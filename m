Return-Path: <bpf+bounces-11116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB1D7B3739
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 17:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A966B282DD4
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 15:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9859E521AF;
	Fri, 29 Sep 2023 15:48:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD32516DD;
	Fri, 29 Sep 2023 15:48:35 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7F4DB;
	Fri, 29 Sep 2023 08:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=1Z4w2GSMgZnLDZe2A+e0eyFLH+sMwC0wx+0SEkVg94U=; b=ZETi8p5eJmyQ+pikvrzTL2VQnT
	SpKrvo1krgbYOcPDYrCvxjSL9XNde8AEli5vIBXlelhJq6f1H/mG01J+Rsi9j+1UmRFZpEs4sH+Mq
	cas3d6RjZ4kRJLCdzjr5kdOXwqjQL/0pRnmmzncoz8Pop7Eq/2RVIdaxSYaKrmjaQaZOaCT64pdyp
	C5XwbZXL1vd94tee4cxWhnUV11MuuQk4vWeH1Yq6KhSzDXoJVDCsrVGvTWEbJD4WFD6c7URKAlUpw
	aEALK4bZ742/aZAOVJHENN05Ubz9Duaei3Z0tOmtm5/skh6ih/ZDxbcpSAzxsAjzojWpJNWKcWbk0
	GucHvLaQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qmFj3-000N3m-BN; Fri, 29 Sep 2023 17:48:21 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qmFj2-0009rW-RB; Fri, 29 Sep 2023 17:48:20 +0200
Subject: Re: [PATCH net-next 1/1] net/sched: Disambiguate verdict from return
 code
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, paulb@nvidia.com, netdev@vger.kernel.org,
 kernel@mojatatu.com, martin.lau@linux.dev, bpf@vger.kernel.org
References: <20230919145951.352548-1-victor@mojatatu.com>
 <beb5e6f3-e2a1-637d-e06d-247b36474e95@iogearbox.net>
 <CAM0EoMncgehpwCOxaUUKhOP7V0DyJtbDP9Q5aUkMG2h5dmfQJA@mail.gmail.com>
 <97f318a1-072d-80c2-7de7-6d0d71ca0b10@iogearbox.net>
 <CAM0EoMnPVxYA=7jn6AU7D3cJJbY5eeMLOxCrj4UJcFr=pCZ+Aw@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1df2e804-5d58-026c-5daa-413a3605c129@iogearbox.net>
Date: Fri, 29 Sep 2023 17:48:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoMnPVxYA=7jn6AU7D3cJJbY5eeMLOxCrj4UJcFr=pCZ+Aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27046/Fri Sep 29 09:41:56 2023)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/26/23 1:01 AM, Jamal Hadi Salim wrote:
> On Fri, Sep 22, 2023 at 4:12 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 9/20/23 1:20 AM, Jamal Hadi Salim wrote:
>>> On Tue, Sep 19, 2023 at 6:15 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>> On 9/19/23 4:59 PM, Victor Nogueira wrote:
[...]
>>
>> In the above case we don't have 'internal' errors which you want to trace, so I would
>> also love to avoid the cost of zeroing struct tcf_result res which should be 3x 8b for
>> every packet.
> 
> We can move the zeroing inside tc_run() but we declare it in the same
> spot as we do right now. You will still need to set res.verdict as
> above.
> Would that work for you?

What I'm not following is that with the below you can avoid the unnecessary
fast path cost (which is only for corner case which is almost never hit) and
get even better visibility. Are you saying it doesn't work?

>> I was more thinking like something below could be a better choice. I presume your main
>> goal is to trace where these errors originated in the first place, so it might even be
>> useful to capture the actual return code as well.
> 
> The main motivation is a few syzkaller bugs which resulted in not
> disambiguating between errors being returned and sometimes
> TC_ACT_SHOT.
> 
>> Then you can use perf script, bpf and whatnot to gather further insights into what
>> happened while being less invasive and avoiding the need to extend struct tcf_result.
> 
> We could use trace instead - the reason we have the skb reason is
> being used in the other spots (does this trace require ebpf to be
> usable?).

No you can just use regular perf by attaching to the tracepoint, no need for using
bpf at all here.

>> This would be quite similar to trace_xdp_exception() as well, and I think you can guarantee
>> that in fast path all errors are < TC_ACT_UNSPEC anyway.
> 
> I am not sure i followed. 0 means success, result codes are returned in res now.

What I was saying is that you don't need the struct change from the patch, but only
the changes where you rework TC_ACT_SHOT into one of the -E<errors>, and then with
the below you can pass this through an exception tracepoint.

>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 85df22f05c38..4089d195144d 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -3925,6 +3925,10 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)
>>
>>          mini_qdisc_bstats_cpu_update(miniq, skb);
>>          ret = tcf_classify(skb, miniq->block, miniq->filter_list, &res, false);
>> +       if (unlikely(ret < TC_ACT_UNSPEC)) {
>> +               trace_tc_exception(skb->dev, skb->tc_at_ingress, ret);
>> +               ret = TC_ACT_SHOT;
>> +       }
>>          /* Only tcf related quirks below. */
>>          switch (ret) {
>>          case TC_ACT_SHOT:

Thanks,
Daniel

