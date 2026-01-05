Return-Path: <bpf+bounces-77880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC065CF5987
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 22:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64412309BC0C
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 21:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEDD2D7DE2;
	Mon,  5 Jan 2026 21:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jLlJwdml"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E7B57C9F
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 21:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647065; cv=none; b=qq1od5icDuyvWWdW53nz8zMzUsHXIzOJ3KDJWex28su9npVxL2Xc4IAw/4V1rd3tNpRc9p23NqiovvRtAJRBHCrsN4n/SszBsNGe2GOpnKZK/cyCWvjP1gOo1LGYQj7FqPn4UV1TBaM222E/3dwqY/Qd/IkdlWK7sy0b4dYIIJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647065; c=relaxed/simple;
	bh=ShY9KNnVLQ0fyXnGBHmt441cvYVse0oMts1K7E3gVCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C12rTrOEUCR4HwpC5yjk+BOilj4aRMCmHRdNWiVC9IqLIqr9JhnVHzcacJS54LfYbmOi6s5prvWfy9euc29K0infS0Aykz44h9Z0Hb2Djhj3PSJ4xfUZOjfqqh8wa6gOTW6pu2L0YUD+Xqt+DDP1cU0+72gExZW+lUHlwDAYy/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jLlJwdml; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b79e7112398so60869466b.3
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 13:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767647062; x=1768251862; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Pu0j22Ua6/B/af/fCm8aYXRd0QaCIL2/BGIXkmKA6g=;
        b=jLlJwdmlHUut4OPzz3tjnc7NGndR6e8ORkIZKxYOOE6LV72i3ABdclu4/xcOM+g03O
         ui932qzTAQYgpkHmC/dAdSE/IdIzzz+L0IdSz+cKYuTQSXFSCovk3vBTiinQQCaFLkq0
         HkcNcAcy9sJ6Oprks4jYMqVqqgRuDEFsPw/ibWRj0k9VByPTsgwiG1v79+EhuOdrjn2P
         pTEbKbw3cN5QtlSLVOUEcONn+EtP70D1s39NecJoY5O2RBLUj3dbYijmrVu4uUC55xA2
         olBkeB4qDGRdHvuJVdu43YdHnJpfBoITOa3zDE4iD4xcfipA85+iWwHYGVDHrSDYZDZA
         Y8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767647062; x=1768251862;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Pu0j22Ua6/B/af/fCm8aYXRd0QaCIL2/BGIXkmKA6g=;
        b=B4JTuzvdyqC5BJ7CFxnH8dsznv8DERlzqh60Uy/2y17Cl9urZbMGPwytvfYguRk3Ir
         2lrcca/z0y3GAJvyErUBImK57YBOHK0+ikrZCss2rxhmaZ5T51FKT7ewHMUkr4Rm+p4F
         5VKY80BBsCMDOpU6wjtwwUyfg7su7p3eN7Q4M+Ix5wDnURkztgu3XtSXZkY7nXf3grmN
         mWvyIU32J++VlEkbI9FCMIx2/6oLhyIiEBLSS8dgn5vfVK/4raTDEBwNHkCzzJRHeuYE
         KzaMdVQ3wIkHiKtYQQ1ZLqrZHJm4g1g28F4yO8xnuVIby00XofzD3UNQ6lbjZclWR3ov
         Gq1g==
X-Forwarded-Encrypted: i=1; AJvYcCUQrlM6eTDczTAkD9XQheMDiWYFG8Jc5lF1F1qsuZ+Pziug8wovj8lnaJJqf/xeSnCndjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRM1mKdyp6v6PB334ckrUssdBgAS9Fy59syK2LT9/dyE7BEBMW
	u+aN7pJ7W9xFDMnSrvoyxtNN4C/udd7U3Q7kE2Gkl7molK8drUTd41frmrgnhVzs2g==
X-Gm-Gg: AY/fxX6Fq+v1ES4Wjp2R0ZhsTn39SKpMK7FlpZRb7rAAbZBbbnlvgkq2v9ilL8ypw91
	SrreY7kxjonWq/xXGyggDXCM9BZ1IN0ZTOLUjtmLDi+AUJ8nILpkWqwmXaPrmR6yl1koNry1pQj
	XtsLuabT3Af395h7y7JlyhPKWBQnFgcMbuyCi5e0sS+CbSFwduzezR7Gz6T7iX5jkQLKsAMP5G0
	4/EASQ5atH7Yj1Bl9YW+zgsenYiF9dEY8pykUNE+i1JdWGNxGBhWznKBlSLSQB8F7rSBE6CZaw3
	u/moqHZJ+CSyWQ87dpd47MjZQ84FQTvZPPWdAQiRTdB7RUmLW0BJevnKnYjs6D4MbVvUgTvy6Mq
	tOxwxIZfmNrt0xYbew5v2YFzqXxeqOjMUJl8D3LmjNifQKJhHZWOgVpPnj4QMFCTkTAQQnWMaLT
	VCR37pgsIaqnmg5WWjEdDssTwvP0VK9f5SaU3WHksHJ+waA9jzTzXiTA==
X-Google-Smtp-Source: AGHT+IH5WTn41lg95uujB075zzBoLd9HIlELS6iNanZ/1oj+Lg79QDlEASfdo8DVdErdLUKvHN7/MA==
X-Received: by 2002:a17:907:70c:b0:b73:80de:e6b2 with SMTP id a640c23a62f3a-b8426bf10a8mr113572266b.31.1767647061473;
        Mon, 05 Jan 2026 13:04:21 -0800 (PST)
Received: from google.com (14.59.147.34.bc.googleusercontent.com. [34.147.59.14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a2bc6bbsm29697666b.27.2026.01.05.13.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:04:21 -0800 (PST)
Date: Mon, 5 Jan 2026 21:04:17 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>,
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
Message-ID: <aVwnUUXmgE1uOOj4@google.com>
References: <20251223044156.208250-1-roman.gushchin@linux.dev>
 <20251223044156.208250-4-roman.gushchin@linux.dev>
 <aVQ1zvBE9csQYffT@google.com>
 <7ia4ms2zwuqb.fsf@castle.c.googlers.com>
 <aVTTxjwgNgWMF-9Q@google.com>
 <CAADnVQLNiMTG5=BCMHQZcPC-+=owFvRW+DDNdSKFdF8RPHGrqQ@mail.gmail.com>
 <aVts9hQyy-yAjlIK@google.com>
 <CAADnVQJr0WqmqA2fQeC0=Jn5F-ujWmUkL-GfT6Jbv8jiQwCAMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJr0WqmqA2fQeC0=Jn5F-ujWmUkL-GfT6Jbv8jiQwCAMw@mail.gmail.com>

On Mon, Jan 05, 2026 at 08:05:54AM -0800, Alexei Starovoitov wrote:
> On Sun, Jan 4, 2026 at 11:49 PM Matt Bobrowski <mattbobrowski@google.com> wrote:
> >
> > >
> > > No need for a new KF flag. Any struct returned by kfunc should be
> > > trusted or trusted_or_null if KF_RET_NULL was specified.
> > > I don't remember off the top of my head, but this behavior
> > > is already implemented or we discussed making it this way.
> >
> > Hm, I do not see any evidence of this kind of semantic currently
> > implemented, so perhaps it was only discussed at some point. Would you
> > like me to put forward a patch that introduces this kind of implicit
> > trust semantic for BPF kfuncs returning pointer to struct types?
> 
> Hmm. What about these:
> BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
> BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_RET_NULL)
> BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_RET_NULL | KF_RCU_PROTECTED)
> 
> I thought they're returning a trusted pointer without acquiring it.
> iirc the last one returns trusted in RCU CS,
> but the first two return just a legacy ptr_to_btf_id ?
> This is something to fix asap then.

No, AFAIU they do not. These simply return a regular pointer to BTF ID
(PTR_TO_BTF_ID), rather than a formally "trusted" pointer (which would
carry the PTR_TRUSTED flag or a ref_obj_id). scx_bpf_cpu_curr returns
a MEM_RCU pointer (via KF_RCU_PROTECTED), which is somewhat considered
to be trusted within a RCU read-side critical section *ONLY*.

Kumar/Tejun,

Please keep me honest here.

