Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D8969EB89
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 00:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjBUX40 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 18:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBUX4Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 18:56:25 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A931125E10
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 15:56:15 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 32804240769
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 00:56:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1677023774; bh=m6Whec5ZykD7UtwGCOayuz5CqyboHAZzYp2p8t8UhRs=;
        h=Date:From:To:Subject:From;
        b=gA4dn/vyPbzq6G0SyNBnTkfR4WPr0MVROsZ+gyLD9CJQuMOUPzzU/h4vrlp0H3aI3
         3stUmirJuGZikHt3Fht+lghXmdtiPteOxxfJRT/R9a+baKuk2j2sffbMmQuX1vFvNs
         ZeRkiI96ZnGhKvhPOw87B/itMH9Y4sejyEBSmk8qjMCjZrEnkdt1rQrPaTFiYLAlDb
         ukFEhzS0nkut3xnd3wPBlvNgCr4fZCINJuPSGL5r2N1dLKCgKR8Z+fEslIm2H0mS9t
         5u8UJa3nIYPF2LvBsrW63javAAKjZ+a4k+8fHxaBUVBCR+QcdY0Lfwqm851vVSqLyI
         1+7qytLPvlqZQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PLx5773Dgz9rxB;
        Wed, 22 Feb 2023 00:56:11 +0100 (CET)
Date:   Tue, 21 Feb 2023 23:56:08 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 0/3] Make uprobe attachment APK aware
Message-ID: <20230221235608.cdpofdoog4hoqznn@muellerd-fedora-PC2BDTX9>
References: <20230221234500.2653976-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230221234500.2653976-1-deso@posteo.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The changelog ended up in a different file. Added it below now.

On Tue, Feb 21, 2023 at 11:44:57PM +0000, Daniel Müller wrote:
> On Android, APKs (android packages; zip packages with somewhat
> prescriptive contents) are first class citizens in the system: the
> shared objects contained in them don't exist in unpacked form on the
> file system. Rather, they are mmaped directly from within the archive
> and the archive is also what the kernel is aware of.
> 
> For users that complicates the process of attaching a uprobe to a
> function contained in a shared object in one such APK: they'd have to
> find the byte offset of said function from the beginning of the archive.
> That is cumbersome to do manually and can be fragile, because various
> changes could invalidate said offset.
> 
> That is why for uprobes inside ELF files (not inside an APK), commit
> d112c9ce249b ("libbpf: Support function name-based attach uprobes") added
> support for attaching to symbols by name. On Android, that mechanism
> currently does not work, because this logic is not APK aware.
> 
> This patch set introduces first class support for attaching uprobes to
> functions inside ELF objects contained in APKs via function names. We
> add support for recognizing the following syntax for a binary path:
>   <archive>!/<binary-in-archive>
> 
>   (e.g., /system/app/test-app.apk!/lib/arm64-v8a/libc++.so)
> 
> This syntax is common in the Android eco system and used by tools such
> as simpleperf. It is also what is being proposed for bcc [0].
> 
> If the user provides such a binary path, we find <binary-in-archive>
> (lib/arm64-v8a/libc++.so in the example) inside of <archive>
> (/system/app/test-app.apk). We perform the regular ELF offset search
> inside the binary and add that to the offset within the archive itself,
> to retrieve the offset at which to attach the uprobe.
> 
> [0] https://github.com/iovisor/bcc/pull/4440

Changelog
---------
v1->v2:
- removed unaligned_* types
- switched to using __u32 and __u16
- switched to using errno constants instead of hard-coded negative values
- added another pr_debug() message
- shortened central_directory_* to cd_*
- inlined cd_file_header_at_offset() function
- bunch of syntactical changes

> Daniel Müller (3):
>   libbpf: Implement basic zip archive parsing support
>   libbpf: Introduce elf_find_func_offset_from_file() function
>   libbpf: Add support for attaching uprobes to shared objects in APKs
> 
>  tools/lib/bpf/Build    |   2 +-
>  tools/lib/bpf/libbpf.c | 142 ++++++++++++++----
>  tools/lib/bpf/zip.c    | 326 +++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/zip.h    |  47 ++++++
>  4 files changed, 489 insertions(+), 28 deletions(-)
>  create mode 100644 tools/lib/bpf/zip.c
>  create mode 100644 tools/lib/bpf/zip.h
> 
> -- 
> 2.30.2
> 
