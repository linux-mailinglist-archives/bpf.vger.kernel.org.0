Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F777636F06
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 01:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiKXAk7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 19:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKXAk5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 19:40:57 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A74B08DB;
        Wed, 23 Nov 2022 16:40:56 -0800 (PST)
Message-ID: <6fbd8c35-04de-c379-5062-a0b9d4a8ebbe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669250455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RW4s5qZP7iLYjFXDb8iCZpuHhmvYZDpwBBjWfBk4ed8=;
        b=YrgziNJVFPBsbTQxrMK/WQfPldsgHqCpbYNfxIcUFm/ZAF5C8WmynY8/SHpzKk5akTx2Ew
        rCmJi1N7pJYvoASWQfzC/5hU6TxIl6nM4eIBRX9vlIs6XRYrpqpvs/dKhAJq/iIIG/MqmJ
        D3HrLD6mUGEhRXTNGn3IDirN9momOZc=
Date:   Wed, 23 Nov 2022 16:40:50 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2] bpf: Update bpf_{g,s}etsockopt() documentation
Content-Language: en-US
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Ji Rongfeng <SikoJobs@outlook.com>
Cc:     ast@kernel.org, andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, joannelkoong@gmail.com,
        kuifeng@fb.com, lorenzo@kernel.org, maximmi@nvidia.com,
        quentin@isovalent.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <DU0P192MB15479B86200B1216EC90E162D6099@DU0P192MB1547.EURP192.PROD.OUTLOOK.COM>
 <0977584d-8aff-624d-4cf8-a6e4868958c5@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <0977584d-8aff-624d-4cf8-a6e4868958c5@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/23/22 4:18 PM, Daniel Borkmann wrote:
> On 11/18/22 9:18 AM, Ji Rongfeng wrote:
>> * append missing optnames to the end
>> * simplify bpf_getsockopt()'s doc
>>
>> Signed-off-by: Ji Rongfeng <SikoJobs@outlook.com>
>> ---
>>   include/uapi/linux/bpf.h       | 20 ++++++++++++--------
>>   tools/include/uapi/linux/bpf.h | 20 ++++++++++++--------
>>   2 files changed, 24 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 51b9aa640ad2..14f29d95ea71 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -2576,14 +2576,19 @@ union bpf_attr {
>>    *         * **SOL_SOCKET**, which supports the following *optname*\ s:
>>    *           **SO_RCVBUF**, **SO_SNDBUF**, **SO_MAX_PACING_RATE**,
>>    *           **SO_PRIORITY**, **SO_RCVLOWAT**, **SO_MARK**,
>> - *           **SO_BINDTODEVICE**, **SO_KEEPALIVE**.
>> + *           **SO_BINDTODEVICE**, **SO_KEEPALIVE**, **SO_REUSEADDR**,
>> + *           **SO_REUSEPORT**, **SO_BINDTOIFINDEX**, **SO_TXREHASH**.
>>    *         * **IPPROTO_TCP**, which supports the following *optname*\ s:
>>    *           **TCP_CONGESTION**, **TCP_BPF_IW**,
>>    *           **TCP_BPF_SNDCWND_CLAMP**, **TCP_SAVE_SYN**,
>>    *           **TCP_KEEPIDLE**, **TCP_KEEPINTVL**, **TCP_KEEPCNT**,
>> - *          **TCP_SYNCNT**, **TCP_USER_TIMEOUT**, **TCP_NOTSENT_LOWAT**.
>> + *           **TCP_SYNCNT**, **TCP_USER_TIMEOUT**, **TCP_NOTSENT_LOWAT**,
>> + *           **TCP_NODELAY**, **TCP_MAXSEG**, **TCP_WINDOW_CLAMP**,
>> + *           **TCP_THIN_LINEAR_TIMEOUTS**, **TCP_BPF_DELACK_MAX**,
>> + *           **TCP_BPF_RTO_MIN**.
>>    *         * **IPPROTO_IP**, which supports *optname* **IP_TOS**.
>> - *         * **IPPROTO_IPV6**, which supports *optname* **IPV6_TCLASS**.
>> + *         * **IPPROTO_IPV6**, which supports the following *optname*\ s:
>> + *           **IPV6_TCLASS**, **IPV6_AUTOFLOWLABEL**.
>>    *     Return
>>    *         0 on success, or a negative error in case of failure.
>>    *
>> @@ -2800,12 +2805,11 @@ union bpf_attr {
>>    *           and **BPF_CGROUP_INET6_CONNECT**.
>>    *
>>    *         This helper actually implements a subset of **getsockopt()**.
>> - *         It supports the following *level*\ s:
>> + *         It supports the same set of *optname*\ s that supported by
> 
> nit: that is supported by
> 
>> + *         **bpf_setsockopt**\ () helper with a few exceptions:
>>    *
>> - *         * **IPPROTO_TCP**, which supports *optname*
>> - *           **TCP_CONGESTION**.
>> - *         * **IPPROTO_IP**, which supports *optname* **IP_TOS**.
>> - *         * **IPPROTO_IPV6**, which supports *optname* **IPV6_TCLASS**.
>> + *         * **bpf_setsockopt**\ () helper only: **TCP_BPF_***.
>> + *         * **bpf_getsockopt**\ () helper only: **TCP_SAVED_SYNC**.
> 
> I think from a user PoV the above is a bit hard to follow, maybe take Martin's
> earlier feedback into account and add a proper sentence; it will be much easier
> to understand.

+1  Made the change and also fixed TCP_SAVED_SYNC with s/SYNC/SYN/ while 
applying.  Thanks!


