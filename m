Return-Path: <bpf+bounces-58315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC086AB8793
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 15:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B66087B6F57
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 13:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37CA29AB04;
	Thu, 15 May 2025 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fX8Rd8kv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C9A29A9E8
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314773; cv=none; b=BdacdQG0WN7YB6HB0WKTnUUtd3RLB569kez8DpsGbzl834Dz3OR0A6BlvZIBJmXgcDSaNv82ZXo4T459kgDT7p2qKJz1DfCktT/bm5XVrGcbQL/pJM62PgqiuAfQCPY+NMY1PmmfSoOmCDnW5gskGkHBclr+1qAWeQ1eUMoyCGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314773; c=relaxed/simple;
	bh=h3rS68HIKc08d7AKcI8nLqC7n+gNjlA+jVgKmtRSPnk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=br0kAQyRQ7yk1vfiPZ9Ko58TCzyAkllPbAF9zg7jznz9SM5btta/xG2CRLeaCaUQ44YeLSgn9vu2U4AYwtQwMLhx9VmNi1TVij2K/OLrRdcX3EqO+6q9IyiHXpGh4w+3JueJ62NrBYP4b0NO5zCfmdLPvfcHk5FbnyizMCv862U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fX8Rd8kv; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3a0b9625662so804907f8f.3
        for <bpf@vger.kernel.org>; Thu, 15 May 2025 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747314759; x=1747919559; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Sc7s4zPug7QCBZMgJvj3UJe25bWXU+WVGJNmLlNHLU=;
        b=fX8Rd8kvBp/aYEpGo5D+4unY4mId/c6f4kgKXShbBknXl/DCRY18f8EnDB5juDMaD/
         SyEKXtJizYTfpq4e8MMUZzCDmhsYOEuyijMK3Cn0BOClkXCrjv+FjwvWwi77qk1DiCMI
         i3fVO1DiV1JCf/QTOfOE5a7zVHlqwBFjItAw8ghsFjrDv47QexJzq3fpnzK50isFqddn
         5ksDi5W2WZWGWty6Za5dndkxh1paNdC2ESxDm57AKjNTTqo8rsOTgehqjr3F3oiM3LSm
         S3zj+NCAoues5SEPFGV13mxwoE4E2uwbEsQIXxlsuy85Xe+/zWxrvjAKPADd4VIZsB0S
         PdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314759; x=1747919559;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Sc7s4zPug7QCBZMgJvj3UJe25bWXU+WVGJNmLlNHLU=;
        b=UsjvCvYe0Mg2xLRZQnr8OcTpqFefuxrtCIWyROp2KizTpCdYikr5To8arZQ4XVx1Gc
         C0Q8OlkBGg0udwS5e8SkE/8SRw2g0yhvWS6rGR7gYCr+9qAPQc4I8/uTD8YXI1KkIKP1
         Q7US5Loy35HE+RRSYjALrUfAbmvjq1VaLfCx/wTplKPq1tmR4B0oqD/f+/Dt12CWONal
         +xPdtYvJ3kIEMuYT78MpPUulrNtilEDQq0uYLYOl2+O3zp3WPAR5spNoIEKPqrCUa60o
         W3ZOKg5ujYAPrPMsZm4VQcogTFqsZ8GtbZNvBGKeG1O71aHL9QqPxceryjsnYDpO50mi
         4wog==
X-Gm-Message-State: AOJu0YxbpPbPu7b5YYhuILfevNdYrrP0ZjovQXAX+JrigAu3F719NWFq
	KAUXyTR9Smh6tluYUHXvVpVGvd8O58bmMNJlOm0k8qAQPkmmzLE+YlPn2dIQBB+qSPWD6yCeUxI
	gF5B5rtLv
X-Gm-Gg: ASbGncsJOK60fzYosCd0DQ5O+epnR/Qg521pYCH4UArAbfbhMgEDYNee2sAsgw79adR
	QaGLHkQTi5Ait9fyqe3N8nnoRud6uOBzF5T9IDDoDeAN9a0Tp6k4Oe/kgq5dx753KPspIbU7qf9
	N4VNo/0fAE9qy0/Bb5WoJx+wNgWX61ihis2mppPAZRiW1hwtCEB4G3qPg4drx/A6Py+Zsf6BTcv
	3rDPIGoCvOyN+AB3gMc9LKGeDF2H/bDWMy+ELviSIHkd/oa0Z14i7IW4fIZ/AMU7hl3EYw0gG+h
	o+usW1oS7mpqm0E8BCvOEmMuqP6cEB+AmzgM//afvwtpnZXUDnn4QanbNWL3zdgRtG6Tz6kLP1o
	=
X-Google-Smtp-Source: AGHT+IGU57xOouQYJOoHXSv7L1CzbOeG1YaSFTyHO9EqbI2SUzbIwPqP+E+vwOTbyIhTtUlFo0TsXw==
X-Received: by 2002:a05:6000:2506:b0:3a0:8c45:d41b with SMTP id ffacd0b85a97d-3a3496a71b3mr6559388f8f.20.1747314759305;
        Thu, 15 May 2025 06:12:39 -0700 (PDT)
Received: from u94a (1-174-3-124.dynamic-ip.hinet.net. [1.174.3.124])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4df8299e6dbsm2404387137.14.2025.05.15.06.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:12:38 -0700 (PDT)
Date: Thu, 15 May 2025 21:12:25 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org, linux-mm@kvack.org, Kees Cook <kees@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	regressions@lists.linux.dev, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Eduard Zingerman <eddyz87@gmail.com>
Subject: [REGRESSION] bpf verifier slowdown due to vrealloc() change since
 6.15-rc6
Message-ID: <20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

There is an observable slowdown when running BPF selftests on 6.15-rc6
kernel[1] built with tools/testing/selftests/bpf/{config,config.x86_64}.
Overall the BPF selftests now takes 2x time to run (from ~25m to ~50m),
and for the verif_scale_loop3_fail it went from single digit seconds to
6 minutes.

Bisect was done by Pawan and got to commit a0309faf1cb0 "mm: vmalloc:
support more granular vrealloc() sizing"[2]. To further zoom in the
issue, I tried removing the only kvrealloc() call in kernel/bpf/ by
reverting commit 96a30e469ca1 "bpf: use common instruction history
across all states", so _krealloc()_ was used instead of kvrealloc(), and
observe that there is _no_ slowdown[3]. While the bisect and the revert
is done on 6.14.7-rc2, I think it should stll be pretty representitive.

In short, the follow were tested:
- 6.15-rc6 (has a0309faf1cb0) -> slowdown
- 6.14.7-rc2 (has a0309faf1cb0) -> slowdown
- 6.14.7-rc2 (has a0309faf1cb0, call to kvrealloc in
  kernel/bpf/verifier.c replaced with krealloc) -> _no_ slowdown

And the vrealloc() change is causing slowdown in kvrealloc() call within
push_insn_history().

  /* for any branch, call, exit record the history of jmps in the given state */
  static int push_insn_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
  			     int insn_flags, u64 linked_regs)
  {
  	struct bpf_insn_hist_entry *p;
  	size_t alloc_size;
  	...
  	if (cur->insn_hist_end + 1 > env->insn_hist_cap) {
  		alloc_size = size_mul(cur->insn_hist_end + 1, sizeof(*p));
  		p = kvrealloc(env->insn_hist, alloc_size, GFP_USER);
  		if (!p)
  			return -ENOMEM;
  		env->insn_hist = p;
  		env->insn_hist_cap = alloc_size / sizeof(*p);
  	}
  
  	p = &env->insn_hist[cur->insn_hist_end];
  	p->idx = env->insn_idx;
  	p->prev_idx = env->prev_insn_idx;
  	p->flags = insn_flags;
  	p->linked_regs = linked_regs;
  
  	cur->insn_hist_end++;
  	env->cur_hist_ent = p;
  
  	return 0;
  }

BPF CI probably hasn't hit this yet because bpf-next have only got to
6.15-rc4.

Shung-Hsi

#regzbot introduced: a0309faf1cb0622cac7c820150b7abf2024acff5

1: https://github.com/shunghsiyu/libbpf/actions/runs/15038992168/job/42266125686
2: https://lore.kernel.org/stable/20250515041659.smhllyarxdwp7cav@desk/
3: https://github.com/shunghsiyu/libbpf/actions/runs/15043433548/job/42280277024

