Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A1A53BD78
	for <lists+bpf@lfdr.de>; Thu,  2 Jun 2022 19:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbiFBRoH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jun 2022 13:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbiFBRoG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jun 2022 13:44:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72A1287F59
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 10:44:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CF9861677
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 17:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DB8C34115
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 17:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654191844;
        bh=aqSID2m9712ByluUqhDQ1HoQkIXevf4HnCCgTJ/K2gE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DbOfZUKadXxWTiLRGsLO4eG/DJbwl35S9zNTESyLtQ4Ms+nWdQglAdKOraYoC2CPO
         DpQkQfkmY/XPOvq6zzcxqDtq/zpw9VAzmPgct4QoLskvBhVszT1RdOud8cXh6xA6/x
         8lE8xMNvKe7Yru6Vd3/9gtGShwp/c2rWOjkegOot1ybzuivgong+j9JS14qbs6U/RK
         y6pXu1jYL1tbowSEj5e0j73zphxB9lrQVCBh6crZk90drNS0++KjXKXDx110X9OIcA
         peWgy5jiGE5wY9ScID1DApAg1QyZhu6Az2civJbo7qzxHot4qrJmx7xM6zZI+JpqMj
         OxOLczCFQ1H8Q==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-30c1b401711so59208077b3.2
        for <bpf@vger.kernel.org>; Thu, 02 Jun 2022 10:44:04 -0700 (PDT)
X-Gm-Message-State: AOAM533jgo0DHob8vMsNW0oKNzf/0Tu8WZWA6fymad0/JPUYSnTzhtk4
        m5DtgKHdag95oGHtMw6jgl9xbSxKstHkly2NWTY=
X-Google-Smtp-Source: ABdhPJxCzCkDHnPSm0IliNswknERGqtzf0+puwk5I5TUNjiaJ1wbM2Hsy3RNd6ioLXx/2PcbUR+jB3XEn1S6AHLDeeU=
X-Received: by 2002:a81:7505:0:b0:30c:45e3:71bc with SMTP id
 q5-20020a817505000000b0030c45e371bcmr6981178ywc.460.1654191843829; Thu, 02
 Jun 2022 10:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220601234050.2572671-1-kafai@fb.com>
In-Reply-To: <20220601234050.2572671-1-kafai@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 2 Jun 2022 10:43:53 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6VcOLSakKAdT5WXvrGtmuFM8BKQUZi+JiQ38X25H8Pdw@mail.gmail.com>
Message-ID: <CAPhsuW6VcOLSakKAdT5WXvrGtmuFM8BKQUZi+JiQ38X25H8Pdw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix tc_redirect_dtime
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 1, 2022 at 4:40 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> tc_redirect_dtime was reported flaky from time to time.  It
> always fails at the udp test and complains about the bpf@tc-ingress
> got a skb->tstamp when handling udp packet.  It is unexpected
> because the skb->tstamp should have been cleared when crossing
> different netns.
>
> The most likely cause is that the skb is actually a tcp packet
> from the earlier tcp test.  It could be the final TCP_FIN handling.
>
> This patch tightens the skb->tstamp check in the bpf prog.  It ensures
> the skb is the current testing traffic.  First, it checks that skb
> matches the IPPROTO of the running test (i.e. tcp vs udp).
> Second, it checks the server port (dst_ns_port).  The server
> port is unique for each test (50000 + test_enum).
>
> Also fixed a typo in test_udp_dtime(): s/P100/P101/
>
> Fixes: c803475fd8dd ("bpf: selftests: test skb->tstamp in redirect_neigh")
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>
