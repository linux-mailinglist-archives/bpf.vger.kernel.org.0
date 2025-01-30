Return-Path: <bpf+bounces-50111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA85A22930
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 08:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0528D7A1F89
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 07:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0621A19F115;
	Thu, 30 Jan 2025 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ahmdGzq8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5301494CC
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738222394; cv=none; b=FccLRjFyoojYeKPsGhXC6QfZre1GIbCx0oSGBvbwi65HQvoGvnprcMqeOXN/+uZCqfmBKGP76bMHZ6p80jaqnQW/u/L6zgQFIBFsBo/0suVzF3HOTubbUwKnT1GnPhOhEevaY5/gQ/05AR6sdbgScb9q18SkFlfZyUnZNYxbctY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738222394; c=relaxed/simple;
	bh=1fowZ9KXYCBdJgkV7K9T6CXDCAJHWY5gHPO2bk3Qsl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btTK/54fhBcU+v1m0WSZ4F1rSEVspmznvzdIYl0mg8Y3hZ2IeZG0g0yagdyPhiKvX9ZipD1VNB5tjrBBBcSv2wedGnHSUmj3M03VgcXkwTbUm1Gs8y88vyzEABu2Ahsx+NDRzfG/8RwFhrfmrNW6rdFlBTKK0dR6Hyh/zLz48p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ahmdGzq8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-219f6ca9a81so58955ad.1
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 23:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738222392; x=1738827192; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DLCh+tatBBGoG+KXA63+7xQMMZDdLguhv+Isvay7xM0=;
        b=ahmdGzq8WpHcWt3y7i5tBQrtqs+LL4DsfYdmkMJdQs+sFluHxf8ExOcTWgPb2yhhyp
         UOR/BmFv9ryKT0qnDRE6+bfBHy2MW/4DBKLZpAuFFlwbIAIDrMJYLIgjSsnuGvoLCM9X
         evcyXWwmdMKLa8Wd8/w7+5CIqI/5PVoeUaDKXVn4zzellH4e21A5d2GN0UjVHBCva8MA
         t32bD3W6Rf6K7OTAGcEVUWeRIm5UL0orxDReFgGV0tEOkbkEUsJCsVo3Uc/ys6clLYGW
         CsKdVdj0PFsfLYDGaxMNxiJjHHOSGQOfjTkPFyBkB2FPje25SZQWJL9TDsr+lsCvdXSd
         3yQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738222392; x=1738827192;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLCh+tatBBGoG+KXA63+7xQMMZDdLguhv+Isvay7xM0=;
        b=wkwcL1LK4tIm0KAvPetFII2ofHoIubFYGD1mv8Ig2fIj7kBHsBpGEZYreIqFnMu6GM
         /Lc6EHJzBQbrH1x1mmaBKb0aU8x7CoPVX3/HekywFae0sb/QV2Yeq3kro3FNTN6k4USI
         8SkXdiuEsMQz+hOt626g9gIlR/td2h2GsQptKGk5+Ggdb2zMqIg7toX9nZx4OHMjhs41
         j7o1aB1vdDN25jnfjLzcWfl7K57Ejq9AhgZIsqsc6WN7Qx2WnRemmao9UIQ87Lr66Po1
         1cocwPSg12iBx8NqU1EJJHspptQT/YBIRFyaSQ8g3yVwL5CAsbHIvggrBNRZKBlJiGhc
         m2NA==
X-Gm-Message-State: AOJu0YzEu+/2FaRjx9hGaczPll+g7/HBAeX7u3c9b5DfYiby5JtXiKyK
	QgD7DAuiX10d/hJblv8vOBC9eWjqyVzXkjrF3g+2188ESkgX1QOS0od1Ie2OdA==
X-Gm-Gg: ASbGncsOnhf4hzY0OxHj+nPFIkkXu6kOzWFsD0F+/EhQes7ql90NsVfA97W+AutBX4h
	NccP/zVP27c150MRlQSWu+iskzSUJJDnE2oBchR7FNj2+Dkg2Gz2nVg+SvYD9HbWP8qy2JF0eDU
	5dXYIXkNcUMQt6F1rkzqZ4CpI4GG/G5Y2va0Wa8s/hkiNmsFkMCaSg5tdtuSzyB04TwV/u+1/W6
	9o+dJ9Vp7G8z91R1xcYfM8ID5HtpbiX+3ydZfOtBVsPtOfVdlG9IRAbNNIyhlRPkpSaJgX2tnTH
	tBg11bp3cZqjyp4A8y5fwpvnwIq3QWmDD9k1wtCk9LMezovjSnk=
X-Google-Smtp-Source: AGHT+IGtAQyWP4E3jsq2fUXxPPBesuF/fheiJwtNQUCgGQWBzEClyXLLlz+nAdz/kOBuE6N6Xda0bw==
X-Received: by 2002:a17:902:740c:b0:21d:dd8f:6e09 with SMTP id d9443c01a7336-21de36189ecmr1296665ad.1.1738222392075;
        Wed, 29 Jan 2025 23:33:12 -0800 (PST)
Received: from google.com (55.131.16.34.bc.googleusercontent.com. [34.16.131.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de33000e0sm7571625ad.167.2025.01.29.23.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 23:33:11 -0800 (PST)
Date: Thu, 30 Jan 2025 07:33:07 +0000
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Yingchi Long <longyingchi24s@ict.ac.cn>
Subject: Re: [PATCH bpf-next v1 8/8] bpf, docs: Update instruction-set.rst
 for load-acquire and store-release instructions
Message-ID: <Z5srM--fdH_JAgYT@google.com>
References: <cover.1737763916.git.yepeilin@google.com>
 <e2072e24a6773b346f2a71c80b6a28d5b98e6194.1737763916.git.yepeilin@google.com>
 <CAADnVQ+hi3918DUyA7bs4Va9NdNqXJg-R4A45n_MHGTikYaOSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+hi3918DUyA7bs4Va9NdNqXJg-R4A45n_MHGTikYaOSA@mail.gmail.com>

+Cc: Yingchi Long

On Wed, Jan 29, 2025 at 04:44:02PM -0800, Alexei Starovoitov wrote:
> On Fri, Jan 24, 2025 at 6:19 PM Peilin Ye <yepeilin@google.com> wrote:
> > +Atomic load and store operations
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +To encode an atomic load or store operation, the lowest 8 bits of the 'imm'
> > +field are divided as follows::
> > +
> > +  +-+-+-+-+-+-+-+-+
> > +  | type  | order |
> > +  +-+-+-+-+-+-+-+-+
> > +
> > +**type**
> > +  The operation type is one of:
> > +
> > +.. table:: Atomic load and store operation types
> > +
> > +  ============  =====  ============
> > +  type          value  description
> > +  ============  =====  ============
> > +  ATOMIC_LOAD   0x1    atomic load
> > +  ATOMIC_STORE  0x2    atomic store
> > +  ============  =====  ============
> > +
> > +**order**
> > +  The memory order is one of:
> > +
> > +.. table:: Memory orders
> > +
> > +  =======  =====  =======================
> > +  order    value  description
> > +  =======  =====  =======================
> > +  RELAXED  0x0    relaxed
> > +  ACQUIRE  0x1    acquire
> > +  RELEASE  0x2    release
> > +  ACQ_REL  0x3    acquire and release
> > +  SEQ_CST  0x4    sequentially consistent
> > +  =======  =====  =======================
> 
> I understand that this is inspired by C,
> but what are the chances this will map meaningfully to hw?
> What JITs suppose to do with all other combinations ?

For context, those memorder flags were added after a discussion about
the SEQ_CST case on GitHub [1].

Do you anticipate we'll ever need BPF atomic seq_cst load/store
instructions?

If yes, I think we either:

  (a) add more flags to imm<4-7>: maybe LOAD_SEQ_CST (0x3) and
      STORE_SEQ_CST (0x6); need to skip OR (0x4) and AND (0x5) used by
      RMW atomics
  (b) specify memorder in imm<0-3>

I chose (b) for fewer "What would be a good numerical value so that RMW
atomics won't need to use it in imm<4-7>?" questions to answer.

If we're having dedicated fields for memorder, I think it's better to
define all possible values once and for all, just so that e.g. 0x2 will
always mean RELEASE in a memorder field.  Initially I defined all six of
them [2], then Yonghong suggested dropping CONSUME [3].

[1] https://github.com/llvm/llvm-project/pull/108636#discussion_r1817555681
[2] https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2023/n4950.pdf#page=1817
[3] https://github.com/llvm/llvm-project/pull/108636#discussion_r1819380536

Thanks,
Peilin Ye


