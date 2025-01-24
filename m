Return-Path: <bpf+bounces-49638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E65BA1AED6
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 03:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79FD016B2D6
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 02:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C0F1D619E;
	Fri, 24 Jan 2025 02:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V48qY1s5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759931C5F33;
	Fri, 24 Jan 2025 02:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737686717; cv=none; b=vFPVJ1vptDQlZEoiEMClyRED2irmnfFJCEMQL/y/gH/LM13Z8/gG3q+4veRKxrsCmgu+v/ua5q63bPA2P4PrdWN6Ak27guYALmG+bLFjwnWvoWekVkhAm+Ve6Gkoi0NJk0Dwj0KEUHfOFSlI5CCj4sR/TU3G2bJZf6KhsykSSBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737686717; c=relaxed/simple;
	bh=AGK4PFDghSQSTeGrgxUFnwcXS/yxeQImh4MkmJxrK2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Innb+yvdnegLbPh57wqSN/Zdi+eHkdhbxKW9n8h/i3C/lzvwchFMO/Rph4qoR1YJ3a58jxEWqesXBbNTjJrFcZSEX4WDvLaVALYAEC9xLxKVAXOIaAnbIoRDsJIApO5mcMXl0mXZY9JhnaROF88M4vYJ4YdpSIDccRKm0C7aAFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V48qY1s5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21631789fcdso37279665ad.1;
        Thu, 23 Jan 2025 18:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737686715; x=1738291515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GePSqs03Aexh6HgXJIw+ZOzcN1MnAJHA3c0/jz1hhjE=;
        b=V48qY1s5fxdq4/0alixLYN0O5PkFVtzWp0mlGHFAZZFH8egOWSdC3idTjdKL+b7efS
         iuqPdCeybWUlAQbeUiRUTZKAUxxPoT7GxJCv/4Y1768MdfKTdJ5xwBQ2IvTKlNPZLoZq
         VbrZRYPNz+IWCm0PtSXy3IIPc80mrBVy9MZYfVBTbvtjViMquRvWwrd1P5GILZbSH0AU
         fFHFsFvoNOpiFtmjdRruYoqYpSlzBmAPDoDYN7kE2klqiCcElxBldwN+jKJ8KTK8OYGb
         YuhcKPT8dtSQN7EK/Iiz7hXGesw+6dZW0b+ysKbDDasy7/78vOlz59OiBcWt8hhyyAw5
         ajbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737686715; x=1738291515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GePSqs03Aexh6HgXJIw+ZOzcN1MnAJHA3c0/jz1hhjE=;
        b=Q+kQRlm6cFCaC74kpCe+yrhnKAvrVXMMvMtiBmOJU9LT2iWTCEqmNU9ewSHnfnhD6b
         AkANlUlJ4fiewxFGIsZJrd/XrKZgVSBNrKZDT6ds5uC4VdYmKB0HAD5VcGno5KQuTgtS
         X2HjLBQE8azowvK+CTdzuhdfzSmtImwQjCwHz5nOju4n5x9gkR6yUAi0utZ4sk3dVaV5
         ljZf+fRtbOyzC9zQxT+AlzpWuFiugEyUa6qaWORUZUSxIlP6n1eJBO7Cz8v5pMCTHzrw
         rRlRG4mz8mc8sR7MhQBe3uqfrI1AyfkDtTXF5sNWqLUz2OaXpO7nIlYyBi1IZZQdO9yD
         VWnw==
X-Forwarded-Encrypted: i=1; AJvYcCV6kufRDE4vKf6JCf7bBc/Oyf7CbEr4N7C/zGxBHR5jOuOSXUTrfdAdqw9wUapsdV24vMI=@vger.kernel.org, AJvYcCVT3rqdvpPANA5xCIE4FalF4GwZSpjTWOPsk+avUFljKJeX4RDYJ3UHOpatVduffuBXIKaa4u5A@vger.kernel.org
X-Gm-Message-State: AOJu0YyuNsTxtBhPoJ7vrIsXdz+Q/KJq076gJQWRj0U1rZuwP4kxrRUt
	ogRY0vIdkABUtWM7Co+FjnDYgTFIXuEy205YZdg1O8euvKpktcQ=
X-Gm-Gg: ASbGncuJNmRDl31ho1ZPwcPGDM4NJb3ZoNBokBXERu1Xgovwqi3AgdI5n4aeuvI61Jn
	LS81c8cmd2Hc2lHQ0CA+30N1m35rKxu4vApJINjZeMcLGIdvAFiOBYe7+/ePGYLxknCWzxoT0UN
	WgAD5RxxXnT7D+R5OcE0m6cAm6BPHzgO8b6+28DWQ4XgWY98AroSv+ONF6yhb5SVqg8vusoLRGM
	r1ufBqYBzXEEav7Alg6szvrE4DayR2f+AKr7j8//3L7n4jMTVaVyKHonVGpH732ga6RW249V/1v
	+BLCx6eXte7IH24=
X-Google-Smtp-Source: AGHT+IHz4SfDUQRu78nxEFlQ7GNd/xQ1tPysAoM3RuyWNKfaGxCmvpmgxaxqlLI9+RwKo3dxLcCSVw==
X-Received: by 2002:a05:6a21:600f:b0:1e1:adcd:eadb with SMTP id adf61e73a8af0-1eb696e2d17mr8901431637.11.1737686714585;
        Thu, 23 Jan 2025 18:45:14 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a69f401sm705410b3a.29.2025.01.23.18.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 18:45:14 -0800 (PST)
Date: Thu, 23 Jan 2025 18:45:13 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Shigeru Yoshida <syoshida@redhat.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	hawk@kernel.org, lorenzo@kernel.org, toke@redhat.com,
	bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Adjust data size to have
 ETH_HLEN
Message-ID: <Z5L-ubBI7z1J6IDi@mini-arch>
References: <20250121150643.671650-1-syoshida@redhat.com>
 <20250121150643.671650-2-syoshida@redhat.com>
 <Z5KWE6J8OtRVCFDR@mini-arch>
 <5e342fea-764b-48a0-afda-4adfb504bd46@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e342fea-764b-48a0-afda-4adfb504bd46@linux.dev>

On 01/23, Martin KaFai Lau wrote:
> On 1/23/25 11:18 AM, Stanislav Fomichev wrote:
> > On 01/22, Shigeru Yoshida wrote:
> > > The function bpf_test_init() now returns an error if user_size
> > > (.data_size_in) is less than ETH_HLEN, causing the tests to
> > > fail. Adjust the data size to ensure it meets the requirement of
> > > ETH_HLEN.
> > > 
> > > Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> > > ---
> > >   .../testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c  | 4 ++--
> > >   .../testing/selftests/bpf/prog_tests/xdp_devmap_attach.c  | 8 ++++----
> > >   2 files changed, 6 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
> > > index c7f74f068e78..df27535995af 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
> > > @@ -52,10 +52,10 @@ static void test_xdp_with_cpumap_helpers(void)
> > >   	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to cpumap entry prog_id");
> > >   	/* send a packet to trigger any potential bugs in there */
> > > -	char data[10] = {};
> > > +	char data[ETH_HLEN] = {};
> > >   	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> > >   			    .data_in = &data,
> > > -			    .data_size_in = 10,
> > > +			    .data_size_in = sizeof(data),
> > >   			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
> > >   			    .repeat = 1,
> > >   		);
> > 
> > We should still keep 10, but change the ASSERT_OK below to expect the
> > error instead. Looking at the comment above, the purpose of the test
> > is to exercise that error case.
> > 
> 
> I think the bpf_prog_test_run_opts in this dev/cpumap test is to check the
> bpf_redirect_map() helper, so it expects the bpf_prog_test_run_opts to
> succeed.
> 
> It just happens the current data[10] cannot trigger the fixed bug because
> the bpf prog returns a XDP_REDIRECT instead of XDP_PASS, so xdp_recv_frames
> is not called.
> 
> To test patch 1, a separate test is probably needed to trigger the bug in
> xdp_recv_frames() with a bpf prog returning XDP_PASS.

Ah, yes, you're right, I missed the remaining parts that make sure
the redirect happens :-(

