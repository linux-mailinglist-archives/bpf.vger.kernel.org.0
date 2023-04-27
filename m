Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7936F0CE0
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 22:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344137AbjD0UK4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 16:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245168AbjD0UKz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 16:10:55 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4E82D74;
        Thu, 27 Apr 2023 13:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=rm4VFHyDYsqXBKBCZiX6B5oR3dBaXDqMYN7/nV3rI0o=; b=oVjhWQHWCGmKy1M95S4AZgQpao
        aPZfZFUwt0gqinnR6m4oxjlEQu8YYNfEY5wYHAgeWfURDtWW9eh6yB0j9w1ZCUaPLHjdamaTkC5dw
        K+HliZCX9gTUW4J5N3ZLj3X/HWKYNtmzDrCKjLeGPNMwa/mNmVIIswQyITTh20FlpaB1hmfeIarje
        KPLVkTfhs6Q9LtJaCzf6uyToiJPAlQYfVC3iPNUdYpd4HvBvKmS/mdOOnJvKRygqm1/0/4iZTRsfc
        F/q76zK1DIqtAZaVnLaXFKzZixIe1ayxB06fUp25+johy6c+NNtWNVcaowsQu3HkctlJdPinrEAPE
        LPFF1NqQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1ps7x5-000JeT-CV; Thu, 27 Apr 2023 22:10:51 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ps7x4-000Lnr-W5; Thu, 27 Apr 2023 22:10:51 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: Update the aarch64 tests deny
 list
To:     Stanislav Fomichev <sdf@google.com>,
        Florent Revest <revest@chromium.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, kpsingh@kernel.org, mykolal@fb.com,
        martin.lau@linux.dev, song@kernel.org, xukuohai@huaweicloud.com,
        mark.rutland@arm.com
References: <20230427143207.635263-1-revest@chromium.org>
 <CABRcYm+O-_GGhnAmJW6_=9vKeKSvzVLcxBRq3Pfjb3W0_HNjhw@mail.gmail.com>
 <ZErFdVXHhEdJ/m3G@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <60a7370b-9e6a-cba3-4d63-76d47a780982@iogearbox.net>
Date:   Thu, 27 Apr 2023 22:10:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ZErFdVXHhEdJ/m3G@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26889/Thu Apr 27 09:25:48 2023)
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/27/23 8:56 PM, Stanislav Fomichev wrote:
> On 04/27, Florent Revest wrote:
>> On Thu, Apr 27, 2023 at 4:32 PM Florent Revest <revest@chromium.org> wrote:
>>>
>>> This patch updates the list of BPF selftests which are known to fail so
>>> the BPF CI can validate the tests which pass now.
>>
>> Note: I tested this denylist a few months back by sending a manual PR
>> to https://github.com/kernel-patches/bpf.
>> At the time, it worked
>> https://github.com/kernel-patches/bpf/actions/runs/4106542133/jobs/7085514761
>> (even though there seemed to be a known flake in the gcc variant but
>> unrelated to the new arch support)
>>
>> Every time I wanted to have the CI run on my PRs, I had to annoy Manu
>> by email (I wouldn't have the rights to trigger the CI by myself
>> otherwise). So I haven't tested this *actual* patch rebased on the
>> current CI before sending it to the list. (e.g. the
>> module_fentry_shadow test has been added since then and I just assumed
>> it would pass in CI like the rest)
>>
>> My understanding is that this patch should soon be picked up by the
>> testing bot and we can use that CI run to check that everything works
>> as intended. Let's wait for a CI green light before merging this! :)
>> If there are errors I'll send a v2
> 
> Looks green now:
> 
> Acked-by: Stanislav Fomichev <sdf@google.com>
> 
> https://github.com/kernel-patches/bpf/actions/runs/4822595792/jobs/8590732278

That's awesome to see ... big batch of tests which this unlocks!
