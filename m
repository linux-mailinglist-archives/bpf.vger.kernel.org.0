Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0196C4420
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 08:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjCVHc4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 03:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCVHcx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 03:32:53 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1B95BC99
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 00:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=MpGVPOb/NVM+8aN5hh2iHqHJRSBSfSzPO53radfUn+E=; b=moDwU/fFtGrT23A3CJsAT5WVhf
        IeNX+mpNH0L42cXce/pP44bkdQz82asoSBDLl5vqSLSpSF/JzNlBAEPCt+UkHEAgbUUEVK0bZufC/
        V40PmV/UbgJlTTErVNrBtWTIKhGNpY4YB9IX3PjGCwB0sblnrSDHMpvwwAs1v2dV547xBVB9sMjdb
        ozLtxTsNnXn1I4Q7uTUeio5dEsssjDVrPIT2jBynNA7tzS7AL8jSjWUj1oyVrpl89JkHbqkbCDr/X
        2wyRLDu8nCttufY+S0MEDlKaSwylJzvPda7Ta1FD+MvXBMKNNqS//2Fvi7a4Ml1IDt2JW+piC/msb
        eIToZVsA==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pesxf-000HWm-Ck; Wed, 22 Mar 2023 08:32:43 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pesxf-000739-6M; Wed, 22 Mar 2023 08:32:43 +0100
Subject: Re: [stable] seccomp: Move copy_seccomp() to no failure path.
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     bpf@vger.kernel.org, lefteris.alexakis@kpn.com, sh@synk.net
References: <2a09e672-5cc4-346d-2536-5efa5a59bae1@iogearbox.net>
 <20230321233544.25287-1-kuniyu@amazon.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1c7b9523-a5a4-7148-bf29-33d3bf2a0b10@iogearbox.net>
Date:   Wed, 22 Mar 2023 08:32:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230321233544.25287-1-kuniyu@amazon.com>
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

On 3/22/23 12:35 AM, Kuniyuki Iwashima wrote:
>> On 3/21/23 6:09 PM, Kuniyuki Iwashima wrote:
>> [...]
>>>> Link: https://github.com/awslabs/amazon-eks-ami/issues/1179
>>>> Link: https://github.com/awslabs/amazon-eks-ami/issues/1219
>>>
>>> I'm investigating these issues with EKS folks.  On the issue 1179, the
>>> customer was using our 5.4 kernel, and on 1219, 5.10 kernel.
>>>
>>> Then, I found my memleak fix commit a1140cb215fa ("seccomp: Move
>>> copy_seccomp() to no failure path.") was not backported to upstream 5.10
>>> stable trees.  We'll test if the issue can be reproduced with/without
>>> the fix.
>>
>> Good to know that 5.10 EKS kernel is based on top of stable one. It indeed
>> looks like this could be happening there given a1140cb215fa is missing. I
>> wonder given it has proper Fixes tag why it didn't made it into stable tree
>> already. Thanks for checking, if it confirms, then lets ping Greg to cherry-
>> pick.
> 
> The commit conflicted with 5.10, so it was missed, I guess.
> I'll send a backporting patch for stable.

Awesome, thanks!
