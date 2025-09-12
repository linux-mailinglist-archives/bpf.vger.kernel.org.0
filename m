Return-Path: <bpf+bounces-68216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A12B54465
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 10:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C96585460
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 08:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079A22D6E4C;
	Fri, 12 Sep 2025 08:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+QxmWp9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB72D3EDA
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757664251; cv=none; b=Z78yib9yJSmL79AE+2i6cYX/C//a7v+TbzyMzXphaDJvZR8hMEWQKZUq7l/50bFD0q7gWtd21PJD6HLhL9ZcKyQf0u/e5dyXsijbCXnrzRt/KlQVcqaCAkG2sVmcpYs9sFx7EWrT1eAtg/Siu7bA1m/5/gxzmF16uTTDjhZZgdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757664251; c=relaxed/simple;
	bh=+gT7jsG1PqPXYNJ0px+020KWTHBR9gaaZ4whEKKLr9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gpIAuQDW7L0qLTWI5Z/wBU0oCXwEv34r5HroVpu86XwcQFkdjz/rMaFrm2N1oLCYD9ZsMBz0aVlb1eoznFXoxZc9xVBXBQ5O7ysykbhUoTM13/VDsXqc6iKR+50ThTgZgVqATEp0nfBNZq0yVjCDbggWgt2z8DKr+cWdkenjLdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+QxmWp9; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-80e4cb9d7ceso197928885a.1
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 01:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757664249; x=1758269049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9kzsA//wpYq4jCc4/cU2xPStiaIfnlqm31u2FS1/80=;
        b=V+QxmWp90zqdBm/9lAR1QzilrD3mfiJjXwSJDbfd078xAd35UQ8LkybpsciFrUBFBL
         uulAf83GQO9AcO73kTbiOm1621pMuSVR/U4omlq226DVPO8PQLt0XgHC6YirvFh+IXGh
         QZNsIwFwn8fyeFGUp9N1pTexGA0xRqy3xlA7KGtpL+VZ1LYoylfcbUaFXgdoRwNgBJb9
         01osOz0XnE6h8CbDDkRLUKN0rWCni8D+gH2Tl/7n4e2xu2nXMR7snllOQN1EzSZgWyWh
         qLVuz+3KEqJOnXKgYAXqHDmMRZms9ZE5eTUJbMEFle1K47IyCicOZkzs9Z5Kvxo0dCu9
         Ft0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757664249; x=1758269049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9kzsA//wpYq4jCc4/cU2xPStiaIfnlqm31u2FS1/80=;
        b=mdF5FPVymEvGr9WIkXZsxJOfgWTJvrnHj5djytJlDGe+4z4PKf0uPxnO8b/W0uSSIZ
         h0FcMtEK+JeKGgDm/AMSl+1dDO5hrUumJsuuIjbS0FyKHTTx2LnqPAE3sYc2ty5sI6GM
         2pJOAZej+pbuoza55zxFMkGW6crZEyNBvgJTDBnQLqb2daJxvS5Z/M49jHrVRnY0B4Z/
         kSgBwwJ2XQ4pEeulFb+I9d8AXsF6cUdqpCJBwlJ+jCCWLaKYRyUa3yBvB0kYyupqeLo8
         x3rBoEUQuJMye9Tu9MB3Ehmnox0KeVrxueKCdO+ihuXec+CgeDfOJW6oznlLN4dJQVqH
         zL0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwYtwuv6DfxMl2lIYQjdSy3pXysrsmhDn99P/eD1IOUhEO9BytkP7FonBt2qtXCes8uK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk/4ZUCD1S9ckM1vnBlMVfzS9Fw2VN6tpz8FQ6+cb/p8Y0eGpz
	s63ofz1go4GyK00dvsfxQmPg9/R5f3+m7Sl6/PVc48/mnpVCKQcpNUiBWOisLvFSTBg1qBCx6cV
	7QoYc1CiYP2rJ+JHjdHZenemAuHuDpdA=
X-Gm-Gg: ASbGncs0Uju0aU2ZoQxKFzFFYCbQ1vtOOZl60uRrA6Jq7umim6/6pCw5hgB0kzwhjbe
	pxwtVuYlBZ40jdjL+Bu9J+irJLSZALCpaTRJfuHMCR8I6yjPxXQR4gA8GVshGgm9qI0Bw++tknv
	50sArMA67yIq6nh3JbpGASE7Wa2ipnOccsUlmwdL0DQsvofrJm3GiaBOEc4K5ct+wo8bVdyFEcC
	eRpG+hS+JDtI1/xQKdY5deWFk3adsSHDea5dAHDLYvHzq6B7o4=
X-Google-Smtp-Source: AGHT+IE/rRxj5RfD+jcO6rOLKI2X4Bc67cmPj4n4+LR7XsAcv1UA2oLigMwdjougFZk3BL3ls1kQK8Z3ivxUUHKV+3w=
X-Received: by 2002:a05:620a:a203:b0:800:e534:ea6c with SMTP id
 af79cd13be357-82400c2387dmr234122085a.77.1757664248706; Fri, 12 Sep 2025
 01:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910024447.64788-1-laoar.shao@gmail.com> <20250910024447.64788-3-laoar.shao@gmail.com>
 <c7cc3203-502e-4cdb-ade0-25fb9381d0f4@lucifer.local>
In-Reply-To: <c7cc3203-502e-4cdb-ade0-25fb9381d0f4@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 12 Sep 2025 16:03:32 +0800
X-Gm-Features: AS18NWAnNXCrtGWtqD9eMTIlF1-Sphloom2BXF1qQB73hQgvHSaCJsTjlL9fzZc
Message-ID: <CALOAHbDYv5wCj=s3KPWa4DOPhhHLA7Mx8UiHUD3T_bfFQiWmhw@mail.gmail.com>
Subject: Re: [PATCH v7 mm-new 02/10] mm: thp: add support for BPF based THP
 order selection
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 10:51=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Sep 10, 2025 at 10:44:39AM +0800, Yafang Shao wrote:
> > diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
> > new file mode 100644
> > index 000000000000..525ee22ab598
> > --- /dev/null
> > +++ b/mm/huge_memory_bpf.c
>
> [snip]
>
> > +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
> > +                                   vm_flags_t vma_flags,
> > +                                   enum tva_type tva_type,
> > +                                   unsigned long orders)
> > +{
> > +     thp_order_fn_t *bpf_hook_thp_get_order;
> > +     unsigned long thp_orders =3D orders;
> > +     enum bpf_thp_vma_type vma_type;
> > +     int thp_order;
> > +
> > +     /* No BPF program is attached */
> > +     if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> > +                   &transparent_hugepage_flags))
> > +             return orders;
> > +
> > +     if (vma_flags & VM_HUGEPAGE)
> > +             vma_type =3D BPF_THP_VM_HUGEPAGE;
> > +     else if (vma_flags & VM_NOHUGEPAGE)
> > +             vma_type =3D BPF_THP_VM_NOHUGEPAGE;
> > +     else
> > +             vma_type =3D BPF_THP_VM_NONE;
> > +
> > +     rcu_read_lock();
> > +     bpf_hook_thp_get_order =3D rcu_dereference(bpf_thp.thp_get_order)=
;
> > +     if (!bpf_hook_thp_get_order)
> > +             goto out;
> > +
> > +     thp_order =3D bpf_hook_thp_get_order(vma, vma_type, tva_type, ord=
ers);
> > +     if (thp_order < 0)
> > +             goto out;
> > +     /*
> > +      * The maximum requested order is determined by the callsite. E.g=
.:
> > +      * - PMD-mapped THP uses PMD_ORDER
> > +      * - mTHP uses (PMD_ORDER - 1)
> > +      *
> > +      * We must respect this upper bound to avoid undefined behavior. =
So the
> > +      * highest suggested order can't exceed the highest requested ord=
er.
> > +      */
> > +     if (thp_order <=3D highest_order(orders))
> > +             thp_orders =3D BIT(thp_order);
>
> OK so looking at Lance's reply re: setting 0 and what we're doing here in
> general - this seems a bit weird to me.
>
> Shouldn't orders be specifying a _mask_ as to which orders are _available=
_,
> rather than allowing a user to specify an arbitrary order?
>
> So if you're a position where the only possible order is PMD sized, now t=
his
> would let you arbitrarily select an mTHP right? That does no seem correct=
.
>
> And as per Lance, if we cannot satisfy the requested order, we shouldn't =
fall
> back to available orders, we should take that as a signal that we cannot =
have
> THP at all.
>
> So shouldn't this just be:
>
>         thp_orders =3D orders & BIT(thp_order);

That's better.  I will change it.

--=20
Regards
Yafang

