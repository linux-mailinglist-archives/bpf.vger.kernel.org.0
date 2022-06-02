Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE0F53BAD9
	for <lists+bpf@lfdr.de>; Thu,  2 Jun 2022 16:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbiFBOhz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jun 2022 10:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbiFBOhy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jun 2022 10:37:54 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1040B2DA9C;
        Thu,  2 Jun 2022 07:37:51 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5ECCF5C00E0;
        Thu,  2 Jun 2022 10:37:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 02 Jun 2022 10:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1654180668; x=1654267068; bh=BzjRBbEu68
        Kzk8yC4V4e2pbTUKKqIZY45MXe4ZImIak=; b=WQRNUcou5TAqDeXht8BzuPsoBR
        Crp+v/UFTBIxi0spr1Fxtb2gOq0OyUjgHlAKxwJisASxTD5dYqmvlDa2pTt6u8IC
        HS/1DmzzDnkmSiNOZMWlTGXPz5bR2fJo73GPqD5Ik26netbJCWS0dD+yhbie74Ji
        qyBUsgYEK1Y2zYvbIU7mj+kN9PZLR4rlVAXxN6GGjvdH7iCeJuwz4i5Mqa93E87y
        mzO2rmYd4lkt8zv8FtBAd7NLxRFEmfw8I/bHp7c8cTnvFDt/7I8+0qyafMP2bdyt
        Vl/Om8uMpeyDKBUU2b+UEgqXjvITQMasazi38tkGEnpztB5Ft8NEWXCpb44Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1654180668; x=1654267068; bh=BzjRBbEu68Kzk8yC4V4e2pbTUKKq
        IZY45MXe4ZImIak=; b=uFZlaPl/p0d+T6LLoet0CnPwBL82RRIG+/GTxIrVhnhA
        hIbAPnEPAspo3h5WLAG4K2KF48d4iNK6Cc47igpo2tyUgWc03pn8uTP8sUxMLxWE
        mkvVRtG2uFiTBVAuWSjgZcPNuLrprQ5w4mh1LgR2ElX9de/kc4yCyGsfXjqEeGWL
        hh/lognlm+8vf4XpcpNarLKSwxXNtYXpk5wZ5BzitAbpJJhRRYeKcWkF1EE4LOsv
        u8Q7rvwT5umpdpb3XyVE4/kiuHugHXnY71v4NvstgOtn+n7p5uUC+KUKT9uJrXZ5
        n7H0LXe16yBb/UmGROGx3rUTMQhEaoUu9AEALuOzew==
X-ME-Sender: <xms:PMuYYg4FTL-ZO80AV-QyIuIIkAViJJWMz8Gorg_-1ujzsc-3mZDnGA>
    <xme:PMuYYh7XxtRZ5sMpsv49QFiIjoYmkZLbI-K_QQnvw82E196dgKnhfZjxQMTRavKPO
    V29zFDqUxsA_oUrjA>
X-ME-Received: <xmr:PMuYYvfj9oivpHy5P8QRZ8jBnpkt6bchbjPiTvyKIVMh-KYkWb8fSe_x7oTNIWs7NautkrHEYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrledvgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpeevuddugeeihfdtffehgffgudeggeegheetgfevhfekkeeileeu
    ieejleekiedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:PMuYYlJmhsCk7t3w5NQWbb53m-rwrBYVX77SAzgntwISoSAcU-YWEQ>
    <xmx:PMuYYkIBA2X_EYIn79pJrhsUUGtACiCn90VETHRiSftH0ToCWSoiBQ>
    <xmx:PMuYYmxxJ5v69nMQISt532WDmX63jmRma6rthPEYoW7yDr-fnggkQQ>
    <xmx:PMuYYpHBhI55sVA2ccPy3RVnMWN8R7MrcbX4CqeWbjlMoY3c7rW3Wg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jun 2022 10:37:47 -0400 (EDT)
Date:   Thu, 2 Jun 2022 09:37:46 -0500
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf, test_run: Add PROG_TEST_RUN support to
 kprobe
Message-ID: <20220602143746.dydumxrrvhb6jdv5@kashmir.localdomain>
References: <cover.1653861287.git.dxu@dxuuu.xyz>
 <b544771c7bce102f2a97a34e2f5e7ebbb9ea0a24.1653861287.git.dxu@dxuuu.xyz>
 <CAADnVQL6Duc5qdwkqf+DWqYhngE3Dj-J37=7QoVA3ycFoWBU2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQL6Duc5qdwkqf+DWqYhngE3Dj-J37=7QoVA3ycFoWBU2w@mail.gmail.com>
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 31, 2022 at 11:07:31AM -0700, Alexei Starovoitov wrote:
> On Sun, May 29, 2022 at 3:06 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > This commit adds PROG_TEST_RUN support to BPF_PROG_TYPE_KPROBE progs. On
> > top of being generally useful for unit testing kprobe progs, this commit
> > more specifically helps solve a relability problem with bpftrace BEGIN
> > and END probes.
> >
> > BEGIN and END probes are run exactly once at the beginning and end of a
> > bpftrace tracing session, respectively. bpftrace currently implements
> > the probes by creating two dummy functions and attaching the BEGIN and
> > END progs, if defined, to those functions and calling the dummy
> > functions as appropriate. This works pretty well most of the time except
> > for when distros strip symbols from bpftrace. Every now and then this
> > happens and users get confused. Having PROG_TEST_RUN support will help
> > solve this issue by allowing us to directly trigger uprobes from
> > userspace.
> >
> > Admittedly, this is a pretty specific problem and could probably be
> > solved other ways. However, PROG_TEST_RUN also makes unit testing more
> > convenient, especially as users start building more complex tracing
> > applications. So I see this as killing two birds with one stone.
> 
> bpftrace approach of uprobe-ing into BEGIN_trigger can
> be solved with raw_tp prog.
> "BEGIN" bpftrace's program doesn't have to be uprobe.
> I can be raw_tp and prog_test_run command is
> already implemented for raw_tp.
> 
> kprobe prog has pt_regs as arguments,
> raw_tp has tracepoint args.
> Both progs expect kernel addresses in args.
> Passing 'struct pt_regs' filled with integers and non-kernel addresses
> won't help to unit test bpf-kprobe programs.
> There is little use in creating a dummy kprobe-bpf prog
> that expects RDI to be 1 and RSI to be 2
> (like selftest from patch 2 does) and running it.

Yeah that's a good point about the kprobe case. But AFAICT uprobes are
implemented using a kprobe prog in which case it would be both possible
and useful to insert userspace args and userspace addrspace addrs.

> We already have raw_tp with similar args and such
> progs can be executed already.
> Whether SEC() part says kprobe/ or raw_tp/ doesn't change
> much in the prog itself.

I suppose so, and I guess you could always bpf_program__set_type(..).

> More so raw_tp prog will work on all architectures,
> whereas kprobe's pt_regs are arch specific.
> So even if kprobe progs were runnable, bpftrace
> should probably be using raw_tp to be arch independent.

bpftrace has all the infra to pull arbitrary structs out of vmlinux BTF
already. It should be fairly simple to get the arch-specific struct
pt_regs size and construct a buffer of all 0s. And fall back to old
logic (that'll be necessary for a while) if kprobe BPF_PROG_RUN or
vmlinux BTF is missing.

That being said, I didn't realize that when I put up the patch, so
thanks for the hint. It sounds like it's probably simpler to just use
raw_tp then.

FWIW I still think this feature is useful, but since I probably won't
use it in bpftrace I'm fine with dropping the patchset. If anyone still
wants it in I'm also fine with continuing on it.

Thanks,
Daniel
