Return-Path: <bpf+bounces-48037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C355A03461
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 02:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9A31625F2
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 01:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2E13D984;
	Tue,  7 Jan 2025 01:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hok3Wt0o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3950846BF
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 01:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736212354; cv=none; b=bUnkbsf8LbNPhrZhvV5K29AQr/UHhK18XxKz1xhmPXEOoyssKaKGW9PvCzzsyfr36IO2bAi51dBCHPSgi0bG4PHFgCzEouU6x8EUZFEbRkvShw6AU89XbUJnHT+u4hM6f1C0SsCq7T0nvxQJge52MvoQDLMU8Rt/Owe6fXC9AuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736212354; c=relaxed/simple;
	bh=sv1yfuyrJdCRnABNLuxIPheVp2m1xqPSqlLV9XIxNCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWSKnhQdjdDOvlJXXofD3uTR1UlPQrbxlefq2Bv6g3pEgxya1OT3tHIRpDhy/6vGaa9EhfWCdZu5f0pTnr8kS1QJykDfQNLvWSmuECNca23GKeYABiwt/SxkSWiwdiyDP+C3CWwFG4N4RoIRjIV44AffNrUFi06/6h9pPkb1D9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hok3Wt0o; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2163affd184so34535ad.1
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 17:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736212352; x=1736817152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sv1yfuyrJdCRnABNLuxIPheVp2m1xqPSqlLV9XIxNCg=;
        b=hok3Wt0oe4e2PhT48WR8A/LKjP/7EMSRjPqb59uYXyj9Oxl3BaMP6Yc53mHCTmU34z
         f0a4E6r2sSX6ylnmM0U9QX7pbWO2WwZrjKWzpUFKz8iC+8xBfxwUHONgrf5EdpqD6w/D
         rdVzTfGh0oVLRrD50CNdlUYOsH7VbyE54uTO0WcCN0hCvc1DPrHanV8BI4Q8DL81qLTA
         z9mcb8YlyPFYWIiJzUWzFbb5fADwSWPeGQdnOjaznF32pm0NN/ZJJ00cdKzgyorMHnjP
         UX5rzWe8T8CpB586Hngtlx5/HRgQDsvtgbFHKS3Dv//1cEFPWWqRnHm/202kYly25TEz
         /xPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736212352; x=1736817152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sv1yfuyrJdCRnABNLuxIPheVp2m1xqPSqlLV9XIxNCg=;
        b=h4lBi9lphIAzgn9hCQcGS6wQTonV5YPz/269BscBPFOmySst6g+A4KMNpSnubUAnUI
         U4Rwp0ApUJNNYkHh+zxnignofVjJG8M96XlCCkZ8Ib7wYK2BETBgmJL1vxFntUVsA2lU
         nXHScgNYBnU/vovlCdKecYAvBIZOwuQQuHFu8y7Zer4Jem8eQRQWF+LL3cSf6DUMQ/qz
         jufsAgif3lW7/oB7UexXlgQ35CxZV3KH392JQDhVr+4OgsDTNHz+K7VEuXhRn+FONAnL
         MtHf0OQwPxY2nE1IJr4Nr3hNGTB0nAhZtJjenzd7F0vY6GMMk3vq16nmImoGYTwXJGjH
         SGmQ==
X-Gm-Message-State: AOJu0Yy8q3LcDx8Qrfn8ekpsWXBQN27sQLhmnFigYyrbUDW0luxclPqa
	CwtQXjR+xFZZd4bqLdFdQj8FJM4c8lGa4zUMJFlIXPTniUnn4FNu6INk1JvrtQ==
X-Gm-Gg: ASbGncuaap0gYhKPjLLmQb/m1W193hIJYvXDDrm2EhviP88L6UB/a3O0dhQn9FBFNH2
	pSrT0G/7XeVPtCTsg8RA4/cgrMB6mdzB36s4OABOezrDy1yGOEQykPTzGScwQBx1ErKyp0BsaLR
	wp6Wa+Uh+//h+UckaR+hZg0YZPIIrLB9Pgs3oTLa+JPqeoAKSR3w0l3lw8jNECfScgHr3Y3HDoH
	YOR5DOhxrNGUcnskwrXlKyEo2C2XrnWhSG+SqD5P6AooDMNKSGSlYdd1047VkTHMjIXNp7yLgJm
	3CnCoHZoyfGvPTDTO6dV6Q==
X-Google-Smtp-Source: AGHT+IERvsxcOnNzAdKMMO/YoeIvWeftP6ZkJjHYrnkTx57V0z4f2BJ+wJN4Tc7uQvcbeDSezolR6A==
X-Received: by 2002:a17:903:2290:b0:216:607d:c867 with SMTP id d9443c01a7336-21a7bc2e161mr551265ad.29.1736212352358;
        Mon, 06 Jan 2025 17:12:32 -0800 (PST)
Received: from google.com (101.150.125.34.bc.googleusercontent.com. [34.125.150.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d4431sm299350965ad.147.2025.01.06.17.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 17:12:31 -0800 (PST)
Date: Tue, 7 Jan 2025 01:12:28 +0000
From: Peilin Ye <yepeilin@google.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	David Vernet <dvernet@meta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v1 4/4] selftests/bpf: Add selftests for
 load-acquire and store-release instructions
Message-ID: <Z3x_fDJ_Jhm98G1f@google.com>
References: <cover.1734742802.git.yepeilin@google.com>
 <114f23ac20d73eeb624a9677e39a87b766f4bcc2.1734742802.git.yepeilin@google.com>
 <eab308952286a2eee443fdd368fd05b6e6389df0.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eab308952286a2eee443fdd368fd05b6e6389df0.camel@gmail.com>

On Fri, Jan 03, 2025 at 05:11:11PM -0800, Eduard Zingerman wrote:
> test_verifier tests runner is currently in a maintenance mode,
> new tests should be added as parts of a test_progs runner.
> Please take a look at selftests/bpf/progs/verifier_ldsx.c,
> selftests/bpf/prog_tests/verifier.c and selftests/bpf/bpf_misc.h.

I see, thanks!

Peilin Ye


