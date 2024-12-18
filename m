Return-Path: <bpf+bounces-47257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A87C99F6C14
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 18:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EB5188D39A
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 17:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964E41F8ACE;
	Wed, 18 Dec 2024 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6f1L1tk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8845F1547E2;
	Wed, 18 Dec 2024 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541907; cv=none; b=lY295MGhi9GylUWzfD79DVkwby1gWrLfGV7ObPSdiQ6g02xqSNE3SjZ6n/ksXFJ3MAK8QUeRFZxAi+WKGam8K3pMKRCHBzgPj0CITgCwpvGMd5IPHMkAmY8/EukSMxBEuOSEwJoaBSTS5CVEwD0dhI7Mo64sLqtPVIxkVNBCNko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541907; c=relaxed/simple;
	bh=QkG5146bo0CGwDE8nvoN/ET4BKac5LPli9otqYJB3wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0OeDMmLOzwKyARpE3PW4XTndpvY1b4WqSIlndFLk5yF6uRO1AGdZVYZwIESEvCFMgCkcP6v0uYa2gF7bCWP3ETKe3iOMVrnPlabSRyoxr7US1JiVKNoElK4HejGSs6VgzJmaxiBvNFa+mwhoR+AEsR74yv5z/dsM4Wv32seo7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6f1L1tk; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e460717039fso3813844276.0;
        Wed, 18 Dec 2024 09:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734541904; x=1735146704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVsLO/ozQKiYb6Yyt2h8xhdm9zIQgU0/l+fMFmEPNd0=;
        b=c6f1L1tkqOT6e2SI6W8swOpmUgq3kMAdrhItCWT9PYsqTJrmtiRULGk3CHgJcFs7JQ
         EKfEoJQCixyNvlHuwlq6ghKsfXR/lUNB4UqUWlQLC2lZoPvW3KDTDTf+elf2oJNCNqt9
         2dQeLRp6WiOw/VuDfs9Vfw3bhXYPp+qkjqXHN9qNdhwMRbBE6mnk5TMECaWju8IguzzB
         +ur03IVaD9VLe5SGa9niMEM/o0axtHWd/SwydyUfJFYehrAwdMUeSukDDcFGN0MYpHj3
         w0yXvgVoZb4Ov6YcO/AKA6Ok6YoBqQ8qT6uLVlOysDcrM7af0qkh+55mz86q3BRnQd5V
         99kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734541904; x=1735146704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVsLO/ozQKiYb6Yyt2h8xhdm9zIQgU0/l+fMFmEPNd0=;
        b=phgk59CNx7tRWzY4ZW1N26U51Ue9o4f2+yyUN+MtQH3RpqcMKaiHA9DME+UhpA4T3R
         6BFSi18fTgEynFI+KWUHXLVL0AskH6valHNIogyLkqctfYjoFBvxrdZSlcZFdMnp+W7Z
         E2pv5bjE2/aUFbxfcAcGP1L9iMfqOJVZ8cymuVa5L+0yxCnCFMkQ15rcbSpyYzV5BnPk
         kcapSrRu1BBrkmoC6nsPWjLi6zI+KSjeNF98Pf6WiZ16S0w73JGjX4m2cB3iab9h1F2I
         ZqjJIQV6HpcsVqr4/PvUbGEw1BRCxGNNh/nLwBUuOMkuN6N2ag8POQpLm1zl9bH7P+Py
         ZPiA==
X-Forwarded-Encrypted: i=1; AJvYcCXMxvm9chQ55OGleYVgtvaCQYeha8md9CvNZYkI3hWU1FnN8Q9yzMysHzu4WuqZwJEQu0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzBrFEuey+ct0WOQo/0uObccSEoEGbxiEa6NBMQxye8zMQyHts
	qVuYBFYIL9yh3kolCl3pfH1mZEinviaoUqySlRa3+USziZsvQJBpEaFFiyiPcawr8VKVJCeuCK+
	vSMCo1YlqqZa0dsJ6jGg3GG+rWjI=
X-Gm-Gg: ASbGnctFwZr1Te9tsH5OAiR5PCeGro1AwRG5tlmNLdkkjsBgPSiEK6V5SETEdE9R0kC
	BQffFUGy4bp1f1grIQAYNFi/PSLnA9yHqtokQeXA=
X-Google-Smtp-Source: AGHT+IHSLxJlpM+8bOvZ/JV/KfwUtQ0DrNWOkukcuMbp0ROa4IYqHfvTVZO0OueFIbmsNr2qX/oKrfzzkusip4+MN3s=
X-Received: by 2002:a05:690c:6386:b0:6ef:4a57:fc98 with SMTP id
 00721157ae682-6f3e1b5bb0fmr5183097b3.16.1734541904328; Wed, 18 Dec 2024
 09:11:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213232958.2388301-1-amery.hung@bytedance.com> <20241213232958.2388301-7-amery.hung@bytedance.com>
In-Reply-To: <20241213232958.2388301-7-amery.hung@bytedance.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 18 Dec 2024 09:11:32 -0800
Message-ID: <CAMB2axPioMoEwLAH4y-nPjYngq_+uv5PiaO=708rS98=t8dEvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 06/13] bpf: net_sched: Add basic bpf qdisc kfuncs
To: Amery Hung <amery.hung@bytedance.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org, 
	sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, 
	stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br, 
	yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 3:30=E2=80=AFPM Amery Hung <amery.hung@bytedance.co=
m> wrote:
>
> Add basic kfuncs for working on skb in qdisc.
>
> Both bpf_qdisc_skb_drop() and bpf_kfree_skb() can be used to release
> a reference to an skb. However, bpf_qdisc_skb_drop() can only be called
> in .enqueue where a to_free skb list is available from kernel to defer
> the release. bpf_kfree_skb() should be used elsewhere. It is also used
> in bpf_obj_free_fields() when cleaning up skb in maps and collections.
>
> bpf_skb_get_hash() returns the flow hash of an skb, which can be used
> to build flow-based queueing algorithms.
>
> Finally, allow users to create read-only dynptr via bpf_dynptr_from_skb()=
.
>
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---
>  net/sched/bpf_qdisc.c | 77 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 1 deletion(-)
>
> diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> index a2e2db29e5fc..28959424eab0 100644
> --- a/net/sched/bpf_qdisc.c
> +++ b/net/sched/bpf_qdisc.c
> @@ -106,6 +106,67 @@ static int bpf_qdisc_btf_struct_access(struct bpf_ve=
rifier_log *log,
>         return 0;
>  }
>
> +__bpf_kfunc_start_defs();
> +
> +/* bpf_skb_get_hash - Get the flow hash of an skb.
> + * @skb: The skb to get the flow hash from.
> + */
> +__bpf_kfunc u32 bpf_skb_get_hash(struct sk_buff *skb)
> +{
> +       return skb_get_hash(skb);
> +}
> +
> +/* bpf_kfree_skb - Release an skb's reference and drop it immediately.
> + * @skb: The skb whose reference to be released and dropped.
> + */
> +__bpf_kfunc void bpf_kfree_skb(struct sk_buff *skb)
> +{
> +       kfree_skb(skb);
> +}
> +
> +/* bpf_qdisc_skb_drop - Drop an skb by adding it to a deferred free list=
.
> + * @skb: The skb whose reference to be released and dropped.
> + * @to_free_list: The list of skbs to be dropped.
> + */
> +__bpf_kfunc void bpf_qdisc_skb_drop(struct sk_buff *skb,
> +                                   struct bpf_sk_buff_ptr *to_free_list)
> +{
> +       __qdisc_drop(skb, (struct sk_buff **)to_free_list);
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +#define BPF_QDISC_KFUNC_xxx \
> +       BPF_QDISC_KFUNC(bpf_skb_get_hash, KF_TRUSTED_ARGS) \
> +       BPF_QDISC_KFUNC(bpf_kfree_skb, KF_RELEASE) \
> +       BPF_QDISC_KFUNC(bpf_qdisc_skb_drop, KF_RELEASE) \
> +
> +BTF_KFUNCS_START(bpf_qdisc_kfunc_ids)
> +#define BPF_QDISC_KFUNC(name, flag) BTF_ID_FLAGS(func, name, flag)
> +BPF_QDISC_KFUNC_xxx
> +#undef BPF_QDISC_KFUNC
> +BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
> +BTF_KFUNCS_END(bpf_qdisc_kfunc_ids)
> +
> +#define BPF_QDISC_KFUNC(name, _) BTF_ID_LIST_SINGLE(name##_ids, func, na=
me)
> +BPF_QDISC_KFUNC_xxx
> +#undef BPF_QDISC_KFUNC
> +
> +static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc=
_id)
> +{

Here is a null pointer dereference since prog->aux->attach_func_name
is not populated yet during check_cfg(). I will add:

        if (!btf_id_set8_contains(&bpf_qdisc_kfunc_ids, kfunc_id) ||
            !prog->aux->attach_func_name)
                return 0;

> +       if (kfunc_id =3D=3D bpf_qdisc_skb_drop_ids[0])
> +               if (strcmp(prog->aux->attach_func_name, "enqueue"))
> +                       return -EACCES;
> +
> +       return 0;
> +}
> +
> +static const struct btf_kfunc_id_set bpf_qdisc_kfunc_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set   =3D &bpf_qdisc_kfunc_ids,
> +       .filter =3D bpf_qdisc_kfunc_filter,
> +};
> +
>  static const struct bpf_verifier_ops bpf_qdisc_verifier_ops =3D {
>         .get_func_proto         =3D bpf_qdisc_get_func_proto,
>         .is_valid_access        =3D bpf_qdisc_is_valid_access,
> @@ -209,6 +270,20 @@ static struct bpf_struct_ops bpf_Qdisc_ops =3D {
>
>  static int __init bpf_qdisc_kfunc_init(void)
>  {
> -       return register_bpf_struct_ops(&bpf_Qdisc_ops, Qdisc_ops);
> +       int ret;
> +       const struct btf_id_dtor_kfunc skb_kfunc_dtors[] =3D {
> +               {
> +                       .btf_id       =3D bpf_sk_buff_ids[0],
> +                       .kfunc_btf_id =3D bpf_kfree_skb_ids[0]
> +               },
> +       };
> +
> +       ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_=
qdisc_kfunc_set);
> +       ret =3D ret ?: register_btf_id_dtor_kfuncs(skb_kfunc_dtors,
> +                                                ARRAY_SIZE(skb_kfunc_dto=
rs),
> +                                                THIS_MODULE);
> +       ret =3D ret ?: register_bpf_struct_ops(&bpf_Qdisc_ops, Qdisc_ops)=
;
> +
> +       return ret;
>  }
>  late_initcall(bpf_qdisc_kfunc_init);
> --
> 2.20.1
>

