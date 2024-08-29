Return-Path: <bpf+bounces-38339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A982196380D
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 04:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454B31F2439E
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 02:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396F02AF1E;
	Thu, 29 Aug 2024 02:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFboUv6a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB1F18B1A
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 02:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724896919; cv=none; b=dkQISyg2cZOogCF9+bbw9nuCuJegXiiylfGQLGuJAcngmA8DldKKslin44f7V0HotmE3qxnX2QoQVgVMKRnVMFciCCw0ctsPQsE6kfaKYQTNkaNt8SJSkUHZbXUYm1lGka6uzqyqgWIoFSqDFKec5ut9WfLR/zq2JEcyKqYTR/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724896919; c=relaxed/simple;
	bh=i2HwQ4kV2UPqCv0xLpqmcaKNSMAR/Sb0zJ0ougd6XZI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ohcwtN2P0UPsl/EvW8bRE/b8j6NQDRQ55bSaG0XwXECIUybe1xiezzpVG93RHW6meJQRev9li2wbi3SrSFGd8yo+MQQXwq5aAecubudggMX717x6e821o80frBazCVgM3QavoGk+hD+uTLwMiUy6HPARCgrPV2OD6PTwOLHnUzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFboUv6a; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7142a93ea9cso135019b3a.3
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 19:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724896918; x=1725501718; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cLAo3tq8o4aWru/snJc3as4ysvbwuMQs2aGtozb6tfA=;
        b=ZFboUv6aut1nwggz8mrgzBS17EnfcFs5btdCMVCVWUn/cYnPXla2q7r6Lf7kUzipgj
         EQOZoUkZFICoZvGXinOmu/dXhh41K3Nqi5CDEx248mXtohqKB+2bQjHNsw31WF2wI3ju
         1cDIy3T9OVo/73XAcXObKvtKoZ39XBxkE1IDvC0rD7OYYh1tVfO6lYohTXih+7X+E8fn
         xgH30yai3dP6pL1xWb0GvqAyogoAwFPpe2KDyxDDzn7lQF7J3XC20Z8iDj3XxlD82ZBq
         7Ir3noEPQ4DmVxbXVY1+BfZqgXK62cOGfZ5LaPsxc2iHACxsmmPAgeNKtW2kE+O/tcWt
         oJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724896918; x=1725501718;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cLAo3tq8o4aWru/snJc3as4ysvbwuMQs2aGtozb6tfA=;
        b=rWOW5iC7Z8oOeyamb6ckF+bA0uStF2ncp+N8ITbZyhV09nAcl6M30TZYlJdoRACqZ3
         Ihx3ontoq/OUWzChtMAkz6G2aCXgesiQHCS4Jxr4JHtP703uo11w6mea/yJyASySwI/A
         ObnAia51bCQrnM/hXs9PJC4ztvF0es9c2DjBHlhXj12NadcTSxNYOTREhXzBKHvSYD6B
         QVhhV00Ol+jgzlzSVPOUKGVKUQgAqoIe4zJ37FGHc6udjRRsMBRhDrBJW8zQO8h0RNnX
         zcbLWdQiWoXf4Lu5+heS0PPd2SviTsr8s16BKZdUWTUPtt0QuMuQ6ZtfknysxzcCwpeX
         U75A==
X-Forwarded-Encrypted: i=1; AJvYcCVJEaotAzKvvP+80tVOhjOhdENA1iK2v2Qjm2lrG+nQOLZgZakonFeFlVzJ0maerAtrp/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPVhaaXkzXI5fjgB5+9v4SK3lXIRQ0sj95rXD58q1AS1oIDVJv
	b6nmO4hp+yfBY3PDU8ngP8pHgQbMt+RxRmuWJHAqe2JEwybheitq
X-Google-Smtp-Source: AGHT+IFCVrOW0KO3P0KiZ9OLkwhpCLFcPrp0RUKfh/XtsmyaGB+rHRWz7cMNu2M0jxCCKCdVNpk2EQ==
X-Received: by 2002:a05:6a21:3997:b0:1ca:dafc:fbab with SMTP id adf61e73a8af0-1cce0feac73mr1774009637.4.1724896917626;
        Wed, 28 Aug 2024 19:01:57 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5749b3bsm124938b3a.187.2024.08.28.19.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 19:01:57 -0700 (PDT)
Message-ID: <488009642cac896a1f5aa30f39d897e484a9d5a8.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/9] bpf: Adjust BPF_JMP that jumps to the
 1st insn of the prologue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song
 <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
 kernel-team@meta.com
Date: Wed, 28 Aug 2024 19:01:52 -0700
In-Reply-To: <20240827194834.1423815-3-martin.lau@linux.dev>
References: <20240827194834.1423815-1-martin.lau@linux.dev>
	 <20240827194834.1423815-3-martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-27 at 12:48 -0700, Martin KaFai Lau wrote:

[...]

> @@ -19705,6 +19705,9 @@ static int convert_ctx_accesses(struct bpf_verifi=
er_env *env)
>  		}
>  	}
> =20
> +	if (delta)
> +		WARN_ON(adjust_jmp_off(env->prog, 0, delta, delta));
> +

I double checked my old calculations and agree that this adjustment is nece=
ssary.
Alexei's suggestion to use delta =3D=3D skip_cnt sounds reasonable.


>  	if (bpf_prog_is_offloaded(env->prog->aux))
>  		return 0;
> =20

[...]


