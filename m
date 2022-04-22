Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E1A50B1AB
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 09:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391008AbiDVHei (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 03:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386165AbiDVHeh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 03:34:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C739B515B4;
        Fri, 22 Apr 2022 00:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BiFwTkcFOMTtKqRq3uhC/TlKTqlAY7nnCuq174HKk0M=; b=AyKZDrqtPLqsXggbYiNB4s0jKC
        YuBihnegzx6MUh0QMeUCIUyxS0f8f2fHUB0dpThVn0kxXgH0ji+gVYvcBDXPVbqWZBj1H0bHQy6HK
        rNHe9jnf9i/eJ6t+KzyR7oxKiLEvuZVv4p7TySSggte7OR1iygeQw2aUvicwuJ+FbLEXH5T9RW31q
        IoRQPXYf6lKNUEFw8989N3pP2QZ3Om5Fj0KPUjQngthaabNwb3SsL9Te6XdrDGTAaKoV+cLlcsXhd
        elh8AV6Q6wtQkZ48zABYj5dlG8a7qkVNvEDyGFpyaK6gdfaEXz6tVXyNi6cht7qnie+3kKrkNBvcB
        7NUjcvXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhnlA-007dGP-HF; Fri, 22 Apr 2022 07:31:20 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3733D9861C1; Fri, 22 Apr 2022 09:31:18 +0200 (CEST)
Date:   Fri, 22 Apr 2022 09:31:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Song Liu <song@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf] bpf: invalidate unused part of bpf_prog_pack
Message-ID: <20220422073118.GR2731@worktop.programming.kicks-ass.net>
References: <20220421072212.608884-1-song@kernel.org>
 <CAHk-=wi3eu8mdKmXOCSPeTxABVbstbDg1q5Fkak+A9kVwF+fVw@mail.gmail.com>
 <CAADnVQKyDwXUMCfmdabbVE0vSGxdpqmWAwHRBqbPLW=LdCnHBQ@mail.gmail.com>
 <CAHk-=whFeBezdSrPy31iYv-UZNnNavymrhqrwCptE4uW8aeaHw@mail.gmail.com>
 <CAPhsuW7M6exGD3C1cPBGjhU0Y5efxtJ3=0BWNnbuH87TgQMzdg@mail.gmail.com>
 <CAHk-=wh1mO5HdrOMTq68WHM51-=jdmQS=KipVYxS+5u3uRc5rg@mail.gmail.com>
 <1A4FF473-0988-48BE-9993-0F5E9F0AAC95@fb.com>
 <CAHk-=wi62LDc5B3DOr5pyVtOUOuLkLzHvmZQApH9q=raqaGkUg@mail.gmail.com>
 <8F788446-899C-4BA3-8236-612A94D98582@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8F788446-899C-4BA3-8236-612A94D98582@fb.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > On Apr 21, 2022, at 3:30 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > I actually think bpf_arch_text_copy() is another horribly badly done thing.
> > 
> > It seems only implemented on x86 (I'm not sure how anything else is
> > supposed to work, I didn't go look), and there it is horribly badly
> > done, using __text_poke() that does all these magical things just to
> > make it atomic wrt concurrent code execution.
> > 
> > None of which is *AT*ALL* relevant for this case, since concurrent
> > code execution simply isn't a thing (and if it were, you would already
> > have lost).
> > 
> > And if that wasn't pointless enough, it does all that magic "map the
> > page writably at a different virtual address using poking_addr in
> > poking_mm" and a different address space entirely.
> > 
> > All of that is required for REAL KERNEL CODE.
> > 
> > But the thing is, for bpf_prog_pack, all of that is just completely
> > pointless and stupid complexity.

I think the point is that this hole will likely share a page with active
code, and as such there should not be a writable mapping mapping to it,
necessitating the whole __text_poke() mess.

That said; it does seem somewhat silly have a whole page worth of int3
around just for this.

Perhaps we can do something like the completely untested below?

---
 arch/x86/kernel/alternative.c | 48 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d374cb3cf024..60afa9105307 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -994,7 +994,20 @@ static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
 __ro_after_init struct mm_struct *poking_mm;
 __ro_after_init unsigned long poking_addr;
 
-static void *__text_poke(void *addr, const void *opcode, size_t len)
+static void text_poke_memcpy(void *dst, const void *src, size_t len)
+{
+	memcpy(dst, src, len);
+}
+
+static void text_poke_memset(void *dst, const void *src, size_t len)
+{
+	int c = *(int *)src;
+	memset(dst, c, len);
+}
+
+typedef void text_poke_f(void *dst, const void *src, size_t len);
+
+static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t len)
 {
 	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
 	struct page *pages[2] = {NULL};
@@ -1059,7 +1072,7 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
 	prev = use_temporary_mm(poking_mm);
 
 	kasan_disable_current();
-	memcpy((u8 *)poking_addr + offset_in_page(addr), opcode, len);
+	func((void *)poking_addr + offset_in_page(addr), src, len);
 	kasan_enable_current();
 
 	/*
@@ -1091,7 +1104,8 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
 	 * If the text does not match what we just wrote then something is
 	 * fundamentally screwy; there's nothing we can really do about that.
 	 */
-	BUG_ON(memcmp(addr, opcode, len));
+	if (func == text_poke_memcpy)
+		BUG_ON(memcmp(addr, src, len));
 
 	local_irq_restore(flags);
 	pte_unmap_unlock(ptep, ptl);
@@ -1118,7 +1132,7 @@ void *text_poke(void *addr, const void *opcode, size_t len)
 {
 	lockdep_assert_held(&text_mutex);
 
-	return __text_poke(addr, opcode, len);
+	return __text_poke(text_poke_memcpy, addr, opcode, len);
 }
 
 /**
@@ -1137,7 +1151,7 @@ void *text_poke(void *addr, const void *opcode, size_t len)
  */
 void *text_poke_kgdb(void *addr, const void *opcode, size_t len)
 {
-	return __text_poke(addr, opcode, len);
+	return __text_poke(text_poke_memcpy, addr, opcode, len);
 }
 
 /**
@@ -1167,7 +1181,29 @@ void *text_poke_copy(void *addr, const void *opcode, size_t len)
 
 		s = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(ptr), len - patched);
 
-		__text_poke((void *)ptr, opcode + patched, s);
+		__text_poke(text_poke_memcpy, (void *)ptr, opcode + patched, s);
+		patched += s;
+	}
+	mutex_unlock(&text_mutex);
+	return addr;
+}
+
+void *text_poke_set(void *addr, int c, size_t len)
+{
+	unsigned long start = (unsigned long)addr;
+	size_t patched = 0;
+
+	if (WARN_ON_ONCE(core_kernel_text(start)))
+		return NULL;
+
+	mutex_lock(&text_mutex);
+	while (patched < len) {
+		unsigned long ptr = start + patched;
+		size_t s;
+
+		s = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(ptr), len - patched);
+
+		__text_poke(text_poke_memset, (void *)ptr, (void *)&c, s);
 		patched += s;
 	}
 	mutex_unlock(&text_mutex);
