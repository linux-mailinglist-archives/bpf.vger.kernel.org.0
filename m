Return-Path: <bpf+bounces-53015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64159A4B7B6
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 06:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A851890BD1
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 05:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F151E0DE3;
	Mon,  3 Mar 2025 05:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yGgSwXB5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DEB14F121
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 05:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740980779; cv=none; b=WXnaviNdgwxXyLfuWMS8IbNYyM7dIy1SGuOAlieFYHmXoksWeZdRs9LvwaCOnBrV4ETqnftelsLeZez9lFs3IFZEljBlcVMEX0ttU//AfLWUY/8jHHDnd+QsIk9/YT7zplz6CTkvyheLmg4OC3En4yER07JcRRdZJRr9OTbujRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740980779; c=relaxed/simple;
	bh=kFywK/ACq8d8QY2b87w30M3VzLAGE4vSEdG8FS6u2Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjpEECJv0sXbWPggmw2UXE1/xn7R1IH89HP3swfkOg/xtuRn9V0/dJx+J221kS6JMjjz7I+W9ezwmY8jZjRQzmL3Jdl7jdXbBWmT9YdY3r8lOiFdbC2z+FLKU7pgWPhXG+s0CVF1c8G8y+YClk9fRs2JFAxzqRMBxy+VszICls0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yGgSwXB5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223a0da61easo124485ad.0
        for <bpf@vger.kernel.org>; Sun, 02 Mar 2025 21:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740980777; x=1741585577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LWZczVLGJa1y4XReahdUAMxIiZ2gtlx/faB4w9x6vag=;
        b=yGgSwXB5hM3gv3yGEdhsTm0mRnqprQl2Aw7dv1Ghq8tNIef9S0bGq//SGA6NdX19KC
         MrGgFGAOVZalwoM8dwy/0cHBzE8Y/glcCLvEnrf2a9KOfdVWMXnjzRaMTcAESKoiZVG/
         l4rdLAZPwvEx4inICpx9hgDE80s5urDx669foXqSc8xLBCN1xyAkFWhOrJkthwFguyDW
         m5FPnneZfKNEVHoi4iqhBnuS3zDzrLHMEx4KKkDGg6cIQhvEmoNL5PdhFx8oSclbT6o0
         IOypmY/WHBNDRZCwfdA7h9xrljhZKLxkPl+YL0gZkFDe1rCcB6wtx/LvvkGNkyTz95B2
         CFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740980777; x=1741585577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWZczVLGJa1y4XReahdUAMxIiZ2gtlx/faB4w9x6vag=;
        b=gKjYpY/B2Fk3jIkynooFAaLTpP0U7Sfd3GZyHLWCvkPlWalI3g9c8Ae6RgeLoyJIy7
         W7bxu7ixQk0h724B2QSuJyHEoOWv2oAwniGiX/OGBGoq7Rq5hkRI4iGzSGBjQ4rOwQWB
         w840CSF7dAcIPzU1SpLYmzFHfHSmFS0Vctlvq2cZ/T8grGNrkjCE9Vral78lM9l1oRV9
         18h7K1ZRb3+Vf+Lj7CXBzjSaiYq8lH+0f6G4tirfWBm6x+9AELDnD0noUwe0aRND9PEQ
         iDO+eWCs7PujtXtTI8RoKC7Ly/NGk79TG+bDYUPjqtAqMrGwKoyLQeOxfGqS6NJUx24g
         rpXw==
X-Gm-Message-State: AOJu0YzqYPkeWU3umUDYjtUN/2k1hweeDBMrmM7Q9+3YRgSFnGM365nO
	bkeqVU6mwtlealM9efu9gVDAaPOGvzE/+186acoXbk28cHQl7sA7TUlYB+zZaLwjbsPjXM1rTZ1
	T1g==
X-Gm-Gg: ASbGncsi6NR4ikbE3WlUy9jJ8O1zBoAuJgsMXjIEa3umEKHx70G+E5iF0RXSj/wnndT
	+UkQB+QkIrFZwj1GMa4sIp/6B5fsNCxcTiKefAttK1rRVHckjGxSBTEChuNYJM8OLTGeozXJb+N
	Pk+HyMM964xRY1jcqAmfTOeSCn8UsDag604fB7mSUYp4q13/vfMxlm8wGr38JLE8zNX5sF7x1jv
	qz5WTAOKgHmcAQ5qxUfuhqSvqrpSJHEB6fWwe8MO4bbqzLcxy4/jLrPnLxvAtk/lO2WLJDJdjON
	xeXJdDMkKRVk0k6IdL7r7XrSyGzL8+etj27JbrgOjLDHkK+HlsszUr7/7WWznBb98ZI9ECXBeR1
	2knGX+qY=
X-Google-Smtp-Source: AGHT+IGR9sIbs4GODDlDVazb4ZHmmL3k8nYNXhdZXtHYDL05wSLBQV8yxY07hQVWXU5lra6HhADNPw==
X-Received: by 2002:a17:902:c947:b0:21f:56e5:daee with SMTP id d9443c01a7336-223826bd593mr2964695ad.6.1740980776552;
        Sun, 02 Mar 2025 21:46:16 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a0024c04sm8210373b3a.105.2025.03.02.21.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 21:46:16 -0800 (PST)
Date: Mon, 3 Mar 2025 05:46:10 +0000
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>
Cc: bpf@ietf.org, Alexei Starovoitov <ast@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	David Vernet <void@manifault.com>,
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
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 08/10] bpf, x86: Support load-acquire and
 store-release instructions
Message-ID: <Z8VCIrnJ10uBj0yN@google.com>
References: <cover.1740978603.git.yepeilin@google.com>
 <ea2754510513dce17a1d8f4fcab07d9d769e7b08.1740978603.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea2754510513dce17a1d8f4fcab07d9d769e7b08.1740978603.git.yepeilin@google.com>

Hi Alexei,

On Mon, Mar 03, 2025 at 05:38:07AM +0000, Peilin Ye wrote:
> Recently we introduced BPF load-acquire (BPF_LOAD_ACQ) and store-release
> (BPF_STORE_REL) instructions.  For x86-64, simply implement them as
> regular BPF_LDX/BPF_STX loads and stores.  The verifier always rejects
> misaligned load-acquires/store-releases (even if BPF_F_ANY_ALIGNMENT is
> set), so emitted MOV* instructions are guaranteed to be atomic.
> 
> Arena accesses are supported.  8- and 16-bit load-acquires are
> zero-extending (i.e., MOVZBQ, MOVZWQ).
> 
> Rename emit_atomic{,_index}() to emit_atomic_rmw{,_index}() to make it
> clear that they only handle read-modify-write atomics, and extend their
> @atomic_op parameter from u8 to u32, since we are starting to use more
> than the lowest 8 bits of the 'imm' field.

For x86-64, v4 PATCH 08/10 implements ld_acq/st_rel as regular LDX/STX
(aligned) loads/stores.  Please take another look.  Thanks!

Peilin Ye


