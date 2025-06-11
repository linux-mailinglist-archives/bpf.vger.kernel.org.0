Return-Path: <bpf+bounces-60302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0E2AD4A6F
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 07:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0AB43A55A1
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 05:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680CC17A58F;
	Wed, 11 Jun 2025 05:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nF3w2IIF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997DBC8CE
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 05:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749619866; cv=none; b=QC6AYawLAwJDUeQ4dXXK61VdJMTkdybGFZeTuzBj156gExWCPis6j2WDENMhojtCf2kRIgEjGergYOLciJ++mfJfiHseVU7lO6vep7AvcoRhaLKhqau8lMvbJmqXqvb9/GL2Op9lEFqa8rt6SEFtFk5z/yQBGjQ5I07U19QKvn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749619866; c=relaxed/simple;
	bh=dRH46/1hNLBiXkjN9kgJL81svW0Uw8xj53iNR/ajQlQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e5IDmAFyTQ5n2gyp0kEvapjIqrbnuKt1EvgAn1MLo9mjxOsxdEZwiw5BLWEKPjg64Ztm0NySYBU7xMx5hSro7I2rmfaFW5sC1Rry+s1ylwF1EMICPt46wlizCqn3viqoOC9Xn1mdoVZmAjuSgPcUoFcbEb9wZgesC204TuPb0oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nF3w2IIF; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b2c49373c15so4361885a12.3
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 22:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749619864; x=1750224664; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dfiU1NAwld4VCnc2vxBMtZOueJCRPQQAjvibob+nkrU=;
        b=nF3w2IIFGLHzepN2ioFXce9eI99VbEDRrKoJiipUlLdhQikqvUKav/WJcAgLyd84YK
         JVBeTwxeBn0lfREWYCmxhOCV52WisuaDqm77uVcSqJmborrDoNRiUEn61KdHbdv/iUed
         26yLMY4rhCHwr9BH3Zk282pg4ieRJ7BEDNQpMN9LQpkqVvrRYc++LZ8wQ04DA4VuwMXP
         a5R+FvLwe0Bo9zrzsOrmRloNBYQHHSfNaDVBnnz8+eofR3NUyODGtSBe/jBDp/14Lj5+
         +VN5uF+35/utITpoqRrtaRcOVDngWt1OS9ByGl7t7e9uI1IV1V0uhrsR3xQE36ZoQXs2
         U9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749619864; x=1750224664;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dfiU1NAwld4VCnc2vxBMtZOueJCRPQQAjvibob+nkrU=;
        b=ItdbIkWzF6SqzVMp9vuUMIpTqkCN/GNruqN+yiGPIkrykxRQYO4Wq8FYxvc8r7vsRB
         i8oLxMrIph9jEtiqeBlUTLDp8nnKOcOQpqiUy4dRA0ecQvZkSrtOsDTDHxL9Kgvt+8io
         5TtEENwYUpvF/kNXNfl2RdsuSGROrpvt3rgnFU6qTqb5Ih9qIL4yuG62TGIwsibNUfVU
         g4hLOg+YIKW0IOwBTHtFS64FU9tkPsHAxMm+K1xaFe8gAOM4FQG3dnv3qpFcX5CFNc9x
         R+cl8FcRhMPxYlC/yEFoUsljcGWnrQraOkc7TSVbgNI/fMhO1beViSEMd5YEZLK77ao/
         m51Q==
X-Gm-Message-State: AOJu0YzC0xhTwsItvtFZ/uASLTeBowIkfRy9gMJCSNZoNRxYDW93xdAq
	QF6EufYy/4miKchr1mnNlzJpextb60xEBlR2JYPgWYpEXCf0DQggw2yU
X-Gm-Gg: ASbGnct6kfMfyo8JIgucrk8HinwYYwEZA4FcQ4JTQkLFjA36JX035JMUW0ZDWsCRH2w
	hkV3wKOeZNnibylun/7Zrrusg6aOIoOxumEUUzQytSrfSmhwRBUqZGydc/k4Wbk8XXAlw5JpMEh
	aWkL9lv8l+7Zz5KxSYOHGlklDKgMbejyJopIKblbc6+0ReLRzAnMJx3pZdfedbhBeOPHTs6Xnn4
	si/OoZRnLDmcN0360463hC7bcjTde9OlsuQqmh36hbc2cwCAJBVjQMo7WptJWw2y0jxiM8iOrwX
	Q5UaSwlarvgwB6KD0wZEq/+J/7ndK5AtCRkJ/hSvvRSy+GVIYAIYsK/DrA==
X-Google-Smtp-Source: AGHT+IGyjmLpLw2XTmspnJXfyXbXxrlMC3v2K/x9mBioNB1sLVLJ3HVy4DjW+Jq195jSBOJ7ARgbwQ==
X-Received: by 2002:a17:90a:ec86:b0:312:25dd:1c86 with SMTP id 98e67ed59e1d1-313b1fdabfbmr2044053a91.18.1749619863698;
        Tue, 10 Jun 2025 22:31:03 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313b20078dfsm492088a91.15.2025.06.10.22.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:31:03 -0700 (PDT)
Message-ID: <5381e905bb6f782493866a6cf8aa859f2b1e3170.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: more precise cpu_mitigations
 state detection
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, 	mykyta.yatsenko5@gmail.com
Date: Tue, 10 Jun 2025 22:31:00 -0700
In-Reply-To: <CALOAHbDPkbhun3KFXpwTuSKGzOx4PcUBhqDriofMgzwCXxR8_A@mail.gmail.com>
References: <20250610215221.846484-1-eddyz87@gmail.com>
	 <CALOAHbDPkbhun3KFXpwTuSKGzOx4PcUBhqDriofMgzwCXxR8_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-11 at 10:54 +0800, Yafang Shao wrote:

[...]

> > +       config =3D gzopen("/proc/config.gz", "rb");
>=20
> The /proc/config.gz file is not enabled in certain kernel releases.
> Should we also check "/boot/config-$(uname -r)" as an alternative?
>

Oh, my... It's a zoo, on Fedora the config location is:

  /usr/lib/modules/$(uname -r)/config

Tbh, I was fixing a problem with tests execution in a specific
environment. Adding a list of common locations for config is an
option.

Another option I tried but discarded is [1], where
kernel/cpu.c:cpu_mitigations variable is read directly by a BPF
program. But this is probably too heavy-handed.

[1]  https://github.com/eddyz87/bpf/tree/better-unpriv-disabled-detector

[...]


