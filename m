Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F51853D65A
	for <lists+bpf@lfdr.de>; Sat,  4 Jun 2022 12:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiFDKBv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Jun 2022 06:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiFDKBu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Jun 2022 06:01:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982F6B4
        for <bpf@vger.kernel.org>; Sat,  4 Jun 2022 03:01:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BF80B80011
        for <bpf@vger.kernel.org>; Sat,  4 Jun 2022 10:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6D9C385B8;
        Sat,  4 Jun 2022 10:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654336907;
        bh=xRXdEV99WU6xlHK5luRtVk2IifrVVUkjo5OKMiwOMDI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gsY9NJoAjXS/naBQjp6Xyymk7AZpevxUpITBGyCSp53SGc2bzokvxBUkBCL8JO83i
         rECd2akbadxN4lJDWZ/rw42UDvepxJhcMiIG4vcBCggi52NTNY0A0Dv/XladoQvrun
         bvZ/tL2vGfTgiBksW8YMrwAsSNRv8gkgJ77fFpvGeGl/2/5kAvU565Ziua++mL9zLC
         Iy1iV2Kl3zzZLxJUsFkCSFdO+0v6Joet5gqOpzA5bF7NNb7ALr5ELg/JIxCI4D5QHM
         j6eTQs7Hd9ZZsrqvpl6EdJxmOx5TPPYrivMeOfWt0rAtu0oxQYsuOojmFjAyv6Pvls
         /2Xt/9oW8uygQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C8C5D405424; Sat,  4 Jun 2022 12:01:42 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 00/15] libbpf: remove deprecated APIs
In-Reply-To: <20220603190155.3924899-1-andrii@kernel.org>
References: <20220603190155.3924899-1-andrii@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 04 Jun 2022 12:01:42 +0200
Message-ID: <87wndwvjax.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii@kernel.org> writes:

> This patch set removes all the deprecated APIs in preparation for 1.0 release.
> It also makes libbpf_set_strict_mode() a no-op (but keeps it to let per-1.0
> applications buildable and dynamically linkable against libbpf 1.0 if they
> were already libbpf-1.0 ready) and starts enforcing all the
> behaviors that were previously opt-in through libbpf_set_strict_mode().
>
> xsk.{c,h} parts that are now properly provided by libxdp ([0]) are still used
> by xdpxceiver.c in selftest/bpf, so I've moved xsk.{c,h} with barely any
> changes to under selftests/bpf.
>
> Other than that, apart from removing all the LIBBPF_DEPRECATED-marked APIs,
> there is a bunch of internal clean ups allowed by that. I've also "restored"
> libbpf.map inheritance chain while removing all the deprecated APIs. I think
> that's the right way to do this, as applications using libbpf as shared
> library but not relying on any deprecated APIs (i.e., "good citizens" that
> prepared for libbpf 1.0 release ahead of time to minimize disruption) should
> be able to link both against 0.x and 1.x versions. Either way, it doesn't seem
> to break anything and preserve a history on when each "surviving" API was
> added.
>
> NOTE. This shouldn't be yet landed until Jiri's changes ([1]) removing last
> deprecated API usage in perf lands. But I thought to post it now to get the
> ball rolling.

Any chance you could push this to a branch of github as well? Makes it
easier to test libxdp against it :)

-Toke
