Return-Path: <bpf+bounces-67066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0BFB3D0D1
	for <lists+bpf@lfdr.de>; Sun, 31 Aug 2025 05:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70194449D3
	for <lists+bpf@lfdr.de>; Sun, 31 Aug 2025 03:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F16F207A32;
	Sun, 31 Aug 2025 03:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyPkHC2i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548C433F6;
	Sun, 31 Aug 2025 03:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756609934; cv=none; b=PTaZGDEsLMMlY0qj/3Jp9ZZqCIZ8YUu624q64ue6rtDaV/hW9bM2zlyf75484I6GOkT7cwS17DZHN7miVLMZuGp2Ip32K4B14a1EiYdMFjpBMPq5rQy0LEsfZ8KGqh62nq9+grO5u5xwMZhCY/LyhwJEsMt7ARqfC2F2FJ4vVEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756609934; c=relaxed/simple;
	bh=ZghKD+huZEMFUfuTcUPU6A8gGO3lMEzzE+8mMxZGLy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYBvIfRvAV87e+g81GA9tZWZM1x0KdsWYiyIUMn+8nNQS3YPMgkxe/YVN4w2AOzDWRm2DhjwzLTekDqvVN97V8PtX/zj+tstUwvaYbvQ6pVcJmSvG7/DJwCFhOTUzaPNVJImhogc1AeoMUbiwjm83viqkR2dJRyUgo3z37T2cFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyPkHC2i; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-70fa294211dso18632916d6.0;
        Sat, 30 Aug 2025 20:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756609931; x=1757214731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6uViiQkLqQ26rYisgrBivch86yoSDYpu/P/2cI/29k=;
        b=KyPkHC2iMqWJ+HXq11ncUqS2bixsUxBgsJW2BDd/lreqfQYt6dRjbGJz8twx+uFy02
         RvRrE0YvaCUyP2MMOF1UferdAwMNHmnmGNlNhrvf18xCE6784Rgs7NYI/dE6ua1yjVzj
         SINX4G1n+u0N5fgn7AgvDg+iF6NOYkN3MctWXcxroXdtLZObE9O5/cLG6kvD6JG3x6Jf
         TvBeYZbTXIdjIPwMzUAAPCqU8qDIppJ1dOAQ+qTMkmOmUmzpCDAIGf7jU+b1TjD2gVPx
         DX8Nw0yLJuvLOT+RwcK6J+9JMsTk5oPUXPlV0P0l318G/zVxOjucQJH4LkdBxyuOFdQZ
         s6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756609931; x=1757214731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6uViiQkLqQ26rYisgrBivch86yoSDYpu/P/2cI/29k=;
        b=n//Lg5dTWBPv42ycdMFlcTRhNs1AGqbDdQ2obp3qDVAl952AOZb+rwlOe8SJkOG49Z
         SB7pPdxHyVLQ9eWhtdzsmlgt5a5rsPqTa8Ekxpr0OWzquFTZIaE4kbjzjXz9ztLNLKfG
         FzzectCe5AYV9oz85xAjeGPROP8e22Y//cFq3uZ+JYNMty6AhSPgPtGZ1gAOdmerSk5y
         aGzTmaZMR1WIG5PCFRsBiUdA40WWAjOo4bUO7ISCCaNRkh4RrKqrMfLFceHbfvOwlSdp
         KoAHORXHOvdMn9Wo7DbTg0zI4TGbwClXeIZRt/Z20x6sNab+CspCmrgFDmrubJ7hxUYq
         0TBg==
X-Forwarded-Encrypted: i=1; AJvYcCVZQ2W9/dVaZsWL+YdTyPYEPBJscXFrsFXRlokCCP1XeGwhMfnEHqw/Obus0PUdQutJIK8=@vger.kernel.org, AJvYcCXFu4yLnIrk/qualKN3Jn3krdtRAc1SZGBhgsltZGDrg/E3pAX8JBD3V0N8W1ZcjXtrQM4ex7UYgZIY@vger.kernel.org
X-Gm-Message-State: AOJu0YyCBRG6f0dH7QCn4yJ53APxTRh66ytmsnhT1Diqpf2OjEdtEJ9x
	WVpCjJ8zlFQPlNKJM9CzkC5D5NBWzr/KbbCYJ/KjNnpqrTeoD1CZH8WymkdKPo5BRoesvoYfGV/
	lZpzxrr/oKCwyGKOCI2uWSX/PTIxS7lg=
X-Gm-Gg: ASbGnctKkzslRvfwf4MXPIHj+sj7JQL1wGZdHT07IGilhOP2ahiqzeJIWj+825Oh5ny
	FgB9/lROLbihNAyOxRD/kWVyKQBtEgaUrVnQEzKD29pBOb1iaBsWhs4mEedtsVprRs4My10HZz7
	pHmkHA+4WfIQj2FIrDtxM3YfFQch0o46me5y/vs0cSIkVBrdGCCpyRWdGdyJXkIfF9DdHDafkT2
	VBkWKYrZ09AsPT7Ej3vqnECDNt8K9YoUOGpKWmXEhajEZd/tIQ=
X-Google-Smtp-Source: AGHT+IHoOeIBrZuK799idI+00BU0X1iG2eH36Jm1fCyI100q8UfhD5xJHvPrmnVRleAD5vkGI71wj24qNED5HFa1jek=
X-Received: by 2002:a05:6214:2246:b0:70d:c4f1:cd7d with SMTP id
 6a1803df08f44-70fac901b9dmr41557476d6.56.1756609931096; Sat, 30 Aug 2025
 20:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-1-laoar.shao@gmail.com> <20250826071948.2618-2-laoar.shao@gmail.com>
 <f1bc20e0-9d39-4294-8f70-f51315a534d8@lucifer.local> <CALOAHbCd4vuZoot-Bt4y=4EMLB0UvX=5u8PjsW2Nz883sevT1g@mail.gmail.com>
 <80db932c-6d0d-43ef-9c80-386300cbeb64@lucifer.local> <CALOAHbCQucvD968pgmMzv0dcg1j5cJ+Nxz4FKaiGXajXXBcs0Q@mail.gmail.com>
 <95a32a87-5fa8-4919-8166-e9958d6d4e38@lucifer.local>
In-Reply-To: <95a32a87-5fa8-4919-8166-e9958d6d4e38@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 31 Aug 2025 11:11:34 +0800
X-Gm-Features: Ac12FXzOtmfjHzolQe069Qe3boecmHTNTi6kRA1b6pdevFJ7dSaEwg9sdG8Semg
Message-ID: <CALOAHbBRQf=QLqYgA9E8m6AKGmZxY6rFZsoXwTYCaiSqpTb=JQ@mail.gmail.com>
Subject: Re: [PATCH v6 mm-new 01/10] mm: thp: add support for BPF based THP
 order selection
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 6:42=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Aug 29, 2025 at 11:01:59AM +0800, Yafang Shao wrote:
> > On Thu, Aug 28, 2025 at 6:50=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Thu, Aug 28, 2025 at 01:54:39PM +0800, Yafang Shao wrote:
> > > > > Also will mm ever !=3D vma->vm_mm?
> > > >
> > > > No it can't. It can be guaranteed by the caller.
> > >
> > > In this case we don't need to pass mm separately then right?
> >
> > Right, we need to pass either @mm or @vma. However, there are cases
> > where vma information is not available at certain call sites, such as
> > in khugepaged. In those cases, we need to pass @mm instead.
>
> Yeah... this is weird to me though, are you checking in _general_ what
> khugepaged should use, or otherwise surely it's per-VMA?
>
> Otherwise this bpf hook seems ill-suited for that, and we should have a
> separate one for khugepaged surely?
>
> I also hate that we're passing mm _just because of this one edge case_,
> otherwise always passing vma->vm_mm, it's a confusing interface.

make sense.
I'll give some thought to how we can better handle this edge case.

>
> >
> > >
> > > >
> > > > >
> > > > > Are we hacking this for the sake of overloading what this does?
> > > >
> > > > The @vma is actually unneeded. I will remove it.
> > >
> > > Ah OK.
> > >
> > > I am still a little concerned about passing around a value reference =
to the VMA
> > > flags though, esp as this type can + will change in future (not sure =
what that
> > > means for BPF).
> > >
> > > We may go to e.g. a 128 bit bitmap there etc.
> >
> > As mentioned in another thread, we only need to determine whether the
> > flag is VM_HUGEPAGE or VM_NOHUGEPAGE, so it can be simplified.
>
> OK cool thanks. Maybe missed.
>
> >
> > >
> > >
> > > >
> > > > >
> > > > > Also if we're returning a bitmask of orders which you seem to be =
(not sure I
> > > > > like that tbh - I feel like we shoudl simply provide one order bu=
t open for
> > > > > disucssion) - shouldn't it return an unsigned long?
> > > >
> > > > We are indifferent to whether a single order or a bitmask is return=
ed,
> > > > as we only use order-0 and order-9. We have no use cases for
> > > > middle-order pages, though this feature might be useful for other
> > > > architectures or for some special use cases.
> > >
> > > Well surely we want to potentially specify a mTHP under certain circu=
mstances
> > > no?
> >
> > Perhaps there are use cases, but I haven=E2=80=99t found any use cases =
for
> > this in our production environment. On the other hand, I can clearly
> > see a risk that it could lead to more costly high-order allocations.
>
> So why are we returning a bitmap then? Seems like we should just return a
> single order in this case... I think you say below that you are open to
> this?

will return a single order in the next version.

>
> >
> > >
> > > In any case I feel it's worth making any bitfield a system word size.
>
> Also :>)
>
> If we do move to returning a single order, should be unsigned int.

sure

>
> > >
> > > >
> > > > >
> > > > > > +#else
> > > > > > +static inline int
> > > > > > +get_suggested_order(struct mm_struct *mm, struct vm_area_struc=
t *vma__nullable,
> > > > > > +                 u64 vma_flags, enum tva_type tva_flags, int o=
rders)
> > > > > > +{
> > > > > > +     return orders;
> > > > > > +}
> > > > > > +#endif
> > > > > > +
> > > > > >  static inline int highest_order(unsigned long orders)
> > > > > >  {
> > > > > >       return fls_long(orders) - 1;
> > > > > > diff --git a/include/linux/khugepaged.h b/include/linux/khugepa=
ged.h
> > > > > > index eb1946a70cff..d81c1228a21f 100644
> > > > > > --- a/include/linux/khugepaged.h
> > > > > > +++ b/include/linux/khugepaged.h
> > > > > > @@ -4,6 +4,8 @@
> > > > > >
> > > > > >  #include <linux/mm.h>
> > > > > >
> > > > > > +#include <linux/huge_mm.h>
> > > > > > +
> > > > >
> > > > > Hm this is iffy too, There's probably a reason we didn't include =
this before,
> > > > > the headers can be so so fragile. Let's be cautious...
> > > >
> > > > I will check.
> > >
> > > Thanks!
> > >
> > > >
> > > > >
> > > > > >  extern unsigned int khugepaged_max_ptes_none __read_mostly;
> > > > > >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > > > >  extern struct attribute_group khugepaged_attr_group;
> > > > > > @@ -22,7 +24,15 @@ extern int collapse_pte_mapped_thp(struct mm=
_struct *mm, unsigned long addr,
> > > > > >
> > > > > >  static inline void khugepaged_fork(struct mm_struct *mm, struc=
t mm_struct *oldmm)
> > > > > >  {
> > > > > > -     if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm))
> > > > > > +     /*
> > > > > > +      * THP allocation policy can be dynamically modified via =
BPF. Even if a
> > > > > > +      * task was allowed to allocate THPs, BPF can decide whet=
her its forked
> > > > > > +      * child can allocate THPs.
> > > > > > +      *
> > > > > > +      * The MMF_VM_HUGEPAGE flag will be cleared by khugepaged=
.
> > > > > > +      */
> > > > > > +     if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm) &&
> > > > > > +             get_suggested_order(mm, NULL, 0, -1, BIT(PMD_ORDE=
R)))
> > > > >
> > > > > Hmmm so there seems to be some kind of additional functionality y=
ou're providing
> > > > > here kinda quietly, which is to allow the exact same interface to=
 determine
> > > > > whether we kick off khugepaged or not.
> > > > >
> > > > > Don't love that, I think we should be hugely specific about that.
> > > > >
> > > > > This bpf interface should literally be 'ok we're deciding what or=
der we
> > > > > want'. It feels like a bit of a gross overloading?
> > > >
> > > > This makes sense. I have no objection to reverting to returning a s=
ingle order.
> > >
> > > OK but key point here is - we're now determining if a forked child ca=
n _not_
> > > allocate THPs using this function.
> > >
> > > To me this should be a separate function rather than some _weird_ usa=
ge of this
> > > same function.
> >
> > Perhaps a separate function is better.
>
> Thanks!
>
> >
> > >
> > > And generally at this point I think we should just drop this bit of c=
ode
> > > honestly.
> >
> > MMF_VM_HUGEPAGE is set when the THP mode is "always" or "madvise". If
> > it=E2=80=99s set, any forked child processes will inherit this flag. It=
 is
> > only cleared when the mm_struct is destroyed (please correct me if I=E2=
=80=99m
> > wrong).
>
> __mmput()
> -> khugepaged_exit()
> -> (if MMF_VM_HUGEPAGE set) __khugepaged_exit()
> -> Clear flag once mm fully done with (afaict), dropping associated mm re=
fcount.
>
> ^--- this does seem to be accurate indeed.

Thanks for the explanation.

>
> >
> > However, when you switch the THP mode to "never", tasks that still
> > have MMF_VM_HUGEPAGE remain on the khugepaged scan list. This isn=E2=80=
=99t an
> > issue under the current global mode because khugepaged doesn=E2=80=99t =
run
> > when THP is set to "never".
> >
> > The problem arises when we move from a global mode to a per-task mode.
> > In that case, khugepaged may end up doing unnecessary work. For
> > example, if the THP mode is "always", but some tasks are not allowed
> > to allocate THP while still having MMF_VM_HUGEPAGE set, khugepaged
> > will continue scanning them unnecessarily.
>
> But this can change right?
>
> I really don't like the idea _at all_ of overriding this hook to do thing=
s
> other than what it says it does.
>
> It's 'set which order to use' except when it's this case then it's 'will =
we
> do any work'.
>
> This should be a separate callback or we should drop this and live with t=
he
> possible additional work.

Perhaps we could reuse the MMF_DISABLE_THP flag by introducing a new
BPF helper to set it when we want to disable THP for a specific task.

Separately from this patchset, I realized we can optimize khugepaged
handling for the MMF_DISABLE_THP case with the following changes:

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 15203ea7d007..e9964edcee29 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -402,6 +402,11 @@ void __init khugepaged_destroy(void)
        kmem_cache_destroy(mm_slot_cache);
 }

+static inline int hpage_collapse_test_disable(struct mm_struct *mm)
+{
+       return test_bit(MMF_DISABLE_THP, &mm->flags);
+}
+
 static inline int hpage_collapse_test_exit(struct mm_struct *mm)
 {
        return atomic_read(&mm->mm_users) =3D=3D 0;
@@ -1448,6 +1453,11 @@ static void collect_mm_slot(struct
khugepaged_mm_slot *mm_slot)
                /* khugepaged_mm_lock actually not necessary for the below =
*/
                mm_slot_free(mm_slot_cache, mm_slot);
                mmdrop(mm);
+       } else if (hpage_collapse_test_disable(mm)) {
+               hash_del(&slot->hash);
+               list_del(&slot->mm_node);
+               mm_flags_clear(MMF_VM_HUGEPAGE, mm);
+               mm_slot_free(mm_slot_cache, mm_slot);
        }
 }

Specifically, if MMF_DISABLE_THP is set, we should remove it from
mm_slot to prevent unnecessary khugepaged processing.

>
> >
> > To avoid this, we should prevent setting this flag for child processes
> > if they are not allowed to allocate THP in the first place. This way,
> > khugepaged won=E2=80=99t waste cycles scanning them. While an alternati=
ve
> > approach would be to set the flag at fork and later clear it for
> > khugepaged, it=E2=80=99s clearly more efficient to avoid setting it fro=
m the
> > start.
>
> We also obviously should have a comment with all this context here.

Understood. I'll give some thought to a better way of handling this.

--=20
Regards
Yafang

