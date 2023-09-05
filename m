Return-Path: <bpf+bounces-9232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB4C792080
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 08:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A695F28106D
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 06:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69C5A5D;
	Tue,  5 Sep 2023 06:15:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FDD7F3
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 06:15:58 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F2FCC4
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 23:15:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RfwHD6S04z4f3prV
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 14:15:52 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgBHsWWVx_ZksO2JCQ--.41500S2;
	Tue, 05 Sep 2023 14:15:53 +0800 (CST)
Subject: Re: [PATCH bpf-next 03/12] bpf: Count stats for kprobe_multi programs
To: Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
References: <20230828075537.194192-1-jolsa@kernel.org>
 <20230828075537.194192-4-jolsa@kernel.org>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <6fcc4045-7a73-8ce9-0926-af5f2088d4eb@huaweicloud.com>
Date: Tue, 5 Sep 2023 14:15:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230828075537.194192-4-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgBHsWWVx_ZksO2JCQ--.41500S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF43Gry8Cry3Cw15WFWkCrg_yoW8XrWfpF
	Z7J3yDCr48Xa17ZFZrAr48ury3Z3Z8W34fWF4DG34fXr1kXw48t3W2kFs0vrWF9r95CrWS
	q3Wj9rZFk3y29rUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 8/28/2023 3:55 PM, Jiri Olsa wrote:
> Adding support to gather stats for kprobe_multi programs.
>
> We now count:
>   - missed stats due to bpf_prog_active protection (always)
>   - cnt/nsec of the bpf program execution (if kernel.bpf_stats_enabled=1)
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a7264b2c17ad..0a8685fc1eee 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2706,18 +2706,24 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
>  		.link = link,
>  		.entry_ip = entry_ip,
>  	};
> +	struct bpf_prog *prog = link->link.prog;
>  	struct bpf_run_ctx *old_run_ctx;
> +	u64 start;
>  	int err;
>  
>  	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
> +		bpf_prog_inc_misses_counter(prog);
>  		err = 0;
>  		goto out;
>  	}
>  
> +
>  	migrate_disable();
>  	rcu_read_lock();
>  	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> -	err = bpf_prog_run(link->link.prog, regs);
> +	start = bpf_prog_start_time();
> +	err = bpf_prog_run(prog, regs);
> +	bpf_prog_update_prog_stats(prog, start);

Oops, I missed the bpf_prog_run() here. It seems that bpf_prog_run() has
already done the accounting thing, so there is no need for double
accounting.
>  	bpf_reset_run_ctx(old_run_ctx);
>  	rcu_read_unlock();
>  	migrate_enable();


