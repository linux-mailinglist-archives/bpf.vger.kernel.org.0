Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C5728E1B2
	for <lists+bpf@lfdr.de>; Wed, 14 Oct 2020 15:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgJNNvT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Oct 2020 09:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgJNNvT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Oct 2020 09:51:19 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCB7C061755
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2020 06:51:18 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l15so1728061wmh.1
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2020 06:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WjaovaCQ0eCt8Yl43E3wEUK378r499nXJLq1rTHlnNU=;
        b=DYXBXD1D1629Vq6QcQ0plYMDrbU8+8AXifChm7Uq3HQGO0vgH5k7/GZ1jPbrjjCR0h
         psZuVGf2q8LW2O6rrMTF9+TnUihyZeM/Bha7IRsq3r/KYuzO9A2qVy/Z6GCVCZaRUOYl
         yNa2Dz8zmcMJbp8oZ06EANbLi16dA0o6u9/HknS91ySySFZDh97DCkwcb+AIkcZoNk9j
         mo+/fiSX95coCLDFKQbn8ssLR7Qo2GCtXKS1Gm7np8MPW6bL817c6jBxxUBeUu2bZ8/t
         HPhgKTPIOnZsWWz7DZMZZ0B9VbQoh7C8PZy+0p4BRdS3sNP+xKPQGRhBL0nXemCt2Hns
         uoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WjaovaCQ0eCt8Yl43E3wEUK378r499nXJLq1rTHlnNU=;
        b=aHsJ+agZAsIU67hycKoPhajYDwuL3nelnmAgRd9sqCIBqk0e96yX4yPY5mO/nocupP
         mAWrli0hlE8Fluu75/1Y8D3mrNKcQDeGvPZTHLfG1rXA5GoKRFHoHlJ6hUAl0bvzF6ZL
         AizkQ/x3Dj5NTIcgOnLCI1fsxhInbIlknF7OvBdDwF0KGeQSCo9v4HSlNRXkpKHyDLQA
         snU8s0nSEBSz9n1/k81nJjtHH71ktxFGpUstBjZleODUOmv/42vRzgLLuvzktJJB3Fuq
         ExF3nNgFmRR+14GzjyMMQOcwHk0XA0ak/d1Pf5djRh7VjUyts+TYaE/+Yr+97YhDy73l
         1I1g==
X-Gm-Message-State: AOAM530MSDieFNKw4uqLPNVSwIg43U6cZEJeNkCYyuKEQdRjam2DvIQw
        JqkSLVGMbz/THCPgGEA+OqKtlYFCf527
X-Google-Smtp-Source: ABdhPJzsKZAq3cZJWkhFCXcF25V7z2nQSXh4IDEKM9Lhd0aBKoaqaqlJl3ezbjcWdZDyMjLYKkxZ3Q==
X-Received: by 2002:a1c:3d86:: with SMTP id k128mr3609292wma.153.1602683476996;
        Wed, 14 Oct 2020 06:51:16 -0700 (PDT)
Received: from [192.168.254.199] (x4dbe9d8e.dyn.telefonica.de. [77.190.157.142])
        by smtp.gmail.com with ESMTPSA id 1sm5450511wre.61.2020.10.14.06.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 06:51:16 -0700 (PDT)
Subject: Re: BUG: kernel NULL pointer dereference in
 __cgroup_bpf_run_filter_skb
From:   Thomas Reim <reimth@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
References: <CAOLRBTUSkRbku25rbw6Fyb019wFqFvEN=6xGM+RgFJFQ=NH4KQ@mail.gmail.com>
 <b62a18d0-1f78-3bf5-38b2-08d9a779e432@iogearbox.net>
 <92acbf2d-9d21-5074-cb07-0a3f206bd090@gmail.com>
Message-ID: <f00e8a89-98ea-94c7-3956-3fc1f565d763@gmail.com>
Date:   Wed, 14 Oct 2020 15:51:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <92acbf2d-9d21-5074-cb07-0a3f206bd090@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>>
>> Fix is under discussion here:
>>
>> https://lore.kernel.org/netdev/20200616180352.18602-1-xiyou.wangcong@gmail.com/ 
>>
>>
>> Thanks,
>> Daniel
> 
> Dear Daniel,
> 
> thank you for the hint. I will try to follow-up the discussion. For your 
> convenience I have added some of our many and various logs to this 
> thread. Maybe it will be of some help for the team.
> 

There seems to be not much progress in above mentioned thread. Don't 
know if there have been other discussions that have resulted in a patch.

But last week we successfully tested kernel 5.8.11 (5.8.11-1-MANJARO 
x64) without experiencing a kernel panic/freeze.. In the userspace 
systemd 246.6 was running. No idea which changes have solved our issue. 
But here kernel is back stable again.

We will switch the workstations from intermediate kernel 4.9 LTS, which 
was stable all the time, back to kernel 5.8.

Thank you.



