Return-Path: <bpf+bounces-56657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804B5A9BBEF
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 02:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DA527B2836
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 00:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68468C1F;
	Fri, 25 Apr 2025 00:50:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435A92914
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745542246; cv=none; b=kDTK4lXEWY244igIXMj3kji0gteT+GOHxsp4iPhn5td6j6tN0Ac3V9HQbPc5am7+Cds0Og+yT1tW0uWVHWjIubt6Fu1cT29I/dew65tKAWYp5MkJ0my6oAq7mpoXgsnQyQkrF/+W4geAfkVwXIKM0nfv69PjQmMs+8mO0IvpiAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745542246; c=relaxed/simple;
	bh=bakjHZfSpx1bZP0wLgaloQct0/iQxRto7nMJYgasWHo=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZyltV1MtxkWPSumVOqPRHaPO4rBxcoAu08jqOCwv0tU8PwxVM9+MnT0965An5MPrObipvHDzanoFZ3VYDanXwhUBMg2Og0x+JXQO8Jk9q1B6WJGCrbft+Z3qXSsmoFERtQ2FAouTiiwybF07PjuS5tcGtcA9ZrHxR7mjEoYzN5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZkDlP13fhz4f3jd3
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 08:50:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2D24D1A018D
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 08:50:33 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgAXIWRV3ApoOa+fKQ--.10727S2;
	Fri, 25 Apr 2025 08:50:33 +0800 (CST)
Subject: Re: [PATCH v3 bpf 0/2] bpf: Fix softlock condition in BPF hashmap
 interation
To: Brandon Kammerdiener <brandon.kammerdiener@intel.com>, bpf@vger.kernel.org
References: <20250424153246.141677-1-brandon.kammerdiener@intel.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <dbfd7b7c-4367-f0ee-c5f9-e488fc6a6f86@huaweicloud.com>
Date: Fri, 25 Apr 2025 08:50:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250424153246.141677-1-brandon.kammerdiener@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgAXIWRV3ApoOa+fKQ--.10727S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFWxZF1rKF1kArW7Jry7KFg_yoWfAwc_Wr
	WktF9Yyw42ka10kF4xJws3Ar4fGay0q348Gr1DXw4avw15Awn8ZFsakr95Xw4Ikay5tF98
	GFn7Ja42gw17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbz8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 4/24/2025 11:32 PM, Brandon Kammerdiener wrote:
> Hi,
>
> This patchset fixes an endless loop condition that can occur in
> bpf_for_each_hash_elem, causing the core to softlock. My understanding is
> that a combination of RCU list deletion and insertion introduces the new
> element after the iteration cursor and that there is a chance that an RCU
> reader may in fact use this new element in iteration. The patch uses a
> _safe variant of the macro which gets the next element to iterate before
> executing the loop body for the current element.
>
> I have also added a subtest in the for_each selftest that can trigger this
> condition without the fix.
>
> Changes since v2:
> - Renaming and additional checks in selftests/bpf/prog_tests/for_each.c
>
> Changes since v1:
> - Added missing Signed-off-by lines to both patches
>
> Thanks,
> Brandon Kammerdiener

Acked-by: Hou Tao <houtao1@huawei.com>


