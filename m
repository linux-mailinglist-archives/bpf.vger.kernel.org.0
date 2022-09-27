Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7DA5EC23E
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 14:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiI0MQn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 08:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiI0MQe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 08:16:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24237D8E3E
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 05:16:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB8E5B81BB9
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0AFC433C1;
        Tue, 27 Sep 2022 12:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664280990;
        bh=gdwSviHgi1jhgb9yeWm3IhnYq7lwotnbiSyh1EQbf/k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Rz5FKaQwZ6q/MQ0SH1iJij/zcy9CVFPKxZS23BAmr0xZKs+IY/m1xWSw3/MuVudre
         96yv/A3enmua5zGAH/aBPc8Y3svJsoKpaZFxVnmoaMkJjg1o4XSkWSrI5pW9cFBbCU
         +j1YZ49PptHgSbRkI+Cg0/E1BajRkKumJtlvz82CpJcqP4hxX847mjJwA2p58RPCr+
         NlTGn3LHI1dyH2J7ickZLMQBR45Prp7oFwQSwxSkHekfNnePNV8g5GH8i7H53OjnRq
         YRJBkQKyfLCNeC7f+zbO24SdmxbMkkirsRZwgBMC5bdG/b9zXXSSIzN8GBk03IdCdW
         6A1OHriV7XzOw==
Message-ID: <57d6b6957f6e19aef509edf791266ee9f2afa20b.camel@kernel.org>
Subject: Re: [PATCH v2 bpf-next 0/2] enforce W^X for trampoline and
 dispatcher
From:   Jeff Layton <jlayton@kernel.org>
To:     Song Liu <song@kernel.org>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        kpsingh@chromium.org, kernel-team@fb.com, haoluo@google.com,
        bjorn@kernel.org
Date:   Tue, 27 Sep 2022 08:16:27 -0400
In-Reply-To: <20220926184739.3512547-1-song@kernel.org>
References: <20220926184739.3512547-1-song@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2022-09-26 at 11:47 -0700, Song Liu wrote:
> Changes v1 =3D> v2:
> 1. Update arch_prepare_bpf_dispatcher to use a RO image and a RW buffer.
>    (Alexei) Note: I haven't found an existing test to cover this part, so
>    this part was tested manually (comparing the generated dispatcher is
>    the same).
>=20
> Jeff Layton reported CPA W^X warning linux-next [1]. It turns out to be
> W^X issue with bpf trampoline and bpf dispatcher. Fix these by:
>=20
> 1. Use bpf_prog_pack for bpf_dispatcher;
> 2. Set memory permission properly with bpf trampoline.
>=20
> [1] https://lore.kernel.org/lkml/c84cc27c1a5031a003039748c3c099732a718aec=
.camel@kernel.org/
>=20
> Song Liu (2):
>   bpf: use bpf_prog_pack for bpf_dispatcher
>   bpf: Enforce W^X for bpf trampoline
>=20
>  arch/x86/net/bpf_jit_comp.c | 16 ++++++++--------
>  include/linux/bpf.h         |  4 ++--
>  include/linux/filter.h      |  5 +++++
>  kernel/bpf/core.c           |  9 +++++++--
>  kernel/bpf/dispatcher.c     | 27 +++++++++++++++++++++------
>  kernel/bpf/trampoline.c     | 22 +++++-----------------
>  6 files changed, 48 insertions(+), 35 deletions(-)
>=20
> --
> 2.30.2

Your patch seems to have fixed the issue. You can add:

Tested-by: Jeff Layton <jlayton@kernel.org>

Thanks!
