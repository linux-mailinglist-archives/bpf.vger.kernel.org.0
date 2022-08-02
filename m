Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB98F58847E
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 00:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbiHBWir (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 18:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236953AbiHBWig (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 18:38:36 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F747564CA
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 15:38:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y13so14389737ejp.13
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 15:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Wpzx1elzmX2tIeNR/BNU5HcDq9H5HPWSUuIqkyP3lBo=;
        b=BWNx4eQpt1o2kDfjTw22IThOeqQXW2DFO0MbPRYrPDEGrocFX6VZUhkrduQy1jD32H
         VnPTBifcPucdWGn3Je4iIOhyfQiUTTt9TA9ICtbEnZrLYKRxN0XziCBWWCp5ExRobLZy
         jbaB+CepsebXPS7PruoQy87CsopaGGpm6F/NGTcuuQrQJCYBIQPpKJ/njXwmGll//wJ2
         wQNGk3Eb8j0IL5+jsy4uS559xfRneO7F2wTShQ8rpH+sMoMse7taoU2urJkpnUw5RJ44
         uyqJSfXGJONIG6XJyTiGw9cvy1oUJmOVlQ5Asxmb/QyCWgdYLzpBqaGmeRCwtrO8UkPF
         dRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Wpzx1elzmX2tIeNR/BNU5HcDq9H5HPWSUuIqkyP3lBo=;
        b=QLonfti25qVb9yKE+A2xGjx8zVsAaAeX1BiD2nvzqpAJdUhNMFA0+4PuJ5/h0ZPo9Q
         QFLvI7pYg8lm+1XHCIFDpWL/MPXYDftxrOo98yWK25kf3d/PRCEmJ3lVd7sqScGZkV/Z
         N2+mILCwkF6ShmVGrdpN8na9AJAc5w6elvGrvh8FpjxW3mbrzpkxQ8yjyxk53BRDXmie
         9SLON0+gWNkTcfJRcp801z6FxM7zNMDQDTrV0lb6SrZKRfrPf7gVykuwRTegHPBZ4KM2
         4DIzk3uT7EHmguy6RLjycAKxKbw9EmnBtTb9HwP0iDA7BALOr5R8Q83Gph/3S7H92TtA
         i4tQ==
X-Gm-Message-State: AJIora8b/uqN23Eq7D04S5fgyWbIkYMkFca0K9CFFPfmljGeMer0gNDs
        jMKYIXQk058x6EneFKu1LCLndUE6Ww07qoggzEc=
X-Google-Smtp-Source: AGRyM1t0iqkQ3hSFJ9J75+j+POVDDT3ncfdEOQHuaKCwmMt3I3f2KRf+Yj5uW/kMTcWIn+WxIikiSyLbxA/JSAfG/UQ=
X-Received: by 2002:a17:907:6e1d:b0:72f:20ad:e1b6 with SMTP id
 sd29-20020a1709076e1d00b0072f20ade1b6mr18292625ejc.545.1659479894356; Tue, 02
 Aug 2022 15:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220726130005.3102470-1-houtao1@huawei.com>
In-Reply-To: <20220726130005.3102470-1-houtao1@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 2 Aug 2022 15:38:02 -0700
Message-ID: <CAEf4BzYdC=G0CzbiXm4gnT5EKHuGfAiFnYRyzf0nNeuAU-T4pw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] Add support for qp-trie map
To:     Hou Tao <houtao1@huawei.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 26, 2022 at 5:42 AM Hou Tao <houtao1@huawei.com> wrote:
>
> Hi,
>

Hey, sorry I'm catching up on upstream and there is just too many
complicated patch sets coming in, so it takes time to get through
them.

I think you did a great job with this implementation, it's certainly
worth submitting as non-RFC for proper upstream review. I know that
some people didn't get your patches, they got into spam somehow. So I
think it would be great to just resubmit it as non-RFC so that it
appears in patchworks as to-be-reviewew patches and hopefully will get
a wider audience to review this.

I've tried to answer some questions below, but would definitely like
more people to chime in. I haven't went through implementation in
details, but superficially it looks pretty clean and certainly ready
for proper non-RFC review.

One point about user API would be to maybe instead use bpf_dynptr as
an interface for specifying variable-sized lookup key instead of
hard-coded
 bpf_qp_trie_key. Please check recent work by Joanne on bpf_dynptr.

In short: looks great, I think it's certainly worth adding this as BPF
map type. Please submit as non-RFC and go through a proper review
process. Looking forward (even if that means reviewing 1000k lines of
dense algorithmic code :) ).

> The initial motivation for qp-trie map is to reduce memory usage for
> string keys special those with large differencies in length as
> discussed in [0]. And as a big-endian lexicographical ordered map, it
> can also be used for any binary data with fixed or variable length.
>
> Now the basic functionality of qp-trie is ready, so posting a RFC version
> to get more feedback or suggestions about qp-trie. Specially feedback
> about the following questions:
>
> (1) Application scenario for qp-trie
> Andrii had proposed to re-implement lpm-trie by using qp-trie. The
> advantage would be the speed up of lookup operations due to lower tree
> depth of qp-trie. Maybe the performance of update could also be improved
> although in cillium there is a big lock during lpm-trie update [1]. Is

Well, using qp-trie approach as an internal implementation of lpm-trie
is probably a major win already, what's wrong with that?

> there any other use cases for qp-trie ? Specially those cases which need
> both ordering and memory efficiency or cases in which jhash() of htab
> creates too much collisions and qp-trie lookup performances better than
> hash-table lookup as shown below:

I'm thinking about qp-trie as dynamically growable lookup table.
That's a pretty big use case already. There is an RB tree proposal
under review right now which would also satisfy dynamically growable
criteria, but its focus is slightly different and it remains to be
seen how convenient it will be as general-purpose resizable
alternative to hashmap. But from benchmarks I've found online, RB tree
will definitely use more memory than qp-trie.

Ordered property seems also very useful, but I don't yet have specific
use case for that. But once we have data structure like this in BPF,
I'm sure use cases will pop up.

>
>   Randomly-generated binary data with variable length (length range=3D[1,=
 256] entries=3D16K)
>
>   htab lookup      (1  thread)    5.062 =C2=B1 0.004M/s (drops 0.002 =C2=
=B1 0.000M/s mem 8.125 MiB)
>   htab lookup      (2  thread)   10.256 =C2=B1 0.017M/s (drops 0.006 =C2=
=B1 0.000M/s mem 8.114 MiB)
>   htab lookup      (4  thread)   20.383 =C2=B1 0.006M/s (drops 0.009 =C2=
=B1 0.000M/s mem 8.117 MiB)
>   htab lookup      (8  thread)   40.727 =C2=B1 0.093M/s (drops 0.010 =C2=
=B1 0.000M/s mem 8.123 MiB)
>   htab lookup      (16 thread)   81.333 =C2=B1 0.311M/s (drops 0.020 =C2=
=B1 0.000M/s mem 8.122 MiB)
>
>   qp-trie lookup   (1  thread)   10.161 =C2=B1 0.008M/s (drops 0.006 =C2=
=B1 0.000M/s mem 4.847 MiB)
>   qp-trie lookup   (2  thread)   20.287 =C2=B1 0.024M/s (drops 0.007 =C2=
=B1 0.000M/s mem 4.828 MiB)
>   qp-trie lookup   (4  thread)   40.784 =C2=B1 0.020M/s (drops 0.015 =C2=
=B1 0.000M/s mem 4.071 MiB)
>   qp-trie lookup   (8  thread)   81.165 =C2=B1 0.013M/s (drops 0.040 =C2=
=B1 0.000M/s mem 4.045 MiB)
>   qp-trie lookup   (16 thread)  159.955 =C2=B1 0.014M/s (drops 0.108 =C2=
=B1 0.000M/s mem 4.495 MiB)
>

Kind of surprised that qp-tire is twice as fast as hashmap. Do you
have any idea why hashmap is slower? Was htab pre-allocated? What was
it's max_entries?

>   * non-zero drops is due to duplicated keys in generated keys.
>
> (2) more fine-grained lock in qp-trie
> Now qp-trie is divided into 256 sub-trees by using the first character of

character -> byte, it's not always strings, right?

> key and one sub-tree is protected one spinlock. From the data below,
> although the update/delete speed of qp-trie is slower compare with hash
> table, but it scales similar with hash table. So maybe 256-locks is a
> good enough solution ?
>
>   Strings in /proc/kallsyms
>   htab update      (1  thread)    2.850 =C2=B1 0.129M/s (drops 0.000 =C2=
=B1 0.000M/s mem 33.564 MiB)
>   htab update      (2  thread)    4.363 =C2=B1 0.031M/s (drops 0.000 =C2=
=B1 0.000M/s mem 33.563 MiB)
>   htab update      (4  thread)    6.306 =C2=B1 0.096M/s (drops 0.000 =C2=
=B1 0.000M/s mem 33.718 MiB)
>   htab update      (8  thread)    6.611 =C2=B1 0.026M/s (drops 0.000 =C2=
=B1 0.000M/s mem 33.627 MiB)
>   htab update      (16 thread)    6.390 =C2=B1 0.015M/s (drops 0.000 =C2=
=B1 0.000M/s mem 33.564 MiB)
>   qp-trie update   (1  thread)    1.157 =C2=B1 0.099M/s (drops 0.000 =C2=
=B1 0.000M/s mem 18.333 MiB)
>   qp-trie update   (2  thread)    1.920 =C2=B1 0.062M/s (drops 0.000 =C2=
=B1 0.000M/s mem 18.293 MiB)
>   qp-trie update   (4  thread)    2.630 =C2=B1 0.050M/s (drops 0.000 =C2=
=B1 0.000M/s mem 18.472 MiB)
>   qp-trie update   (8  thread)    3.171 =C2=B1 0.027M/s (drops 0.000 =C2=
=B1 0.000M/s mem 18.301 MiB)
>   qp-trie update   (16 thread)    3.782 =C2=B1 0.036M/s (drops 0.000 =C2=
=B1 0.000M/s mem 19.040 MiB)


qp-trie being slower than htab matches my expectation and what I
observed when trying to use qp-trie with libbpf. But I think for a lot
of cases memory vs CPU tradeoff, coupled with ability to dynamically
grow qp-trie will make this data structure worthwhile.


>
> (3) Improve memory efficiency further
> When using strings in BTF string section as a data set for qp-trie, the
> slab memory usage showed in cgroup memory.stats file is about 11MB for
> qp-trie and 15MB for hash table as shown below. However the theoretical
> memory usage for qp-trie is ~6.8MB (is ~4.9MB if removing "parent" & "rcu=
"
> fields from qp_trie_branch) and the extra memory usage (about 38% of tota=
l
> usage) mainly comes from internal fragment in slab (namely 2^n alignment
> for allocation) and overhead in kmem-cgroup accounting. We can reduce the
> internal fragment by creating separated kmem_cache for qp_trie_branch wit=
h
> different child nodes, but not sure whether it is worthy or not.
>

Please CC Paul McKenney (paulmck@kernel.org) for your non-RFC patch
set and maybe he has some good idea how to avoid having rcu_head in
each leaf node. Maybe some sort of per-CPU queue of to-be-rcu-freed
elements, so that we don't have to keep 16 bytes in each leaf and
branch node?

> And in order to prevent allocating a rcu_head for each leaf node, now onl=
y
> branch node is RCU-freed, so when replacing a leaf node, a new branch nod=
e
> and a new leaf node will be allocated instead of replacing the old leaf
> node and RCU-freed the old leaf node. Also not sure whether or not it is
> worthy.
>
>   Strings in BTF string section (entries=3D115980):
>   htab lookup      (1  thread)    9.889 =C2=B1 0.006M/s (drops 0.000 =C2=
=B1 0.000M/s mem 15.069 MiB)
>   qp-trie lookup   (1  thread)    5.132 =C2=B1 0.002M/s (drops 0.000 =C2=
=B1 0.000M/s mem 10.721 MiB)
>
>   All files under linux kernel source directory (entries=3D74359):
>   htab lookup      (1  thread)    8.418 =C2=B1 0.077M/s (drops 0.000 =C2=
=B1 0.000M/s mem 14.207 MiB)
>   qp-trie lookup   (1  thread)    4.966 =C2=B1 0.003M/s (drops 0.000 =C2=
=B1 0.000M/s mem 9.355 MiB)
>
>   Domain names for Alexa top million web site (entries=3D1000000):
>   htab lookup      (1  thread)    4.551 =C2=B1 0.043M/s (drops 0.000 =C2=
=B1 0.000M/s mem 190.761 MiB)
>   qp-trie lookup   (1  thread)    2.804 =C2=B1 0.017M/s (drops 0.000 =C2=
=B1 0.000M/s mem 83.194 MiB)
>
> Comments and suggestions are always welcome.
>
> Regards,
> Tao
>
> [0]: https://lore.kernel.org/bpf/CAEf4Bzb7keBS8vXgV5JZzwgNGgMV0X3_guQ_m9J=
W3X6fJBDpPQ@mail.gmail.com/
> [1]: https://github.com/cilium/cilium/blob/5145e31cd65db3361f6538d5f5f899=
440b769070/pkg/datapath/prefilter/prefilter.go#L123
>
> Hou Tao (3):
>   bpf: Add support for qp-trie map
>   selftests/bpf: add a simple test for qp-trie
>   selftests/bpf: add benchmark for qp-trie map
>

Overall, looks



>  include/linux/bpf_types.h                     |    1 +
>  include/uapi/linux/bpf.h                      |    8 +
>  kernel/bpf/Makefile                           |    1 +
>  kernel/bpf/bpf_qp_trie.c                      | 1064 +++++++++++++++++
>  tools/include/uapi/linux/bpf.h                |    8 +
>  tools/testing/selftests/bpf/Makefile          |    5 +-
>  tools/testing/selftests/bpf/bench.c           |   10 +
>  .../selftests/bpf/benchs/bench_qp_trie.c      |  499 ++++++++
>  .../selftests/bpf/benchs/run_bench_qp_trie.sh |   55 +
>  .../selftests/bpf/prog_tests/str_key.c        |   69 ++
>  .../selftests/bpf/progs/qp_trie_bench.c       |  218 ++++
>  tools/testing/selftests/bpf/progs/str_key.c   |   85 ++
>  12 files changed, 2022 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/bpf/bpf_qp_trie.c
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_qp_trie.c
>  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_qp_trie.=
sh
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/str_key.c
>  create mode 100644 tools/testing/selftests/bpf/progs/qp_trie_bench.c
>  create mode 100644 tools/testing/selftests/bpf/progs/str_key.c
>
> --
> 2.29.2
>
