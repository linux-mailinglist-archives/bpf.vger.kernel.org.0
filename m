Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB525829EF
	for <lists+bpf@lfdr.de>; Wed, 27 Jul 2022 17:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiG0Pr0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jul 2022 11:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbiG0PrZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 11:47:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DB922299;
        Wed, 27 Jul 2022 08:47:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C1C29CE22D8;
        Wed, 27 Jul 2022 15:47:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CD1C433C1;
        Wed, 27 Jul 2022 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658936840;
        bh=IvHKCnwGpSnb7GfypxH1IHXl4ckkYxToRY4TjjvSCuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I5xWCFQZDHEH9MhNePdfOMMWLIPyAJNHPHZUEeXIT0pKq7Pu2rCR7eNsttwX2k2wc
         rTsy0g+zKXa1Ww9nZvv90mQEQqSUd2XdwzuehRC7Yk+m77FPqlpRJIkCyZHG3UAHL7
         ZngEyhqld4itMDLFqmafkKa+lrsquUb5tKhpUGqtWxCN7NqrtFNV3f7ApaU+c6SytT
         emy+VMCzkCarQfFC5Dn15uz5V6iV4CaOzCWQGcZp6qx1AeiePwgqFYDTVxjtRsAqih
         xMKV9MeNawyH4EecnjLJ9ea6XwRG2y2aXSnFXWhUUV1tG3SWUaLj3ei9/qx/Yzk6/s
         UadadpNplASyA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 79B28405DD; Wed, 27 Jul 2022 12:47:16 -0300 (-03)
Date:   Wed, 27 Jul 2022 12:47:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andres Freund <andres@anarazel.de>
Cc:     Ben Hutchings <ben@decadent.org.uk>, sedat.dilek@gmail.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH v2 0/5] tools: fix compilation failure caused by
 init_disassemble_info API changes
Message-ID: <YuFeBEzSNMNwx47o@kernel.org>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220703212551.1114923-1-andres@anarazel.de>
 <CA+icZUVDzogiyG=8sCuxdW4aaby_kRwToit2tg-A4D3VorVKnA@mail.gmail.com>
 <5afd3b45e9b95fa5023790c24f8a1b0b4ce1ca7c.camel@decadent.org.uk>
 <20220715191641.go6xbmhic3kafcsc@awork3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715191641.go6xbmhic3kafcsc@awork3.anarazel.de>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Jul 15, 2022 at 12:16:41PM -0700, Andres Freund escreveu:
> Hi,
> 
> On 2022-07-14 15:25:44 +0200, Ben Hutchings wrote:
> > Thanks, I meant to send that fix upstream but got distracted.  It
> > should really be folded into "tools perf: Fix compilation error with
> > new binutils".
> 
> I'll try to send a new version out soon. I think the right process is to add
> Signed-off-by: Ben Hutchings <benh@debian.org>
> to the patch I squash it with?

Hi,

	How is this going? Any new patch coming soon? :-)

- Arnaldo
