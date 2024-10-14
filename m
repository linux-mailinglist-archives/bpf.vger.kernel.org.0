Return-Path: <bpf+bounces-41878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4E199D5FC
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 19:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C379B252C2
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 17:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1A61CACF2;
	Mon, 14 Oct 2024 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JHJRJg1T"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F8B1C7B6F
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728928570; cv=none; b=labEPToL/uefiUtBGyss0XtFOQjKpbcd8+WCWKF3R/EO3Ji8kh0ytjW10AKe6DBOISYCF4uLvfBsdNjy9YQ7MmMW5TFpBNIxuDlhai1UxY5w+xhMgLFbBLgb/wNYgQwen66vYwpydkwtdZJjE9qPuZJW/Fnod7tnmveYDm6dOYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728928570; c=relaxed/simple;
	bh=UHpoiUVUmZaMURyvWmy1HhKdDrr20pbdfMbWxnM2z3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5U4wfLfcno3Gw33x62SR54VB46ataKWsXBVIigMWsIW/OsC4LsTAMBAm+yuoWbwDyKAgWWc9hT3ZWA2G+68CHvT9IffSIxpn3fHHFJIQXdeGWiwMGfDzZ39wTRMxTeHlMsYjp/jMvIPndJoo/NVVs4KNgbheqUXYb3aj5lLx+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JHJRJg1T; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a0a22269-44d4-460d-870b-64913fef90ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728928566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHpoiUVUmZaMURyvWmy1HhKdDrr20pbdfMbWxnM2z3w=;
	b=JHJRJg1TxOq41FwcZ0Sk5qIecIYd8QfnR+ceJP43LQU6xLEXxr0LXG+EW/c1dcfMWCBPDQ
	c2hcM6hwFtynsohc9JOyDzkB4vdx5TNUcgWUb+3LZKSxdYlifLyH9zYcpvGXZ2hn3itYcA
	OktKWS2wcQHvjnr7CKrGOwe06d50aMg=
Date: Mon, 14 Oct 2024 10:55:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] selftests/bpf: Add test for sign extension in
 coerce_subreg_to_size_sx()
Content-Language: en-GB
To: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shung-Hsi Yu <shung-hsi.yu@suse.com>
References: <20241014121155.92887-1-dimitar.kanaliev@siteground.com>
 <20241014121155.92887-4-dimitar.kanaliev@siteground.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241014121155.92887-4-dimitar.kanaliev@siteground.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/14/24 5:11 AM, Dimitar Kanaliev wrote:
> Add a test for unsigned ranges after signed extension instruction. This
> case isn't currently covered by existing tests in verifier_movsx.c.
>
> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Signed-off-by: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


