Return-Path: <bpf+bounces-3415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8F573D652
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 05:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6264280DAD
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 03:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A643A57;
	Mon, 26 Jun 2023 03:30:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE5A7F;
	Mon, 26 Jun 2023 03:30:12 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3850211C;
	Sun, 25 Jun 2023 20:30:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QqCyl0MpKz4f3pBp;
	Mon, 26 Jun 2023 11:30:07 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBnwx08Bplkopd6Lw--.65136S2;
	Mon, 26 Jun 2023 11:30:07 +0800 (CST)
Subject: Re: [PATCH v2 bpf-next 09/13] bpf: Allow reuse from
 waiting_for_gp_ttrace list.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, daniel@iogearbox.net,
 andrii@kernel.org, void@manifault.com, paulmck@kernel.org
Cc: tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
 <20230624031333.96597-10-alexei.starovoitov@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <9cc35513-5522-9229-469b-7d691c9790e1@huaweicloud.com>
Date: Mon, 26 Jun 2023 11:30:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230624031333.96597-10-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBnwx08Bplkopd6Lw--.65136S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWUGF13WF1kJry7AF1UWrg_yoW8Gw45pF
	4fJFy8Wr45ZFy2y3Wagr4xCas8Xw18t343KayUZ34akr15Xwn0grZ3Wry3Xrn0kw4FkrWa
	qw1vgF13tw4Uu3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/24/2023 11:13 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> alloc_bulk() can reuse elements from free_by_rcu_ttrace.
> Let it reuse from waiting_for_gp_ttrace as well to avoid unnecessary kmalloc().
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/memalloc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 692a9a30c1dc..666917c16e87 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -203,6 +203,15 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
>  	if (i >= cnt)
>  		return;
>  
> +	for (; i < cnt; i++) {
> +		obj = llist_del_first(&c->waiting_for_gp_ttrace);
After allowing to reuse elements from waiting_for_gp_ttrace, there may
be concurrent llist_del_first() and llist_del_all() as shown below and
llist_del_first() is not safe because the elements freed from free_rcu()
could be reused immediately and head->first may be added back to
c0->waiting_for_gp_ttrace by other process.

// c0
alloc_bulk()
    llist_del_first(&c->waiting_for_gp_ttrace)

// c1->tgt = c0
free_rcu()
    llist_del_all(&c->waiting_for_gp_ttrace)

> +		if (!obj)
> +			break;
> +		add_obj_to_free_list(c, obj);
> +	}
> +	if (i >= cnt)
> +		return;
> +
>  	memcg = get_memcg(c);
>  	old_memcg = set_active_memcg(memcg);
>  	for (; i < cnt; i++) {


