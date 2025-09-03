Return-Path: <bpf+bounces-67246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3106BB4122D
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 04:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF97A16A9C6
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 02:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDF61E7C34;
	Wed,  3 Sep 2025 02:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQbVQ8n9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4EA1E2838;
	Wed,  3 Sep 2025 02:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756865485; cv=none; b=V5JHIebmg7b4++9NyiDEVd8CTp5+DTjfsQysrocbBCEUNGITdxO674d7AkqzPmQh9MfX/5+ldMuepeGBWUE0yTm1Ks9RXBCORl2v1xp6xJGSpTSKhspXQt9qLkAqDuQrCyj+CVZqh6cRYqIYfmit9VtX2PM4WU5rCE58P8nmiLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756865485; c=relaxed/simple;
	bh=up0m3QjYYM98dIry+86nDsuG3DeVB2n2A+F5JusZ3A8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5LSK5rva7W4evdH+AUXCkRtXaGvsF7gOMv1pT8zlsfLHgddtmit235medA4LgrT92WYPkyAehUVE17px1EbF4OeE8AZrfWlOpqB7Y2SXYbdJcauwyWECq2VBF0K1ai2eT0/KDElCPC5iPTWOCESg75h1RjPxfh4yx3CvJ7zVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQbVQ8n9; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70de042246eso46787446d6.1;
        Tue, 02 Sep 2025 19:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756865482; x=1757470282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdqNFNYALodzYVHsNSrlk7v0LMXjLfKbkcpRQgMAJzY=;
        b=CQbVQ8n9/C1fuWWo0aATOwCyuWaBpL9b3qQq1+9PMTgn+LmGAOF2Q/G1J4OsQxg+mP
         rsernAhAYLLGnv2RT4O79gXdGjWVqLPUIGhk+KKqyTScm07EKBR1kCQTl1vsvSjRgofM
         hhOKUD3AL+gnbW+tW4XsM8KLRvWQvB/uDxeoSNrl2MVUNdj/gynnkzxThxWszgYJkIrK
         evJZX6Z7N8gAEUdn+Eo/UDbz+G2ZOBmPqfH9fO+cnDdfZRDi1ZWzER4KlccXD/+9t6u3
         Oi822R+9STPVH10SQUPJ1rCS6rLxLPi9mADvrYIW4YBLDpDIAajyu0aldS8eZnAYc67E
         GS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756865482; x=1757470282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdqNFNYALodzYVHsNSrlk7v0LMXjLfKbkcpRQgMAJzY=;
        b=qNK3vGNW64O+t0L8wF/0wxsxHSNlM20o5OVFDQNvgYjHtWw9W1ZAdFVnBnjAzfbKhJ
         uQ0wuRnCYaHm4xzK5V7w30hqeWil57YI7bkjUZzPSNCtiunHPHMaCQZvBqla2AxnOh4p
         xXjz8uhTkucmlBtgB+r3tQx6DbWXF56xDKMmKnAkTw88fGfWDDUksN+Y3NX7pLqdOH7T
         m8yYXnat2TP93lBcfpVUQzITzPGtjUQjpNq+sUebMgY4S7rNPkZxhYAY9TZd0LBmS7eQ
         RIPIqHPJT1FojpoTsEtPydfGqWwx2tSyygAOTbtGyUqw1c/iveml7hue5O+7PjG4208d
         neEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZjOlhXDc/2zhQ7w2vAgRo6a5JSTIANxt2Ty4mYjsMgHHGeyXe3wFC/BFHR4VwkLAtQdM=@vger.kernel.org, AJvYcCX6X1fQ3ArMywNxheJ/UDSzT4W/Ofglnc2EsDQyEXBPHH2FuHXPJazfUGVc9eQljVxfjbrt0bMWX9Ld@vger.kernel.org
X-Gm-Message-State: AOJu0YyH+L4TE3dFU/SUrTL0uOiSUF5aWlIAwUKHuAMfVmgPHCUH8ZZu
	EEijbIZf7TMCPyuStBklOaElPLykpWRCIZQVAfZJg5uFKBhaMI/58vVoXXxW3U2P5LQHY8jQSIQ
	AebO7GeHpDouz9l5Ua4twvvLLsHmuw30=
X-Gm-Gg: ASbGncvAofGzN0HvTAX4zMvgydZWUpEFdS61C1410EfjX9WjV90oy3evS/tZKgblDs4
	lAurAbG78plK9VCbtlFFE3SwolklGSKCJUpNnA/zhcIeffrpBEdxlQmwW0rN0NARp1jdvf/20WI
	hRFwwzwuRkHnHQ9ItuBxZcnK8dgyW7ZLGQpK1sC60WkgmM2YGqZ280BOvuLBHB5CKGLp3wxS8y6
	f0D9Ca50dkzMgiYmutcLhVEOW4hJBecZMHvUP3G
X-Google-Smtp-Source: AGHT+IGz2gBVy7MkvtGJ1h228Bg/OBFxRXDjUUk7x4EwH+bv0391gRJTsywXbH6IULWjrEHcWzM5SpX7ZwkmkyuZ2sw=
X-Received: by 2002:a05:6214:622:b0:70f:a460:c454 with SMTP id
 6a1803df08f44-70fac896f25mr173575846d6.34.1756865482399; Tue, 02 Sep 2025
 19:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-1-laoar.shao@gmail.com> <20250826071948.2618-2-laoar.shao@gmail.com>
 <f1bc20e0-9d39-4294-8f70-f51315a534d8@lucifer.local> <CALOAHbCd4vuZoot-Bt4y=4EMLB0UvX=5u8PjsW2Nz883sevT1g@mail.gmail.com>
 <80db932c-6d0d-43ef-9c80-386300cbeb64@lucifer.local> <CALOAHbCQucvD968pgmMzv0dcg1j5cJ+Nxz4FKaiGXajXXBcs0Q@mail.gmail.com>
 <95a32a87-5fa8-4919-8166-e9958d6d4e38@lucifer.local> <CALOAHbBRQf=QLqYgA9E8m6AKGmZxY6rFZsoXwTYCaiSqpTb=JQ@mail.gmail.com>
 <73ca819c-9a2b-4f12-853d-557a4e7399e9@lucifer.local> <CALOAHbDXBaumw0W=Ak=AQG+64jQb9Usy8_9m00vNaZ7SPKFayg@mail.gmail.com>
 <21b73d0f-c322-490b-8fb9-ef9f67f7393f@lucifer.local>
In-Reply-To: <21b73d0f-c322-490b-8fb9-ef9f67f7393f@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 3 Sep 2025 10:10:46 +0800
X-Gm-Features: Ac12FXw7pJ_LSeKo9cC58k0LnXweemYE9VcHAzJCfbisVZoecU7a9SJNAsKTIRQ
Message-ID: <CALOAHbCegJEHf+zaYuK6HFu_Y6KTwX_KSgsxaf_rvR1pF4aCMw@mail.gmail.com>
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

On Tue, Sep 2, 2025 at 3:50=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Sep 02, 2025 at 10:48:47AM +0800, Yafang Shao wrote:
> > > >
> > > > >
> > > > > >
> > > > > > However, when you switch the THP mode to "never", tasks that st=
ill
> > > > > > have MMF_VM_HUGEPAGE remain on the khugepaged scan list. This i=
sn=E2=80=99t an
> > > > > > issue under the current global mode because khugepaged doesn=E2=
=80=99t run
> > > > > > when THP is set to "never".
> > > > > >
> > > > > > The problem arises when we move from a global mode to a per-tas=
k mode.
> > > > > > In that case, khugepaged may end up doing unnecessary work. For
> > > > > > example, if the THP mode is "always", but some tasks are not al=
lowed
> > > > > > to allocate THP while still having MMF_VM_HUGEPAGE set, khugepa=
ged
> > > > > > will continue scanning them unnecessarily.
> > > > >
> > > > > But this can change right?
> > > > >
> > > > > I really don't like the idea _at all_ of overriding this hook to =
do things
> > > > > other than what it says it does.
> > > > >
> > > > > It's 'set which order to use' except when it's this case then it'=
s 'will we
> > > > > do any work'.
> > > > >
> > > > > This should be a separate callback or we should drop this and liv=
e with the
> > > > > possible additional work.
> > > >
> > > > Perhaps we could reuse the MMF_DISABLE_THP flag by introducing a ne=
w
> > > > BPF helper to set it when we want to disable THP for a specific tas=
k.
> > >
> > > Interesting, yeah perhaps that could work, as long as we're in a sens=
ible
> > > context to be able to toggle this bit.
> >
> > Right, we can't set the mm->flags arbitrarily.
> > Perhaps we should add a generic BPF hook in dup_mmap().
> >
>
> Yeah perhaps that could be a way forward :)
>
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 7a057e0e8da9..1b60bdb08de1 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1843,6 +1843,8 @@ __latent_entropy int dup_mmap(struct mm_struct
> > *mm, struct mm_struct *oldmm)
> >  loop_out:
> >         vma_iter_free(&vmi);
> >         if (!retval) {
> > +               /* Allow a BPF program to modify the new mm_struct in f=
ork. */
> > +               bpf_hook_mm_fork(mm, oldmm);
> >                 mt_set_in_rcu(vmi.mas.tree);
> >                 ksm_fork(mm, oldmm);
> >                 khugepaged_fork(mm, oldmm);
> >
> > This provides a mechanism for BPF programs to configure the new
> > mm_struct on demand, acting as a modern, flexible replacement for
> > prctl() ;-)
>
> Hahaha that's obviously very appealing to me :)))
>
> >
> > >
> > > >
> > > > Separately from this patchset, I realized we can optimize khugepage=
d
> > > > handling for the MMF_DISABLE_THP case with the following changes:
> > > >
> > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > index 15203ea7d007..e9964edcee29 100644
> > > > --- a/mm/khugepaged.c
> > > > +++ b/mm/khugepaged.c
> > > > @@ -402,6 +402,11 @@ void __init khugepaged_destroy(void)
> > > >         kmem_cache_destroy(mm_slot_cache);
> > > >  }
> > > >
> > > > +static inline int hpage_collapse_test_disable(struct mm_struct *mm=
)
> > > > +{
> > > > +       return test_bit(MMF_DISABLE_THP, &mm->flags);
> > > > +}
> > > > +
> > > >  static inline int hpage_collapse_test_exit(struct mm_struct *mm)
> > > >  {
> > > >         return atomic_read(&mm->mm_users) =3D=3D 0;
> > > > @@ -1448,6 +1453,11 @@ static void collect_mm_slot(struct
> > > > khugepaged_mm_slot *mm_slot)
> > > >                 /* khugepaged_mm_lock actually not necessary for th=
e below */
> > > >                 mm_slot_free(mm_slot_cache, mm_slot);
> > > >                 mmdrop(mm);
> > > > +       } else if (hpage_collapse_test_disable(mm)) {
> > > > +               hash_del(&slot->hash);
> > > > +               list_del(&slot->mm_node);
> > > > +               mm_flags_clear(MMF_VM_HUGEPAGE, mm);
> > > > +               mm_slot_free(mm_slot_cache, mm_slot);
> > > >         }
> > > >  }
> > > >
> > > > Specifically, if MMF_DISABLE_THP is set, we should remove it from
> > > > mm_slot to prevent unnecessary khugepaged processing.
> > >
> > > Ohhh interesting, perhaps send as separate patch?
> >
> > sure, I will send it separately.
>
> Thanks!
>
> >
> > --
> > Regards
> > Yafang
>
> And overall - cheers for being an ABSOLUTE DELIGHT on review :) it's much
> appreciated. I shall buy you a beer (or whatever is your preferred
> beverage) at the next conference we are both at :)

Honestly, that's exactly what I wanted to say to you too! I learned so
much during your review process, and I owe you a beer (or your drink
of choice) as well!

--=20
Regards
Yafang

