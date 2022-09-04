Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6025AC39C
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 11:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiIDJ3D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 05:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiIDJ3D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 05:29:03 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01CF474F0
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 02:29:01 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oUlw0-00077B-BR; Sun, 04 Sep 2022 11:28:56 +0200
Message-ID: <d610de0d-d0f9-6c1f-93e1-b408109b861f@leemhuis.info>
Date:   Sun, 4 Sep 2022 11:28:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US, de-DE
To:     Stefan Wahren <stefan.wahren@i2se.com>, regressions@lists.linux.dev
Cc:     bpf@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        jpalus@fastmail.com
References: <f038d6f9-b96b-0749-111c-33ac8939a1c0@i2se.com>
 <56ffb198-8c93-1ec2-0b5e-9441e96359de@leemhuis.info>
 <76951173-ce4e-adda-e80e-7c313725e937@i2se.com>
 <d58ed1a8-99d5-c45a-975f-85b71a1f3928@i2se.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [BUG] null pointer dereference when loading bpf_preload on
 Raspberry Pi
In-Reply-To: <d58ed1a8-99d5-c45a-975f-85b71a1f3928@i2se.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1662283741;68340a74;
X-HE-SMSGID: 1oUlw0-00077B-BR
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03.09.22 16:44, Stefan Wahren wrote:
> Am 03.09.22 um 16:17 schrieb Stefan Wahren:
>>
>> Am 19.06.22 um 19:06 schrieb Thorsten Leemhuis:
>>> [TLDR: I'm adding this regression report to the list of tracked
>>> regressions; all text from me you find below is based on a few templates
>>> paragraphs you might have encountered already already in similar form.]
>>
>> as reported by Jan on Bugzilla [1] the issue has been resolved by
>>
>> e2dcac2f58f5 ("BPF: Fix potential bad pointer dereference in
>> bpf_sys_bpf()")
>>
>> I can confirm the fix.
> 
> sorry missed the link.
> 
> [1] - https://bugzilla.kernel.org/show_bug.cgi?id=216105
> 
>> #regzbot fixed-by: |e2dcac2f58f5

Sorry, I'm totally behind with tracking the progress for some
regressions because I'm busy preparing three talks :-/ Many thx for
letting me know!

FWIW, this is how you mail looked like here:

```
|I can confirm the fix.
|

|#regzbot fixed-by: |e2dcac2f58f5
||
"""

Regzbot ignored it, as the "#" has to be the first character in a new
paragraph. And the "|" before e2dcac2f58f5 would have confused it as
well. No worries, happens, that is easily fixed up:

#regzbot fixed-by: e2dcac2f58f5

But I wanted to tell you, as it's not the first time you tried to
interact with regzbot in a way that failed. I suspect you mailer does
something odd.

But as I said: no worries, things like that happen. :-D

Ciao, Thorsten
