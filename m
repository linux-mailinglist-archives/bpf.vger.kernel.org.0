Return-Path: <bpf+bounces-51062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53AEA2FDC4
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 23:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B54518891E4
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 22:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AFF2586F9;
	Mon, 10 Feb 2025 22:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXFaWDim"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58404254B16
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227878; cv=none; b=JwfIwyAc5WfviXkeHtteCdwtz9gSg9B4hKuzWIXViKuvz6e+w98UbGqFOPzysLmzUiJe22UytwqioogaXrbsyW/Th0evVTHy61ZiGYJYIV5XOq6MQx5tFnbt7jxGRT6zjNxSQBV3I3DQT5i/cVL93+hX/oFaxLPSh0x7QVT1QDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227878; c=relaxed/simple;
	bh=xfG4WeE7SjirZ5Mcv8UCshdnCtmJEh7KANnBAKvtBeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTyCVUoJDRO3X05IwBIuoD6FIsICl4+8z5D90AjpwoTUh/Inf1QzJZmlnAa3posJDKgJH1zS88Pd5OMT/4T//K8i0abQOaPkxQ0POpuKi0GaEGuilLjjvORs3yCQA4nnup4sm7QaRzNpxzX2Y4J2IdHGa/DnRBpMCVBzGkaT0+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cXFaWDim; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f8c280472so20955ad.1
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 14:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739227876; x=1739832676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kzD9w/10Tg/Dbaxqt0ZLJaS8jBU14ki/gg5wLfoid+o=;
        b=cXFaWDim6jCcbo8VlT9Zn0BXncjw8vT0MECuwrmcsS+PzkbiVJ6R7HhTcsoWC1bGNV
         MJwyq6av2ENSWDiEMU0cz29qkEWZjvgoGrwwYANwH/cOkKB43U5zB6zhPYKgpI7G4eFK
         FzVxVt+1UtxPKXk9PhsfkPFgDkEYC3uUkptTE9KVIcFhla6H5GXGNJzfxXaTNZyIzbsy
         kXW0Onk1ef+2yYkzvxKcb8EhrYFIjuDYkIeIng0odeFVOGRLKm2xygPx8S5q53hPHCHF
         /gJNHTBvzDKSUKgyXDjafUxFMMpxVkCKqM+ToWo3QFuubFs9C8mZROWf1bYQBxC6jUIs
         KsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739227876; x=1739832676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzD9w/10Tg/Dbaxqt0ZLJaS8jBU14ki/gg5wLfoid+o=;
        b=nGNRyQsJFCHhRVrWK+dzjaQmd/Mj4hSzOTARKiJSvTYsd4Gj+rKXLG6Dr9EWGHm85g
         aCYPOtWhgQvVkYYCdZNa1TQ3+KDLTgHW7WsC2R3aQVkg0XKDJJCjzWrQfBTHLRXagBb6
         zimPJSOYizUsoR4hewYw22qiJEXY/cPUI6UbC+7L++d/XpJV5ww7+SIWLk8Kz7CQazdA
         UvcMyc21MMVq04l7J52StPtBPFe9OSrHcNDEMPhfUoPxivJrA2YRj6miTkcRpy1ShEnO
         gaDPnW2lwa1Q8mXxDuWZsegXcI59jEmsGVblrq9GneMU8DjpYRDINKJ67jXuAZuNbZgq
         8bSw==
X-Gm-Message-State: AOJu0Yw3acb6Hey2DKNPXyYM3Ch3g4JWk+B+3l1R4h4guO93GJZZAs6w
	1M2UyOpfnMqLyajRp3NrH+98iW4sJuHHpj53KKINd2rYuXSy6h3LijKlYZmamQ==
X-Gm-Gg: ASbGnct1OLcIx6YjTKroW3SEAYpyYDiZgNUD1BA3Tr6gk3vH9qlx88IjEyBm+/j8SaM
	XbR90cM9JAR+dcBFPa48nxZObwBqaOlVGbNMc8z3qrFE8d7z0rf4Zw3zV9MilMuly51nfO2oEoi
	jVgq1ydwGa/b5Wr+Ufmj0IeEthxOKJatBzuTkwJ+Lv3Bok6hFX150HHgHksxORUAdoHBYxO60Y8
	AhVAPA9gZR3/FVhEuzOeoKcD6aDg80vtOVB8ix9OYjJXdYkjDPcDoRAXh1GW9rX3FW7jD5QZ7gA
	ZTuoDqqTAFpX1xAduHoUe4Hl39DSvygJpjQn/YRW7x1FIYiqbDsuHg==
X-Google-Smtp-Source: AGHT+IF3MLc1SEMp/5ggqyCFt3vZ33zwtCZnr32F33srmpgWaKSJcp4xjwvbrjeQxnAK8XCWIX7FIA==
X-Received: by 2002:a17:902:ce08:b0:212:26e:1b46 with SMTP id d9443c01a7336-21fbb511b0bmr260955ad.23.1739227876395;
        Mon, 10 Feb 2025 14:51:16 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368d8ccbsm84732645ad.255.2025.02.10.14.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:51:15 -0800 (PST)
Date: Mon, 10 Feb 2025 22:51:11 +0000
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
Message-ID: <Z6qC303CzfUMN8nV@google.com>
References: <cover.1738888641.git.yepeilin@google.com>
 <d03d8c3305e311c6cb29924119b5eecae8370bbc.1738888641.git.yepeilin@google.com>
 <CAADnVQ+L0h8qXfYkC3+ORyQkXFJ2MgO8FDHr_Ha0QMAtS_ujag@mail.gmail.com>
 <Z6gRHDLfA7cjnlSn@google.com>
 <CAADnVQLkHA9LGv99k2TZOJEGUU=dw=q6nVurJ=aoh0v6cFS6zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLkHA9LGv99k2TZOJEGUU=dw=q6nVurJ=aoh0v6cFS6zQ@mail.gmail.com>

Hi Alexei,

On Sat, Feb 08, 2025 at 07:46:54PM -0800, Alexei Starovoitov wrote:
> > Got it!  In v3, I'll change it back to:
> >
> >   #define BPF_LOAD_ACQ   0x10
> >   #define BPF_STORE_REL  0x20
> 
> why not 1 and 2 ?

I just realized that we can't do 1 and 2 because BPF_ADD | BPF_FETCH
also equals 1.

> All other bits are reserved and the verifier will make sure they're zero

IOW, we can't tell if imm<4-7> is reserved or BPF_ADD (0x00).  What
would you suggest?  Maybe:

  #define BPF_ATOMIC_LD_ST 0x10

  #define BPF_LOAD_ACQ      0x1
  #define BPF_STORE_REL     0x2

?

> , so when/if we need to extend it then it wouldn't matter whether
> lower 4 bits are reserved or other bits.
> Say, we decide to support cmpwait_relaxed as a new insn.
> It can take the value 3 and arm64 JIT will map it to ldxr+wfe+...
> 
> Then with this new load_acq and cmpwait_relaxed we can efficiently
> implement both smp_cond_load_relaxed and smp_cond_load_acquire.

Thanks,
Peilin Ye


