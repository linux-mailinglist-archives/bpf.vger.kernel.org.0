Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E716E6E9B
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 23:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjDRVth (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 17:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjDRVtg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 17:49:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC3C49FD;
        Tue, 18 Apr 2023 14:49:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A92163985;
        Tue, 18 Apr 2023 21:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E49FC433D2;
        Tue, 18 Apr 2023 21:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681854568;
        bh=EmrFUT/eYHiutiyWMgwlwsEKO7EDPGWzF/8vU7NjxTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oLV9wxq6fo0KJRnjFHjrkOxZ4wW9+MHVySebMJil1Nu/dFX3RyGQ+P21wRo15mr5g
         hZStLwD4z0HEI9ttY+EEW0Ft2rxRaVYtOC1vlVqerlFUzxkjH1SwuJ25pJHXHAsE0J
         kHN/WqRL56xXTKnxPHCjTZ1T7O06Ktjvc6OtgCjM0a1wH3Sy43AyJnRT8UQKnFNE/5
         eX1G1Ki2n3zxn4th9W6U5QRqbPHwvzQm6uV/dvVptsOjyv3EHMfFdFzXUqBe7JJlHa
         7EuA02nARoPlSgBzfovOPIzo2riC8Fr3PbRwHFHBPm5+2oHkEXoRdX5sO066rEyHaw
         hIeCjsRc6CyIQ==
Date:   Tue, 18 Apr 2023 14:49:25 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Joan Bruguera =?utf-8?B?TWljw7M=?= <joanbrugueram@gmail.com>
Cc:     i.pear@outlook.com, acme@kernel.org, alan.maguire@oracle.com,
        alexandref75@gmail.com, bpf@vger.kernel.org, dxu@dxuuu.xyz,
        jforbes@redhat.com, linux-kernel@vger.kernel.org,
        olsajiri@gmail.com, peterz@infradead.org, ptalbert@redhat.com,
        yhs@fb.com
Subject: [PATCH v2] vmlinux.lds.h: Discard .note.gnu.property section
Message-ID: <20230418214925.ay3jpf2zhw75kgmd@treble>
References: <20230413185922.ufmollqlnlghwyvy@treble>
 <20230416190219.2600911-1-joanbrugueram@gmail.com>
 <20230418214701.4qky77rsxxytyoc2@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230418214701.4qky77rsxxytyoc2@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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
Link: https://lkml.kernel.org/bpf/57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com
Debugged-by: Tianyi Liu <i.pear@outlook.com>
Suggested-by: Joan Bruguera Micó <joanbrugueram@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
v2:
- fixed link
- combined discards
- updated comment

 include/asm-generic/vmlinux.lds.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index d1f57e4868ed..cebdf1ca415d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -891,9 +891,16 @@
 /*
  * Discard .note.GNU-stack, which is emitted as PROGBITS by the compiler.
  * Otherwise, the type of .notes section would become PROGBITS instead of NOTES.
+ *
+ * Also, discard .note.gnu.property, otherwise it forces the notes section to
+ * be 8-byte aligned which causes alignment mismatches with the kernel's custom
+ * 4-byte aligned notes.
  */
 #define NOTES								\
-	/DISCARD/ : { *(.note.GNU-stack) }				\
+	/DISCARD/ : {							\
+		*(.note.GNU-stack)					\
+		*(.note.gnu.property)					\
+	}								\
 	.notes : AT(ADDR(.notes) - LOAD_OFFSET) {			\
 		BOUNDED_SECTION_BY(.note.*, _notes)			\
 	} NOTES_HEADERS							\
-- 
2.39.2

