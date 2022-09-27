Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36C45EC322
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 14:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiI0Mnl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 08:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiI0Mnj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 08:43:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E15615E4D9
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 05:43:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C135DB81B97
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7FEC433C1;
        Tue, 27 Sep 2022 12:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664282615;
        bh=vIDbrl3yjZKn/Jc6mYdhqBJ5ndukoL7NPn7wIE7k/Mo=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=O0cE6A1v7m80gNKlSKCGFRnoaEnb2eHAFvwVN+3ZKG+vFTQRRN6wGglZM+KT+n9Kx
         nFK+drgzgSg05o8O9tGhreZ1LJKta0skoZJJKtAOcovK8iaPG26T4l5Kam5o7IURqj
         NUKFfNu2o6jY2XRuK80ZPnhua+d1CnN+X8NTeV5sguaYuRZWsZm/dDToAOgnyofwVy
         Gil1kLGtjAASHgAwuzAU6PkcHZPGYUrXkR+i9JAif7nN8lIuEqh89/ABX7JKGqYGJx
         wZnAEsGMs5M+/qc2geM5P0PVamelTt5a+iiNWWAc0hmmMFNXcQExxNjYK1ukKwHTcY
         priypUHq//OVA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C9E9161CFFD; Tue, 27 Sep 2022 14:43:32 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: The future of bpf_dispatcher
In-Reply-To: <CAJ+HfNgnvWaQcZKC37ayZgrWdLa1Ni9Zvena8NxyEYPTeAoMsw@mail.gmail.com>
References: <CAJ+HfNgnvWaQcZKC37ayZgrWdLa1Ni9Zvena8NxyEYPTeAoMsw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 27 Sep 2022 14:43:32 +0200
Message-ID: <87tu4trnrf.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> In the recent weeks there have been various issues [1] [2] (warnings, ftr=
ace
> breakage) related to the bpf_dispatcher. The dispatcher was introduced
> to reduce the cost of indirect calls for the XDP realm, and during the
> whole retpoline timeline it was doing its job pretty good.
>
> However, it's a somewhat odd animal in the kernel, and very x86
> specific.
>
> Is the bpf_dispatcher still relevant? If yes, can it be replaced by a
> more generic functionality (e.g. static_calls)?

During Daniel's talk at LPC (about TC attachment) he mentioned that he
was planning to support multiple programs by iterating through an array
and doing an indirect call into each. I asked if we could avoid the
indirect calls by generating a bpf_dispatcher-style trampoline instead
(and further down the line extend this to XDP as well, like what libxdp
is doing).

No one seemed to complain loudly about this idea in the session; so I'm
hoping that the future of bpf_dispatcher is that we can generalise it so
it can be used for both TC and XDP, and also support chaining of
multiple programs on a single hook.

I don't have any opinion on how the low-level plumbing for this should
work, though; if changing it to re-use other kernel functionality like
static_calls makes sense, that's fine with me...

WDYT, sounds feasible? :)

-Toke
