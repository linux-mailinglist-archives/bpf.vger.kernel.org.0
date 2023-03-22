Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7695D6C4441
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 08:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjCVHod (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 03:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCVHoc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 03:44:32 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B7B1DB8C
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 00:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=6t7Bhd1Bh6EvMit2b0ZfZcbjvCFvjUqk4VJaUAum3FU=; b=D0eeHOyPsIQkkzU+ToQtFcXB/z
        8cq5vsTTwvLscd9NztAigTBVSfVKU+lojlH77gIfRuNwaZX4qBr8bS7qnCuyHfrUggfkw2Z/Ks92k
        fjUoaIskDRoOgSj9U3/hxLzLswwYR65X5wFDRsBcEp/2FtFYrJm4aiLyky8NmMS8llaGkkxf9SP7D
        FCNA8NRBVVQTXglhOIhOFYYJnvQQ1xHy+JUx15cCoVBs9lDuPGjs+3gn3yC6V7wHKtXkqZI7iyKSn
        z+uCCDFci8YmqqBOoBaD5UZBHskqjqog3LBKCeGpiPCmqFC7FmRF3d9LYMJZE2t3iynTvHbqYw2Uy
        yVu8b5GA==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pet93-000KtC-Hv; Wed, 22 Mar 2023 08:44:29 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pet93-000PP6-B9; Wed, 22 Mar 2023 08:44:29 +0100
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix __reg_bound_offset 64->32 var_off
 subreg propagation
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Xu Kuohai <xukuohai@huaweicloud.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>
References: <20230321193354.10445-1-daniel@iogearbox.net>
 <20230322030342.sl4n62pmep3rc6vg@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f780adc2-a21c-3c98-083d-8dc5b965a3ff@iogearbox.net>
Date:   Wed, 22 Mar 2023 08:44:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230322030342.sl4n62pmep3rc6vg@dhcp-172-26-102-232.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26850/Tue Mar 21 08:22:52 2023)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/22/23 4:03 AM, Alexei Starovoitov wrote:
> On Tue, Mar 21, 2023 at 08:33:53PM +0100, Daniel Borkmann wrote:
>> Xu reports that after commit 3f50f132d840 ("bpf: Verifier, do explicit ALU32
>> bounds tracking"), the following BPF program is rejected by the verifier:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> ...
>> index d517d13878cf..d66e70707172 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -1823,9 +1823,9 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
>>   	struct tnum var64_off = tnum_intersect(reg->var_off,
>>   					       tnum_range(reg->umin_value,
>>   							  reg->umax_value));
>> -	struct tnum var32_off = tnum_intersect(tnum_subreg(reg->var_off),
>> -						tnum_range(reg->u32_min_value,
>> -							   reg->u32_max_value));
>> +	struct tnum var32_off = tnum_intersect(tnum_subreg(var64_off),
>> +					       tnum_range(reg->u32_min_value,
>> +							  reg->u32_max_value));
> 
> Great fix and excellent analysis!
> The CI is complaining though:
> test_align:FAIL:pointer variable subtraction unexpected error: 1 (errno 13)
> #1/12    align/pointer variable subtraction:FAIL
> #1       align:FAIL
> Summary: 289/1752 PASSED, 29 SKIPPED, 1 FAILED
> 
> Please roll the update for the test into the fix.
> 
> Also agree that bpf-next is a good target for the fix.
> It doesn't look risky, but since it was there for so long it can go through
> bpf-next just fine.

Agree wrt to above. I'll look into the test_progs one and get this fixed today in a v2.

Thanks,
Daniel
