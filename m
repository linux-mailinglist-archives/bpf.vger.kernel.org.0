Return-Path: <bpf+bounces-51312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84A9A3324A
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 23:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C1287A2FB2
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 22:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF7A2036E6;
	Wed, 12 Feb 2025 22:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oAtLihFF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0495D20408E
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 22:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739398467; cv=none; b=CjTbPrW303GsLXYeoLoTyxK+4y82HFSgFOfvgLck4ZiJ7m00Bk4AzeZooYRzTIxSABYl9ra+oIsexKUjS5pQX0kn/EaVrsapHpswRQWxzEZrpdNJqoOcMc7OstPpIXJka0gwIbrvbiKmn+g9/Uw51suCau8/R8HJRxI5+8eIjvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739398467; c=relaxed/simple;
	bh=G+nTDK4sSbJchmSn+8ZNil8Qq03iohzkfde6VphcdsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LO9IMC71HRrA+cxDz/ty9yI5G+AETz/OiHqpR9QVH9UTi8kyZeQH4TTfz6tJ3J/Oeej3y4D7azqCWAr/wV5yOG4BcIMV1Qk+P4PU0X2r0zIUOEK5M3FMTP7kkZJ2hSJ58qMDwfcwKx2+KijPdzPzCj+r4BQqjIcXRNQYMNPUiBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oAtLihFF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f032484d4so10685ad.0
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 14:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739398465; x=1740003265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RIamoPjwg48ZZC5Sh2bLQXIBfW0utIiRcjouU0t3hJI=;
        b=oAtLihFFzWr1++knG4t85uNigpH2CRah7Dqjht8T1kuano3h04OZq2vY3Kv/ve1rBz
         RkdBpUysaGLVyfPAY5OKra3PCXuR3ichk221TsfABDU9EacSiLQcuUiwPxteFgXaV5MN
         tT9w0NwBn3D5McigAtYIT78PxV0r2UdhTucYol2Sr+ITPrDCZ9sFTJj2DIJltOBzY41L
         xQaUUliphs4vBKdi17f2Mp77QANFXJihEXQMhxXfBzUvhGoWdpW2xBJID6gATw6Su2K9
         XmMeICQ41zzegJnxVkPJOoEQxkyuNfViK9NVO6+hid6Is85T92Fw6r3DdWKCk3oTo68S
         1TxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739398465; x=1740003265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIamoPjwg48ZZC5Sh2bLQXIBfW0utIiRcjouU0t3hJI=;
        b=TZTgDvyR8p7vDOMTlQpZhJg6sS3h7/Tv2vaCrqETyL2vOWDI0i3LV6AqItl/RC1zM5
         WQnE8mRncb7j4IepTVH3hmXyhQPd3snYP64jf7zxNDbmMbAb0dMuyGqqNYkbX/ALvtVY
         tIrue40+DIZg6yWgI2n1zxN+13YwzNjsY5oWtyrgHH35MfDRNJBBsfQ5YTlOU3aD4bIz
         0OYoj9O5tyHofxybLuVzfriPkp6k2eOWXmEgBqcpMIhuFg1SYoyA9W+c+JMchavNGfrW
         rQUaYs9qNTikP/dI2Y4bsOuJ4PAjtl0Y/m6CdhligP3EMJGfhwTzWpVlpc0Hb5/GFvV7
         cI6w==
X-Gm-Message-State: AOJu0YwNfAkMRNxEutTsw7o5TDJUVBFQKaLNCN3RpED3caUVH0ZsbdXz
	bzEkuZ9kGhy2zI1unRJG3ZvphAzD7GCDdCnCXflFTYfrsJYYotVoIlyfH/KuWg==
X-Gm-Gg: ASbGnctrzwr0MAndxYjdELbOFraZN6nxafObJ2PGvmc0jLvbDhEn8LA0aVdzGHpz1EJ
	mDn1bFg4p16VeVkOkhovqXxlgucWwC7d1YI3G3vERpeQ4RIH27VdEeBL+0GAgeDHNtsmNLWUeEL
	ujESpiA9JMOIoKTVbP4dxmGiqbKWIPIPQsuMmKsBn4glfgFB1cjNPfEd92iN9urosXMSD73neYU
	GVHzhOqgeuY4kcRB4ZKZ6/qvur5y+3ajv0e0eDKgbB7lyb1bm5H7bMbRyHzwLnuJUFYpRHcn1SW
	TNrk9ypW0fvXm/uATNgL1EBTat23jf1NmBL3J3Xdfc9aEerG8jdwCw==
X-Google-Smtp-Source: AGHT+IHoHezTdxvkJ/1VIrDh3oYzMtm6RGlYCwXFrwTeWP7zj3QgqCDHMbHI4+dadLOhjZf0y9DdCw==
X-Received: by 2002:a17:902:f550:b0:21c:e29:b20d with SMTP id d9443c01a7336-220d555da00mr178295ad.3.1739398464924;
        Wed, 12 Feb 2025 14:14:24 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f8fsm11770742b3a.71.2025.02.12.14.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 14:14:24 -0800 (PST)
Date: Wed, 12 Feb 2025 22:14:19 +0000
From: Peilin Ye <yepeilin@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	David Vernet <void@manifault.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yingchi Long <longyingchi24s@ict.ac.cn>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 4/9] bpf: Introduce load-acquire and
 store-release instructions
Message-ID: <Z60dO2sV6VIVNE6t@google.com>
References: <cover.1738888641.git.yepeilin@google.com>
 <d03d8c3305e311c6cb29924119b5eecae8370bbc.1738888641.git.yepeilin@google.com>
 <CAADnVQ+L0h8qXfYkC3+ORyQkXFJ2MgO8FDHr_Ha0QMAtS_ujag@mail.gmail.com>
 <Z6gRHDLfA7cjnlSn@google.com>
 <CAADnVQLkHA9LGv99k2TZOJEGUU=dw=q6nVurJ=aoh0v6cFS6zQ@mail.gmail.com>
 <Z6qC303CzfUMN8nV@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6qC303CzfUMN8nV@google.com>

On Mon, Feb 10, 2025 at 10:51:11PM +0000, Peilin Ye wrote:
> > >   #define BPF_LOAD_ACQ   0x10
> > >   #define BPF_STORE_REL  0x20
> > 
> > why not 1 and 2 ?
> 
> I just realized that we can't do 1 and 2 because BPF_ADD | BPF_FETCH
> also equals 1.
> 
> > All other bits are reserved and the verifier will make sure they're zero
> 
> IOW, we can't tell if imm<4-7> is reserved or BPF_ADD (0x00).  What
> would you suggest?  Maybe:
> 
>   #define BPF_ATOMIC_LD_ST 0x10
> 
>   #define BPF_LOAD_ACQ      0x1
>   #define BPF_STORE_REL     0x2
> 
> ?

Or, how about reusing 0xb in imm<4-7>:

  #define BPF_ATOMIC_LD_ST 0xb0

  #define BPF_LOAD_ACQ      0x1
  #define BPF_STORE_REL     0x2

0xb is BPF_MOV in BPFArithOp<>, and we'll never need it for BPF_ATOMIC.
Instead of moving values between registers, we now "move" values from/to
the memory - if I can think of it that way.

- - -
Or, do we want to start to use the remaining bits of the imm field (i.e.
imm<8-31>) ?

Thanks,
Peilin Ye


