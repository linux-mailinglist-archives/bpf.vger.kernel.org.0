Return-Path: <bpf+bounces-70579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B735BC3D00
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 10:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D61744F937B
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 08:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716EE2F3C1A;
	Wed,  8 Oct 2025 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bg3zAzwB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966E22EBDCD
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 08:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759911556; cv=none; b=k15dFaF9Cgn402Zt5Bsws9fSv0U1jWqf27c9x2F67TNbG+/FAZI7WzxrOZG1nfFFd3OtX03X9T+ETXMaQNzRFHGv1eh4kqkMJE1QtdJHHZKDth3aAI4P2jl2RB1SK3PmE0kYddCRqq/7CrDHeoHOuWqNoYKKiPs4Ko/Ec5TZRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759911556; c=relaxed/simple;
	bh=ClTqU9A4l/7rsWUJLOHQy+IbYnmpNzYl8yg1dsQSgUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkCWUDOPK6KVigI5wsyXA9nFe4VQq9EbLpNqCvoEFPNhZtlUxkV0zQKJYHPn5Tn1aAL0pa4TszlkpprhXQ4115Ku8vL0rPXf7Ku7i8ePPTCEfepeOXDqVkyFHi30psPTl+0COvTuWsbVzCWnznhoCJ4iBSBDhhBz1Z4+bB1zDjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bg3zAzwB; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-79599d65f75so58852326d6.2
        for <bpf@vger.kernel.org>; Wed, 08 Oct 2025 01:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759911553; x=1760516353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujkQmW6plJLZBDQO/36IgQfW49HabBHClJLGnLpua0c=;
        b=Bg3zAzwB14x4jGmPD5x3/F4JtBe4c6+EFtVM6qthHlQoYDBOvScBvw6trOBBf4U8Ci
         GEL8Nyds62/UGcEbBn9sGNZXRHbfzhGnWrk+VaQNXHCKC7QSce2rKRHwklU1uPmPyejF
         CUziadW82Et/oiD1lZzSoRd0aNnB7vFBdoCvcSW+nj3dWVEnUbbkC74LyWETzVd2tPk0
         JY+B2X1fQEJjNCREqAJTLge9ywbbKnRiVUcBrRf8ew6eKbgun/zIy1lInB4awc+FtV1n
         y8h9cBEHqAsYcJGma7o/jrknPz071LjmW5nn8/OmzjoFyVEOjEX9paFHOgRHGUfPk2Um
         uPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759911553; x=1760516353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujkQmW6plJLZBDQO/36IgQfW49HabBHClJLGnLpua0c=;
        b=Z7BmdOmkA0+aL+VQaZ5wV3V9bgiYD3CfES7wZO15NfsKknxUht6HrsjRIJoEQiddbT
         uW6vrp2SDwP+PrA2G9DFyD6dym4ZsVGI5WhJ+JxFv83WLFZFwMvrM9I7SCimFD2HnOp/
         jhoouo5kzoP1z3dQstPF5mxCIZnjy5bIxD0KypqFfuk64LEwx8WpLNsHZYiIY38bHciO
         BJTQ3j/TCNUYP8nmE8d4zP+rzW1ZUCKqDsU3uPQK0lJmaMdL7WuNJfGES5pfqy04eyxD
         9p6mfn+CMlUMXjq8H2aKfQ+08Tp4HP09YGfrEDuKbAZqWDZMo5kzMFvaZqkQudJoasLP
         xysw==
X-Forwarded-Encrypted: i=1; AJvYcCXn4W+1S0q+h0JlTbLS94zwDump23zUYx0peWM/MQk1uG6H4vh33dh7tkkpLGJWPulhCI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXXAsnET602Ada4C/45KYWwncrG4r9vwWJAYHDbUP9DYBIS/jG
	ZQQ8TOsEr6DDBLwiTlkzR0nZS7GX8/C2Xm8wwVpKnS5M4izcvst0cCcljm3mjcmSf1BmixL37gH
	CJn0L1opvQI7n7i14dfxKPZot4Bd5mRA=
X-Gm-Gg: ASbGnct93zUWv5eLJuvVxjEjdgGmuy1YZ1o3CoPSJHg0pVYCSnWbI+BZPVMi1O55Znb
	bgz9usaxqge0v4EiDEprARWHykuWub1NASOLglg9bq/F86LuaV0GgjoF2U0K9DXGOFeTRfPRqSk
	i2bdLLRFfxL8GnMq3i5G3/yOS50iFfaPFM6XJcYSQg4yF6pUqHhoeVT7G5i7c5FBl4kCSEtSoc+
	VZmPFCd4LJK8YfuK3qW8LR94zh1sOQceKeuEn+tBiXCDgb+cr8dgSsPi7MHUYj/Xy7TAy6LVII=
X-Google-Smtp-Source: AGHT+IHZGUO4OF/QfunpmTKIRKSgOuGmZNfsONzgXodv17mKF+pXVLfT+JBj8J2eFByzmTADYXWLJpPNEeD4YOKOEG0=
X-Received: by 2002:a05:6214:408:b0:78e:49a0:2ba4 with SMTP id
 6a1803df08f44-87b2ef9480bmr33207836d6.58.1759911553333; Wed, 08 Oct 2025
 01:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930055826.9810-1-laoar.shao@gmail.com> <20250930055826.9810-4-laoar.shao@gmail.com>
 <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com> <27e002e3-b39f-40f9-b095-52da0fbd0fc7@redhat.com>
In-Reply-To: <27e002e3-b39f-40f9-b095-52da0fbd0fc7@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 8 Oct 2025 16:18:37 +0800
X-Gm-Features: AS18NWBqVaYKWhKnTCEHPPwnoyf7n1_vwGYnsczH0QG6uK9Ydgy_AQN3Vgm1uv0
Message-ID: <CALOAHbBFNNXHdzp1zNuD530r9ZjpQF__wGWyAdR7oDLvemYSMw@mail.gmail.com>
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: David Hildenbrand <david@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, Johannes Weiner <hannes@cmpxchg.org>, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	Matthew Wilcox <willy@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Amery Hung <ameryhung@gmail.com>, David Rientjes <rientjes@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, 21cnbao@gmail.com, Shakeel Butt <shakeel.butt@linux.dev>, 
	Tejun Heo <tj@kernel.org>, lance.yang@linux.dev, Randy Dunlap <rdunlap@infradead.org>, 
	bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 4:08=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 03.10.25 04:18, Alexei Starovoitov wrote:
> > On Mon, Sep 29, 2025 at 10:59=E2=80=AFPM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> >>
> >> +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
> >> +                                     enum tva_type type,
> >> +                                     unsigned long orders)
> >> +{
> >> +       thp_order_fn_t *bpf_hook_thp_get_order;
> >> +       int bpf_order;
> >> +
> >> +       /* No BPF program is attached */
> >> +       if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> >> +                     &transparent_hugepage_flags))
> >> +               return orders;
> >> +
> >> +       rcu_read_lock();
> >> +       bpf_hook_thp_get_order =3D rcu_dereference(bpf_thp.thp_get_ord=
er);
> >> +       if (WARN_ON_ONCE(!bpf_hook_thp_get_order))
> >> +               goto out;
> >> +
> >> +       bpf_order =3D bpf_hook_thp_get_order(vma, type, orders);
> >> +       orders &=3D BIT(bpf_order);
> >> +
> >> +out:
> >> +       rcu_read_unlock();
> >> +       return orders;
> >> +}
> >
> > I thought I explained it earlier.
> > Nack to a single global prog approach.
>
> I agree. We should have the option to either specify a policy globally,
> or more refined for cgroups/processes.
>
> It's an interesting question if a program would ever want to ship its
> own policy: I can see use cases for that.
>
> So I agree that we should make it more flexible right from the start.

To achieve per-process granularity, the struct-ops must be embedded
within the mm_struct as follows:

+#ifdef CONFIG_BPF_MM
+struct bpf_mm_ops {
+#ifdef CONFIG_BPF_THP
+       struct bpf_thp_ops bpf_thp;
+#endif
+};
+#endif
+
 /*
  * Opaque type representing current mm_struct flag state. Must be accessed=
 via
  * mm_flags_xxx() helper functions.
@@ -1268,6 +1281,10 @@ struct mm_struct {
 #ifdef CONFIG_MM_ID
                mm_id_t mm_id;
 #endif /* CONFIG_MM_ID */
+
+#ifdef CONFIG_BPF_MM
+               struct bpf_mm_ops bpf_mm;
+#endif
        } __randomize_layout;

We should be aware that this will involve extensive changes in mm/. If
we're aligned on this direction, I'll start working on the patches.

--=20
Regards
Yafang

