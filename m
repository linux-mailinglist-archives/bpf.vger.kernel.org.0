Return-Path: <bpf+bounces-66800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1269CB39423
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 08:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8259D1C229F2
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 06:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9408E27780D;
	Thu, 28 Aug 2025 06:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPvtwd+0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736762773F2;
	Thu, 28 Aug 2025 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363693; cv=none; b=r/SXwgqQhYlbh8pHzyppnFTylt8qMOyAB2Vybf2FXgMbOWmY/pNp+/0+PijMHceqdDHwymA67vlSwHh012mqTUlqUlB3szEjWWmouZN/oN6bY1+Gh1P3NH/Oa7lzegsTr5qn6tTA73WmAtEoKa4uGHRM5NfQrVj6GKHz/z6ukDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363693; c=relaxed/simple;
	bh=LvqlVI11D2qEfcPdRN8xDDbC7/lXxeo1pqv4TlHEhhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q80HYw8jIcTRC67S76RJepQx51WflwmYqznfAghww6dTiI7Vcw9yO3ybeqc0iLXiX9UFlt32RVdKEmNTpFdsBjjP53zMaGTUyw34pj1TCOhNhzUF5jNlWCPWZzl7tSPIGOasFwiSM7uFEUrO80qt7TkfAh5C7uhE0QVC1ZBymR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPvtwd+0; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70ddd2e61d9so7842686d6.1;
        Wed, 27 Aug 2025 23:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756363690; x=1756968490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhKDCD8/DGV5fH6nxnOqiP7dbAwWbENHECBTrAvc42o=;
        b=FPvtwd+07hkF3IpV36uHUwttYiNhtDZhR+AU94AtD4YMxsIJiJyKzrHVY9LuEiXOFw
         vm9fUPuIji7G8wKS6vD8Yb+9yP0XQJ7rXty9hHW+qmCAJaKxR8LPYkpPaFqjFF38+hsy
         my+mBJnNKi5CT0aZ+yjWSQHYc3V2XCcEnsjT9WDMx/u3UFarLwj5bK5w3V1i2/nKHSaY
         VH5Rs74qC2igeUBF1hfRSp3BjlqZ71W5uCZtENgTWODUnV0jPtKY/RQmFDZ5yW1YXPtg
         iogIjzf3KrDWeseR30gVRp5HX7SiSoAg7l5lJuAX+T3MM3FXbD1lkb4GkiKSW4Cu6Lc+
         iFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756363690; x=1756968490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhKDCD8/DGV5fH6nxnOqiP7dbAwWbENHECBTrAvc42o=;
        b=BEIzXFqsZwDC/He7s6HJ/m6AFOu/DfJ58rY4KQ8nks1ibJm3xweLj1Cveh0ymEqBaG
         F+pmx4uNthvB8aog0vOQDN1jB+41gMbS/zTX+eks6vLpB4+2absUZTkcdh8CIp7tauro
         ZoCKe3RWA7xG9BZSSxFt/BqrVjOFSYZSPu5zr0r01wYD5Ti78VJs9QCdifc8sbuDyJS+
         VAvo+Uy3fDMagKJLZIkHIJbO15q8b/sgycZuZQbZw9fUR6/CBZZUbF1bTsa4ipaOJ21v
         Y4M86VOe7+CiD7QHv0hsHWofvYi0IpozPgCZoIzFzRI/8qSho+GbC7tCKuiFxXeLMkEy
         LFjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxWUktqujXTcNcbfiXgdzFo6zJfvy/ROEu/a6O8YunSqIrh6rvgPQarBj0bEmwkNOKUGC7KsAVBiqe@vger.kernel.org, AJvYcCWYZmADtEGfK6bQRJau7aA48IquxEKrGpp/8kYqD3qZJr+zhCOdo4vbAUpG/0Hx4bxen0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoYa/ijS/lUyTyZFU07HMQctXyQN/rVUkJDE1XbbTxovbnuWCH
	0qfHu7yAVBhPhdsqO0HZtqeD84kW3tQX/41Xiw2MzRiB+Uf87ROM0YNhk5mvfY0bex/r3AJirbZ
	GBP+1uLBFLHTg+/QiO/Yt41J+03kmcFI=
X-Gm-Gg: ASbGncswLroRXLXQDYm7roEpDRdhRUvMIqZ2fSLGcXWjIipxMxdZPaI556oyWEUPDcD
	Dz6fPJJmYocrExElWMuqQqguqmKAZy29pbAo078FEUXzf/VRoHgg3VGeffZ3RwHsECwd56t8JUh
	woJzdj2KABUItS6JxsFM28upTyMGJrePOhYMBiTKbokU655NnyMKud7JGQPgPy+zPL7vQ9z4hoo
	tACAx5QsJ5Hxt8ZFlpgNYzwEw6bXMYxWWgEj5Q=
X-Google-Smtp-Source: AGHT+IEHoD0Uiusmd/UOKL+6+ngiZoVhE1NGASgu/DqDEWY+8Tk5z5aKAhPh99n6YIUVa7EigBjgFPT+dBliZZToc6M=
X-Received: by 2002:a05:6214:19e7:b0:70d:b1ea:25ed with SMTP id
 6a1803df08f44-70db1ea286fmr214292226d6.23.1756363690237; Wed, 27 Aug 2025
 23:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-1-laoar.shao@gmail.com> <20250826071948.2618-4-laoar.shao@gmail.com>
 <5fb8bd8d-cdd9-42e0-b62d-eb5a517a35c2@lucifer.local>
In-Reply-To: <5fb8bd8d-cdd9-42e0-b62d-eb5a517a35c2@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 28 Aug 2025 14:47:34 +0800
X-Gm-Features: Ac12FXxFTwzSzvJhj5UIbCdO1z68biL2fU9bhU24okrE4ErExRxkOpwYSA6y-j0
Message-ID: <CALOAHbBHLLo+Xcd=zJeQp9gvLBnyYWAdeBiqKYKgj424m1Sn6A@mail.gmail.com>
Subject: Re: [PATCH v6 mm-new 03/10] mm: thp: add a new kfunc bpf_mm_get_task()
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

On Wed, Aug 27, 2025 at 11:42=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Aug 26, 2025 at 03:19:41PM +0800, Yafang Shao wrote:
> > We will utilize this new kfunc bpf_mm_get_task() to retrieve the
> > associated task_struct from the given @mm. The obtained task_struct mus=
t
> > be released by calling bpf_task_release() as a paired operation.
>
> You're basically describing the patch you're not saying why - yeah you're
> getting a task struct from an mm (only if CONFIG_MEMCG which you don't
> mention here), but not for what purpose you intend to use this?

For example, we could retrieve task->comm or other attributes and make
decisions based on that information. I=E2=80=99ll provide a clearer
description in the next revision.

>
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  mm/bpf_thp.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
> > index b757e8f425fd..46b3bc96359e 100644
> > --- a/mm/bpf_thp.c
> > +++ b/mm/bpf_thp.c
> > @@ -205,11 +205,45 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cg=
roup *memcg)
> >  #endif
> >  }
> >
> > +/**
> > + * bpf_mm_get_task - Get the task struct associated with a mm_struct.
> > + * @mm: The mm_struct to query
> > + *
> > + * The obtained task_struct must be released by calling bpf_task_relea=
se().
>
> Hmmm so now bpf programs can cause kernel bugs by keeping a reference aro=
und?
>
> This feels extremely dodgy, I don't like this at all.
>
> I thought the whole point of BPF was that this kind of thing couldn't pos=
sibly
> happen?
>
> Or would this be a kernel bug?
>
> If a bpf program can lead to a refcount not being put, this is not
> upstreamable surely?

As explained by Andrii, the BPF verifier can protect it.

>
> > + *
> > + * Return: The associated task_struct on success, or NULL on failure. =
Note that
> > + * this function depends on CONFIG_MEMCG being enabled - it will alway=
s return
> > + * NULL if CONFIG_MEMCG is not configured.
> > + */
> > +__bpf_kfunc struct task_struct *bpf_mm_get_task(struct mm_struct *mm)
> > +{
> > +#ifdef CONFIG_MEMCG
> > +     struct task_struct *task;
> > +
> > +     if (!mm)
> > +             return NULL;
> > +     rcu_read_lock();
> > +     task =3D rcu_dereference(mm->owner);
>
> > +     if (!task)
> > +             goto out;
> > +     if (!refcount_inc_not_zero(&task->rcu_users))
> > +             goto out;
> > +
> > +     rcu_read_unlock();
> > +     return task;
> > +
> > +out:
> > +     rcu_read_unlock();
> > +#endif
>
> This #ifdeffery is horrid, can we please just have separate functions ins=
tead of
> inside the one? Thanks.
>
> > +     return NULL;
>
> So we can't tell the difference between this failling due to CONFIG_MEMCG
> not being set (in which case it will _always_ fail) or we couldn't get a
> task or we couldn't get a refcount on the task.
>
> Maybe this doesn't matter since perhaps we are only using this if
> CONFIG_MEMCG but in that case why even expose this if !CONFIG_MEMCG?
>

As suggested by Andrii, I will remove this kfunc and mark mm->owner as
BTF_TYPE_SAFE_TRUSTED_OR_NULL.

Thanks for your comments.

--=20
Regards
Yafang

