Return-Path: <bpf+bounces-56568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECF6A99E5C
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 03:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73DCB462667
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 01:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0741C862C;
	Thu, 24 Apr 2025 01:38:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5621C8601
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 01:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745458717; cv=none; b=VALL540Aobsz+TyAzj+nM8zKvKb8e8+yE3G8TBiR1Q4c87B+7O449dgT1rBYTpeYWoXv1lBUFU3sr4b1NtDsXCCOEt7PUkbD/1W66zfzy60KBxGeydEtKlCbox/2FPWZzun5I0MXr0xNa3Rr8EgSnLepUlIDhIoKMapZZrrVAhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745458717; c=relaxed/simple;
	bh=L03Vilp1IVCl/atSX719+BBu45J7Q4HXxpFpS/EG9cQ=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=M8Qd2+fauMKbupAXCwykRBpIcPDbTOS0K6EqsM+Wchr817aT3OpH0BpuZ2d+PnWftzHBUEpzCNQUErrVM1UPNQIKI1KJ/e48KgO/dCZK75du4DYv4j9jBgLhSpA+6tITStnmlxOuqu1+3/musDlKz0G0r1wovcUCelpaWoAEY4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zjds703lhz4f3kvt
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 09:38:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 7EB131A1968
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 09:38:28 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgB3FsERlglopx3vKA--.49647S2;
	Thu, 24 Apr 2025 09:38:28 +0800 (CST)
Subject: Re: [PATCH v2 bpf 1/2] bpf: fix possible endless loop in BPF map
 iteration
To: Brandon Kammerdiener <brandon.kammerdiener@intel.com>, bpf@vger.kernel.org
References: <20250423171159.122478-1-brandon.kammerdiener@intel.com>
 <20250423171159.122478-2-brandon.kammerdiener@intel.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <b9fd67c0-a112-e348-417f-d1d8ed1d342f@huaweicloud.com>
Date: Thu, 24 Apr 2025 09:38:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250423171159.122478-2-brandon.kammerdiener@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgB3FsERlglopx3vKA--.49647S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFyrCrW3Cw45ZF18uF4rZrb_yoWfKrX_Gr
	Z7XFnrGrs8CanI9a1UKFWxWrWft34SgFy8Gw47ZrZFyr15Zan5X3WaqFZ8ZasFgr97Kr9x
	ZF93XFyqqr1rZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 4/24/2025 1:12 AM, Brandon Kammerdiener wrote:
> The _safe variant used here gets the next element before running the callback,
> avoiding the endless loop condition.
>
> Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>

Acked-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/hashtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 5a5adc66b8e2..92b606d60020 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2189,7 +2189,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
>  		b = &htab->buckets[i];
>  		rcu_read_lock();
>  		head = &b->head;
> -		hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) {
> +		hlist_nulls_for_each_entry_safe(elem, n, head, hash_node) {
>  			key = elem->key;
>  			if (is_percpu) {
>  				/* current cpu value for percpu map */
> --
> 2.49.0
>
> .


