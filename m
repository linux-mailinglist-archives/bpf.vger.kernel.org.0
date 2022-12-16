Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D2364EDCD
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 16:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiLPPYk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 10:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLPPYi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 10:24:38 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FC9532E9;
        Fri, 16 Dec 2022 07:24:37 -0800 (PST)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1p6CZc-0006Fh-LT; Fri, 16 Dec 2022 16:24:32 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1p6CZc-0004I2-6M; Fri, 16 Dec 2022 16:24:32 +0100
Subject: Re: [PATCH bpf-next] bpf: dup xlated insns with kvmalloc+memcpy
To:     Hao Sun <sunhao.th@gmail.com>, Yonghong Song <yhs@meta.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, jolsa@kernel.org,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20221216055436.4698-1-sunhao.th@gmail.com>
 <fa3c59e3-da85-aec3-d7bb-6360c842042c@meta.com>
 <6523CED9-3532-40CB-8B50-5C137555E58E@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7d274284-0fcc-061c-582e-3dfb629c6a44@iogearbox.net>
Date:   Fri, 16 Dec 2022 16:24:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <6523CED9-3532-40CB-8B50-5C137555E58E@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26752/Fri Dec 16 09:25:27 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/16/22 8:18 AM, Hao Sun wrote:
> 
> 
>> On 16 Dec 2022, at 3:03 PM, Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 12/15/22 9:54 PM, Hao Sun wrote:
>>> Currently, kmemdup() is used for allocating and copying xlated insns
>>> in bpf_insn_prepare_dump(). The following warning can be triggered
>>> when dup large amount of insns (roughly BPF_COMPLEXITY_LIMIT_INSNS/2)
>>> because kmemdup() uses kmalloc() which would fail when allocing size
>>> is too big, leading to failure in dump xlated insns:
>>> WARNING: CPU: 2 PID: 7060 at mm/page_alloc.c:5534
>>> Call Trace:
>>>   <TASK>
>>>   __alloc_pages_node include/linux/gfp.h:237 [inline]
>>>   alloc_pages_node include/linux/gfp.h:260 [inline]
>>>   __kmalloc_large_node+0x81/0x160 mm/slab_common.c:1096
>>>   __do_kmalloc_node mm/slab_common.c:943 [inline]
>>>   __kmalloc_node_track_caller.cold+0x5/0x5d mm/slab_common.c:975
>>>   kmemdup+0x29/0x60 mm/util.c:129
>>>   kmemdup include/linux/fortify-string.h:585 [inline]
>>>   bpf_insn_prepare_dump kernel/bpf/syscall.c:3820 [inline]
>>>   bpf_prog_get_info_by_fd+0x9a3/0x2cb0 kernel/bpf/syscall.c:3975
>>>   bpf_obj_get_info_by_fd kernel/bpf/syscall.c:4297 [inline]
>>>   __sys_bpf+0x3928/0x56f0 kernel/bpf/syscall.c:5004
>>>   __do_sys_bpf kernel/bpf/syscall.c:5069 [inline]
>>>   __se_sys_bpf kernel/bpf/syscall.c:5067 [inline]
>>>   ...
>>> So use kvmalloc()+memcpy() to fix this, for small size of insns,
>>> this is same as kmemdup(), but this also support dup large amount
>>> of xlated insns.
>>> Signed-off-by: Hao Sun <sunhao.th@gmail.com>
>>> ---
>>>   kernel/bpf/syscall.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> index 35972afb6850..06229fddac0d 100644
>>> --- a/kernel/bpf/syscall.c
>>> +++ b/kernel/bpf/syscall.c
>>> @@ -3831,10 +3831,10 @@ static struct bpf_insn *bpf_insn_prepare_dump(const struct bpf_prog *prog,
>>>    u8 code;
>>>    int i;
>>>   - insns = kmemdup(prog->insnsi, bpf_prog_insn_size(prog),
>>> - GFP_USER);
>>
>> Does kmemdup(prog->insnsi, bpf_prog_insn_size(prog), GFP_USER | __GFP_NOWARN) work?
> 
> This only suppress the warning, bpf_insn_prepare_dump() still fails because of
> the failure of kmalloc() invoked by kmemdup().

Ok, instead of open coding, would be nice if we add a helper to mm/util.c :

void *kvmemdup(const void *src, size_t len, gfp_t gfp)
{
         void *p;

         p = kvmalloc(len, gfp);
         if (p)
                 memcpy(p, src, len);
         return p;
}
EXPORT_SYMBOL(kvmemdup);

And then bpf and in future others could make use of it.

Thanks,
Daniel
