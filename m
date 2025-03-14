Return-Path: <bpf+bounces-54071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4A6A61CBF
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 21:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120ED881410
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 20:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BC32054E0;
	Fri, 14 Mar 2025 20:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nd1lu+LN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C52204099;
	Fri, 14 Mar 2025 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741984313; cv=none; b=ZfUdOOVqdyPz4P6FLZJcnBl4GZb/01LkumJZ7nGKEK6+iUrekRLVxj1v0zAKyMYRf7j94D2s6VZJzQf++1LXX4plE7BPswMcr3C3QbfF3uXd91g9eukuIkklKwv0LiCL4HTzWBs3JoXNyYzv/hrLLdgqnPPS9IYL/MdN0vtljgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741984313; c=relaxed/simple;
	bh=CClAWyhe+zvGkSJnvmrqiVywGtdUPjZLGum2vT+wi9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZvXik0C2Tgk6yR26Ul1dS4D6csQTVvQxey1qkeH48ZdJmyT5YVAEphF6hPMY9BpdiRJrxIWrhwdw8oTlx9q8yhcy0m/k1m3t6OeNk6Du8sdsiIDGZAG/toycIYUioSDnfK8yijUj7O622Ohj3ejhild2jkVqpqbTUI5ApiDlYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nd1lu+LN; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so1283675e9.0;
        Fri, 14 Mar 2025 13:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741984310; x=1742589110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8SBW/0o/OhjS45ktfU2GD+0iJTxTsBLbOf9gBVJ9vg=;
        b=Nd1lu+LNoFs9Om9V0cHnnQREXhJDVAwwgVCfyD3QxsT4ec5GQ9q1yka16AooeSytrP
         T5t+uToOWe+2KsIqXjSI17JrVqu4DRgt+C9DPEGnsa8+UVhOhrY0Fl4yNEInbhcU735Q
         X/Jxh75nn5OcOCOp1FPVqYJ4hezpchMFwQd5EvcvO3pvYDxcOQI84YyyTFOTNxBKbNB1
         eXvDUjgJ6U7h5Fo+f9tSF6HXqYGDy1OIm+mH+blYRlV6XSiftRzJ2LvekGQSnQDsP8eD
         qNE+pDIia6U3B7FQP+mnchhIZBU3miM+PrUpFdFVtF4ia+mVUQkbJozk0/YIr/fOD8DW
         aRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741984310; x=1742589110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8SBW/0o/OhjS45ktfU2GD+0iJTxTsBLbOf9gBVJ9vg=;
        b=QXXVxLd+za/vw0ItYG+BBZVFIbsMk3QKc/sSYvliw9tJqOKLb4bAC+QLnuPRQcaTqB
         XJTLe9JvAaNKDg44XS0/+yvKhKQgv/+oGYkLv54xhButtKmKnhvrTsmoM6wr3D5wiZ1H
         2cL0RHlCk+AWfG6QoPIfhME1a5J09nI/6YYlO985LMBaYOnwJXpamgw4LU7Nz5IkZ/OD
         zGRlMSJp/MxTBBusldfI0MfmEPBRmSsH/BbENRHNr9ihkZGIcMzpfQtm0RUXje73yf49
         qJ+LuyLWJ6o+JE6pzsiLL++AsuiEaKYWPrPgAikzaBOYMicr8fhhSYfO2FVRwH3bQLBQ
         +mbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVPXInOdCti/95hIrRxBKn131MT2TwdqIdpF4FHgubY4y9RRR6th0Yuyy7gZvERYLGKWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrTJkRNxBqUUcxYDYBp+Sd18li/KhJEJJeF02cHtHmkbDs3Q+W
	aczC+1Y8YLIV169dg7aQTgHcRTKlHzI72p/hS5YCtH7prcQJKDQiZnXohLol2Gye2plIWoo7a1n
	scC95VqOOGWM5qsI9K/DiLIJMFOA=
X-Gm-Gg: ASbGncuwt75/qIcpbVSuJH1q7C41ZC7PzQ2Q5Qn8knPkacd66TmGRH5PhpTXydDUiNK
	VRys3cV/bqjFj8LArBo7pQeQESx+3YoFG9o0b9tIdnWW48UB1lFBAPtxceYuGRCQclNBt1JjdYI
	ohEmsGNojlb2hZm9CPiVpO6ieOZ4M/mz5LeS9BYXJcEtNsmCV6XsmJ
X-Google-Smtp-Source: AGHT+IF0kVri9I9eAy9szqB8xcwSwCCOtiQitSpA/3PLeJKTIqkIN+TYzg3QRHz2eVkpCkC91Y2m2ZbRiaSTO/u2nME=
X-Received: by 2002:a05:600c:1d15:b0:43c:e481:3353 with SMTP id
 5b1f17b1804b1-43d1ec8e42fmr53083445e9.17.1741984309749; Fri, 14 Mar 2025
 13:31:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313190309.2545711-1-ameryhung@gmail.com> <20250313190309.2545711-10-ameryhung@gmail.com>
In-Reply-To: <20250313190309.2545711-10-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Mar 2025 13:31:38 -0700
X-Gm-Features: AQ5f1JrtiIXysTvlT2R9ZfFgY2yAD-dmVTEcyc0yvh9IPoR3SVRLeXLoR9yIXR0
Message-ID: <CAADnVQJ-kSNw4hiZ5p_fpsVAyYWDSu50OJyY_NGmaxk9+ofiiQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 09/13] bpf: net_sched: Disable attaching bpf
 qdisc to non root
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
> Do not allow users to attach bpf qdiscs to classful qdiscs. This is to
> prevent accidentally breaking existings classful qdiscs if they rely on
> some data in the child qdisc. This restriction can potentially be lifted
> in the future. Note that, we still allow bpf qdisc to be attached to mq.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  net/sched/bpf_qdisc.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> index e4e7a5879869..c2f33cd35674 100644
> --- a/net/sched/bpf_qdisc.c
> +++ b/net/sched/bpf_qdisc.c
> @@ -170,8 +170,11 @@ static int bpf_qdisc_gen_prologue(struct bpf_insn *i=
nsn_buf, bool direct_write,
>                 return 0;
>
>         *insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> +       *insn++ =3D BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 16);
>         *insn++ =3D BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);

Both loads need a comment.
It's st_ops callback specific and not obvious what ends up in r1 and r2.

>         *insn++ =3D BPF_CALL_KFUNC(0, bpf_qdisc_init_prologue_ids[0]);
> +       *insn++ =3D BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1);
> +       *insn++ =3D BPF_EXIT_INSN();
>         *insn++ =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
>         *insn++ =3D prog->insnsi[0];
>
> @@ -239,11 +242,26 @@ __bpf_kfunc void bpf_qdisc_watchdog_schedule(struct=
 Qdisc *sch, u64 expire, u64
>  }
>
>  /* bpf_qdisc_init_prologue - Hidden kfunc called in prologue of .init. *=
/
> -__bpf_kfunc void bpf_qdisc_init_prologue(struct Qdisc *sch)
> +__bpf_kfunc int bpf_qdisc_init_prologue(struct Qdisc *sch,
> +                                       struct netlink_ext_ack *extack)
>  {
>         struct bpf_sched_data *q =3D qdisc_priv(sch);
> +       struct net_device *dev =3D qdisc_dev(sch);
> +       struct Qdisc *p;
> +
> +       if (sch->parent !=3D TC_H_ROOT) {
> +               p =3D qdisc_lookup(dev, TC_H_MAJ(sch->parent));
> +               if (!p)
> +                       return -ENOENT;
> +
> +               if (!(p->flags & TCQ_F_MQROOT)) {
> +                       NL_SET_ERR_MSG(extack, "BPF qdisc only supported =
on root or mq");
> +                       return -EINVAL;
> +               }
> +       }
>
>         qdisc_watchdog_init(&q->watchdog, sch);
> +       return 0;
>  }
>
>  /* bpf_qdisc_reset_destroy_epilogue - Hidden kfunc called in epilogue of=
 .reset
> --
> 2.47.1
>

