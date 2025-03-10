Return-Path: <bpf+bounces-53708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5E5A58A84
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 03:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FBCA188D7EA
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 02:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED7C19DF8D;
	Mon, 10 Mar 2025 02:41:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE95D477
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 02:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741574480; cv=none; b=GHmPJB1rRgIaOn3158SO80CQ6j9C9WbN2hr1wqVxZAQ7bmza+zBf3ckfY6oljnFh7DD1WVthJyl37oLyGKOYJI4nQoY2dmBJ6wtiZ3h/18Czq00k8jZZC5anhAV5ykmqOVzRClx3qtb9cl8/qLFNiOxEMNayILn+HG5RvoHbnBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741574480; c=relaxed/simple;
	bh=7m+7J6otzoGqCNv1ZTerbcjO9kVUM4h4S0pvliuVHjk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ew02enYedw45B0iRSVxpaQ5E1+y+I7297Yo0YROqibJEKj58qlRtgMRIvW1usUFF3k1A9RM66JAVJpAt/7qiC5E4hcbWuE4DfznplaMF/qBv4qFaKsd9CpdwYnyh/8L37ZDi2BEkr73AAuFwufbSLRH24tZDLe5IVL/Qip99jLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZB1NN65vdz4f3jJG
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 10:40:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 291EF1A07BB
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 10:41:15 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgCH6FxIUc5nT3kzGA--.52729S2;
	Mon, 10 Mar 2025 10:41:15 +0800 (CST)
Subject: Re: [PATCH v7 3/4] bpf: fix missing kdoc string fields in cpumask.c
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, yonghong.song@linux.dev, tj@kernel.org, memxor@gmail.com,
 Alexei Starovoitov <ast@kernel.org>
References: <20250309230427.26603-1-emil@etsalapatis.com>
 <20250309230427.26603-4-emil@etsalapatis.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <55361457-dcd4-0a76-53a3-23d87aecf51e@huaweicloud.com>
Date: Mon, 10 Mar 2025 10:41:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250309230427.26603-4-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgCH6FxIUc5nT3kzGA--.52729S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYH7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4
	kS14v26r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU189N3UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 3/10/2025 7:04 AM, Emil Tsalapatis wrote:
> Some bpf_cpumask-related kfuncs have kdoc strings that are missing
> return values. Add a the missing descriptions for the return values.
>
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>

Acked-by: Hou Tao <houtao1@huawei.com>

Simply test it by running ./scripts/kernel-doc -Wreturn -Wreturn -rst
kernel/bpf/cpumask.c > /dev/null


