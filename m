Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FE469EB62
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 00:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjBUXpG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 18:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjBUXpG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 18:45:06 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB722CFC7
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 15:45:05 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 8B47B2404C7
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 00:45:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1677023103; bh=WAiWmXELlFQ61ZAZkDS3zE2sJ7PS1Mu9+89RH28Z4Po=;
        h=From:To:Subject:Date:From;
        b=gC45D+c8c24Cgsm9SVLYw30fH+m5AOQTGDTJym4owefUaO25oOV0f6pqwYJ0Ce5D0
         VZo8JPwozRsTiWYqch/0luuwKPa93rCf1Qy5EVezn3GvspPVKZjln0Dx6pcemeZn9U
         nDAP9quIhtCPJbvPylMGaN4WsJ/Mo5Nmc8VzEaMznraxkoc/SAud9UvAVO3qGuo7b0
         HSmXx7cc7ysNhWcA6i8WxLmxjWLQO/RVbBEYWHwJVfSD2cDXb8ecuS040wQVFjP8c8
         VMn+Bt/H9aI/2L4zRNgyk1ShcoRDs3fM5UwO6HBl2/dKXtyfJj1oF5uiuHzcDxHhIJ
         bGPIWuPAjW3fw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PLwrG5hMfz6tmK;
        Wed, 22 Feb 2023 00:45:02 +0100 (CET)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/3] Make uprobe attachment APK aware
Date:   Tue, 21 Feb 2023 23:44:57 +0000
Message-Id: <20230221234500.2653976-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Android, APKs (android packages; zip packages with somewhat
prescriptive contents) are first class citizens in the system: the
shared objects contained in them don't exist in unpacked form on the
file system. Rather, they are mmaped directly from within the archive
and the archive is also what the kernel is aware of.

For users that complicates the process of attaching a uprobe to a
function contained in a shared object in one such APK: they'd have to
find the byte offset of said function from the beginning of the archive.
That is cumbersome to do manually and can be fragile, because various
changes could invalidate said offset.

That is why for uprobes inside ELF files (not inside an APK), commit
d112c9ce249b ("libbpf: Support function name-based attach uprobes") added
support for attaching to symbols by name. On Android, that mechanism
currently does not work, because this logic is not APK aware.

This patch set introduces first class support for attaching uprobes to
functions inside ELF objects contained in APKs via function names. We
add support for recognizing the following syntax for a binary path:
  <archive>!/<binary-in-archive>

  (e.g., /system/app/test-app.apk!/lib/arm64-v8a/libc++.so)

This syntax is common in the Android eco system and used by tools such
as simpleperf. It is also what is being proposed for bcc [0].

If the user provides such a binary path, we find <binary-in-archive>
(lib/arm64-v8a/libc++.so in the example) inside of <archive>
(/system/app/test-app.apk). We perform the regular ELF offset search
inside the binary and add that to the offset within the archive itself,
to retrieve the offset at which to attach the uprobe.

[0] https://github.com/iovisor/bcc/pull/4440

Daniel Müller (3):
  libbpf: Implement basic zip archive parsing support
  libbpf: Introduce elf_find_func_offset_from_file() function
  libbpf: Add support for attaching uprobes to shared objects in APKs

 tools/lib/bpf/Build    |   2 +-
 tools/lib/bpf/libbpf.c | 142 ++++++++++++++----
 tools/lib/bpf/zip.c    | 326 +++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/zip.h    |  47 ++++++
 4 files changed, 489 insertions(+), 28 deletions(-)
 create mode 100644 tools/lib/bpf/zip.c
 create mode 100644 tools/lib/bpf/zip.h

-- 
2.30.2

