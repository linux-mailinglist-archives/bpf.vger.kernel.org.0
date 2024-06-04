Return-Path: <bpf+bounces-31284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007318FA855
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 04:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C56C1C22E67
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 02:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8F913D2BA;
	Tue,  4 Jun 2024 02:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zr14eSCa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CEA38B;
	Tue,  4 Jun 2024 02:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717468683; cv=none; b=FR3opwaGe94+1T7ZtiyDLhOq2cN2G57nRqb1q+VaxMVvJhOYcEUwu1pmGSvSlCkFiXMgEwCsNhOUKb1otPDNije0EK00wuaR7NcPNmq2Lc5JH7PxiK+JmkOsPtVK1WRwbaT6NgDSNgkMmy/37P2Jpljrx/hSdvyHsYGiXIiDv9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717468683; c=relaxed/simple;
	bh=0+LwfgOiKTvuzrLIydgZzgIT1hUMnLxgd/J5XwVfLq4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uecbKjZBYYvyQFblKet98407Uc5mHB5pVpEKmBVTD8nMEfOjKjA9I2eLYu/o70Sa5O2ygXOKaOaScZK/AfloIWciqNtyqMhomCjO5oJS0UvNF11bPy8F2lxK6O4NEdno7dTK1yhNwlPLUCql+bx7c9POq3yMk/0JlMuouB6pAPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zr14eSCa; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c9cc66c649so2625830b6e.1;
        Mon, 03 Jun 2024 19:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717468681; x=1718073481; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7BYoaXfmT8TjSE0q6DX+DB1JvtjstkiijHOIkCn8Mnk=;
        b=Zr14eSCazjU6UMrVUIU/78wudhnnD71tGNa2Ff/aC7L4l5F3vn4gG3WyY9U2N9XUYd
         cuFysbYftsNy37i69Sqzw0Ym0SkkJ4YK62K3/LsRdEIfhS2r3xTIS/KTZo6Vy3i7WCJS
         /SZ1UqGOFhl8b9xZr4v6jqm/hRSMa07iqhIP7lCy02n5OJBa/uLnZNWqYTBSo/15Juyg
         87TMUmqrClm+0lwV2WCCxiU4BQlsDkWUKaHMTQFQ58mYNlcqaTb5S9IwYm/1qJKBaYoF
         vB7M5ts72yMZtNB7hTvPMcRlykpFNqaN1ZC8mE++jSmrKxFRxSr2ewrSPiuTmuarMoq7
         pTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717468681; x=1718073481;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BYoaXfmT8TjSE0q6DX+DB1JvtjstkiijHOIkCn8Mnk=;
        b=rpIX3SN0YScUe0LyiJC8hzfdthHKFKt5M6eNN2Jx3fvxFr/Q+2V91NF4xQModAqVkN
         TTevmSRniMJiQJxduLgCMmbNA6lJSM7qFu6effa6IgKKoq6o/QJPJaE9umyYmaZEQErG
         gWmxqf05yFe7Q0+SGmPPCDhYTTJN95JxqUFJ+y6F55typJPS4GV8z4FqUzxYsn9zVWSx
         sJ/ogNgzk6RIuSOTH8/GzpB2gdlhOnTL7CAcel7tT7radJOi8+AX7OUefClwq4UNs+Y9
         y1KNPcfXgLqb2EXxY257Hu8Bf9/969NYwTIFaiuaOpsoj5eRYaFsQnXYc/e739rfYyyK
         sNBA==
X-Forwarded-Encrypted: i=1; AJvYcCVvVfDNlhqrX/cQEWuqwi/k4om8Sph1/kHdVaWpMkN0hA3asEo+Z3Cb+pAIXSY6rEF2Wt/f9K7j27qN7hdRwT52bt3WB+G8
X-Gm-Message-State: AOJu0YzpMNYrBH0UVh3yxBSmr2LW5+BbCdrOruiv6L1AALEKjGEDhU/g
	Qw+raetK6Wj2dQQPSKJgy+IB4Fqho0aqId5Y/Zj6uwI3d4V89/zh
X-Google-Smtp-Source: AGHT+IEAZ8rdzx5W4Ir4TiU3E0Mm3w9pAuzH0MuyaBs0WDFFjKeWk9MG72pW9A2TDhMeSHcMCEEjIw==
X-Received: by 2002:a05:6808:11cf:b0:3d1:d1de:e039 with SMTP id 5614622812f47-3d1e35ad31dmr11205392b6e.29.1717468679380;
        Mon, 03 Jun 2024 19:37:59 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b0579asm6449407b3a.161.2024.06.03.19.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 19:37:58 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 3 Jun 2024 19:37:56 -0700
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH bpf v1 1/2] Compiler Attributes: Add __retain macro
Message-ID: <Zl5+BD50xtAQcfZb@kodidev-ubuntu>
References: <Zl2GtXy7+Xfr66lX@kodidev-ubuntu>
 <cover.1717413886.git.Tony.Ambardar@gmail.com>
 <5416a38a194bb97930f5a2e672165e573b82857b.1717413886.git.Tony.Ambardar@gmail.com>
 <CANiq72n-s4e=KX9yzf8CivnkxyH-YKShSKGS4upKPpGo=xcRqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72n-s4e=KX9yzf8CivnkxyH-YKShSKGS4upKPpGo=xcRqQ@mail.gmail.com>

On Mon, Jun 03, 2024 at 03:57:38PM +0200, Miguel Ojeda wrote:
> On Mon, Jun 3, 2024 at 2:16 PM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
> > +#if __has_attribute(__retain__) && \
> > +       (defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || \
> > +        defined(CONFIG_LTO_CLANG))
> 
> Since this attribute depends on the configuration, please move it to
> `compiler_types.h` instead.

Noted and thanks for clarifying; I'll change in v2.

Cheers,
Tony

> 
> Cheers,
> Miguel

