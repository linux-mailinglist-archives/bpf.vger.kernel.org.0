Return-Path: <bpf+bounces-70965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E377FBDC200
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 04:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91225401EDA
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 02:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDBF3090E0;
	Wed, 15 Oct 2025 02:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5AxxWNA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3AD3081CA
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 02:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760494384; cv=none; b=a/zycsA6XnIKa6CXWLbD7E/lLOAo6awptdJzNa3Hb8HwaU2OwO8r4QLZE0pKC4V69bwnVenZpfmhb1a+vbu+INdtsHzT+ELUHYNvpj63OtlzaL5GYbM83bgWLFVMM2nkzTbPJvf7XmeoT63r/WOgIfL2bAYdhj6eiIB2oGDFpAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760494384; c=relaxed/simple;
	bh=oJP13eB0zf/lx9zE1K6vc8NG7p+qg7wUf8++CqMlTwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StgIzrgioQ09pa0rFUZIdJeEl7bLdqPPmlc4T9GrVdad05TGZAYZz7GGP0a6qWe4Vhlg3/4OcvQpCOmqoOPwzJO9X2QKAgQZRAu+p6a6CAo5q8b+gp3P69o9JgZA1YPfOo3gTFoNz8BL3ZnwonjFlH5SoV5exveNf70aYB9PgM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5AxxWNA; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4257aafab98so5025236f8f.3
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 19:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760494380; x=1761099180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZJ0RxzbQsaIBiUFXIinzpwPD8WCaTc3WmPgE0k6JkY=;
        b=F5AxxWNAhFl8RYCekXOk90H7/Ja9LTRqUaamA2w91lpG6AGDZ9cnMyHEaUGt3ts2c4
         xj6W+30lEdU3FxNrieTH8kpfz90E8FZ/gComY2ICXW8rn0T0/PD7UhaGc99sPcTsF36D
         k6fFXZxrc+xnmdI0/ED1HSMP8jqmKI1GJBvkaPJpGgS3rAlvaMu4MrJ23KqTm3mZaVwY
         355FDNbYBtAm5neMijRw9d5EY+TfSj1tphEKEJaF2AdUDR0hC5M5laF1qjtrg4GF+d9D
         AK+PQqEvn57t000crKBZMvQmRw0NIMMq8dqvRDzMsIhxzeKoFWKYjBKPzVS9zGLOqSr6
         cfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760494380; x=1761099180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZJ0RxzbQsaIBiUFXIinzpwPD8WCaTc3WmPgE0k6JkY=;
        b=B0OsSdAb/nBM6P2EGKyly3L7ow3yXYlqzRzVxqpxk8OF9wKb4Jgdd3JxpPNnP/kaW2
         3PXK0j8ARMxZ04z6heShciRk6MGvc/QULiEi1AU9d6bKxWmbOmAiauZon7CnBrt600hw
         gQACM6L5kwRw18tKvD/IMwHIQw/bJxpzQgy5ancwU9pURPGDlD/wTIVh2olMkXt80BcI
         2RNcdpT+lLBin546S2mebFyOXFaWSBDatYXQjOV87cWmnAcaYG8NX8fxRgY+XHWsTeqh
         seGuucXj+GNSDe0uhXIS5gfiaHEnTs9DLB1B2sxAwV03btF0UddRMSs482aAINwzipER
         awoA==
X-Gm-Message-State: AOJu0Yziv4N/EyOGN6ORsRbwupU/+7OGdyDA3YwKHbYJlEX7PaJH5Ivc
	yakN2Owub/ZpYXA68b279j+6OOnExRFM6TAiEVqLl3rIZh00tjfO+8N8UpCMIJbiHx+2SmgTiKF
	jadYC9N1C7bUPUjYemLyXZk/AEhwu0EY=
X-Gm-Gg: ASbGnctFqsycMcnrgiLXNHLiVXjDUp0ExTwOEoHfBaJ4NzeEvykga7bJrccjUxPczV5
	zm4u3vJpmMpWpvUP+2RwQxIkqaNslZKPWj7JsWxE12GOMB4sjfX9Y8aAtLXll2ziAWcmZa7QVXp
	b5/jYrV5twKSFveZHVIazaNP3oaPDJie7nhGmDpx4Dv+q8KTjubeHVVfVMCT+5FadbFIyLk8Uk9
	7WNQDISJtO9gRkg2DvTs61DmtUWsFvfrFKDVHP+v/RXp1inuqTjhh+hmPM=
X-Google-Smtp-Source: AGHT+IEwYA517M0XM7y/RBDJ75Pdx2FaIZOm3jjoxpf1t30CFtaHlbZHgoUlOk6ZEcZbTczeZOv8CSaRDtbDstfleZU=
X-Received: by 2002:a05:6000:438a:b0:425:86ae:b0b with SMTP id
 ffacd0b85a97d-4266e7d9330mr19858110f8f.38.1760494379757; Tue, 14 Oct 2025
 19:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015000700.28988-1-alexei.starovoitov@gmail.com> <aO8AAD4sJA9ORlO5@hyeyoo>
In-Reply-To: <aO8AAD4sJA9ORlO5@hyeyoo>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Oct 2025 19:12:48 -0700
X-Gm-Features: AS18NWBswixMrlr5nowYRcKQlHuls29t8Ef-LXpIkHMfVAzD3LEtX_caH29NLS4
Message-ID: <CAADnVQLJ33_az3qK49PDwjh5aeSirUOuiJax+-7p2S3MKziaoA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] bpf: Replace bpf_map_kmalloc_node() with
 kmalloc_nolock() to allocate bpf_async_cb structures.
To: Harry Yoo <harry.yoo@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, Peilin Ye <yepeilin@google.com>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 6:59=E2=80=AFPM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Tue, Oct 14, 2025 at 05:07:00PM -0700, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > The following kmemleak splat:
> > [    8.105530] kmemleak: Trying to color unknown object at 0xff11000100=
e918c0 as Black
> > [    8.106521] Call Trace:
> > [    8.106521]  <TASK>
> > [    8.106521]  dump_stack_lvl+0x4b/0x70
> > [    8.106521]  kvfree_call_rcu+0xcb/0x3b0
> > [    8.106521]  ? hrtimer_cancel+0x21/0x40
> > [    8.106521]  bpf_obj_free_fields+0x193/0x200
> > [    8.106521]  htab_map_update_elem+0x29c/0x410
> > [    8.106521]  bpf_prog_cfc8cd0f42c04044_overwrite_cb+0x47/0x4b
> > [    8.106521]  bpf_prog_8c30cd7c4db2e963_overwrite_timer+0x65/0x86
> > [    8.106521]  bpf_prog_test_run_syscall+0xe1/0x2a0
> >
> > happens due to the combination of features and fixes, but mainly due to
> > commit 6d78b4473cdb ("bpf: Tell memcg to use allow_spinning=3Dfalse pat=
h in bpf_timer_init()")
> > It's using __GFP_HIGH, which instructs slub/kmemleak internals to skip
> > kmemleak_alloc_recursive() on allocation, so subsequent kfree_rcu()->
> > kvfree_call_rcu()->kmemleak_ignore() complains with the above splat.
> >
> > To fix this imbalance, replace bpf_map_kmalloc_node() with
> > kmalloc_nolock() and kfree_rcu() with call_rcu() + kfree_nolock() to
> > make sure that the objects allocated with kmalloc_nolock() are freed
> > with kfree_nolock() rather than the implicit kfree() that kfree_rcu()
> > uses internally.
> >
> > Note, the kmalloc_nolock() happens under bpf_spin_lock_irqsave(), so
> > it will always fail in PREEMPT_RT. This is not an issue at the moment,
> > since bpf_timers are disabled in PREEMPT_RT. In the future
> > bpf_spin_lock will be replaced with state machine similar to
> > bpf_task_work.
> >
> > Fixes: 6d78b4473cdb ("bpf: Tell memcg to use allow_spinning=3Dfalse pat=
h in bpf_timer_init()")
> > Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
>
> LGTM,
> Acked-by: Harry Yoo <harry.yoo@oracle.com>
>
> So we're losing benefit of batch-processing via kfree_rcu() and
> instead using call_rcu(), and I guess it's fine since it's not very
> performance critical

yes. Here freeing is not in critical path.

> so we don't have to make kfree_rcu() work with
> objects that are allocated via kmalloc_nolock()?

Not quite :) It's on the todo list.
Something like kfree_nolock_rcu() is needed, and
also SLAB_TYPESAFE_BY_RCU-like and new SLAB_TYPESAFE_BY_SRCU_FAST flag.
The plan for the upcoming merge window is to delete rcu tasks trace
and replace with srcu_fast. It will clarify next steps.

