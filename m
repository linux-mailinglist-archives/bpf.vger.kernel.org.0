Return-Path: <bpf+bounces-45072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 429D79D0981
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 07:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F221F211E2
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 06:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56921474A9;
	Mon, 18 Nov 2024 06:20:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F4A13D50C
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 06:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731910834; cv=none; b=SCoq6EegCAQ1j+y0cyiH9ugfVfzL1DqHom5U0XHDOQc6M8E1k6Y9VPhMKSbhV/YMT90kcjDs5YvopAv8nXDeGbDHN0VKgg400SFAEwU4Zp9J9m+7rGmnZjnL461FXFT9zB/Ok4uU0jPZCU45VZDbMMdzVT+fQ7OplTVNbqUOksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731910834; c=relaxed/simple;
	bh=tTspQRPqL6psxjcaDar8pXC8pPqUmv1tiUZplSfH9MY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BXbtSN3KHyI4JbQN7Rfy714v43RWwgRQpKE6NGYJAajlMtNZs56iE8Mm3DWC9G/sI0hrvB6Jr/8V4Vq7izKJkMMMnknXIKe1GTjfmHwy3SJ1UWbCbaJzMY3S5eVPBHF0waLrwApfe0sGITl7zSgV1krQNjv2i1+ZP+y770Oyc+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XsHY300sYz4f3lg7
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 14:20:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 54E381A06D7
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 14:20:26 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgAX84ak3Dpns0t1CA--.55900S2;
	Mon, 18 Nov 2024 14:20:23 +0800 (CST)
Subject: Re: [PATCH bpf-next 00/10] Fixes for LPM trie
To: bot+bpf-ci@kernel.org
Cc: kernel-ci@meta.com, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, bpf <bpf@vger.kernel.org>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <46268aa9ef13a24388af833b17f6cef8bdd3a7be8402fec7640e65a2f1118468@mail.kernel.org>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <fd947bab-1445-4d43-ce7e-ed53697d466a@huaweicloud.com>
Date: Mon, 18 Nov 2024 14:20:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <46268aa9ef13a24388af833b17f6cef8bdd3a7be8402fec7640e65a2f1118468@mail.kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgAX84ak3Dpns0t1CA--.55900S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF15Gr4UGw47Zw45uFy8Zrb_yoW3uFXEkw
	4kur97GrnxA3Z8KF1xXr4xWFs2gry8ZFyFyr4DtrW7Zwn0kryDXrs5Gr93ZF98Xa9xXr9x
	Z3Z3J390krnxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU7I
	JmUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/18/2024 9:42 AM, bot+bpf-ci@kernel.org wrote:
> Dear patch submitter,
>
> CI has tested the following submission:
> Status:     SUCCESS
> Name:       [bpf-next,00/10] Fixes for LPM trie
> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=910440&state=*
> Matrix:     https://github.com/kernel-patches/bpf/actions/runs/11884065937
>
> No further action is necessary on your part.
>
>
> Please note: this email is coming from an unmonitored mailbox. If you have
> questions or feedback, please reach out to the Meta Kernel CI team at
> kernel-ci@meta.com.

I am curious about the reason on why test_maps on s390 is disabled. If I
remember correctly, test_maps on s390 was still enabled last year [1].

[1]: https://github.com/kernel-patches/bpf/actions/runs/7164372250


