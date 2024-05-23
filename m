Return-Path: <bpf+bounces-30352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FB88CCA3D
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 03:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FCFF1F22595
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 01:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9381869;
	Thu, 23 May 2024 01:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fymTrEui"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198381852;
	Thu, 23 May 2024 01:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716426396; cv=none; b=WTGkcyiFBAJ/XzakZMJdEjNYpCVN4RkJKYbLcxDZMc4f/jzq8eD19rbduR2/ICVu4mKi3nxQc+X1dtJeYZt4kzUdG64qfA6b7FITd24JP/OgH4/qgb/NtBXvy85r+NsYDncCN3rPf5P4s6Fs4GrCI1GWMY6LkXVLkYE6M0mzyUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716426396; c=relaxed/simple;
	bh=B5c+0KTU5O/YrZ4+uQnz57jRa5hVdrszSpRIjq0R4F4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1l9v3lTpNYmNvW4ceE2j3IfuKA29oFGjKArXruAHduioPJmcQpUMxFgMAsjdSf7QwBTjyLqnZax5iReWjM24yQhnWYtaW3YBh+y3k7ZWuZW+epRhSzPeGNx6nMlLKjxwghJRU+0aKRyLPKxw+tb4Wiypn3cM3C/bry4mDyKDFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fymTrEui; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-df4f05e5901so957208276.0;
        Wed, 22 May 2024 18:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716426394; x=1717031194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVyCC5338yhi+4vP+H2pZuPHQW7Eit3elvw2dtevr68=;
        b=fymTrEui9BjqZgyt1Xvws+tR+K6r3uOWcFnRkF7t/EQCqZzOYa3udYHsXqSAfIbk0Q
         3XbrDIIypkCK8Ys6QU7Pt8Icn0p1iSlxsUqmDR3F0ZYVx7z3bZo0BocHKCsLMxe4YttI
         4LPDzoKMFp1UQ6XPfvWr4k5mfirYWHTQJMbQkSPCyIJzCcYwfnEh2w4OlFD2+NDE7TNh
         zT2PJDuTdy8MVZBvLXA5ryOARfh1sdBJZHQmfsafDn1s4jjhNCdnbP0+23nOq6a4ayiC
         9SIqLGVvJXNRkb+PONWS15IXRRaJz2CkIZoin688L8en5vehJWrA7h7gX0yCVx+r2vjg
         W+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716426394; x=1717031194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVyCC5338yhi+4vP+H2pZuPHQW7Eit3elvw2dtevr68=;
        b=YmUpqSNX8VEo0iuiyQYJIOPaJtvKHV2BndEj4bONrBuGSSavSNeLH66B02vtC5ZJwc
         nZ4l5ZeGGwDpJaThxjazcKCn3Ya5Pp22oRhEGIIBiRex08KLHp6IOFDhWkmPUUuFVSAs
         AwQYdiLeYpx9n263WjRt/3Pye/4uNRQhHOZpuDQYdBeSqsmFRoHJCZdv+Ji/2rBmH0B5
         JAjqckjo2uIgffSTZ7geVE1Y0JHCav1wb55CVKguLrmiGI/qZauQfk8yj2oGpWDtD3Kg
         d1+pSTDeVfoXs3myk3fGdR/osxjzP5NW4+nFzkmn2tmc+Ooz+ggHTDGUvBByMjOvBYU1
         GA4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvwDtdGDEVzaBHL6pFpn5W8bYPHUlocXJbqku8SgS5FYk5wLSrCSeFmpdf/3khzFTUzhmP8DsrxigirxpjXAk1IIGIQBa+
X-Gm-Message-State: AOJu0YwtK9woy35C4TDAFitH028ezQ2tgMY1wSR0QR4qnHcU7jkPuuS0
	5JVTYjryQsidzqPXKHxD4d26SmXdWVRzkCvy8M/bmM25csiFtufCSNq7AZXzuus/ndTC3Akl+Jm
	PEX0KxusCMq3eYefXoKDEmFIV3TU=
X-Google-Smtp-Source: AGHT+IFzNk5XqknxTlVflwL8cI3I3hrQk45Zu3VfdE65WmqmXzNQyaVhmKo8t2JZbhGVgV7ZC2XIhdHcxHIgYvWpsVA=
X-Received: by 2002:a25:fa02:0:b0:df4:ab39:8c1d with SMTP id
 3f1490d57ef6-df4e0da6e12mr3621734276.46.1716426394115; Wed, 22 May 2024
 18:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
 <20240510192412.3297104-15-amery.hung@bytedance.com> <e87abee4-7dc4-4fea-bf98-499d7378acbf@linux.dev>
In-Reply-To: <e87abee4-7dc4-4fea-bf98-499d7378acbf@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 22 May 2024 18:06:23 -0700
Message-ID: <CAMB2axPPCv13NZST4Dekig9QmBAfBy3ftzXyYMzZWVK3mWj0dA@mail.gmail.com>
Subject: Re: [RFC PATCH v8 14/20] bpf: net_sched: Add bpf qdisc kfuncs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, 
	sdf@google.com, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 4:56=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 5/10/24 12:24 PM, Amery Hung wrote:
> > +BTF_KFUNCS_START(bpf_qdisc_kfunc_ids)
> > +BTF_ID_FLAGS(func, bpf_skb_set_dev)
> > +BTF_ID_FLAGS(func, bpf_skb_get_hash)
> > +BTF_ID_FLAGS(func, bpf_skb_release, KF_RELEASE)
> > +BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
> > +BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule)
>
> Thanks for working on the bpf qdisc!
>
> I want to see if we can shrink the set and focus on the core pieces first=
.
>
> The above kfuncs look ok. bpf_skb_set_dev() will need some thoughts but m=
y
> understanding is that it is also not needed if the patch set did not reus=
e the
> rb_node in the sk_buff?

Correct. I will remove this kfunc and fall back to the v7 approach
(allocating local objects to hold skb kptrs) in the next version.
Support for adding skb natively to bpf graphs can come at a later
time.

>
> > +BTF_ID_FLAGS(func, bpf_skb_tc_classify)
> > +BTF_ID_FLAGS(func, bpf_qdisc_create_child)
> > +BTF_ID_FLAGS(func, bpf_qdisc_find_class)
> > +BTF_ID_FLAGS(func, bpf_qdisc_enqueue, KF_RELEASE)
> > +BTF_ID_FLAGS(func, bpf_qdisc_dequeue, KF_ACQUIRE | KF_RET_NULL)
>
> How about starting with classless qdisc first?
>
> I also wonder if the class/hierarchy can be implemented in the
> bpf_map/bpf_rb_root/bpf_list_head alone. That aside, the patch set shows =
that
> classful qdisc is something tangible with kfuncs. The classless qdisc bpf
> support does not seem to depend on it. Unless there is something on the c=
lassful
> side that really needs to be finalized at this point, I would leave it ou=
t from
> the core pieces for now and focus on classless. Does it make sense?
>

Totally make sense! I will simplify the patchset in the next version
by making it classless. Like what you said, with bpf maps and graphs,
sophisticated & hierarchical queues can already be implemented in a
single bpf qdisc.

Just to sum up, to make the patchset landable, I will:
1) fix and keep the first 4 struct_ops patches that support acquiring/
   returning referenced kptr
2) defer the support of adding skb to bpf graphs
3) defer Qdisc_class_ops and related kfuncs

> > +BTF_KFUNCS_END(bpf_qdisc_kfunc_ids)
> > +
> > +static const struct btf_kfunc_id_set bpf_qdisc_kfunc_set =3D {
> > +     .owner =3D THIS_MODULE,
> > +     .set   =3D &bpf_qdisc_kfunc_ids,
> > +};
> > +
> > +BTF_ID_LIST(skb_kfunc_dtor_ids)
> > +BTF_ID(struct, sk_buff)
> > +BTF_ID_FLAGS(func, bpf_skb_release, KF_RELEASE)
> > +
> >   static const struct bpf_verifier_ops bpf_qdisc_verifier_ops =3D {
> >       .get_func_proto         =3D bpf_qdisc_get_func_proto,
> >       .is_valid_access        =3D bpf_qdisc_is_valid_access,
> > @@ -558,6 +781,20 @@ static struct bpf_struct_ops bpf_Qdisc_ops =3D {
> >
> >   static int __init bpf_qdisc_kfunc_init(void)
> >   {
> > -     return register_bpf_struct_ops(&bpf_Qdisc_ops, Qdisc_ops);
> > +     int ret;
> > +     const struct btf_id_dtor_kfunc skb_kfunc_dtors[] =3D {
> > +             {
> > +                     .btf_id       =3D skb_kfunc_dtor_ids[0],
> > +                     .kfunc_btf_id =3D skb_kfunc_dtor_ids[1]
> > +             },
> > +     };
> > +
> > +     ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_=
qdisc_kfunc_set);
> > +     ret =3D ret ?: register_btf_id_dtor_kfuncs(skb_kfunc_dtors,
> > +                                              ARRAY_SIZE(skb_kfunc_dto=
rs),
> > +                                              THIS_MODULE);
> > +     ret =3D ret ?: register_bpf_struct_ops(&bpf_Qdisc_ops, Qdisc_ops)=
;
> > +
> > +     return ret;
> >   }
> >   late_initcall(bpf_qdisc_kfunc_init);
>

