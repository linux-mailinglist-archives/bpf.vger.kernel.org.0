Return-Path: <bpf+bounces-53245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4365A4EF88
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 22:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4255D3AA215
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 21:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1244724C085;
	Tue,  4 Mar 2025 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJmiPp4V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440B51FBEB6
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741124904; cv=none; b=YM9PeWDkRwfppO7K/HqgDBuXilcR8a6JPJyg4ebhvi5qH7Stfaa6/q08L1pRHSsMF4JzPXorByB5OySaE8a/jc16Ews1zOJ96LftV2KW80XpK0JATgle9NxYJ0lw4g636lMrsWifWRadIUnjKsxgFfNdeqpnxqsMkuz/9wNVYj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741124904; c=relaxed/simple;
	bh=KlJ1Z4SgERjzZorH9uR3P+6ylyXPO5hX2WPKMQD//lg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qA0la1wetZM2W0hF2hz8Ucd5Nlq6vDznqukicbAsMiLE22QfBdZbBg3fJCXE133+DGKruKGwkGNJDc1CygCO+1s4rk34xyJGkyNKH0fEZP4uD0cs+MgBiEfvvP9G75XErEWfBls1+VaCM7YvhvmV/4R7ePpHeYgDBjI6CVo72zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJmiPp4V; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22374f56453so112707795ad.0
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 13:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741124902; x=1741729702; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XZJyJOl2eKC8PzzTIBjshuB/L3pwkP9ELglLrNR4HO4=;
        b=lJmiPp4VFrQbLGd03CD3FmQCzGtVNcOHpiIhreeMO8GKOubCbA8XpypMs+nzXKqS7+
         Xd10YEhOnoNPvD4xqRjNnVG/7HPlkYjkD7bvYavBqjseF8oMETtX0Jxw+HMEPEkUFdT9
         f/QzmkXjqLCGPU3KBLWpHqOtAmoKMC0wFQdyw54lfYKJNGaT4dHSsRgAC1XpXHnE9oJE
         +WLbfWPOD2/GfY0mgo4LoUcnra+OpNEiNoG2cF/jpoba0uKypq/YWtx0twGlXZBs4f57
         rsOyBF4/tKm0lD0PPwLivZnSgqxZAtlYsUsTvRFEBcr8ft/qpTOMyE+uFPCdqMaVfStB
         FGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741124902; x=1741729702;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZJyJOl2eKC8PzzTIBjshuB/L3pwkP9ELglLrNR4HO4=;
        b=P0RZjivzjg/yJaGeHahBzi165oLTJc7lxNC89YcpFInh8h70Ugu587nY7mzIr1vf/u
         UjAA7X9o4/O/gPq7uyRxDbOdUapjpSbYPCDKJNIhlV5mekUjJY5C5IeDYpYyy8EYLOIG
         nMbxmUh9Is2JPP3Kb2o/RyDscXKvWoSO2cIXORUm/iOmlLmK2yBWqZbcnXxqu5MB2umd
         F/CTocNyztur2SFzBfySPvrFJDtTD7lxh4Z4ZQmBwLm2lOJySGpoKIVIaDsPkcJb14GB
         99DDpuwtQ1A1GjsiK0jrFTUsERoOqBZDRjTe8QVLvgXNIlxhYuWI2g02PkuPxNXy99Wb
         jWAg==
X-Forwarded-Encrypted: i=1; AJvYcCVbrX9n/DcLwy/NUJeDryOYBo3FLK1hiid+srIIRRBhSqKtocDalZctWscpOZfRP1CZd6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YypAzX8O626F1FCywXmvCmpeuUAQqj6oraFL9IVTKN4e3Oxa9/K
	MVfFv2tZ+KwAOco1b0Jb4BPKLqGbnTaI2r+qaEYX8L3To8GVciwP
X-Gm-Gg: ASbGncsaZw86RzMMgTqFN9LflHoV6W1ujFfnzk/eeXMHvD/aXEsnFJi09QYK0p58kCS
	BLCFlvP7TqPamnxvE5L4MfTUGdkyD9uDNqoHmlaCjTmP7nzKe1+//XYBsySXQcqllBH/AERxxhI
	DVWkl8Z1g4YFEOqJQRVMSn9Mg7FcxC2zSUXyB+Mv0Qwg47pwbPGc7tXQnMVeXCQKkHCSIhBZ5dO
	9lEYNEL5O2pto9czn8Y1iC0vpWZ5JLzh+LgpdQLhHR9s8WsBxs+U2MmOApjs4kEGORmhHZUA6zS
	/x73UPQImom19kKudDE230kPttQMEdEIH499O8r9XQ==
X-Google-Smtp-Source: AGHT+IE9hEt3i2BgFBdYXahk9M4zNf8TFU/LoDxPgdTnA0F1N0PbO4uD4MwNZ/UPx/I1K2lKqw1XVw==
X-Received: by 2002:a05:6a00:1804:b0:736:43d6:f008 with SMTP id d2e1a72fcca58-73682bc0934mr801185b3a.12.1741124900213;
        Tue, 04 Mar 2025 13:48:20 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73648f97953sm5485903b3a.166.2025.03.04.13.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 13:48:19 -0800 (PST)
Message-ID: <891505bc040c9dd82814889b2da52e299132cc89.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] selftests/bpf: Clean up call sites of
 stdio_restore()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Date: Tue, 04 Mar 2025 13:48:16 -0800
In-Reply-To: <20250304163626.1362031-1-ameryhung@gmail.com>
References: <20250304163626.1362031-1-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-04 at 08:36 -0800, Amery Hung wrote:
> There is no need to call a bunch of stdio_restore() in test_progs if the
> scope of stdio redirection is reduced to what it needs to be: only
> hijacking tests/subtests' stdio.
>=20
> Also remove an unnecessary check of env.stdout_saved in the crash handler=
.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

If anyone else would look at this commit, here is an alternative
description:
- functions reset_affinity() and restore_netns() are only called from
  run_one_test();
- beside other places stdio_restore() is called from reset_affinity(),
  restore_netns() and run_one_test() itself;
- this commit moves stdio_restore() call in run_one_test() so that
  it executes before reset_affinity() and restore_netns().

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -1943,6 +1938,9 @@ int main(int argc, char **argv)
> =20
>  	sigaction(SIGSEGV, &sigact, NULL);
> =20
> +	env.stdout_saved =3D stdout;
> +	env.stderr_saved =3D stderr;
> +

Nit: why moving these?

>  	env.secs_till_notify =3D 10;
>  	env.secs_till_kill =3D 120;
>  	err =3D argp_parse(&argp, argc, argv, 0, NULL, &env);
> @@ -1969,9 +1967,6 @@ int main(int argc, char **argv)
>  		return -1;
>  	}
> =20
> -	env.stdout_saved =3D stdout;
> -	env.stderr_saved =3D stderr;
> -
>  	env.has_testmod =3D true;
>  	if (!env.list_test_names) {
>  		/* ensure previous instance of the module is unloaded */



