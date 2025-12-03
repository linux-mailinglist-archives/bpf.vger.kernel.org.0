Return-Path: <bpf+bounces-75963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEE7C9EC02
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 11:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D0AA34A273
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 10:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101902EFD80;
	Wed,  3 Dec 2025 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="WnmC0VPe"
X-Original-To: bpf@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E95A2ED860;
	Wed,  3 Dec 2025 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758454; cv=none; b=kkvKFpuT5jG5rjbRUhkohb/H37TkuWdoQ17kjzDncjuHC59JHr+luSdwBYjORpCRaa1SMLkeRvsJpFsjuLbrEXy+4aRtmPsb7ZZUwzbngPHM/UcGWa8Qj8eSGqh6z4GLNL9x8fUiF1BVrkaKIGRV4xPWbNY32jBY4YyozHuej7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758454; c=relaxed/simple;
	bh=6teEcSTtrJgnszeTAzsbDyQDdZwMlpmbiBo5m8ykxrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTto22kKdhu0BSG4dd26U2zZ6NP3RgzataqMfjSoPu7t8G3FIafrcAwPOIBDNofNiajTT/z37cLfJ+eC9l3Am87Mm1CTLI860LgEqFBNS6JmaPLM57a4rEiUv216l+WlfjhCrVINqA5QKNnBwIk+sElTOSPIvMuTTK6iXSoQyDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=WnmC0VPe; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764758453; x=1796294453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jXsVFWbj35rMKMy+vwDkpwi9rIVDzao0SnxFiNJEYic=;
  b=WnmC0VPeXivWBHgx7glRQtTnB+LimAfJyGWmqWOylKWJvrMvIXSpEmxR
   qvmfs6pl1Hz5pC///vweGjX0vDd8DnSq/Z2gru5idlhxgD4FCCCR9ZPFJ
   VAbDFJ3N/Xy2Brb9OeZY5UbCNakPeG2Wd2wZxGT7Sby2HfZ7lje0QCcWP
   F9BZM3gh7eRfpgDTCJ13TvRQgsMKI53netcyWgPuF0kmWZjG0HOltmiMf
   7B4KAjm37094Rh+hUJbxaw6fa/ypki5Zu7YNAvJsyHvsIi9YzR23KDUwm
   Bue2RXMj2KD8Nn8gR/Qde25LJDzVDIgQTw4cprhzjs6ZqfnfqXaVTTL/E
   A==;
X-CSE-ConnectionGUID: N8Xm2/fSRySWr23rjtng3Q==
X-CSE-MsgGUID: KQwY1GezQp2wB8EYIe9gxA==
X-IronPort-AV: E=Sophos;i="6.20,245,1758585600"; 
   d="scan'208";a="8324630"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 10:40:50 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:24081]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.237:2525] with esmtp (Farcaster)
 id 07a0754c-ba91-4c24-8dc7-78f50d138f6e; Wed, 3 Dec 2025 10:40:50 +0000 (UTC)
X-Farcaster-Flow-ID: 07a0754c-ba91-4c24-8dc7-78f50d138f6e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 3 Dec 2025 10:40:50 +0000
Received: from b0be8375a521.amazon.com (10.37.245.10) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 3 Dec 2025 10:40:46 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <alexei.starovoitov@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <eddyz87@gmail.com>,
	<enjuk@amazon.com>, <haoluo@google.com>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <jolsa@kernel.org>, <kohei.enju@gmail.com>,
	<kpsingh@kernel.org>, <kuba@kernel.org>, <lorenzo@kernel.org>,
	<martin.lau@linux.dev>, <netdev@vger.kernel.org>, <sdf@fomichev.me>,
	<shuah@kernel.org>, <song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf v1 1/2] bpf: cpumap: propagate underlying error in cpu_map_update_elem()
Date: Wed, 3 Dec 2025 19:40:34 +0900
Message-ID: <20251203104037.40660-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CAADnVQLjw=iv3tDb8UadT_ahm_xuAFSQ6soG-W=eVPEjO_jGZw@mail.gmail.com>
References: <CAADnVQLjw=iv3tDb8UadT_ahm_xuAFSQ6soG-W=eVPEjO_jGZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Tue, 2 Dec 2025 17:08:32 -0800, Alexei Starovoitov wrote:

>On Fri, Nov 28, 2025 at 8:05 AM Kohei Enju <enjuk@amazon.com> wrote:
>>
>> After commit 9216477449f3 ("bpf: cpumap: Add the possibility to attach
>> an eBPF program to cpumap"), __cpu_map_entry_alloc() may fail with
>> errors other than -ENOMEM, such as -EBADF or -EINVAL.
>>
>> However, __cpu_map_entry_alloc() returns NULL on all failures, and
>> cpu_map_update_elem() unconditionally converts this NULL into -ENOMEM.
>> As a result, user space always receives -ENOMEM regardless of the actual
>> underlying error.
>>
>> Examples of unexpected behavior:
>>   - Nonexistent fd  : -ENOMEM (should be -EBADF)
>>   - Non-BPF fd      : -ENOMEM (should be -EINVAL)
>>   - Bad attach type : -ENOMEM (should be -EINVAL)
>>
>> Change __cpu_map_entry_alloc() to return ERR_PTR(err) instead of NULL
>> and have cpu_map_update_elem() propagate this error.
>>
>> Fixes: 9216477449f3 ("bpf: cpumap: Add the possibility to attach an eBPF program to cpumap")
>
>The current behavior is what it is. It's not a bug and
>this patch is not a fix. It's probably an ok improvement,
>but since it changes user visible behavior we have to be careful.

Oops, got it.
When I resend, I'll remove the tag and send to bpf-next, not to bpf.

Thank you for taking a look.

>
>I'd like Jesper and/or other cpumap experts to confirm that it's ok.
>

Sure, I'd like to wait for reactions from cpumap experts.

