Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1F46552F3
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 17:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiLWQsR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Dec 2022 11:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiLWQsR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Dec 2022 11:48:17 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37D02734
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 08:48:15 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso5540521wmb.1
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 08:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MZG3W3tth1PM3VOyWr8XYQ+qgqJ74w04nJrt+HRIRg=;
        b=p0nEkxT6oiBpSWNn6OavQcXoaxalmaQQmiF0IrDQZZNx8qkYNqSCxLby+07JBja7hK
         vUWwY0Z+Sd/wOdPjg0wzs9swOgqCc49FmiFCebbcRCqz8jrXve7SABr6DW03kgkLJLjJ
         X08sDeKF7p2uHZiAN3NQdnA1ka+clk3nXuKqSH3trP1l/7k0990nF4ZchoTgV1i1zYt0
         MirJglFqYTL6VOfHwpfDUf5qSsEdz+0HYS9XcCo4VZ4qcFNbOFLVc4h2ynuWbwEndDJe
         oCzRAVQhXhWKftwQI5LYvteYILaYWfdi5usbjfHgOhtM5rkjM72NgQev7z4anGabKX10
         7GWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/MZG3W3tth1PM3VOyWr8XYQ+qgqJ74w04nJrt+HRIRg=;
        b=TpRoaW67mGKGtBtHKoV/8vuRmljjNfTDcyTP0hEmLojazSa33bIRY+bvZ3/JQAQwDA
         zvW8CE4gcZGSrZPpmtV44v77pWDF5cBM7lZRGJmvhSOZmW095E8yGLTYNmJ/lunV2+dx
         gHEony7nLorlxaJj02tBf6N1pDi808GOMfUanes4ikZkh1venkIn7LtTs4AZwx6CjJaR
         8V7bsuVcVQARyOKWVRi2ndI9nDTv5vfYGCQKlIHuzjb5um951RmeGrMdIENYHTtomynZ
         nFl7SML/Pk81O/i/aNOJoJRanMstR6sVmeny3i36V0b8DdyB2Ful9hDUjq6vWNb/WY10
         4eeA==
X-Gm-Message-State: AFqh2kquBp5gH9su0PWPSjdxHTkTzAMRzGmFwpuwjfA+TDDJYCniffLd
        HE9ymvwv9LYXdsF1CZyJ9CkqfdnjwOQUOA==
X-Google-Smtp-Source: AMrXdXs9R2auqGT0W0DW82xhWeJjYpB9wSqVjMduaKfRT7T3A4iw2CnL2mwtspL+bl3+qVxJcIvRpw==
X-Received: by 2002:a05:600c:3b02:b0:3c7:18:b339 with SMTP id m2-20020a05600c3b0200b003c70018b339mr8765773wms.37.1671814094203;
        Fri, 23 Dec 2022 08:48:14 -0800 (PST)
Received: from [0.0.0.0] (ip44.ip-51-89-110.eu. [51.89.110.44])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b003c6f8d30e40sm10873382wms.31.2022.12.23.08.48.13
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 08:48:13 -0800 (PST)
Message-ID: <bc688911-79f1-d680-b06a-1ef837570032@gmail.com>
Date:   Fri, 23 Dec 2022 20:18:11 +0330
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     bpf@vger.kernel.org
From:   farbod shahinfar <fshahinfar1@gmail.com>
Subject: Adjust packets in SK_SKB verdict program
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello everyone,

I have a question about sk_skb eBPF hook. Specifically my question is 
about resizing packets in the sk_skb verdict programs using 
`bpf_skb_adjust_room`. The issue is that even though I call this helper 
and it returns successfully, after redirecting the packet, the size of 
the packet received on the other side of the socket (userspace app) has 
the original size.

I believe that this helper works properly and it really increases the 
skb room. Also after invoking this helper, the verifier won't complain 
about out of packet accesses. I think the issue is that the length would 
be overwritten by the value from the  stream parser before redirecting 
the skb (look at [1]).

Looking at the implementation of `bpf_skb_adjust_room` helper function  
(here [2]), it seems that at line [3] the stream parser value is updated 
if there is a context for the TLS program. In my test environment this 
update is not happening (I checked by adding printk). I am not 
interested in kTLS, so it makes sense to me that this branch is not 
taken. But it also makes me wonder if there should be a similar thing 
for other sk_skb programs. Am I missing a point?

My question is, can a sk_skb verdict program resize the packet it redirects?

Just for the sake of testing, I added some changes to update the stream 
parser length value with respect to room adjustment and it solves the 
issue. But I wonder if I have missed the point.

[1] https://github.com/torvalds/linux/blob/master/net/core/skmsg.c#L664
[2] https://github.com/torvalds/linux/blob/master/net/core/filter.c#L3536
[3] https://github.com/torvalds/linux/blob/master/net/core/filter.c#L3562


Sincerely,
Farbod
