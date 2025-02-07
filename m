Return-Path: <bpf+bounces-50808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E280BA2CEF7
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 22:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFE716CF88
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 21:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8031B4151;
	Fri,  7 Feb 2025 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="20PyrTKW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A75C194C6A
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963408; cv=none; b=nsffOQ9hxx3uH/7N4/y9x4VXLfDVcoU3B0IRkRgSo/X0adJmoQcEttgsDtHnD7KHNILNQiw9KoFPdEa1gIApTpF0GGBrL4iYNAwoOIOlDfJYs90xeACD1ZVtOHhBrq0x9yLuT0dZOTZQQ0vA298bJBtWpFVELWaeY+HMDCkNJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963408; c=relaxed/simple;
	bh=2fnqc0zpuTZ1osqRxouJu28UD5i3KWjrsuvBjj0eF4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIkPeRLUR/gZMS1uT6V+wSd2N4FFdZjLVIlRJQtv6WZVRzQmyhrcBTkhJSFnjxsSKxaaIoR1bJh/cDXG9zBCqL5V84jmwhDhFX+Qu8ErZVq6isYcM8QfxUEB6I3zu/GoE06UCnIf0L19JRtIXw1sHTa+2pm1eq9UBlfYmZi0GQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=20PyrTKW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21625b4f978so35705ad.0
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2025 13:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738963406; x=1739568206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6XMDBGWHjm28kopyGkEygbqgRtjfyapFQf4AL4yI3g=;
        b=20PyrTKWYuw50ZT1kPwxapjyW9iW7udIXrHvcBY9hTrF8f3G1uK6+YvCprS9nwR3Tp
         uZtdswUZipSlGPPeBe3XlOwn8SM14dCBFFOMEBIUsURIIjlwa98wFJjfmKCsdSZYopyb
         rqY13dAxpJH5NkC5GTnwnC5nA1Ca/RLvxyj83xB53UatRjF7g9ZgIPTHvNfyYWdwQNDo
         NPqJd9FUCjPwCjQEcRhX63e6AMBtk7R+43T8XJKhpplAXuOIjte65alGUsWLCxveJHHG
         6aVw1p3nkucz3UHEB6i/8++1SnKxyjnBuZ9oP/0e52YzExUsoZkAByQ/u9yZvWqzBnbA
         Hd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738963406; x=1739568206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6XMDBGWHjm28kopyGkEygbqgRtjfyapFQf4AL4yI3g=;
        b=b5MmsJ6p2sLsskHo1cA4AlmE2YECd4RdQjzfzwng0JpRqtNf5UmA6bTrOYZ8gUXEWm
         lx2U5s72RvIIPgJmPYnq1SRxVjrXKNNCwedqhjjPzrNFiLgDJZYnU9iM21WmjAslg0eX
         rL/FnbeUcCa+pdS1w/XOD41k9fQ3UnPbQGRyFWHR+ae/sDbz3k4BmBto9qJsi1GI0yol
         0gSAYMVDqDTIvsfWeEGI8bZxBB/5Hf6ewY/S7iTNUO84VYeTSWbhaauVgbduL0s/EtJF
         acN74/sMPaLfxPXEFOttyfI/pm7Pc7qKRoGw5yulOrA8SyuwWRlDAqvl8Y9mO/UA56bk
         QvcQ==
X-Gm-Message-State: AOJu0Yy2kLU7/ou8GYxtdlDbLI4cf2YffFnaRDiJuiykqG2MZUb5mRNq
	hgUP06umhUEIHYcNk+t2sRG4zYJ0WeB2Sw+LshPu8qptAopfgDA7JUNJW8dGzg==
X-Gm-Gg: ASbGncu8S1AVVG6IwL0Pqye9m+Z76qYJHErPyYdoe0M0IUDnDZhP4GY88GtWRnKjqXM
	Ffy9qpmFTTtU1fSdM2r8rAzpqZM/peWli3cmE6m1H3RGBYI0urzTUlgDRmkZHT2FoYHFNtfSAZM
	L//eg3s46cL8BwhKRJ88IOGGLBcz3ZDe8w8DnoWnoJa/7YKN47DwTEQ3tvz75eCO+0Sk9x/y6Rh
	AK8FL6yvDA6VMWc1TpqoZ3AHTRulpzljHdOABJxlRwwFM6ktyskZS53IppKa88KFu+MNot+28/V
	Yl8PdFc/QrQJzHIvPjPVs/MDqA2aoFPQuJSPeMLHvgY6dXykQnBrcw==
X-Google-Smtp-Source: AGHT+IHso8RJPb+vtNaFlFpohsHAMYbmR3QFQJHAAenGlRgMQKXQ54uhWmZuUpEKK6ELwZyS2450Bw==
X-Received: by 2002:a17:903:3348:b0:216:201e:1b63 with SMTP id d9443c01a7336-21f69f35c2dmr461955ad.11.1738963406326;
        Fri, 07 Feb 2025 13:23:26 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048bf1504sm3593423b3a.108.2025.02.07.13.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 13:23:25 -0800 (PST)
Date: Fri, 7 Feb 2025 21:23:20 +0000
From: Peilin Ye <yepeilin@google.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bpf@ietf.org,
	Xu Kuohai <xukuohai@huaweicloud.com>,
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
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yingchi Long <longyingchi24s@ict.ac.cn>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 4/9] bpf: Introduce load-acquire and
 store-release instructions
Message-ID: <Z6Z5yLETaJ38TvqR@google.com>
References: <cover.1738888641.git.yepeilin@google.com>
 <d03d8c3305e311c6cb29924119b5eecae8370bbc.1738888641.git.yepeilin@google.com>
 <cff3dc9eaa592dbe634e336eb83f9bb47dd9705a.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cff3dc9eaa592dbe634e336eb83f9bb47dd9705a.camel@linux.ibm.com>

Hi Ilya,

On Fri, Feb 07, 2025 at 12:28:43PM +0100, Ilya Leoshkevich wrote:
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

Thanks!

> s390x has a strong memory model, and the regular load and store
> instructions are atomic as long as operand addresses are aligned.

I see.

> IIUC the verifier already enforces this unless BPF_F_ANY_ALIGNMENT
> is set, in which case whoever loaded the program is responsible for the
> consequences: memory accesses that happen to be unaligned would
> not trigger an exception, but they would not be atomic either.

The verifier rejects misaligned BPF_ATOMIC instructions since commit
ca36960211eb ("bpf: allow xadd only on aligned memory"), even if
BPF_F_ANY_ALIGNMENT is set - so this patch makes the verifier reject
misaligned load-acquires and store-releases, too, to keep the behaviour
consistent:

Specifically, check_atomic_load() calls check_load_mem() (and
check_atomic_store() calls check_store_reg()) with the
@strict_alignment_once argument equals true.  See also selftests
load_acquire_misaligned() and store_release_misaligned() in PATCH 8/9.

> So I can implement the new instructions as normal loads/stores after
> this series is merged.

That would be great!

Thanks,
Peilin Ye


