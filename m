Return-Path: <bpf+bounces-19697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF51A82FE18
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 01:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7C01C243EE
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 00:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90246119;
	Wed, 17 Jan 2024 00:48:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E807E1FAF
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 00:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705452487; cv=none; b=sMEJ+H9MJ+VWN/BOLyRzATcyoaqGIzh8AycJb3FSdl8/VFXT/7fy8XnqshLDiNBpWFvqW8J8S2UROwgCJbkd/yEqS47U2nXEv84TGdcIc0u6//JKQIXGQoSghjHXoitNJTf5pTsy/7po9iwwTc4/Bk40HX2nPlukTNrf5y2cj8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705452487; c=relaxed/simple;
	bh=rD20a8HiJ3LhmDFhiRbv0Es36uLDhy5hcDCVDGuL+0U=;
	h=Received:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Content-Language:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo; b=HRP3U8nWejumthJRcaztcGFrJFHw7/BXEmpl8alAzKBS5fjhrlHA4LYEI0wTyeg100zSgi53ZlBljoV/B8xFcuILMIfSaNkrsLzpWC7nHI8AbQJFI5KebDnVb8GY19OgGoBVpUcCMPaCTT3RpztUKF6dOEiV/EKPWm8lwX3jd6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TF6fx1yBYz4f3lfq
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 08:47:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5F9A61A0CBA
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 08:47:59 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgBXeQy9I6dlyBdKBA--.52127S2;
	Wed, 17 Jan 2024 08:47:59 +0800 (CST)
Subject: Re: [PATCH bpf v4 1/2] libbpf: Apply map_set_def_max_entries() for
 inner_maps on creation
To: Andrey Grafin <conquistador@yandex-team.ru>, bpf@vger.kernel.org
Cc: andrii@kernel.org
References: <20240116140131.24427-1-conquistador@yandex-team.ru>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <2ef76aeb-544b-70ed-fd51-85a078dfcfd4@huaweicloud.com>
Date: Wed, 17 Jan 2024 08:47:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240116140131.24427-1-conquistador@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgBXeQy9I6dlyBdKBA--.52127S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5E7kC6x804xWl14x267AKxVWUJVW8JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
	8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 1/16/2024 10:01 PM, Andrey Grafin wrote:
> This patch allows to auto create BPF_MAP_TYPE_ARRAY_OF_MAPS and
> BPF_MAP_TYPE_HASH_OF_MAPS with values of BPF_MAP_TYPE_PERF_EVENT_ARRAY
> by bpf_object__load().
>
> Previous behaviour created a zero filled btf_map_def for inner maps and
> tried to use it for a map creation but the linux kernel forbids to create
> a BPF_MAP_TYPE_PERF_EVENT_ARRAY map with max_entries=0.
>
> Signed-off-by: Andrey Grafin <conquistador@yandex-team.ru>

Acked-by: Hou Tao <houtao1@huawei.com>


