Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73477525A47
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 05:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353745AbiEMDnc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 23:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350532AbiEMDnb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 23:43:31 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD394E3A8
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 20:43:30 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id h11so4911453ila.5
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 20:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m8AsPE0936FJQu8kBYcPgxdQsGVn6FQCwj/VckK/V80=;
        b=A+teNGbnGPE0zlaz2mnBR48pu7d2Gr+lLALne+SiUVKxWejXGQ7xAF3Dkm4bVRxiPr
         9g/kQeabueTVQLh/ihzxStVKj8j20nt2yNI8TbUe6v/iXR5EyR9bopolbuEx8wMXGvkH
         6WE+4NgH+W4h6ww8N1xoLHhgV2oAEVJahQuTI5u+CB2wcYaO5XK0CgLKJJZRXX04vcb5
         wK6afOHh3cJZnrRz3gkVNGPhKgKWEImsEecMC8hiv4+fDQLNYXiJAypzVd0a7Uu4s0lO
         vQSEDxlKCTCWi/8agJbIitWTUlHctqSSnoaGYf5ONcuc+3NGIHPXONqUuX9eNdVPhWwb
         nEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m8AsPE0936FJQu8kBYcPgxdQsGVn6FQCwj/VckK/V80=;
        b=Rg9cLmjaA1yJcqU+M2NF4dehnTiMjHHG4pon5nLSo4XagYCWopLKFCfPIC91KhnJCF
         TFSInqACGhPyI8Xqgi+7iCi/bwk1h7ipohMmGyJpLXAjQIXj1/9VzIJT8yURwWtM1lK8
         F7Y7fBzXV4+Rd4d+iTQVFXceZ4klDz4LDHcFazJa5lOS5GtNaUBIOzo6xeKsp6ZPzc7P
         9sZkBsWyKep49WfEa81mCK+5tlJ4Abn5uhQ3FlXKA3vGK9tkYlTN8mIgBiEktsPWuniM
         C6c4fd7xQewHObh6lsJsvb/BXr7xgIGsYOiTLZKRqgwWE8NtES8lpAdqHERTn6ebEZNA
         z6FQ==
X-Gm-Message-State: AOAM531UdO6jFM3kkwSe9FfmXsS35wBCeZ4yWKLW/VOM0MnVRuxgPmrx
        o5SYn8yLVA5g1KlH3OtlCdKVBrljYFCw6UWHZwA=
X-Google-Smtp-Source: ABdhPJzmIN8+pCwHbnibQ4WPpedfG5CjEuWKMYwcwf/SHD5P6Jz9yz+yufE8viEEE0Yd36NFKWZHESZB87LxLvSM48k=
X-Received: by 2002:a05:6e02:1b82:b0:2cf:199f:3b4b with SMTP id
 h2-20020a056e021b8200b002cf199f3b4bmr1620203ili.71.1652413409950; Thu, 12 May
 2022 20:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220508215301.110736-1-davemarchevsky@fb.com>
 <20220511173305.ftldpn23m4ski3d3@MBP-98dd607d3435.dhcp.thefacebook.com> <f52ded4c-2d62-66dc-8e9d-9a4ba8671c02@fb.com>
In-Reply-To: <f52ded4c-2d62-66dc-8e9d-9a4ba8671c02@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 May 2022 20:43:19 -0700
Message-ID: <CAEf4BzYbbSvM8cAynMDj3E6CPuXYQ8Ou-WdcEDai0AEu02s7Tw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add benchmark for local_storage get
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Kernel Team <kernel-team@fb.com>
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

On Thu, May 12, 2022 at 6:42 PM Dave Marchevsky <davemarchevsky@fb.com> wro=
te:
>
> On 5/11/22 1:33 PM, Alexei Starovoitov wrote:
> > On Sun, May 08, 2022 at 02:53:01PM -0700, Dave Marchevsky wrote:
> >> Add a benchmarks to demonstrate the performance cliff for local_storag=
e
> >> get as the number of local_storage maps increases beyond current
> >> local_storage implementation's cache size.
> >>
> >> "sequential get" and "interleaved get" benchmarks are added, both of
> >> which do many bpf_task_storage_get calls on a set of {10, 100, 1000}
> >> task local_storage maps, while considering a single specific map to be
> >> 'important' and counting task_storage_gets to the important map
> >> separately in addition to normal 'hits' count of all gets. Goal here i=
s
> >> to mimic scenario where a particular program using one map - the
> >> important one - is running on a system where many other local_storage
> >> maps exist and are accessed often.
> >>
> >> While "sequential get" benchmark does bpf_task_storage_get for map 0, =
1,
> >> ..., {9, 99, 999} in order, "interleaved" benchmark interleaves 4
> >> bpf_task_storage_gets for the important map for every 10 map gets. Thi=
s
> >> is meant to highlight performance differences when important map is
> >> accessed far more frequently than non-important maps.
> >>
> >> Addition of this benchmark is inspired by conversation with Alexei in =
a
> >> previous patchset's thread [0], which highlighted the need for such a
> >> benchmark to motivate and validate improvements to local_storage
> >> implementation. My approach in that series focused on improving
> >> performance for explicitly-marked 'important' maps and was rejected
> >> with feedback to make more generally-applicable improvements while
> >> avoiding explicitly marking maps as important. Thus the benchmark
> >> reports both general and important-map-focused metrics, so effect of
> >> future work on both is clear.
> >>
> >> Regarding the benchmark results. On a powerful system (Skylake, 20
> >> cores, 256gb ram):
> >>
> >> Local Storage
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>         num_maps: 10
> >> local_storage cache sequential  get:  hits throughput: 20.013 =C2=B1 0=
.818 M ops/s, hits latency: 49.967 ns/op, important_hits throughput: 2.001 =
=C2=B1 0.082 M ops/s
> >> local_storage cache interleaved get:  hits throughput: 23.149 =C2=B1 0=
.342 M ops/s, hits latency: 43.198 ns/op, important_hits throughput: 8.268 =
=C2=B1 0.122 M ops/s
> >>
> >>         num_maps: 100
> >> local_storage cache sequential  get:  hits throughput: 6.149 =C2=B1 0.=
220 M ops/s, hits latency: 162.630 ns/op, important_hits throughput: 0.061 =
=C2=B1 0.002 M ops/s
> >> local_storage cache interleaved get:  hits throughput: 7.659 =C2=B1 0.=
177 M ops/s, hits latency: 130.565 ns/op, important_hits throughput: 2.243 =
=C2=B1 0.052 M ops/s
> >>
> >>         num_maps: 1000
> >> local_storage cache sequential  get:  hits throughput: 0.917 =C2=B1 0.=
029 M ops/s, hits latency: 1090.711 ns/op, important_hits throughput: 0.002=
 =C2=B1 0.000 M ops/s
> >> local_storage cache interleaved get:  hits throughput: 1.121 =C2=B1 0.=
016 M ops/s, hits latency: 892.299 ns/op, important_hits throughput: 0.322 =
=C2=B1 0.005 M ops/s
> >
> > Thanks for crafting a benchmark. It certainly helps to understand the c=
liff.
> > Is there a way to make it more configurable?
> > 10,100,1000 are hard coded and not easy to change.
> > In particular I'm interested in the numbers:
> > 1, 16, 17, 32, 100.
> > If my understanding of implementation is correct 1 and 16 should have
> > pretty much the same performance.
> > 17 should see the cliff which should linearly increase in 32 and in 100=
.
> > Between just two points 100 and 1000 there is no easy way
> > to compute the linear degradation.
>
> Agreed that being able to choose an arbitrary number of local_storage map=
s for
> the benchmark would be ideal. I tried to do this in an earlier iteration =
of the
> patch, but abandoned it as it would require a bcc-style approach, somethi=
ng like
> generating .c bpf program with python at runtime, then running through li=
bbpf
> loader.
>
> The easiest path forward is probably just generating bytecode and using r=
aw API.
> Will give that a shot, hopefully the test prog is still comprehensible in=
 that
> form.

Can this be avoided by using ARRAY_OF_MAPS and doing bounded loops? I
see that we have inlining for ARRAY_OF_MAPS, just like for ARRAY, so
it shouldn't hurt performance (not significantly at least).

>
> > Also could you add a hash map with key=3Dtid.
> > It would be interesting to compare local storage with hash map.
> > iirc when local storage was introduced it was 2.5 times faster than lar=
ge hashmap.
> > Since then both have changed.
>
> Will do.
