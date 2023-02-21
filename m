Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC46869E360
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 16:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjBUP35 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 10:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbjBUP34 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 10:29:56 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5490B2A9A3
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 07:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676993395; x=1708529395;
  h=message-id:date:mime-version:subject:from:to:references:
   in-reply-to:content-transfer-encoding;
  bh=gg/fLoMvT9rzE2Xe65hBqcu3xFlMrqPfcKbfkrA3HKI=;
  b=JEgJnVzFFgFZuIuTx+1s1/bKY4RcCEl9P7769HgseYGcxNLheBApRmCu
   v/pS9CEQdWSTHdjePDHwJn8ei5e6jguuJsXZsE5z6JIJIRC2HK4JieXPA
   5UKkCd3LIobWnWUfqRkhWYZjrcmkJAnb7BB3Dp+Ms8xnZ+tYmk9K74TVH
   NqX9hXo0wqaHd+R3EGg2bqsiyH6Ze07nI0zI2b0KKWXKYqMnshYYiMtx2
   Xl20skbz/9/xEKwn8FPKQ+fmcF5uZNNP08ZEj0pAs2mYtkUIZAz14c9Ww
   dbznT72im+PtjeLv+bCom0T1ukJI4I7wUfqHKVNdiyU9VEYRdoNMtoXvu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="316381323"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="316381323"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 07:17:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="704066373"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="704066373"
Received: from tveit-mobl.ger.corp.intel.com (HELO [10.249.39.132]) ([10.249.39.132])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 07:17:53 -0800
Message-ID: <b2cf88bf-c137-8278-d20d-bb8a0eda5fd8@linux.intel.com>
Date:   Tue, 21 Feb 2023 17:17:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] bpf: Add support for absolute value BPF timers
Content-Language: en-US
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org
References: <20230221144803.2216876-1-tero.kristo@linux.intel.com>
In-Reply-To: <20230221144803.2216876-1-tero.kristo@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Please ignore this, I added a broken mailing list to CC.

Re-sending in a bit.

-Tero

On 21/02/2023 16:48, Tero Kristo wrote:
> Add a new flag BPF_F_TIMER_ABS that can be passed to bpf_timer_start()
> to start an absolute value timer instead of the default relative value.
> This makes the timer expire at an exact point in time, instead of a time
> with latencies and jitter induced by both the BPF and timer subsystems.
> This is useful e.g. in certain time sensitive profiling cases, where we
> need a timer to expire at an exact point in time.
>
> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> ---
>   include/uapi/linux/bpf.h | 15 +++++++++++++++
>   kernel/bpf/helpers.c     | 11 +++++++++--
>   2 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 464ca3f01fe7..7f5b71847984 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4951,6 +4951,12 @@ union bpf_attr {
>    *		different maps if key/value layout matches across maps.
>    *		Every bpf_timer_set_callback() can have different callback_fn.
>    *
> + *		*flags* can be one of:
> + *
> + *		**BPF_F_TIMER_ABS**
> + *			Start the timer in absolute expire value instead of the
> + *			default relative one.
> + *
>    *	Return
>    *		0 on success.
>    *		**-EINVAL** if *timer* was not initialized with bpf_timer_init() earlier
> @@ -7050,4 +7056,13 @@ struct bpf_core_relo {
>   	enum bpf_core_relo_kind kind;
>   };
>   
> +/*
> + * Flags to control bpf_timer_start() behaviour.
> + *     - BPF_F_TIMER_ABS: Timeout passed is absolute time, by default it is
> + *       relative to current time.
> + */
> +enum {
> +	BPF_F_TIMER_ABS = (1ULL << 0),
> +};
> +
>   #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index af30c6cbd65d..924849d89828 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1253,10 +1253,11 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
>   {
>   	struct bpf_hrtimer *t;
>   	int ret = 0;
> +	enum hrtimer_mode mode;
>   
>   	if (in_nmi())
>   		return -EOPNOTSUPP;
> -	if (flags)
> +	if (flags > BPF_F_TIMER_ABS)
>   		return -EINVAL;
>   	__bpf_spin_lock_irqsave(&timer->lock);
>   	t = timer->timer;
> @@ -1264,7 +1265,13 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
>   		ret = -EINVAL;
>   		goto out;
>   	}
> -	hrtimer_start(&t->timer, ns_to_ktime(nsecs), HRTIMER_MODE_REL_SOFT);
> +
> +	if (flags & BPF_F_TIMER_ABS)
> +		mode = HRTIMER_MODE_ABS_SOFT;
> +	else
> +		mode = HRTIMER_MODE_REL_SOFT;
> +
> +	hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
>   out:
>   	__bpf_spin_unlock_irqrestore(&timer->lock);
>   	return ret;
