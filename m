Return-Path: <bpf+bounces-4605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65CD74D734
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 15:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A495F281132
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 13:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF48E125B0;
	Mon, 10 Jul 2023 13:15:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956F911CBA;
	Mon, 10 Jul 2023 13:15:35 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAC9C4;
	Mon, 10 Jul 2023 06:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=dBaDVblR2ob/aIGjDLC09bSDFt0x2ZxnghQWoo4HwrU=; b=Le9rrslu9u0FTwx6g1/+gTUieM
	4wnFFODuxk1E5gBb/iMmQgIdAIh427QEfmtapyxEyTi/Vj0k2IVt1HUmNqNkZWrZ95UdyDBO01ZRW
	sYClG8GrTYi/HTUEsm1JovuO9uGkOQ47y2iuwIe8eB2aCQ0HFLtHapjTmqZ4UCIubuDVevN+rumyG
	xJ174VfC5gMtdrcgvz9+PdfVce7SJ6d4cM92cge3ote2HkFXujCcr3sT2rjKbdwzTxsxR8seSvV8y
	TE8RM1h6wvLdsBgAJUB1ejv9/TKTuCe0/8XYguYE6ztX26+fF6FqUpDsN1zzA6aox054nJthRakLd
	//eD/lEA==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qIqjU-0000mS-Q6; Mon, 10 Jul 2023 15:15:16 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qIqjU-000WvH-AZ; Mon, 10 Jul 2023 15:15:16 +0200
Subject: Re: [PATCH bpf-next v3 1/8] bpf: Add generic attach/detach/query API
 for multi-progs
From: Daniel Borkmann <daniel@iogearbox.net>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com,
 kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org,
 davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20230707172455.7634-1-daniel@iogearbox.net>
 <20230707172455.7634-2-daniel@iogearbox.net>
 <20230709171728.gonedzieinilrvra@MacBook-Pro-8.local>
 <305f79d1-fbe0-6a57-991c-0f79679d62d6@iogearbox.net>
Message-ID: <075ea7b6-08f3-c334-1140-e2a24669aed2@iogearbox.net>
Date: Mon, 10 Jul 2023 15:15:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <305f79d1-fbe0-6a57-991c-0f79679d62d6@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26965/Mon Jul 10 09:29:40 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/10/23 9:10 AM, Daniel Borkmann wrote:
> On 7/9/23 7:17 PM, Alexei Starovoitov wrote:
>> On Fri, Jul 07, 2023 at 07:24:48PM +0200, Daniel Borkmann wrote:
>>> +
>>> +#define BPF_MPROG_KEEP    0
>>> +#define BPF_MPROG_SWAP    1
>>> +#define BPF_MPROG_FREE    2
>>
>> Please document how this is suppose to be used.
>> Patch 2 is using BPF_MPROG_FREE in tcx_entry_needs_release().
>> Where most of the code treats BPF_MPROG_SWAP and BPF_MPROG_FREE as equivalent.
>> I can guess what it's for, but a comment would help.
> 
> Ok, sounds good, will add a comment to these codes.
> 
[...]
>> In the future, for cgroups, bpf_prog_run_array_cg() will keep explicit rcu_read_lock()
>> before accessing bpf_mprog_entry, right?
>> And bpf_mprog_commit() assumes that RCU protection.
> 
> Both yes.
> 
>> All fine, but we need to document that mprog mechanism is not suitable for sleepable progs.
> 
> Ok, I'll add a comment.

I've added this as comment for bpf_mprog.h to address the ret codes, locking
and usage example :

/*
  * bpf_mprog framework:
  * ~~~~~~~~~~~~~~~~~~~~
  *
  * bpf_mprog is a generic layer for multi-program attachment. In-kernel users
  * of the bpf_mprog don't need to care about the dependency resolution
  * internals, they can just consume it with few API calls. Currently available
  * dependency directives are BPF_F_{BEFORE,AFTER} which enable insertion of
  * a BPF program or BPF link relative to an existing BPF program or BPF link
  * inside the multi-program array as well as prepend and append behavior if
  * no relative object was specified, see corresponding selftests for concrete
  * examples (e.g. tc_links and tc_opts test cases of test_progs).
  *
  * Usage of bpf_mprog_{attach,detach,query}() core APIs with pseudo code:
  *
  *  Attach case:
  *
  *   struct bpf_mprog_entry *entry, *peer;
  *   int ret;
  *
  *   // bpf_mprog user-side lock
  *   // fetch active @entry from attach location
  *   [...]
  *   ret = bpf_mprog_attach(entry, [...]);
  *   if (ret >= 0) {
  *       peer = bpf_mprog_peer(entry);
  *       if (bpf_mprog_swap_entries(ret))
  *           // swap @entry to @peer at attach location
  *       bpf_mprog_commit(entry);
  *       ret = 0;
  *   } else {
  *       // error path, bail out, propagate @ret
  *   }
  *   // bpf_mprog user-side unlock
  *
  *  Detach case:
  *
  *   struct bpf_mprog_entry *entry, *peer;
  *   bool release;
  *   int ret;
  *
  *   // bpf_mprog user-side lock
  *   // fetch active @entry from attach location
  *   [...]
  *   ret = bpf_mprog_detach(entry, [...]);
  *   if (ret >= 0) {
  *       release = ret == BPF_MPROG_FREE;
  *       peer = release ? NULL : bpf_mprog_peer(entry);
  *       if (bpf_mprog_swap_entries(ret))
  *           // swap entry to @peer at attach location
  *       bpf_mprog_commit(entry);
  *       if (release)
  *           // free bpf_mprog_bundle
  *       ret = 0;
  *   } else {
  *       // error path, bail out, propagate @ret
  *   }
  *   // bpf_mprog user-side unlock
  *
  *  Query case:
  *
  *   struct bpf_mprog_entry *entry;
  *   int ret;
  *
  *   // bpf_mprog user-side lock
  *   // fetch active @entry from attach location
  *   [...]
  *   ret = bpf_mprog_query(attr, uattr, entry);
  *   // bpf_mprog user-side unlock
  *
  *  Data/fast path:
  *
  *   struct bpf_mprog_entry *entry;
  *   struct bpf_mprog_fp *fp;
  *   struct bpf_prog *prog;
  *   int ret = [...];
  *
  *   rcu_read_lock();
  *   // fetch active @entry from attach location
  *   [...]
  *   bpf_mprog_foreach_prog(entry, fp, prog) {
  *       ret = bpf_prog_run(prog, [...]);
  *       // process @ret from program
  *   }
  *   [...]
  *   rcu_read_unlock();
  *
  * bpf_mprog_{attach,detach}() return codes:
  *
  * Negative return code means that an error occurred and the bpf_mprog_entry
  * has not been changed. The error should be propagated to the user. A non-
  * negative return code can be one of the following:
  *
  * BPF_MPROG_KEEP:
  *   The bpf_mprog_entry does not need a/b swap, the bpf_mprog_fp item has
  *   been replaced in the current active bpf_mprog_entry.
  *
  * BPF_MPROG_SWAP:
  *   The bpf_mprog_entry does need an a/b swap and must be updated to its
  *   peer entry (peer = bpf_mprog_peer(entry)) which has been populated to
  *   the new bpf_mprog_fp item configuration.
  *
  * BPF_MPROG_FREE:
  *   The bpf_mprog_entry now does not hold any non-NULL bpf_mprog_fp items
  *   anymore. The bpf_mprog_entry should be swapped with NULL and the
  *   corresponding bpf_mprog_bundle can be freed.
  *
  * bpf_mprog locking considerations:
  *
  * bpf_mprog_{attach,detach,query}() must be protected by an external lock
  * (like RTNL in case of tcx).
  *
  * bpf_mprog_entry pointer can be an __rcu annotated pointer (in case of tcx
  * the netdevice has tcx_ingress and tcx_egress __rcu pointer) which gets
  * updated via rcu_assign_pointer() pointing to the active bpf_mprog_entry of
  * the bpf_mprog_bundle.
  *
  * Fast path accesses the active bpf_mprog_entry within RCU critical section
  * (in case of tcx it runs in NAPI which provides RCU protection there,
  * other users might need explicit rcu_read_lock()). The bpf_mprog_commit()
  * assumes that RCU protection.
  *
  * The READ_ONCE()/WRITE_ONCE() pairing for bpf_mprog_fp's prog access is for
  * the replacement case where we don't swap the bpf_mprog_entry.
  */

Hope that helps,
Daniel

