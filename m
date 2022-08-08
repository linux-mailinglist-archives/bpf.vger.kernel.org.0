Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90AC58CD14
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 19:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbiHHRyy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 13:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238289AbiHHRyx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 13:54:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9ABE0D2
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 10:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5D99B81026
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 17:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB72C433C1;
        Mon,  8 Aug 2022 17:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659981289;
        bh=Px4EG0PizJRP2fHajqEl/TjC66hxfaN/DN2lftCYWnk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MOrwckMoa0/98znAr1MYQ6u4ECzDOQgzgAeRxssTUh8MwKy9j6VHIMMFeabyBzhFN
         LY+64Sa6TipKKTHKdRbClblxpsHY0kC8Gg8IJPslxJTzdwTluDZ1FRhFz895202RLJ
         olAw+yMKnlPoMPPZQzaQVljHOSKtVs8ylZeJ6VptINnjO3xvGhvGSnoBCsk4SuFkMS
         F5UiJDwvVvn0gRnX+A6Y34TsMjHm7c2gw7+VqtEUAbsgfzDjuY4zaiBecFb17br6oC
         j2l/5UbYeKfnerWUPks+x16bOQo9oscbfA8jiJ8POAr85hEKOE01p8axwPiin4b99+
         eUv5HITOON8mg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 28C4850E07D; Mon,  8 Aug 2022 19:54:46 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Hou Tao <houtao1@huawei.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] Add support for qp-trie map
In-Reply-To: <CAEf4BzYdC=G0CzbiXm4gnT5EKHuGfAiFnYRyzf0nNeuAU-T4pw@mail.gmail.com>
References: <20220726130005.3102470-1-houtao1@huawei.com>
 <CAEf4BzYdC=G0CzbiXm4gnT5EKHuGfAiFnYRyzf0nNeuAU-T4pw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 08 Aug 2022 19:54:46 +0200
Message-ID: <87fsi68vtl.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Jul 26, 2022 at 5:42 AM Hou Tao <houtao1@huawei.com> wrote:
>>
>> Hi,
>>
>
> Hey, sorry I'm catching up on upstream and there is just too many
> complicated patch sets coming in, so it takes time to get through
> them.
>
> I think you did a great job with this implementation, it's certainly
> worth submitting as non-RFC for proper upstream review. I know that
> some people didn't get your patches, they got into spam somehow. So I
> think it would be great to just resubmit it as non-RFC so that it
> appears in patchworks as to-be-reviewew patches and hopefully will get
> a wider audience to review this.
>
> I've tried to answer some questions below, but would definitely like
> more people to chime in. I haven't went through implementation in
> details, but superficially it looks pretty clean and certainly ready
> for proper non-RFC review.
>
> One point about user API would be to maybe instead use bpf_dynptr as
> an interface for specifying variable-sized lookup key instead of
> hard-coded
>  bpf_qp_trie_key. Please check recent work by Joanne on bpf_dynptr.
>
> In short: looks great, I think it's certainly worth adding this as BPF
> map type. Please submit as non-RFC and go through a proper review
> process. Looking forward (even if that means reviewing 1000k lines of
> dense algorithmic code :) ).
>
>> The initial motivation for qp-trie map is to reduce memory usage for
>> string keys special those with large differencies in length as
>> discussed in [0]. And as a big-endian lexicographical ordered map, it
>> can also be used for any binary data with fixed or variable length.
>>
>> Now the basic functionality of qp-trie is ready, so posting a RFC version
>> to get more feedback or suggestions about qp-trie. Specially feedback
>> about the following questions:
>>
>> (1) Application scenario for qp-trie
>> Andrii had proposed to re-implement lpm-trie by using qp-trie. The
>> advantage would be the speed up of lookup operations due to lower tree
>> depth of qp-trie. Maybe the performance of update could also be improved
>> although in cillium there is a big lock during lpm-trie update [1]. Is
>
> Well, using qp-trie approach as an internal implementation of lpm-trie
> is probably a major win already, what's wrong with that?

+1, just improving the LPM trie map type is definitely worthwhile!

>> there any other use cases for qp-trie ? Specially those cases which need
>> both ordering and memory efficiency or cases in which jhash() of htab
>> creates too much collisions and qp-trie lookup performances better than
>> hash-table lookup as shown below:
>
> I'm thinking about qp-trie as dynamically growable lookup table.
> That's a pretty big use case already. There is an RB tree proposal
> under review right now which would also satisfy dynamically growable
> criteria, but its focus is slightly different and it remains to be
> seen how convenient it will be as general-purpose resizable
> alternative to hashmap. But from benchmarks I've found online, RB tree
> will definitely use more memory than qp-trie.
>
> Ordered property seems also very useful, but I don't yet have specific
> use case for that. But once we have data structure like this in BPF,
> I'm sure use cases will pop up.

From the various discussions of the packet queueing schemes (for both
XDP and sch_bpf), it seems some sort of ordered data structure is going
to be useful for that. Not sure this is a great fit for that use case,
but may be worth trying out. Looking harder at this is close to the top
of my list, so will play around with this series as well :)

-Toke
