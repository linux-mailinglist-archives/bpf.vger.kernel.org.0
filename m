Return-Path: <bpf+bounces-53639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CA0A5786D
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 06:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3976B18998AF
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 05:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582BE17A31F;
	Sat,  8 Mar 2025 05:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BheBh2FP"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759361779B8
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 05:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741410755; cv=none; b=BSds75002yK21sB+pZI4vMKIW/oYcVZLwjO3zk6chjnbQDvgG0bqkLrhNREk/bCEEzto1MGbyzk56SEqvR4E64paeTaTu/MR7idZQAtLonDpmsICzm3pmp2JMuWt8xHuTm0zX/aQ1Qf2QLXOVV0O01j2MtfBS+V9tRLqlVa1V6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741410755; c=relaxed/simple;
	bh=mG9SW1vtcyMP5LKs9r4miZuKx5r240f/WsYEtpeRdlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXAg7JWm+yFZZniKqyIwC1r4H/NgMTZcleqp32+N4FOC9xBqLCFKEYcTj1B6bURA/loBQYREYoqvOXJ88IgPh7mYx2PRQbB3T3cliBxIfS7+sRsyXEKBPuqcKsRKN47yT6wzj4GJbH224ArpTziGkjdc3+YmWhc6oNK2Adae57Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BheBh2FP; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <02caed19-ae4a-4c7e-bad6-449b4f157322@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741410751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mG9SW1vtcyMP5LKs9r4miZuKx5r240f/WsYEtpeRdlE=;
	b=BheBh2FPHT/nNmIH9KUEed8uv/f2eTJ7e9iTGtVRhN1NSCz+hfb/j/OVUVgH0sEF0wp6RP
	3YszGagy46NL7jdPFT0gosKz6NLGO2oTBGOvY11/CqmfvBfBBSV3BP2G3cxsBsaaB+kfNs
	eS/wENt60xgfcE3IUuiiaoBanZfE/JI=
Date: Fri, 7 Mar 2025 21:12:26 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: test freplace from user
 namespace
Content-Language: en-GB
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250307212934.181996-1-mykyta.yatsenko5@gmail.com>
 <20250307212934.181996-5-mykyta.yatsenko5@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250307212934.181996-5-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/7/25 1:29 PM, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add selftests to verify that it is possible to load freplace program
> from user namespace if BPF token is initialized by bpf_object__prepare
> before calling bpf_program__set_attach_target.
> Negative test is added as well.
>
> Modified type of the priv_prog to xdp, as kprobe did not work on aarch64
> and s390x.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


