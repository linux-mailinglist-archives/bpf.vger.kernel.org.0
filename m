Return-Path: <bpf+bounces-50908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 405AEA2E189
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 00:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935741885339
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 23:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FC3241CB7;
	Sun,  9 Feb 2025 23:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zIEG+E8b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8233224113F
	for <bpf@vger.kernel.org>; Sun,  9 Feb 2025 23:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739144524; cv=none; b=APCcj7Xy4Sm0RUXGnJkkDAPu36zHBbEMGn164Xi43XYgADrL8dE2Vbh/F+yoAUmtSvyP7HWKle88Y0P9v0vK/ueXRjyZWokN2hkZSBLgJvohyKjCIl0RQipsCME/2wpsyjCBV6ZSIRVXxZsV5wg9dheb6RSksbK5hS7nHiPuoZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739144524; c=relaxed/simple;
	bh=rQPvUG/o2rTnO0CHjoBObshc5YBL9GZpqX7CFdJ8An0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH/xFJCY9gr4xhfp9E9Y7WvYivRPvynT4AtKpbTXyVW0mFvs0Ytisv4//HfITv0Fayf766MUsopimOLpLvFcRn/wjPSG7Pcvn/OgH9+6eOQLurB2Jy3ddhMta2ixv+jPl7x161YVxXyU1qmQKYec6LnjLKCI/L4N4/7KZKL69vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zIEG+E8b; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f8c280472so43175ad.1
        for <bpf@vger.kernel.org>; Sun, 09 Feb 2025 15:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739144523; x=1739749323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8r8GqE7AcCzw/ZhoiEBDX6FoohFVz6Qw8VfxhrWWFOM=;
        b=zIEG+E8bEF+bBarWVfDVOeq/DEHOmfg5+zUKXlafarCXGV4Asg4F2jOykJBZ/Emajf
         myWRkMTWdf6jb1+LOO4rfXuuU4SR8hxMBSYICJnftsRASqd1z1ZkuEBd9JpqLt7zXk7Y
         jd1yxfdo6BPT/bYM/zpu4GCyoYUpjoLZlSYqnTHOh8d40rutX1WTZytI10PLAANU+FEx
         zjA1+3V8I9yPcf85pUSdVBEE7ZJjZQobSPckSL7/02XMfOtU3kt86Sy3Ev0EpB4Kviys
         D6so5t6HVGZPL6KmoZypjozGXNo99fhLb/jInvwbe6pbD93C/Q74Lg5Jj0U8o+Qm+mR3
         uUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739144523; x=1739749323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8r8GqE7AcCzw/ZhoiEBDX6FoohFVz6Qw8VfxhrWWFOM=;
        b=XV0f8N/vKEN+X/B+DalEehJ8epfgZcrPOqaD2x+F39+rfdirk+MNf+qs0z7h5Yg1qs
         2wqUDQOVazewU8zuvTyLTc0hQTDQP4uN5QJHyIEvdgkh+SQ/vgdLNxZL4uorFzZbQI7v
         rATeplHLolUP0gPXRK9h+tBS/Wh/588TNq+J121o3ZLwMdbHI293Mqd9VQUBsAlNyxd2
         TtsqVXWz+rf0ucTCDzKAp5pGcnKHjmRdBle10FrbSMFdt/FGhQ63NK8jXL87f/L4IX7P
         xNBwjtx8KLQ9J7IkLD7M22YxQ9So9EwPWpma/0Zw9mw+oLn9DNOXS+MZg3CrgUBbdoNU
         KzYw==
X-Gm-Message-State: AOJu0YyklRoMprbFto+enyH1+vl633HqrP4271Li7JOezrqr7Wc4lG2f
	s9N9NJ1f9UJXMTVqyx3c7+BKhDdd2WxjBZyXwNGGZG+c4aTVC6RxcmpJb6VD76KAJJ/5IzvHOZx
	MLeiX
X-Gm-Gg: ASbGncuhsiGGkWXjuMvJUp7M9AIgbNJlLJq+YmRLc0J7EviMf0Ww5GWBEp3v0CbIeNk
	nz5HGcG0C4sWWk3wKbKe4ak6WCJ5f8jm5ct00dtsggRQbqw2zLwUFxS0CVvM5uDP2bdxoPiLsli
	zA8FXEU+13TDouI94ZX9tOa9rIcIm/dxjhxz7jPc3D57pGhOFwELxJO9jsAmRSdbm9sTvyry2Vo
	9BuHVGWFR5fYEchP3kaUmDpk+FkvtjOKl8CFN6ToFudLLsXYxSNYTW2dU56UoBNMqN9sTQ4ZZiy
	KdMmDeRBFScrmcroAebVd0yaO7kBtKR2iTx1TXUuYcA3oJWEWkfu5A==
X-Google-Smtp-Source: AGHT+IGWHtUanwi++EymoxyoPMciInVawa1/VM+FGRotgFZ32k+cNoaAFIfQ4hVKBEquC6xHERYLiQ==
X-Received: by 2002:a17:903:2406:b0:21f:2ded:bfc5 with SMTP id d9443c01a7336-21f69e53a84mr2650125ad.28.1739144522571;
        Sun, 09 Feb 2025 15:42:02 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51af64c1dsm6573311a12.52.2025.02.09.15.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 15:42:02 -0800 (PST)
Date: Sun, 9 Feb 2025 23:41:56 +0000
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
Message-ID: <Z6k9RELOQxp67rIn@google.com>
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

On Sat, Feb 08, 2025 at 07:46:54PM -0800, Alexei Starovoitov wrote:
> > > These values might imply that bpf infra is supposed to map all the values
> > > to cpu instructions, but that's not what we're doing here.
> > > We're only dealing with two specific instructions.
> > > We're not defining a memory model for all future new instructions.
> >
> > Got it!  In v3, I'll change it back to:
> >
> >   #define BPF_LOAD_ACQ   0x10
> >   #define BPF_STORE_REL  0x20
> 
> why not 1 and 2 ?
> All other bits are reserved and the verifier will make sure they're zero,
> so when/if we need to extend it then it wouldn't matter whether
> lower 4 bits are reserved or other bits.
> Say, we decide to support cmpwait_relaxed as a new insn.
> It can take the value 3 and arm64 JIT will map it to ldxr+wfe+...
> 
> Then with this new load_acq and cmpwait_relaxed we can efficiently
> implement both smp_cond_load_relaxed and smp_cond_load_acquire.

Ah, I see.  When you suggested "LOAD_ACQ=1 and STORE_REL=2" earlier, I
didn't realize you meant 1 and 2 in imm<0-3>.

Thanks,
Peilin Ye


