Return-Path: <bpf+bounces-50018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68A1A21677
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 03:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3A33A4B07
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 02:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F9518B499;
	Wed, 29 Jan 2025 02:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQPwlPMD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225B0DDD2;
	Wed, 29 Jan 2025 02:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738117057; cv=none; b=G6a4YWq1VBaHuwKHzHHwkDb16U96chXfYIDEIcjm2Q8T1uO9fB1RGmBAgC3zYzO4sQTvx0uhCG/ntrRxyi970/VTRFkUo8q4dw0bJgM9FJLQ6hxNCT0SeEWCTeshdoz3W3g2fQf/sDU39VGsibgzyJt/j5fPnLnpVGC+7C1ddSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738117057; c=relaxed/simple;
	bh=L/7rpkCRjrjLUYXMCzO9/+2F2CRM8/XcJAntFkoNsbU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X9snFC6AYcGd2c6BYxXpWKy4OLtBTnIZqnueQ4AW6Dy2UZ6SlcBKKQSo1V1Im1ipsG0p2sxkhb8rHXO2t6Tvo/BoiyU28/Hpd2pVzxioh1v8//Qtsnc5EGPGC/a0WVG9VqXv7C5DUiqe0E1VzoR3AHjzGGRCbleSflxsbL1HAP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQPwlPMD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-219f8263ae0so116807445ad.0;
        Tue, 28 Jan 2025 18:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738117055; x=1738721855; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L/7rpkCRjrjLUYXMCzO9/+2F2CRM8/XcJAntFkoNsbU=;
        b=jQPwlPMD12Kxlju8goy4NSn1Bq+fUo/+UhV8TyZNjXibaTkTdjbDZNEHjwk3gtKE/d
         y+DCdRMK7KfgyggW5A0wkfwR4nmV44BYvZnAk8Yvw+R9fv/cYIFT3VAMB5G3LIJmdQJM
         6z4wlp1SROLemKJkyMaD7iRemEGGYIm3VklUuLgW+Afa+3HrYr3Yvc9UO3c29//m+ImT
         ktIw1Pk79PnAB7vnmsnSqce30Scj1foru1/cDYiQr1zUfvulFpjleOyQtcJpMrUlVMHc
         uxn6WaWMb7MLwABhNkv8BoycmdXmp85bkuCU7IfKqWAi4rm7brB7NVYDhijdQnj9bz0X
         /75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738117055; x=1738721855;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/7rpkCRjrjLUYXMCzO9/+2F2CRM8/XcJAntFkoNsbU=;
        b=HC5wFv60t0ASDM8JAyNVKVLZ1AmcX5fbqPU1mTDaX6oZhqQpz+1f6X4Mtg49NryUcx
         Te5JMKQkfRfxURaLOZ263VUTlFIcfpTxKSUWH39CFVFGgS9X/HwCGfm9iE3D4AC8nepV
         79bC6nQaUs4rZ4Xmhujmn4t0pSW2pj3AscDUZGtGkw5PelnTi/wDotJgDP0Xsgb2ihpI
         qNwsQBjUEYT1b7CDv7rKOLcQyvBXdSJqdEmC13ywxZFfT51YfrIre28/1pIfGXnpfeM9
         7BUacgw7K5K0PGERJISU9t5yfEGKdHchGOV5sOhxRf2ns0/7iPTRgeqq0oYkRZpNZDt+
         NtiA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ2bgGBC1tYyuyzHwYgSXxfvmM/MGGWiz9tXBEhIZxUG/GMfTDbvftwIftm0NOgSxbMYE=@vger.kernel.org, AJvYcCWexYgupcaNxL2lYSaQMqCDSXAlyS8EfMY6IID/X5JWbBKfA1hSrN9MD3+C9t3vPupXuawed//ePgC/+yNs@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9QOFwyzVhTWdJ8mojlDljGriGf6CpSvZ7krgsiGHDuN0ggi96
	WxIN/0rfEUreEFKzO4Q7Lj08q0Iw8Q+U6xBwdmAYOQrBoK3+ypRO
X-Gm-Gg: ASbGncuatpN0345kzvpfGEfEBrrbluMpf31yRdVQMXs8rVRlhL+Xyruz0S1hYzvg/si
	A0cNv7z5Io8C1zzD+5BHfeykU7tTyXpvy5musY2Zkjj4h4KRJFFi0ERz39WpKgiWB4xyOyxLtgZ
	0D4qlWPWc2Zt0R/TCEAzATHRNfcT4TIHkL88xsTq118M1TOejC5cTF5VOcF7J6Y0KM+iRIz1FBa
	HCbavzAybhP9kb6GnuCT6AsGoJvdCa2MZ3Fqr+WmaD+GUamDxWjt//PWgE/HIaYmb8b3umSJAjO
	J6D5QlbzW8sz
X-Google-Smtp-Source: AGHT+IHuAK5Hv9o5X/1iIXi7Nk/IsYkAIpLhfpe0mnp0C3ElcAbj2ipHe69cLEPwepZTcfn4AV2G1w==
X-Received: by 2002:a17:902:d551:b0:216:5556:8b46 with SMTP id d9443c01a7336-21dd7e0728fmr22399605ad.49.1738117055220;
        Tue, 28 Jan 2025 18:17:35 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac495d590e0sm9005157a12.51.2025.01.28.18.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 18:17:34 -0800 (PST)
Message-ID: <6c7a14503338699fa99a4cf13f1e2b0abbfc9dfb.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] selftests/bpf: Add selftests for
 load-acquire and store-release instructions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Peilin Ye
 <yepeilin@google.com>, 	bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>, David Vernet	
 <void@manifault.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann	
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau	 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet	
 <corbet@lwn.net>, "Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan	
 <puranjay@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon	 <will@kernel.org>, Quentin Monnet <qmo@kernel.org>, Mykola Lysenko	
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Josh Don
 <joshdon@google.com>,  Barret Rhoden <brho@google.com>, Neel Natu
 <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>, 
	linux-kernel@vger.kernel.org
Date: Tue, 28 Jan 2025 18:17:29 -0800
In-Reply-To: <bda935ed074d3151d9afe02df06f026b8ea30690@linux.dev>
References: <cover.1737763916.git.yepeilin@google.com>
	 <3f2de7c6e5d2def7bdfb091347c1dacea0915974.1737763916.git.yepeilin@google.com>
	 <131a817f7f2749e78e527a251ca7971588cf62f8.camel@gmail.com>
	 <bda935ed074d3151d9afe02df06f026b8ea30690@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-01-29 at 02:07 +0000, Ihor Solodrai wrote:

[...]

> > This restriction would mean that tests are skipped on BPF CI, as it
> >=20
> > currently runs using llvm 17 and 18. Instead, I suggest using some
>=20
> Eduard, if this feature requires a particular version of LLVM, it's
> not difficult to add a configuration for it to BPF CI.
>=20
> Whether we want to do it is an open question though. Issues may come
> up with other tests when newer LLVM is used.

These changes have not landed yet and would be in llvm main for some time.
The workaround is straightforward and I don't see a reason to add more jobs=
 to CI.


