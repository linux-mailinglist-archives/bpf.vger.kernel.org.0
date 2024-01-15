Return-Path: <bpf+bounces-19550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3471B82DE82
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 18:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97818B20C6B
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 17:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B9918037;
	Mon, 15 Jan 2024 17:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tUmDgGzm"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B40E18622
	for <bpf@vger.kernel.org>; Mon, 15 Jan 2024 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e42d6c9a-a395-413e-883e-d3d4fe9dff24@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705340117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQI79ndvac8r83cGbUm9Bn03WVHSC8zj51WXgjbS4JY=;
	b=tUmDgGzmN7vkbfqH7jaRXqJ9z2/qO2R8bLaZNC75w85VK2WNu2fblNotDDsH7R3/7D2MV7
	STS9iYj9ZQG0bcT+GXqD1YirC5PPtqzvfOVmz4vdpLnq82dTG/m7dXZIsIMJIt7NdaEQEn
	wupYhFBZ/jWv1yGNT31B4F8LIs49ayc=
Date: Mon, 15 Jan 2024 09:35:11 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/2] selftests/bpf: Add test for alu on
 PTR_TO_FLOW_KEYS
Content-Language: en-GB
To: Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org
Cc: willemb@google.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, linux-kernel@vger.kernel.org
References: <20240115082028.9992-1-sunhao.th@gmail.com>
 <20240115082028.9992-2-sunhao.th@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240115082028.9992-2-sunhao.th@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/15/24 12:20 AM, Hao Sun wrote:
> Add a test case for PTR_TO_FLOW_KEYS alu. Testing if alu with
> variable offset on flow_keys is rejected.
>
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


