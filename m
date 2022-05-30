Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99321538531
	for <lists+bpf@lfdr.de>; Mon, 30 May 2022 17:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242900AbiE3PqF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 May 2022 11:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242673AbiE3Pp7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 May 2022 11:45:59 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855174B435;
        Mon, 30 May 2022 07:56:44 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0CC375C01AA;
        Mon, 30 May 2022 10:56:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 30 May 2022 10:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1653922602; x=1654009002; bh=ibjnI8Geex
        5eh6AY7BjUezUuIjEtyn8A9+EqUJ4bMcc=; b=Zc4guAAbjCZPW1oy4/pvYVjbmK
        L4SIDfKq+K8W2disdVij7aHl9gykkN+c83dd63PVuGVkMTOL7A6r3GVqFvXajcbl
        u7RBLsAXNT4gJeZTGwAzjhz1hsFgk1JDXagLzunTPgOhFiRbqM2XC97xXN3oIjUv
        BxqCMDpQXHSYy4AMJzF5c43hSu1GfYEYpiKqSc9Y6sm7Th2RoEYWUsT1H2ztwwpz
        bwr3xWHc8mqg6yVX1GNZ/CnSihk7trfanrV8kNcjR/EGmc1e5Nbc/URl62EXt2Oe
        B8m7TBp7ENKru1m0o66Thzx5Bs++AmOFkUYtpHUEfgCRpxikOVXZT4Ty85Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1653922602; x=1654009002; bh=ibjnI8Geex5eh6AY7BjUezUuIjEt
        yn8A9+EqUJ4bMcc=; b=Ku9WXIBvVTOendts8TxCy1zIHRrURG4K36Fp6BQwY5Kb
        IolmOUFnvR09GXd3b8cQCxO4+qnK+DW2kQBtdepoLxssSGJvFGb9SVdttDPXDcR1
        AyX+mbTqRILl+cFoNmZUC0fZ9c3Q04LuJcwazdL5HV+JRYffWS2T3xLlu0Ip0LzP
        MwbAAw5zKJF1UD6S8W/2m3XlO7/JEY8HQ39n3UhkQpAKaKoL5N71783aTV2HetvZ
        BSIZvOfcfAZqx4sMgtpfYm/hw0F0WWi9BMfns4esJPtirDaAMC08p2m+89JTCDE8
        PwVPsK/zEKhCe2s4IIOF/aeps6E4fZokZufLHs0MVQ==
X-ME-Sender: <xms:KduUYtZn9AxioNICwyMqhiOxXiR9JHpIG4nyPrwB8M_db8zQelkXfg>
    <xme:KduUYkaWmK5MQWI_JS-rSmPbFXVrpJEsgRbZJDf10Wv9eNOZtGN0O-9V2R7NjdE77
    6bdAE_ci8g6PvP6hQ>
X-ME-Received: <xmr:KduUYv8346H6L5bl9JK_tkfJ1FGvlIm1Pb-T3JCDVMHM2wCX4Oamok-7gUzfi4sQ2FU_YoRj6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkeeigdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpeevuddugeeihfdtffehgffgudeggeegheetgfevhfekkeeileeu
    ieejleekiedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:KduUYrpdBRhIi15smniQh5BOu53OFH96kOsIhWtPFVBWeiiQWpd5_w>
    <xmx:KduUYorIOfx2o5_IN3Cuvv8BqUuC08EnpFGBOrjE_3T564wFg_80wA>
    <xmx:KduUYhT75FpIWw-XHep7pSZx7ClzO07HEYwUQdbBcDsA_y44SScedg>
    <xmx:KtuUYhlXx3nDUKSuKMh8tTpnLB_4xkHnxT8-hxUp3JhKJdwZmWnkCA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 May 2022 10:56:41 -0400 (EDT)
Date:   Mon, 30 May 2022 09:56:39 -0500
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/2] Add PROG_TEST_RUN support to
 BPF_PROG_TYPE_KPROBE
Message-ID: <20220530145639.slbwvbwewonj6im2@kashmir.localdomain>
References: <cover.1653861287.git.dxu@dxuuu.xyz>
 <CAPhsuW4nC_7L48aMJfNPcx69O6JtS7zk8p2=4Vro2S1608dztw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4nC_7L48aMJfNPcx69O6JtS7zk8p2=4Vro2S1608dztw@mail.gmail.com>
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Song,

On Sun, May 29, 2022 at 11:00:48PM -0700, Song Liu wrote:
> On Sun, May 29, 2022 at 3:06 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > This patchset adds PROG_TEST_RUN support to BPF_PROG_TYPE_KPROBE progs.
> > On top of being generally useful for unit testing kprobe progs, this
> > feature more specifically helps solve a relability problem with bpftrace
> > BEGIN and END probes.
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
> We have BPF_PROG_RUN which is an alias of BPF_PROG_TEST_RUN. I guess
> that's a better name for the BEGIN/END use case.

Right, sorry. Was getting names mixed up.

> 
> Have you checked out bpf_prog_test_run_raw_tp()? AFAICT, it works as good as
> kprobe for this use case.

I just took a look -- I think it'll work for BEGIN/END use case. But
also like I mentioned, BPF_PROG_RUN/BPF_PROG_TEST_RUN support for
kprobes is probably still useful. For example if kprobe accesses 13th
register. I suppose the raw_tp 12 arg limit could be lifted but it might
be tricky to capture that logic in the absence of something like `struct
pt_regs` to check the ctx_size_in against.

Thanks,
Daniel
