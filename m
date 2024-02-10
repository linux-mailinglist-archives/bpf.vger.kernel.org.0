Return-Path: <bpf+bounces-21667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A294C8500EF
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 01:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB4F1C22CD4
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 00:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8231FD1;
	Sat, 10 Feb 2024 00:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nC/5y7nX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5AD36B
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 00:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707523284; cv=none; b=lj2t7+XS/N7VT71mDJm2DqZwoUsLwtw3fvaP2cUFERbPbcysLcb7dYY8S1I5M/+VbNJLxCnTF72sx+lNx7WUEhKqjhFzDyZ+yyEcPuR4R8cwJdOOLKAYLjxL7pnP20WahNHogNjnoZlrnRUd+VQCX6yddKzTMkQodF8iiGIxaxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707523284; c=relaxed/simple;
	bh=rCfJsAKeXXcZCAjkOXWwNzPHH0iNeMtutMIl0Ma/wGc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L1R3jpmd9z26hfKjxzmWRVfN5+CnUdgDRLWd+T4jZmFSZFfabLDnnOWFwZBSiAoxHLGVmCiOx3BrD+ZWlVWxLWQJsLgqkU2L9+2KTr7NT7jGqLZutv8gPxw2Xy5+titDoCXoLKte1+Aizc8ODQj2WLWobBvtKPrCwgIt/XtwCQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nC/5y7nX; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-290e7a0a585so1476401a91.3
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 16:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707523283; x=1708128083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6ofdqHOHjOqeu37knmsIEqYVGa2yCjdBWHlcP9NF/Q=;
        b=nC/5y7nX6754PKWviq40EEoJ8KQ3RAp6ciXnVF5LUbmsfBfjYlGeNTlV+Fl2VElfiz
         TSTXtT7to/x8w3LyvSpI6IrPv3zJDpFJHbDs1gaqVQe9Oe8QGYPAJLQcM9TEu70NB0D3
         SBErKEyVMpGk+MtiP22z9PpvxZKTD3JzjblflOxY4eiaM6JN8mqh0zZORx9LrKmvXKW9
         xWMA9G4x+/bESdmjlUzo5q+a4+UBfgOvOn1LtnWSkKEqiWeqP0YMOhrEjjSQw8NimIZG
         hgrsZdSPbzgCcFhdpEpQ/okg614Yk3971CcpsXDW8rzA4ktLaKVjYYPdXS9No14I3KrH
         ciNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707523283; x=1708128083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6ofdqHOHjOqeu37knmsIEqYVGa2yCjdBWHlcP9NF/Q=;
        b=EsYHEqx/FITNWYQcfvF84NUj6DUzSRfPg4yyQVsvc3e+iv9L/kSndjAkl1tzv4LQjM
         CblshtCCFWmELjh3RbGUSP8IjoEdq3TaOwUUHLHv3wKvlNPRec8baQP7uXWb/rLdCdRN
         Dihhtew9CVYgULAyujEhDNNnA66WT4Pklw6vFLlRforPWTx5+5QckgoGPZN+YrQzSkcz
         wI1/l5RdLlOr1av4f62pJHbIw3mVmgv/R6kDQw/DYwEQEkQSKgVVRTLagQ3XWQf2vgPv
         PNy7xs3Rqvr1iHuUkFNKWMmVv56mg9oPoC1i1tORBnomYhQIQ5jk5G4RFjPVO/7SJli4
         F30A==
X-Gm-Message-State: AOJu0YzcbQ6KIChRVHMq5tGA583S25l9GsurCWdW/a8Ik0rV6WATcRxB
	lI6SNhR8w7b+JW/fkLgD2zkAJg6aSCzrujuFTrUSU/8zcASnSekoe462PKsqOPP/eg==
X-Google-Smtp-Source: AGHT+IF9QXd1fY5X9EOvsnSL9kEOtXqg/M1FMsRHU6x6+GdLrUXw3lbf88I0IE+ePtSMWI89x2Qr0BY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:fc4b:b0:296:c9f1:a67e with SMTP id
 ee11-20020a17090afc4b00b00296c9f1a67emr10371pjb.6.1707523282741; Fri, 09 Feb
 2024 16:01:22 -0800 (PST)
Date: Fri, 9 Feb 2024 16:01:21 -0800
In-Reply-To: <5ac3e6uwvhdujq6tywb6b5bh5flqln6d7kedmcbvhyp55jp4yo@65pnej6e2ub6>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <5ac3e6uwvhdujq6tywb6b5bh5flqln6d7kedmcbvhyp55jp4yo@65pnej6e2ub6>
Message-ID: <Zca80Uetl26BsICU@google.com>
Subject: Re: [PATCH v3 bpf-next] net: remove check in __cgroup_bpf_run_filter_skb
From: Stanislav Fomichev <sdf@google.com>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 02/09, Oliver Crumrine wrote:
> Originally, this patch removed a redundant check in
> BPF_CGROUP_RUN_PROG_INET_EGRESS, as the check was already being done in
> the function it called, __cgroup_bpf_run_filter_skb. For v2, it was
> reccomended that I remove the check from __cgroup_bpf_run_filter_skb,
> and add the checks to the other macro that calls that function,
> BPF_CGROUP_RUN_PROG_INET_INGRESS.
> 
> To sum it up, checking that the socket exists and that it is a full
> socket is now part of both macros BPF_CGROUP_RUN_PROG_INET_EGRESS and
> BPF_CGROUP_RUN_PROG_INET_INGRESS, and it is no longer part of the
> function they call, __cgroup_bpf_run_filter_skb.
> 
> Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
> 
> v2->v3: Sent to bpf-next instead of generic patch
> v1->v2: Addressed feedback about where check should be removed.
> ---
>  include/linux/bpf-cgroup.h | 7 ++++---
>  kernel/bpf/cgroup.c        | 3 ---
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index a789266feac3..b28dc0ff4218 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -195,10 +195,11 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>  #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
>  ({									      \
>  	int __ret = 0;							      \
> -	if (cgroup_bpf_enabled(CGROUP_INET_INGRESS) &&			      \
> -	    cgroup_bpf_sock_enabled(sk, CGROUP_INET_INGRESS))		      \
> +	if (cgroup_bpf_enabled(CGROUP_INET_INGRESS) &&			      \
> +	    cgroup_bpf_sock_enabled(sk, CGROUP_INET_INGRESS) && sk &&	      \
> +	    sk_fullsock(sk))						      \
>  		__ret = __cgroup_bpf_run_filter_skb(sk, skb,		      \

[..]

> -						    CGROUP_INET_INGRESS);     \
> +						    CGROUP_INET_INGRESS);     \

The bot still can't git-am it. And I can't either. Did you somehow
manually mangle that part above? The original line has less trailing spaces
than what your diff source has, look at:

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/include/linux/bpf-cgroup.h#n201

Can you drop this part? Let the idents stay broken :-)

