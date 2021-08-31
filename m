Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382663FC096
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 03:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbhHaB5P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 21:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239310AbhHaB5P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Aug 2021 21:57:15 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA226C06175F
        for <bpf@vger.kernel.org>; Mon, 30 Aug 2021 18:56:20 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id b64so18105191qkg.0
        for <bpf@vger.kernel.org>; Mon, 30 Aug 2021 18:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kLE88EQebLxIb0eueAspM45JjD9ZYCctcMIOochu70g=;
        b=iFQ5epuevHPR1kqaIGxM2ApjObna1lR81SjKMd2R1mWjvP98llgLloXKsZ0r1F2KkX
         RcqC3HaeACXzYLERD8AmMfhbOGYR+GmofFlaicMvBmDltQPTEVZmrFlCRVnQoPBl2Z1h
         YHzShPHTe2ucwkGG+HUYTYbFmNgJosEn3CczF47mSSty2O1FPIMd9W6Wk8iCPT4gU7OB
         woSksUd/cQJM2m0VkT/9hQwuaVyHsYUVQOr2H08hzTPQFopNkZNHgAIbKvHxmFVDdPaf
         DsQkJ3IKbIP1w2OZIGuXHDxObWAIOOq8UpwSCnswGEUSRC9OhiaUF/HGtKQTXOl1tBBo
         h9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kLE88EQebLxIb0eueAspM45JjD9ZYCctcMIOochu70g=;
        b=HgD6sXpQnW9i5cG9oOczIp4R2JZk5OtbtLQRLxUuBfL1hzC3uUSdFS7fPqWbBvSub1
         9FmceA2Vaf5yDxPom7QodjdnJRU34dag/QgQhU+ct3NWwhbW8IuG5GkCkdjtzEBfNrMp
         8eJ7Y4/+goI/84rZR+AFmVmj0hZH8Jrsk10Wm0b8aP2/2JY3wuuj1ThE+YJOtHKgpXoD
         L4W5DRsZikYZFrCKadPXppQBaGblYMGkoMLHP8N/xgq6V8BiIyTvnnx4D8wyCiK/9OCn
         2GcS1LHGQrMgEeR6HAFRkIs7joESSCZwYthvR1HobS/y9RomFU7kkcMxdw/MWUUTbUx+
         zELQ==
X-Gm-Message-State: AOAM532Gj5+cfKeBpaoOc8vhE9CafZ884xyHuAOAYR8HRGkk0LGulIz8
        Qw6ktSXjeRZE4mKp7m+QCrnatz+I3mEtdQ==
X-Google-Smtp-Source: ABdhPJzW9jFrTT47/g8jDjcZdgNt5Q2tdNzHqJKyqA+6ikPEHG4S2417Zt6bxF1hRbgmhNPYurdRCg==
X-Received: by 2002:a37:a08e:: with SMTP id j136mr636291qke.195.1630374979859;
        Mon, 30 Aug 2021 18:56:19 -0700 (PDT)
Received: from [192.168.1.79] (bras-base-kntaon1617w-grc-28-184-148-47-47.dsl.bell.ca. [184.148.47.47])
        by smtp.googlemail.com with ESMTPSA id g1sm9785586qti.56.2021.08.30.18.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 18:56:19 -0700 (PDT)
Subject: Re: [PATCH bpf-next v2 00/13] bpfilter
To:     Dmitrii Banshchikov <me@ubique.spb.ru>, bpf@vger.kernel.org
Cc:     ast@kernel.org, davem@davemloft.net, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, rdna@fb.com
References: <20210829183608.2297877-1-me@ubique.spb.ru>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <a4039e82-9184-45bf-6aee-e663766d655a@mojatatu.com>
Date:   Mon, 30 Aug 2021 21:56:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210829183608.2297877-1-me@ubique.spb.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021-08-29 2:35 p.m., Dmitrii Banshchikov wrote:

[..]

> And here are some performance tests.
> 
> The environment consists of two machines(sender and receiver)
> connected with 10Gbps link via switch.  The sender uses DPDK to
> simulate QUIC packets(89 bytes long) from random IP. The switch
> measures the generated traffic to be about 7066377568 bits/sec,
> 9706553 packets/sec.
> 
> The receiver is a 2 socket 2680v3 + HT and uses either iptables,
> nft or bpfilter to filter out UDP traffic.
> 
> Two tests were made. Two rulesets(default policy was to ACCEPT)
> were used in each test:
> 
> ```
> iptables -A INPUT -p udp -m udp --dport 1500 -j DROP
> ```
> and
> ```
> iptables -A INPUT -s 1.1.1.1/32 -p udp -m udp --dport 1000 -j DROP
> iptables -A INPUT -s 2.2.2.2/32 -p udp -m udp --dport 2000 -j DROP
> ...
> iptables -A INPUT -s 31.31.31.31/32 -p udp -m udp --dport 31000 -j DROP
> iptables -A INPUT -p udp -m udp --dport 1500 -j DROP
> ```
> 
> The first test measures performance of the receiver via stress-ng
> [3] in bogo-ops. The upper-bound(there are no firewall and no
> traffic) value for bogo-ops is 8148-8210. The lower bound value
> (there is traffic but no firewall) is 6567-6643.
> The stress-ng command used: stress-ng -t60 -c48 --metrics-brief.
> 
> The second test measures the number the of dropped packets. The
> receiver keeps only 1 CPU online and disables all
> others(maxcpus=1 and set number of cores per socket to 1 in
> BIOS). The number of the dropped packets is collected via
> iptables-legacy -nvL, iptables -nvL and bpftool map dump id.
> 
> Test 1: bogo-ops(the more the better)
>              iptables            nft        bpfilter
>    1 rule:  6474-6554      6483-6515       7996-8008
> 32 rules:  6374-6433      5761-5804       7997-8042
> 
> 
> Test 2: number of dropped packets(the more the better)
>              iptables            nft         bpfilter
>    1 rule:  234M-241M           220M            900M+
> 32 rules:  186M-196M        97M-98M            900M+
> 
> 
> Please let me know if you see a gap in the testing environment.

General perf testing will depend on the nature of the use case
you are trying to target.
What is the nature of the app? Is it just receiving packets and
counting? Does it exemplify something something real in your
network or is just purely benchmarking? Both are valid.
What else can it do (eg are you interested in latency accounting etc)?
What i have seen in practise for iptables deployments is a default
drop and in general an accept list. Per ruleset IP address aggregation
is typically achieved via ipset. So your mileage may vary...

Having said that:
Our testing[1] approach is typically for a worst case scenario.
i.e we make sure you structure the rulesets such that all of the
linear rulesets will be iterated and we eventually hit the default
ruleset.
We also try to reduce variability in the results. A lot of small
things could affect your reproducibility, so we try to avoid them.
For example, from what you described:
You are sending from a random IP - that means each packet will hit
a random ruleset (for the case of 32 rulesets). And some rules will
likely be hit more often than others. The likelihood of reproducing the
same results for multiple runs gets lower as you increase the number
of rulesets.
 From a collection perspective:
Looking at the nature of the CPU utilization is important
Softirq vs system calls vs user app.
Your test workload seems to be very specific to ingress host.
So in reality you are more constrained by kernel->user syscalls
(which will be hidden if you are mostly dropping in the kernel
as opposed to letting packets go to user space).

Something is not clear from your email:
You seem to indicate that no traffic was running in test 1.
If so, why would 32 rulesets give different results than 1?

cheers,
jamal

[1] https://netdevconf.info/0x15/session.html?Linux-ACL-Performance-Analysis
