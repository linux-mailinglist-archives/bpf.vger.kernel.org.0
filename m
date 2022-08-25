Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08D45A1046
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 14:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241596AbiHYMV5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 08:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241602AbiHYMVz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 08:21:55 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013ADB14E8
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 05:21:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4MD24t3dXnz9v7QS
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 20:16:30 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBXKRVJaQdjlTNLAA--.62062S2;
        Thu, 25 Aug 2022 13:21:36 +0100 (CET)
Message-ID: <d85a241583a325be9f6a6860df7bebea5e55e032.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH v3 02/15] bpf: Set open_flags as last bpf_attr
 field for bpf_*_get_fd_by_id() funcs
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "quentin@isovalent.com" <quentin@isovalent.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "jevburton.kernel@gmail.com" <jevburton.kernel@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Date:   Thu, 25 Aug 2022 14:21:25 +0200
In-Reply-To: <d3b9f2e1cb4a4fb5b5e47ea45df4be5c@huawei.com>
References: <20220722171836.2852247-1-roberto.sassu@huawei.com>
         <20220722171836.2852247-3-roberto.sassu@huawei.com>
         <20220722175528.26ve4ahnir6su5tu@macbook-pro-3.dhcp.thefacebook.com>
         <5c5cdf397a6e4523845d0a16117e3b81@huawei.com>
         <CAEf4BzYmomMAEEQYH+fGQeH-_+4oxsFYc+qbZyf1DgF1E_CuSw@mail.gmail.com>
         <d3b9f2e1cb4a4fb5b5e47ea45df4be5c@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwBXKRVJaQdjlTNLAA--.62062S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4Duw1xKw18KrW8ZFW3GFg_yoW5WF1Dpa
        97C3WYkr4qqrW7u3s0qw4rJFyFq3sYqw1UXrn5G3savryDKFn2yr40gF4YkasFkryxCrsF
        qa1UJF17Ww1DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBF1jj4JKBAAAs3
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2022-08-01 at 10:33 +0000, Roberto Sassu wrote:
> > From: Andrii Nakryiko [mailto:andrii.nakryiko@gmail.com]
> > Sent: Friday, July 29, 2022 8:49 PM
> > On Mon, Jul 25, 2022 at 12:10 AM Roberto Sassu <
> > roberto.sassu@huawei.com>
> > wrote:
> > > > From: Alexei Starovoitov [mailto:alexei.starovoitov@gmail.com]
> > > > Sent: Friday, July 22, 2022 7:55 PM
> > > > On Fri, Jul 22, 2022 at 07:18:23PM +0200, Roberto Sassu wrote:
> > > > > The bpf() system call validates the bpf_attr structure
> > > > > received as
> > > > > argument, and considers data until the last field, defined
> > > > > for each
> > > > > operation. The remaing space must be filled with zeros.
> > > > > 
> > > > > Currently, for bpf_*_get_fd_by_id() functions except
> > bpf_map_get_fd_by_id()
> > > > > the last field is *_id. Setting open_flags to BPF_F_RDONLY
> > > > > from user space
> > > > > will result in bpf() rejecting the argument.
> > > > 
> > > > The kernel is doing the right thing. It should not ignore
> > > > fields.
> > > 
> > > Exactly. As Andrii requested to add opts to all
> > > bpf_*_get_fd_by_id()
> > > functions, the last field in the kernel needs to be updated
> > > accordingly.
> > > 
> > 
> > It's been a while ago so details are hazy. But the idea was that if
> > we
> > add _opts variant for bpf_map_get_fd_by_id() for interface
> > consistency
> > all the other bpf_*_get_fd_by_id() probably should get _opts
> > variant
> > and use the same opts struct. Right now kernel doesn't support
> > specifying flags for non-maps and that's fine. I agree with Alexei
> > that kernel shouldn't just ignore unrecognized field silently.
> > 
> > I think we still can add _opts() for all APIs, but user will need
> > to
> > know that non-map variants expect 0 as flags. For now. If we
> > eventually add ability to specify flags for, say, links, then
> > existing
> > API will just work. One can see how this get_fd_by_id() can use
> > read-only flags to return FDs that only support read-only
> > operations
> > on objects (e.g., fetching link info for links, dumping prog
> > instructions for programs), but not modification operations (e.g.,
> > updating prog for links, or whatever write operation could be for
> > programs).
> > 
> > So I don't think there is contradiction here. We might choose to
> > add
> > bpf_map_get_fd_by_id_opts() only, but we probably still should use
> > common struct name as if all bpf_*_get_fd_by_id_opts() exist.
> 
> Ok, understood.

Hi Andrii

I'm about to send v4 with the suggestions you made.

Since now libbpf v1 has been released, how it works for new patches? It
seems there is not a new section in libbpf.map (kernel) new API
functions should be added to.

Also, I'm using a custom step in the CI:

https://github.com/robertosassu/libbpf-ci/commit/7743eb92f81f95355571c07e5b7082a9a2b0bfe0

Do you want me to create a new PR before sending the patch set?

Thanks

Roberto

