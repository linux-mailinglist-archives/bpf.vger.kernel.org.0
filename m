Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3EE5FE7F0
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 06:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJNEUb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 00:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJNEUa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 00:20:30 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12864C619;
        Thu, 13 Oct 2022 21:20:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MpY692w6yzl4bZ;
        Fri, 14 Oct 2022 12:18:25 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgAX_tKD40hjtML3AA--.63871S2;
        Fri, 14 Oct 2022 12:20:23 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Free elements after one RCU-tasks-trace
 grace period
To:     paulmck@kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Delyan Kratunov <delyank@fb.com>, rcu@vger.kernel.org,
        houtao1@huawei.com
References: <20221011071128.3470622-1-houtao@huaweicloud.com>
 <20221011071128.3470622-2-houtao@huaweicloud.com>
 <20221011090742.GG4221@paulmck-ThinkPad-P17-Gen-1>
 <d91a9536-8ed2-fc00-733d-733de34af510@huaweicloud.com>
 <20221012063607.GM4221@paulmck-ThinkPad-P17-Gen-1>
 <b0ece7d9-ec48-0ecb-45d9-fb5cf973000b@huaweicloud.com>
 <20221012161103.GU4221@paulmck-ThinkPad-P17-Gen-1>
 <ca5f2973-e8b5-0d73-fd23-849f0dfc4347@huaweicloud.com>
 <20221013190041.GZ4221@paulmck-ThinkPad-P17-Gen-1>
Message-ID: <08d09b15-5a6b-7f76-d53d-242fb20ed394@huaweicloud.com>
Date:   Fri, 14 Oct 2022 12:20:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221013190041.GZ4221@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgAX_tKD40hjtML3AA--.63871S2
X-Coremail-Antispam: 1UD129KBjvJXoWxArWDWr1DXF4fXFy7Gw4kZwb_yoW5AFW5pF
        ZayFnrCr1kZry8K3Z3Jw17Cr42v3Z3GFW3Jr98Wr48A3WayrnrJrn2qr4rXrWFq393Ca42
        vF1YqrW5K3WUZFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUFDGOUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 10/14/2022 3:00 AM, Paul E. McKenney wrote:
> On Thu, Oct 13, 2022 at 09:25:31AM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 10/13/2022 12:11 AM, Paul E. McKenney wrote:
>>> On Wed, Oct 12, 2022 at 05:26:26PM +0800, Hou Tao wrote:
SNIP
>>> How about if I produce a patch for rcu_trace_implies_rcu_gp() and let
>>> you carry it with your series?  That way I don't have an unused function
>>> in -rcu and you don't have to wait for me to send it upstream?
>> Sound reasonable to me. Also thanks for your suggestions.
> Here you go!  Thoughts?
It looks great and thanks for it.
>
> 							Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 2eac2f7a9a6d8921e8084a6acdffa595e99dbd17
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu Oct 13 11:54:13 2022 -0700
>
>     rcu-tasks: Provide rcu_trace_implies_rcu_gp()
>     
>     As an accident of implementation, an RCU Tasks Trace grace period also
>     acts as an RCU grace period.  However, this could change at any time.
>     This commit therefore creates an rcu_trace_implies_rcu_gp() that currently
>     returns true to codify this accident.  Code relying on this accident
>     must call this function to verify that this accident is still happening.
>     
>     Reported-by: Hou Tao <houtao@huaweicloud.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Cc: Alexei Starovoitov <ast@kernel.org>
>     Cc: Martin KaFai Lau <martin.lau@linux.dev>
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 08605ce7379d7..8822f06e4b40c 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -240,6 +240,18 @@ static inline void exit_tasks_rcu_start(void) { }
>  static inline void exit_tasks_rcu_finish(void) { }
>  #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
>  
> +/**
> + * rcu_trace_implies_rcu_gp - does an RCU Tasks Trace grace period imply an RCU grace period?
> + *
> + * As an accident of implementation, an RCU Tasks Trace grace period also
> + * acts as an RCU grace period.  However, this could change at any time.
> + * Code relying on this accident must call this function to verify that
> + * this accident is still happening.
> + *
> + * You have been warned!
> + */
> +static inline bool rcu_trace_implies_rcu_gp(void) { return true; }
> +
>  /**
>   * cond_resched_tasks_rcu_qs - Report potential quiescent states to RCU
>   *
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index b0b885e071fa8..fe9840d90e960 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1535,6 +1535,8 @@ static void rcu_tasks_trace_postscan(struct list_head *hop)
>  {
>  	// Wait for late-stage exiting tasks to finish exiting.
>  	// These might have passed the call to exit_tasks_rcu_finish().
> +
> +	// If you remove the following line, update rcu_trace_implies_rcu_gp()!!!
>  	synchronize_rcu();
>  	// Any tasks that exit after this point will set
>  	// TRC_NEED_QS_CHECKED in ->trc_reader_special.b.need_qs.

