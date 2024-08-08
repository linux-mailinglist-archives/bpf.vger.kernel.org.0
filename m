Return-Path: <bpf+bounces-36723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC0B94C620
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 23:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4717A28AD4F
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 21:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F04C15EFC8;
	Thu,  8 Aug 2024 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XIjIVpTv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73CE15ECCE
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150796; cv=none; b=fFXA9Ui01su0NSM4o8rVaWLJ0L4z5BhS3Z+TCSxE5TrbnesJibmEUzAfExQwK+BUBhyWyNqWqOURetrmjsCP/xeR4puntrXa1mvKSlk7UdPmSM+xjXKGj0AtrHIJ45NyHEJALqIBIUD8LGxckz0nbmV+rgbDm/nTOQhZHUxnPSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150796; c=relaxed/simple;
	bh=v6VjavZpCV2Dv4riRFKshHPHsnu5PiVM+eX2XC0Vn98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAGt2INi5et9W5ajUWfrvml7g6NL5tX/uvd4GxUjjaeenzEbf3P6YOR8yvHOfrJjfJ9A+vz6A7P6q8K1LGpjyqXW6g+RcCWhYWEiHwLcTx8iZhGcKSKpQ3PaTSXGJqNTwCEta8Drx9f8ZYY1Gu0kAinwcltWeDX/GCqpExx+Hio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XIjIVpTv; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-710d1de6ee5so620786b3a.0
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 13:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723150794; x=1723755594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rkdvX5YMGoaDeVmm00+UjcGF5eZpdLw9ltJCeaYT/s=;
        b=XIjIVpTvfjkvcIuIO1272pMkRqkxD3oHk6+S3l3c2NuZZHKxZggODYJE68hclpSI0+
         eZJv4jhrTjwfrQTuMQSYVTBBhWm8ZLZnvLUNJ2h8x6DoZ7DGqG0g2ilK/xrN9f7jkkGN
         q01xaNFvHzbcgycO4pzoV2iQ5XO9WpuRiOJfabQmrg9AR1H5C+ka/oolm1wwx+4UozAc
         TJwel+UVKxP6zLKaMw65P1Vcfe2LA97TLqD6NZV3gsE+ZdAH3ZFhCL6LDtEPtSttDhVa
         tayVzwRFIoYhIGidkrCNQo/RzDD5JcflKNeIGa6pgrEj2LKUuhCU9SfHpmsRAcdCY2L5
         QAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723150794; x=1723755594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rkdvX5YMGoaDeVmm00+UjcGF5eZpdLw9ltJCeaYT/s=;
        b=V/d2MeqV2bEZeDmtobjMShEo+3iRjWZqHxJmqF+8rNq0Pq4XatuKGeS9IOVKxhkvvA
         tsBagsPYrKWS1i109DIv3JFxnk9QOsktjIQngLsfjhhIncLwrQoBWJlXoU8xTz4ETnvI
         1nVHpwFInv8HXzcaAW+3m2tQM1FGBRReDHwcAn2QA4ER/ZSybar3MYU0idYMR8E05iKx
         Jr1e5/iMHhs0KzqLHblXULOowsquqOF9VAeTFQxUAmok2dQoWDOUC/5JUqgjLBsGOlHK
         x3K+LSk1hOpzR6UK403j2s508iu68ZQFHjWR4GuwcTPmeJoN5pKYBTzkVbjH5Nd/MPIQ
         G1LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa3hWHpwNZKpYg57M5F0cOEvAPCIbTvuE0kHjtdlrRHZTQSaPm1s+V2Gs+nkuN/FqLMLEHJaS+CcWOHof24+AhqYMC
X-Gm-Message-State: AOJu0Yz0scilXxmb6QL6l6WEaksRPUg0K+l11SiElrZJUSWAupOcK8fJ
	O49jnEn69Kw06P5A9IXjWbTIgdW1X2iFtfLgRD6o61uv+lAmHDhNJCqhEKjfa+ZAAvnusJBHMyB
	GXHHB
X-Google-Smtp-Source: AGHT+IEVkKPjFRWs8XNlNhC4xFXyucUx6mP1jeqOoeShulKAsRjMhwm1nPUPXWLLhjdDkbQ1qSOv/w==
X-Received: by 2002:a05:6a21:8193:b0:1c2:9288:b93a with SMTP id adf61e73a8af0-1c6fcf880c7mr3127955637.37.1723150793739;
        Thu, 08 Aug 2024 13:59:53 -0700 (PDT)
Received: from google.com (201.204.125.34.bc.googleusercontent.com. [34.125.204.201])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9f484sm10286120a12.5.2024.08.08.13.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 13:59:53 -0700 (PDT)
Date: Thu, 8 Aug 2024 20:59:49 +0000
From: Peilin Ye <yepeilin@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	"Jose E. Marchesi" <jemarch@gnu.org>, bpf <bpf@vger.kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	David Vernet <dvernet@meta.com>,
	Dave Marchevsky <davemarchevsky@meta.com>,
	Eddy Z <eddyz87@gmail.com>
Subject: Re: Supporting New Memory Barrier Types in BPF
Message-ID: <ZrUxxRpp_hd-2zyc@google.com>
References: <20240729183246.4110549-1-yepeilin@google.com>
 <CAADnVQJqGzH+iT9M8ajT62H9+kAw1RXAdB42G3pvcLKPVmy8tg@mail.gmail.com>
 <ZrJ3_esc7nBb6k9_@google.com>
 <CAADnVQJDki9GCxDAaGJWb+HrKT2EnzYXM8K3238XxPtHkhU0Ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJDki9GCxDAaGJWb+HrKT2EnzYXM8K3238XxPtHkhU0Ag@mail.gmail.com>

On Thu, Aug 08, 2024 at 09:33:31AM -0700, Alexei Starovoitov wrote:
> > > ldx/stx insns support MEM and MEMSX modifiers.
> > > Adding MEM_ACQ_REL feels like a natural fit. Better name?
> >
> > Do we allow aliases?  E.g., can we have "MEMACQ" for LDX and "MEMREL"
> > for STX, but let them share the same numeric value?
> 
> yes. See
> #define BPF_ATOMIC      0xc0    /* atomic memory ops - op type in immediate */
> #define BPF_XADD        0xc0    /* exclusive add - legacy name */
> 
> but it has to be backward compatible.
> 
> > Speaking of numeric value, out of curiosity:
> >
> >     IMM    0
> >     ABS    1
> >     IND    2
> >     MEM    3
> >     MEMSX  4
> >     ATOMIC 6
> >
> > Was there a reason that we skipped 5?  Is 5 reserved?
> 
> See
> /* unused opcode to mark special load instruction. Same as BPF_ABS */
> #define BPF_PROBE_MEM   0x20
> 
> /* unused opcode to mark special ldsx instruction. Same as BPF_IND */
> #define BPF_PROBE_MEMSX 0x40
> 
> /* unused opcode to mark special load instruction. Same as BPF_MSH */
> #define BPF_PROBE_MEM32 0xa0
> 
> it's used by the verifier when it remaps opcode to tell JIT.
> It can be used, but then the internal opcode needs to change too.

[...]

> > It seems that nocsr BPF kfuncs are not supported yet.  Do we have a
> > schedule for it?
> 
> Support for nocsr for kfuncs is being added.
> Assume it's already available :)
> It's not a blocker to add barrier kfuncs.

Got it!  I'll start cooking (kernel and LLVM) patches for "MEMACQ" and
"MEMREL" (using 0x7) first.

Thanks,
Peilin Ye


