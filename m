Return-Path: <bpf+bounces-60830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D29ADD9FE
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 19:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593364A37C5
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 17:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607AB2FA651;
	Tue, 17 Jun 2025 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rQRFwyrQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55332FA647
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179611; cv=none; b=OnyASV8J3NKGhBw/fm5ljfg9YKPTiCJ50pja7cdaTM02CCOFuUISU77bGYlaH9SbOAkt99kTcyLyeddeLS9N3akJ53ZGL5ernDajtlD44rggJHdYVqcZzieLW8EOp8YOD/Um1fBOXkc8o+g/vH9KM6frXX6vfmEtGTCyU3TQbMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179611; c=relaxed/simple;
	bh=/BB9ETuzbSVVgLx10Jveyq9gkuwk2i+fF/bnsIWuyoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=muhUx3GG4VrxaHX2z1IVYUmo3dy7iRf81u9FECLQH7LL+DQwuEXSWAc2YiBRbaHorw96Bv5HyAvc00eiwWhHcU1LLNjAQTeHK5QRAgLSiTe1K4mXjlIJFaxTKXUMdAxtbTxup7Mp4uMLM0ne8qgGKwVKc4sLtSiFnxzkvB7s6Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rQRFwyrQ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <553696f2-e97c-4e80-b3b5-efaeff878462@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750179605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/BB9ETuzbSVVgLx10Jveyq9gkuwk2i+fF/bnsIWuyoc=;
	b=rQRFwyrQoUAKbFHo7r1ta2GXGriq+zLgrAnDdr5DGhqIFrQ2cUeheqU+Mzq7NlGfZLpLCS
	ZJxRM0OuUL6g6nVPviaq68zfHTlsiv3Dms4J63v5GGYfa/cc+Z1P3qb/jg3/Y5Xjdb6jb1
	7glcMUu0VA+/ke5v/cwUEn2ERLkUI9E=
Date: Tue, 17 Jun 2025 09:59:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: fix unintentional switch case
 fall through
Content-Language: en-GB
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250617121536.1320074-1-mykyta.yatsenko5@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250617121536.1320074-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/17/25 5:15 AM, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Break from switch expression after parsing -n CLI argument in veristat,
> instead of falling through and enabling comparison mode.
> Fixes: a5c57f81eb2b ("veristat: add ability to set BPF_F_TEST_SANITY_STRICT flag with -r flag")
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


