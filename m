Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1665755EA7D
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 19:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiF1Q7C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 12:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiF1Q5l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:57:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F87C4B
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:57:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1197B81F12
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 16:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E45C3411D;
        Tue, 28 Jun 2022 16:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656435426;
        bh=p3m/6+7abQz9q+v+S2ODjPD287P1BvhsQalggyw4wQk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KAA0lwBWxG+0QZn2Rcy0cxpeLyVmMV3WV3T6HuyC1RfSo4Z8nYxEDJVNna140vF0r
         GyFiyP/h41MTuga+z8QKPrwixh9mb4g5TyxVbjuo9ifczz+5q4VwyEPgIPt6gBKz2H
         MJLopkWButrG63/LIuYearHl0U+KBK6OyF1W4LGz3k9/k3syfsi7URa4vtdUb4Wkvl
         3qfLioxglaBSEJnVTpJ5exbJ75MdxUdty292LUiOBJ9XlpVQwQwgVm7mgavWAyMOgs
         3SVBjXTY1pplKEimRys80ZPmKXGZGK5D+Et9ZVH0V6ttXr6yl2cEnhW1H/WHQlAfim
         fQjU0/MVZ/BMQ==
Date:   Tue, 28 Jun 2022 09:57:03 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Mykola Lysenko <mykolal@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH bpf] bpf, docs: Better scale maintenance of BPF
 subsystem
Message-ID: <20220628095703.1b01fc4e@kernel.org>
In-Reply-To: <ac8da400-f403-7817-414d-d3001c82dc4c@iogearbox.net>
References: <5bdc73e7f5a087299589944fa074563cdf2c2c1a.1656353995.git.daniel@iogearbox.net>
        <20220627122535.6020f23e@kicinski-fedora-PC1C0HJN>
        <CAADnVQLOS4kvmcp+aaX6gtDUCUfoL906K+Y4KUZOsYBDso_xMw@mail.gmail.com>
        <20220627133027.1e141f11@kernel.org>
        <CAADnVQKf8huK_bdGPQzOZwXJD7aqr-2a3jFPfhYrEz8BD115qw@mail.gmail.com>
        <ac8da400-f403-7817-414d-d3001c82dc4c@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 28 Jun 2022 10:59:02 +0200 Daniel Borkmann wrote:
> +BPF [MISC]
> +L:     bpf@vger.kernel.org
> +S:     Odd Fixes
> +K:     (?:\b|_)bpf(?:\b|_)
> +
>   BROADCOM B44 10/100 ETHERNET DRIVER
>   M:     Michael Chan <michael.chan@broadcom.com>
>   L:     netdev@vger.kernel.org
>=20
> If there are no objections, I can fold this in..

=F0=9F=91=8C=F0=9F=91=8C=F0=9F=91=8C

Thanks Daniel!
