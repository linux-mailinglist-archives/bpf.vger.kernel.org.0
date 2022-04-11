Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AD54FC6BA
	for <lists+bpf@lfdr.de>; Mon, 11 Apr 2022 23:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243372AbiDKV2X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Apr 2022 17:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244205AbiDKV2W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Apr 2022 17:28:22 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2E7329BE
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 14:26:07 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h5so14339724pgc.7
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 14:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DyjG5QxouCWLjH6WbGp8H0dyl9aGtlSAU5083aT5q0E=;
        b=mR/CpOhozi4gNNUC2rSGRIDnUgHivivJm/WbyzIaLp0AhqLl7TEa5IuNjx5ebeho4u
         M6ZrPCHs3RbScPeUok5SaBrwA4PnVtR3feVn75LvxRCNjLRxmxfmMqtmq2UlxCwF5sG3
         uVZs2kYg/AMXhxRYjH37arMaORYrWOk8XnWC/Wy/BoY1503H8AYipiYoqxQEXGNEP29k
         bu3byElNLaTFsq2r4lrjXys5eRhpxTYdHSxMvZPdp6XAlnrjbnKsCWElwWsuopJin7Ij
         o2rJw1/ZgK+I9qZYncAG+ZOjssVI5isFY6GkUCt+pnv2sm63m/ST2o8fwe2uYx09LjR5
         7X/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DyjG5QxouCWLjH6WbGp8H0dyl9aGtlSAU5083aT5q0E=;
        b=vX6v9saD3MiFKxDTgINGyzjTgoY9xxP+ofPCmPlLf4+B+AqNT3oA9UNTd4qDrQrqVT
         +DfATnS7L+X8Z0sG7d8YY/IkUmWvDVPTCJ471sXusFKFcxZo9rj5neG2re/mW3tS4TzS
         sxZgTYexrqJZWLpX1BylD4CZQDJhNXXNMK5LYEvG9vbvbNoX8UQv0ULAk9X93484zTlT
         OWn2J/tfFeJfEfAHHfr4XgSlq+YZvTomM4N5NWUfHqqUVNLpeYuV3vGWJj+Ba0tSTof6
         Y51e9OHGLDGyI4emOJXdF9D8zORlZwsL/TjTibLFR0Vrw2ihLKVZMv9zImYJh58Cdtgo
         qBcA==
X-Gm-Message-State: AOAM533qCvjV5/6mGLnCTqu0FqNhcJcJdId8p3unCMwaC7GNOhNUJcyo
        JVfNbACJbY1v1na1SWBpexLvyIjMcRcKCjPN3Pc=
X-Google-Smtp-Source: ABdhPJxI2FynOwILwM5KS7SLPGLQI4AEYooN2cuUvxy+xTu8BErZPVWlDjwRN91sj3fvnGqGb1EnR17NxxNMwsAYB2E=
X-Received: by 2002:a65:6bd6:0:b0:39d:4f85:9ecf with SMTP id
 e22-20020a656bd6000000b0039d4f859ecfmr6330928pgw.336.1649712367210; Mon, 11
 Apr 2022 14:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220411173429.4139609-1-kuifeng@fb.com> <20220411173429.4139609-3-kuifeng@fb.com>
In-Reply-To: <20220411173429.4139609-3-kuifeng@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 11 Apr 2022 21:25:56 +0000
Message-ID: <CAADnVQJYpsdUh9+vt8Majj+M5XoFxHjjjDQ7=4H+uG3HAhL4OQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/5] bpf, x86: Create bpf_tramp_run_ctx on the
 caller thread's stack
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Mon, Apr 11, 2022 at 5:35 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
> -u64 notrace __bpf_prog_enter(struct bpf_prog *prog)
> +u64 notrace __bpf_prog_enter(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
>         __acquires(RCU)
>  {
>         rcu_read_lock();
>         migrate_disable();
> +
> +       if (run_ctx)
> +               run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);

3rd time the same comment.
Looks like you're missing my emails.
Please fix your email filters.
