Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73863A1B83
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 19:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhFIRJk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 13:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhFIRJk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Jun 2021 13:09:40 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E442C061574
        for <bpf@vger.kernel.org>; Wed,  9 Jun 2021 10:07:28 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id g12so13155340qvx.12
        for <bpf@vger.kernel.org>; Wed, 09 Jun 2021 10:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPN2GSxPFJUxc+63St4VY+Cv/XmC5EUbHqNEpm3AXGI=;
        b=GfnxaZnYkxkCglnfjjDpjZcE8OySRiXKl06+j/ykM7gGmCJdm2Mqv7yynTIXpj/3Ed
         a3XxO9mu+E49ExBHhwfiMRsWTrPjl9UK3GCYhd7rDICXGjnCcxPC1uqNpXFJyijukgTL
         9w/hgqEz/TaFWjI1mv0kRtiRHhM+ypTK8k3Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPN2GSxPFJUxc+63St4VY+Cv/XmC5EUbHqNEpm3AXGI=;
        b=ACdOBy1a6BrwxYRoPc2/WowArj3gXN2+gDXVahvFTjsZpo8KoNiCZbZO3p2PcbQvSG
         dsAMDJKKyHrt1wy5/iYEwvUR3BPvIZ8NagrQibTFJpKm9bHIh40qseIkRXr57UBSbQRn
         4o+AW9kh4NOxhExFnSd8ab2GVNuDjvp53UEdeYQ2YUWgbR0m3CH9ke/FTk2/o2NqWRxw
         vfyq9XPI/MzJEJdkSwukGETbf4oRHOdFXPbOs0MWjx+Z/9u8qNsbilVoKhN19TuNetMx
         XbBvNHXOJlv+dKQzPSBlDCU82dQJJNO0vyo+cbqGYJSAL/NS/zuwSGjGvysTzZ6lrZyC
         tEQQ==
X-Gm-Message-State: AOAM531jmBez1x5qIPV0shr5Mx4JpoFleZdQvD38rPHvqQZIGNLjQKgr
        xC050L+faDOt9xPflKbrbdoQ5wtGUg3EbVNPeNdeFQ==
X-Google-Smtp-Source: ABdhPJz8bUh4DdtpS3r/ou9Q6Y/Q5xRsZS7f/nD8+Aau7Q5Qp48cBkyD5ppF+KpZKnD35ObGQL1wJyuYXAxKn37ubzE=
X-Received: by 2002:ad4:4502:: with SMTP id k2mr666679qvu.43.1623258447585;
 Wed, 09 Jun 2021 10:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210604220235.6758-1-zeffron@riotgames.com> <20210604220235.6758-4-zeffron@riotgames.com>
 <960ba904-9e5a-9345-4ff3-73c3eb8a82bd@fb.com>
In-Reply-To: <960ba904-9e5a-9345-4ff3-73c3eb8a82bd@fb.com>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Wed, 9 Jun 2021 12:07:16 -0500
Message-ID: <CAC1LvL08QdD-4D_q2TEt3wv+8N=xbfmMdPwZPyA+MoZV=0KKMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Add test for xdp_md
 context in BPF_PROG_TEST_RUN
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 5, 2021 at 11:19 PM Yonghong Song <yhs@fb.com> wrote:
> On 6/4/21 3:02 PM, Zvi Effron wrote:
> > +     opts.ctx_in = &ctx_in;
> > +     opts.ctx_size_in = sizeof(ctx_in);
> > +
> > +     opts.ctx_in = &ctx_in;
> > +     opts.ctx_size_in = sizeof(ctx_in);
>
> The above two assignments are redundant.
>

Good catch.

> > +     ctx_in.data_meta = 0;
> > +     ctx_in.data = sizeof(__u32);
> > +     ctx_in.data_end = ctx_in.data + sizeof(pkt_v4);
> > +     err = bpf_prog_test_run_opts(prog_fd, &opts);
> > +     ASSERT_OK(err, "bpf_prog_test_run(test1)");
> > +     ASSERT_EQ(opts.retval, XDP_PASS, "test1-retval");
> > +     ASSERT_EQ(opts.data_size_out, sizeof(pkt_v4), "test1-datasize");
> > +     ASSERT_EQ(opts.ctx_size_out, opts.ctx_size_in, "test1-ctxsize");
> > +     ASSERT_EQ(ctx_out.data_meta, 0, "test1-datameta");
> > +     ASSERT_EQ(ctx_out.data, ctx_out.data_meta, "test1-data");
>
> I suggest just to test ctx_out.data == 0. It just happens
> the input data - meta = 4 and bpf program adjuested by 4.
> If they are not the same, the result won't be equal to data_meta.
>

Sure.

> > +     ASSERT_EQ(ctx_out.data_end, sizeof(pkt_v4), "test1-dataend");
> > +
> > +     /* Data past the end of the kernel's struct xdp_md must be 0 */
> > +     bad_ctx[sizeof(bad_ctx) - 1] = 1;
> > +     opts.ctx_in = bad_ctx;
> > +     opts.ctx_size_in = sizeof(bad_ctx);
> > +     err = bpf_prog_test_run_opts(prog_fd, &opts);
> > +     ASSERT_EQ(errno, 22, "test2-errno");
> > +     ASSERT_ERR(err, "bpf_prog_test_run(test2)");
>
> I suggest to drop this test. Basically you did here
> is to have non-zero egress_ifindex which is not allowed.
> You have a test below.
>

We think the actual correction here is that bad_ctx is supposed to be one byte
larger than than struct xdp_md. It is misdeclared. We'll correct that.

> > +
> > +     /* The egress cannot be specified */
> > +     ctx_in.egress_ifindex = 1;
> > +     err = bpf_prog_test_run_opts(prog_fd, &opts);
> > +     ASSERT_EQ(errno, 22, "test3-errno");
>
> Use EINVAL explicitly? The same for below a few other cases.
>

Good suggestion.

> > +     ASSERT_ERR(err, "bpf_prog_test_run(test3)");
> > +
> > +     /* data_meta must reference the start of data */
> > +     ctx_in.data_meta = sizeof(__u32);
> > +     ctx_in.data = ctx_in.data_meta;
> > +     ctx_in.data_end = ctx_in.data + sizeof(pkt_v4);
> > +     ctx_in.egress_ifindex = 0;
> > +     err = bpf_prog_test_run_opts(prog_fd, &opts);
> > +     ASSERT_EQ(errno, 22, "test4-errno");
> > +     ASSERT_ERR(err, "bpf_prog_test_run(test4)");
> > +
> > +     /* Metadata must be 32 bytes or smaller */
> > +     ctx_in.data_meta = 0;
> > +     ctx_in.data = sizeof(__u32)*9;
> > +     ctx_in.data_end = ctx_in.data + sizeof(pkt_v4);
> > +     err = bpf_prog_test_run_opts(prog_fd, &opts);
> > +     ASSERT_EQ(errno, 22, "test5-errno");
> > +     ASSERT_ERR(err, "bpf_prog_test_run(test5)");
>
> This test is not necessary if ctx size should be
> <= sizeof(struct xdp_md). So far, I think we can
> require it must be sizeof(struct xdp_md). If
> in the future, kernel struct xdp_md is extended,
> it may be changed to accept both old and new
> xdp_md's similar to other uapi data strcture
> like struct bpf_prog_info if there is a desire.
> In my opinion, the kernel should just stick
> to sizeof(struct xdp_md) size since the functionality
> is implemented as a *testing* mechanism.
>

You might be confusing the context (struct xdp_md) with the XDP metadata (data
just before the frame data). XDP allows at most 32 bytes of metadata. This test
is verifying that a metadata size >32 bytes is rejected.

> > +     ctx_in.ingress_ifindex = 1;
> > +     ctx_in.rx_queue_index = 1;
> > +     err = bpf_prog_test_run_opts(prog_fd, &opts);
> > +     ASSERT_EQ(errno, 22, "test10-errno");
> > +     ASSERT_ERR(err, "bpf_prog_test_run(test10)");
>
> Why this failure? I guess it is due to device search failure, right?
> So this test MAY succeed if the underlying host happens with
> a proper configuration with ingress_ifindex = 1 and rx_queue_index = 1,
> right?
>

I may be making incorrect assumptions, but my understanding is that interface
index 1 is always the loopback interface, and the loopback interface only ever
(in current kernels) has one rx queue. If that's not the case, we'll need to
adjust (or remove) the test.

> > +
> > +     test_xdp_context_test_run__destroy(skel);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c b/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c
> > new file mode 100644
> > index 000000000000..56fd0995b67c
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c
> > @@ -0,0 +1,20 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +
> > +SEC("xdp")
> > +int _xdp_context(struct xdp_md *xdp)
>
> Maybe drop prefix "_" from the function name?
>

Sure.

> > +{
> > +     void *data = (void *)(unsigned long)xdp->data;
> > +     __u32 *metadata = (void *)(unsigned long)xdp->data_meta;
>
> The above code is okay as verifier will rewrite correctly with actual
> address. But I still suggest to use "long" instead of "unsigned long"
> to be consistent with other bpf programs.
>

Sure.
