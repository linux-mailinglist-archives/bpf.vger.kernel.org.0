Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDA55209B3
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 01:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiEIX4q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 19:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiEIX4n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 19:56:43 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8619357142
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 16:52:46 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e194so16976181iof.11
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 16:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9pGub4GFUUocvupf+3zrxrhgAEXrBnaGHBL/Yi8og9s=;
        b=XWgqRuAu9k+JwaYK1gN7swR+9fVG3B02scMJLso4hHmjiypFykj0yXQ6FeL8AeWS4s
         tUnNe7vaSwL9b0Dn7RfLXSEO84J/vdvPmSK/pnMPy3WzHnhUNjJjNsrfzeedP2eJJM81
         4AaMBbTJ864dhsaV91NC6mydKjDbvsIwR2cHEnf3BHrMdIt7ZvGW/7TGu25lnqDY2KWS
         cHIrDjAd08IWKJ8/SSCRJlr/h4Wu87OAazEaETBC9fbnrifEH1GLF3nIad2LiBkKbupS
         5OmUrafJLKxRDir0O5/D53d0S31HGZ8rregszkp98JMCF3fstDUxzdhDTLq0nHWMQWoE
         JMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9pGub4GFUUocvupf+3zrxrhgAEXrBnaGHBL/Yi8og9s=;
        b=Hqkqp/HVpYtWtfAbeP33x2UaavxBCeqenB+Ze49U+La6gbSvefUKkmLIQyXCv1c/3b
         /39U1tWbVEflyUzG74IKudl2ejy0c0rAMYatq2sY7XP7QywlP1kq0AEB0IvYYtDX5GRM
         JwxhSlastWy7cfh39poEiYl2c1nj8xrmjhmkYk1zXG5ztLCPzNkB4Cnq8/dKtA7hilDq
         xXBQSjR7g0kNxI4Wx+OjMuPP41Akgk0hg+gdeOzrOck3oQWuuSVLv9jcdwbtu7lhw57T
         nW3WQbWx7OyYozGskFm7H5b2/c828ka3kGiCGv6MdQOe9GEAoqDoER7T5duZxWppDMqx
         1xig==
X-Gm-Message-State: AOAM533qT7q10B7aJnTwmsG7oc+iMeXpy40JYwWJGW3Nz9tHeORgXiBf
        KbQNohbc3qntT4aY7ywCRdTuqfN85F3WeigBSd4=
X-Google-Smtp-Source: ABdhPJxTlibuHXmt54w3m6QTw7fxV59r7LTBb2MGtYWN1OEvyTDK7839qe39+rGS6T72K1CpKt3enfreTDMRMKcHeUY=
X-Received: by 2002:a05:6602:1683:b0:64f:ba36:d3cf with SMTP id
 s3-20020a056602168300b0064fba36d3cfmr7401977iow.144.1652140365901; Mon, 09
 May 2022 16:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651532419.git.delyank@fb.com> <611d4629dc959f9d327693180b0d106dcefe949f.1651532419.git.delyank@fb.com>
In-Reply-To: <611d4629dc959f9d327693180b0d106dcefe949f.1651532419.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 16:52:35 -0700
Message-ID: <CAEf4BzYznOb6RZbNvFjWxg0hc64siUjoiZcAV1X5TTS7De8xBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] bpf: allow sleepable uprobe programs to attach
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 2, 2022 at 4:09 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> uprobe and kprobe programs have the same program type, KPROBE, which is
> currently not allowed to load sleepable programs.
>
> To avoid adding a new UPROBE type, we instead allow sleepable KPROBE
> programs to load and defer the is-it-actually-a-uprobe-program check
> to attachment time, where we're already validating the corresponding
> perf_event.
>
> A corollary of this patch is that you can now load a sleepable kprobe
> program but cannot attach it.
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/verifier.c |  4 ++--
>  kernel/events/core.c  | 16 ++++++++++------
>  2 files changed, 12 insertions(+), 8 deletions(-)
>

[...]
