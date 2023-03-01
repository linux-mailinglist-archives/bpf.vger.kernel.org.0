Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EB16A761A
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 22:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCAVXg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 16:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCAVXN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 16:23:13 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF42E3B8
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 13:23:12 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id DB815240737
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 22:23:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1677705790; bh=iDttboEdgHnSnDtpnwAt0+v3oIvqwAVhxo1Hl51B0kw=;
        h=From:To:Subject:Date:From;
        b=CjSZIgSp9/Hf0pWdL7iWNyU+AWQJgBNoJhRy7S3GGUjpBrIyjei/mb2jeab2MwJOJ
         +48IiapOtWNXkyB/g0v6D4jelGO5edZw/JmGWOS3330Y4cAsux+HG8Q4XUxnxkVTKl
         +FqiTSYrtiLQA15WpfmRn20fP1exReVWRI16bj9AxS4yXIUlSKD/YW8diA2vdXRNJE
         9v7Z1iUoN8Tm5atXi2MO5CsqWhGBqwkUb4+izgOdAynVIUkH/ra72Llv5YDKWTFPaK
         EfLI6GSpNhq+c5FIlALxpPBx29ZgXiyFc7aV5J/Tq0fk6K+0DKFc9tquU2NWQhVsrK
         SdAvATWxiKllQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PRnJt05K6z6trM;
        Wed,  1 Mar 2023 22:23:09 +0100 (CET)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Subject: [PATCH bpf-next v4 0/3] Make uprobe attachment APK aware
Date:   Wed,  1 Mar 2023 21:23:05 +0000
Message-Id: <20230301212308.1839139-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Changelog
---------
v3->v4:
- use ERR_PTR instead of libbpf_err_ptr() in zip_archive_open()
- eliminated err variable from elf_find_func_offset_from_archive()

v2->v3:
- adjusted zip_archive_open() to report errno
- fixed provided libbpf_strlcpy() buffer size argument
- adjusted find_cd() to handle errors better
- use fewer local variables in get_entry_at_offset()

v1->v2:
- removed unaligned_* types
- switched to using __u32 and __u16
- switched to using errno constants instead of hard-coded negative values
- added another pr_debug() message
- shortened central_directory_* to cd_*
- inlined cd_file_header_at_offset() function
- bunch of syntactical changes

Daniel Müller (3):
  libbpf: Implement basic zip archive parsing support
  libbpf: Introduce elf_find_func_offset_from_file() function
  libbpf: Add support for attaching uprobes to shared objects in APKs

 tools/lib/bpf/Build    |   2 +-
 tools/lib/bpf/libbpf.c | 146 ++++++++++++++----
 tools/lib/bpf/zip.c    | 328 +++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/zip.h    |  47 ++++++
 4 files changed, 495 insertions(+), 28 deletions(-)
 create mode 100644 tools/lib/bpf/zip.c
 create mode 100644 tools/lib/bpf/zip.h

-- 
2.39.2

