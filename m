Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8715D6B2D1E
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 19:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjCISu5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 13:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjCISus (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 13:50:48 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9963EFAAF2
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 10:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=v6m9LhzvdyUmNdGhCLMsN+mLfez7f51psF1rvVegUCk=; b=cYxzmEa3HX8tv9lLpwYDro1YIk
        ahKiwE2z48BI8quV1rrlqo3+3foDXFbx2tKhPyl+scv0Yq9zKAoJ/3MpZjSgIyTBrDn1hsYLxnHKP
        OlFwX+BW+K8ngnJr5cwPGai2X6d8jKBjygOAw/6poWe4t8Idd7vaHEMLpl2kRmqNcNzebWzGsFfxg
        XvRiRWQmigqYBzmOnn4069DaZVC97MvXwW6MXl23p8ub3w19cNJOMLgoMIWdnn6rVMF7PVYppE77C
        Bs6mSxA6PcP8X8FxIgRhagjumh7rd5wGVQcrmMYKLEc4THqr0LL8kOZzW/unF8BUpLhRiDtAojua6
        47i0GVEQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1paLLY-000LkM-Dx; Thu, 09 Mar 2023 19:50:36 +0100
Received: from [81.6.34.132] (helo=localhost.localdomain)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1paLLY-000B7W-61; Thu, 09 Mar 2023 19:50:36 +0100
Subject: Re: [PATCH] Revert "libbpf: Poison strlcpy()"
To:     Jesus Sanchez-Palencia <jesussanp@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     andrii@kernel.org, bpf@vger.kernel.org, sdf@google.com,
        rongtao@cestc.cn
References: <20230309004836.2808610-1-jesussanp@google.com>
 <167832601863.28104.18004021177531379064.git-patchwork-notify@kernel.org>
 <CAK4Nh0gOSHfwb8Yuv_YAhKHH+gTr=rqt+ZnQi1yXQ7qLiqu21w@mail.gmail.com>
 <CAEf4BzbggD36JS4Z1dukPBqpTBapO-ptbfa3Qc8m9j5j-7ue=A@mail.gmail.com>
 <CAK4Nh0hjip7U4_oMYbCn1mx2j4n_y4FT67yMUDMY1ffu6RtOew@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4afc9786-be46-8b7f-3e71-f457d6111c22@iogearbox.net>
Date:   Thu, 9 Mar 2023 19:50:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAK4Nh0hjip7U4_oMYbCn1mx2j4n_y4FT67yMUDMY1ffu6RtOew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26836/Thu Mar  9 09:23:04 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/9/23 6:31 PM, Jesus Sanchez-Palencia wrote:
> On Thu, Mar 9, 2023 at 9:27 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>> On Thu, Mar 9, 2023 at 8:06 AM Jesus Sanchez-Palencia
>> <jesussanp@google.com> wrote:
>>> On Wed, Mar 8, 2023 at 5:40 PM <patchwork-bot+netdevbpf@kernel.org> wrote:
>>>>
>>>> Hello:
>>>>
>>>> This patch was applied to bpf/bpf-next.git (master)
>>>> by Andrii Nakryiko <andrii@kernel.org>:
>>>
>>> Andrii, are you planning to send this patch to 6.3-rc* since the build
>>> is broken there?
>>> Just double-checking since it was applied to bpf-next.
>>
>> I didn't intend to, feel free to do that.
> 
> Oh I always thought that fixes for the rc-* iterations had to come
> from the maintainer
> trees. Should I just send it to lkml directly?
> 
>> But just curious, why are you building libbpf from kernel sources
>> instead of Github repo? Is it through perf build?
> 
> Yes, through the perf build. We build it altogether as part of our kernel build.

Ok, just moved over to bpf tree in that case where it will land in -rc's.

Thanks,
Daniel
