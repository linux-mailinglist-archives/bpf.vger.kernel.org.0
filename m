Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9EE6466D8
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 03:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiLHCTT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 21:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLHCTS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 21:19:18 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE1D60E91
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 18:19:17 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bp15so31550416lfb.13
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 18:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FcyJD2XKm/5PaBLSpU/CQAkVZDiSDoWw43y2P+C6cpw=;
        b=otk2Pei8TYsjLNUO9h6guWVawQCmFiWTDAnre4lmV2tTHdZa0tKCQpFNdZkJznSELw
         6RegAalUqtYG1OUyteNrce5MnDKxVFCuWfwK0APeboqm3LE9HbGoGSeRUgSVtNPXKCA1
         AsYU+xH2qVcS9cefWOzqFqm+/SlRcr02B3dxi3okoF+tH5LqLc7DoFYwDQVxusWqw8Vg
         c4QZF0TpXH4+IOqVF2SYKw4KK8Vx1DOhtX19QVcE6JOlILUzf7LKyiv2gVx1j11GB+c7
         A76Azc2Xlzg6D+fp1w8ge2+PBTtQjxDcgDbYchqp1oAwFNQsWd1bG4aNqYydcdl+0kg0
         3DCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FcyJD2XKm/5PaBLSpU/CQAkVZDiSDoWw43y2P+C6cpw=;
        b=TsnVJRmcR3mIRIalQDmie33CrLwYkRBO56+/RmZnwPTWRms6tDwqjPGGuwNRhtZXy/
         QFV3SKovUPpv9ga8lTWah+UjfKLROxM7yd9GMbUSGHwnSPDFHUHA70ZMK+JEO8cumcQy
         sE4T4ON4YPFHNJnxI8ZNvCmibmtC0Oyh6oVAHioXrDunCKjMXT6LnyMNC31GDFNQohGw
         O+ansF3IXioKw0ESxeHLzqhsGqfuwryC8nRkek+27G11R6iltqgSucXcApbsjnRYVBIq
         CvCCbqCv9CcfjgmH1ONCtwwkePvDDRiqbC+iVv7WuTXN9mJvMxrgI4NFNoYs8Aq0mbdj
         FLnQ==
X-Gm-Message-State: ANoB5pmsE2aNDj45b5xwemZhU8UHrCN2dFk1ckPB3xbgFKeRFLpvTgya
        eYOojf/WKgU3gMcL9ysLx2JPpfti7XIqzaFl84fDHw==
X-Google-Smtp-Source: AA0mqf4EZnMpXyah8TbG2PWlPfdSmR1yfoNsueO8uMYeMakxGlZ58EsFfhLz/tsBaxSn8FiNzYfe9aSm6Nsmuj/pzgo=
X-Received: by 2002:ac2:46f2:0:b0:4b5:7fde:9568 with SMTP id
 q18-20020ac246f2000000b004b57fde9568mr4389796lfo.139.1670465955228; Wed, 07
 Dec 2022 18:19:15 -0800 (PST)
MIME-Version: 1.0
References: <20221109024155.2810410-1-connoro@google.com> <5708a47d-5400-e75e-ccf6-96177366ea38@meta.com>
In-Reply-To: <5708a47d-5400-e75e-ccf6-96177366ea38@meta.com>
From:   "Connor O'Brien" <connoro@google.com>
Date:   Wed, 7 Dec 2022 18:19:03 -0800
Message-ID: <CALE1s+NfHYpE_=fNr47U2groVDwhdHJJDSo6-2gdN8mR5G700g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: btf: don't log ignored BTF mismatches
To:     Yonghong Song <yhs@meta.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 9, 2022 at 8:45 AM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 11/8/22 6:41 PM, Connor O'Brien wrote:
> > Enabling CONFIG_MODULE_ALLOW_BTF_MISMATCH is an indication that BTF
> > mismatches are expected and module loading should proceed
> > anyway. Logging with pr_warn() on every one of these "benign"
> > mismatches creates unnecessary noise when many such modules are
> > loaded. Instead, limit logging to the case where a BTF mismatch
> > actually prevents a module form loading.
> >
> > Signed-off-by: Connor O'Brien <connoro@google.com>
> > ---
> >   kernel/bpf/btf.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 5579ff3a5b54..406370487413 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -7190,11 +7190,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
> >               }
> >               btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size);
> >               if (IS_ERR(btf)) {
> > -                     pr_warn("failed to validate module [%s] BTF: %ld\n",
> > -                             mod->name, PTR_ERR(btf));
>
> I think such warning still useful even with
> CONFIG_MODULE_ALLOW_BTF_MISMATCH.
> Can we use pr_warn_ratelimited instead of pr_warn in the above to
> avoid excessive warnings?

I gave this a try on a Pixel 6 but I'm not sure it quite addresses the
issue. The amount of logging doesn't seem to decrease much, I think
because the interval between loading one mismatched module and the
next can be greater than the default rate limit. To my mind, the issue
is the total volume of these messages more so than their rate.

For context, Android devices using the GKI may load hundreds of
separately-built modules, and BTF mismatches are possible for any/all
of these. It was pointed out to me that btf_verifier_log_type can also
print several more lines per mismatched module. ~5 lines of logging
for each mismatched module can start to add up, in terms of both
overhead and the noise added to the kernel logs.

This is more subjective but I think the warnings also read as though
this is a more serious failure that might prevent affected modules
from working correctly; anecdotally, I've gotten multiple questions
about them asking if something is broken. This can be a red herring
for anyone unfamiliar with BTF who is reading the logs to debug
unrelated issues. In the CONFIG_MODULE_ALLOW_BTF_MISMATCH=y case the
flood of warnings seems out of proportion to the actual result
(modules still load successfully, just without debug info) especially
since the user has explicitly enabled a config saying they expect
mismatches.

If there needs to be some logging in the "mismatch allowed" case,
could an acceptable middle ground be to use pr_warn_once to send a
single message reporting that mismatches were detected & module BTF
debug info might be unavailable? Alternatively, if we could opt out of
module BTF loading then that would also avoid this issue, but that's
already been proposed before ([1], [2]) so I thought working with the
existing config option might be preferred.

[1] https://lore.kernel.org/bpf/20220209052141.140063-1-connoro@google.com/
[2] https://lore.kernel.org/bpf/20221004222725.2813510-1-sdf@google.com/
