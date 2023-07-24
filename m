Return-Path: <bpf+bounces-5721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202D475FA76
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 17:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390331C20BA9
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 15:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8BFD530;
	Mon, 24 Jul 2023 15:11:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584CCD505
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 15:11:16 +0000 (UTC)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F712E7E
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 08:11:14 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76ae5b44426so193985285a.2
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 08:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690211473; x=1690816273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jHLHGvMvxYr4nt1BaNxAR/8eH1fxSS05ogGAzD554c=;
        b=5H5qoia/YCAThHL4tL1FBWzptpsIAsUlPFP+JsHr2dIKRN1bZ3X8b5hbmiozX3Hjp7
         L1O/Z3NDSEeCNdcnjIfiaHtRGuseUTrpR1ipIRSWO0N7Ta7nYAGbsIT0SFmaSyumT8jG
         JqxEdAk6WIvVBfbR02BWAU1k/wjOj3cOUfUgRWeugwFNY0qDl+W2Tvl8pA1P10g4ssbj
         WEtzD2s0fxkzmh3deWnnvupfgH1AhuckGrbpAJw4rlAGZlWgKFGTQnOkuySSo4s6jOF+
         2Jn4QddvJMA0fgJUs7lBnJ4EMoyL92unDt/bFMlUBu4zRno7Uanh/L8s1L/VMRuD2itn
         RMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690211473; x=1690816273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jHLHGvMvxYr4nt1BaNxAR/8eH1fxSS05ogGAzD554c=;
        b=AEbI0jugLSEbHn4W6DUuLSpEcExY1nvgknzu8/G5MGyNJCm6W1B0/SEFNytR127zdD
         H0DmurE/bd8LCA0Ga16/LUttmiCdttdI8zimXmYzSeIiCzRmH6l0YEEH8GHUDEQtv1QF
         1ttKqoY+WiAtD2CO5/TpHOOPPazon1+cj6QppRrCnNVYNTS1Ie55s2MEtEcFhrDxK5yg
         Yzbh+VA6xMU5DaZn/6Mfw0tmjxc939mrzU7WF5McMfnhDunzIw/4hGDbAD8tpMCr2e/P
         /TporTXabcfJo/zsZ9eKUAT0ZmT8HQBKzm2q/1ITUobzud1RwUIg9is8dmrU0TPe4A09
         Cijg==
X-Gm-Message-State: ABy/qLaxZ37n9rLCP0Ac3WLtdGpvbcWxl8DBqLNxwhqw76FdNZSlOmVa
	OW7u8fHQIpd+RasTvoWGJgTTVw==
X-Google-Smtp-Source: APBJJlFFHXH/+LGEPJpqtFuaBMrabrPuHbxjrUl8Ip7uKk3unQpUdzH/+9V33TtYVrX78fV2kYevBg==
X-Received: by 2002:a05:620a:1724:b0:768:1e00:76c4 with SMTP id az36-20020a05620a172400b007681e0076c4mr13167qkb.51.1690211473332;
        Mon, 24 Jul 2023 08:11:13 -0700 (PDT)
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id y24-20020a37e318000000b00767d7fa3d05sm2993144qki.136.2023.07.24.08.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 08:11:12 -0700 (PDT)
Message-ID: <2bef1006-3798-3fbe-87ad-4adfaee08cc0@google.com>
Date: Mon, 24 Jul 2023 11:11:10 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCHSET v4] sched: Implement BPF extensible scheduler class
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 joshdon@google.com, pjt@google.com, derkling@google.com, haoluo@google.com,
 dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
 riel@surriel.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@meta.com
References: <20230711011412.100319-1-tj@kernel.org>
 <ZLrQdTvzbmi5XFeq@slm.duckdns.org>
From: Barret Rhoden <brho@google.com>
In-Reply-To: <ZLrQdTvzbmi5XFeq@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.7 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi -

On 7/21/23 14:37, Tejun Heo wrote:
> Hello,
> 
> It's been more than half a year since the initial posting of the patchset
> and we are now at the fourth iteration. There have been some reviews around
> specifics (should be all addressed now except for the ones Andrea raised on
> this iteration) but none at high level. There also were some in-person and
> off-list discussions. Some, I believe, are addressed by the cover letter but
> it'd be nonetheless useful to delve into them on-list.
> 
> On our side, we've been diligently experimenting. 

On the google side, we're still experimenting and developing schedulers 
based on ghost, which we think we can port over to sched_ext.

Specifically, I've been working on a framework to write multicore 
schedulers in BPF called 'Flux'.  The idea in brief is to compose a 
scheduler as a hierarchy of "subschedulers", where cpus allocations go 
up and down the tree.

Flux is open-source, but it needs the ghost kernel and our BPF 
extensions currently (which are also open source, but harder to use for 
people).  I'll send a proposal to talk about it at LPC in case people 
are interested - if not the scheduler framework itself, then as a "this 
is some crazy stuff people can do with BPF".

As far as results go, I wrote a custom scheduler with Flux for our 
Search app and have been testing it on our single-leaf loadtester.  The 
initial results out of the box were pretty great: 17% QPS increase, 43% 
p99 decrease (default settings for the loadtester).  But the loadtester 
varies a bit, so it's hard to get reliable numbers out of it for an A/B 
comparison of schedulers.  Overall, we run equal or better than CFS.  I 
did a sweep across various offered loads, and we got 5% better QPS on 
average, 30% better p99 latency, 6% lower utilization.  The better 
numbers come under higher load, as you'd expect, when there are more 
threads competing for the cpu.

The big caveat to those numbers is the single-leaf loadtester isn't a 
representative test.  It's more of a microbenchmark.  Our next step is 
to run a full cluster load test, which will give us a better signal.

Anyway, this scheduler is highly specific to our app, including shared 
memory regions where the app's threads can tell us stuff like RPC 
deadlines.  It's the sort of thing you could only reasonably do with a 
pluggable scheduler like sched_ext or ghost.


> We are comfortable with the current API. Everything we tried fit pretty
> well. It will continue to evolve but sched_ext now seems mature enough for
> initial inclusion. I suppose lack of response doesn't indicate tacit
> agreement from everyone, so what are you guys all thinking?

Btw, I backported your patchset to our "franken-kernel".  I was able to 
boot it on one of our nodes, and run the search loadtest on CFS. 
Nothing broke, performance was the same, etc.  Not a huge surprise, 
since I didn't turn on sched_ext.  I haven't been able to get a 
sched_ext scheduler to work yet with our kernel - there's more patch 
backporting needed for your schedulers themselves (the bpf_for iterators 
and whatnot).  I'll report back if/when I can get it running.

Thanks,

Barret



