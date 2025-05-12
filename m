Return-Path: <bpf+bounces-58033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0771AAB3EFA
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 19:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680A63A58F5
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 17:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F8A296D1E;
	Mon, 12 May 2025 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIFnXSmD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2267C29345A
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070792; cv=none; b=f0q6BhaAXs+0c/HJwp6FZSQY+j9t8K0tzHEgw7siP5d/rsSIujJ2BzxpAJlZKwonM84Z8BEo+RcXVLZ1iGS/EENbyTi9czbkZg+mjje9PeiqzGMjejfFH5rY9VTvOKB65lsGwM/CCp7raIY8Hoc6Z1Pfzm5+i7N1vlKbxPNJPcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070792; c=relaxed/simple;
	bh=uIRdwvJBQ3GnQoXZ+V9Vd8dZ+ZHOECcYzavz9pq/b9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B2mvCfUOTDJzEONoI3v4FDqxbyXQ4P6JbZ//Iorn+k63hsFnSvpAzDqiXwUTWQM9+Bmh/foun0KBjCxOXp+vBzIVzY3ljPxrlGNBPqGbBDH0LCl2J2AhYcuKAL1floF+hI3+6hkffuj6cI/UObIDavnZcpFbHtb9vidk4/vmr+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIFnXSmD; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74019695377so3503659b3a.3
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 10:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747070790; x=1747675590; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uIRdwvJBQ3GnQoXZ+V9Vd8dZ+ZHOECcYzavz9pq/b9Q=;
        b=bIFnXSmDGpz7+Grfey5L+HCrGijBH5IMmD19QfaJAFb/jMzY0UJOMF4n0g2kJfsWB+
         1dVAPlqt1FwWVFhjH3Msw8V/WMxWTFi2IzgfvLP0jER/Jvh2OXxEd/nrphwfqV1SXkTS
         0UvVqx2f+5DC375hm2NhWCZpHMdcAN7VKlz+6l8yeTCF8jgiERkvLrsd7tenslGmkLLl
         gMmjh+LqEr/smliB0AfZN3O6TNf9IvQBEuG1UG7c0dIiWSTUXE73wGq17KC847kqB13t
         F9UBQVIO2DegcUsbUjDVg6clkLuBoxVGylgF8pXTpyCjuA5UwEy1BqYxevcaH3zZWxgn
         MShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747070790; x=1747675590;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIRdwvJBQ3GnQoXZ+V9Vd8dZ+ZHOECcYzavz9pq/b9Q=;
        b=wRIcxdPNEeAEFmhlNJaAcgA8CsopbLTh+IPwf5CERBhrXMu4uxVeijs2OYj6p4t+Xg
         mdApbKjkrn48e4JIdR5kTAIVyumCNUap5g9CP2fCgiLLlDih//YlzPzAwL9eDRHdpwgT
         6o/fSvEWebsek9flpwOxYS9Si5gyetrI54hksCi/olzyOklY80Fzsh4Y8NiIwapQ9LSs
         zBxLTPbkxkCqfN7SbOrk1FGvyi0sQBUUUEIiBhHb96ukJlTLPVixKp2/5TbMpAn3icFU
         usBlUPrfOWtZ6ZhrZrrwrmiKrPK4SD9qHtV+tPcAU6RnSWmaAwUE55t+dmutzg1TnQ/Z
         Y4IQ==
X-Gm-Message-State: AOJu0Ywa0r86N5ZXkLmUcMebrXoABEc0xhY1WktGNJiAUDoGk8qTwqwz
	WvcSAEVg9kDd+CxX2kN0EC7kO+F3iY4djYktkVU5z6/FFDkd5WlM
X-Gm-Gg: ASbGncssCTEN3dAvd4Na2JOc9pOALoHQ/gzRSqpSQi6dj4gOhKLDUhCRXe/jzijexFq
	V9BWf5H1tFQ9o4ZS+7IsTEviA/U061rQqn+3nL4GxmBrfdmuBEnYX3JvtCv8GRUVh+PRJAMhr7g
	JmIPH3gAbC4MdPej/P/sY4YrBz01OPVjNYjbTDy/HA6vpNdwWLVYrwUn+c5eD7ey3UASiQzOKxW
	9EkdvP0Zp1koQhRjkpMMcMuajPFYz2DRGo+2rupGR1j3cYxrr0BdBQ80Q4lXA7KFlczGUQG1/oP
	WfH33dew/xoQZPXXs+He7VnnPvEzapRyBWU62Algxryjd1dIY1e1wdZG+70=
X-Google-Smtp-Source: AGHT+IF8MsxBK9t4gPeDJTqMFE+spLpcPl7ByNsysCph0fCeARn+x6yIxSvT3qLUppDqUg9/Njerkw==
X-Received: by 2002:a05:6a00:14ce:b0:73f:ebb:6cb2 with SMTP id d2e1a72fcca58-7423bc0333dmr22640234b3a.3.1747070790214;
        Mon, 12 May 2025 10:26:30 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::6:10d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7423770447asm6250573b3a.32.2025.05.12.10.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 10:26:29 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Gregory Bell <grbell@redhat.com>
Cc: bpf@vger.kernel.org,  andrii@kernel.org,  mykolal@fb.com,
  ast@kernel.org,  daniel@iogearbox.net,  martin.lau@linux.dev,
  song@kernel.org,  yonghong.song@linux.dev,  john.fastabend@gmail.com,
  kpsingh@kernel.org,  sdf@fomichev.me,  haoluo@google.com,
  jolsa@kernel.org,  shuah@kernel.org
Subject: Re: [PATCH bpf-next 0/2] Fix verifier test failures in verbose mode
In-Reply-To: <cover.1747058195.git.grbell@redhat.com> (Gregory Bell's message
	of "Mon, 12 May 2025 10:04:11 -0400")
References: <cover.1747058195.git.grbell@redhat.com>
Date: Mon, 12 May 2025 10:26:26 -0700
Message-ID: <m234d97nb1.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gregory Bell <grbell@redhat.com> writes:

> This patch series fixes two issues that cause false failures in the
> BPF verifier test suite when run with verbose output (`-v`).
>
> The following tests fail only when running the test_verifier in
> verbose.
>
> #458/p ld_dw: xor semi-random 64 bit imms, test 5 FAIL
> #494/p precise: test 1 FAIL
> #495/p precise: test 2 FAIL
> #497/p precise: ST zero to stack insn is supported FAIL
> #498/p precise: STX insn causing spi > allocated_stack FAIL
> #501/p scale: scale test 1 FAIL
> #502/p scale: scale test 2 FAIL
>
> This leads to inconsistent results across verbose and
> non-verbose runs.
>
> Patch 1 addresses an issue where the verbose flag (`-v`) unintentionally
> overrides the `opts.log_level`, leading to incorrect contents when checking
> bpf_vlog in tests with `expected_ret == VERBOSE_ACCEPT`. This occurs when
> running verbose with `-v` but not `-vv`
>
> Patch 2 increases the size of the `bpf_vlog[]` buffer to prevent truncation
> of large verifier logs, which was causing failures in several scale and
> 64-bit immediate tests.
>
>
> Before patches:
> ./test_verifier | grep FAIL
> Summary: 790 PASSED, 0 SKIPPED, 0 FAILED

Can reproduce the issue with -v option, the series fixes failures I see.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

