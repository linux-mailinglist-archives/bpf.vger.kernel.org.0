Return-Path: <bpf+bounces-9037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4200C78E9C0
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 11:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD9028147C
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 09:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F087E8C10;
	Thu, 31 Aug 2023 09:46:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA78379F8;
	Thu, 31 Aug 2023 09:46:08 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061B3E49;
	Thu, 31 Aug 2023 02:46:05 -0700 (PDT)
Received: from kwepemd100003.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rbx5r4VgczNmtb;
	Thu, 31 Aug 2023 17:42:24 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemd100003.china.huawei.com (7.221.188.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Thu, 31 Aug 2023 17:46:01 +0800
Message-ID: <23cd4ce0-0360-e3c6-6cc9-f597aefb2ab5@huawei.com>
Date: Thu, 31 Aug 2023 17:46:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [BUG bpf-next] bpf/net: Hitting gpf when running selftests
Content-Language: en-US
To: Jiri Olsa <olsajiri@gmail.com>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Martin KaFai Lau
	<kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Hou Tao
	<houtao1@huawei.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>
References: <ZO+RQwJhPhYcNGAi@krava> <ZO+vetPCpOOCGitL@krava>
From: Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <ZO+vetPCpOOCGitL@krava>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100003.china.huawei.com (7.221.188.180)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/31/2023 5:07 AM, Jiri Olsa wrote:
> On Wed, Aug 30, 2023 at 08:58:11PM +0200, Jiri Olsa wrote:
>> hi,
>> I'm hitting crash below on bpf-next/master when running selftests,
>> full log and config attached
> 
> it seems to be 'test_progs -t sockmap_listen' triggering that
> 
> jirka
> 
>>
>> jirka
>>
>>
>> ---
>> [ 1022.710250][ T2556] general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b73: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC NOPTI^M
>> [ 1022.711206][ T2556] CPU: 2 PID: 2556 Comm: kworker/2:4 Tainted: G           OE      6.5.0+ #693 1723c8b9805ff5a1672ab7e6f25977078a7bcceb^M
>> [ 1022.712120][ T2556] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014^M
>> [ 1022.712830][ T2556] Workqueue: events sk_psock_backlog^M
>> [ 1022.713262][ T2556] RIP: 0010:skb_dequeue+0x4c/0x80^M
>> [ 1022.713653][ T2556] Code: 41 48 85 ed 74 3c 8b 43 10 4c 89 e7 83 e8 01 89 43 10 48 8b 45 08 48 8b 55 00 48 c7 45 08 00 00 00 00 48 c7 45 00 00 00 00 00 <48> 89 42 08 48 89 10 e8 e8 6a 41 00 48 89 e8 5b 5d 41 5c c3 cc cc^M
>> [ 1022.714963][ T2556] RSP: 0018:ffffc90003ca7dd0 EFLAGS: 00010046^M
>> [ 1022.715431][ T2556] RAX: 6b6b6b6b6b6b6b6b RBX: ffff88811de269d0 RCX: 0000000000000000^M
>> [ 1022.716068][ T2556] RDX: 6b6b6b6b6b6b6b6b RSI: 0000000000000282 RDI: ffff88811de269e8^M
>> [ 1022.716676][ T2556] RBP: ffff888141ae39c0 R08: 0000000000000001 R09: 0000000000000000^M
>> [ 1022.717283][ T2556] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88811de269e8^M
>> [ 1022.717930][ T2556] R13: 0000000000000001 R14: ffff888141ae39c0 R15: ffff88810a20e640^M
>> [ 1022.718549][ T2556] FS:  0000000000000000(0000) GS:ffff88846d600000(0000) knlGS:0000000000000000^M
>> [ 1022.719241][ T2556] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
>> [ 1022.719761][ T2556] CR2: 00007fb5c25ca000 CR3: 000000012b902004 CR4: 0000000000770ee0^M
>> [ 1022.720394][ T2556] PKRU: 55555554^M
>> [ 1022.720699][ T2556] Call Trace:^M
>> [ 1022.720984][ T2556]  <TASK>^M
>> [ 1022.721254][ T2556]  ? die_addr+0x32/0x80^M
>> [ 1022.721589][ T2556]  ? exc_general_protection+0x25a/0x4b0^M
>> [ 1022.722026][ T2556]  ? asm_exc_general_protection+0x22/0x30^M
>> [ 1022.722489][ T2556]  ? skb_dequeue+0x4c/0x80^M
>> [ 1022.722854][ T2556]  sk_psock_backlog+0x27a/0x300^M
>> [ 1022.723243][ T2556]  process_one_work+0x2a7/0x5b0^M
>> [ 1022.723633][ T2556]  worker_thread+0x4f/0x3a0^M
>> [ 1022.723998][ T2556]  ? __pfx_worker_thread+0x10/0x10^M
>> [ 1022.724386][ T2556]  kthread+0xfd/0x130^M
>> [ 1022.724709][ T2556]  ? __pfx_kthread+0x10/0x10^M
>> [ 1022.725066][ T2556]  ret_from_fork+0x2d/0x50^M
>> [ 1022.725409][ T2556]  ? __pfx_kthread+0x10/0x10^M
>> [ 1022.725799][ T2556]  ret_from_fork_asm+0x1b/0x30^M
>> [ 1022.726201][ T2556]  </TASK>^M
> 
> 
> .

My patch failed on the BPF CI, and the log shows the test also died in skb_dequeue:

https://github.com/kernel-patches/bpf/actions/runs/6031993528/job/16366782122

[...]

   [   74.396478]  ? __die_body+0x1f/0x70
   [   74.396700]  ? page_fault_oops+0x15b/0x450
   [   74.396957]  ? fixup_exception+0x26/0x330
   [   74.397211]  ? exc_page_fault+0x68/0x1a0
   [   74.397457]  ? asm_exc_page_fault+0x26/0x30
   [   74.397724]  ? skb_dequeue+0x52/0x90
   [   74.397954]  sk_psock_destroy+0x8c/0x2b0
   [   74.398204]  process_one_work+0x28a/0x550
   [   74.398458]  ? __pfx_worker_thread+0x10/0x10
   [   74.398730]  worker_thread+0x51/0x3c0
   [   74.398966]  ? __pfx_worker_thread+0x10/0x10
   [   74.399235]  kthread+0xf7/0x130
   [   74.399437]  ? __pfx_kthread+0x10/0x10
   [   74.399707]  ret_from_fork+0x34/0x50
   [   74.399967]  ? __pfx_kthread+0x10/0x10
   [   74.400234]  ret_from_fork_asm+0x1b/0x30


After a few tries, I found a way to reproduce the problem.

Here is the reproduce steps:

1. create a kprobe to delay sk_psock_backlog:

static struct kprobe kp = {
         .symbol_name = "sk_psock_backlog",
         .offset = 0x00,
};

static int handler_pre(struct kprobe *p, struct pt_regs *regs)
{
         mdelay(1000);
         return 0;
}

static int __init kprobe_init(void)
{
         int ret;

         kp.pre_handler = handler_pre;

         ret = register_kprobe(&kp);
         if (ret < 0) {
                 return -1;
         }

         return 0;
}

2. insert the kprobe and run the vsock sockmap test:

./test_progs -t "sockmap_listen/sockmap VSOCK test_vsock_redir"



I guess the problem is in sk_psock_backlog, where skb is inserted to another
list before skb_dequeue is called.

So I tested it with the following changes, and found the problem did go away.

--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -648,7 +648,7 @@ static void sk_psock_backlog(struct work_struct *work)
                 off = state->off;
         }

-       while ((skb = skb_peek(&psock->ingress_skb))) {
+       while ((skb = skb_dequeue(&psock->ingress_skb))) {
                 len = skb->len;
                 off = 0;
                 if (skb_bpf_strparser(skb)) {
@@ -684,7 +684,6 @@ static void sk_psock_backlog(struct work_struct *work)
                         len -= ret;
                 } while (len);

-               skb = skb_dequeue(&psock->ingress_skb);
                 if (!ingress) {
                         kfree_skb(skb);
                 }

Not clear what exactly happened, needs more debugging.

