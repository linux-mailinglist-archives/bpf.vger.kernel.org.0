Return-Path: <bpf+bounces-54069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BA0A61C48
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 21:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D078E4606FC
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 20:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651A52046B5;
	Fri, 14 Mar 2025 20:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz83SmDt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298F21FCF53;
	Fri, 14 Mar 2025 20:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983264; cv=none; b=nnkZ6j4DmqwPevot6KCOZQOxzph6uO7dX/+/pOR7VqyyvUDuoPF0vBRKBuCWdCpwjy8N7giKwswNW4zao9VgL2e7/h4C5GWzW8EAgHdFJ8CCWHFvVZTbOcYOBdKBoMkgwGj7Ni1jXjeEvACl76XoBTmkXzHlH8/UZ67fBsmwUNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983264; c=relaxed/simple;
	bh=9dAeYi9kJ2AtXm/I29WGA0JurNcBoVhJni+4GXQ0KlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIiDuQ+SFT20yhfx4a5FGJ8lp/gKn7OAmzFijZp36A3GydeCjgcm4jkqHNSiiwWLb1GX0aSyncN1uLm4GYRNEX0oul3bJ9+PxIrSS/lWzPD3pUQz1MW59UpcOCjmacyiPCFgOIAtw516DYG1LOnpqykXfk4hRmarguvq2fspmZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gz83SmDt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso1166925e9.1;
        Fri, 14 Mar 2025 13:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741983260; x=1742588060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qj9v1HE5z2Yqau3OQQwvIyD70JeYbmSGWo9Kb0rlOto=;
        b=gz83SmDty5vMNxK+5F+grYWWdGkGoTO8Et7FALb0dErFwGwgnyn65pD44SXQ40JBik
         mnn25PXldu/zvxNWzaySPX4VkvWLrTAaosDqxDRKLWHJzS2XzY3yE5IfHCG6n/VFpFO7
         Pevz+qCtFqCsJDzGxWn2NGGr9yKgdjlrl8Ssl1QjSxmU2nznIJGarZFmptZk2aDN5tTd
         rOej8qNnPCNdZRTBoeMI+nq7OSTj9gE5Suq7XaMelYiL16HjOkpY4QujEolKGifRcXxp
         pA/GgDvobd+sJfJiYZx8+LNPcVvUV2j3Ppb4JvUruxv0ORx8EhxSX/ZzpnEp0D1OyWmX
         mZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741983260; x=1742588060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qj9v1HE5z2Yqau3OQQwvIyD70JeYbmSGWo9Kb0rlOto=;
        b=osKUJOZqg6P9OcfaqbrqeRaBrgo1LFuKnjOWqMfAgv+v2apkc992z5O+ri2k1Hj9mR
         lVo870q3kQCXmc1ZDaYvrAcjAywRX1u47PulJbLnBUptO45/qQEzPDRTauVaj2EJgP/r
         BMqD8jKxmQ3GLRdheF4e8cowdaEay1tKOmFLjl+kR2aO7sToU4ZKq6WC/JTFlMg6Mefb
         XJWWw+Bf9qUUpeB/uDR06AkRnFZ6TYLzVWeZEqG407pA/mQiZwv+tuywYna4p9CJqzEq
         QtLYfQzlRTbDpCPEs6Bs0zMZB0Au61PsXyqpXT9E5tT343o2SzRsf3j3oExZ+qiW5RUu
         JjTw==
X-Forwarded-Encrypted: i=1; AJvYcCWDAsKZAIrMnkujEyoq3ipAoSNmhZNdI2eq7PVWPGz03cDfnzvrcUC7XtuhOl24PN246xg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Dz+LERWs8MrFCI2lntciJx9esW6UE+7D9sxwZZG1gFSc9ABX
	0YtEJj0GVkCfDBS0CGODrsMFLMxP1ZSa0QdeDDqxfHBuSRD1tZRyh8vcaMR2GQYLrsfisSgNung
	6s5C3gwh7nVc6VbEIXLk++yT2wpM=
X-Gm-Gg: ASbGnct35jCzYH5Cr3CpzPQYMGXgMW4XdAZ4DOdI25HYQJC5XksZzRL/whluaxXwj4S
	srJNaMn5l1N/RtFjRu+lPImZgqPLDCmhVdO3BL05ICF3MHQrdXp+MyEnKIN5f/BSM+8HIu62Jfv
	EmBqRW6nLm57qW8mk4U+PXgO6cYTKiqAXDJdK+leUXlw==
X-Google-Smtp-Source: AGHT+IE6xYbTIMwbLh/WOv3yVOJXyIl9GqFbtoPINP4OGbUFoO15Grf46C3MylZ2OBC4ywvnzVZwK1YVdYMV8cvOJT4=
X-Received: by 2002:a05:600c:34d0:b0:43c:fe15:41c9 with SMTP id
 5b1f17b1804b1-43d25479656mr5244955e9.9.1741983259888; Fri, 14 Mar 2025
 13:14:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313190309.2545711-1-ameryhung@gmail.com> <20250313190309.2545711-5-ameryhung@gmail.com>
In-Reply-To: <20250313190309.2545711-5-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Mar 2025 13:14:08 -0700
X-Gm-Features: AQ5f1Jo6WfyJBqsW67Ac4GZ0QtOD7HYNEgTQ331EfvmNB_STdkjl1qrJZmZTp7w
Message-ID: <CAADnVQ+ayU=H0gzFdh5Yfx=Aya4PXUJYvQoOXb+4=wsgmnnDQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 04/13] bpf: net_sched: Add basic bpf qdisc kfuncs
To: Amery Hung <ameryhung@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Kui-Feng Lee <sinquersw@gmail.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Stanislav Fomichev <stfomichev@gmail.com>, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	Peilin Ye <yepeilin.cs@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 12:03=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> From: Amery Hung <amery.hung@bytedance.com>
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
>  include/linux/bpf.h         |  1 +
>  kernel/bpf/bpf_struct_ops.c |  2 +
>  net/sched/bpf_qdisc.c       | 93 ++++++++++++++++++++++++++++++++++++-
>  3 files changed, 95 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 463e922cb0f5..d3b0c4ccaebf 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1826,6 +1826,7 @@ struct bpf_struct_ops {
>         void *cfi_stubs;
>         struct module *owner;
>         const char *name;
> +       const struct btf_type *type;
>         struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
>  };

there is an alternative to this...

> +static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc=
_id)
> +{
> +       if (bpf_Qdisc_ops.type !=3D btf_type_by_id(prog->aux->attach_btf,
> +                                                prog->aux->attach_btf_id=
))
> +               return 0;
> +
> +       /* Skip the check when prog->attach_func_name is not yet availabl=
e
> +        * during check_cfg().
> +        */
> +       if (!btf_id_set8_contains(&qdisc_kfunc_ids, kfunc_id) ||
> +           !prog->aux->attach_func_name)
> +               return 0;
> +
> +       if (bpf_struct_ops_prog_moff(prog) =3D=3D offsetof(struct Qdisc_o=
ps, enqueue)) {
> +               if (btf_id_set_contains(&qdisc_enqueue_kfunc_set, kfunc_i=
d))
> +                       return 0;
> +       }

Instead of logic in this patch and patch 2,
I think it's cleaner to do:
https://lore.kernel.org/all/AM6PR03MB50804BE76B752350307B6B4C99C22@AM6PR03M=
B5080.eurprd03.prod.outlook.com/

then in this patch it will be

if (prog->aux->st_ops !=3D &bpf_Qdisc_ops)

and instead of unchecked array accesses in bpf_struct_ops_prog_moff()
it will be prog->aux->attach_st_ops_member_off

Also see flag based approach in Juntong's patch 3+4.
imo it looks cleaner (more extensible with more checks per st_ops hook)
than offsetof() approach above.

