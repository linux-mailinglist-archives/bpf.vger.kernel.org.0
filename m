Return-Path: <bpf+bounces-50878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBC3A2DA64
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 03:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5792188801A
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 02:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93688F4C;
	Sun,  9 Feb 2025 02:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tqGf/1aj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3271392
	for <bpf@vger.kernel.org>; Sun,  9 Feb 2025 02:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739067684; cv=none; b=tl+svFATXz/tsIVZ4odEKHIzSh/AuuZTmC5ljLuAaRXiF/fdldkUkFYivvq+lYB2xXR6de3mxzzhM+7SKI2H6QgPNzIzXqy2HDaqEasR9rDLycpVE10mwfkOwoojQjI+9xc7C12ylyFPxkQjmwBjoOO0HNWKAs6o4r4EjPNlbCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739067684; c=relaxed/simple;
	bh=oLJie9UWNJxd9BkkGwaeRdy2QSgvFMiToNByFI6z9Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlVlfZVb/7EqW9Z27LWT3bhLZLVoA8W0sWeAjzXuF630vUSSCA6hG5hl5dn6/nKAaq6FZ4xRoxRXd9Nc7Qrh/WGvFC/+ICZEKk46CGO58YtXXrxSefLXf+7iuyBtWwdM4QTGcUwk+VtQPEe1+mQ6U3w3tw0CnnVKuahLIoe9G/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tqGf/1aj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2163affd184so96895ad.1
        for <bpf@vger.kernel.org>; Sat, 08 Feb 2025 18:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739067682; x=1739672482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aPYRBH8N0cFSlMms6AVV4eSsR5UK0yhiANnm0hFSLXo=;
        b=tqGf/1aj/fi6ZXNkBJhuns+7xcKAHeM0jgyENdye4OKMs6uRx+LE0G25XKHPRYCJGo
         aPjOrENbZV1Ozys6+eNlcxRPUuZ14UNwoM+j9tKVR2sala4AVVXz6Z9+9BcEkxfUNfpD
         7eer4AbJoke921pxMvM33ZxC+VvzphFXMxMrzye98DzVIGItZys54fXo7q5ffbuE+sxf
         5JbXIl83pEiQlUoFXbnCJLmvfcRZsdQu6bux+uijssiSq+4MKTx5K4M6fKobplpSwgFV
         7vPuam4HEVkIK1zvd+GDxlb8484Q67aAak7aB0u1uaWtgD9MQgNtrMalLvtxkhQskJvD
         /esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739067682; x=1739672482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPYRBH8N0cFSlMms6AVV4eSsR5UK0yhiANnm0hFSLXo=;
        b=n9kYrpnECKRy4UQ4RuoSfMsq7WPiDj3/x45E++mIBmi5+LrCc6Rae5D+xZzvn/0EAC
         euXR47HrWhVXiQO9gGMmFqLLDpb3kuHJKlLJTRYdyiH6ss26CMehFfzZiBPDxh1p6SBf
         FaPKvxSWRno4xYQAC+m1Gk53fgal25iR+gPgPiyuPApWzKOehq4wlK4wn+1TKGzHv5q4
         KE2exo5d75SpBV8KvLlx01ixAx8WP83vvlcXujmLtIcjCQ4nAd3UMFt88UdaqEW7SCvK
         lszcEcAjwCNX4O8eOm0LRx/hr5VjpihvOvVmIvDL2bS5y7WqkzyP6Q3Dl3JUB7796R7C
         AMYQ==
X-Gm-Message-State: AOJu0Yx4VQ+/BarZP5KkT61sGURMe3EiuHqFtGPmjBqnJ2RxWcYI0J3w
	PW+ldBUMpMDb35PPJVerA3QWXHfkKWYZBlv8pPLnhj3N39vYiG2I8Cwg36HUcw==
X-Gm-Gg: ASbGncvEWP6xqgwu2URpslS3J6lntt2q74wq2L6tZTdsqkqrGIl8s4rqdMRljcvPY02
	1q6/3v/4X/Q787szGzkdD0WBYBX9SPD2R7QNy7FEdtF5q85RSteHpCdZFR/McySzFmHK31t+SCF
	2iJm1BLNSriF2w68Ye55G3Zdrhgn7gyJ7x0EnUI+ULREoJgwVkBIJlrOLJmQmlT/HO+I8u5usZ0
	F9ZABOpyClw2inbaYgfgcy5KtHcijXwczSxRTF455iNLnabcsHo6v7MNxXrcA22isCMU6Qrfm9v
	p5IVG1BUMZDKuEKZ0ssVlOUwfJm816yyvXvAAWg3XN1qDcppQWI04Q==
X-Google-Smtp-Source: AGHT+IEowLr0ODuJvhhRX0k3wQ9ChkhKhAElhUwga2QcQJLk+imc7mKSniosyKtNBmFd0SxXKu92Ag==
X-Received: by 2002:a17:903:144b:b0:21f:3e29:9cd4 with SMTP id d9443c01a7336-21f69e53acdmr2101805ad.20.1739067681888;
        Sat, 08 Feb 2025 18:21:21 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c15baesm5148861b3a.121.2025.02.08.18.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 18:21:21 -0800 (PST)
Date: Sun, 9 Feb 2025 02:21:16 +0000
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
Message-ID: <Z6gRHDLfA7cjnlSn@google.com>
References: <cover.1738888641.git.yepeilin@google.com>
 <d03d8c3305e311c6cb29924119b5eecae8370bbc.1738888641.git.yepeilin@google.com>
 <CAADnVQ+L0h8qXfYkC3+ORyQkXFJ2MgO8FDHr_Ha0QMAtS_ujag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+L0h8qXfYkC3+ORyQkXFJ2MgO8FDHr_Ha0QMAtS_ujag@mail.gmail.com>

Hi Alexei,

On Sat, Feb 08, 2025 at 01:30:46PM -0800, Alexei Starovoitov wrote:
> > Introduce BPF instructions with load-acquire and store-release
> > semantics, as discussed in [1].  The following new flags are defined:
> >
> >   BPF_ATOMIC_LOAD         0x10
> >   BPF_ATOMIC_STORE        0x20
> >   BPF_ATOMIC_TYPE(imm)    ((imm) & 0xf0)
> >
> >   BPF_RELAXED        0x0
> >   BPF_ACQUIRE        0x1
> >   BPF_RELEASE        0x2
> >   BPF_ACQ_REL        0x3
> >   BPF_SEQ_CST        0x4
> 
> I still don't like this.
> 
> Earlier you said:
> 
> > If yes, I think we either:
> >
> >  (a) add more flags to imm<4-7>: maybe LOAD_SEQ_CST (0x3) and
> >      STORE_SEQ_CST (0x6); need to skip OR (0x4) and AND (0x5) used by
> >      RMW atomics
> >  (b) specify memorder in imm<0-3>
> >
> > I chose (b) for fewer "What would be a good numerical value so that RMW
> > atomics won't need to use it in imm<4-7>?" questions to answer.
> >
> > If we're having dedicated fields for memorder, I think it's better to
> > define all possible values once and for all, just so that e.g. 0x2 will
> > always mean RELEASE in a memorder field.  Initially I defined all six of
> > them [2], then Yonghong suggested dropping CONSUME [3].
> 
> I don't think we should be defining "all possible values",
> since these are the values that llvm and C model supports,
> but do we have any plans to support anything bug ld_acq/st_rel ?
> I haven't heard anything.
> What even the meaning of BPF_ATOMIC_LOAD | BPF_ACQ_REL ?
> 
> What does the verifier suppose to do? reject for now? and then what?
> Map to what insn?
> 
> These values might imply that bpf infra is supposed to map all the values
> to cpu instructions, but that's not what we're doing here.
> We're only dealing with two specific instructions.
> We're not defining a memory model for all future new instructions.

Got it!  In v3, I'll change it back to:

  #define BPF_LOAD_ACQ   0x10
  #define BPF_STORE_REL  0x20

Thanks,
Peilin Ye


