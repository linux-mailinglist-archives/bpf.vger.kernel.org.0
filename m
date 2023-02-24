Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426466A1BA3
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 12:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBXLyn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 06:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBXLym (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 06:54:42 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F264630B24;
        Fri, 24 Feb 2023 03:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677239680; x=1708775680;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ObhEshuOx+I1UzksG69l/ZNgGBajEWxCRJYRmtthNsQ=;
  b=go3SdFAjoT2v8vLxh4ZyvFhVYdWeY8uCwlRLj/UeohilrQQri6JljFVF
   a4IrvzUobl7WqmI7DgBQCnoVbkPFa8SFto8NMPGHRGH3Vqod4TvDHr6Fd
   +s5UnLVYBS8wmC3Ge1F+amCugUdyIBvyo7NrI3au+tW+h/SPvJjvRbokB
   HnceuR7uMVgPT1sDId8pMx2Zxq1DOfZno6riAw6WNs2vyLE8Gl0Ltw+go
   TiBMDcNGAjn+8rDlnu9mZqLIg3LyAxuhmJ89Knn7FavEnr5GCtPT4WuwC
   KxndXXkqE/aiPzeFigpuPUtOyl3WaeTVVoKctwJ9XT/IHLXilRSdLDw3V
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="331194417"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="331194417"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 03:54:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="672874893"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="672874893"
Received: from hhalland-mobl.ger.corp.intel.com (HELO [10.249.40.112]) ([10.249.40.112])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 03:54:38 -0800
Message-ID: <b440647d-c001-2dbb-4f79-805936e4456f@linux.intel.com>
Date:   Fri, 24 Feb 2023 13:54:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RESEND PATCH] bpf: Add support for absolute value BPF timers
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230221151846.2218217-1-tero.kristo@linux.intel.com>
 <CAADnVQKmAEd3GTLC1GeP2hFtQUuaYZAkbV3Sk5-75x2jmmybLA@mail.gmail.com>
From:   Tero Kristo <tero.kristo@linux.intel.com>
In-Reply-To: <CAADnVQKmAEd3GTLC1GeP2hFtQUuaYZAkbV3Sk5-75x2jmmybLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 23/02/2023 18:31, Alexei Starovoitov wrote:
> On Tue, Feb 21, 2023 at 7:21 AM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>> Add a new flag BPF_F_TIMER_ABS that can be passed to bpf_timer_start()
>> to start an absolute value timer instead of the default relative value.
>> This makes the timer expire at an exact point in time, instead of a time
>> with latencies and jitter induced by both the BPF and timer subsystems.
>> This is useful e.g. in certain time sensitive profiling cases, where we
>> need a timer to expire at an exact point in time.
> "certain time sensitive profiling cases" is too vague.
>
> Please precisely describe the use case.
Ok, I'll do my best to update the changelog on that. There is an open 
source tool available that will benefit from this change so I can refer 
to that.
>
>> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
>> ---
>>   include/uapi/linux/bpf.h | 15 +++++++++++++++
>>   kernel/bpf/helpers.c     | 11 +++++++++--
>>   2 files changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 464ca3f01fe7..7f5b71847984 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -4951,6 +4951,12 @@ union bpf_attr {
>>    *             different maps if key/value layout matches across maps.
>>    *             Every bpf_timer_set_callback() can have different callback_fn.
>>    *
>> + *             *flags* can be one of:
>> + *
>> + *             **BPF_F_TIMER_ABS**
>> + *                     Start the timer in absolute expire value instead of the
>> + *                     default relative one.
>> + *
>>    *     Return
>>    *             0 on success.
>>    *             **-EINVAL** if *timer* was not initialized with bpf_timer_init() earlier
>> @@ -7050,4 +7056,13 @@ struct bpf_core_relo {
>>          enum bpf_core_relo_kind kind;
>>   };
>>
>> +/*
>> + * Flags to control bpf_timer_start() behaviour.
>> + *     - BPF_F_TIMER_ABS: Timeout passed is absolute time, by default it is
>> + *       relative to current time.
>> + */
>> +enum {
>> +       BPF_F_TIMER_ABS = (1ULL << 0),
>> +};
>> +
>>   #endif /* _UAPI__LINUX_BPF_H__ */
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index af30c6cbd65d..924849d89828 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -1253,10 +1253,11 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
>>   {
>>          struct bpf_hrtimer *t;
>>          int ret = 0;
>> +       enum hrtimer_mode mode;
>>
>>          if (in_nmi())
>>                  return -EOPNOTSUPP;
>> -       if (flags)
>> +       if (flags > BPF_F_TIMER_ABS)
>>                  return -EINVAL;
>>          __bpf_spin_lock_irqsave(&timer->lock);
>>          t = timer->timer;
>> @@ -1264,7 +1265,13 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
>>                  ret = -EINVAL;
>>                  goto out;
>>          }
>> -       hrtimer_start(&t->timer, ns_to_ktime(nsecs), HRTIMER_MODE_REL_SOFT);
>> +
>> +       if (flags & BPF_F_TIMER_ABS)
>> +               mode = HRTIMER_MODE_ABS_SOFT;
>> +       else
>> +               mode = HRTIMER_MODE_REL_SOFT;
>> +
>> +       hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> The patch looks fine, but please add a selftest for new functionality
> in the 2nd patch and resend them together.

Ok, will look at that, thanks!

-Tero

