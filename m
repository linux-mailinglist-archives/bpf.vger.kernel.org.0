Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6EF585C6D
	for <lists+bpf@lfdr.de>; Sat, 30 Jul 2022 23:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiG3VpL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 Jul 2022 17:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbiG3VpK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 30 Jul 2022 17:45:10 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDD8B9B;
        Sat, 30 Jul 2022 14:45:08 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0D99B5C00AB;
        Sat, 30 Jul 2022 17:45:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 30 Jul 2022 17:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1659217506; x=1659303906; bh=Eb5hutMmuL
        E5GHhGStTcjZOsHjRPJtci8kgSP4tb0j8=; b=gONVT5kncx3PpM78LjSRH9xmkc
        8mxKZtHi/l2tMiz1pQqQ+N2EtL2J8b14LRlWfvCu9TKSOgg09GTefNJSBoxDRmid
        alEtIl/nJWGv8yXxfx/JQlNBhi6AhwzD+gNGpr4qnG98sns/6Kg5MZwaqjDW+I2z
        X5GQzS1qseS9+Hu79a8wWDpyPUq5SYYgCTW0LqSZgUy9zTr9QXtzuU0LC8BZOn7C
        ZIKNo3W4keTHhio3zgndjy5smgtUaC17P+uhu6mnhdZ/Z7QS1IrvQ7ZZGqZn1Xls
        Qvx8EZ7ohuZAig+/y+ISNy848gAApRKdaxDIbqmknr5Z2tK2nlK34gsn6K1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659217506; x=1659303906; bh=Eb5hutMmuLE5GHhGStTcjZOsHjRP
        Jtci8kgSP4tb0j8=; b=saYt9nd86EQA5jROmQfJjnJVf2pJhxFE/13xrGANymuJ
        uDquLrZW/MNLY25F9opBq3Hdl2tMjRjkmSFksf0zn6tP734nZgbZEZLnTjjnv/Yt
        UBX6v4t1Es/ZyP6lO6sPFxq6VUmNVEhHljJFNgQp+3uDcblz/SwSZA2slPpPuUzf
        Ry/im9MhyCh54AjYUPXVpXAj5i4DFLX8F1YVmcLFhzqYwJCxzWk6apErqT2+9/up
        o+wBwRp4F7sfdauY/shH7wBP3WnChwp7LqJ+68FWVvWqnOeysvGjjo6G9OUfHDED
        NyTTcWAbuJuKgTS6Wh8e+XZK6PZPn84JEDtQU8UpFw==
X-ME-Sender: <xms:YablYjrBFvFZEflRUaS6AEINBwspuiFFEoWqw3jFRPNSFHho9JUfaQ>
    <xme:YablYtp9uM1GYT3yt4bbt-UB2rde8JCPctp7zVYIBAaKhDn4pVKJGNNTexSNjFpJi
    pQr4ZMpTtzgvbBttw>
X-ME-Received: <xmr:YablYgPK92DvB-3Cuvq7k-zcF90YWZ6rO5FI7gPAVI8b5QaIQWyQX_ianaKvdTQswqmIPzQatrmU4PW4YwhW131ZTtfZr--IU6huEBLVoSu_5JyQfLdbxe8m9Dez>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvtddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepvdfffeevhfetveffgeeiteefhfdtvdffjeevhfeuteegleduheetvedu
    ieettddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:YablYm4hpwK90T3BZr7bdPNwb4XZ0rzXEMHlWfnjaSTIEETlf_BMHw>
    <xmx:YablYi7U3bon--SBVtVy9jbdL_6CtLUTHgEzx6O_HxsTtfvnL824uw>
    <xmx:YablYuhHY9wiV8cFR5vfiErt3EYbWGWgHpSD0yb5lud3W-F84p6DyA>
    <xmx:YqblYpYyBWa7EjjFBoMlcgBp0Uio75htJje4KPvLapUGqD_K3WUqCw>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 Jul 2022 17:45:05 -0400 (EDT)
Date:   Sat, 30 Jul 2022 14:45:04 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ben Hutchings <ben@decadent.org.uk>, sedat.dilek@gmail.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH v2 0/5] tools: fix compilation failure caused by
 init_disassemble_info API changes
Message-ID: <20220730214504.itq5cnypwpdpiwdn@awork3.anarazel.de>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220703212551.1114923-1-andres@anarazel.de>
 <CA+icZUVDzogiyG=8sCuxdW4aaby_kRwToit2tg-A4D3VorVKnA@mail.gmail.com>
 <5afd3b45e9b95fa5023790c24f8a1b0b4ce1ca7c.camel@decadent.org.uk>
 <20220715191641.go6xbmhic3kafcsc@awork3.anarazel.de>
 <YuFeBEzSNMNwx47o@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuFeBEzSNMNwx47o@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 2022-07-27 12:47:16 -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jul 15, 2022 at 12:16:41PM -0700, Andres Freund escreveu:
> > On 2022-07-14 15:25:44 +0200, Ben Hutchings wrote:
> > > Thanks, I meant to send that fix upstream but got distracted.  It
> > > should really be folded into "tools perf: Fix compilation error with
> > > new binutils".
> > 
> > I'll try to send a new version out soon. I think the right process is to add
> > Signed-off-by: Ben Hutchings <benh@debian.org>
> > to the patch I squash it with?
> 
> Hi,
> 
> 	How is this going? Any new patch coming soon? :-)

Sorry - had hoped to finish sending it out before my vacation (and then on the
flight, but wifi didn't work...). Now back, will work on it asap.

Greetings,

Andres Freund
