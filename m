Return-Path: <bpf+bounces-78070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A075DCFCE8D
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 10:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49942307F015
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 09:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46ED3191AC;
	Wed,  7 Jan 2026 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a1eyvgy4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AED3161B5
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778165; cv=none; b=Ju2lVlyyfwY1F7H3KvIGlW1H/nIuzXLOpxBslNZ2UW+oBMVSYSUX2VxZzeoJSqPHsdC86wvbHj0EbdTUvwA/Jg5ETtbA9T2r4S2nNJB6aPg9OPf3eqM9we4K22BfP2PpAgLM7ZAV+cJdQsxDmiiNXBaJSINT30t9lJBHIKRrCQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778165; c=relaxed/simple;
	bh=2lLk2OnF51neQ23htcb5Tc9D7Pjc7rtydCq04TCve7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctESemzfvn894/4Zc3LTTH3VlZhRMs6C2p21vp0UO+Iz2DB0V9YBq/aNIuEW/HVDdQ0dS1MQredSxJ97bBDQIUgknBUHN+WKVCq9O+hpg9vfYBKu+/CnEoKmr6PcJS7mxZYDQA4oFG5bY69zBroHMFpMZ+O0icg2wQT1aZfSkFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a1eyvgy4; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b725ead5800so257762066b.1
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 01:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767778162; x=1768382962; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qAmBFvHljQCF3L3oXr+WZULma4DAz/lJTXBequgmr24=;
        b=a1eyvgy4fNsijNJupgIOWUWgBjJwmLpNrSZPp7emXiqaeADTp5vxwfh8EbcTHFUSC0
         B3JvPm5RsOs1ZgnfjbBVLCXoPygyVgXo5ynyyv2+RK9l9ByYgXb6r9ZQYpvzTIA5Ja8X
         T97Ws0093jMXNXdBH0TMsTKYvUhWcpRhj1EqoGgDtOt8W4R0pwvSwVFenLfHy3VNsvSB
         TpHgCDMjlqmouTvSST3vyCf/KNcXOeBcf37BF8/nahCzY1MKoiiCS2oNwh08QvwtnWnH
         UczWgbmdurWlRVBOKdCH5jC5gHYSfgT1RCec4co28rTCYMSgv2mXNAWe7DGMKlv7Xak/
         Qpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767778162; x=1768382962;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qAmBFvHljQCF3L3oXr+WZULma4DAz/lJTXBequgmr24=;
        b=ET/kh45fS/pmRq7vGe+NHRTS3tZMjdRkjiU0YptbUMb/pNpL+7rNrOLZfcLRmFbiXM
         XJA2xcyspLr5gPnV8cSFZ7JVa/Ev8MQP0+OjYFJvqOgziMrI4lrbog898vCINulprIA1
         69F4LIN3YjAOeVYWs7TjQOE5gNxUUTBxLLBCfGezFReo4o/ImlyFl5Dc3LsCjhytoViu
         jPNxKmD62LvYyEbMaZHJEXkGqQQnaZWhLheRElyH2Px04XDUj0gfks3uPQc7O7lODqaL
         ZHMHPwhQGtno/iXX8r73UzDUDDg3K8Kbn8AOUCGiNtlstyH7bZBZfTjZb8taKG5CgdeR
         zk8w==
X-Forwarded-Encrypted: i=1; AJvYcCXG3j7t0iGRzJ27BTf2nBBV+G1Xaod6NKYUx43LIuUuZjn9G3anPg79g41UldagbkDAZoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWxebyi+/Gd7UvzfpGViLrgJxf42dRR93bwATwyC622DIlWhFG
	Emq2LXMidZP4eX4t+4jJKrS93vFEGFGyBekfmwXGGnmoa/eNN6mHCzTvo5hLb1PpBg==
X-Gm-Gg: AY/fxX6EBHKH4B9lunFzEZiYaXVkvAJaprB92rYlK/Em9fMKYPrzCCbpliSE6SNUHE9
	E4G7uosQTDqxQ654Bvl5jnf6FVl0JgxhMV/ZtsggBpimYPRkAgOZDSoDlznDplaYJqMQBO20r9Z
	aC0/vUPyTT5kDRQiCw9HhR4Nd/uAvcQPnZ74zr5TMSdgguM4Utou7QH0rrnaBCg+M8+4c6beNq5
	gfrV8r8QsjVfYetcCS+kvwUXOyEpPJYcddEgdYqPg483eHu2Cwh72SPpJK6ragGi93JO7F9SIeY
	/UaWbM6Xtm/55jiVIU5qj4nEgzhD39iDQnKUp3iVDBGrtB9PEEii1fZFWB5MLNEStvytSc7fyZH
	kR2jktQPjTm/rhsvN6l7DIiJY/li1sicraYy9KGA8shutlQRV2XH3bxe1DK8OI1B4K8uuLQ4aKp
	FeNA8ChTu01NtaW8Z/D71Y+76b88sM77F6LzXmwD++Dt9GBLHjfeLHKQ==
X-Google-Smtp-Source: AGHT+IEZ569HZDlJCwAETH6UvXRvz+tkMRRxeKTBnNpUb4XcosV6KbxuzsGMXy5rQgg3tcmEAr8VOQ==
X-Received: by 2002:a17:907:cd0e:b0:b73:5b9a:47c7 with SMTP id a640c23a62f3a-b8445413775mr187603266b.51.1767778161682;
        Wed, 07 Jan 2026 01:29:21 -0800 (PST)
Received: from google.com (14.59.147.34.bc.googleusercontent.com. [34.147.59.14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4cfd97sm444211066b.36.2026.01.07.01.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 01:29:21 -0800 (PST)
Date: Wed, 7 Jan 2026 09:29:16 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, g@google.com
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH bpf-next v4 3/6] mm: introduce bpf_get_root_mem_cgroup()
 BPF kfunc
Message-ID: <aV4nbCaMfIoM0awM@google.com>
References: <20251223044156.208250-1-roman.gushchin@linux.dev>
 <20251223044156.208250-4-roman.gushchin@linux.dev>
 <aVQ1zvBE9csQYffT@google.com>
 <7ia4ms2zwuqb.fsf@castle.c.googlers.com>
 <aVTTxjwgNgWMF-9Q@google.com>
 <CAADnVQLNiMTG5=BCMHQZcPC-+=owFvRW+DDNdSKFdF8RPHGrqQ@mail.gmail.com>
 <aVts9hQyy-yAjlIK@google.com>
 <CAADnVQJr0WqmqA2fQeC0=Jn5F-ujWmUkL-GfT6Jbv8jiQwCAMw@mail.gmail.com>
 <aVwnUUXmgE1uOOj4@google.com>
 <CAP01T75ATFb_gjy5_fSwt6=QMxt7kGSS+12SJN9rz9SfJQ7Qyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP01T75ATFb_gjy5_fSwt6=QMxt7kGSS+12SJN9rz9SfJQ7Qyg@mail.gmail.com>

On Tue, Jan 06, 2026 at 04:13:24PM +0100, Kumar Kartikeya Dwivedi wrote:
> On Mon, 5 Jan 2026 at 22:04, Matt Bobrowski <mattbobrowski@google.com> wrote:
> >
> > On Mon, Jan 05, 2026 at 08:05:54AM -0800, Alexei Starovoitov wrote:
> > > On Sun, Jan 4, 2026 at 11:49 PM Matt Bobrowski <mattbobrowski@google.com> wrote:
> > > >
> > > > >
> > > > > No need for a new KF flag. Any struct returned by kfunc should be
> > > > > trusted or trusted_or_null if KF_RET_NULL was specified.
> > > > > I don't remember off the top of my head, but this behavior
> > > > > is already implemented or we discussed making it this way.
> > > >
> > > > Hm, I do not see any evidence of this kind of semantic currently
> > > > implemented, so perhaps it was only discussed at some point. Would you
> > > > like me to put forward a patch that introduces this kind of implicit
> > > > trust semantic for BPF kfuncs returning pointer to struct types?
> > >
> > > Hmm. What about these:
> > > BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
> > > BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_RET_NULL)
> > > BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_RET_NULL | KF_RCU_PROTECTED)
> > >
> > > I thought they're returning a trusted pointer without acquiring it.
> > > iirc the last one returns trusted in RCU CS,
> > > but the first two return just a legacy ptr_to_btf_id ?
> > > This is something to fix asap then.
> >
> > No, AFAIU they do not. These simply return a regular pointer to BTF ID
> > (PTR_TO_BTF_ID), rather than a formally "trusted" pointer (which would
> > carry the PTR_TRUSTED flag or a ref_obj_id). scx_bpf_cpu_curr returns
> > a MEM_RCU pointer (via KF_RCU_PROTECTED), which is somewhat considered
> > to be trusted within a RCU read-side critical section *ONLY*.
> >
> > Kumar/Tejun,
> 
> Yeah, they don't return a trusted pointer. I think it would make sense
> to change the behavior here by default.

Thanks for chiming in and confirming this Kumar! I also agree that any
BPF kfunc returning a pointer should be treated as being implicitly
trusted by default. I can't think of any scenario whereby a BPF kfunc
would want to return a pointer that'd fundamentally be untrusted, but
there always could be some exceptions. Anyway, I will work on this and
send something through for review soon.

> A non-trusted pointer cannot be passed to kfuncs taking trusted
> arguments, so hopefully it will only make things more permissive and
> doesn't break anything.

We can only hope! ;)

