Return-Path: <bpf+bounces-75598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68938C8ACFF
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 17:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66AA93B80BB
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 16:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A6533BBAB;
	Wed, 26 Nov 2025 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dpj5JCRX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762AA33B6DD
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764172885; cv=none; b=TEY6S6FPLz2LhI+a4IA11gcYXIjWb/YpCYMtKeVtVAcK5dfst5bI3K6A9HmMfm3uFCn5/I5K5siLooN9Ec+IB8VHcrdIm7aRNIbawJquag/IfpFe1FwVNO/6SrNEG6D3FxKys6C1YYWpJrP4/pTH815NxiD1PvmzcS8P0CRIQuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764172885; c=relaxed/simple;
	bh=fC4YN0ZWYFMgM4qaKEJsp+sm5vftxFD2o0/sgSjhz1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ME+sN0K2yzqCNaGkPjp/lRvHmpPEw9pmUVqYP9teWai8S6nD3+z0NpMJlZKsEX2du6SV5DEyBz9LNPvbOEWhxooW/9tmdWNdk1dXtP3OjK8F5/X1rAlvgMCb23o+DmDX8sVRIWce0/5H8Rg0BkhfaGFSc7/xH7hO2wy4ClHOzEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dpj5JCRX; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso67357495e9.0
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 08:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764172882; x=1764777682; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LSEYaUAThzWufYFQbG5NmjfparTQ345H1vYgCRR94jQ=;
        b=dpj5JCRXjpzRpcpjr6whjoB4Ui1M6MwifOYVwE/uFNU6c8ie7HVYDLwY6nrSbiKkeP
         GnRMz/JX+tMi0aRjUhT7elBkTox3bXWsrI6GVwx+uERwYPcgvHd8cW6XRGsstTwtjQO6
         NXpt/qM+jSBo8p407MyJcojujXHZUUPbRfVR7SCNg04RfjP2srXPjdlIWL0kCQc+xh8+
         LBtWHBFxkUyFPqGYfhtYI6F6jp6B+tpFtrcuWtN47OXheGZhDNlhbryoVL8c7+7Ue2iU
         yld+gVs5yRmf4vcaertG9+bOftXgR9NX/e5V/WQVKrgNGj28Pe/E14D+WfdK1JDO6yg5
         qFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764172882; x=1764777682;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSEYaUAThzWufYFQbG5NmjfparTQ345H1vYgCRR94jQ=;
        b=k/Ybtq5dNRCOJSF0awkB3g99hlVpFtNGXprgh3ZRF326gRBV5nwtQOEmvmL+LDA9Eg
         R3pZy0rMAVyavpkAFrOCszSHfS2BXiWobfcBIaXKYQmwtB31m9hUczwSRV5ptWbyJx60
         tEk2jpr6oeZR1lcSeJYZl1KfZ6HPD1l3QAsQV4actLBEjxby3Eps4TEg6jrnqUA3CvpW
         ciecI4aEqEYDyYBmOB0pKhNFah2LvIirdVQV4Xcz2sQGRnNn/p7pEErxHpf9qoLHynJU
         Ku1sjFmr18U1JmhZ3S77WZppNAf6fFHRu4nOGwCkAe3cBKsESO3nTeoRLRj7kLbnwHn4
         oAhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj5IW6484pIyfKfpCHd2OmROJBjK1qV9mOteZYKQwznFNMITKoyNNlDCCPm5YCPcfii/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6WvMowt/0nU/dnj1ymzEtAJ7Wx94Dfal4QNr/NmvPoyT0a636
	AMQZnBxq8YaWmPhy1mIpcEJPr2dcF73Vi6bUXdpOSbVe+Ly3jpro8I3OWS0eHqEzqwE=
X-Gm-Gg: ASbGnctuPNkT+Qx5LUGcCkrxSEF+ZpXRnqk3EQ0HVTWB48pJAPtQD2wfwFgJ+CAjpdW
	UIvLKTZQ9kVjEF9k/CJT7FKXVdwiPwd+qlTssvNd3UDWyuQJUMrWmFlkr+tk1Nx5inGrWeVDZ85
	RjeKNkQd28xRRIaCOHJnwnCGbl+frS+qypCPiz8SIHIcf9jYk5eAaTXX2N7xQMLWi9d8/X0jpxj
	YdVQ5cJJd84bFnmW3IarQOPfDN+QMCQnisT/1G5ntNoxiXUbbIReKgAa6JXDUuEho3ap6P41HqL
	C6+T0JIzpNeD0yOnM6GcLuHc4o6/Jtmd6i8KkDg03SHuPXRsRRIOpAWH2jG3XjpNSvYSyecJlKm
	iVexzaVeyWqRnOTd5rjshn1GDGtCC3W3YBxxOrTvaMnvRMu9E3026nrt2+iFJi6+UcLE74Nle6B
	SnvsekyrnWSy4NvChVV+o=
X-Google-Smtp-Source: AGHT+IGmW6B0mWDbCOocDZ2euc5+xXD69i8th6QMhNJdys8XoC7Ssf0VJWSdjafP9//scVbg3OATOQ==
X-Received: by 2002:a05:600c:5494:b0:477:93f7:bbc5 with SMTP id 5b1f17b1804b1-477c0184c3amr197847725e9.10.1764172881604;
        Wed, 26 Nov 2025 08:01:21 -0800 (PST)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040cfe17sm47110715e9.5.2025.11.26.08.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 08:01:21 -0800 (PST)
Date: Wed, 26 Nov 2025 17:01:20 +0100
From: Michal Hocko <mhocko@suse.com>
To: hui.zhu@linux.dev
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
	Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>,
	mkoutny@suse.com, Jan Hendrik Farr <kernel@jfarr.cc>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH 0/3] Memory Controller eBPF support
Message-ID: <aSckUNAfVokeC_2F@tiehlicka>
References: <cover.1763457705.git.zhuhui@kylinos.cn>
 <87ldk1mmk3.fsf@linux.dev>
 <895f996653b3385e72763d5b35ccd993b07c6125@linux.dev>
 <aR9p8n3VzpNHdPFw@tiehlicka>
 <f5c4c443f8ba855d329a180a6816fc259eb8dfca@linux.dev>
 <aSWdSlhU3acQ9Rq1@tiehlicka>
 <6ff7dad904bcb27323ea21977e1160ebfa5e283d@linux.dev>
 <aSWnPfYXRYxCDXG3@tiehlicka>
 <87af0c7a8fc35cd96519a4e3f09d39918bdb7370@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87af0c7a8fc35cd96519a4e3f09d39918bdb7370@linux.dev>

On Wed 26-11-25 03:05:32, hui.zhu@linux.dev wrote:
> 2025年11月25日 20:55, "Michal Hocko" <mhocko@suse.com mailto:mhocko@suse.com?to=%22Michal%20Hocko%22%20%3Cmhocko%40suse.com%3E > 写到:
> 
> 
> > 
> > On Tue 25-11-25 12:39:11, hui.zhu@linux.dev wrote:
> > 
> > > 
> > > My goal is implement dynamic memory reclamation for memcgs without limits,
> > >  triggered by specific conditions.
> > >  
> > >  For instance, with memcg A and memcg B both unlimited, when memcg A faces
> > >  high PSI pressure, ebpf control memcg B do some memory reclaim work when
> > >  it try charge.
> > > 
> > Understood. Please also think whether this is already possible with
> > existing interfaces and if not what are roadblocks in that direction.
> 
> I think it's possible to implement a userspace program using the existing
> PSI userspace interfaces and the control interfaces provided by memcg to
> accomplish this task.
> However, this approach has several limitations:
> the entire process depends on the continuous execution of the userspace
> program, response latency is higher, and we cannot perform fine-grained
> operations on target memcg.

I will need to back these arguments by some actual numbers.

> Now that Roman has provided PSI eBPF functionality at
> https://lore.kernel.org/lkml/20251027231727.472628-1-roman.gushchin@linux.dev/
> Maybe we could add eBPF support to memcg as well, allowing us to implement
> the entire functionality directly in the kernel through eBPF.

His usecase is very specific to OOM handling and we have agreed that
this specific usecase is really tricky to achieve from userspace. I
haven't see sound arguments for this usecase yet.
-- 
Michal Hocko
SUSE Labs

