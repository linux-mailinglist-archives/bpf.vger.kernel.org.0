Return-Path: <bpf+bounces-19621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A7282F483
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 19:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C043A1C239E8
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 18:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C483F1CF87;
	Tue, 16 Jan 2024 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lzFZ0S0f"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F11CD33
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 18:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430676; cv=none; b=VCylneWGmO8xaRl13zcZcC2to5V5jCrsl6xUsdwb5qmtkwdXcUg3cdVfMnPl4FGa+AsthOmwn8wtorvVKQ2pHMhemlvYuXY/g7viV1Uw4mrcerrpTj1vn2PK0rq1uHGe3c1sdTQBhZJkQj8INEGPi8Wvbm10asYm3VLpusRT6HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430676; c=relaxed/simple;
	bh=IeGi5eTLKmkhLFtKQxtNq6MFHvBLUzhJyDPRfBqAEiI=;
	h=Message-ID:DKIM-Signature:Date:MIME-Version:Subject:
	 Content-Language:To:Cc:References:X-Report-Abuse:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Migadu-Flow; b=WlwhcLAWx676KAP3gs5W9UhiQjBD1K3f/6OnltsG/3fmBl7dVg4dZ3r6ozUQffubLNq9+FdGSJQ70A4ZkleClTvvEHyEqVklqlGjVAbXOUClQplEqZxZU4evC/Ybob5s4Stg5mVKUV2IcXz0jYmewZQV9dp3DsWA3D7/NmJB4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lzFZ0S0f; arc=none smtp.client-ip=95.215.58.187
Message-ID: <98222fd4-394a-43e3-bf03-3fe8d660f2c3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705430672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IeGi5eTLKmkhLFtKQxtNq6MFHvBLUzhJyDPRfBqAEiI=;
	b=lzFZ0S0fpgFD1cTUS39UeDFjtbYFWolfUIHYdtyLYi6CfySV5gxPz+TBUljIhT4JJBf4FV
	NNTi6QZAi17N1t3XS7vu5+0IB4DJDx7Q5PVEJgfmFn90V5gPmx/4aLN63lgWDEEObV2c4p
	O8UAqGfmoWRdgjgWc6U2c+3+EIbbQTo=
Date: Tue, 16 Jan 2024 10:44:26 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4 1/2] libbpf: Apply map_set_def_max_entries() for
 inner_maps on creation
Content-Language: en-GB
To: Andrey Grafin <conquistador@yandex-team.ru>, bpf@vger.kernel.org
Cc: andrii@kernel.org
References: <20240116140131.24427-1-conquistador@yandex-team.ru>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240116140131.24427-1-conquistador@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/16/24 6:01 AM, Andrey Grafin wrote:
> This patch allows to auto create BPF_MAP_TYPE_ARRAY_OF_MAPS and
> BPF_MAP_TYPE_HASH_OF_MAPS with values of BPF_MAP_TYPE_PERF_EVENT_ARRAY
> by bpf_object__load().
>
> Previous behaviour created a zero filled btf_map_def for inner maps and
> tried to use it for a map creation but the linux kernel forbids to create
> a BPF_MAP_TYPE_PERF_EVENT_ARRAY map with max_entries=0.
>
> Signed-off-by: Andrey Grafin <conquistador@yandex-team.ru>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


