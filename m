Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64206DE1CF
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 19:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjDKRB7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 13:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjDKRBc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 13:01:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2217D6A4E;
        Tue, 11 Apr 2023 10:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D54BE6299C;
        Tue, 11 Apr 2023 17:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CE1C433EF;
        Tue, 11 Apr 2023 17:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681232460;
        bh=Xq8P+RD4YgDPuo3ptNv5j3i63DAD9z61+4UfucIts88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1uvHVnBIa+ewJJn3ce/1LScENzWOjjNFJ7xOuNkKnD5tBjmLqBQYHbZ/lfrtjOnB
         Bhli5Wg5iHhLt4nqjEboJ0mW5I7PjDqkdLPw2SlbRgphQPTPNOLenpbgKXpM9c2wZQ
         fq+RA2cp+rjlqmmcZdpI2EaoeLRvgJBkiKo3Xqp9Ej2Dv412aMQhJEfDzl9jFwA4B2
         vD/g6k/cK1YQ0dYgf2M1mqPmt3ZmFZ1xHQpsrCe3VsWFYDSwVU4ISr8f4AdE/TLRM5
         b/jI99QSnJezUKx+qDqV3yyC3hUo2E2IwKiXHKIXafnsCC2kif3Fpzftsz/mRbOqCR
         2CojejthgVHPA==
Date:   Tue, 11 Apr 2023 10:00:58 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Tianyi Liu <i.pear@outlook.com>
Cc:     alexandref75@gmail.com, olsajiri@gmail.com, acme@kernel.org,
        alan.maguire@oracle.com, bpf@vger.kernel.org, dxu@dxuuu.xyz,
        yhs@fb.com, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, ptalbert@redhat.com,
        jforbes@redhat.com
Subject: [PATCH] vmlinux.lds.h: Force-align ELF notes section to four bytes
Message-ID: <20230411170058.7677oximl7oq4hkv@treble>
References: <CAMHq1ZuhecqT-YX8+yzUyhx8tmnQ7CDyuXV4GOuG=z44XTFsaw@mail.gmail.com>
 <SY4P282MB1084A0E31D4228DF89FC42639DA29@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SY4P282MB1084A0E31D4228DF89FC42639DA29@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 14, 2023 at 02:33:02PM +0800, Tianyi Liu wrote:
> > LLVM_OBJCOPY=objcopy pahole -J --btf_gen_floats -j
> > --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
> > .tmp_vmlinux.btf
> > btf_encoder__encode: btf__dedup failed!
> > Failed to encode BTF
> >
> > Thanks,
> >
> 
> I encountered the same problem when building a new kernel and I found some
> reasons for the error.
> 
> In short, enabling CONFIG_X86_KERNEL_IBT will change the order of records in
> .notes section. In addition, due to historical problems, the alignment of
> records in the .notes section is not unified, which leads to the inability of
> gelf_getnote() to read the records after the wrong one.

Alexandre, Tianyi, are you still seeing this issue with the latest
dwarves?  If so can you confirm the below patch fixes it?

Apparently the latest dwarves release fixes it on Fedora Rawhide [1],
does anybody know if there a specific dwarves and/or libbpf change for
this?

[1] https://gitlab.com/cki-project/kernel-ark/-/merge_requests/2346#note_1348057786

---8<---

From: Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH] vmlinux.lds.h: Force-align ELF notes section to four bytes

When tooling reads ELF notes, it assumes each note entry is aligned to
the value listed in the .note section header's sh_addralign field.

The kernel-created ELF notes in the .note.Linux and .note.Xen sections
are aligned to 4 bytes.  This causes the toolchain to set those
sections' sh_addralign values to 4.

On the other hand, the GCC-created .note.gnu.property section has an
sh_addralign value of 8 for some reason, despite being based on struct
Elf32_Nhdr which only needs 4-byte alignment.

When the mismatched input sections get linked together into the vmlinux
.notes output section, the higher alignment "wins", resulting in an
sh_addralign of 8, which confuses tooling.  For example:

  $ readelf -n .tmp_vmlinux.btf
  ...
  readelf: .tmp_vmlinux.btf: Warning: note with invalid namesz and/or descsz found at offset 0x170
  readelf: .tmp_vmlinux.btf: Warning:  type: 0x4, namesize: 0x006e6558, descsize: 0x00008801, alignment: 8

In this case readelf thinks there's alignment padding where there is
none, so it starts reading an ELF note in the middle.

With newer toolchains (e.g., latest Fedora Rawhide), a similar mismatch
triggers a build failure when combined with CONFIG_X86_KERNEL_IBT:

  btf_encoder__encode: btf__dedup failed!
  Failed to encode BTF
  libbpf: failed to find '.BTF' ELF section in vmlinux
  FAILED: load BTF from vmlinux: No data available
  make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255

Fix it by forcing the .notes section input and output alignments to 4 to
match the kernel's note entry alignments.

Note this doesn't break the 8-byte-aligned .note.gnu.property entries
because their internal data representations fill the entire 8-byte
alignment boundary, so there's no padding between entries to be
misinterpreted.  And there's only a single entry in that section anyway.

Reported-by: Daniel Xu <dxu@dxuuu.xyz>
Debugged-by: Tianyi Liu <i.pear@outlook.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index d1f57e4868ed..1c7c87c9ae71 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -894,7 +894,7 @@
  */
 #define NOTES								\
 	/DISCARD/ : { *(.note.GNU-stack) }				\
-	.notes : AT(ADDR(.notes) - LOAD_OFFSET) {			\
+	.notes ALIGN(4) : AT(ADDR(.notes) - LOAD_OFFSET) SUBALIGN(4) {	\
 		BOUNDED_SECTION_BY(.note.*, _notes)			\
 	} NOTES_HEADERS							\
 	NOTES_HEADERS_RESTORE
-- 
2.39.2

