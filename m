Return-Path: <bpf+bounces-52120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E463AA3E92B
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 01:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF3519C2221
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 00:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D770A79F2;
	Fri, 21 Feb 2025 00:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDGeullS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F405B6136
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740097852; cv=none; b=IyJwoE+D8p5ziGk/1vpoEEIqFr/Mt4Qb/I1B9kKYt0AqubllpFTCOt8WyRh96p/74a36A+IrKXiYAY7/lsyHqRpENw9SpmMwkss2J4fzHqreWDjtXxxATZIWWLCt35b8LKpkZEZtY//PeGVP8EBwfHrKX3Tb2G5noosQQKk8CP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740097852; c=relaxed/simple;
	bh=y78d2Ay1hM31DoZVbVC4W2Xvsc4QurMWzPrFT/rlBFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5UH0bvuhqB4Bf8EDtuMQ4p0/tf/5yZ8fsJP+osv4M8jMz2zbW94+pL5EGaHf6FodWYKI/2oE9r8/aNSCjC0Gb5i/Mwzn0J6B8CH4n/HIrqgibTiADNrytCCvCIncS/j3uiHo1jHubTeYJfPuP1J5Vh1wb4ztSAR3DGu4JeqPQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDGeullS; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fc11834404so2507532a91.0
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 16:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740097850; x=1740702650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6gT9dQPxIC9/sJmSGN9CJieKdgmQ7IWoiLicVCIbDU=;
        b=GDGeullS5pLGSQaDmyVwLZr8c8n4CqdHizBJcXBXpueKzOJJ6lJz8V9z4f8vwieAde
         FWvk7S6+pgq+pqTs6Dn+XehW4KKnnaav6L+G43ylwZUWhufDETpkN8pFIRMO7MOny+go
         XkARoR0+NKmR8rskIsFJyVJNvOZtHUDEF9vdE2cC/DlIcxwIif/pzazX4bfkqj9szJin
         pCy2lk+VgQALaxGXOpLhBiJVOa4l6LWp66Djdz9NWq4LfC6qu9udM8bRvgB9PMW9jBcE
         dYV9sJO+X5RiPLaQMJI50BFZU4cQ4pw6j5Y1EgVn3HYXFO1Ltmqh2uDYg36bNiM6vQwk
         gRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740097850; x=1740702650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6gT9dQPxIC9/sJmSGN9CJieKdgmQ7IWoiLicVCIbDU=;
        b=I/7srRkl2FB2HAB0EF2jW0wuW2926dR0XR7cGpNKQwdcuh9docg8o59H9hyLXZ77Ul
         J2RD8rr20ISKp7GiU/y8ICVZJEs4imhgCSS83N21HA+drIbgyACLr1CwkvZ0n+RLL4wZ
         9v85DBvYdcAnqjEvhzoPzZlhuCr/mQz1lqcrfsLx+diGnzGLRbCmOCowCTmQSpZUlvyc
         0y8/2HG/OxG5x6QtRUxHbYeB4VTJpOV18Kjf+wYeigTxr+6rCu2NC8a/gh9hbJXkM/9s
         PWdJs0F2pWw9tF5xURpSDt7EH6j2Y2MhwsDXBeG7x8Qv0m/8tcyygcsw8kFq4iOk35/z
         DQow==
X-Gm-Message-State: AOJu0YyRwMoccuYB6eNHIeR3fthnu5T/Tn2f03RZZrI+h9LvM4ySLlQB
	LZwUy7GxNufARFhMoBq/WPMUHiqkY3G6L0eW8RISb2wpXfrsJNfe8HdEV/SB6LUG5QjIPuPCqYF
	D7pbb4GmgapiU4ZMYTq8A9YB2dTA=
X-Gm-Gg: ASbGncvMZB71ni3AP/p6QtdhS0GyM1Z6Uh1thKfSIxgu6FQOwDWdGVOtltpsK5R2BvA
	1eHOyVlISXcgO0vo0yv6Emmv0rxCIpoeTff4MsdVWjWR+gOgQFhyPgVmzSYK7h0UTFKxqtc9wi5
	fH4aBXT6h716Sr
X-Google-Smtp-Source: AGHT+IHwklNbPbXm3Bey7TEh8pkr03FEOcBInEyDLG9YW6s66dE4nJ4wvnE6+fNvjkM0qUy0PIHXVnaGyBo+XthriN0=
X-Received: by 2002:a17:90a:fc48:b0:2ee:c04a:4281 with SMTP id
 98e67ed59e1d1-2fce868c8d3mr1174167a91.6.1740097850031; Thu, 20 Feb 2025
 16:30:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219063113.706600-1-pulehui@huaweicloud.com>
In-Reply-To: <20250219063113.706600-1-pulehui@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 20 Feb 2025 16:30:38 -0800
X-Gm-Features: AWEUYZk-7gCvliD-Yg_lHeGZ3-8EAs5Z76JUaZ0REQC2a-WogcVFcC1ZhViQViU
Message-ID: <CAEf4BzYJLKZpuEsbU-A1s7wtpG0YQKUHG3QDaQoDH8B+VY0oSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] kbuild, bpf: Correct pahole version that
 supports distilled base btf feature
To: Pu Lehui <pulehui@huaweicloud.com>, Alan Maguire <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 10:29=E2=80=AFPM Pu Lehui <pulehui@huaweicloud.com>=
 wrote:
>
> From: Pu Lehui <pulehui@huawei.com>
>
> pahole commit [0] of supporting distilled base btf feature released on
> pahole v1.28 rather than v1.26. So let's correct this.
>
> Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=
=3Dc7b1f6a29ba1 [0]
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  scripts/Makefile.btf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index c3cbeb13de50..fbaaec2187e5 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -24,7 +24,7 @@ else
>  pahole-flags-$(call test-ge, $(pahole-ver), 126)  =3D -j$(JOBS) --btf_fe=
atures=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func,con=
sistent_func,decl_tag_kfuncs
>
>  ifneq ($(KBUILD_EXTMOD),)
> -module-pahole-flags-$(call test-ge, $(pahole-ver), 126) +=3D --btf_featu=
res=3Ddistilled_base
> +module-pahole-flags-$(call test-ge, $(pahole-ver), 128) +=3D --btf_featu=
res=3Ddistilled_base
>  endif

Alan,

Is this correct? Can you please check and ack? Thanks!

>
>  endif
> --
> 2.34.1
>

