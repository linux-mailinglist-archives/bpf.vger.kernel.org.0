Return-Path: <bpf+bounces-67138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6D3B3F27F
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 04:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B33E4E20B6
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 02:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC482727FA;
	Tue,  2 Sep 2025 02:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXfUzm8w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF4132F77F;
	Tue,  2 Sep 2025 02:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756781366; cv=none; b=H8vUL/ZABzr7Bl3i5FsI1LqOI8tJC229/ULJP1SHpd8ea2u7IA1SmtOMZXJbDyvlbksfjIbosG/cxgriXQPdT+ILrPSnA6+CZK9czUkpEoJmryqyxYZkz3hJhwXvgNffbwlJf1pv4/L9GGu/UvbVFOQiMM70d4314MlOCW/Iap0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756781366; c=relaxed/simple;
	bh=j6apl4co+InwCmd10tcTaeFVunTr8bQX5H1s4UCVAbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yiym4OZ1md6K0phkv4EbxebVf/ZxPdAD8qn5hm+Lzx1RhykXC7tze0lnjULKk8bwP66oyrSY38bQUNiPR/g4YEkipXCUcJApNybN08HGlOuw5bq6B8zWeyWaEWmGFqkrkKgQIdR0IGdEbMZ27Q+U9N6LGU04kv6QCTvPDhmfz2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXfUzm8w; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70de9ffcfffso47431236d6.2;
        Mon, 01 Sep 2025 19:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756781363; x=1757386163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUP9w0YULyiRRnnBIwdjKC8OU+iYqQQqOvvU+cUZsX4=;
        b=fXfUzm8w3NuqJuOjAmZdAqY+x68fpT9yFblDoYMCMWCQk13ld4verznRytcLFGR5yu
         wLLaIN5gAlHHMAXw7V32YzbHtou2+WByPCk5ev9ZF8z4B/qq7/bKfoU+Cb4NjtQV8igD
         looRfxZQXDMPebIZtUid4JSVEf6AB3KrahYubz0hJt9ebKk9yV+QskpapFeL1p2D7/jZ
         BlvuKhvAw7tj1QXMLMhMvDbyyjdh4fG6g7KPnKFViIWDx7OC4P6WmKmFbNkdMFQh2b5G
         o72/P9mwe1cUnF3W9meDMbhobP12Yo8vKN9BWrNuyTXgl/CqhP8FylWnP6lkSzTRSIGX
         CVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756781363; x=1757386163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUP9w0YULyiRRnnBIwdjKC8OU+iYqQQqOvvU+cUZsX4=;
        b=q8bh8C3bSQ7c5/NjqMBL9VxUIAyOMgxWEJBm2D/6CoFbtysf4vP3NzlQhkW4Wbi87o
         P9ZZ1Y8jO2QWn8bCGTNfQKrQSi7frNT29sgfhB8ypebuzZ92mY7ruQ0RqA5cPgiBqZtz
         wcHcbrQvIRf0+uyJ+UsiPRXTZ7nKOiF01Ka31aRU/TNu+bWwRwri50zZF0XtZjDJdlLY
         8FJbWElnhgBflw8wOzNXpj1AM1CF3xJNzSbD29GuRQIeNMMTIysnrCo/mbou2RTzdIVU
         ZDy+DGaDWsnLxoXjKokuOEXC4ibGEL+k5iNZUJm2GzIdcDFw0WjQ5ZAUorK4mgi2pRJF
         D1Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUiN2jrbXwndioGwZjYHiupVkfNO92MKM8ynFZU0l9kzjr/PRF8ulrfitw64x9fx9iV6+o=@vger.kernel.org, AJvYcCUqep7eA2W6xj9pMaYSXZOQY09NVGS0TTNj23N4m8veo4z3Rl5P+2tkZgzcS3C1arhcbof3owIwaNqP@vger.kernel.org
X-Gm-Message-State: AOJu0YxGTMlrkx/UYQfGtph3pgwo1Vn0CrvwTc/aJ67ujEQbtxxMqX4Q
	7TBkYFKIW/XgAH1sTroDUEOU4JMVf+4JP7ITweBdQi72e05SAjMMr+B6OxAs9SInAJFD1UQrDTN
	5vOFiWNnHz05cpeBAZio6bwCPjVQ1sUk=
X-Gm-Gg: ASbGncvlTLYrscYLdtxMrZUNqRx91t6H/P68G5JSjJDO9TCOMxLD6wXdlPGYGmugBW+
	rFBMBjHwrhEZT4CelbO+S/s39Qa55zjVxx7TjYGC3MzDOZ0DnesDILrHCDJNiGm+F7bs0cEsw3g
	wQ0g2uSaOgngZZv2PY3BijmuCmTncYUDTwwCeRTo78v8+BQehsGdJiIPFvCmWEPkM4Zh9gWHHqE
	GZjvwYQhYqDb524w0bYrzpeVT1HvU5X8k92v/wN
X-Google-Smtp-Source: AGHT+IE1C35e1sDvqxEfIXD2mJ0lddO/GMjI0L1bn740LuJspS045VKCkbSg193JvmqK0lXcqQvbcT8ZB1N8QQ0AdBI=
X-Received: by 2002:a05:6214:404:b0:70d:dade:c359 with SMTP id
 6a1803df08f44-70fac8943a8mr115702276d6.35.1756781363373; Mon, 01 Sep 2025
 19:49:23 -0700 (PDT)
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
 <73ca819c-9a2b-4f12-853d-557a4e7399e9@lucifer.local>
In-Reply-To: <73ca819c-9a2b-4f12-853d-557a4e7399e9@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 2 Sep 2025 10:48:47 +0800
X-Gm-Features: Ac12FXyO4izGS6-5B7-USCiG73zEbiKHhxahma8eif44AkhXjkm-wICmc-N4i_E
Message-ID: <CALOAHbDXBaumw0W=Ak=AQG+64jQb9Usy8_9m00vNaZ7SPKFayg@mail.gmail.com>
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

On Mon, Sep 1, 2025 at 7:39=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Sun, Aug 31, 2025 at 11:11:34AM +0800, Yafang Shao wrote:
> > On Fri, Aug 29, 2025 at 6:42=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Fri, Aug 29, 2025 at 11:01:59AM +0800, Yafang Shao wrote:
> > > > On Thu, Aug 28, 2025 at 6:50=E2=80=AFPM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > >
> > > > > On Thu, Aug 28, 2025 at 01:54:39PM +0800, Yafang Shao wrote:
> > > > > > > Also will mm ever !=3D vma->vm_mm?
> > > > > >
> > > > > > No it can't. It can be guaranteed by the caller.
> > > > >
> > > > > In this case we don't need to pass mm separately then right?
> > > >
> > > > Right, we need to pass either @mm or @vma. However, there are cases
> > > > where vma information is not available at certain call sites, such =
as
> > > > in khugepaged. In those cases, we need to pass @mm instead.
> > >
> > > Yeah... this is weird to me though, are you checking in _general_ wha=
t
> > > khugepaged should use, or otherwise surely it's per-VMA?
> > >
> > > Otherwise this bpf hook seems ill-suited for that, and we should have=
 a
> > > separate one for khugepaged surely?
> > >
> > > I also hate that we're passing mm _just because of this one edge case=
_,
> > > otherwise always passing vma->vm_mm, it's a confusing interface.
> >
> > make sense.
> > I'll give some thought to how we can better handle this edge case.
>
> Thanks!
>
> > > >
> > > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Also if we're returning a bitmask of orders which you seem to=
 be (not sure I
> > > > > > > like that tbh - I feel like we shoudl simply provide one orde=
r but open for
> > > > > > > disucssion) - shouldn't it return an unsigned long?
> > > > > >
> > > > > > We are indifferent to whether a single order or a bitmask is re=
turned,
> > > > > > as we only use order-0 and order-9. We have no use cases for
> > > > > > middle-order pages, though this feature might be useful for oth=
er
> > > > > > architectures or for some special use cases.
> > > > >
> > > > > Well surely we want to potentially specify a mTHP under certain c=
ircumstances
> > > > > no?
> > > >
> > > > Perhaps there are use cases, but I haven=E2=80=99t found any use ca=
ses for
> > > > this in our production environment. On the other hand, I can clearl=
y
> > > > see a risk that it could lead to more costly high-order allocations=
.
> > >
> > > So why are we returning a bitmap then? Seems like we should just retu=
rn a
> > > single order in this case... I think you say below that you are open =
to
> > > this?
> >
> > will return a single order in the next version.
>
> Thanks
>
> >
> > >
> > > >
> > > > >
> > > > > In any case I feel it's worth making any bitfield a system word s=
ize.
> > >
> > > Also :>)
> > >
> > > If we do move to returning a single order, should be unsigned int.
> >
> > sure
>
> Thanks!
>
> > > >
> > > > >
> > > > > And generally at this point I think we should just drop this bit =
of code
> > > > > honestly.
> > > >
> > > > MMF_VM_HUGEPAGE is set when the THP mode is "always" or "madvise". =
If
> > > > it=E2=80=99s set, any forked child processes will inherit this flag=
. It is
> > > > only cleared when the mm_struct is destroyed (please correct me if =
I=E2=80=99m
> > > > wrong).
> > >
> > > __mmput()
> > > -> khugepaged_exit()
> > > -> (if MMF_VM_HUGEPAGE set) __khugepaged_exit()
> > > -> Clear flag once mm fully done with (afaict), dropping associated m=
m refcount.
> > >
> > > ^--- this does seem to be accurate indeed.
> >
> > Thanks for the explanation.
>
> No problem, this was more 'Lorenzo's thought process' :P
>
> >
> > >
> > > >
> > > > However, when you switch the THP mode to "never", tasks that still
> > > > have MMF_VM_HUGEPAGE remain on the khugepaged scan list. This isn=
=E2=80=99t an
> > > > issue under the current global mode because khugepaged doesn=E2=80=
=99t run
> > > > when THP is set to "never".
> > > >
> > > > The problem arises when we move from a global mode to a per-task mo=
de.
> > > > In that case, khugepaged may end up doing unnecessary work. For
> > > > example, if the THP mode is "always", but some tasks are not allowe=
d
> > > > to allocate THP while still having MMF_VM_HUGEPAGE set, khugepaged
> > > > will continue scanning them unnecessarily.
> > >
> > > But this can change right?
> > >
> > > I really don't like the idea _at all_ of overriding this hook to do t=
hings
> > > other than what it says it does.
> > >
> > > It's 'set which order to use' except when it's this case then it's 'w=
ill we
> > > do any work'.
> > >
> > > This should be a separate callback or we should drop this and live wi=
th the
> > > possible additional work.
> >
> > Perhaps we could reuse the MMF_DISABLE_THP flag by introducing a new
> > BPF helper to set it when we want to disable THP for a specific task.
>
> Interesting, yeah perhaps that could work, as long as we're in a sensible
> context to be able to toggle this bit.

Right, we can't set the mm->flags arbitrarily.
Perhaps we should add a generic BPF hook in dup_mmap().

diff --git a/mm/mmap.c b/mm/mmap.c
index 7a057e0e8da9..1b60bdb08de1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1843,6 +1843,8 @@ __latent_entropy int dup_mmap(struct mm_struct
*mm, struct mm_struct *oldmm)
 loop_out:
        vma_iter_free(&vmi);
        if (!retval) {
+               /* Allow a BPF program to modify the new mm_struct in fork.=
 */
+               bpf_hook_mm_fork(mm, oldmm);
                mt_set_in_rcu(vmi.mas.tree);
                ksm_fork(mm, oldmm);
                khugepaged_fork(mm, oldmm);

This provides a mechanism for BPF programs to configure the new
mm_struct on demand, acting as a modern, flexible replacement for
prctl() ;-)

>
> >
> > Separately from this patchset, I realized we can optimize khugepaged
> > handling for the MMF_DISABLE_THP case with the following changes:
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 15203ea7d007..e9964edcee29 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -402,6 +402,11 @@ void __init khugepaged_destroy(void)
> >         kmem_cache_destroy(mm_slot_cache);
> >  }
> >
> > +static inline int hpage_collapse_test_disable(struct mm_struct *mm)
> > +{
> > +       return test_bit(MMF_DISABLE_THP, &mm->flags);
> > +}
> > +
> >  static inline int hpage_collapse_test_exit(struct mm_struct *mm)
> >  {
> >         return atomic_read(&mm->mm_users) =3D=3D 0;
> > @@ -1448,6 +1453,11 @@ static void collect_mm_slot(struct
> > khugepaged_mm_slot *mm_slot)
> >                 /* khugepaged_mm_lock actually not necessary for the be=
low */
> >                 mm_slot_free(mm_slot_cache, mm_slot);
> >                 mmdrop(mm);
> > +       } else if (hpage_collapse_test_disable(mm)) {
> > +               hash_del(&slot->hash);
> > +               list_del(&slot->mm_node);
> > +               mm_flags_clear(MMF_VM_HUGEPAGE, mm);
> > +               mm_slot_free(mm_slot_cache, mm_slot);
> >         }
> >  }
> >
> > Specifically, if MMF_DISABLE_THP is set, we should remove it from
> > mm_slot to prevent unnecessary khugepaged processing.
>
> Ohhh interesting, perhaps send as separate patch?

sure, I will send it separately.

--=20
Regards
Yafang

