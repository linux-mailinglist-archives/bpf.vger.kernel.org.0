Return-Path: <bpf+bounces-50262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E73A246DB
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 03:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82CDB7A1E9E
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 02:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9F537719;
	Sat,  1 Feb 2025 02:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CjF2ee/+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ADD20B22
	for <bpf@vger.kernel.org>; Sat,  1 Feb 2025 02:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738377698; cv=none; b=WAAOVnapXYbbJC+t6WS1RrlHz9VDO17WrluCwSPNUCtNwSMgMHgh7TPcldhvN4kg2eFCEMWxPNmTkGdG7zfWhC1CF+bxv6+gPc7OgEQQhg/njyG3n7lXCD3FjEcNH1S7B0j7n/CmBM8Gw0Fky3lDI2J6kwFelgiRXNYyl1aFsgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738377698; c=relaxed/simple;
	bh=djRlcE9P01w4z3y1JQaA+m1/JmEz/lD+8NkRRxfNWYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfu+cTaV+RBEQKrL0Gi5fflImTDg6nrVaUsliEl/LjIqrmJ5OPP3f2a/dg1R957NAGBrBENFISE6d75AfC4AnOmFSitnFiaW2cJnMlL95SiI9qXUZE4Gh6DLj8L6mJGZ1xytxfjdQXtR6BIlCukRzatDBrH85VXVOq2z0Vi+gMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CjF2ee/+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5db6890b64eso4845029a12.3
        for <bpf@vger.kernel.org>; Fri, 31 Jan 2025 18:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738377695; x=1738982495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfBoUsZaLtBEyJLVe9JkQ4NF34QTaJ6gtHjAQyjfemI=;
        b=CjF2ee/+4vcmabUEUou5RfP0cusNeK3VqKYksH1Sc+AxxislS1ZsDOlcwiV3nRMave
         o974WIVHrRndVr6afUM9c7o/6ry1RpFMxmkoZl1gOooH59GQogTzznCtG9wjeFOvhp+s
         tBCjDufS4CXX+oJDyDtSwFYOrc0dcJ7AZqKJcVcmd0uNOwy48une4ybA3oNPV6cHdnlF
         Ctf3nOQFULasjcmSejbOMoL/S0L6kGNNHCMSPYE2bZOyEaurxbd+/Z8anG2pYiLJheZW
         ggvvorjnQ2anRMwg8WguA+c9QulsQ/zTpcYUIQDLCrjANnQoHBp6J3/VXwTbpyiKkTvA
         jewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738377695; x=1738982495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfBoUsZaLtBEyJLVe9JkQ4NF34QTaJ6gtHjAQyjfemI=;
        b=d0DS6njEBx9Wpn/y698kf69D/HWA/cSyZSpyPQ0dAIAq1RIxDz9qY/HNUb7KGMcSpO
         gXJ1IXTvuwK2D3lX+GNGEiwVfTzB3phoWoFOCfM8TtrDuz7TMBz4xSSx+xyssMGMcTMP
         UvFVv+D4XhOecXvfHFfMr9iweJF6iBE3rtgAufBPNtImH1N0DuZxabTMaZzZmZYXKU9+
         vkTF6D81aOl1wRVlT2QvjhGj64Nf5dLH+3kh3ShpdnIvqfGn9brrQOaTLVvb000yaXKT
         88mNas4kgLUUiLRqEhKljf826z7pgP+nlWsUtLiaWhpt/LS1f6SIN1KGhSars9tVXxod
         0qvw==
X-Forwarded-Encrypted: i=1; AJvYcCXlSpuOU0sYB9OxnWOjiqSYc29uVKIIoq36E3WpRsZOwynzC7p/2CTr/BIhTGJ1DGH8bCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv3veZWoVFidRBhanBSZJzHQ9zPPWI6Ld1xG9agKzMfwyyyJlX
	+jm5PmOdiBt6MA03Xv6zLQgilNkAVvz/0gxAcxuHRYR6hgOQ3ehJ6sDiE33AI39cQU3+QbXQ5Kw
	GzYmxN6XHFA8ZYqy6HUsuO6ZowXgKxx7BH0W6kA==
X-Gm-Gg: ASbGncsT7/+TUasAXHyvcgOgryOT1yLt0MEZfwaLw2JuODFRAFjSfFphw3ArFjmgUke
	jIoLceqjP2WZ46S/BOovAxHBaHnWn5aZXk/1tzFXtc19iXhj5ciQDi+kHjjnmk18LUd7ucNVmsq
	6GIkjQ67k29VM=
X-Google-Smtp-Source: AGHT+IH5Z9vcdkZY0q8pZRLbEOFe0a/Zajiz86fU+P3WGLcHUM1ixdjMnAvG3cT0BTXHarFKBuQuZhP0KDj4e4rIuhA=
X-Received: by 2002:a05:6402:42cc:b0:5dc:1273:63fd with SMTP id
 4fb4d7f45d1cf-5dc5efec154mr14354528a12.20.1738377695268; Fri, 31 Jan 2025
 18:41:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201001425.42377-1-kuniyu@amazon.com> <feb7ac0f-54e7-4e45-b79e-0fc8a4509437@linux.dev>
In-Reply-To: <feb7ac0f-54e7-4e45-b79e-0fc8a4509437@linux.dev>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 31 Jan 2025 20:41:24 -0600
X-Gm-Features: AWEUYZkkHXS4mUSeuNtNrnSGkQAeL4j781kWI7h_Ac_yT1Zmnkm1aRsx6jFNCNk
Message-ID: <CAO3-Pbr6dRto6LcACKsBDcn1s+gzbF4Kb-6WWeKgyNSAnvvkoQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf] net: Annotate rx_sk with __nullable for trace_kfree_skb.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 8:19=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/31/25 4:14 PM, Kuniyuki Iwashima wrote:
> > Yan Zhai reported a BPF prog could trigger a null-ptr-deref [0]
> > in trace_kfree_skb if the prog does not check if rx_sk is NULL.
> >
> > Commit c53795d48ee8 ("net: add rx_sk to trace_kfree_skb") added
> > rx_sk to trace_kfree_skb, but rx_sk is optional and could be NULL.
> >
> > Let's add __nullable suffix to rx_sk to let the BPF verifier
> > validate such a prog and prevent the issue.
> >
> > Now we fail to load such a prog:
> >
> >    libbpf: prog 'drop': -- BEGIN PROG LOAD LOG --
> >    0: R1=3Dctx() R10=3Dfp0
> >    ; int BPF_PROG(drop, struct sk_buff *skb, void *location, @ kfree_sk=
b_sk_null.bpf.c:21
> >    0: (79) r3 =3D *(u64 *)(r1 +24)
> >    func 'kfree_skb' arg3 has btf_id 5253 type STRUCT 'sock'
> >    1: R1=3Dctx() R3_w=3Dtrusted_ptr_or_null_sock(id=3D1)
> >    ; bpf_printk("sk: %d, %d\n", sk, sk->__sk_common.skc_family); @ kfre=
e_skb_sk_null.bpf.c:24
> >    1: (69) r4 =3D *(u16 *)(r3 +16)
> >    R3 invalid mem access 'trusted_ptr_or_null_'
> >    processed 2 insns (limit 1000000) max_states_per_insn 0 total_states=
 0 peak_states 0 mark_read 0
> >    -- END PROG LOAD LOG --
> >
> > Note this fix requires commit 8aeaed21befc ("bpf: Support
> > __nullable argument suffix for tp_btf").
>
> I believe the current way is to add kfree_skb to the raw_tp_null_args[],
> https://lore.kernel.org/all/20241213221929.3495062-3-memxor@gmail.com/
>
Nice to learn the trick. Thanks Martin!

Yan

> cc: Kumar
>

