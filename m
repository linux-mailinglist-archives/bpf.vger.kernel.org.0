Return-Path: <bpf+bounces-4573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4A374CE03
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 09:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154E41C208B7
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 07:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D1D53BE;
	Mon, 10 Jul 2023 07:11:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9253E5239;
	Mon, 10 Jul 2023 07:11:07 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9603E18F;
	Mon, 10 Jul 2023 00:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=p1CaBzrQyFh3svsFkQa5RwFTYENMw7vRJmgDg1HYKHE=; b=dyPkNHtj/Fh4Xd+0diddGFbzle
	LDTUSjg3Yc51j22Hx1q16MkuwpjQ4tjQVfy/ZE3EbnlDSrTX0o9mNkzqq4fmY1xhBDg1gZrJ2xHBI
	rGW+5JYbrDag6hF3S6TyXRmSElbYI+PfBe6mjLjRtLsgZp25MMabG80hpQVzuWgWfgBvrrc4BxpxJ
	6kcKeAu2Bjh839RHO5VDNnFarZhUknwoigBOBxmZVsU6fXk9yZY5V00z0XPk9obtUfCfM/kWUZlus
	WzLkD7j++QCnsF1+dUo1/FL+IianVd6Ec2oxi8+jVQ8Zc2UBHKQAsAis1xHPwYSCVqtysSmt0PU11
	9y0QvhPw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qIl2s-000NNZ-C7; Mon, 10 Jul 2023 09:10:54 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qIl2r-0008rP-Q8; Mon, 10 Jul 2023 09:10:53 +0200
Subject: Re: [PATCH bpf-next v3 1/8] bpf: Add generic attach/detach/query API
 for multi-progs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com,
 kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org,
 davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20230707172455.7634-1-daniel@iogearbox.net>
 <20230707172455.7634-2-daniel@iogearbox.net>
 <20230709171728.gonedzieinilrvra@MacBook-Pro-8.local>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <305f79d1-fbe0-6a57-991c-0f79679d62d6@iogearbox.net>
Date: Mon, 10 Jul 2023 09:10:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230709171728.gonedzieinilrvra@MacBook-Pro-8.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26964/Sun Jul  9 09:27:43 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/9/23 7:17 PM, Alexei Starovoitov wrote:
> On Fri, Jul 07, 2023 at 07:24:48PM +0200, Daniel Borkmann wrote:
>> +
>> +#define BPF_MPROG_KEEP	0
>> +#define BPF_MPROG_SWAP	1
>> +#define BPF_MPROG_FREE	2
> 
> Please document how this is suppose to be used.
> Patch 2 is using BPF_MPROG_FREE in tcx_entry_needs_release().
> Where most of the code treats BPF_MPROG_SWAP and BPF_MPROG_FREE as equivalent.
> I can guess what it's for, but a comment would help.

Ok, sounds good, will add a comment to these codes.

>> +#define BPF_MPROG_MAX	64
> 
> we've seen buggy user space attaching thousands of tc progs to the same netdev.
> I suspect 64 limit will be hit much sooner than expected.

In that sense it's probably good that we'll bail out rather than draining memory
as you had with the cls_bpf case, iirc. As I mentioned given this is not uapi, we
can adapt this further in future when needed if you have cases where you attach
more than 64 progs for a single device.

>> +#define bpf_mprog_foreach_tuple(entry, fp, cp, t)			\
>> +	for (fp = &entry->fp_items[0], cp = &entry->parent->cp_items[0];\
>> +	     ({								\
>> +		t.prog = READ_ONCE(fp->prog);				\
>> +		t.link = cp->link;					\
>> +		t.prog;							\
>> +	      });							\
>> +	     fp++, cp++)
>> +
>> +#define bpf_mprog_foreach_prog(entry, fp, p)				\
>> +	for (fp = &entry->fp_items[0];					\
>> +	     (p = READ_ONCE(fp->prog));					\
>> +	     fp++)
> 
> I have similar questions to Stanislav.

The READ_ONCE/WRITE_ONCE is for the replacement case where we don't need to swap
the whole array, so I annotated all access to fp->prog.

> Looks like update/delete/query of bpf_prog should be protected by an external lock
> (like RTNL in case of tcx),

Correct for tcx it's rtnl, other users also either have to piggyback on existing
locking or need their own.

> but what are the life time rules for 'entry'?
> Looking at patch 2 sch_handle_ingress():
> struct bpf_mprog_entry *entry = rcu_dereference_bh(skb->dev->tcx_ingress);
> I suspect the assumption is that bpf_mprog_entry object should be accessed within
> RCU critical section. Since tc/tcx and XDP run in napi we have RCU protection there.

Correct.

> In the future, for cgroups, bpf_prog_run_array_cg() will keep explicit rcu_read_lock()
> before accessing bpf_mprog_entry, right?
> And bpf_mprog_commit() assumes that RCU protection.

Both yes.

> All fine, but we need to document that mprog mechanism is not suitable for sleepable progs.

Ok, I'll add a comment.

>> +	if (flags & BPF_F_BEFORE) {
>> +		tidx = bpf_mprog_pos_before(entry, &rtuple);
>> +		if (tidx < -1 || (idx >= -1 && tidx != idx)) {
>> +			ret = tidx < -1 ? tidx : -EDOM;
>> +			goto out;
>> +		}
>> +		idx = tidx;
>> +	}
>> +	if (flags & BPF_F_AFTER) {
>> +		tidx = bpf_mprog_pos_after(entry, &rtuple);
>> +		if (tidx < 0 || (idx >= -1 && tidx != idx)) {
> 
> tidx < 0 vs tidx < -1 for _after vs _before.
> Does it have to have this subtle difference?
> Can _after and _before have the same semantics for return value?

Yes, they can. In 'after' tidx will never be -1, but I can adapt the condition
so it's the same for the two to avoid confusion.

>> +			ret = tidx < 0 ? tidx : -EDOM;
>> +			goto out;
>> +		}
>> +		idx = tidx;
>> +	}
> 


