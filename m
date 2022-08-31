Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD625A87F4
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 23:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiHaVP3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 17:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiHaVP2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 17:15:28 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D1044542;
        Wed, 31 Aug 2022 14:15:26 -0700 (PDT)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oTV3R-0006Xz-3c; Wed, 31 Aug 2022 23:15:21 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oTV3Q-000Ph0-Rr; Wed, 31 Aug 2022 23:15:20 +0200
Subject: Re: [RFC PATCH v2] bpf: use bpf_capable() instead of CAP_SYS_ADMIN
 for blinding decision
To:     "Serge E. Hallyn" <serge@hallyn.com>,
        Yauheni Kaliuta <ykaliuta@redhat.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org,
        alexei.starovoitov@gmail.com, jbenc@redhat.com,
        linux-security-module@vger.kernel.org
References: <20220831090655.156434-1-ykaliuta@redhat.com>
 <20220831152414.171484-1-ykaliuta@redhat.com>
 <20220831185039.GA20800@mail.hallyn.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4df80c14-d744-efc6-c043-c70c4c4ab541@iogearbox.net>
Date:   Wed, 31 Aug 2022 23:15:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220831185039.GA20800@mail.hallyn.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26644/Wed Aug 31 09:53:02 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/31/22 8:50 PM, Serge E. Hallyn wrote:
> On Wed, Aug 31, 2022 at 06:24:14PM +0300, Yauheni Kaliuta wrote:
>> The capability check can cause SELinux denial.
>>
>> For example, in ptp4l, setsockopt() with the SO_ATTACH_FILTER option
>> raises sk_attach_filter() to run a bpf program. SELinux hooks into
>> capable() calls and performs an additional check if the task's
>> SELinux domain has permission to "use" the given capability. ptp4l_t
>> already has CAP_BPF granted by SELinux, so if the function used
>> bpf_capable() as most BPF code does, there would be no change needed
>> in selinux-policy.
> 
> The selinux mentions probably aren't really necessary.  The more
> concise way to say it is that bpf_jit_blinding_enabled() should
> be permitted with CAP_BPF, that full CAP_SYS_ADMIN is not needed.
> (Assuming that that is the case)
> 
>> Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
>> ---
>>
>> v2: put the reasoning in the commit message
>>
>> ---
>>   include/linux/filter.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index a5f21dc3c432..3de96b1a736b 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -1100,7 +1100,7 @@ static inline bool bpf_jit_blinding_enabled(struct bpf_prog *prog)
>>   		return false;
>>   	if (!bpf_jit_harden)
>>   		return false;
>> -	if (bpf_jit_harden == 1 && capable(CAP_SYS_ADMIN))
>> +	if (bpf_jit_harden == 1 && bpf_capable())

I think lowering this requirement is fine here. These days given unpriv eBPF is
disabled by default, I see the main users for constant blinding coming from unpriv
in particular via cBPF -> eBPF migration (e.g. old-style socket filters).

>>   		return false;
>>   
>>   	return true;

Please also update Documentation/admin-guide/sysctl/net.rst to clarify cap details.

Thanks,
Daniel
