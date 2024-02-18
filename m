Return-Path: <bpf+bounces-22225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47009859537
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 08:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A0128303D
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 07:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C3A1078D;
	Sun, 18 Feb 2024 07:13:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69E0FBE1
	for <bpf@vger.kernel.org>; Sun, 18 Feb 2024 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708240428; cv=none; b=iLxonbMzff8tmZqkQayo4O8Lin01lZnbOKX4l78OccjuRuEK30Hn0HTTMMIko1HxUEdgFGa7to+UHFm/Wwuj/F3XIEZhUkbg9zH1a5eunV9sxMwAxHDqw1yaRF5ueddZGwuoHIsbdfItBa5SCuTrp+Zc35/TSPJnMHJlxefPk8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708240428; c=relaxed/simple;
	bh=lewx5c7PMjBFLrzc1Q7KFELshQoWgeOHhMVwiFVBwnA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Umg1TODsMxON72X+NJotN87rni4zqoTgMupy/s+Sw+TRPdfIR6jTVbN77kSWIPu4OEFEo+htZon619JPuxdIaxnn+PTcAMu9KyHL6qyYuSLskYOe+hbJeAehoxsehGojCoShWX+becrdSo/s932/kuMd1yTCOKEziTy5ivE7zPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TcxjJ4RbBz4f3jqN
	for <bpf@vger.kernel.org>; Sun, 18 Feb 2024 15:13:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AF9C01A027B
	for <bpf@vger.kernel.org>; Sun, 18 Feb 2024 15:13:43 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgCH2mwnrtFlaqq8EQ--.7435S2;
	Sun, 18 Feb 2024 15:13:43 +0800 (CST)
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Test racing between
 bpf_timer_cancel_and_free and bpf_timer_cancel
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
References: <20240215211218.990808-1-martin.lau@linux.dev>
 <20240215211218.990808-2-martin.lau@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <a271b1b1-cf9b-e23e-0e86-9b6db0b793bd@huaweicloud.com>
Date: Sun, 18 Feb 2024 15:13:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240215211218.990808-2-martin.lau@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgCH2mwnrtFlaqq8EQ--.7435S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKw1UJFyxZFWkGF4xGryrXrb_yoW3CrX_ua
	y8WFW8tw13Jr9rGwnxCryavrsxKa47ZFyjgr1UGrnIy34avF4DXrsYkr1Sy348Zas3GF9r
	Ww15JayYvrnYqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 2/16/2024 5:12 AM, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> This selftest is based on a Alexei's test adopted from an internal
> user to troubleshoot another bug. During this exercise, a separate
> racing bug was discovered between bpf_timer_cancel_and_free
> and bpf_timer_cancel. The details can be found in the previous
> patch.
>
> This patch is to add a selftest that can trigger the bug.
> I can trigger the UAF everytime in my qemu setup with KASAN. The idea
> is to have multiple user space threads running in a tight loop to exercise
> both bpf_map_update_elem (which calls into bpf_timer_cancel_and_free)
> and bpf_timer_cancel.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

Acked-by: Hou Tao <houtao1@huawei.com>


