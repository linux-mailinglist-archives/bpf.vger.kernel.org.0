Return-Path: <bpf+bounces-51525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F27FA3567F
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 06:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9C7165204
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 05:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949FF18A6C0;
	Fri, 14 Feb 2025 05:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X01BBUpt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A5318A6B8;
	Fri, 14 Feb 2025 05:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739511906; cv=none; b=QaH9YSnDMV57vYga6byQVjW0om5LXXCPze0G/Dm+2Dd6U0Mg9d/PQIoPdnUHux6bxLQpsYXjP6dXk6+Vzoya6qTpObANu+VRbb0xNSfHJeBAzW1BCv9xiflymTKISlhtEjlfN4TNVfHDWgOB3TtcCGA6/dFxHinsNg6YRejGTZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739511906; c=relaxed/simple;
	bh=SpV6gU4dH4/RbNa4LGUMXY4ykpvqmlx4QE93BGR8tbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYrQUOUQFtF4emrc3YoDrbEUT1OpSL83qkMF4XUcXTp/XUfZl2aw8GWRoCp6L0S1yT3XQodqopcfuey08Yj2d3NXuC9NSESP768/Mz+oalfYSU220gnVFi83O8Lduk8mVAvRbag3c58v7YdhwPqVnf91uWltGWuOLkb5mCQFEIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X01BBUpt; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e53c9035003so1331997276.2;
        Thu, 13 Feb 2025 21:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739511903; x=1740116703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+g3t1xpmHHGvkCi1mzuO0iYCFXd/XL2tsFLnK4Gt4Q=;
        b=X01BBUptvcElrfwwPdXHNwqEcSKTS7FDxpnrHd3d2ebYLTijF9/bE5P0hqtIEZAj7E
         BBdQ20uyKv2dDnkEma3VUoGpQS4anrZo2UviIyAxE3RIWO3LYkhCk+AjLmhd/6LvxAek
         voIFjLYcowl2nP30GzXxqgI+sGaNhLNcT+qEHLMyYEWh4n6KyRF4FoJr13xZVDrZ6cN6
         KvTrVmz/mov15POeZGitj6L0IQtuaOP0Xv7pViWgRZB4BdJsiiYPTWvejJTqAMbtRzDw
         aEWLn+sZoHWjh/YglwTw+FiJXYpfJ74ZJ2gFxlR5S55A9io8W7FRRu327hyyEQm1WAKX
         O/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739511903; x=1740116703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+g3t1xpmHHGvkCi1mzuO0iYCFXd/XL2tsFLnK4Gt4Q=;
        b=hodNpHfOeafa0oSdAc/NsoN0QpQCPtS2vDnzj4uTh1+Bs0EERNEWCkM1ExUqk01ugh
         UjYuSad/HQxy2g7SfwAr6kZ8D2HWr1OF/mGneMpIvG0f9aHDD/YAGwCyvT7Cgf4alvW1
         2HBGreqIZG0jpfQOMzQjCNnUr54uMpkEL3VGh4IP1DS2OIVvWFDeJIWXZQdJykHWk1K0
         uKJYmPQMjqmZ/7MoMuZ4lz7vuHHq95GYZWYKyOnM5RIK2S1JII71uwTOePUJFn2Gy8fU
         9H1HPhyTvHxXPs8rAxKyDev5w+xNccZVDSJn5AL0Ut2YPZg26509YvmOmGGDvYY7s5hG
         lmlw==
X-Forwarded-Encrypted: i=1; AJvYcCVKBAH8TA4WO1pbX4HSGFSv6mDy8bUMhfNMucDXeye8WZhpSz3g+t/PRcJsapUgDVBci9mV1uw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1NXu32LVF4rIMjZIfNdKLT83/FDOfkZ1KRz28nQjZJl9/rm+d
	XK5IjOLO2+VIzpCuD2l6fxPQa3gxc8AnJS9KA8s3/w4GTIUqIZocBKHjQm5b7EJrvGQG8svZ9SQ
	VK6280Lj/kL+Ame30sqPyTSShSso=
X-Gm-Gg: ASbGncsg/vVL/C2cABEDhOAO00eAdLG05Nd8M6gPnmBOkSr21pDpw/iq2iZIshFGh7C
	dW47IGZbhr6sXzVfFIcK46NCPnVG7vTxD3lkyGDfIsv0aETn7AX2j2KPnuac5l9UhAJ6n0SQ5
X-Google-Smtp-Source: AGHT+IGIihUVoAVCUXpgds5ypH/iwoRtxdOC1bY/zttJTlf4zUBc0yN5Q4Nvp19kwSM1fvB641IXWq5Wtcp1Q/9Zjy0=
X-Received: by 2002:a05:6902:10cb:b0:e5b:34b8:5d5e with SMTP id
 3f1490d57ef6-e5da815c681mr5775941276.26.1739511903488; Thu, 13 Feb 2025
 21:45:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210174336.2024258-1-ameryhung@gmail.com> <20250210174336.2024258-2-ameryhung@gmail.com>
 <0bee571a-927d-4042-9e89-53bf695ec054@linux.dev>
In-Reply-To: <0bee571a-927d-4042-9e89-53bf695ec054@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 13 Feb 2025 21:44:52 -0800
X-Gm-Features: AWEUYZnNCWkwe7XKJbQFRb5sVdvpcwySEEcq7pHg2MGl15FaYoqfGJB3kDU3LCE
Message-ID: <CAMB2axN+HNH+XOrEDKRwg8rDywOxPBEjWNQCp0FaNxsFnbvArw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 01/19] bpf: Make every prog keep a copy of ctx_arg_info
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org, 
	kuba@kernel.org, edumazet@google.com, xiyou.wangcong@gmail.com, 
	cong.wang@bytedance.com, jhs@mojatatu.com, sinquersw@gmail.com, 
	toke@redhat.com, jiri@resnulli.us, stfomichev@gmail.com, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	yepeilin.cs@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 11:54=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 2/10/25 9:43 AM, Amery Hung wrote:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 9971c03adfd5..a41ba019780f 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -22377,6 +22377,18 @@ static void print_verification_stats(struct bp=
f_verifier_env *env)
> >               env->peak_states, env->longest_mark_read_walk);
> >   }
> >
> > +int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
> > +                            const struct bpf_ctx_arg_aux *info, u32 cn=
t)
> > +{
> > +     prog->aux->ctx_arg_info =3D kcalloc(cnt, sizeof(*info), GFP_KERNE=
L);
>
> Missing a kfree.

Thanks for catching this. I will fix it.

>
> > +     if (!prog->aux->ctx_arg_info)
> > +             return -ENOMEM;
> > +
> > +     memcpy(prog->aux->ctx_arg_info, info, sizeof(*info) * cnt);
> > +     prog->aux->ctx_arg_info_size =3D cnt;
> > +     return 0;
> > +}
> > +

