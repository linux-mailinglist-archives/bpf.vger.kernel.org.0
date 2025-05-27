Return-Path: <bpf+bounces-59025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6592AC5C50
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 23:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B081BA622F
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 21:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AD52147ED;
	Tue, 27 May 2025 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToJV+9LD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906AE20551C;
	Tue, 27 May 2025 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748381993; cv=none; b=eLBRei0eOCBj9JCN9UeNfXHAMkkTyZRZNKsEraFwLAomvLaMrhC4LtpvvowpaN4IX5Rkv6NLVTrMtTob5kMstralwtJ5yrQrecli9+gRLnMuvKeOCd8+0bGWqzRtJjgq/DvowgKwh5PHvGNq3CqSSJ8BdWtg2Z6lfxqOgH0Ubo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748381993; c=relaxed/simple;
	bh=6YNyQSi+NXWsf2Hu9EJhYHMmDJXMHB9t+ICW3ATuink=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iJb1Llq+SeHHm80KgGtE5h5Rwo76qk1nT8eoKjBLQBlO1wxOdPFehEqnXfsXMcVhtmXia8+6CsEi54Lh6QaT9XMZZQ9jZiZSou/plx/GTgYQAVBYIDak8KhGbiOla5MOUtl1UjWE8dBEC7oXaCkjwSgogrV3E4+owbuY/nAerZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToJV+9LD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2347b7d6aeeso23279885ad.2;
        Tue, 27 May 2025 14:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748381991; x=1748986791; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6YNyQSi+NXWsf2Hu9EJhYHMmDJXMHB9t+ICW3ATuink=;
        b=ToJV+9LDOSkJja7mC50J7sAc3VZQaP8MWgB1T3g5xT+dU6HLM9ojC6OJf80eQI9Nd6
         eXgzGn9WvhZQElxZWy/nY2E1LcZ4gTHd+HuJlGtfF80VU9hXcvCKBsooUblReLXAJ5Dx
         NsjBLim/6IZh275TtfrsTqLUTTuzVxp81G/T69a4mIeoBGwjBybG1ACiumRBbz9NrX5K
         dVSRtYlH5OZzTAVxNc/BoPm9SKXksneDcpw7QNJMi9yFa38rJ/A6P8QlOFxUThz6dcCq
         sQ7kBk2k+jGXzp8P7WTjslM21G54ehc1vd6BuMPd6BhWG01VPwk8WBxPiQhZYiL8LzwY
         Ca8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748381991; x=1748986791;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YNyQSi+NXWsf2Hu9EJhYHMmDJXMHB9t+ICW3ATuink=;
        b=lP50EYLlv2ZT6rzTP4TmtolYuRJXnM15AGC2FA6Nnuaw4pk4VWD0nd7OaXo9LdbRvx
         I/b0Hnqi0pyAI7G6icxLDTkaI5S3t9MQBjVR5oJfH8SuDrPKOtsHdpKpuBZYypD37OWj
         Z/oep9Vz4J/k921Ck8uuyufZd39OVZ7l8S3FZg+9VHueVCfTZugBACPC4wZKzHfpXiNQ
         qlWGDrEEGwkNpLj1oFvv4RWvxhyDNWafWZyeT1hdLOHIc2Ft/7iEq1PcDZSL9BPtTrg0
         pR1dRsLS/KdaIldCMxJBPviEo1RuvweTkWsgFlZuWl8+F1GCGy625/gDz8gCp/QXNfhN
         Q7GA==
X-Forwarded-Encrypted: i=1; AJvYcCUXpXKLzYM9p7wILDMWI0QjsDeMhB+48i3yaz5SZzV5HABqnmGazQbV0GW5Vx6vr/DNCIY9xQZRVkAVbDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5a9nOy8zs+9a+DTbZ1EdNwzfByMIfsDky12CkO6R4VjTEtIBg
	anOdkDWW2qx12rE6cCPinnnrq+7zTwNAi1iG4aN8wOqKJr96jaVveLiqph2P9uJ9
X-Gm-Gg: ASbGncuhbQYSi2sikO4rF8kQlOjuy2awsfAMkCPsi6gPZZPedgJ+MB6b1vZcWtUzcJv
	NR+w2kCQ2KK9RWp8Qu94xfZlTjoFonhBDqn7HOl49XtKiG8Vvc80DhMnDoWdvCuePA5u21Vp3wI
	PRR5j0+zu3meKrE8PLF9bhe6snOzbtw1I//37o4Bqmh5JbossywcfiafBUWv3ON3QFcQzSM5ie0
	2a/wU1P7i5zSkMmEUJ4003gQL6xdS5tK1nJeCnobFOo43jDiXzExbyb0myxzaWbFBNPzLud7pw/
	5rU2vcG87yRWQWvWXVSar+dkUQUlJ5XzaCBwTgVGMPm0KweWgfJJ5bw=
X-Google-Smtp-Source: AGHT+IHOQWWz8DzoaRoO30K2AVMpD9QlFR8QA0NDb1ZoC9oic7Dyris3dV5vSUzlZU2Kx/NlYEbz+Q==
X-Received: by 2002:a17:902:e5cb:b0:234:c549:da10 with SMTP id d9443c01a7336-234c549dbedmr12734285ad.47.1748381990628;
        Tue, 27 May 2025 14:39:50 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::7:461c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234cc24e8bfsm447345ad.221.2025.05.27.14.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 14:39:50 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Jerome Marchand" <jmarchan@redhat.com>
Cc: bpf@vger.kernel.org,  Martin KaFai Lau <martin.lau@linux.dev>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Andrii Nakryiko <andrii@kernel.org>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Specify access type of bpf_sysctl_get_name args
In-Reply-To: <20250527165412.533335-1-jmarchan@redhat.com> (Jerome Marchand's
	message of "Tue, 27 May 2025 18:54:12 +0200")
References: <20250527165412.533335-1-jmarchan@redhat.com>
Date: Tue, 27 May 2025 14:39:48 -0700
Message-ID: <m2ecw97mxn.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jerome Marchand" <jmarchan@redhat.com> writes:

> The second argument of bpf_sysctl_get_name() helper is a pointer to a
> buffer that is being written to. However that isn't specify in the
> prototype.
>
> Until commit 37cce22dbd51a ("bpf: verifier: Refactor helper access
> type tracking"), all helper accesses were considered as a possible
> write access by the verifier, so no big harm was done. However, since
> then, the verifier might make wrong asssumption about the content of
> that address which might lead it to make faulty optimizations (such as
> removing code that was wrongly labeled dead). This is what happens in
> test_sysctl selftest to the tests related to sysctl_get_name.
>
> Correctly mark the second argument of bpf_sysctl_get_name() as
> ARG_PTR_TO_UNINIT_MEM.
>
> Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
> ---

Looks like we don't run bpf_sysctl_get_name tests on the CI.
CI executes the following binaries:
- test_progs{,-no_alu32,-cpuv4}
- test_verifier
- test_maps
test_progs is what is actively developed.

I agree with the reasoning behind this patch, however, could you please
add a selftest demonstrating unsafe behaviour?
You can use tools/testing/selftests/bpf/progs/verifier_and.c as an
example of verifier test checking for specific log message.
(framework also supports execution if __retval is specified,
 tests can be written in plain C as well, e.g. as in .../iters.c).

