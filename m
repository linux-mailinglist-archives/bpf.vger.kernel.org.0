Return-Path: <bpf+bounces-9226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B17792005
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 04:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35649280EF3
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 02:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4353638;
	Tue,  5 Sep 2023 02:23:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A2162B
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 02:23:36 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE6FCC6
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 19:23:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Rfq735Dx7z4f3jYB
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 10:23:27 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgA3ZjIfkfZkL24ICQ--.8291S2;
	Tue, 05 Sep 2023 10:23:31 +0800 (CST)
Subject: Re: [PATCH bpf-next 05/12] bpf: Add missed value to kprobe perf link
 info
To: Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
References: <20230828075537.194192-1-jolsa@kernel.org>
 <20230828075537.194192-6-jolsa@kernel.org>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <4540a09e-43a4-c258-710c-af895138ba6b@huaweicloud.com>
Date: Tue, 5 Sep 2023 10:23:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230828075537.194192-6-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgA3ZjIfkfZkL24ICQ--.8291S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1kKF43Kw4kuw4UXF18Xwb_yoW8KF1kpF
	s8ArsxKr4xJFWj93y8Zw18uw1rtw4kXrWUK39rG34fArn0q348XFsFgrsFvw1FvrZ0kay3
	A3y29FyYk347ZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
> Add missed value to kprobe attached through perf link info to
> hold the stats of missed kprobe handler execution.
>
> The kprobe's missed counter gets incremented when kprobe handler
> is not executed due to another kprobe running on the same cpu.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/trace_events.h   |  6 ++++--
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/syscall.c           | 14 ++++++++------
>  kernel/trace/bpf_trace.c       |  5 +++--
>  kernel/trace/trace_kprobe.c    |  5 ++++-
>  tools/include/uapi/linux/bpf.h |  1 +
>  6 files changed, 21 insertions(+), 11 deletions(-)
>

SNIP
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 17c21c0b2dd1..998c88874507 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1546,7 +1546,8 @@ NOKPROBE_SYMBOL(kretprobe_perf_func);
>  
>  int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
>  			const char **symbol, u64 *probe_offset,
> -			u64 *probe_addr, bool perf_type_tracepoint)
> +			u64 *probe_addr, unsigned long *missed,
> +			bool perf_type_tracepoint)
>  {
>  	const char *pevent = trace_event_name(event->tp_event);
>  	const char *group = event->tp_event->class->system;
> @@ -1565,6 +1566,8 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
>  	*probe_addr = kallsyms_show_value(current_cred()) ?
>  		      (unsigned long)tk->rp.kp.addr : 0;
>  	*symbol = tk->symbol;
> +	if (missed)
> +		*missed = tk->rp.kp.nmissed;

According to the implement of probes_profile_seq_show(), the missed
counter for kretprobe should be tk->rp.kp.nmissed + tk->rp.nmissed. I
think it would be a good idea to factor out a common helper to get the
missed counter for kprobe or kretprobe.
>  	return 0;
>  }
>  #endif	/* CONFIG_PERF_EVENTS */
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index b754edfb0cd7..5a39c7a13499 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6539,6 +6539,7 @@ struct bpf_link_info {
>  					__u32 name_len;
>  					__u32 offset; /* offset from func_name */
>  					__u64 addr;
> +					__u64 missed;
>  				} kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
>  				struct {
>  					__aligned_u64 tp_name;   /* in/out */


