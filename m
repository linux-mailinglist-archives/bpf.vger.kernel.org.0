Return-Path: <bpf+bounces-18686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB8581EB3A
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 02:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E5728340B
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 01:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21701FD1;
	Wed, 27 Dec 2023 01:14:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384C41C02;
	Wed, 27 Dec 2023 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T0DDk4Gxnz4f3jJB;
	Wed, 27 Dec 2023 09:13:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1CA801A09EB;
	Wed, 27 Dec 2023 09:14:00 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBXpgxUeotlj6bvEg--.62105S2;
	Wed, 27 Dec 2023 09:13:59 +0800 (CST)
Subject: Re: [PATCH] HID: bpf: One function call less in
 call_hid_bpf_rdesc_fixup() after error detection
To: Markus Elfring <Markus.Elfring@web.de>, bpf@vger.kernel.org,
 linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 David Vernet <void@manifault.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <3203eb44-6e69-4bda-b585-426408cb75ee@web.de>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <618f886f-b2ff-4d50-cf74-e8478a7e8547@huaweicloud.com>
Date: Wed, 27 Dec 2023 09:13:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3203eb44-6e69-4bda-b585-426408cb75ee@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBXpgxUeotlj6bvEg--.62105S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1UWFyUWry7KrWUuFW5Awb_yoW8CFyxpw
	s7JayYkF4UtryvgF17Kr4vy3Waqa18XrZ8CFyxKay3Zws0vFZ5Jr1av345Wa98JrWkuF42
	kr40q3y7XF1jkaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/27/2023 2:24 AM, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 26 Dec 2023 19:13:25 +0100
>
> The kfree() function was called in one case by the
> call_hid_bpf_rdesc_fixup() function during error handling
> even if the passed data structure member contained a null pointer.
> This issue was detected by using the Coccinelle software.

It is totally OK to free a null pointer through kfree() and the ENOMEM
case is an unlikely case, so I don't think the patch is necessary.
>
> Thus adjust jump targets.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/hid/bpf/hid_bpf_dispatch.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
> index d9ef45fcaeab..c84fe55be5ed 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -118,17 +118,17 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *s
>
>  	ctx_kern.data = kzalloc(ctx_kern.ctx.allocated_size, GFP_KERNEL);
>  	if (!ctx_kern.data)
> -		goto ignore_bpf;
> +		goto dup_mem;
>
>  	memcpy(ctx_kern.data, rdesc, min_t(unsigned int, *size, HID_MAX_DESCRIPTOR_SIZE));
>
>  	ret = hid_bpf_prog_run(hdev, HID_BPF_PROG_TYPE_RDESC_FIXUP, &ctx_kern);
>  	if (ret < 0)
> -		goto ignore_bpf;
> +		goto free_data;
>
>  	if (ret) {
>  		if (ret > ctx_kern.ctx.allocated_size)
> -			goto ignore_bpf;
> +			goto free_data;
>
>  		*size = ret;
>  	}
> @@ -137,8 +137,9 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *s
>
>  	return rdesc;
>
> - ignore_bpf:
> +free_data:
>  	kfree(ctx_kern.data);
> +dup_mem:
>  	return kmemdup(rdesc, *size, GFP_KERNEL);
>  }
>  EXPORT_SYMBOL_GPL(call_hid_bpf_rdesc_fixup);
> --
> 2.43.0
>
>
> .


