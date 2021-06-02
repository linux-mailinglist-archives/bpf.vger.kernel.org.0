Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA504399609
	for <lists+bpf@lfdr.de>; Thu,  3 Jun 2021 00:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFBWnp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Jun 2021 18:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFBWno (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Jun 2021 18:43:44 -0400
Received: from out2.mail.ruhr-uni-bochum.de (out2.mail.ruhr-uni-bochum.de [IPv6:2a05:3e00:c:1001::8693:2ae5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05089C06174A
        for <bpf@vger.kernel.org>; Wed,  2 Jun 2021 15:42:01 -0700 (PDT)
Received: from mx2.mail.ruhr-uni-bochum.de (localhost [127.0.0.1])
        by out2.mail.ruhr-uni-bochum.de (Postfix mo-ext) with ESMTP id 4FwPCp6S1Sz8SVK;
        Thu,  3 Jun 2021 00:41:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rub.de; s=mail-2017;
        t=1622673718; bh=mTFKQrJYDpdDf/PTxmijfc9yhp61WKxuyBJBoEpauYo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Evw/yWdEvVQNpQigBk9TBnF35mJRlZi3bp3In7uMM1xd2jlFFcMfeM8UF+s2qFZs3
         y5gBgCPNZIKtKzsQ4aVDjrvh9JdKc2hSKxNv4tkFmEzlJAUzn3/JxiEU/PDty1c+c5
         ZnUGExTvB83Kcl7oOAWl6sBDIabf0mfdbexU0pJs=
Received: from out2.mail.ruhr-uni-bochum.de (localhost [127.0.0.1])
        by mx2.mail.ruhr-uni-bochum.de (Postfix idis) with ESMTP id 4FwPCp5llFz8SRW;
        Thu,  3 Jun 2021 00:41:58 +0200 (CEST)
X-RUB-Notes: Internal origin=IPv6:2a05:3e00:c:1001::8693:2aec
X-Envelope-Sender: <Benedict.Schlueter@rub.de>
Received: from mail2.mail.ruhr-uni-bochum.de (mail2.mail.ruhr-uni-bochum.de [IPv6:2a05:3e00:c:1001::8693:2aec])
        by out2.mail.ruhr-uni-bochum.de (Postfix mi-int) with ESMTP id 4FwPCp46lTz8SQl;
        Thu,  3 Jun 2021 00:41:58 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.1 at mx2.mail.ruhr-uni-bochum.de
Received: from [IPv6:2003:de:73f:90c9:d250:99ff:fe8d:a1e1] (p200300de073f90c9d25099fffe8da1e1.dip0.t-ipconnect.de [IPv6:2003:de:73f:90c9:d250:99ff:fe8d:a1e1])
        by mail2.mail.ruhr-uni-bochum.de (Postfix) with ESMTPSA id 4FwPCp0mS5zDgyl;
        Thu,  3 Jun 2021 00:41:58 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.0 at mail2.mail.ruhr-uni-bochum.de
Subject: Re: fix u32 printf specifier
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, benedict.schlueter@ruhr-uni-bochum.de
References: <6662597c-13a2-5c6e-df6c-31d18ed34bfd@rub.de>
 <20210602174127.55ny556mki3uv4tx@kafai-mbp>
From:   Benedict Schlueter <Benedict.Schlueter@rub.de>
Message-ID: <2d11fecc-4999-73d7-82e7-3a2c9d9826f3@rub.de>
Date:   Thu, 3 Jun 2021 00:41:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602174127.55ny556mki3uv4tx@kafai-mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/06/2021 19:41, Martin KaFai Lau wrote:

> On Wed, Jun 02, 2021 at 05:23:19PM +0200, Benedict Schlueter wrote:
>> Hi,
>>
>> I assume its clear what this patch does.
>>
>>
>>  From 9618e4475b812651c3fe481af885757675fc4ae2 Mon Sep 17 00:00:00 2001
>> From: Benedict Schlueter <benedict.schlueter@rub.de>
>> Date: Wed, 2 Jun 2021 17:16:13 +0200
>> Subject: use correct format string specifier for unsigned 32 Bit
>>   bounds print statements
>>
>> Signed-off-by: Benedict Schlueter <benedict.schlueter@rub.de>
>> ---
>>   kernel/bpf/verifier.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 1de4b8c6ee42..e107996c7220 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -690,11 +690,11 @@ static void print_verifier_state(struct
>> bpf_verifier_env *env,
>>                           (int)(reg->s32_max_value));
>>                   if (reg->u32_min_value != reg->umin_value &&
>>                       reg->u32_min_value != U32_MIN)
>> -                    verbose(env, ",u32_min_value=%d",
>> +                    verbose(env, ",u32_min_value=%u",
>>                           (int)(reg->u32_min_value));
> "%u" and (int) cast don't make sense.
Yep, changed to unsigned int for consistency with the other cases. Is 
this necessary? Since reg->u32_min_value is already a unsigned 32 bit 
number.
> It needs a proper commit message to explain why the change is needed
> and also a Fixes tag.  Please refer to Documentation/bpf/bpf_devel_QA.rst.

Sorry should have read this more carefully before. Everything should be 
included right now.

 From fd076dc5f2bd5ec4e9cb49530e77cf2d3e4f42c2 Mon Sep 17 00:00:00 2001
From: Benedict Schlueter <benedict.schlueter@rub.de>
Date: Wed, 2 Jun 2021 21:42:39 +0200
Subject: [PATCH bpf-next]
  use correct format string specifier for unsigned 32 bounds

when printing an unsigned value, it should be a positive number

verifier log before the patch
([...],s32_max_value=-2,u32_min_value=-16,u32_max_value=-2)

verifier log after the patch
([...],s32_max_value=-2,u32_min_value=4294967280,u32_max_value=4294967294)


fixes 3f50f132d840 (bpf: Verifier, do explicit ALU32 bounds tracking)
Signed-off-by: Benedict Schlueter <benedict.schlueter@rub.de>
---
  kernel/bpf/verifier.c | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1de4b8c6ee42..ea482ebaeb26 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -690,12 +690,12 @@ static void print_verifier_state(struct 
bpf_verifier_env *env,
                          (int)(reg->s32_max_value));
                  if (reg->u32_min_value != reg->umin_value &&
                      reg->u32_min_value != U32_MIN)
-                    verbose(env, ",u32_min_value=%d",
-                        (int)(reg->u32_min_value));
+                    verbose(env, ",u32_min_value=%u",
+                        (unsigned int)(reg->u32_min_value));
                  if (reg->u32_max_value != reg->umax_value &&
                      reg->u32_max_value != U32_MAX)
-                    verbose(env, ",u32_max_value=%d",
-                        (int)(reg->u32_max_value));
+                    verbose(env, ",u32_max_value=%u",
+                        (unsigned int)(reg->u32_max_value));
              }
              verbose(env, ")");
          }
-- 
2.31.1


