Return-Path: <bpf+bounces-36115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091D594253E
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 06:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8769A1F22B7F
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 04:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD371B5AA;
	Wed, 31 Jul 2024 04:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc8QhXxi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6A217C77;
	Wed, 31 Jul 2024 04:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722398940; cv=none; b=BAJQXu110/UHzqLLLDu809H6ma6r8J2PG/NYxbdQcSKHdhg9mzNCYeSoLf5xv0uP+6njsGQaFMsvMgqsaFneLRw6UjlC4sSE0LC5XbZ6F9LIIoRl4/24uouH7f8n9gJx7hICfH6BM4JZN6V7OZb0ddmToYoITgIpFXQa42MN5Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722398940; c=relaxed/simple;
	bh=KMAOpm5U0m4hl5C4y/b8ehaGRf4H3NJ3EHY5zZny3h4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EiV9LymQSWBshfq/0xeMp3cEN+AuURx0aYgoy6/0bdVAaKYbZmdz5imUmkHWEYmRtEThuVhNoDOb9fjsJLQSNvA4ZTrYeHhGkXKpjTqwD3FxDovVNSIlM5zcZ5VJFwkT2UrwEdImq+f/wlRAo7JahXzu8i/L3ORprEoSfNM13LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hc8QhXxi; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-66526e430e0so40748077b3.2;
        Tue, 30 Jul 2024 21:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722398937; x=1723003737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XT2u7pA/HlId5gFgJjU2gH/LOR1UKAsDl58MCOCyr0=;
        b=Hc8QhXxiyefrrLlpt/PB/rW9qwp8rIg3MPEkyP66YTgt8CBqGNw7LkQ4vCUSTQvQ/H
         lMmm+OcnF71TcFTaLuqvvK9GSkkSbJcssbu2ZOhwdKicv5OWiz32XcsvBj7sBM3J929O
         slBFA4dB1/2bAXSI+aJAKOcA4ZE/5yAvwdISGVq/2lOXLz7xZbtS2ewdiheI93tqG/9I
         Ucu0uPRdMPkLUcbrQ6XeHvboIgTOeINoDYN8loHFX/2MytSdMi2BgI+ietdwv/dLdX77
         34RCryDUiKLpFoHDct5tEqa5bVtVzQGW0D3DeQxfw9E6mTNLD0vae2o0THo8ymFfdmH1
         jEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722398937; x=1723003737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XT2u7pA/HlId5gFgJjU2gH/LOR1UKAsDl58MCOCyr0=;
        b=Wbl/KG+tXoYIoNBXzUHSpQ9D0iz7VOwPDAQRj8W4cDEOje4daIltupcIrRAqdcmsaa
         0euViH8mLesijL2KUHoe8VZ9TkvdYLZ8MDBHJtbZf3irbmQ8vlu/UCVON/NQ3xml6SF6
         KPyJwZnpehMkcuvI2jfziljglTgNgREtnzeJMd1BP9RL/ZJqB7II9RKTx98okmyRtrJ2
         AQUheSoi5QaqSo1bJwenwfjE/p9E+yTIpH5yeeRPZmypg9B7UBdzirHXH/uUaiDe2UpS
         UO8kc5e0AA/K+GrB1EOrUWZ2TsDg5paZthWou8YZdrLW6kTd5aOp23f/XRj/chBilOFg
         TuLg==
X-Forwarded-Encrypted: i=1; AJvYcCXeplIA6IEvmr6tWIg/cVP7Mzbpa+SB6Uzrw7HJSewQasAWQHkhWF7bki5/AsvMEGA2M3oxoKMpQmCg24BmSO0BSXYi3kIT
X-Gm-Message-State: AOJu0YxG1OdZIoFgFWF7cA2Yz94hQNi/pQ4D46Q18xVH3f9mD1Fpu0DF
	7cHmkNC/HstF444BIBMNH7CW1BZ8gZ9jJotIAMw/jK+FT9PNdRtXVlLQbl4OSEb6KeENE5KYCTz
	e3sgpnPmvfgEmmCuUuiRNaIxtJQ6UKQ==
X-Google-Smtp-Source: AGHT+IEL/9gXqa8QJopq9kDvxzVEANoVV0CXzc8HY5lQ+gD5z0bwBaHsJOxASBL1MH9BSrk+rU4zd4cnQdvqxe9WtCg=
X-Received: by 2002:a05:6902:c12:b0:e0b:4dce:98 with SMTP id
 3f1490d57ef6-e0b5447b08emr13274326276.20.1722398937543; Tue, 30 Jul 2024
 21:08:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240714175130.4051012-7-amery.hung@bytedance.com> <47a1dae1-7196-4991-b008-b50fb92fd5c3@linux.dev>
In-Reply-To: <47a1dae1-7196-4991-b008-b50fb92fd5c3@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 30 Jul 2024 21:08:46 -0700
Message-ID: <CAMB2axMi6eGyQP94DXkC_EOY3nHOt=9mLTYkqae-JDPV9PmcLw@mail.gmail.com>
Subject: Re: [RFC PATCH v9 06/11] bpf: net_sched: Add bpf qdisc kfuncs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 3:39=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 7/14/24 10:51 AM, Amery Hung wrote:
> > Add kfuncs for working on skb in qdisc.
> >
> > Both bpf_qdisc_skb_drop() and bpf_skb_release() can be used to release
> > a reference to an skb. However, bpf_qdisc_skb_drop() can only be called
> > in .enqueue where a to_free skb list is available from kernel to defer
>
> Enforcing the bpf_qdisc_skb_drop() kfunc only available to the ".enqueue"=
 is
> achieved by the  "struct bpf_sk_buff_ptr" pointer type only available to =
the
> ".enqueue" ops ?

Yes. I assume it will be better to make this availability check
explicit using the .filter you mentioned.

>
> > the release. Otherwise, bpf_skb_release() should be used elsewhere. It
> > is also used in bpf_obj_free_fields() when cleaning up skb in maps and
> > collections.
> >
> > bpf_qdisc_schedule() can be used to schedule the execution of the qdisc=
.
> > An example use case is to throttle a qdisc if the time to dequeue the
> > next packet is known.
> >
> > bpf_skb_get_hash() returns the flow hash of an skb, which can be used
> > to build flow-based queueing algorithms.
> >
> > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > ---
> >   net/sched/bpf_qdisc.c | 74 ++++++++++++++++++++++++++++++++++++++++++=
-
> >   1 file changed, 73 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> > index a68fc115d8f8..eff7559aa346 100644
> > --- a/net/sched/bpf_qdisc.c
> > +++ b/net/sched/bpf_qdisc.c
> > @@ -148,6 +148,64 @@ static int bpf_qdisc_btf_struct_access(struct bpf_=
verifier_log *log,
> >       return 0;
> >   }
> >
> > +__bpf_kfunc_start_defs();
> > +
> > +/* bpf_skb_get_hash - Get the flow hash of an skb.
> > + * @skb: The skb to get the flow hash from.
> > + */
> > +__bpf_kfunc u32 bpf_skb_get_hash(struct sk_buff *skb)
> > +{
> > +     return skb_get_hash(skb);
> > +}
> > +
> > +/* bpf_skb_release - Release an skb reference acquired on an skb immed=
iately.
> > + * @skb: The skb on which a reference is being released.
> > + */
> > +__bpf_kfunc void bpf_skb_release(struct sk_buff *skb)
> > +{
> > +     consume_skb(skb);
>
> snippet from the comment of consume_skb():
>
>   *      Functions identically to kfree_skb, but kfree_skb assumes that t=
he frame
>   *      is being dropped after a failure and notes that
>
> consume_skb() has a different tracepoint from the kfree_skb also. It is b=
etter
> not to confuse the tracing.
>
> I think at least the Qdisc_ops.reset and the btf_id_dtor_kfunc don't fall=
 into
> the consume_skb(). May be useful to add the kfree_skb[_reason?]() kfunc a=
lso?
>

I see. I will change bpf_skb_release() from using consume_skb() to
kfree_skb() (existing qdiscs are not using skb_drop_reason). The skb
cleanup mechanism when .reset is called can use rtnl_kfree_skbs().

> > +}
> > +
> > +/* bpf_qdisc_skb_drop - Add an skb to be dropped later to a list.
> > + * @skb: The skb on which a reference is being released and dropped.
> > + * @to_free_list: The list of skbs to be dropped.
> > + */
> > +__bpf_kfunc void bpf_qdisc_skb_drop(struct sk_buff *skb,
> > +                                 struct bpf_sk_buff_ptr *to_free_list)
> > +{
> > +     __qdisc_drop(skb, (struct sk_buff **)to_free_list);
> > +}
> > +
> > +/* bpf_qdisc_watchdog_schedule - Schedule a qdisc to a later time usin=
g a timer.
> > + * @sch: The qdisc to be scheduled.
> > + * @expire: The expiry time of the timer.
> > + * @delta_ns: The slack range of the timer.
> > + */
> > +__bpf_kfunc void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 ex=
pire, u64 delta_ns)
> > +{
> > +     struct bpf_sched_data *q =3D qdisc_priv(sch);
> > +
> > +     qdisc_watchdog_schedule_range_ns(&q->watchdog, expire, delta_ns);
> > +}
> > +
> > +__bpf_kfunc_end_defs();
> > +
> > +BTF_KFUNCS_START(bpf_qdisc_kfunc_ids)
> > +BTF_ID_FLAGS(func, bpf_skb_get_hash)
>
> Add KF_TRUSTED_ARGS. Avoid cases like getting a skb from walking the skb-=
>next
> for now.

Good point. Will do.




>
> > +BTF_ID_FLAGS(func, bpf_skb_release, KF_RELEASE)
> > +BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
> > +BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule)
>
> Also add KF_TRUSTED_ARGS here.
>
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
> > @@ -347,6 +405,20 @@ static struct bpf_struct_ops bpf_Qdisc_ops =3D {
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

