Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CDE526A63
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 21:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383854AbiEMT3L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 15:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383871AbiEMT2w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 15:28:52 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743AC12764
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 12:28:06 -0700 (PDT)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1npaxH-0009H6-Rr; Fri, 13 May 2022 21:28:03 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1npaxH-000BL4-Lc; Fri, 13 May 2022 21:28:03 +0200
Subject: Re: [PATCH bpf-next v4 2/6] bpf: Add verifier support for dynptrs and
 implement malloc dynptrs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <20220509224257.3222614-1-joannelkoong@gmail.com>
 <20220509224257.3222614-3-joannelkoong@gmail.com>
 <6c0d9917-fcb2-6a74-81d7-4f9421867d76@iogearbox.net>
 <CAJnrk1Zs6dVAqwbCQ1VShH+00D_EY7ePjyyhfj5UVO5zwSO7JA@mail.gmail.com>
 <b35e19c7-82ea-27fa-4fd6-50e36e64241c@iogearbox.net>
 <20220513163951.tg2nrsuwlglpxvu7@MBP-98dd607d3435.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0313e3f4-2e5b-240f-0c45-339f7b23da8b@iogearbox.net>
Date:   Fri, 13 May 2022 21:28:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220513163951.tg2nrsuwlglpxvu7@MBP-98dd607d3435.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26540/Fri May 13 10:03:59 2022)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/13/22 6:39 PM, Alexei Starovoitov wrote:
> On Fri, May 13, 2022 at 03:12:06PM +0200, Daniel Borkmann wrote:
>>
>> Thinking more about it, is there even any value for BPF_FUNC_dynptr_* for
>> fully unpriv BPF if these are rejected anyway by the spectre mitigations
>> from verifier?
> ...
>> So either for alloc, we always built-in __GFP_ZERO or bpf_dynptr_alloc()
>> helper usage should go under perfmon_capable() where it's allowed to read
>> kernel mem.
> 
> dynptr should probably by cap_bpf and cap_perfmon for now.
> Otherwise we will start adding cap_perfmon checks in run-time to helpers
> which is not easy to do. Some sort of prog or user context would need
> to be passed as hidden arg into helper. That's too much hassle just
> to enable dynptr for cap_bpf only.
> 
> Similar problem with gfp_account... remembering memcg and passing all
> the way to bpf_dynptr_alloc helper is not easy. And it's not clear
> which memcg to use. The one where task was that loaded that bpf prog?
> That task could have been gone and cgroup is in dying stage.
> bpf prog is executing some context and allocating memory for itself.
> Like kernel allocates memory for its needs. It doesn't feel right to
> charge prog's memcg in that case. It probably should be an explicit choice
> by bpf program author. Maybe in the future we can introduce a fake map
> for such accounting needs and bpf prog could pass a map pointer to
> bpf_dynptr_alloc. When such fake and empty map is created the memcg
> would be recorded the same way we do for existing normal maps.
> Then the helper will look like:
> bpf_dynptr_alloc(struct bpf_map *map, u32 size, u64 flags, struct bpf_dynptr *ptr)
> {
>    set_active_memcg(map->memcg);
>    kmalloc into dynptr;
> }
> 
> Should we do this change now and allow NULL to be passed as a map ?

Hm, this looks a bit too much like a hack, I wouldn't do that, fwiw.

> This way the bpf prog will have a choice whether to account into memcg or not.
> Maybe it's all overkill and none of this needed?
> 
> On the other side maybe map should be a mandatory argument and dynptr_alloc
> can do its own memory accounting for stats ? atomic inc and dec is probably
> an acceptable overhead? bpftool will print the dynptr allocation stats.
> All sounds nice and extra visibility is great, but the kernel code that
> allocates for the kernel doesn't use memcg. bpf progs semantically are part of
> the kernel whereas memcg is a mechanism to restrict memory that kernel
> allocated on behalf of user tasks. We abused memcg for bpf progs/maps
> to have a limit. Not clear whether we should continue doing so for dynpr_alloc
> and in the future for kptr_alloc. gfp_account adds overhead too. It's not free.
> Thoughts?

Great question, I think the memcg is useful, just that the ownership for bpf
progs/maps has been relying on current whereas current is not a real 'owner',
just the entity which did the loading.

Maybe we need some sort of memcg object for bpf where we can "bind" the prog
and map to it at load time, which is then different from current and can be
flexibly set, e.g. fd = open(/sys/fs/cgroup/memory/<foo>) and pass that fd to
BPF_PROG_LOAD and BPF_MAP_CREATE via bpf_attr (otherwise, if not set, then
no accounting)?

Thanks,
Daniel
