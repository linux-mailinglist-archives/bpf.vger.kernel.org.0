Return-Path: <bpf+bounces-47415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C8D9F93C9
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 14:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3DAD16F66D
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 13:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A182165E6;
	Fri, 20 Dec 2024 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIIDe5vf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB7E1C3F3B;
	Fri, 20 Dec 2024 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734702951; cv=none; b=Rzk2C+tLPFHJlU8ovJ/bU//j0xG3rhyAhuhiSzHXRP2YhbXogKG7+2Yir17NrJYJ8PCM/cec3BbPfggaAQ9deQHTnDzaHlibmCrbrrzHA43H71fZLG8oWqpHICE+rrN51XeJkaOUqZ0TvIoe4z+h2sK0CUreVto5cPclDJNn6bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734702951; c=relaxed/simple;
	bh=wbrarCglUa9+iuNA4uIlNMi7O8wn4+eWSHj2Bn6oBOo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTTswF9RQL18DMaC0BENs3XpwUGKfr8rt+6rPbJsQEyDthhaXx9ErMvdVl7vDKnVbZ0QJU9evk9BVCZ1fIdr0G/tYhv3vXMqy7E3vXpVNe14U31nTAJgoBsmR95/nWUi1Tc1pnTO8obk6oAefEckHfidQoclyVb9NbTzDtL0mQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIIDe5vf; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so3090380a12.1;
        Fri, 20 Dec 2024 05:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734702947; x=1735307747; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ZfoEgCtUD/GDU/ljraPXdKu+rsuZh5wrUTuZudBI20=;
        b=EIIDe5vfzv1Yk0ZMWCef7iJCEk7ksywchXHuYY5B37rbl4js7i0FME7D4OLVhGHLT3
         L0NkQiFBuBMEd9ZO5M/btnua1Gj5GBQqX0uD4db79g3UZUgc17axjTHia6Dz7BANetjH
         7IgYDCLUhSiesS4MVxQzpeJKkU1x8p3OwsBMurn1a08mFn6z/WS5av6+BMYL8MqYcpgx
         sGCCjvFar4yPvKgyzyZlkB4c8/RZ+Le0m/RYdkzu0DJW9f2hyYBS/7haynXMyZ3Q9bFX
         oTOVgbFIyCMvZ9DUojUfI2F6hLeT5qCj2WrKebwWcLtbvYbrMz05hVvVIVz8iruoodcu
         GbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734702947; x=1735307747;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZfoEgCtUD/GDU/ljraPXdKu+rsuZh5wrUTuZudBI20=;
        b=jzUsQKPwp/tHqgXdTo1e7oNOnZcmIr2HFfYwr8XO1IzC6eTIWMaaQFMXvZjn/V2Mjd
         0xiY7A8dMtVNFOH4HBDnQ/oSVay/wh+NeYjsfMwueoAU7oPQcrP4SYRPIQ+JQjgASUOq
         4LWn6qK+Fvjzs1GAIiLlLBPQ6boL4cyDrQgM+WcjTxdpfIpy3v46/EK+jhD2UbFOuoRV
         +njsNBhNH5S4zGlrJsZiYpJMUSxNp2la06J0x62Zob89cTZb9hHke1051/FYvaf0sxaN
         MgJf8m1DleyiFAqB1XHArxJMWyx3auX6VPzATI6SgVGuVvgOeBlX3TYpiEiHt82nwOI9
         4Tiw==
X-Forwarded-Encrypted: i=1; AJvYcCUmXVAxdD1+vAdusf/6aZjH3BP5j2VE5ijXJ3RoeLXausVL8ijEQxXURtUe3x3PdGEo1FUzBtO19Af1+zGW@vger.kernel.org, AJvYcCUwwkE5asWgYPAPhUvSpkD0wkg3A7QhoguVJ3b0jN8EnU28uCouBuI91J36kSFvvtJjn/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylb+lUfP+Kn8w9Mv5FznhGnVgf/kPJqB07TVVkxK00BQE5WBz6
	S6nxJHdxG/uJFrWQ1RMI8n+kydzgWH8vmAzXBaccKVXyA2I+OS71
X-Gm-Gg: ASbGnct2RO2F6Vj05JO1e9G6/3H7oYctqRI/iz987oJ/pUYMlWPJnYvDIW6CilHeAGl
	6VYknbYS4AUPrzvs3mQo4l/MiCyZXq8YomCrIFaIZhhaUomr3rLt1d7AujFwNXS2XEH1MWrLYuO
	Y7CGo5ly8DZonYtkby2MWWSRLOp9VkmhhjZaPO5iK7Cy233tDobNNlIxtXpOXdfQJKCxC/7JVvs
	H2G4n1ZjYmiAo63E8tv/B5IlP/LTD4Dqj+Bncp4RG9NrGUchOYpcmIpMuYvRaK1ZUlVt1hx4e+r
	P+5oT/oCMhM/cyu2P77cMGmShjHAtw==
X-Google-Smtp-Source: AGHT+IH53FtZj8Cr0qnbQSyFgL3P1ggCMrl6RVaKIlx5g0nso5As1eE3DOMnFBbZxAEVq25eSLSmcQ==
X-Received: by 2002:a05:6402:35c5:b0:5d3:ba42:e9d6 with SMTP id 4fb4d7f45d1cf-5d81dde87bbmr1966735a12.17.1734702947288;
        Fri, 20 Dec 2024 05:55:47 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a71fsm1751147a12.18.2024.12.20.05.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 05:55:46 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 20 Dec 2024 14:55:44 +0100
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Fix holes in special_kfunc_list if !CONFIG_NET
Message-ID: <Z2V3YKafR949GFuA@krava>
References: <20241219-bpf-fix-special_kfunc_list-v1-1-d9d50dd61505@weissschuh.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241219-bpf-fix-special_kfunc_list-v1-1-d9d50dd61505@weissschuh.net>

On Thu, Dec 19, 2024 at 10:41:41PM +0100, Thomas Weiﬂschuh wrote:
> If the function is not available its entry has to be replaced with
> BTF_ID_UNUSED instead of skipped.
> Otherwise the list doesn't work correctly.
> 
> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Closes: https://lore.kernel.org/lkml/CAADnVQJQpVziHzrPCCpGE5=8uzw2OkxP8gqe1FkJ6_XVVyVbNw@mail.gmail.com/
> Fixes: 00a5acdbf398 ("bpf: Fix configuration-dependent BTF function references")
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/bpf/verifier.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f27274e933e55342dcefa482a9ac75313d0d3469..44616b492f87cf4e1dc354e34d9158f13079dda7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11739,6 +11739,9 @@ BTF_ID(func, bpf_rbtree_first)
>  #ifdef CONFIG_NET
>  BTF_ID(func, bpf_dynptr_from_skb)
>  BTF_ID(func, bpf_dynptr_from_xdp)
> +#else
> +BTF_ID_UNUSED
> +BTF_ID_UNUSED
>  #endif
>  BTF_ID(func, bpf_dynptr_slice)
>  BTF_ID(func, bpf_dynptr_slice_rdwr)
> 
> ---
> base-commit: c2ce3bb13ae7f4445a5e8fb12254b2dacefd309c
> change-id: 20241219-bpf-fix-special_kfunc_list-cddcf0ba5216
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 

