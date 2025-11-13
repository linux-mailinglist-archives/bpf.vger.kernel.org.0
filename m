Return-Path: <bpf+bounces-74427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA8FC59272
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 18:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4719535E888
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 17:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4022FABE0;
	Thu, 13 Nov 2025 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeuNiak9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C362727F3
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763054235; cv=none; b=tN5hYpR3H/23uVUGg4oFbY/pxAwCkeISBSlDg4uBlZhxNuE37zUTlbHio+64egSvY8wMbbllvoeYmnkYjhOkoGIE9rr4vZBdKo9U2yFPKivbKVpM1tqRyM8VaAci6hv2Kw7A7c+xjgO2i4uNjD62wZryOB8tEz6Gyj56+2AFT0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763054235; c=relaxed/simple;
	bh=Zhz80cMnx8q+UfKEIXA1zXdhSkoVcxlOP4yVhENwo98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwxtZ7CPCeki4kpTjTa3cNYnqJTm8Br3ZsaTfrSaWH3jtN9C2Fo4uNwO0oThD6eWVdXhJjI0GUMjsiC3wP4v+va5Td3U15tewnUq/Mt7X5jALcPazQ97FbTqhITUlDY4eyyarsGgQ17jpDzzz34sfecXXwb7iPV9x95ITXV13XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeuNiak9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477632b0621so6946515e9.2
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 09:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763054232; x=1763659032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5KyfVieqHXba+u7m0lOAZosFkzUNJCY6nPeemJTYVw=;
        b=KeuNiak9sgzJ/vV+87wlKAvU8PeROUS37BNuZ1g3HKGUMFPg4G1gMy0qMpzJiLEnDk
         ZwS5Xog3MyXZU7t/HW3XSTfcZ+h9VMSe8gDvm4E8TsiDUBHNWgJWgdVuGCsQqBglSbMD
         JiUnropLIHHqKkrs/DlpD0hSM/auQ51OyPjXZtLpv5+6wg6yUvOcopD3N+f2GJuT15Ov
         vwZicy68xeAViw9m5IabG2NrUET90ieVWORe84d4L7vBOr3S5AtGeLJMNpsSxsxRP0Qb
         ymO+DVXJL7ghoZapeHuXnyOwu1B4ecOQq+oXw3entHz5UFDjjrbJ4m3XT4lFr4cI5xFC
         6Rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763054232; x=1763659032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5KyfVieqHXba+u7m0lOAZosFkzUNJCY6nPeemJTYVw=;
        b=vb89dQN657tFi45cb9WwsYB2one7/X7AKDpB2sHZM4g64ggCn4TT3RdfwRV5JPiyXj
         JtRrBCeuIrDaANWE1MqgEzsGe+csY2gxrFhRGUVJw260Fawoyjr/y+XVMr7KmppEiTUs
         uyjKGv0NP5MUprtJiJ5kHJab0OH2FzAOwI9cigTfK8QkgrWzmNc+NI7CisuuFUK7BBa7
         ZUhpe+W5D3o30xvJJToR9VHdchreZA8Zchbg/4AeUhOQYp4ndF+K4zZA0NWXD1P/y8G6
         5TdzCO0awNtkm6BpctfBqjDlqlLSPi2kiwRkE7mz0ntxsJ48gN1/Q4fpbg+JHwwGhhAF
         9EPw==
X-Forwarded-Encrypted: i=1; AJvYcCVjzj30kIc7W8AzLm08Y388RdgiYwO9BUrdrD33QBefQ+Ut8fIkr8wXPfTF8ldR7PrLi0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyry8vkpB3VtzCJWJDht0LyOh/8s9LVvwwR/+a3YDu6TXLtLrbd
	is4ehTS6Qzajmzii1H5GRB+4Uf/IO1X2FtN8yQ3k87gxndjUKB4rQ5dU
X-Gm-Gg: ASbGnct7JoB+aSo/m1ShI+AtCHLPK/yr/xHwOX6rK5Q15GSAAEiWXBCxxCR0I/jx3kw
	rU5WT23nABcqPyXDaeC5lZrH/mO6Q9lmbj8u2dzFeWbV3qKYoilbTItOzs3R7W+m38AMOm0NdjD
	20fZlfE4uMXxchFqDyJPHIGNpOqUGizRvtipCPToyz4NqXnyDekhc9a1e6PPze1/Op3WRALgSiz
	R0s3aapoRGbo5BWVETcFqDYg6OaDckeZoMz/4ORs90/2GKxYxL0S94yFSPLdUzro0FLnSzoBi9L
	ePBMEvbKUETRa5LqyTAfBB1PsmtSyebHZq+so+HJ+SDTC0pm0oCCxIguz1RvZSapnFSS0LVVBcV
	YNNVfUjRZNcmlOV4MGJP/I1cDLx7WP4OwVxNzt5Ame6rhKn+IXDMfFUVRUFvaWfE+CNZUzx0k3Y
	FGmrWAQbCkeWQW9Bzdied4Itd1OnGT1CpmjlQxENtCMz8bEEOSDkC6i0/rDVtFyO2cmiMFCrtHA
	ks=
X-Google-Smtp-Source: AGHT+IHw0+dMsmHzK7SKkNNLgtvqsvSU9cN0flfGWOToSbXh1gwkLoXOxo+8crIR20brH6TmHylItQ==
X-Received: by 2002:a05:600c:450f:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-4778fea51cemr2086535e9.27.1763054231540;
        Thu, 13 Nov 2025 09:17:11 -0800 (PST)
Received: from mail.gmail.com (2a01cb0889497e00f96f7d4f53fe5ba7.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f96f:7d4f:53fe:5ba7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c847bbasm45065975e9.1.2025.11.13.09.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 09:17:10 -0800 (PST)
Date: Thu, 13 Nov 2025 18:17:08 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: ast@kernel.org, m.shachnai@rutgers.edu, srinivas.narayana@rutgers.edu,
	santosh.nagarakatte@rutgers.edu,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] bpf, verifier: Detect empty intersection between
 tnum and ranges
Message-ID: <aRYSlGmmQM1kfF_b@mail.gmail.com>
References: <20251107192328.2190680-1-harishankar.vishwanathan@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107192328.2190680-1-harishankar.vishwanathan@gmail.com>

On Fri, Nov 07, 2025 at 02:23:27PM -0500, Harishankar Vishwanathan wrote:
> This RFC introduces an algorithm called tnum_step that can be used to
> detect when a tnum and the range have an empty intersection. This can
> help the verifier avoid walking dead branches that lead to range
> invariant violations. I am sending this as a patchset to keep the
> motivation (this email) separate from the details of algorithm
> (following email).
> 
> Several fuzzing campaigns have reported programs that trigger "REG
> INVARIANTS VIOLATION" errors in the verifier [1, 2, 3, 4]. These
> invariant violations happen when the verifier refines register bounds in
> a branch that is actually dead. When reg_bounds_sync() attempts to
> update the tnum and the range in such a dead branch, it can produce
> inconsistent ranges, for example, a register state with umin > umax or
> var_off values incompatible with the range bounds.

I think an open question here is whether such patterns of tnum/ranges
happen in practice, outside of syzkaller. We probably don't want to
introduce additional logic for something that doesn't help "real"
programs. I'm happy to check the impact on Cilium for example, but that
would require a patch to actually start using the new tnum helper.

> 
> There is a solution is in the works by Eduard [5] to modify verifier's
> logic to use the fact that the register's tnum and range bounds are
> incompatible to detect that a branch cannot be taken. Detecting an empty
> intersection between the range and the tnum could be a useful primitive
> to detect incompatiblity.
> 
> * Detecting Empty Intersections

[...]

> * Usage in the verifier and next steps
> 
> The tnum_step() procedure is self-contained and can be incorporated
> as-is.
> 
> Regarding incorporating the range-tnum intersection test, as it
> stands, if is_branch_taken() cannot determine that a branch is dead,
> reg_set_min_max()->regs_refine_cond_op() are called to update the
> register bounds.
> 
> We can incorporate the range-tnum intersection test after the calls to
> regs_refine_cond_op() or the calls to reg_bounds_sync(). If there is no
> intersection between the ranges and the tnum, we are on a dead branch.

Couldn't we incorporate such a test in is_branch_taken() today?

> 
> Alternatively, the range-tnum intersection check could be incorporated
> as part of Eduard's upcoming patchset, which is expected to rework the
> logic in reg_set_min_max() and is_branch_taken().
> 
> Looking forward to hearing any feedback and suggestions.
> 
> [1] https://lore.kernel.org/bpf/aKWytdZ8mRegBE0H@mail.gmail.com/
> [2] https://lore.kernel.org/bpf/75b3af3d315d60c1c5bfc8e3929ac69bb57d5cea.1752099022.git.paul.chaignon@gmail.com/
> [3] https://lore.kernel.org/bpf/CACkBjsZen6AA1jXqgmA=uoZZJt5bLu+7Hz3nx3BrvLAP=CqGuA@mail.gmail.com/T/#e6604e4092656b192cf617c98f9a00b16c67aad87
> [4] https://lore.kernel.org/bpf/aPJZs5h7ihqOb-e6@mail.gmail.com/
> [5] https://lore.kernel.org/bpf/CAEf4BzY_f=iNKC2CVz-myfe_OERN9XWHiuNG6vng43-MXUAvSw@mail.gmail.com/
> 
> Harishankar Vishwanathan (1):
>   bpf, verifier: Introduce tnum_step to step through tnum's members
> 
>  include/linux/tnum.h |  3 ++-
>  kernel/bpf/tnum.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+), 1 deletion(-)
> 
> -- 
> 2.45.2
> 

