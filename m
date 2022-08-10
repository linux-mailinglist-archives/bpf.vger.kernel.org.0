Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4877358EED9
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 16:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbiHJOyM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 10:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiHJOyC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 10:54:02 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5505675FDA;
        Wed, 10 Aug 2022 07:54:00 -0700 (PDT)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oLn5o-000E0n-G5; Wed, 10 Aug 2022 16:53:56 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oLn5o-0002MJ-7J; Wed, 10 Aug 2022 16:53:56 +0200
Subject: Re: [PATCH bpf] bpf, arm64: Fix bpf trampoline instruction endianness
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Xu Kuohai <xukuohai@huawei.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com,
        kbuild-all@lists.01.org, catalin.marinas@arm.com, will@kernel.org
References: <20220808040735.1232002-1-xukuohai@huawei.com>
 <YvI4FqZ91e2+0sBA@myrica>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7d680ad8-8851-dd4e-49f5-0d6054cf8de0@iogearbox.net>
Date:   Wed, 10 Aug 2022 16:53:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <YvI4FqZ91e2+0sBA@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26623/Wed Aug 10 09:55:07 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/9/22 12:33 PM, Jean-Philippe Brucker wrote:
> [+ arm64 maintainers]
> 
> On Mon, Aug 08, 2022 at 12:07:35AM -0400, Xu Kuohai wrote:
>> The sparse tool complains as follows:
>>
>> arch/arm64/net/bpf_jit_comp.c:1684:16:
>> 	warning: incorrect type in assignment (different base types)
>> arch/arm64/net/bpf_jit_comp.c:1684:16:
>> 	expected unsigned int [usertype] *branch
>> arch/arm64/net/bpf_jit_comp.c:1684:16:
>> 	got restricted __le32 [usertype] *
>> arch/arm64/net/bpf_jit_comp.c:1700:52:
>> 	error: subtraction of different types can't work (different base
>> 	types)
>> arch/arm64/net/bpf_jit_comp.c:1734:29:
>> 	warning: incorrect type in assignment (different base types)
>> arch/arm64/net/bpf_jit_comp.c:1734:29:
>> 	expected unsigned int [usertype] *
>> arch/arm64/net/bpf_jit_comp.c:1734:29:
>> 	got restricted __le32 [usertype] *
>> arch/arm64/net/bpf_jit_comp.c:1918:52:
>> 	error: subtraction of different types can't work (different base
>> 	types)
>>
>> This is because the variable branch in function invoke_bpf_prog and the
>> variable branches in function prepare_trampoline are defined as type
>> u32 *, which conflicts with ctx->image's type __le32 *, so sparse complains
>> when assignment or arithmetic operation are performed on these two
>> variables and ctx->image.
>>
>> Since arm64 instructions are always little-endian, change the type of
>> these two variables to __le32 * and call cpu_to_le32 to convert
>> instruction to little-endian before writing it to memory.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Fixes: efc9909fdce0 ("bpf, arm64: Add bpf trampoline for arm64")
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> 
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Applied, thanks! Also added small note that this is in line with emit() as well.
