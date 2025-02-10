Return-Path: <bpf+bounces-51068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB40A2FE9B
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 00:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB47165AC4
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 23:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411AB26461E;
	Mon, 10 Feb 2025 23:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aH0i68go"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75573264628;
	Mon, 10 Feb 2025 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739231129; cv=none; b=n/JM6va4QcEYWBbdtTqZMjo2EIZ5acFdGZNnpKkTtT2G6N51uFyMMPv2BD0DwsnuNTFND8flcuR9INxhReiep38yJz/RdbBNK0uxvDWvktqhxG557NFuP1c+JtMeok0cNsUXCcYvElLW2PjgYgjozNkKcmCYurrEajrNWSjOW/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739231129; c=relaxed/simple;
	bh=ixkef8jOB0P+lJ6IyV80P3LNYVwYTiglb+MKur84g6M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ESwxIPeaubSe8vXb+hnC8+o93nE7SlrTOc2cPMTTqRTOINFsXiXsMx/k95sRbyIIhQ0VS5V34C4cuUjnIn19150f/FGMhIIgHEABc+mR7+TygqruM8bmCafRbmsbcxzLzqeYpUDASYYrn5OGaR5vMkM1eklj/kpisJAOc79f1t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aH0i68go; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f48ebaadfso81614785ad.2;
        Mon, 10 Feb 2025 15:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739231127; x=1739835927; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=52lUjiDSJtE5pfFjZXgC0f64Wn3Nt/2DnZ14fk120UY=;
        b=aH0i68goicT0wSSsk9EvAXP+mzAfsfU/3twSYEenk20AZ0jVBHk2CkSCbDBls99JwW
         t3krxMH6N1NISRaFgxzbvq8DFebZIpkbHVec9ryGgdnPb7BBN6INYMX+TNwcfwHcuLB2
         PgvOr6xtwGnrilmu8peqEEudZys6xle38aFmOswVKIEI7+2cBJ0OW3c6pS7fdq4FzGcQ
         Q2Q12nlaipGqIAC38VtcHrfi7J1dsCXO42tp4O5SacSp5RI3m7pKv3flK+PzUD6ATvvt
         VQQ3W8Oe7Oo0AFNijr10hH+KtZOairC3ZS45EIKKd+gKksKd04MWJi5jVqP864Ahm6mO
         RrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739231127; x=1739835927;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=52lUjiDSJtE5pfFjZXgC0f64Wn3Nt/2DnZ14fk120UY=;
        b=T2IuhL29SQl+WuAqsion+pVo/MKYjG+vXh4bypJCnU53yMZLCSCJfO4uTL3bFH645H
         Q6K7vW0iNAbHU9dWWaDRCnXv+gA1XQkPBi28A9gi3pF0EosVs/kArYMausSmLgEC5AhT
         pi99WM/P6atNaQr7mII8+Ixa5/3KKndXBAFVARw5JgjNnFXmHTluFR/jskb/rnwuX70H
         6MTt3kiiJoCjHdVFmcZwGpkplyCIJmjDlGcLoYzNblYZjr+3dioiOt/LFcSYjP8wDnj0
         kIYvO8P9XxvoUHMPwLjlo/kl8j/J2Ae2UnRFdvpo11muOMDdrQ/vO/t75t3GWT1aEWMQ
         lZ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUL91YmbswEywnRF6vrLmOdYTShAA23v5econB01LajZEjNjl21v3I+19GrYcGf67b6lP8=@vger.kernel.org, AJvYcCVyMDBqaXyNl+zfE0IaJjOn5zNoQ4FsjrhFMHLrFQpqfx2wxSPO+HCiQoYw4VrJ1Q/E01Ue9rPLIpSlMXVU@vger.kernel.org
X-Gm-Message-State: AOJu0YydAxtLJsdml6/mdX6fyTNw5xXUxgTO1t2aN2ERxMFH9YCRZdVB
	//nRkrYoLzt/FUKgnGM6O+1DhlOwHuVElOFYIoHb7+Ccw1mMFCkA
X-Gm-Gg: ASbGncuMieLTV08XsyRljfToV9HmNW//+BZ4Jp8DuqPy7O/kjsSmqYptdhzZrrHv4BQ
	dfUl75cdLZUtA5mo6YndornI952OGn061akZzNnhCViOo9d90WQmp8k3EXMC0fwFURRKK2z4jvT
	G37O6BraBlgp68ZJ3okWQpOjRRbMh5MxBEk2ydxkWwo3SjtQo0xFdc+L/HU5ItBxFDtxgwPu7j7
	U5tOn9E9PolHsMxVX70e0nmkuB7Owh2p8ijVb3/xVxMN9bNFJhHQ2rLUpo+Xv2zH84VyHuADJBk
	HOfQPti2rKXV
X-Google-Smtp-Source: AGHT+IFr87HMc3rAIs7T2MJZdH+iBcNx057eedhM1fSNyi8duQq+MXuumgo05Ysb+cZouGZ01IpR+Q==
X-Received: by 2002:a05:6a00:6ca3:b0:730:9801:d3e2 with SMTP id d2e1a72fcca58-7309801e1c2mr6542542b3a.8.1739231127553;
        Mon, 10 Feb 2025 15:45:27 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7307c5b3a99sm4324202b3a.54.2025.02.10.15.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 15:45:27 -0800 (PST)
Message-ID: <5029add95e4dc77a3b28bb9869260af290ffc6ea.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/9] bpf/verifier: Factor out
 check_load_mem() and check_store_reg()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Peilin Ye <yepeilin@google.com>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Cc: bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>, David Vernet	
 <void@manifault.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann	
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau	 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet	
 <corbet@lwn.net>, "Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan	
 <puranjay@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens
	 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Catalin Marinas	
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Quentin Monnet	
 <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>,  Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long
 <longyingchi24s@ict.ac.cn>, Josh Don <joshdon@google.com>,  Barret Rhoden
 <brho@google.com>, Neel Natu <neelnatu@google.com>, Benjamin Segall
 <bsegall@google.com>, 	linux-kernel@vger.kernel.org
Date: Mon, 10 Feb 2025 15:45:21 -0800
In-Reply-To: <363538659933fb2e289d937d81fc8eecb284ea7b.1738888641.git.yepeilin@google.com>
References: <cover.1738888641.git.yepeilin@google.com>
	 <363538659933fb2e289d937d81fc8eecb284ea7b.1738888641.git.yepeilin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-07 at 02:05 +0000, Peilin Ye wrote:
> Extract BPF_LDX and most non-atomic BPF_STX instruction handling logic
> in do_check() into helper functions to be used later.  While we are
> here, make that comment about "reserved fields" more specific.
>=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Peilin Ye <yepeilin@google.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


