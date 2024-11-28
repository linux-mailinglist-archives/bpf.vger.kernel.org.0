Return-Path: <bpf+bounces-45796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B69DF9DB18D
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 03:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 512F2B20EA5
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8171976025;
	Thu, 28 Nov 2024 02:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhlVeTAr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB51433B1;
	Thu, 28 Nov 2024 02:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732761825; cv=none; b=fjP2FdgwdfFtBn32pNy77S7ctP2xHXnBjUf2VIMzErJHYanPIH14NbIQ9XPL6v67OtV3hFcyV9l6MP8zzjBeXCT0H+GwPBp4QZllYCfqcRPnek9c9jZCQ9gxZkSZMgxiqtVKr4f4guHCfiG/nCq0jUNobYDF1tTjdfTcSMN6k2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732761825; c=relaxed/simple;
	bh=B2VUcb3Tmrx1La4HxceUCEyC1e9wB4j5rPnZnNSD+Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3OrvNry0QRrwYTAb1J1GPeavWbI74SuoX4F/Hn210o18uIWe6hGFvYz4PhciQo+16GoxludU1X2ijoDdVObUdDm9VH5uwh+yfn7sk6+xU4JWD9NGqeI/ANws3xwFRDvV2n37xEPhNKJMICoJwA5G2xbrc9i+ofrVUzoEF47xRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhlVeTAr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a099ba95so2885855e9.0;
        Wed, 27 Nov 2024 18:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732761821; x=1733366621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Owa14ZCDoNgQ06uVhcHXrxie/5XbfMeHw34tNIT+blY=;
        b=BhlVeTArOV4zXFRy+9hRR75YR5vNXRZosRRaHnPXFQJO0z1rvIY28lHzOydHT5HMYq
         gfqXQxTf+HbyRtZV/+n7dc0iPKYUC5kUdjMjY4gx/N01SctDCrQ9rlW3JaZazT2H+jfc
         Rd4EPK3mMzOFXKddpW+yngobn/Ld8s4PYvLiM+tzcg7ObHKRt+hGgW4OzLO5O4Xl2K6w
         xbyx6zEyBO1AVB3kfw2OWhR5GK9EHfX2QawoayrkoBG22TU/uHoEh+T/AyrBxmLBbiCW
         LW9IfTFWeHwTdPR9dGwHONRYGxFmDZV1efieyY4bIdFgq//8Mg46aYhecNwl1izCji0R
         o4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732761821; x=1733366621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Owa14ZCDoNgQ06uVhcHXrxie/5XbfMeHw34tNIT+blY=;
        b=F9ArfOkYigotVYXxdVm9BY1S77Cha0ysaldfGSamTpDYivorJs+0fJOqB4e3ZcZIxv
         Tmitq9oUVscP/8DTHhCUdjnYRY33NQxg+SM+MCGMVkgvZEuzU/108av66NEoYuJXV8A3
         WYWijpPaa7qPUzDqrGB2JUowOxocX47JZZd66gTugsorlroTR67lVu6Ok1BuUCnjNvPE
         9PtZCj/9GYoHdTUiS1tfOAh8pVtDtPzfoDRc1bWxLEHCW9GGGm4lOFEoNfPxRxFMv7eD
         8Fb1D9r/jTlaJyqhc5en/oIauLiGWwt5/B/oKuDpLb6k8gejoqPZU4tzhRkpt8RqxzRO
         w7UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU58KKYeLmODeNP9+wKujJFXef0UewaZ/x9p9oej8Bfg2MueuDuIdgBcHDy1h3O+BCEIZq18LuxJan+gM4@vger.kernel.org, AJvYcCUcqTvkqRwB07SMSdm6NxYhPi+8m+2HzxR17rJ7DuWUDKbo21phGExHH4GpiOqEMKi3H/mCSyth@vger.kernel.org, AJvYcCUoWBKPP7Op5ragXOGhIrhiWBeRH0SAoqM/Jzm42ueRXMP1fC1kRAFQ8U021Owh86l8o8Y=@vger.kernel.org, AJvYcCVxj0Y7CTBhLLC/KHkECfBgR5cdm/z2uX9wzMiEJz+F8qMFex8EFAUbS+Afq2+vfQbAGCYW2VIVsQ/H6aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXNLyYoLrCi5VvJprvSL1SWhN0iNfrXAToaa194oxpM8W+V0LP
	BGuSr2aZDpPWFW8iiq1K3RWKJLStGBE3JQanzJAfEagn4vPMtP9lNWe01OGi5fyIcdGCzhI4/kg
	RmQPJqEzhVz03MLemNGrmmqVa03Y=
X-Gm-Gg: ASbGncuo5dzrTxi5cjclOUFNwp0GEVcMkzsWsem/QSRZfX4kiF3AUp5EXRYay+4HQXs
	95WkdIPJftmq28wtuc2iNsPge7MSUhw==
X-Google-Smtp-Source: AGHT+IGL7KlI85w+FpUF5vt3IezZ2f7SZDQWHC1gXz+5gsMJi6fPNdnBTHJG5WwEXnUVsABNq6hffhwecd6FoqZ0SRc=
X-Received: by 2002:a05:6000:1ac9:b0:382:3527:a147 with SMTP id
 ffacd0b85a97d-385c6eb6625mr4763206f8f.1.1732761820964; Wed, 27 Nov 2024
 18:43:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-bpf-const-ops-v1-0-a698b8d58680@weissschuh.net> <20241127-bpf-const-ops-v1-2-a698b8d58680@weissschuh.net>
In-Reply-To: <20241127-bpf-const-ops-v1-2-a698b8d58680@weissschuh.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Nov 2024 18:43:30 -0800
Message-ID: <CAADnVQ+yTZkfC=6Vw3+P9OA2iqzB02OhYTwWWCBGKLy_EfvQKA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/9] bpf: Move func_models from bpf_struct_ops to bpf_struct_ops_desc
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Network Development <netdev@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 11:20=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weiss=
schuh.net> wrote:
>
> --- a/net/bpf/bpf_dummy_struct_ops.c
> +++ b/net/bpf/bpf_dummy_struct_ops.c
> @@ -129,7 +129,7 @@ extern const struct bpf_link_ops bpf_struct_ops_link_=
lops;
>  int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr =
*kattr,
>                             union bpf_attr __user *uattr)
>  {
> -       const struct bpf_struct_ops *st_ops =3D &bpf_bpf_dummy_ops;
> +       static typeof_member(struct bpf_struct_ops_desc, func_models) fun=
c_models;
>         const struct btf_type *func_proto;
>         struct bpf_dummy_ops_test_args *args;
>         struct bpf_tramp_links *tlinks =3D NULL;
> @@ -175,7 +175,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, co=
nst union bpf_attr *kattr,
>
>         op_idx =3D prog->expected_attach_type;
>         err =3D bpf_struct_ops_prepare_trampoline(tlinks, link,
> -                                               &st_ops->func_models[op_i=
dx],
> +                                               &func_models[op_idx],

This is sad. You didn't bother running the tests.
Above is producing garbage.
That's why so many BPF CI tests are failing.

Overall I think it's a minimal positive value to constify struct_ops.
Unless other bpf developers see a huge value
I'd prefer to keep the code as-is.

pw-bot: cr

