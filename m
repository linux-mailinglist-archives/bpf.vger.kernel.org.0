Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC08647A6F
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 01:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiLIAEB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 19:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiLIADw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 19:03:52 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A4B4D5C3;
        Thu,  8 Dec 2022 16:03:51 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id l11so1049052edb.4;
        Thu, 08 Dec 2022 16:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u7tp5M5h/6cg9ED5H3uvPb7Hyu+fCPDdnOUf7K9pOXA=;
        b=prhxCYh7BlRHobaWQBCq0SDdXmebnZwBykhilMcxpuNPPpSr8U8HKsWB1KWEW7uITp
         WJEokyHIMxCeSjJDYOE98G/A7dnF+pGoV1qMA6CO+sgOJ6cEX1XCRITzLvD57nSkvbK8
         KkBX+MeZGO0qsiJFu3JWqQPCmwidWvsNdsi/afkD4n+1JXD6hIVFiw7xWgUeb7RmC9NJ
         QOuQT4OM4jAYKVb3idUmXen+jPW2I+yFrqJy0wtaFb+XFGcwY9ttvJibaMQmVxUvNRcY
         siW5ZRHDnk+KEBUSF6yLLR1PEKEW8M97va3EvuPetvVl1IaiFYSTVGNfYQCJGYQ9hEb4
         K6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7tp5M5h/6cg9ED5H3uvPb7Hyu+fCPDdnOUf7K9pOXA=;
        b=brIj9tcqNUwwR8OeIWBFo8IJ0tIAKFhudng+8vqayvM0WkBRtfU3Kniv7J/DVFyZNC
         XUzpY6TuNwV6WNRC2lbuUkxF5DWuykaLT5ZdsW80cPk8WktyHWg3MS11JCqsitaaqBkx
         2bODgTBsEUwT6RoTRjEe+zAoPD8+hbQ8gOCzz8W1ivsmtwo122P21DyjgxEwM6slx/cO
         Jo74b7KCHrdsDCeMfb0v97Rh5yFSR6YmWqpXrCYG2p6yoTGl+eGMgaUgCyDhiJvmYfCb
         umKQriTCuK1402G2QfZUAYWrcLlHZaDF7iga02fy9GRfY1kNSCpRWirlPggK6yk71wHK
         3voQ==
X-Gm-Message-State: ANoB5pnRo3Wo3008JBRcWeDD9U409BzotLYVYO5Bv9VPyRnL9eNunzwH
        ztQ9eFD9Yt+tLoB40n7wQAfy9hAx0FrBJ4tKS5o=
X-Google-Smtp-Source: AA0mqf7Y5MxgWHgNRS6l8bF7NTDfIp2YQKiyMmyPnAiNIBTkMR+vA17F6K9RpJF4F+7w8VIhFCivJA+2b5P96X0WS+k=
X-Received: by 2002:aa7:d80d:0:b0:46b:7645:86a9 with SMTP id
 v13-20020aa7d80d000000b0046b764586a9mr35638966edq.311.1670544229440; Thu, 08
 Dec 2022 16:03:49 -0800 (PST)
MIME-Version: 1.0
References: <20221109024155.2810410-1-connoro@google.com> <5708a47d-5400-e75e-ccf6-96177366ea38@meta.com>
 <CALE1s+NfHYpE_=fNr47U2groVDwhdHJJDSo6-2gdN8mR5G700g@mail.gmail.com> <0b9023b6-9742-b317-7596-98026a0c5d03@meta.com>
In-Reply-To: <0b9023b6-9742-b317-7596-98026a0c5d03@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 8 Dec 2022 16:03:37 -0800
Message-ID: <CAEf4BzbTeJWkFhF-bW3mp94THeYEMM7R-ZX3C_c1aazY0Togsw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: btf: don't log ignored BTF mismatches
To:     Yonghong Song <yhs@meta.com>
Cc:     "Connor O'Brien" <connoro@google.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 8, 2022 at 10:01 AM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 12/7/22 6:19 PM, Connor O'Brien wrote:
> > On Wed, Nov 9, 2022 at 8:45 AM Yonghong Song <yhs@meta.com> wrote:
> >>
> >>
> >>
> >> On 11/8/22 6:41 PM, Connor O'Brien wrote:
> >>> Enabling CONFIG_MODULE_ALLOW_BTF_MISMATCH is an indication that BTF
> >>> mismatches are expected and module loading should proceed
> >>> anyway. Logging with pr_warn() on every one of these "benign"
> >>> mismatches creates unnecessary noise when many such modules are
> >>> loaded. Instead, limit logging to the case where a BTF mismatch
> >>> actually prevents a module form loading.
> >>>
> >>> Signed-off-by: Connor O'Brien <connoro@google.com>
> >>> ---
> >>>    kernel/bpf/btf.c | 7 ++++---
> >>>    1 file changed, 4 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> >>> index 5579ff3a5b54..406370487413 100644
> >>> --- a/kernel/bpf/btf.c
> >>> +++ b/kernel/bpf/btf.c
> >>> @@ -7190,11 +7190,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
> >>>                }
> >>>                btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size);
> >>>                if (IS_ERR(btf)) {
> >>> -                     pr_warn("failed to validate module [%s] BTF: %ld\n",
> >>> -                             mod->name, PTR_ERR(btf));
> >>
> >> I think such warning still useful even with
> >> CONFIG_MODULE_ALLOW_BTF_MISMATCH.
> >> Can we use pr_warn_ratelimited instead of pr_warn in the above to
> >> avoid excessive warnings?
> >
> > I gave this a try on a Pixel 6 but I'm not sure it quite addresses the
> > issue. The amount of logging doesn't seem to decrease much, I think
> > because the interval between loading one mismatched module and the
> > next can be greater than the default rate limit. To my mind, the issue
> > is the total volume of these messages more so than their rate.
> >
> > For context, Android devices using the GKI may load hundreds of
> > separately-built modules, and BTF mismatches are possible for any/all
> > of these. It was pointed out to me that btf_verifier_log_type can also
> > print several more lines per mismatched module. ~5 lines of logging
> > for each mismatched module can start to add up, in terms of both
> > overhead and the noise added to the kernel logs.
> >
> > This is more subjective but I think the warnings also read as though
> > this is a more serious failure that might prevent affected modules
> > from working correctly; anecdotally, I've gotten multiple questions
> > about them asking if something is broken. This can be a red herring
> > for anyone unfamiliar with BTF who is reading the logs to debug
> > unrelated issues. In the CONFIG_MODULE_ALLOW_BTF_MISMATCH=y case the
> > flood of warnings seems out of proportion to the actual result
> > (modules still load successfully, just without debug info) especially
> > since the user has explicitly enabled a config saying they expect
> > mismatches.
> >
> > If there needs to be some logging in the "mismatch allowed" case,
> > could an acceptable middle ground be to use pr_warn_once to send a
>
> So it looks like pr_warn_ratelimited still produces a lot of warning.
> In this case, I guess pr_warn_once should be okay.

Maybe pr_warn_once generic "some kernel module BTF mismatched". And
also warn per-module message with details if
CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set?

>
> > single message reporting that mismatches were detected & module BTF
> > debug info might be unavailable? Alternatively, if we could opt out of
> > module BTF loading then that would also avoid this issue, but that's
> > already been proposed before ([1], [2]) so I thought working with the
> > existing config option might be preferred.
> >
> > [1] https://lore.kernel.org/bpf/20220209052141.140063-1-connoro@google.com/
> > [2] https://lore.kernel.org/bpf/20221004222725.2813510-1-sdf@google.com/
