Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143F359549C
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 10:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiHPIJg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 04:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiHPIIt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 04:08:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E05211CF17
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 22:34:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id qn6so16916343ejc.11
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 22:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=U9FyCEb+d2Cxmr7ZScxUpqzvM5Hx9INkVaoDX1iT5jQ=;
        b=iyoeX39Fcx4CJUJMP+dKz5UrwGbcAHumIt+m3vn2wb6D98eSRlc8isIt9p1o/bXOUA
         Dfce/ppkXNDd02mti95iS99J4I6E2AOMnAMS20f3JwcTHOcNN2pZdEjZFFjdntIOk/sv
         bwvJdWXcLKuFGjX9SEiVYjnxulZZz/AjEI1/MrfiaJbD8FEbeL3mJGTUYtVsmUg6usMa
         XpWk+usoG2zS5pq8wcAhISpHVl5Z2i92aJ8TUDKGC/dMJFdBSe5XvFuO+ujvtyW4cpuC
         y2JI+EH2KwzqAAI3ZjCcSn6YDlfQ/nQzPo7WrXEh4o2kguSrNuGIVJ14OI1GXkDk19PT
         csIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=U9FyCEb+d2Cxmr7ZScxUpqzvM5Hx9INkVaoDX1iT5jQ=;
        b=lOY5XArq78BSGrJ/mzhnMPApvL3ry/ygqPpW4tDaWNYvHSkqRM5eDoZkqqCRcPZ/Qy
         oFIuaGv130MiZN8RDIm8B5JCCrlheBGXY4tOUpQAN0sNzf+8liJcxuxJcZz2CqSGDr8R
         QZElZu/VkmqLGg71cp2xocyBPM32dgZ14VgyHoibDUp35/3qv2FWdm3WsAI/aTqCmj7x
         hZr0oTiZ87/cBrrNPrpKZSppEzW65QbPZZk+KWylh9OAYA9OqDg+laZ+rfkMTAoO8w6V
         BHjeerbjErhRKi7YIK8+7bJKGhg7xtMmtmVlDDyq5gz1pGBiSXrUC8DeDIghBI8AJw/V
         EVoQ==
X-Gm-Message-State: ACgBeo1zsdzIhfLHCDh/p/c8Xld7TZZTlJOdRgp8tcCUr0HkWANQa/k3
        noRAm6epR3L0rjuD9J8BJqWXJsYdrq+YVDMBKcY=
X-Google-Smtp-Source: AA6agR5CNhoSYBvIDwx0uDNNudq7miHo8+HHPEbO9oM+tFjgU06FXOYbLw/9ucNauU7hCaRj2KRJzxs9dOjMeZoNKFA=
X-Received: by 2002:a17:907:6890:b0:731:41a9:bb03 with SMTP id
 qy16-20020a170907689000b0073141a9bb03mr12109949ejc.302.1660628041935; Mon, 15
 Aug 2022 22:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220726130005.3102470-1-houtao1@huawei.com> <CAEf4BzYdC=G0CzbiXm4gnT5EKHuGfAiFnYRyzf0nNeuAU-T4pw@mail.gmail.com>
 <1efd3943-4068-24ab-dd57-e42b5958106c@huaweicloud.com>
In-Reply-To: <1efd3943-4068-24ab-dd57-e42b5958106c@huaweicloud.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 15 Aug 2022 22:33:50 -0700
Message-ID: <CAEf4BzY7kS4qPQ-z-PuVrmgoVp763Rn+Dov+QZGF8T7-UPtCsA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] Add support for qp-trie map
To:     houtao <houtao@huaweicloud.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
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
        Joanne Koong <joannelkoong@gmail.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 9, 2022 at 1:25 AM houtao <houtao@huaweicloud.com> wrote:
>
> Hi,
>
> On 8/3/2022 6:38 AM, Andrii Nakryiko wrote:
> > On Tue, Jul 26, 2022 at 5:42 AM Hou Tao <houtao1@huawei.com> wrote:
> >> Hi,
> >>
> > Hey, sorry I'm catching up on upstream and there is just too many
> > complicated patch sets coming in, so it takes time to get through
> > them.
> >
> > I think you did a great job with this implementation, it's certainly
> > worth submitting as non-RFC for proper upstream review. I know that
> > some people didn't get your patches, they got into spam somehow. So I
> > think it would be great to just resubmit it as non-RFC so that it
> > appears in patchworks as to-be-reviewew patches and hopefully will get
> > a wider audience to review this.
> Thanks for your encouragement.
> The spam email is due to some misconfiguration in email servers of our co=
mpany,
> but it can not be fixed soon, so I change to use another email account an=
d hope
> that will fix the spam problem.
>
> > I've tried to answer some questions below, but would definitely like
> > more people to chime in. I haven't went through implementation in
> > details, but superficially it looks pretty clean and certainly ready
> > for proper non-RFC review.
> >
> > One point about user API would be to maybe instead use bpf_dynptr as
> > an interface for specifying variable-sized lookup key instead of
> > hard-coded
> >  bpf_qp_trie_key. Please check recent work by Joanne on bpf_dynptr.
> Will check how to archive that. Does that means we will have real
> variable-length key instead of fixed-allocated-length key with
> variable-used-length ?

Yes, check bpf_dynptr patches. We are still working on expanding
bpf_dynptr use cases and API, but all the pieces needed for
variable-sized keys are already in place.

> > In short: looks great, I think it's certainly worth adding this as BPF
> > map type. Please submit as non-RFC and go through a proper review
> > process. Looking forward (even if that means reviewing 1000k lines of
> > dense algorithmic code :) ).
> Thanks. :)
> >> The initial motivation for qp-trie map is to reduce memory usage for
> >> string keys special those with large differencies in length as
> >> discussed in [0]. And as a big-endian lexicographical ordered map, it
> >> can also be used for any binary data with fixed or variable length.
> >>
> >> Now the basic functionality of qp-trie is ready, so posting a RFC vers=
ion
> >> to get more feedback or suggestions about qp-trie. Specially feedback
> >> about the following questions:
> >>
> >> (1) Application scenario for qp-trie
> >> Andrii had proposed to re-implement lpm-trie by using qp-trie. The
> >> advantage would be the speed up of lookup operations due to lower tree
> >> depth of qp-trie. Maybe the performance of update could also be improv=
ed
> >> although in cillium there is a big lock during lpm-trie update [1]. Is
> > Well, using qp-trie approach as an internal implementation of lpm-trie
> > is probably a major win already, what's wrong with that?
> I am OK with that. My concern is that you had mentioned that qp-trie coul=
d be
> used to remove the global lock in lpm-trie, but now there are still subtr=
ee
> locks in qp-trie, so I am not sure whether the scalability of qp-trie is =
still a
> problem. I had searched users of lpm-trie in github and only found Cilium=
. In
> its source code [0], the update and deletion procedure of lpm-trie are pr=
otected
> by a big lock, so may be the global lock is not a big issue right now.
>

I think typically users just stay away from lpm-trie due to its
slowness. Once this is addressed, we'll have more use cases, as the
semantics of this BPF map is useful in a bunch of practical use cases.
So yes, it's very much an issue, overall.

> [0]:
> https://github.com/cilium/cilium/blob/5145e31cd65db3361f6538d5f5f899440b7=
69070/pkg/datapath/prefilter/prefilter.go#L123
> >> there any other use cases for qp-trie ? Specially those cases which ne=
ed
> >> both ordering and memory efficiency or cases in which jhash() of htab
> >> creates too much collisions and qp-trie lookup performances better tha=
n
> >> hash-table lookup as shown below:
> > I'm thinking about qp-trie as dynamically growable lookup table.
> > That's a pretty big use case already. There is an RB tree proposal
> > under review right now which would also satisfy dynamically growable
> > criteria, but its focus is slightly different and it remains to be
> > seen how convenient it will be as general-purpose resizable
> > alternative to hashmap. But from benchmarks I've found online, RB tree
> > will definitely use more memory than qp-trie.
> qp-trie is also RCU-read safe which is hard for rb-tree to archive. I als=
o hope
> qp-trie will have better lookup performance than rb-tree.
> > Ordered property seems also very useful, but I don't yet have specific
> > use case for that. But once we have data structure like this in BPF,
> > I'm sure use cases will pop up.
> For ordered map, next() and prev() helpers will be useful, but now these =
is no
> such support. Embedded rb_node in program-defined structure may make it e=
asier
> to implement such helpers. Maybe we can also add such helpers for qp-trie=
 in the
> next-step ?
>

See bpf_for_each_map_elem() helper, we already have ability to iterate
BPF map elements in *some* order, but in this case for qp-trie those
elements will be guaranteed to be in sorted order.

> >>   Randomly-generated binary data with variable length (length range=3D=
[1, 256] entries=3D16K)
> >>
> >>   htab lookup      (1  thread)    5.062 =C2=B1 0.004M/s (drops 0.002 =
=C2=B1 0.000M/s mem 8.125 MiB)
> >>   htab lookup      (2  thread)   10.256 =C2=B1 0.017M/s (drops 0.006 =
=C2=B1 0.000M/s mem 8.114 MiB)
> >>   htab lookup      (4  thread)   20.383 =C2=B1 0.006M/s (drops 0.009 =
=C2=B1 0.000M/s mem 8.117 MiB)
> >>   htab lookup      (8  thread)   40.727 =C2=B1 0.093M/s (drops 0.010 =
=C2=B1 0.000M/s mem 8.123 MiB)
> >>   htab lookup      (16 thread)   81.333 =C2=B1 0.311M/s (drops 0.020 =
=C2=B1 0.000M/s mem 8.122 MiB)
> >>
> >>   qp-trie lookup   (1  thread)   10.161 =C2=B1 0.008M/s (drops 0.006 =
=C2=B1 0.000M/s mem 4.847 MiB)
> >>   qp-trie lookup   (2  thread)   20.287 =C2=B1 0.024M/s (drops 0.007 =
=C2=B1 0.000M/s mem 4.828 MiB)
> >>   qp-trie lookup   (4  thread)   40.784 =C2=B1 0.020M/s (drops 0.015 =
=C2=B1 0.000M/s mem 4.071 MiB)
> >>   qp-trie lookup   (8  thread)   81.165 =C2=B1 0.013M/s (drops 0.040 =
=C2=B1 0.000M/s mem 4.045 MiB)
> >>   qp-trie lookup   (16 thread)  159.955 =C2=B1 0.014M/s (drops 0.108 =
=C2=B1 0.000M/s mem 4.495 MiB)
> >>
> > Kind of surprised that qp-tire is twice as fast as hashmap. Do you
> > have any idea why hashmap is slower? Was htab pre-allocated? What was
> > it's max_entries?
> The hash table is not pre-allocated and pre-allocation doesn't help for l=
ookup
> performance in the benchmark. max_entries is 16K, and if set max_entries =
to 4K
> or 128K, the performance win of qp-trie is almost the same (worse when da=
ta set
> is bigger).
>
> The better performance is due to two reasons:
> (1) height of qp-trie is low due to the randomly-generated data
> The top-most branch nodes in qp-trie are almost full and have 16 or 17 ch=
ild
> nodes. If using /proc/kallsyms as input data set, the number of child nod=
es of
> top-most branch nodes are just about 2~4.
>

right, makes sense, dense data with high branching factor is best
scenario for trie-based data structures

> (2) large difference between used length of key
> The max key size is 256, but the range of valid data length is [1, 255] a=
nd the
> unused part is zeroed. For htab-lookup, it has to compare 256 bytes each =
time
> during list traverse, but qp-trie only needs to compare the used length o=
f key.

yep, makes sense as well

>
> >>   * non-zero drops is due to duplicated keys in generated keys.
> >>
> >> (2) more fine-grained lock in qp-trie
> >> Now qp-trie is divided into 256 sub-trees by using the first character=
 of
> > character -> byte, it's not always strings, right?
> Yes, qp-trie supports arbitrary bytes array as the key.
> >> key and one sub-tree is protected one spinlock. From the data below,
> >> although the update/delete speed of qp-trie is slower compare with has=
h
> >> table, but it scales similar with hash table. So maybe 256-locks is a
> >> good enough solution ?
> >>
> >>   Strings in /proc/kallsyms
> >>   htab update      (1  thread)    2.850 =C2=B1 0.129M/s (drops 0.000 =
=C2=B1 0.000M/s mem 33.564 MiB)
> >>   htab update      (2  thread)    4.363 =C2=B1 0.031M/s (drops 0.000 =
=C2=B1 0.000M/s mem 33.563 MiB)
> >>   htab update      (4  thread)    6.306 =C2=B1 0.096M/s (drops 0.000 =
=C2=B1 0.000M/s mem 33.718 MiB)
> >>   htab update      (8  thread)    6.611 =C2=B1 0.026M/s (drops 0.000 =
=C2=B1 0.000M/s mem 33.627 MiB)
> >>   htab update      (16 thread)    6.390 =C2=B1 0.015M/s (drops 0.000 =
=C2=B1 0.000M/s mem 33.564 MiB)
> >>   qp-trie update   (1  thread)    1.157 =C2=B1 0.099M/s (drops 0.000 =
=C2=B1 0.000M/s mem 18.333 MiB)
> >>   qp-trie update   (2  thread)    1.920 =C2=B1 0.062M/s (drops 0.000 =
=C2=B1 0.000M/s mem 18.293 MiB)
> >>   qp-trie update   (4  thread)    2.630 =C2=B1 0.050M/s (drops 0.000 =
=C2=B1 0.000M/s mem 18.472 MiB)
> >>   qp-trie update   (8  thread)    3.171 =C2=B1 0.027M/s (drops 0.000 =
=C2=B1 0.000M/s mem 18.301 MiB)
> >>   qp-trie update   (16 thread)    3.782 =C2=B1 0.036M/s (drops 0.000 =
=C2=B1 0.000M/s mem 19.040 MiB)
> > qp-trie being slower than htab matches my expectation and what I
> > observed when trying to use qp-trie with libbpf. But I think for a lot
> > of cases memory vs CPU tradeoff, coupled with ability to dynamically
> > grow qp-trie will make this data structure worthwhile.
> >
> >
> >> (3) Improve memory efficiency further
> >> When using strings in BTF string section as a data set for qp-trie, th=
e
> >> slab memory usage showed in cgroup memory.stats file is about 11MB for
> >> qp-trie and 15MB for hash table as shown below. However the theoretica=
l
> >> memory usage for qp-trie is ~6.8MB (is ~4.9MB if removing "parent" & "=
rcu"
> >> fields from qp_trie_branch) and the extra memory usage (about 38% of t=
otal
> >> usage) mainly comes from internal fragment in slab (namely 2^n alignme=
nt
> >> for allocation) and overhead in kmem-cgroup accounting. We can reduce =
the
> >> internal fragment by creating separated kmem_cache for qp_trie_branch =
with
> >> different child nodes, but not sure whether it is worthy or not.
> >>
> > Please CC Paul McKenney (paulmck@kernel.org) for your non-RFC patch
> > set and maybe he has some good idea how to avoid having rcu_head in
> > each leaf node. Maybe some sort of per-CPU queue of to-be-rcu-freed
> > elements, so that we don't have to keep 16 bytes in each leaf and
> > branch node?
> Will cc Paul. I found a head-less kfree_rcu() which only needs a pointer,=
 but
> its downside is the calling context needs to sleepable, so it doesn't fit=
. And
> it seems that BPF specific memory allocator from Alexei can also help to =
remove
> rcu_head in bpf map element, right ?

Hm.. don't know, maybe?

> >> And in order to prevent allocating a rcu_head for each leaf node, now =
only
> >> branch node is RCU-freed, so when replacing a leaf node, a new branch =
node
> >> and a new leaf node will be allocated instead of replacing the old lea=
f
> >> node and RCU-freed the old leaf node. Also not sure whether or not it =
is
> >> worthy.
> >>
> >>   Strings in BTF string section (entries=3D115980):
> >>   htab lookup      (1  thread)    9.889 =C2=B1 0.006M/s (drops 0.000 =
=C2=B1 0.000M/s mem 15.069 MiB)
> >>   qp-trie lookup   (1  thread)    5.132 =C2=B1 0.002M/s (drops 0.000 =
=C2=B1 0.000M/s mem 10.721 MiB)
> >>
> >>   All files under linux kernel source directory (entries=3D74359):
> >>   htab lookup      (1  thread)    8.418 =C2=B1 0.077M/s (drops 0.000 =
=C2=B1 0.000M/s mem 14.207 MiB)
> >>   qp-trie lookup   (1  thread)    4.966 =C2=B1 0.003M/s (drops 0.000 =
=C2=B1 0.000M/s mem 9.355 MiB)
> >>
> >>   Domain names for Alexa top million web site (entries=3D1000000):
> >>   htab lookup      (1  thread)    4.551 =C2=B1 0.043M/s (drops 0.000 =
=C2=B1 0.000M/s mem 190.761 MiB)
> >>   qp-trie lookup   (1  thread)    2.804 =C2=B1 0.017M/s (drops 0.000 =
=C2=B1 0.000M/s mem 83.194 MiB)
> >>
> >> Comments and suggestions are always welcome.
> >>
> >> Regards,
> >> Tao
> >>
> >> [0]: https://lore.kernel.org/bpf/CAEf4Bzb7keBS8vXgV5JZzwgNGgMV0X3_guQ_=
m9JW3X6fJBDpPQ@mail.gmail.com/
> >> [1]: https://github.com/cilium/cilium/blob/5145e31cd65db3361f6538d5f5f=
899440b769070/pkg/datapath/prefilter/prefilter.go#L123
> >>
> >> Hou Tao (3):
> >>   bpf: Add support for qp-trie map
> >>   selftests/bpf: add a simple test for qp-trie
> >>   selftests/bpf: add benchmark for qp-trie map
> >>
> >
> >>  include/linux/bpf_types.h                     |    1 +
> >>  include/uapi/linux/bpf.h                      |    8 +
> >>  kernel/bpf/Makefile                           |    1 +
> >>  kernel/bpf/bpf_qp_trie.c                      | 1064 ++++++++++++++++=
+
> >>  tools/include/uapi/linux/bpf.h                |    8 +
> >>  tools/testing/selftests/bpf/Makefile          |    5 +-
> >>  tools/testing/selftests/bpf/bench.c           |   10 +
> >>  .../selftests/bpf/benchs/bench_qp_trie.c      |  499 ++++++++
> >>  .../selftests/bpf/benchs/run_bench_qp_trie.sh |   55 +
> >>  .../selftests/bpf/prog_tests/str_key.c        |   69 ++
> >>  .../selftests/bpf/progs/qp_trie_bench.c       |  218 ++++
> >>  tools/testing/selftests/bpf/progs/str_key.c   |   85 ++
> >>  12 files changed, 2022 insertions(+), 1 deletion(-)
> >>  create mode 100644 kernel/bpf/bpf_qp_trie.c
> >>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_qp_trie.c
> >>  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_qp_tr=
ie.sh
> >>  create mode 100644 tools/testing/selftests/bpf/prog_tests/str_key.c
> >>  create mode 100644 tools/testing/selftests/bpf/progs/qp_trie_bench.c
> >>  create mode 100644 tools/testing/selftests/bpf/progs/str_key.c
> >>
> >> --
> >> 2.29.2
> >>
> > .
>
