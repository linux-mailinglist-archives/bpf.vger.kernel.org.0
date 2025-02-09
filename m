Return-Path: <bpf+bounces-50905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E46EA2DF9D
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 18:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9D21884EF0
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 17:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1904B1E0B67;
	Sun,  9 Feb 2025 17:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgjxMTeT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEAC2F22;
	Sun,  9 Feb 2025 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739123489; cv=none; b=Qe0NQpKCaZgh4rMJm1go0uykrDce/94NXHutqe5ZIuFvSkFO6HpVcfPMBt3qepGGSryHFl1G0peZFi1FflVxqogyJdGA6uhOpzRXoaY32Ehs4SmG0hjQTIOG01GULVn7jMP9e/85f0Rcb+15gIgcV0O7idUTjK4herluE7VW2io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739123489; c=relaxed/simple;
	bh=lhZhisK9e2N4pYaos/o5OVqde3jXWtqN25OCLXLk0gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7tdY9uT83k6FG1XGvIgX6xb/d2WJdZmss3lj40MKrEqj27Oynw3yXb0q7B8C00WMg44sFS9Ke+c425xqIrYHXYKrvwwog9hJcSwds7/qYEXj2JQaq9Ah27qw71AyCP1o4lR6VSKyOxef7EvsaT6vTRMSNc1A5PsEYXPKKyt2Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgjxMTeT; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e460717039fso2684809276.0;
        Sun, 09 Feb 2025 09:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739123487; x=1739728287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtnRjXGlyN+ZpcFd0vQyskxHmTk5LTFkbbTZuhC/eB0=;
        b=DgjxMTeTazWm5gxK5JsJ8s98BKoFJEb8CDhyI9ideCb6/TBVANiIipFuVXc6wJ9Kxr
         RmA9Y7f4SazTTBb80/cpSx+IdPClyOyHtTBrC0bLldGv8XUQA5EbHhz1+v1VreEIcas1
         yZLRRislrtKIf+tTN5t7q5dzL6Kwwc09f+iiDzyGM/8R0SO/hL6/Il1/aGr86WRKqkpl
         omv5g5q/J+CnZKqDTlPLGnXwHQTSA0CFkhOFAHxCmH3o9FHyRspXy/ZcEbZ5d5Ag/5g0
         I/6jYDZJSG+m66mpJR7Gpt0ZmhaRArfrfs/ew5wMz2Pgf3iHIvDTZSyyc/mcWRksSQ4I
         +/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739123487; x=1739728287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtnRjXGlyN+ZpcFd0vQyskxHmTk5LTFkbbTZuhC/eB0=;
        b=fAp7v6aCzmRm3QtWX/NfesoPaTnab1sOWu4SVxqqVXOdkNuQWd1VYYlUKK0qKtu6gL
         otiZi6SxtdegSLr6+qFYWs2KyLiWtknTlkhav90gVrZ85Y7OAz7U2otX/Ghy+Do2llAs
         dpD9/BsDDMFY37ZkBtCREMESi02k52g0yRSnRsQepC+PRku85ToA0oz0eDKXiFBygIBR
         JhjoUFc78uqKr0PCX+ECmd5MCHEbQ0BavJUjjmoPkyOcHWULqUjLS93KgWQk6DCoS2hd
         hhcLkb+8u83/kRzogvw71NpCVEFqbNH368ASmRN4A7a+1HsrUctVnCcJ3/zvzrcJq7tb
         UFiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN5nzqQx3GQ4jQbxpvZZ8YXUs6/Q/HN1vjn5IVHUtSudbuO8mLLdl2iLLSR07dAKsR3Upvs0k/H63BLA23@vger.kernel.org, AJvYcCXe5oOPOD5nN/ew8JZD+/1ZzV3lLm/JdYT8skWuusiqHts6BfBuZV+V8whKMKyahgVsELU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAKxxe96VynCZSYmLxVmAQLLu+v8xkC6pDRrAIxROQfteueEOP
	3ODVsvFkkNWxEjtUBPMo7jgk69E32waqqxYPrlpN+57+ryNbauWR
X-Gm-Gg: ASbGncuHxJMCxssa44pH2PJqQECEGY7pWpeIWUx8No0XfyN8qSz7wgg/dIOXpg1dlQS
	HJBAflZOOT3UU20J+KM8Iz/dJqOkC6P3RD3dbSBAlaanE1qBaZlXQ8ovGNntPC3GeFsg2cH5sCr
	HB2+ZO7qKjiYqVKTR7vuifBF0c/XQutVMJ+/uCC0BEhqlkHRhm9xeeit9ZVU+YBo4CTrIdrqNjs
	HFx53LSgOWEb+wbgAHTb+c4y4X0xZkKks56m69ttl/SyaGLpYqj5EDsdozOsKxfqXO1Smnk1l6m
	Cts9vTOb+oeupQUMtIdPqy1e4GYaeaZgBmVtTQlz9ucrUJBVwkk=
X-Google-Smtp-Source: AGHT+IE0JNK1KBOop3/PW5X6yLhiiubhtiDjrrZFqxFA+wzEhcxSbruWmm1kZgEtDMfR85by71TzNQ==
X-Received: by 2002:a05:6902:2501:b0:e5a:c837:a8b6 with SMTP id 3f1490d57ef6-e5b4618bf21mr8973003276.19.1739123487036;
        Sun, 09 Feb 2025 09:51:27 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5b3a45d7f1sm2053561276.40.2025.02.09.09.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 09:51:26 -0800 (PST)
Date: Sun, 9 Feb 2025 12:51:24 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] sched/topology: Introduce for_each_numa_node()
 iterator
Message-ID: <Z6jrHFGr-Iv0gRbI@thinkpad>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-3-arighi@nvidia.com>
 <Z6Z_S6UDg80LUQEi@slm.duckdns.org>
 <Z6aBRs3STxI7DzYk@gpd3>
 <Z6aBjoWa3CGvp68U@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6aBjoWa3CGvp68U@slm.duckdns.org>

On Fri, Feb 07, 2025 at 11:56:30AM -1000, Tejun Heo wrote:
> On Fri, Feb 07, 2025 at 10:55:18PM +0100, Andrea Righi wrote:
> > How about for_each_node_state_by_dist()? It's essentialy a variant of
> > for_each_node_state(), as it also accepts a state, with the only difference
> > that node IDs are returned in increasing distance order.
> 
> Sounds fine by me. Yury?

for_each_node_numadist() maybe? Whichever you choose is good to me.

