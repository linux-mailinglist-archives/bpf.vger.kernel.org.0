Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250F36E14BA
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 20:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDMS72 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 14:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDMS71 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 14:59:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB3F3C39;
        Thu, 13 Apr 2023 11:59:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBEF8640DE;
        Thu, 13 Apr 2023 18:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C08C433D2;
        Thu, 13 Apr 2023 18:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681412365;
        bh=29782vFwFT9re9koO2kNccEZccDNBvEZVvzoDaoERp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZ/D1WglLjVEvl3tf77pFFqMOZzlQbd30vXlNueZZhcO4pt8Xk4qejCdwqnye2/XQ
         SGrfo1lHut8LTi82sr6f0ltbQnqLSK45dyWflzXPOk+H7swwpTVzB2vWoUzcbAzn+j
         Vff2A+YZf1iVk5RIoZoCL0QyQt6jCqUfbdBadDKlJ1Ww2ftIWTq8VlB0eba7TjQ6pP
         m3yJ2QoDucW7NS6vPSWcp1hmGHQE/FNI5tZj8wYskypMoFbGjDuMrjVw+Vetqsx7/m
         d12Mq9RhSehNtCRcmI7WFj3oOF/C41DbUfmoLiIW9SrJ5kMqpbLBuZBTGcci0GAATB
         j0B0Zsstxpuug==
Date:   Thu, 13 Apr 2023 11:59:22 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Tianyi Liu <i.pear@outlook.com>
Cc:     joanbrugueram@gmail.com, acme@kernel.org, alan.maguire@oracle.com,
        alexandref75@gmail.com, bpf@vger.kernel.org, dxu@dxuuu.xyz,
        jforbes@redhat.com, linux-kernel@vger.kernel.org,
        olsajiri@gmail.com, peterz@infradead.org, ptalbert@redhat.com,
        yhs@fb.com
Subject: [PATCH] vmlinux.lds.h: Discard .note.gnu.property section
Message-ID: <20230413185922.ufmollqlnlghwyvy@treble>
References: <20230413022149.94781-1-joanbrugueram@gmail.com>
 <SY4P282MB10847E614FE5952EB4D46F049D989@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SY4P282MB10847E614FE5952EB4D46F049D989@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 13, 2023 at 05:23:08PM +0800, Tianyi Liu wrote:
> > Test 1: Update dwarves (=pahole package on Arch Linux) from the current version
> >         (1:1.24+r29+g02d67c5-1) to the staging version (1:1.25-1).
> > Result: The build works correctly.
> > 
> >         However, the notes section is still not parsed correctly, as confirmed
> >         by `readelf -n` or adding a printf near the code on `cus__merging_cu`
> >         (on `dwarf_loader.c`) pointed to by Tianyi.
> > 
> >         A bisect shows the commit that fixes the build is
> >         a9498899109d3be14f17abbc322a8f55a1067bee
> >         "dwarf_loader: Fix for BTF id drift caused by adding unspecified types"
> >         I don't know why though.
> 
> Pahole reads .notes to look for LINUX_ELFNOTE_BUILD_LTO. When LTO is
> enabled, pahole needs to call cus__merge_and_process_cu to merge compile
> units, at which point there should only be one unspecified type (used to
> represent some compilation information) in the global context.
> 
> However, when the kernel is compiled without LTO, if pahole calls
> cus__merge_and_process_cu due to alignment issues with notes, multiple
> unspecified types may appear after merging the cus, and older versions of
> pahole only support up to one. This is why pahole 1.24 crashes, while
> newer versions support multiple. However, the latest version of pahole
> still does not solve the problem of incorrect LTO recognition, so
> compiling the kernel may be slower than normal.

Thanks for the explanation.  So pahole is still mis-reading the LTO
note, it just doesn't crash now.

> If the only objective is to fix the bug of incorrect LTO recognition,
> perhaps this naive patch[1] could be sufficient.
> 
> [1]: https://lore.kernel.org/bpf/SY4P282MB1084A0E31D4228DF89FC42639DA29@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM/

I think we still need to fix the underlying issue (corrupt .notes
section).

> > Test 2: Applying Josh's patch to force-align the ELF notes section to 4 bytes
> >         (clarification: using the base pahole version again here)
> > Result: The build works correctly.
> >         I can read the notes correctly using `readelf -n` as well,
> >         and they are aligned to 4 bytes instead of 8.
> 
> I'm still currently unable to reproduce this fix, but it may just be an
> issue with my environment.
> 
> > Test 3: Similar to Josh's patch, but instead of force-aligning the sections,
> >         I added `.note.gnu.property` to the `/DISCARD/` list in the line above.
> > Result: The build works correctly.
> >         I can read the notes correctly using `readelf -n` as well
> >         (of course, the GNU notes which made the alignment be 8 bytes are gone;
> >          I don't know if this has any negative effect).
> 
> I think discarding .note.gnu.property will not have side effects. For some
> reason, this note does not exist in my final vmlinux. I also did not find
> any usage of this property in the later steps of compiling the kernel.

It looks like CONFIG_DEBUG_INFO_BTF is already (inadvertently) stripping
it from vmlinux due to how GNU properties are merged by the linker (see
"How GNU properties are merged" in the ld man page).

The btf data is extracted from vmlinux.o with "objcopy
--only-section=.BTF" into .btf.vmlinux.bin.o.  That file doesn't have
.note.gnu.property, so when it gets modified and linked back into the
main object, the linker strips it.

GNU properties are important for user space but they don't seem to have
a purpose for vmlinux.  So yeah, let's just discard .note.gnu.property.

---8<---

From: Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH] vmlinux.lds.h: Discard .note.gnu.property section

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

This latter error was caused by pahole crashing when it encountered the
corrupt .notes section.  This crash has been fixed in dwarves version
1.25.  As Tianyi Liu describes:

  "Pahole reads .notes to look for LINUX_ELFNOTE_BUILD_LTO. When LTO is
   enabled, pahole needs to call cus__merge_and_process_cu to merge
   compile units, at which point there should only be one unspecified
   type (used to represent some compilation information) in the global
   context.

   However, when the kernel is compiled without LTO, if pahole calls
   cus__merge_and_process_cu due to alignment issues with notes,
   multiple unspecified types may appear after merging the cus, and
   older versions of pahole only support up to one. This is why pahole
   1.24 crashes, while newer versions support multiple. However, the
   latest version of pahole still does not solve the problem of
   incorrect LTO recognition, so compiling the kernel may be slower
   than normal."

Even with the newer pahole, the note section misaligment issue still
exists and pahole is misinterpreting the LTO note.  Fix it by discarding
the .note.gnu.property section.  While GNU properties are important for
user space (and VDSO), they don't seem to have any use for vmlinux.

(In fact, they're already getting (inadvertently) stripped from vmlinux
when CONFIG_DEBUG_INFO_BTF is enabled.  The BTF data is extracted from
vmlinux.o with "objcopy --only-section=.BTF" into .btf.vmlinux.bin.o.
That file doesn't have .note.gnu.property, so when it gets modified and
linked back into the main object, the linker automatically strips it
(see "How GNU properties are merged" in the ld man page).)

Reported-by: Daniel Xu <dxu@dxuuu.xyz>
Link: https://lkml.kernel.org/lkml/57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com
Debugged-by: Tianyi Liu <i.pear@outlook.com>
Suggested-by: Joan Bruguera Micó <joanbrugueram@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index d1f57e4868ed..1770b7d87a80 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -894,6 +894,7 @@
  */
 #define NOTES								\
 	/DISCARD/ : { *(.note.GNU-stack) }				\
+	/DISCARD/ : { *(.note.gnu.property) }				\
 	.notes : AT(ADDR(.notes) - LOAD_OFFSET) {			\
 		BOUNDED_SECTION_BY(.note.*, _notes)			\
 	} NOTES_HEADERS							\
-- 
2.39.2

