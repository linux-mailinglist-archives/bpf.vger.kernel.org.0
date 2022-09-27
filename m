Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339B05EC1E2
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 13:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiI0Lxr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 07:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiI0Lxp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 07:53:45 -0400
X-Greylist: delayed 593 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Sep 2022 04:53:43 PDT
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA45F193C
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 04:53:42 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1664279026; bh=oi75rhIEmEvbyiNMvThiJFjm4ON4KMK0ysSmkUtabKY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OmE/JrFXENSjkaYdkDRJjxm2e/3Stj9lsOz1Wfpv6Z8cvnqiy0HLoGYEcj2yarq5s
         29Kl1anff6Zuj88vJR5pHbeIR4SuimOakp7MRv6zghTIYnxBprZu1Wzz6ouLzBwx0X
         A2uppxMxFYuW0QFSzMegz3JfQaUBMqDDwyWbbxrxIs5GrMv4+AFMXtfvvtOkeIZMnq
         HkLGttpJpb+rAmIYMfnnZ/u6z9U0/Oj6ivR7Ezygt0wdt1B/6wM78E+Mmx8Mx/U6m6
         LZASrLCmOYLjcbR7E00Vtilnop/AC/kc2R/lmOWh4UJtxYrrbnijZAS4YqWJ7DOZUJ
         Y5879G6QmN+Rg==
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/2] libbpf: don't require full struct enum64
 in UAPI headers
In-Reply-To: <20220927042940.147185-1-andrii@kernel.org>
References: <20220927042940.147185-1-andrii@kernel.org>
Date:   Tue, 27 Sep 2022 13:43:45 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87zgelrqj2.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii@kernel.org> writes:

> Drop the requirement for system-wide kernel UAPI headers to provide full
> struct btf_enum64 definition. This is an unexpected requirement that
> slipped in libbpf 1.0 and put unnecessary pressure ([0]) on users to have
> a bleeding-edge kernel UAPI header from unreleased Linux 6.0.
>
> To achieve this, we forward declare struct btf_enum64. But that's not
> enough as there is btf_enum64_value() helper that expects to know the
> layout of struct btf_enum64. So we get a bit creative with
> reinterpreting memory layout as array of __u32 and accesing lo32/hi32
> fields as array elements. Alternative way would be to have a local
> pointer variable for anonymous struct with exactly the same layout as
> struct btf_enum64, but that gets us into C++ compiler errors complaining
> about invalid type casts. So play it safe, if ugly.
>
>   [0] Closes: https://github.com/libbpf/libbpf/issues/562
>
> Reported-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
> Fixes: d90ec262b35b ("libbpf: Add enum64 support for btf_dump")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

This seems like a reasonable (and only a bit ugly) workaround; thanks!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
