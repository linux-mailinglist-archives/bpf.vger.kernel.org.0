Return-Path: <bpf+bounces-54070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B16DA61C73
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 21:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70626189EA12
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 20:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4DC204873;
	Fri, 14 Mar 2025 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGaX+eqe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD461EA7C9;
	Fri, 14 Mar 2025 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983863; cv=none; b=pBXLsZ3UMZ8Hw+YWZHK7O1iu+Cobuzt2yyqmPwtikTsvehB9iHoFVr6en9ODDdPF4gsnunSJlX8mbUa6z0CFBRL3npjnxJusWrJ5DH2L0KabSM69o8zcGoXt6xQLBslfJTHapOQcC3sHnzCrEpN7RYBugjDfwPMe/++Ljm9FprI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983863; c=relaxed/simple;
	bh=dfMgX8andqPb6xNC5zAVzri++2MsC8tk88zE/F+0MmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmZ+LHTa/ds1YoAziUg8gzJ1LX6l1nzqKSo4BURiI5kQ1DAtFyFrnz/4wlkwouTh42XGhOilaKDzEkf1ITtoBE6DpRcoVb5yxZg93n69Afl+GMdmEjTf5xiDicROS3s5diFtdakmZJjBk9BidMIN3EpHMSIZgB7rDFEA/jmB/Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGaX+eqe; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d0618746bso800475e9.2;
        Fri, 14 Mar 2025 13:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741983860; x=1742588660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBD7QjUwsZ4gRlPp86xCs1FmL95zEZ6TJFL9r0bh0AQ=;
        b=MGaX+eqeyjkmvxADMbcnkYgut9TCKESKrJ+5jWTB9TAuJpK9g5k/ppjsBB870/D5my
         vU3zAygrnl3P4ST54DXMmbeWIKvwXyT2TpBKw8QFoWMOk93ceKXrCFUkAB4IaCgTWDJW
         DIdART7K9zFbbAJp4sEV3JrdcmmabtkcxL2khgt8+M7N31gRnezPLrFoZPxAJlGGOUdo
         5yLNcuEDft+qW3acsP7/zYf9FNY02BMkE/UdbVYrE7X6qxpfkOq2GmQtvDHosp54FUdl
         ZeGMVd6tgPDqUkYUHegYqu6TDsYIalkagJrrRv7IEAKL9ZygCb8Y72Mu8F1dKd0t7GFf
         GSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741983860; x=1742588660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBD7QjUwsZ4gRlPp86xCs1FmL95zEZ6TJFL9r0bh0AQ=;
        b=GiV47R1y2+BnKhTV4ME7mzzOJrLvkKku2c14+lzh3yCsQeMb8RN3UVCqY28ur0rk0v
         vNk6Gm7o7EBCv8ExYunWH5U1UDRqhVYsRjzmhfYgai/MDpltsnjZ0nRa53xkEYOafpdU
         J46VklvXWY3j7vNUHtLKH3u+5Aj0f2IqQAM1+XdDZc9FFBhoaeLpKoUpUx5LQ9Xz0B6a
         shK/+wY4LhWKdLxaGrUqxh7YuxUpPR99sp5iUA9i37R3gqlSgCAetD+vlRZAbJ+gVzUc
         /k1Rsj8BsgpSuYMe41/ome8OtkUDNgrrPKV1ZPnaVGDGCjF1cnzji3zkZEvT0ha4p9cj
         YwZw==
X-Forwarded-Encrypted: i=1; AJvYcCXUWXKFLC4/1c8jm2C5/uCzBgNdvZUbw01FboofqiCTJhakmNAnm0QOZGjlwwv8/Uiv5Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0kBbY8v59xMueknqZ0SxhrKPWFK+mPJ5yKfIdTmBHe8yhMrF8
	iakqVjeI43kdD0EqF0jEnnbuIGOy4zzeoZI3mHeQWyZrt4M+wRXApH4u0yQqolbYytYH/YJoR8y
	5ZOA+LHRxWn6T0SiK5kW+514ylI8=
X-Gm-Gg: ASbGnct1ZYyCU250ez2uvcBo3mYBCL+yI6NO3kbe+uKMw99hcpTELHOp1fOTtAD8W4C
	o4Afhx42DVtsXWxlXl4ZWsKduZsxjvz7ErRk9bzeco/K8c8N7A62+PWV9Bz8oKOimt0d9Clb1dW
	7TSKOkkCnt38nIJr8L8VwTwWr+U6i84nUQzie5Rddacg==
X-Google-Smtp-Source: AGHT+IEUNMDJ3nG+IH6AH21o7RpF08JjULqzpgNjnPhIfwuqNGOsyFp4OZ7skenM+n39xwG4bIPQoZrvESqdFNiDWWI=
X-Received: by 2002:a5d:6da9:0:b0:38d:e401:fd61 with SMTP id
 ffacd0b85a97d-39720d47e80mr5434628f8f.49.1741983859288; Fri, 14 Mar 2025
 13:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313190309.2545711-1-ameryhung@gmail.com> <20250313190309.2545711-8-ameryhung@gmail.com>
In-Reply-To: <20250313190309.2545711-8-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Mar 2025 13:24:08 -0700
X-Gm-Features: AQ5f1JrDw7FkzebDgranqRMbOsiGMVmO7gfPCxRsi2xSOUZQXlm7S6u9HWqvpeY
Message-ID: <CAADnVQKBe89WSjwsMaaGGmHAtGSSvCVQ+f7HstjQBzx8pu2gUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 07/13] bpf: net_sched: Support updating qstats
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
> Allow bpf qdisc programs to update Qdisc qstats directly with btf struct
> access.
>
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---
>  net/sched/bpf_qdisc.c | 53 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 45 insertions(+), 8 deletions(-)
>
> diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> index edf01f3f1c2a..6ad3050275a4 100644
> --- a/net/sched/bpf_qdisc.c
> +++ b/net/sched/bpf_qdisc.c
> @@ -36,6 +36,7 @@ bpf_qdisc_get_func_proto(enum bpf_func_id func_id,
>         }
>  }
>
> +BTF_ID_LIST_SINGLE(bpf_qdisc_ids, struct, Qdisc)
>  BTF_ID_LIST_SINGLE(bpf_sk_buff_ids, struct, sk_buff)
>  BTF_ID_LIST_SINGLE(bpf_sk_buff_ptr_ids, struct, bpf_sk_buff_ptr)
>
> @@ -60,20 +61,37 @@ static bool bpf_qdisc_is_valid_access(int off, int si=
ze,
>         return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
>  }
>
> -static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
> -                                       const struct bpf_reg_state *reg,
> -                                       int off, int size)
> +static int bpf_qdisc_qdisc_access(struct bpf_verifier_log *log,
> +                                 const struct bpf_reg_state *reg,
> +                                 int off, int size)

Introducing this func in patch 3 and refactoring in patch 7 ?
pls avoid the churn.
squash it ?

if (off + size > end) check wouldn't need to be duplicated.
Can get the name of struct from btf for bpf_log() purpose.

>  {
> -       const struct btf_type *t, *skbt;
>         size_t end;
>
> -       skbt =3D btf_type_by_id(reg->btf, bpf_sk_buff_ids[0]);
> -       t =3D btf_type_by_id(reg->btf, reg->btf_id);
> -       if (t !=3D skbt) {
> -               bpf_log(log, "only read is supported\n");
> +       switch (off) {
> +       case offsetof(struct Qdisc, qstats) ... offsetofend(struct Qdisc,=
 qstats) - 1:
> +               end =3D offsetofend(struct Qdisc, qstats);
> +               break;
> +       default:
> +               bpf_log(log, "no write support to Qdisc at off %d\n", off=
);
> +               return -EACCES;
> +       }
> +
> +       if (off + size > end) {
> +               bpf_log(log,
> +                       "write access at off %d with size %d beyond the m=
ember of Qdisc ended at %zu\n",
> +                       off, size, end);
>                 return -EACCES;
>         }
>
> +       return 0;
> +}
> +
> +static int bpf_qdisc_sk_buff_access(struct bpf_verifier_log *log,
> +                                   const struct bpf_reg_state *reg,
> +                                   int off, int size)
> +{
> +       size_t end;
> +
>         switch (off) {
>         case offsetof(struct sk_buff, tstamp):
>                 end =3D offsetofend(struct sk_buff, tstamp);
> @@ -115,6 +133,25 @@ static int bpf_qdisc_btf_struct_access(struct bpf_ve=
rifier_log *log,
>         return 0;
>  }
>
> +static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
> +                                      const struct bpf_reg_state *reg,
> +                                      int off, int size)
> +{
> +       const struct btf_type *t, *skbt, *qdisct;
> +
> +       skbt =3D btf_type_by_id(reg->btf, bpf_sk_buff_ids[0]);
> +       qdisct =3D btf_type_by_id(reg->btf, bpf_qdisc_ids[0]);
> +       t =3D btf_type_by_id(reg->btf, reg->btf_id);
> +
> +       if (t =3D=3D skbt)
> +               return bpf_qdisc_sk_buff_access(log, reg, off, size);
> +       else if (t =3D=3D qdisct)
> +               return bpf_qdisc_qdisc_access(log, reg, off, size);
> +
> +       bpf_log(log, "only read is supported\n");
> +       return -EACCES;
> +}
> +
>  BTF_ID_LIST(bpf_qdisc_init_prologue_ids)
>  BTF_ID(func, bpf_qdisc_init_prologue)
>
> --
> 2.47.1
>

