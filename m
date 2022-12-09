Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4DE647B14
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 02:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiLIBBY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 20:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiLIBBX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 20:01:23 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089E6A505C;
        Thu,  8 Dec 2022 17:01:22 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id kw15so8015558ejc.10;
        Thu, 08 Dec 2022 17:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XYnHw3A5Lj4PgcMhioL366GqKUQvej2q/D65GgF3JY8=;
        b=S/pkZvXLNrFgNz4jW0sLD2ZTMZSD8cMwNLSvKIp5qYnBWWrI8wY3yOu1iGtia8rq7F
         IXY5PbheWWGPkT+kKJw6TGLxWldyYhrVEO4wAsOKY7W6A+Led3GqjId3uTuNNZaspHcJ
         o1fQyfCLunRQLNNC1jdw8yP99HFDAd5xa3eyXpsovgnzilF+57c97/iN9KdZjLrAQxa3
         8oG3xSWmi9lPW2BrrkBpAmz7nGzdqsdiv0eZRdw5RxBASOWZO6xlGv3cJlXUHswr8CYk
         Tre7vI4nSP9nLKd/Iy1RfM2m01ixuSQdqZx6rm8SHRfjrD10Nvn++968VtuW003cUPpm
         cnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYnHw3A5Lj4PgcMhioL366GqKUQvej2q/D65GgF3JY8=;
        b=JmSPT0c50WRfFyOjZzpflbz2FFPEUCXk2YrrtVKYFPYykARNCnhyrhka6zi6sLLvsT
         SbjAg66IQhwD0T+340z+ibOYi7/rsFe29+fP+tWVSUbFA46hAUL33oHb92qnIUR25WK/
         e++YDk8fW+s03A6DRLjRdIcWJ5SDiY/g7smXVy9ZYf3H0Z9XEqo00vWEO2dJg9HBvcSf
         aD5ePKRvSHcvTC4xo+o9MfWtIv943te0QYjttoEeQ3/Q8oLI9CqFvK9HO6KRrvQefgrk
         9uHonYfAwaCQpZI+psRzaRhPNup5h1iYyz/I2qpBbL0i9+/AUsLBESGHXRWyDnX4eD9C
         CjoA==
X-Gm-Message-State: ANoB5plZoZVsRV7B1rYzyYw2OhITYc5YtUlzDCP6XzEDMq7uL0fVqjt3
        Brt1vVPUBSY+CXZ3U6FZBcsOy8ypUEb4xwoJSwY=
X-Google-Smtp-Source: AA0mqf5GtaBBe+3V/UdsykawqHO7lFYMp6c5HyOtJGnSray5j24wAmsU2FlqBhZ3loGocEfcWMu7UkvtsVi3Swr/zq8=
X-Received: by 2002:a17:906:3e53:b0:7c1:1f2b:945f with SMTP id
 t19-20020a1709063e5300b007c11f2b945fmr4815746eji.302.1670547680540; Thu, 08
 Dec 2022 17:01:20 -0800 (PST)
MIME-Version: 1.0
References: <20221109024155.2810410-1-connoro@google.com> <5708a47d-5400-e75e-ccf6-96177366ea38@meta.com>
 <CALE1s+NfHYpE_=fNr47U2groVDwhdHJJDSo6-2gdN8mR5G700g@mail.gmail.com>
 <0b9023b6-9742-b317-7596-98026a0c5d03@meta.com> <CAEf4BzbTeJWkFhF-bW3mp94THeYEMM7R-ZX3C_c1aazY0Togsw@mail.gmail.com>
 <CALE1s+OrB9wBGyi2zsyyOm=F36zcES7gtwyb2mVX3j_M8pvJuA@mail.gmail.com>
In-Reply-To: <CALE1s+OrB9wBGyi2zsyyOm=F36zcES7gtwyb2mVX3j_M8pvJuA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 8 Dec 2022 17:01:07 -0800
Message-ID: <CAEf4Bza+-q4XqT_UksVTqJfKRYkx303O2PFz=jPMkPJPsAcHMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: btf: don't log ignored BTF mismatches
To:     "Connor O'Brien" <connoro@google.com>
Cc:     Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org,
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

On Thu, Dec 8, 2022 at 4:59 PM Connor O'Brien <connoro@google.com> wrote:
>
> On Thu, Dec 8, 2022 at 4:03 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Dec 8, 2022 at 10:01 AM Yonghong Song <yhs@meta.com> wrote:
> > >
> > >
> > >
> > > On 12/7/22 6:19 PM, Connor O'Brien wrote:
> > > > On Wed, Nov 9, 2022 at 8:45 AM Yonghong Song <yhs@meta.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >> On 11/8/22 6:41 PM, Connor O'Brien wrote:
> > > >>> Enabling CONFIG_MODULE_ALLOW_BTF_MISMATCH is an indication that BTF
> > > >>> mismatches are expected and module loading should proceed
> > > >>> anyway. Logging with pr_warn() on every one of these "benign"
> > > >>> mismatches creates unnecessary noise when many such modules are
> > > >>> loaded. Instead, limit logging to the case where a BTF mismatch
> > > >>> actually prevents a module form loading.
> > > >>>
> > > >>> Signed-off-by: Connor O'Brien <connoro@google.com>
> > > >>> ---
> > > >>>    kernel/bpf/btf.c | 7 ++++---
> > > >>>    1 file changed, 4 insertions(+), 3 deletions(-)
> > > >>>
> > > >>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > >>> index 5579ff3a5b54..406370487413 100644
> > > >>> --- a/kernel/bpf/btf.c
> > > >>> +++ b/kernel/bpf/btf.c
> > > >>> @@ -7190,11 +7190,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
> > > >>>                }
> > > >>>                btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size);
> > > >>>                if (IS_ERR(btf)) {
> > > >>> -                     pr_warn("failed to validate module [%s] BTF: %ld\n",
> > > >>> -                             mod->name, PTR_ERR(btf));
> > > >>
> > > >> I think such warning still useful even with
> > > >> CONFIG_MODULE_ALLOW_BTF_MISMATCH.
> > > >> Can we use pr_warn_ratelimited instead of pr_warn in the above to
> > > >> avoid excessive warnings?
> > > >
> > > > I gave this a try on a Pixel 6 but I'm not sure it quite addresses the
> > > > issue. The amount of logging doesn't seem to decrease much, I think
> > > > because the interval between loading one mismatched module and the
> > > > next can be greater than the default rate limit. To my mind, the issue
> > > > is the total volume of these messages more so than their rate.
> > > >
> > > > For context, Android devices using the GKI may load hundreds of
> > > > separately-built modules, and BTF mismatches are possible for any/all
> > > > of these. It was pointed out to me that btf_verifier_log_type can also
> > > > print several more lines per mismatched module. ~5 lines of logging
> > > > for each mismatched module can start to add up, in terms of both
> > > > overhead and the noise added to the kernel logs.
> > > >
> > > > This is more subjective but I think the warnings also read as though
> > > > this is a more serious failure that might prevent affected modules
> > > > from working correctly; anecdotally, I've gotten multiple questions
> > > > about them asking if something is broken. This can be a red herring
> > > > for anyone unfamiliar with BTF who is reading the logs to debug
> > > > unrelated issues. In the CONFIG_MODULE_ALLOW_BTF_MISMATCH=y case the
> > > > flood of warnings seems out of proportion to the actual result
> > > > (modules still load successfully, just without debug info) especially
> > > > since the user has explicitly enabled a config saying they expect
> > > > mismatches.
> > > >
> > > > If there needs to be some logging in the "mismatch allowed" case,
> > > > could an acceptable middle ground be to use pr_warn_once to send a
> > >
> > > So it looks like pr_warn_ratelimited still produces a lot of warning.
> > > In this case, I guess pr_warn_once should be okay.
> >
> > Maybe pr_warn_once generic "some kernel module BTF mismatched". And
> > also warn per-module message with details if
> > CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set?
> >
>
> Yeah, I figured the logging behavior should remain unchanged when
> CONFIG_MODULE_ALLOW_BTF_MISMATCH is unset, the existing verbose
> logging makes sense when every mismatch stops a module from loading.
>
> Then for the pr_warn_once case something like "Kernel module BTF
> mismatch detected, BTF debug info may be unavailable for some modules"

yep, makes sense to me

>
>
>
> > >
> > > > single message reporting that mismatches were detected & module BTF
> > > > debug info might be unavailable? Alternatively, if we could opt out of
> > > > module BTF loading then that would also avoid this issue, but that's
> > > > already been proposed before ([1], [2]) so I thought working with the
> > > > existing config option might be preferred.
> > > >
> > > > [1] https://lore.kernel.org/bpf/20220209052141.140063-1-connoro@google.com/
> > > > [2] https://lore.kernel.org/bpf/20221004222725.2813510-1-sdf@google.com/
