Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C7C556EEC
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 01:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbiFVXQn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 19:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377128AbiFVXQl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 19:16:41 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B506A41F9D;
        Wed, 22 Jun 2022 16:16:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 2342E3200564;
        Wed, 22 Jun 2022 19:16:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 22 Jun 2022 19:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1655939785; x=1656026185; bh=zObwhBmn5V
        RZQhkN+fOHap5f7+dJvPSHPdfpoTMXBqo=; b=Uadwy22QHZ5Zza1m0x2J1u6xkk
        9IyYmOPRBeHqH93r7Tt2EcJvOOz5gF+Sp5tn/2dlBsUzNunGEpksWJxxdEaiTo+6
        ydqW+ADPtCWA2INADQcJq4ySnQof99E4w6OgQUo01fwtUY5P+56i/tlY7LGVpp2O
        bTqi+6xe6VMsRywO489lFgXl5U7COMpjQFCX/SAbTaSz7T7ZRco/ff2aKnIr7WNJ
        TxeirXij9NOg5818MV2nQubMsYuqdQ1jyewR2s4D4RbMrKMtgglXoZ4P1gg6iIHA
        IeuaSAfGuQDSnoCME/ya6QPK80+Hrw+BcFgm7OQOD0rIkepn0e8DVvnLNX2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1655939785; x=1656026185; bh=zObwhBmn5VRZQhkN+fOHap5f7+dJ
        vPSHPdfpoTMXBqo=; b=XkpsJ1g+PBFOJbsZE3VfVl1Vn6L/ZwLtJeZuBeqyIt1K
        8PvBdBV80Hb9jOPyCflrSP0Dpo1skHpP4rhp38TmsjgchStOHl5RRzZCc7GZu+8U
        WDGszuHAomf8fuGwfuqc0CXGrxN5g/BO/fjwdf01vojlutLXEUl3OKO6OTiMH+IF
        5MNveS+D5kWxd3jqmhjbWgrjCgRfUlJyA77pEG4e9gIs8ow/6EmxPe7b4S3AL3pC
        HeJ5nvRzy6LHPFMktwKNSQb9DyyGNiY1U8x+ukgHWwUZLMDCXMAASBsqUx20wYwH
        Z34Csdy9oDpvSU3ZB9LgDw/u3M57K8tz3H64EAEPPg==
X-ME-Sender: <xms:yaKzYk8wAPOFdIyCYIenqmBHBmUXDJqA747EBLN54HmNPPqukZldvg>
    <xme:yaKzYsunRfV5OKV3dX9ueS8ID1mcn1Zl8xaacdRvWdRdQGcoOCsTzIZvh8FomgF_M
    Fb2cG4nrYm58iCGhQ>
X-ME-Received: <xmr:yaKzYqAr7bPeybU5EqYgouUQ8HSu43HxqoSLy7CF12BhoZYh51LrBEUPxA1WaCJ4UPxBC-7B6cHpI5g2Uk-s49zJxml0jaWilc7DuVcUhHEWW7NSy0HJh5PcEd85>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefiedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepueelhedvkeehvddvgeevleektefhteefueefhefhteeigffgtdegkeek
    geeigeeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghl
    rdguvg
X-ME-Proxy: <xmx:yaKzYke_kO2ZHdKWQrbqWt-xD3-43BDRJkaK6eWOsmPjBUlt6SvkIw>
    <xmx:yaKzYpP_MlZcAlE-halNcNedh0WZKhNykyLVN823M3Z9WzrLFa7icQ>
    <xmx:yaKzYul_vxvxWWh0FSWpyhsJ-THQ6hDgtp5yazf-PnHLAPsoGcFLLQ>
    <xmx:yaKzYqqZdp3Jj5jb89ilfvw0Nz3ry2um3i6Kv5YYXOR1xyOxdfvdvQ>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jun 2022 19:16:25 -0400 (EDT)
Date:   Wed, 22 Jun 2022 16:16:24 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrew Burgess <aburgess@redhat.com>
Subject: Re: init_disassemble_info() signature changes causes compile failures
Message-ID: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
References: <20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de>
 <CACdoK4LeRPkACejq87VLFgP-b=y1ZoRX3196f7xEVo-UWm8jWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdoK4LeRPkACejq87VLFgP-b=y1ZoRX3196f7xEVo-UWm8jWA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 2022-06-22 23:53:58 +0100, Quentin Monnet wrote:
> Too bad the libbfd API is changing again :/

Yea, not great. Particularly odd that
/* For compatibility with existing code.  */
#define INIT_DISASSEMBLE_INFO(INFO, STREAM, FPRINTF_FUNC, FPRINTF_STYLED_FUNC)  \

was changed. Leaving the "For compatibility with existing code." around,
despite obviously not providing compatibility...

CCed the author of that commit, maybe worth fixing?

Given that disassemble_set_printf() was added, it seems like it'd have been
easy to not change init_disassemble_info() / INIT_DISASSEMBLE_INFO() and
require disassemble_set_printf() to be called to get styled printf support.


> > The fix is easy enough, add a wrapper around fprintf() that conforms to the
> > new signature.
> >
> > However I assume the necessary feature test and wrapper should only be added
> > once? I don't know the kernel stuff well enough to choose the right structure
> > here.
> 
> We can probably find a common header for the wrapper under
> tools/include/. One possibility could be a new header under
> tools/include/tools/, like for libc_compat.h. Although personally I
> don't mind too much about redefining the wrapper several times given
> how short it is, and because maybe some tools could redefine it anyway
> to use colour output in the future.

I'm more bothered by duplicating the necessary ifdefery than duplicating the
short fprintf wrapper...


> The feature test would better be shared, it would probably be similar
> to what was done in the following commit to accommodate for a previous
> change in libbfd:
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fb982666e380c1632a74495b68b3c33a66e76430

Ah, beautiful hand-rolled feature tests :)


> > Attached is my local fix for perf. Obviously would need work to be a real
> > solution.
> 
> Thanks a lot! Would you be willing to submit a patch for the feature
> detection and wrapper?

I'll give it a go, albeit probably not today.

Greetings,

Andres Freund
