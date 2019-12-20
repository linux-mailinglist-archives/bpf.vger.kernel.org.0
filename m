Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DABF128086
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 17:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfLTQWG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 11:22:06 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:46849 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfLTQWG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 11:22:06 -0500
Received: by mail-wr1-f51.google.com with SMTP id z7so9927693wrl.13;
        Fri, 20 Dec 2019 08:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XwJJzR6QzlYFD6/ZYjJ0H72RiZX/I4Z7P7dfLpzKIXQ=;
        b=SJuXFwvjbiUIRxZkIVt+njC8able0gAD3XWHO69SVtatSS0MqPO+VPSXy96S0p2cI+
         odr+aKhnTn6QMlDugEZSQXJmnL34By0zKWcu9Ni5nUQP0eIEo7nZvQevhjbvr2eC+aF+
         OEfY309aoD7G88UbnBQmyLha+NY1t66TxGyXH4eq1hBWOCp+DbpBMCpXW0UQUz/RMomq
         6ghM2oWwpsp4NtnIkf4yRP3TiCF4aK7Lccf+LKI6k9U3eVoM5amHtE8kUAS/WS/j/Vc4
         SCy78EN025YHIKYVHKpvrAPWqBU1olivqkuyh+pyq2EJ92GpEqc+yU4gyeTo1ORpURkW
         KR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XwJJzR6QzlYFD6/ZYjJ0H72RiZX/I4Z7P7dfLpzKIXQ=;
        b=JQJYSQBiKI442RISlfLz7fRe1ckUgh86vHg1Uw6d0QJlv6utgYY2bm7JcHQa0bl3rj
         pjpaMe1eSxlEevD1xUhh3xBSLLam1Ymlpsnkk6CCCiVAvJuEzYL3c3rVqB7UqFFYx1Kl
         5NuX0OtXSmpAKget0mqK0EiKu4vKSZtqUkniFmb/tAc8X4fdP3CbQBEV4XtsFTBrTJzm
         i/g3bGblBPCEykq/nSzSn/XQ2PzJETMgdkSGWB/91UYt1VXkUTZFTHkvu1vUm7xUDHlR
         JSZau+iBiccfsjMdPLSkWANEkIF9H41Bd6PAT7gH0d0eAbhyyqbxPXmYlhvNI677MeCg
         WZ3w==
X-Gm-Message-State: APjAAAXiRxZFxO/NVrM/gDxkY1lwAxZgoBrn3gqn7Z72BAKevaTpw1zo
        s6Nj43juPIqjnN9VrKs5PUs=
X-Google-Smtp-Source: APXvYqyBGuIo3mtqHDF9loUVBWZbuDY+RxQ2FX1olpk5WamJiGLmvUTfrVnVeE5AobMfgFB2EHWcxQ==
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr16344627wrm.284.1576858924463;
        Fri, 20 Dec 2019 08:22:04 -0800 (PST)
Received: from [192.168.8.147] (72.173.185.81.rev.sfr.net. [81.185.173.72])
        by smtp.gmail.com with ESMTPSA id n3sm10488026wmc.27.2019.12.20.08.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 08:22:04 -0800 (PST)
Subject: Re: Percpu variables, benchmarking, and performance weirdness
To:     Tejun Heo <tj@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>
References: <CAJ+HfNgNAzvdBw7gBJTCDQsne-HnWm90H50zNvXBSp4izbwFTA@mail.gmail.com>
 <20191220103420.6f9304ab@carbon>
 <20191220151239.GE2914998@devbig004.ftw2.facebook.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <a66e79b1-41a8-08f6-8dc2-37ce7a5fff53@gmail.com>
Date:   Fri, 20 Dec 2019 08:22:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220151239.GE2914998@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/20/19 7:12 AM, Tejun Heo wrote:
> On Fri, Dec 20, 2019 at 10:34:20AM +0100, Jesper Dangaard Brouer wrote:
>>> So, my question to the uarch/percpu folks out there: Why are percpu
>>> accesses (%gs segment register) more expensive than regular global
>>> variables in this scenario.
>>
>> I'm also VERY interested in knowing the answer to above question!?
>> (Adding LKML to reach more people)
> 
> No idea.  One difference is that percpu accesses are through vmap area
> which is mapped using 4k pages while global variable would be accessed
> through the fault linear mapping.  Maybe you're getting hit by tlb
> pressure?

I definitely seen expensive per-cpu updates in the stack.
(SNMP counters, or per-cpu stats for packets/bytes counters)

It might be nice to have an option to use 2M pages.

(I recall sending some patches in the past about using high-order pages for vmalloc,
but this went nowhere)
