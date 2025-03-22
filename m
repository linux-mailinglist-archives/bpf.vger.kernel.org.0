Return-Path: <bpf+bounces-54564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFBDA6C75C
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 04:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFCD1B605E9
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 03:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0517386349;
	Sat, 22 Mar 2025 03:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zam5Wuyz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D27E2E339B;
	Sat, 22 Mar 2025 03:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742613454; cv=none; b=FMCJtlid0MDs6TLdk8Il/k3bzn1LECFxqTB3i5I+sxVVasM3lTbvtO+mtrut4+NBk2DAOK2FO+oTok2YmGxCaKsBkNnvzxdU1DdprIYFpq0bR1BdkHu8v/9/Y8Iavqans+u4ZXyGBJ29EprDpVnjxcwvpSfBqzWcvGTCHqhmivs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742613454; c=relaxed/simple;
	bh=WmIYri5geIA6iz6zSAryOlx0KnSOfaMzZ5okPJ46L0o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p7oUwnMpqBx8EGhDAYF60bfenB8AF2VhZonu3OQ2GSVhLB/NaV6s71WaOCmP5Q/RaVkPRMQiBp7jl4mdIpyTMM8ECLiQTZQ4Y21w5Dd8K2kMxV+ff3MCFNPmRZmZkE9c0ReaCcXT3iWNNjOYzt9QjrF1uIyco6ccHZdu9RlohM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zam5Wuyz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224171d6826so23392895ad.3;
        Fri, 21 Mar 2025 20:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742613452; x=1743218252; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WmIYri5geIA6iz6zSAryOlx0KnSOfaMzZ5okPJ46L0o=;
        b=Zam5WuyzCgE7+Kciz4L9eBYqqlPFjlKYl5KAYBPI3lGO2cWhu7eAYzgsSw1W3ZcqdI
         kRMRhWCdYB+XMY1hISlZtOKgh+lazyg9jhrKL1DePJWOjdnp1dG7+5pJSq0IAXafsYXT
         ZWickIDRcKLsQpS0tvKuW1zMZS0Bl3k1x5CzyfZtUAMGgsFtcM5pCSDN3XsegNpwPfuD
         BZd375O3y8WoeraZZMqaBP5uxkmp64M2vufBqhTfRx672OL4agS6gtnBFmARblDXc7j3
         fFuDB7mgCyTwBfZQbKChCpi38DZwmNcfNMPXTSl+IhBl8DJcJ7JMQ/umnfed7TBcoZUc
         lt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742613452; x=1743218252;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WmIYri5geIA6iz6zSAryOlx0KnSOfaMzZ5okPJ46L0o=;
        b=WgJ4ljo8P5shIYNOI1aSwhq0rGMLWyBa9P50M3m+rZ+RP/HPTMTe9xa5be8Tp9DmXl
         HbseFBPiNAXzFyW+CF4U5TglbMYWBwhGW0Vwo++w5aWRlQ7K1EQ2Tdg7r7Ha3ae9T+m9
         HfM6UYw45BVPR4IFE6ZAk95i/3DaPuSnC73UYptPlqh92ScOQBATm8hCrgybe8SOjvzi
         A0BMjXjDbwYAxMV2Rfp75Hc+VSk5gEi5o5g1PMlnoXqPTKWtU6oAeTZgDjsCOD4VO5xY
         Mly2QW+iFsDtZox+zDW4GETd01Hz0TvxQ4WKaHr2fHmosOpxddG7Iq8KCEZ1MCAdjobg
         g1iw==
X-Forwarded-Encrypted: i=1; AJvYcCU9vaXZWU8KY0kFUJVIbNbu8ZOesh9RPx8Ml1brSS2fDr0phpdO9FgRhU7GOUXHMvLfoVY=@vger.kernel.org, AJvYcCUcv+my11mBblT6HTcJ6AwrbZr3H2U+45SZ16dTB1IEBT2i7crBZ+qHZtbajJS5AEJ+XWy8go5GOM21D/LC@vger.kernel.org
X-Gm-Message-State: AOJu0YzV07Iu6gK9LBBJoogjEtZuU8C2ta3oQN6KPSaj5mUrOZCJ0RFA
	1KioXG7GYnYNnnmWBD49/D5ird+ScgTgJ/WbcGEa4uXbVL0grMwT
X-Gm-Gg: ASbGnctIjtWhfgMeLRMCH8aeYWKgI/BYq4t+MYSP0LQEs4bzGVRc+yHhZNey5qB3GZV
	37hcaSV1mKPiepyL8CUPglswFQBhmP5YS7Qki+eZS0h0AU8MtbX2fsVCRI1oamMsarxkSPsjPMA
	aeXEhkcKvayxzPHKmDAoqHHZtL4is8LhrOFyukJ8DguRIMQEGH9WvvIgp4j6PeNMyuCueKxz5//
	62255TTco4qX9YxmAmBVFjWNTwVAmL47GVqWG2S+8UC+HCOgu3f0/XS5RWA5TCVjZ7N6SefEVat
	nZdaZunewTdPezKmItCZA4VrpB3BbJODMGSAMKJr
X-Google-Smtp-Source: AGHT+IFbWw5Wo8cyq6P6QMBtmDT8WXm7+AfSVecP5ctBT93NTLbN8af1L5YITFrWMx1MPJSIjOgZcA==
X-Received: by 2002:a05:6a00:2d90:b0:730:9752:d02a with SMTP id d2e1a72fcca58-7390593b9c5mr7683129b3a.4.1742613452284;
        Fri, 21 Mar 2025 20:17:32 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611d21dsm2916811b3a.118.2025.03.21.20.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 20:17:31 -0700 (PDT)
Message-ID: <cd4c961ef54cc3a03d5f8eb709699a476b7a1300.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add selftests for
 load-acquire/store-release when register number is invalid
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kohei Enju <enjuk@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, iii@linux.ibm.com,
 john.fastabend@gmail.com, jolsa@kernel.org, 	kohei.enju@gmail.com,
 kpsingh@kernel.org, kuniyu@amazon.com, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, 	song@kernel.org,
 yepeilin@google.com, yonghong.song@linux.dev
Date: Fri, 21 Mar 2025 20:17:27 -0700
In-Reply-To: <20250322025013.76028-1-enjuk@amazon.com>
References: <65ff9c62d0d2c355121468b04c0701081d3275fd.camel@gmail.com>
	 <20250322025013.76028-1-enjuk@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-03-22 at 11:48 +0900, Kohei Enju wrote:

[...]

> I chose the minimum invalid register regardless of the actual occurrence=
=20
> of the splat, since the validity check of this type might be `regno >=3D=
=20
> MAX_BPF_REG` or not.
> Sorry for my confusing choice.
>=20
> Since I'm not attached to that particular choice, I'll change it to R15.
> Thank you for reviewing and providing feedback!

Hi Kohei,

Thank you for detailed explanation.
Please add 'Acked-by: Eduard Zingerman <eddyz87@gmail.com>'
for the next revision.

Thanks,
Eduard

[...]


