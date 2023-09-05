Return-Path: <bpf+bounces-9227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7363C79200C
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 04:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABEBD280F6A
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 02:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A330463B;
	Tue,  5 Sep 2023 02:40:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D4236A
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 02:40:10 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0B2E6
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 19:40:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RfqVF1pLZz4f3q3b
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 10:40:05 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgAXki4ClfZkzlEJCQ--.41946S2;
	Tue, 05 Sep 2023 10:40:05 +0800 (CST)
Subject: Re: [PATCH bpf-next 08/12] bpf: Count run stats in bpf_prog_run_array
To: Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
References: <20230828075537.194192-1-jolsa@kernel.org>
 <20230828075537.194192-9-jolsa@kernel.org>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <7adba3b2-29de-4959-b99a-d1ce3f26f31a@huaweicloud.com>
Date: Tue, 5 Sep 2023 10:40:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230828075537.194192-9-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgAXki4ClfZkzlEJCQ--.41946S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF43WF1kCF43ZrW8CrWkXrb_yoW8Gw1xpF
	WDA34UCr48Ga1Y9a4DAa18CwnFya4qgr1YkrWUW3yUZryjqrZ5G3WjkFsIyr90vrWjkr4x
	Z3W09rZ7Gry29rDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 8/28/2023 3:55 PM, Jiri Olsa wrote:
> Count runtime stats for bf programs executed through bpf_prog_run_array
> function. That covers kprobe, perf event and trace syscall probe.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/bpf.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 478fdc4794c9..732253eea675 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2715,10 +2715,11 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
>  		   const void *ctx, bpf_prog_run_fn run_prog)
>  {
>  	const struct bpf_prog_array_item *item;
> -	const struct bpf_prog *prog;
> +	struct bpf_prog *prog;
>  	struct bpf_run_ctx *old_run_ctx;
>  	struct bpf_trace_run_ctx run_ctx;
>  	u32 ret = 1;
> +	u64 start;
>  
>  	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu lock held");
>  
> @@ -2732,7 +2733,9 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
>  	item = &array->items[0];
>  	while ((prog = READ_ONCE(item->prog))) {
>  		run_ctx.bpf_cookie = item->bpf_cookie;
> +		start = bpf_prog_start_time();
>  		ret &= run_prog(prog, ctx);
> +		bpf_prog_update_prog_stats(prog, start);
>  		item++;
>  	}

bpf_prog_run() has already accounted the running count and the consumed
time for the prog, so I think both previous patch and this patch are not
needed.

>  	bpf_reset_run_ctx(old_run_ctx);


