Return-Path: <bpf+bounces-13464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B813D7D9FC9
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6A51F21EA0
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 18:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD9B3C08B;
	Fri, 27 Oct 2023 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="fpZWkR5u"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72EF37C9E;
	Fri, 27 Oct 2023 18:21:49 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D0C18F;
	Fri, 27 Oct 2023 11:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=yAZ1l6ZTqmOTsSYC4pFvp359bd24Tgw1IN/gEEgk1V8=; b=fpZWkR5uq/TKb7HIsEpGHRHcnp
	V1IycfqGwcptf/0PYtqlZEDKZCo5XSOiIyXz1HFuWDhkC4OEnpVOxIP/7fBvxmzsILO5EkVSAnYQA
	IZWkhnPae4WL2VMXf6ZOWxRODM7VYH9BlBT9MB9pFjz4bcHOIop7U/WuIdalr2CWjpubajJhiPjZ6
	8oxzJVqZpsk2x2nvQxe/cbgPOJ3j3dmr/jkY9Itsk1qkfBjpXgTMgSb4WYy3HWTD598QAOpnmZsO7
	z+rO9B57pvUMxx22iQb/vaEFvxjVS6rSwr/+sDTEmzapygYpAd4vLQOVsf9CMttcUmgfTZI0gnJND
	5m4Sz0cQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qwRSm-000Nit-ML; Fri, 27 Oct 2023 20:21:40 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qwRSm-000MRw-E7; Fri, 27 Oct 2023 20:21:40 +0200
Subject: Re: [PATCH net-next] net, sched: Fix SKB_NOT_DROPPED_YET splat under
 debug config
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: kuba@kernel.org, idosch@idosch.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20231027135142.11555-1-daniel@iogearbox.net>
 <CAM0EoMm9K=jS=JZUNXo+C6qs=p=r7CtjWK20ocmTKEDxN3Bz-w@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5ab182b6-6ac7-16f7-7eae-7001be2b6da7@iogearbox.net>
Date: Fri, 27 Oct 2023 20:21:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoMm9K=jS=JZUNXo+C6qs=p=r7CtjWK20ocmTKEDxN3Bz-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27074/Fri Oct 27 09:58:36 2023)

On 10/27/23 7:24 PM, Jamal Hadi Salim wrote:
> On Fri, Oct 27, 2023 at 9:51 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> Ido reported:
>>
>>    [...] getting the following splat [1] with CONFIG_DEBUG_NET=y and this
>>    reproducer [2]. Problem seems to be that classifiers clear 'struct
>>    tcf_result::drop_reason', thereby triggering the warning in
>>    __kfree_skb_reason() due to reason being 'SKB_NOT_DROPPED_YET' (0). [...]
>>
>>    [1]
>>    WARNING: CPU: 0 PID: 181 at net/core/skbuff.c:1082 kfree_skb_reason+0x38/0x130
>>    Modules linked in:
>>    CPU: 0 PID: 181 Comm: mausezahn Not tainted 6.6.0-rc6-custom-ge43e6d9582e0 #682
>>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc37 04/01/2014
>>    RIP: 0010:kfree_skb_reason+0x38/0x130
>>    [...]
>>    Call Trace:
>>     <IRQ>
>>     __netif_receive_skb_core.constprop.0+0x837/0xdb0
>>     __netif_receive_skb_one_core+0x3c/0x70
>>     process_backlog+0x95/0x130
>>     __napi_poll+0x25/0x1b0
>>     net_rx_action+0x29b/0x310
>>     __do_softirq+0xc0/0x29b
>>     do_softirq+0x43/0x60
>>     </IRQ>
>>
>>    [2]
>>    #!/bin/bash
>>
>>    ip link add name veth0 type veth peer name veth1
>>    ip link set dev veth0 up
>>    ip link set dev veth1 up
>>    tc qdisc add dev veth1 clsact
>>    tc filter add dev veth1 ingress pref 1 proto all flower dst_mac 00:11:22:33:44:55 action drop
>>    mausezahn veth0 -a own -b 00:11:22:33:44:55 -q -c 1
>>
>> What happens is that inside most classifiers the tcf_result is copied over
>> from a filter template e.g. *res = f->res which then implicitly overrides
>> the prior SKB_DROP_REASON_TC_{INGRESS,EGRESS} default drop code which was
>> set via sch_handle_{ingress,egress}() for kfree_skb_reason().
>>
>> Add a small helper tcf_set_result() and convert classifiers over to it.
>> The latter leaves the drop code intact and classifiers, actions as well
>> as the action engine in tcf_exts_exec() can then in future make use of
>> tcf_set_drop_reason(), too.
>>
>> Tested that the splat is fixed under CONFIG_DEBUG_NET=y with the repro.
>>
>> Fixes: 54a59aed395c ("net, sched: Make tc-related drop reason more flexible")
>> Reported-by: Ido Schimmel <idosch@idosch.org>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Link: https://lore.kernel.org/netdev/ZTjY959R+AFXf3Xy@shredder
>> ---
>>   include/net/pkt_cls.h    | 12 ++++++++++++
>>   net/sched/cls_basic.c    |  2 +-
>>   net/sched/cls_bpf.c      |  2 +-
>>   net/sched/cls_flower.c   |  2 +-
>>   net/sched/cls_fw.c       |  2 +-
>>   net/sched/cls_matchall.c |  2 +-
>>   net/sched/cls_route.c    |  4 ++--
>>   net/sched/cls_u32.c      |  2 +-
>>   8 files changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
>> index a76c9171db0e..31d8e8587824 100644
>> --- a/include/net/pkt_cls.h
>> +++ b/include/net/pkt_cls.h
>> @@ -160,6 +160,18 @@ static inline void tcf_set_drop_reason(struct tcf_result *res,
>>          res->drop_reason = reason;
>>   }
>>
>> +static inline void tcf_set_result(struct tcf_result *to,
>> +                                 const struct tcf_result *from)
>> +{
>> +       /* tcf_result's drop_reason which is the last member must be
>> +        * preserved and cannot be copied from the cls'es tcf_result
>> +        * template given this is carried all the way and potentially
>> +        * set to a concrete tc drop reason upon error or intentional
>> +        * drop. See tcf_set_drop_reason() locations.
>> +        */
>> +       memcpy(to, from, offsetof(typeof(*to), drop_reason));
>> +}
> 
> I believe our bigger issue here is we are using this struct now for
> both policy set by the control plane and for runtime decisions

Hm, but that was also either way in the original rfc.

> (drop_reason) - whereas the original assumption was this struct only
> held set policy. In retrospect we should have put the verdict(which is
> policy) here and return the error code (as was in the first patch). I
> am also not sure humans would not make a mistake on "this field must
> be at the end of the struct". Can we put some assert (or big comment
> on the struct) to make sure someone does not overwrite this field?

Yeah that can be done.

> Also what happens if "from" above has a set drop_reason - is that
> lost? Do you need an assert there as well?

Why it's needed, do you have a use case for it?

> BTW: The simple patch i posted fixes the problem as well (i actually
> tested it minus the typo i sent).

It didn't compile for me, but if you think it's a better approach, yes,
feel free to post it as a proper patch then.

What I'm not quite following though is, I thought your original use case
was that you want to be able to troubleshoot drops from unexpected
locations (aka not policy) in the tc engine so won't this miss cases when
you would then want to use tcf_set_drop_reason() e.g. from tcf_action_exec()
upon 'exception' cases (like the one for example I pointed out)? With the
diff you proposed it will basically fallback to SKB_DROP_REASON_TC_{INGRESS,
EGRESS}, so override anything that would have been set from there.

Thanks,
Daniel

