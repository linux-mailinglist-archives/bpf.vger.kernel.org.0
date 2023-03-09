Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142A16B17E3
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 01:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCIAbD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 19:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCIAbB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 19:31:01 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F7C5552B;
        Wed,  8 Mar 2023 16:31:00 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C5C8D5C017E;
        Wed,  8 Mar 2023 19:30:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 08 Mar 2023 19:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678321858; x=1678408258; bh=WP
        wVWF0IoiZrZqy+/FAl/fj3eRnsltm3szUz0R/YJXQ=; b=G80ZhESH6esAmX8eZy
        TciXLj3ZMVwTL1/gaMxgcNgrC5vfKKp0CDSYjSJiTtt7xJdYJdlvb2bONbKEywOd
        nLV3OLT2Q4WA8QkQUTDHVg8nLYlWCkMISBnd3SuY8FYD2WfqZ6+Oz2zO4ZMPTZrN
        m9n79a39js7CDfq+fFNW/8UH4FOS+qUldHwnsEKpH5gq94iFXndp9J7c9wV2MRIm
        kt40ZnZziBh6UerFkLL1IdT0+6jGfUPoE6cWGiF4Q2PkUhxqHwahYlx9bjrB+3HO
        Kfv4W+kiOtxjJs8zgIJiMUocx8mqipg/dOfccviMfG+RkPU4TfaEw5iFiWHS5ss8
        lSJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678321858; x=1678408258; bh=WPwVWF0IoiZrZ
        qy+/FAl/fj3eRnsltm3szUz0R/YJXQ=; b=RD+9fBm8nykm3tr+gshXJNngnVB5l
        HpnOAyqDdiM1E+CrVR0dfy/vucfFdwe5+4roo3T1Vq+8RdsIub/q6JWU0X1vrPBk
        JByetFxVlcugGqAp9xLMO166AvGsbdsjhFj449p9SJkfWPPLqUjDisRvgxafJJ/f
        YH2nVzxCrQzIhwdKoXstOp79KCqeOi90P8/DB3/dvgb93xE/V+B9KB2oQRrt6nja
        eRiYTxNrd2/Z9ctCthBd2g3UAkS3EQZ1djv5XxMyrHZL4mRBySx3Z+d8ZxXmzuLk
        sw2vNmEMABOKY7nljk6Tpl2E24OkKWkSmQ5sDwmIV2PoIPqWTdoMDwbnw==
X-ME-Sender: <xms:wSgJZPJWcz3zGZGq2Gh8S93XDvjgTB07MrgXw4tffPJnLTtqUm6E1Q>
    <xme:wSgJZDKNRxWHlvti7e7_0cLn8JjmPnBwQ0ZQmLndVdiAU9VJE_4oCu17MqbNhKdEc
    qVxgr4XWG72wWoFRCk>
X-ME-Received: <xmr:wSgJZHtiytUsHc7or1FivkwwCF66-QEkyK3cIQE3mU53e5VOyXL1-Kyx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddugedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:wSgJZIbc7ZOZwFopzUkCldgzI2NbXgQdARIxXxRFp7vr9aLcKfMA_g>
    <xmx:wSgJZGYNM2ysi6tM-jdD2AMRztxQ5I97aG1W_ehdm7raUYozsqRdLg>
    <xmx:wSgJZMD0tD5Xzsm_biSRR27OqQoAqc534erX6j6aOQditp27ba-ZeA>
    <xmx:wigJZOoj4PAPQE5rjWasVfddaMZne_DX2hecuagbS62r6URzevdqKw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Mar 2023 19:30:57 -0500 (EST)
Date:   Wed, 8 Mar 2023 16:30:55 -0800
From:   Boris Burkov <boris@bur.io>
To:     sdf@google.com
Cc:     Rong Tao <rtoax@foxmail.com>, andrii@kernel.org, rongtao@cestc.cn,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "open list:BPF [LIBRARY] (libbpf)" <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] libbpf: poison strlcpy()
Message-ID: <20230309003055.GA6586@zen>
References: <tencent_5695A257C4D16B4413036BA1DAACDECB0B07@qq.com>
 <Y7cbM1D2YvB9tdqg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7cbM1D2YvB9tdqg@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 05, 2023 at 10:47:15AM -0800, sdf@google.com wrote:
> On 01/05, Rong Tao wrote:
> > From: Rong Tao <rongtao@cestc.cn>
> 
> > Since commit 9fc205b413b3("libbpf: Add sane strncpy alternative and use
> > it internally") introduce libbpf_strlcpy(), thus add strlcpy() to a poison
> > list to prevent accidental use of it.
> 
> > Signed-off-by: Rong Tao <rongtao@cestc.cn>
> 
> Acked-by: Stanislav Fomichev <sdf@google.com>
> 
> > ---
> >   tools/lib/bpf/libbpf_internal.h | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> > diff --git a/tools/lib/bpf/libbpf_internal.h
> > b/tools/lib/bpf/libbpf_internal.h
> > index 377642ff51fc..2d26ded383ca 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -20,8 +20,8 @@
> >   /* make sure libbpf doesn't use kernel-only integer typedefs */
> >   #pragma GCC poison u8 u16 u32 u64 s8 s16 s32 s64
> 
> > -/* prevent accidental re-addition of reallocarray() */
> > -#pragma GCC poison reallocarray
> > +/* prevent accidental re-addition of reallocarray()/strlcpy() */
> > +#pragma GCC poison reallocarray strlcpy

On my musl system, I believe this broke compilation, as string.h defines
strlcpy, and is included after this poisoning when compiling strset.c

FWIW, I could work around it by adding
#include <string.h>
above
#include <libbpf_internal.h>
in strset.c, since the poison doesn't apply to symbols that existed
before it ran, but this feels like a kludge, and not in the spirit of
the original poisoning patch..

I'm curious what the proper workaround should be for a libc that defines
strlcpy.

Thanks,
Boris

> 
> >   #include "libbpf.h"
> >   #include "btf.h"
> > --
> > 2.39.0
> 
