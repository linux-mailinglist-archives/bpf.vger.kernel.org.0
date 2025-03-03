Return-Path: <bpf+bounces-53120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3406A4CE2E
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 23:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729BB3AD09B
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 22:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA25215782;
	Mon,  3 Mar 2025 22:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OA80H5t3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C03A1EE7D3
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 22:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040464; cv=none; b=PrUxNP+rbeQ+dXnho/dXup0wWYdm36Jkq68Oxbpy1Q9TkRrrrjisbt2HWbX99rW/3gjhQ5uyg+HLDRABLmfTA2wJ44KVBk7PWbxCex0fMAVWl+E8Q8yG2xuU5T8Z5eyuXuuO2ruz5cC8aoNYzFftzw/6s0CqjUZh5aClmBicLRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040464; c=relaxed/simple;
	bh=8lSPo+KIIq2qYRr/9d3MJdKf0ce1XIDRY2s2HaDhhXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5N8o+7EfaXjodaiZmUQpYwWzI+yTZC24gcjDt2GuMo++xeUt6tmgxdBbO7mxv1AgMe+f/HJYfktBcxFu/EEx2y3wI/+QRNq0wEv8lZFjKE6UPMX75qKNQ0jyioKHI66ZitDI+h8KCfM15vDggBSxFQhoDgvtJnzjzVfFRU0TyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OA80H5t3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2237a32c03aso21735ad.1
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 14:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741040462; x=1741645262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TIPE161XE6h+XbpKbqRdjbwFF+hmkeZmLDbhV/M2UTU=;
        b=OA80H5t3RtNNuYvjlw0//qqL+sgjc7wPnLNGw/yNi52z072O13Tf2MSnjo30V8Kg4V
         Qewn+EV+ncE+yhSE4ywBHWeaaGXO0F+4W/wL0rU2FxRZ0gLeNMYO8bKB3llmU6E4+ZsK
         a9fJ6tiTN5SSWkCgXCYg3/RbxpTust+fSeYn50usD2WEi+3s5FDVBF+RUJzqgV8o2V1x
         qkD96rac4IqwmDJEn9RaHFaRFYbym1JkvufH66xJd4HksBDQU3vVKCDYuLm8TosQ2UQP
         LL174c+nrOMgn+UwzfxpsMJ97055SaNXfw96i8rREDzt+ZFOgih2YRAO6OI+dl4Lsmuf
         BeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741040462; x=1741645262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIPE161XE6h+XbpKbqRdjbwFF+hmkeZmLDbhV/M2UTU=;
        b=ar3NVVK+CPABKqdAwrxDxVT5bkjVedw2IZdbxDZ1lzfa9QUsWH2XDLEtm4I5Y17wJm
         MHjFUU2PLpWx15EghdrT/AQZbzZqFPtMV6Migs7MxHlps+gBr8b66JPBP8KNtTV+5FB3
         tolubUZg5U9Mu/0r94yrp+IZDS83a4l9D5/4PRTTGrd77Ka297dO4tqsQJG8l8gkEvvX
         rJL/FphhY8n+NvoCu/kQQVCU7VxFbNYIkAxxQj3ecmTcHB8PGzY0tvNAF3OavaIW1xLf
         Hc224E5/8AD/+deH5CMnMxwiKUnefbFLgCXzb9aEwRlapV30B2xW5bJs1cPK/TLFdKIx
         gNvg==
X-Gm-Message-State: AOJu0YzS0u9mCZrrWJERtp8NWGby56yCltPoW/m5alboATWYCu81EWzE
	10Y7hICqAK2FE0M6IAbTeHxX808NJ580Bxmlp2G2lbvjt+dxelQPTcuOSGjdRA==
X-Gm-Gg: ASbGncvpXn2AbIsuH9iQS73UkOuHiShO/pcXp6vAgTjbMWjy7GxRCxdu00ryx5tadDL
	F6E8cAi3K7Q1lfgLwfQ/3wTM3uZp7Nabr93SplNs5BMbx5BjB5uJbpTs5hAzxRnrrYwwlVS2WXu
	YPE4CTFPWBBLHhjr8v0E+zMhNhTw6qRa/tJ09gnvj590KqYEWNpRUNUpidsKQoeGSIZOq1tHrFT
	MwRKGuuA1XtNJ24J+qJnvOsDTTvVvBSgoeyBXY6Tuj+/bBfx66F0w/JU6WZ95FmkXSZ0ZfsiWRl
	IvY/EGIXekslp+eLs6rmXb4Ri4kywhvbLdKEiO/VfNzW528VOkRg38vTweKI1LTUj0i79fgZQ8n
	HRwdZoGM=
X-Google-Smtp-Source: AGHT+IHFnd6jZyLm3rBh852SMedzrz4n0Ml2vmv/2ld5Rglar/I+rjdCt1PE6PBirI1AmbiL/BJNuA==
X-Received: by 2002:a17:902:e546:b0:21f:3e29:9cd4 with SMTP id d9443c01a7336-223d9e656cfmr770325ad.20.1741040462117;
        Mon, 03 Mar 2025 14:21:02 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dedd22esm7402504a12.63.2025.03.03.14.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 14:21:01 -0800 (PST)
Date: Mon, 3 Mar 2025 22:20:55 +0000
From: Peilin Ye <yepeilin@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	bpf@ietf.org, Alexei Starovoitov <ast@kernel.org>,
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
	Benjamin Segall <bsegall@google.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 03/10] bpf/verifier: Factor out
 check_load_mem() and check_store_reg()
Message-ID: <Z8YrR7p7ikaw0Kpr@google.com>
References: <cover.1740978603.git.yepeilin@google.com>
 <8b39c94eac2bb7389ff12392ca666f939124ec4f.1740978603.git.yepeilin@google.com>
 <CAADnVQKyMx64_mP+u+rmnRGyzVoBs4rViTHeE4_0Rr+Kf3R5Tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKyMx64_mP+u+rmnRGyzVoBs4rViTHeE4_0Rr+Kf3R5Tg@mail.gmail.com>

On Mon, Mar 03, 2025 at 10:52:08AM -0800, Alexei Starovoitov wrote:
> > Extract BPF_LDX and most non-ATOMIC BPF_STX instruction handling logic
> > in do_check() into helper functions to be used later.  While we are
> > here, make that comment about "reserved fields" more specific.
> >
> > Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Peilin Ye <yepeilin@google.com>
> 
> Applied the first 3 patches.

Thanks!

I'll fix that build issue for 32-bit arches, then send remaining patches
(except v4 10/10) as v5.

Cheers,
Peilin Ye


