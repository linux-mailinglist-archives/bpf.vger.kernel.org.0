Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC006F1664
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 13:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345398AbjD1LIM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 07:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345445AbjD1LIM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 07:08:12 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836BE468F
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 04:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=EIpj9NBrOGmizzfKhLH1UUzuBDHC+GqDc7rVRb4Q03w=; b=bedzFNURa8J2JJSY2XOOedTJu0
        sy20+Xh1aWdzx9oOiJGbhvBa0m84w0l7Z0GEZduauGkXW43QvHdDA5N8zeYx1O8LltVfsfqd45b0x
        D++8nu19aJbWlmI7P54b8s095K3R0zSBjkMLuIhdxDEIo5WyM6jri/kLr1CIhl6Y3YDypz+Gcrvt4
        h+prHwfZxD0cNPvT8/RrDRSuQCEl7bg0KDvlcaFMrg+0a86wrrQj8947RNu+Z2krQikMVGxGuFwTo
        hep6vH3z46cHT+ABsqmp8qNQpLHpMD+Ou5cfvJFYR+Yv4TvTFlLIAGfZMO0UAXGUaQpjbjrwv0Y0M
        PXL4cjOA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1psLxE-000HYy-0w; Fri, 28 Apr 2023 13:07:56 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1psLxD-000Tg0-N5; Fri, 28 Apr 2023 13:07:55 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: Add fexit_sleep to
 DENYLIST.aarch64
To:     Manu Bretelle <chantr4@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@meta.com,
        Manu Bretelle <chantra@meta.com>, revest@chromium.org
References: <20230428034726.2593484-1-martin.lau@linux.dev>
 <ZEteyNfBuJXlxnhG@worktop>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7801acd8-2a97-857e-dd99-07a3f85002cb@iogearbox.net>
Date:   Fri, 28 Apr 2023 13:07:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ZEteyNfBuJXlxnhG@worktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26890/Fri Apr 28 09:22:55 2023)
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/28/23 7:51 AM, Manu Bretelle wrote:
> On Thu, Apr 27, 2023 at 08:47:26PM -0700, Martin KaFai Lau wrote:
>> From: Martin KaFai Lau <martin.lau@kernel.org>
>>
>> It is reported that the fexit_sleep never returns in aarch64.
> 
> Just to clarify, this was only happening against kernels compiled with
> llvm-16. It was working fine against kernel compiled with gcc.
> 
>> The remaining tests cannot start. Put this test into DENYLIST.aarch64
>> for now so that other tests can continue to run in the CI.

+Florent (for visibility and/or if you plan to look into it)

>> Reported-by: Manu Bretelle <chantra@meta.com>
>> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
>> ---
>>   tools/testing/selftests/bpf/DENYLIST.aarch64 | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
>> index 4b6b18424140..cd42e2825bd2 100644
>> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
>> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
>> @@ -1,5 +1,6 @@
>>   bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
>>   bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
>> +fexit_sleep                                      # The test never returns. The remaining tests cannot start.
>>   kprobe_multi_bench_attach                        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
>>   kprobe_multi_test/attach_api_addrs               # bpf_program__attach_kprobe_multi_opts unexpected error: -95
>>   kprobe_multi_test/attach_api_pattern             # bpf_program__attach_kprobe_multi_opts unexpected error: -95
>> -- 
>> 2.34.1
>>

