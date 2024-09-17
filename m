Return-Path: <bpf+bounces-40012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B357A97A9D9
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 02:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFE11C27033
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 00:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A433A48;
	Tue, 17 Sep 2024 00:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D4tpZ7Zd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1FD37B
	for <bpf@vger.kernel.org>; Tue, 17 Sep 2024 00:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726531739; cv=none; b=U2gdKQugqpa2D+M2mAHcNr2cY4qaR5Mc/BkK4R8Fbk2T7QIT2UuR5lk3402/vZZsU+EZfONgtNUagiokXDtIV5z1k4huaM2gnaoLrw5/VT1d603R2Im2fNFC2EcQ7WMdXDWgWV78oOXDoJd10dsJe+MjoIEcqrNXgssmIpWHmNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726531739; c=relaxed/simple;
	bh=v1B6+6ktqXeLQ3XjQCbmY18VKogJCW2LexKrFL9Z//Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxyrPtUqHfxQtH1gta6IsWvU5vyOx2IDr1JQBZJhqs+4a+IMH5Y6cTcKkjiZRRE4kikz9qPRD8kJcEyAXoYZG+2d/RmAZq7Y/U6r90GaOA4HtD1ltjS4iakKNdjo4l63uKLbJp2AC+Io//Gj9Ak501IJS54jYsm2GXexolN7btI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D4tpZ7Zd; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20546b8e754so55605ad.1
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 17:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726531737; x=1727136537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lYVnb/g0RfG35wD1qjml9GWDsd8MPrJi+PFGpQ/sLJ8=;
        b=D4tpZ7ZdqfoqwufKbHsoBqsm0zV3+u3RToOfrqN3mQKEfSbSqe69JgcTJIpI2BDOkM
         96bAiybklKWm2StAddXbfYYw1kkCJakn0bb7ugtVgklEyNtxDXZS5Mg73Ela/ndtkYYx
         gvx15A6JXxmp87GSNfK5FK0N7rMq7Aj17icvphWqRneJZ+NuIDUDueBMbTH/4WMorgfg
         pT/K+yZ9+mKlfM/stqkjou8hKsPT2L2DD13aJ8Y/npL2Lqz8LjiQqID6xZobkfNPXDdi
         rz17DZnNEkrOfkcc7JT9S8++N8bxylOJFbmCOq89Zo/djfBhVKefMFYA+F1WsYk6E0Wc
         E2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726531737; x=1727136537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYVnb/g0RfG35wD1qjml9GWDsd8MPrJi+PFGpQ/sLJ8=;
        b=WCm5l7Tj2aav/uhTua0EAD/aPO8CZpy2TVwy21xdGkbHaaEk+z9OwPa2F9ZXSbUCNl
         XRLHNrOdNYBMORms+2LTH1OQn14QpCxklBYd8pTrrwjSwtZcQaMGs7AsFaf+xjOke+gC
         45gYTv7D5Lbs6AGBTytpbxEJoA49PRUqCLZAdjlWZjV+6+DnQha7d8FGr8RuLKLvR9mY
         c5kCB+UM1uWrAavJxiNirexYmj6l8z8iw/+ybL8vvJTtzZoyQ0UetSgzUovUdrEb5amO
         cZDuvvEMdRtrrfG+ovKnV1biqsQB8cUqEib9taLwpAwNR5AH9yRts3It5TbI4urRUUpk
         kKIA==
X-Forwarded-Encrypted: i=1; AJvYcCWtbYtrTBkJm/AYctYrZ73ou6B0BdsewuiKEVmJ3A+yEiyfNmnf1GEh8FpjNLLqKWyxO6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvIxG46WeXWPhmvP5hFxd4aGnq+xQ87l4eUDcxWAHLFaYsKDMj
	Yw780ccpYexCOy0NpBBe9WWlYoJYP+vxBrtJQPTyTnemcOf3c+aHaJsw8KHaDw==
X-Google-Smtp-Source: AGHT+IEULl1QBQ7YrwmB4g3K/WfULHnzZQfOuuzFBN9L4qbSMOWfGNY8cUYqI/ndmxk1FCVk+lixXQ==
X-Received: by 2002:a17:903:5cb:b0:1ff:622c:27b2 with SMTP id d9443c01a7336-208b4325172mr702925ad.3.1726531736316;
        Mon, 16 Sep 2024 17:08:56 -0700 (PDT)
Received: from google.com (134.90.125.34.bc.googleusercontent.com. [34.125.90.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079472e15esm41386405ad.244.2024.09.16.17.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 17:08:55 -0700 (PDT)
Date: Tue, 17 Sep 2024 00:08:52 +0000
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
Message-ID: <ZujIlLqBEGOsxYRa@google.com>
References: <20240729183246.4110549-1-yepeilin@google.com>
 <CAADnVQJqGzH+iT9M8ajT62H9+kAw1RXAdB42G3pvcLKPVmy8tg@mail.gmail.com>
 <ZrJ3_esc7nBb6k9_@google.com>
 <CAADnVQJDki9GCxDAaGJWb+HrKT2EnzYXM8K3238XxPtHkhU0Ag@mail.gmail.com>
 <ZrUxxRpp_hd-2zyc@google.com>
 <ZuifmkOiuV9-oXgN@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuifmkOiuV9-oXgN@google.com>

On Mon, Sep 16, 2024 at 09:14:02PM +0000, Peilin Ye wrote:
> I just noticed, however:
> 
> > On Thu, Aug 08, 2024 at 09:33:31AM -0700, Alexei Starovoitov wrote:
> > > > Speaking of numeric value, out of curiosity:
> > > >
> > > >     IMM    0
> > > >     ABS    1
> > > >     IND    2
> > > >     MEM    3
> > > >     MEMSX  4
> > > >     ATOMIC 6
> > > >
> > > > Was there a reason that we skipped 5?  Is 5 reserved?
> > > 
> > > See
> > > /* unused opcode to mark special load instruction. Same as BPF_ABS */
> > > #define BPF_PROBE_MEM   0x20
> > > 
> > > /* unused opcode to mark special ldsx instruction. Same as BPF_IND */
> > > #define BPF_PROBE_MEMSX 0x40
> > > 
> > > /* unused opcode to mark special load instruction. Same as BPF_MSH */
> > > #define BPF_PROBE_MEM32 0xa0
> > > 
> > > it's used by the verifier when it remaps opcode to tell JIT.
> > > It can be used, but then the internal opcode needs to change too.
> 
> There's also:
> 
>   /* unused opcode to mark special atomic instruction */
>   #define BPF_PROBE_ATOMIC 0xe0
> 
> 0xe0 is (7 << 5), so it seems like we've already run out of bits for
> mode modifiers?  Can we delete these internal opcodes and re-implement
> them in other ways, to make room for MEMACQ (MEMREL)?

Can we instead use the unused higher bits of bpf_insn::imm as a scratch
pad?                                                   ^^^

For example, instead of letting the verifier change bpf_insn::code from
BPF_ATOMIC to BPF_PROBE_ATOMIC, keep it as-is, but set the highest bit
in bpf_insn::imm to let the JIT know it is a "_PROBE_" instruction, and
there's a corresponding entry in the exception table.

Thanks,
Peilin Ye


