Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63DA6135358
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2020 07:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgAIGsw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jan 2020 01:48:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbgAIGsw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jan 2020 01:48:52 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B226920880
        for <bpf@vger.kernel.org>; Thu,  9 Jan 2020 06:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578552531;
        bh=4G6sGg1ys6863QTyMXDlbv/klXCy1xEPVyUXXUkjE7Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kOY80DL1qlxLw6g2tmV9oG1JqdRsKYAo/o1nAbGbD94j9TWbNFQDDdwqyDI214ewP
         IHMQjbM76iAe37nVcOdi/1liZ6skFvpErivfjwd+clE63tHQGnnWEDSMm7p7wanWCS
         2RwzfXIDVQPdoqDjCSkgwsy4/iysZ6t4EGuxXAGw=
Received: by mail-wm1-f54.google.com with SMTP id p17so1527106wma.1
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2020 22:48:50 -0800 (PST)
X-Gm-Message-State: APjAAAWw2b9zKQm44yNfYiiyKrL1yJk+SlFbcWTtKKEwjSv/mOqMAi4G
        LSaK4UWkGP4/gyRmrXHiCatJc6TLX79PtqwofvSSaA==
X-Google-Smtp-Source: APXvYqyu2uEHRdxJf6p3zKNVC4Uj54r9l5PCzKrRkteNu0epyaxUny9t2ULKRiWQTcAQ0YFdhP+dJU5xyln2IRrrO04=
X-Received: by 2002:a1c:7d8b:: with SMTP id y133mr2657460wmc.165.1578552528899;
 Wed, 08 Jan 2020 22:48:48 -0800 (PST)
MIME-Version: 1.0
References: <21bf6bb46544eab79e792980f82520f8fbdae9b5.camel@intel.com>
 <DB882EE8-20B2-4631-A808-E5C968B24CEB@amacapital.net> <cdd157ef011efda92c9434f76141fc3aef174d85.camel@intel.com>
 <CALCETrV_tGk=B3Hw0h9viW45wMqB_W+rwWzx6LnC3-vSATOUOA@mail.gmail.com> <400be86aab208d0e50a237cdbd3195763396e3ed.camel@intel.com>
In-Reply-To: <400be86aab208d0e50a237cdbd3195763396e3ed.camel@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 8 Jan 2020 22:48:36 -0800
X-Gmail-Original-Message-ID: <CALCETrXXJhkNXmjTX_8VEO39+uE4XECtm=QNTDh1DpncXKhKhw@mail.gmail.com>
Message-ID: <CALCETrXXJhkNXmjTX_8VEO39+uE4XECtm=QNTDh1DpncXKhKhw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Make trampolines W^X
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "ast@kernel.org" <ast@kernel.org>,
        "mjg59@google.com" <mjg59@google.com>,
        "thgarnie@chromium.org" <thgarnie@chromium.org>,
        "kpsingh@chromium.org" <kpsingh@chromium.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "revest@chromium.org" <revest@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "namit@vmware.com" <namit@vmware.com>,
        "jackmanb@chromium.org" <jackmanb@chromium.org>,
        "kafai@fb.com" <kafai@fb.com>, "yhs@fb.com" <yhs@fb.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "mhalcrow@google.com" <mhalcrow@google.com>,
        "andriin@fb.com" <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Jan 8, 2020, at 10:52 AM, Edgecombe, Rick P <rick.p.edgecombe@intel.co=
m> wrote:
>
> =EF=BB=BFOn Wed, 2020-01-08 at 00:41 -0800, Andy Lutomirski wrote:
>>> On Jan 7, 2020, at 9:01 AM, Edgecombe, Rick P <rick.p.edgecombe@intel.c=
om>
>>> wrote:
>>>
>>> =EF=BB=BFCC Nadav and Jessica.
>>>
>>> On Mon, 2020-01-06 at 15:36 -1000, Andy Lutomirski wrote:
>>>>> On Jan 6, 2020, at 12:25 PM, Edgecombe, Rick P <
>>>>> rick.p.edgecombe@intel.com>
>>>>> wrote:
>>>>>
>>>>> =EF=BB=BFOn Sat, 2020-01-04 at 09:49 +0900, Andy Lutomirski wrote:
>>>>>>>>> On Jan 4, 2020, at 8:47 AM, KP Singh <kpsingh@chromium.org>
>>>>>>>>> wrote:
>>>>>>>>
>>>>>>>> =EF=BB=BFFrom: KP Singh <kpsingh@google.com>
>>>>>>>>
>>>>>>>> The image for the BPF trampolines is allocated with
>>>>>>>> bpf_jit_alloc_exe_page which marks this allocated page executable.
>>>>>>>> This
>>>>>>>> means that the allocated memory is W and X at the same time making
>>>>>>>> it
>>>>>>>> susceptible to WX based attacks.
>>>>>>>>
>>>>>>>> Since the allocated memory is shared between two trampolines (the
>>>>>>>> current and the next), 2 pages must be allocated to adhere to W^X
>>>>>>>> and
>>>>>>>> the following sequence is obeyed where trampolines are modified:
>>>>>>>
>>>>>>> Can we please do better rather than piling garbage on top of
>>>>>>> garbage?
>>>>>>>
>>>>>>>>
>>>>>>>> - Mark memory as non executable (set_memory_nx). While
>>>>>>>> module_alloc for
>>>>>>>> x86 allocates the memory as PAGE_KERNEL and not PAGE_KERNEL_EXEC,
>>>>>>>> not
>>>>>>>> all implementations of module_alloc do so
>>>>>>>
>>>>>>> How about fixing this instead?
>>>>>>>
>>>>>>>> - Mark the memory as read/write (set_memory_rw)
>>>>>>>
>>>>>>> Probably harmless, but see above about fixing it.
>>>>>>>
>>>>>>>> - Modify the trampoline
>>>>>>>
>>>>>>> Seems reasonable. It=E2=80=99s worth noting that this whole approac=
h is
>>>>>>> suboptimal:
>>>>>>> the =E2=80=9Cmodule=E2=80=9D allocator should really be returning a=
 list of pages to
>>>>>>> be
>>>>>>> written (not at the final address!) with the actual executable
>>>>>>> mapping to
>>>>>>> be
>>>>>>> materialized later, but that=E2=80=99s a bigger project that you=E2=
=80=99re welcome
>>>>>>> to
>>>>>>> ignore
>>>>>>> for now.  (Concretely, it should produce a vmap address with backin=
g
>>>>>>> pages
>>>>>>> but
>>>>>>> with the vmap alias either entirely unmapped or read-only. A
>>>>>>> subsequent
>>>>>>> healer
>>>>>>> would, all at once, make the direct map pages RO or not-present and
>>>>>>> make
>>>>>>> the
>>>>>>> vmap alias RX.)
>>>>>>>> - Mark the memory as read-only (set_memory_ro)
>>>>>>>> - Mark the memory as executable (set_memory_x)
>>>>>>>
>>>>>>> No, thanks. There=E2=80=99s very little excuse for doing two IPI fl=
ushes
>>>>>>> when one
>>>>>>> would suffice.
>>>>>>>
>>>>>>> As far as I know, all architectures can do this with a single flush
>>>>>>> without
>>>>>>> races  x86 certainly can. The module freeing code gets this sequenc=
e
>>>>>>> right.
>>>>>>> Please reuse its mechanism or, if needed, export the relevant
>>>>>>> interfaces.
>>>>>
>>>>> So if I understand this right, some trampolines have been added that =
are
>>>>> currently set as RWX at modification time AND left that way during
>>>>> runtime?
>>>>> The
>>>>> discussion on the order of set_memory_() calls in the commit message
>>>>> made me
>>>>> think that this was just a modification time thing at first.
>>>>
>>>> I=E2=80=99m not sure what the status quo is.
>>>>
>>>> We really ought to have a genuinely good API for allocation and
>>>> initialization
>>>> of text.  We can do so much better than set_memory_blahblah.
>>>>
>>>> FWIW, I have some ideas about making kernel flushes cheaper. It=E2=80=
=99s
>>>> currently
>>>> blocked on finding some time and on tglx=E2=80=99s irqtrace work.
>>>>
>>>
>>> Makes sense to me. I guess there are 6 types of text allocations now:
>>> - These two BPF trampolines
>>> - BPF JITs
>>> - Modules
>>> - Kprobes
>>> - Ftrace
>>>
>>> All doing (or should be doing) pretty much the same thing. I believe Je=
ssica
>>> had
>>> said at one point that she didn't like all the other features using
>>> module_alloc() as it was supposed to be just for real modules. Where wo=
uld
>>> the
>>> API live?
>>
>> New header?  This shouldn=E2=80=99t matter that much.
>>
>> Here are two strawman proposals.  All of this is very rough -- the
>> actual data structures and signatures are likely problematic for
>> multiple reasons.
>>
>> --- First proposal ---
>>
>> struct text_allocation {
>>  void *final_addr;
>>  struct page *pages;
>>  int npages;
>> };
>>
>> int text_alloc(struct text_allocation *out, size_t size);
>>
>> /* now final_addr is not accessible and pages is writable. */
>>
>> int text_freeze(struct text_allocation *alloc);
>>
>> /* now pages are not accessible and final_addr is RO.  Alternatively,
>> pages are RO and final_addr is unmapped. */
>>
>> int text_finish(struct text_allocation *alloc);
>>
>> /* now final_addr is RX.  All done. */
>>
>> This gets it with just one flush and gives a chance to double-check in
>> case of race attacks from other CPUs.  Double-checking is annoying,
>> though.
>>
>> --- Second proposal ---
>>
>> struct text_allocation {
>>  void *final_addr;
>>  /* lots of opaque stuff including an mm_struct */
>>  /* optional: list of struct page, but this isn't obviously useful */
>> };
>>
>> int text_alloc(struct text_allocation *out, size_t size);
>>
>> /* Memory is allocated.  There is no way to access it at all right
>> now.  The memory is RO or not present in the direct map. */
>>
>> void __user *text_activate_mapping(struct text_allocation *out);
>>
>> /* Now the text is RW at *user* address given by return value.
>> Preemption is off if required by use_temporary_mm().  Real user memory
>> cannot be accessed. */
>>
>> void text_deactivate_mapping(struct text_allocation *alloc);
>>
>> /* Now the memory is inaccessible again. */
>>
>> void text_finalize(struct text_allocation *alloc);
>>
>> /* Now it's RX or XO at the final address. */
>>
>>
>> Pros of second approach:
>>
>> - Inherently immune to cross-CPU attack.  No double-check.
>>
>> - If we ever implement a cache of non-direct-mapped, unaliased pages,
>> then it works with no flushes at all.  We could even relax it a bit to
>> allow non-direct-mapped pages that may have RX / XO aliases but no W
>> aliases.
>>
>> - Can easily access without worrying about page boundaries.
>>
>> Cons:
>>
>> - The use of a temporary mm is annoying -- you can't copy from user
>> memory, for example.
>
> Probably the first proposal is better for usages where there is a signatu=
re that
> can be checked like modules, because you could more easily check the sign=
ature
> after the text is RO. I guess leaving the direct map as RO could work for=
 the
> second option too. Both would probably require significant changes to mod=
ule
> signature verification though.

This sounds complicated =E2=80=94 for decent performance, we want to apply
alternatives before we make the text RO, at which point verifying the
signature is awkward at best.

>
> Just a minor point/clarification, but outside of an enhanced signed modul=
e case,
> I think the cross-CPU attack mitigation can't be full. For example, attac=
king
> the verified BPF byte code (which is apparently planned to no longer be R=
O), or
> the pointers being loaded into these trampolines. There is always going t=
o be
> some writable source or pointer to the source, and unless there is a way =
to
> verify the end RO result, it's an un-winnable game of whack-a-mole to do =
it in
> full. Still the less exposed surfaces the better since the writes we are
> worrying about in this case are probably not fully arbitrary.

We could use hypervisor- or CR3-based protection. But I agree this is
tricky and not strictly on topic :)

>
> I don't see why it would be so bad to require copying data to the kernel =
before
> sending it through this process. Nothing copies to final allocation direc=
tly
> from userspace today, and from a perf perspective, how bad is an extra co=
py when
> we are saving TLB shootdowns? Are you thinking to protect the data that's=
 being
> loaded from other CPUs?

Hmm. If there=E2=80=99s a way to make loading stall, then the cross-cpu att=
ack
is a nice way to write shell code, so mitigating this has at least
some value.

>
> Otherwise, could we lazily clone/sync the original mm into the temporary =
one to
> allow this? (possibly totally misguided idea)

That involves allocating a virtual address at a safe position to make
this work. On architectures like s390, I don=E2=80=99t even know if this is
possible. Even on x86, it=E2=80=99s awkward.  I think it=E2=80=99s easier t=
o just say
that, while the temporary mapping is active, user memory is
inaccessible.

>
> FWIW, I really like the idea of a cache of unmapped or RO pages. Potentia=
lly
> several optimizations we could do there.
>

I guess we would track these pages by the maximum permissions than any
current or unmapped but unflushed alias has.  This lets us get totally
unmapped or RO pages out of the cache.  Or even RX =E2=80=94 we could
potentially allocate, free, and reallocate text without flushing.

> If this API should be cross platform, we might want to abstract the copy =
itself
> as well, since other arch's might have non __user solutions for copying d=
ata in.

Agreed, although maybe all arches would use =E2=80=9Cuser=E2=80=9D mappings=
.

>
> Unless someone else wants to, I can probably take a look at a first cut o=
f this
> after I get the current thing I'm working on out. Probably better to let =
the
> dust settle on the ftrace changes as well.

That would be great!

Do you know why the change_page_attr code currently does
vm_unmap_aliases?  This is yet more extra expense. I assume the idea
is that, if we=E2=80=99re changing cache attributes on a non-self-snoop
machine, we need to kill stale aliases, and we should also kill them
if we=E2=80=99re reducing permissions.  But we currently do it excessively.

We should also consider improving vm_unmap_aliases().  As a practical
matter, vm_unmap_aliases() often does a global flush, but it can't be
relied on.  On the other hand, a global flush initiated for other
reasons won't tell the vmap code that aliases have been zapped.

If the locking is okay, we could maybe get away with zapping aliases
from the normal flush code.  Alternatively, we could do something
lockless, e.g.:

atomic64_t kernel_tlb_gen, flushed_kernel_tlb_gen;

flush_tlb_kernel_range(), etc increment kernel_tlb_gen before flushing
and then update flushed_kernel_tlb_gen to match after flushing.

The vmap code immediately removes PTEs when unmaps occur (which it may
very well do right now -- I haven't checked) but also tracks the
kernel_tlb_gen associated with each record of an
unmapped-but-not-zapped area.  Then we split vm_unmap_aliases() into a
variant that unmaps all aliases and a variant that merely promises to
unmap at least one alias.  The former does what the current code does
except that it skips the IPI if all areas in question have tlb_gen <
flushed_kernel_tlb_gen.  The latter clears all areas with tlb_gen <
flushed_kernel_tlb_gen and, if there weren't any, does
flush_tlb_kernel_range() and flushes everything.

(Major caveat: this is wrong for the case where
flush_tlb_kernel_range() only flushes some but not all of the kernel.
So this needs considerable work if it's actually going to me useful.
The plain old "take locks and clean up" approach might be a better
bet.)

--Andy
