Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09186BA3DF
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 01:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjCOAHe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 20:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCOAHd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 20:07:33 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFF436472
        for <bpf@vger.kernel.org>; Tue, 14 Mar 2023 17:07:32 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x3so68952430edb.10
        for <bpf@vger.kernel.org>; Tue, 14 Mar 2023 17:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678838851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMqxFeYphb/5M5H7JE9KEQ4Hq8mMgSF27qlNGHlmNg8=;
        b=B5VbaVypugmiRnEEaFQjkT4N7q9DHWzdQnGHjxpP7B0NM+b70ZomniNoMJ/QDYVS6O
         1BYxeBj2Thh4kz+rMU1ZH8VE3vMfXd1xlzbqgf9rD8jKrz0tIw/AKIf45sjYVAHfLqwQ
         L4Wq//ZDhQ05CUYW+QSVEirol8f6BTAdy16JagiF0JCAV7ZCOvBsSt36KOd1dqGA0sBB
         fBe+zl6q+fPMC7V6TG3VRkYoJF8nSRHnumpr56KeSX4adJyn4Xl66WFf5Z/jrKPq70wA
         DQQUptAwz5WfWNua1ZZifUV6+SqDSyji9d3Xvcr9iFhRpnfjSLnNe0hz73JmlUZEcxyZ
         RSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678838851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMqxFeYphb/5M5H7JE9KEQ4Hq8mMgSF27qlNGHlmNg8=;
        b=5jcPMFQ2TnZ5hXCJmzwm2jO/lIz+TGPHIRYRyT7CGvOSs+sZCjwcj+dmoRktynSuAb
         nybWsbpzBL8Rzznc5dFjQJoUdJmomGQ8UhiKlLMJG8XULnBVjXEAkP9i8200lKuMdTN1
         a1adKHs82SMzOrnWaI9Fp93Jxni9kNqtnCC3eqq6z6ObSj/dfqX69avKwizEWNVcbuab
         BoBctWOzAy7ZknXhDRZLH46kEBvm/WqVPMKN5XHFpd1JBZzDKsStxeCl2Xp5ov66ixF3
         XH9l1J3IlQTXMdrqlKdYEhmIOMsXnzIZYc+H1Mk2eccyH0aRpuNoBPadkAhlbntfVHEj
         b/mQ==
X-Gm-Message-State: AO0yUKW+2hjpJPxlelcgBzxhlHDWqzP3JzVlXwrmBnGwtu1dy8HBdxkP
        BxwDeNZqlnxuHeMzqZD2tUr8RvqBHUHqSxfT2eM=
X-Google-Smtp-Source: AK7set8H72p6eoOvY05M2d545GirCdawH5ap60W8cXf47Yc4I/Gy+/1oW8hahj7BMYLET+d9b29x22KSYQvQJnzhrPA=
X-Received: by 2002:a17:907:a077:b0:88d:ba79:4317 with SMTP id
 ia23-20020a170907a07700b0088dba794317mr2422825ejc.7.1678838850990; Tue, 14
 Mar 2023 17:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230313214641.3731908-1-davemarchevsky@fb.com>
 <167875201690.9292.11466523661883628604.git-patchwork-notify@kernel.org> <641007aa17a0a_42581208a0@john.notmuch>
In-Reply-To: <641007aa17a0a_42581208a0@john.notmuch>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 14 Mar 2023 17:07:19 -0700
Message-ID: <CAADnVQJE6Vo_wxeEcyCnrQB+PeAfRuz=X_jknUXj2zFjRR0CdQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next] bpf: Disable migration when freeing stashed
 local kptr using obj drop
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     patchwork-bot+netdevbpf@kernel.org,
        Dave Marchevsky <davemarchevsky@fb.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 13, 2023 at 10:35=E2=80=AFPM John Fastabend
<john.fastabend@gmail.com> wrote:
>
> >
> > Here is the summary with links:
> >   - [v1,bpf-next] bpf: Disable migration when freeing stashed local kpt=
r using obj drop
> >     https://git.kernel.org/bpf/bpf-next/c/9e36a204bd43
> >
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
> >
> >
>
> Alexei is quick but FWIW LGTM as well.

Thanks for the review.
Just want to remind everyone that "patch in the tree"
is not a final stage. The patch can be reverted and if there are
review comments they need to be taken just as seriously as
before the patch was applied.
