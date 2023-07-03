Return-Path: <bpf+bounces-3879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17AE745DAE
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 15:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13081C209B3
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 13:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42257F9F6;
	Mon,  3 Jul 2023 13:46:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E323F9DE
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 13:46:44 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4DDE5D
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 06:46:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QvnJr0mZpz4f3xbM
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 21:46:36 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgCXheM50aJk7L0jNA--.61114S2;
	Mon, 03 Jul 2023 21:46:36 +0800 (CST)
Subject: Re: [bug report] bpf: Enforce BPF ringbuf size to be the power of 2
To: Dan Carpenter <dan.carpenter@linaro.org>, andriin@fb.com
Cc: bpf@vger.kernel.org
References: <9c636a63-1f3d-442d-9223-96c2dccb9469@moroto.mountain>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <61cb2c19-5f09-4f0a-baf1-adc69c3031f4@huaweicloud.com>
Date: Mon, 3 Jul 2023 21:46:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9c636a63-1f3d-442d-9223-96c2dccb9469@moroto.mountain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgCXheM50aJk7L0jNA--.61114S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW8AF4DKF48XrWDAr4UXFb_yoW8trWrpF
	4jyr10va9xJr1DZ348Za48JryrA39ay34Y9Fn8Xws29Fy3WFy2qr9F9FyS9rn8Ar4DtF15
	tFW7KFyrAa97A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/30/2023 6:35 PM, Dan Carpenter wrote:
> Hello Andrii Nakryiko,
>
> The patch 517bbe1994a3: "bpf: Enforce BPF ringbuf size to be the
> power of 2" from Jun 29, 2020, leads to the following Smatch static
> checker warning:
>
> 	kernel/bpf/ringbuf.c:198 ringbuf_map_alloc()
> 	warn: impossible condition '(attr->max_entries > 68719464448)'
>
> Also Clang warns:
>
> kernel/bpf/ringbuf.c:198:24: warning: result of comparison of constant
> 68719464448 with expression of type '__u32' (aka 'unsigned int') is
> always false [-Wtautological-constant-out-of-range-compare]
>         if (attr->max_entries > RINGBUF_MAX_DATA_SZ)
>             ~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~
>
> kernel/bpf/ringbuf.c
>     184 static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr)
>     185 {
>     186         struct bpf_ringbuf_map *rb_map;
>     187 
>     188         if (attr->map_flags & ~RINGBUF_CREATE_FLAG_MASK)
>     189                 return ERR_PTR(-EINVAL);
>     190 
>     191         if (attr->key_size || attr->value_size ||
>     192             !is_power_of_2(attr->max_entries) ||
>     193             !PAGE_ALIGNED(attr->max_entries))
>     194                 return ERR_PTR(-EINVAL);
>     195 
>     196 #ifdef CONFIG_64BIT
>     197         /* on 32-bit arch, it's impossible to overflow record's hdr->pgoff */
> --> 198         if (attr->max_entries > RINGBUF_MAX_DATA_SZ)
>
> This check used to be inside bpf_ringbuf_alloc() and it used be:
>
> 	if (data_sz > RINGBUF_MAX_DATA_SZ)
>
> In that context where data_sz is a size_t the condition and the
> #ifdef CONFIG_64BIT made sense but here it doesn't.  Probably just
> delete the check.
It seems the check before 517bbe1994a3 is only used for future
extension. Considering the type of max_entries is u32, I think it is OK
to remove the check and the macro definition.
>
>     199                 return ERR_PTR(-E2BIG);
>     200 #endif
>     201 
>     202         rb_map = bpf_map_area_alloc(sizeof(*rb_map), NUMA_NO_NODE);
>     203         if (!rb_map)
>     204                 return ERR_PTR(-ENOMEM);
>     205 
>     206         bpf_map_init_from_attr(&rb_map->map, attr);
>     207 
>     208         rb_map->rb = bpf_ringbuf_alloc(attr->max_entries, rb_map->map.numa_node);
>     209         if (!rb_map->rb) {
>     210                 bpf_map_area_free(rb_map);
>     211                 return ERR_PTR(-ENOMEM);
>     212         }
>     213 
>     214         return &rb_map->map;
>     215 }
>
> regards,
> dan carpenter
>
> .


