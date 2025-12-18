Return-Path: <bpf+bounces-76990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1673CCC09E
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 14:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 270A33021752
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 13:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F8A3358A8;
	Thu, 18 Dec 2025 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPsrpQUi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63176332EA1;
	Thu, 18 Dec 2025 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766064812; cv=none; b=Pa2nU0DGBohf0Kevn9rVGr0cZwG/ejPaxFwcpbHmwNknM6HZ5OD30sppPqacv2hlX8lnqIIHdhM81A+UZxFCMGB4vQlPta84KDRt831hlOm3nDFDEdqdIKKY/nShzBrVJ1O8XRr+bNNlRDlN7j8C6QPU7qW/YtwUFbAXNmr+jm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766064812; c=relaxed/simple;
	bh=xxQOTT4rkyKQeS6S9irizILXQeO2rmTPhDUE/DKvnsA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mIx/Ci34UV5vJK2riCgeg0EPSqJl9qSeTzkpxaCf5GVDNCwbiAfQACDdAeUNxPnSzmj/AR16LGUO+Brj+geyHrMvyZMCSOH9pflyL5Mb2Oa2nd6fuH+lq+NdDBqqTQcFHxj/vmtF3dYksqA6aN1r0KR8n8M79FiLJq471kWh608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPsrpQUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25BDC4CEFB;
	Thu, 18 Dec 2025 13:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766064812;
	bh=xxQOTT4rkyKQeS6S9irizILXQeO2rmTPhDUE/DKvnsA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=jPsrpQUiqROI6Ixxudf4jGcVzcdkCGI51q4qllDEt49W1pe5yYe9HoWvlToHV9/SY
	 fnaKYhkMls5txiTsVgsxMClb3LpFfHrmdlYbVvq1IR/31+Y5cekrJQv/ncB3Sjij+L
	 I/9TbSBZn7CUEPQFrrNSRwj6GEXrOWazonHMfu4LqCJH3fMrOSRXP7SHDPIoOWrMk9
	 QMjWdFqGViTV+W1+R6/Pypo3d/ex9bq75jOO7awMRzTukBTvkXUR8vmmkb59IuRF1E
	 re/AVXFE78mocutR1asyayCo/iqgbvQ3VnQKK9SocazsK9bjOFbObxx3SoOnhH66Tw
	 biS6CzrsnDyEg==
Content-Type: multipart/mixed; boundary="===============0855099473684338405=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4ee5b08b6cebfc87b552a0fde1f09fd5a2c190813760aa7e68f1e6d060f15ccd@mail.kernel.org>
In-Reply-To: <20251218130629.365398-3-liujing40@xiaomi.com>
References: <20251218130629.365398-3-liujing40@xiaomi.com>
Subject: Re: [PATCH 2/2] bpf: Implement kretprobe fallback for kprobe multi link
From: bot+bpf-ci@kernel.org
To: liujing.root@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,mhiramat@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,liujing40@xiaomi.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 18 Dec 2025 13:33:31 +0000 (UTC)

--===============0855099473684338405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 1fd07c10378f..426a1c627508 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c

[ ... ]

> +int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> +{
> +	struct bpf_kprobe_multi_link *link = NULL;
> +	struct bpf_link_primer link_primer;
> +	struct bpf_kprobe *kprobes = NULL;
> +	u32 flags, cnt;
> +	u64 __user *ucookies;
> +	unsigned long __user *uaddrs;
> +	unsigned long __user *usyms;
> +	int err, i;

[ ... ]

> +	for (i = 0; i < cnt; i++) {
> +		unsigned long addr;
> +
> +		if (uaddrs) {
> +			if (__get_user(addr, uaddrs + i)) {
> +				err = -EFAULT;
> +				goto error;
> +			}
> +		} else {
> +			unsigned long __user usymbol;
> +			char buf[KSYM_NAME_LEN];
> +
> +			if (__get_user(usymbol, usyms + i)) {
> +				err = -EFAULT;
> +				goto error;
> +			}
> +			err = strncpy_from_user(buf, (const char __user *) usymbol, KSYM_NAME_LEN);
> +			if (err == KSYM_NAME_LEN)
> +				err = -E2BIG;
> +			if (err < 0)
> +				goto error;
> +
> +			addr = kallsyms_lookup_name(buf);
> +			if (!addr)
> +				goto error;

When kallsyms_lookup_name() returns 0 (symbol not found), is err being set
to an error code before jumping to the error label? It looks like err will
still hold the positive return value from strncpy_from_user() (the string
length), which would be returned to the caller as a success indication.

The error label at the end of the function does:

    error:
        kvfree(kprobes);
        kfree(link);
        return err;

This could cause the syscall to return a positive value to userspace instead
of an error, and also leak a prog reference since link_create() only calls
bpf_prog_put() when ret < 0.

> +		}
> +		if (prog->kprobe_override && !within_error_injection_list(addr)) {
> +			err = -EINVAL;
> +			goto error;
> +		}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20338242683

--===============0855099473684338405==--

