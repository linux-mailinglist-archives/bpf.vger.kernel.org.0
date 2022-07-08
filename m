Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE9156C3F0
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 01:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbiGHWVD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 18:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbiGHWU7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 18:20:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD042A2E61
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 15:20:58 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e15so170306edj.2
        for <bpf@vger.kernel.org>; Fri, 08 Jul 2022 15:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ZOuIw50PiUE4fvxUFx4PNXHitJXDQa6UVMY8YoBCRg=;
        b=XRDnBwmpulJ4oXbgTGdNSVfhX5dxToQaIXq8baMOvbOchb2EQ4b2OlKMvmAMujAwr4
         1WvBzicQHKCpgTLoGVA+puQWrR1bchygpUaZkvzeA5ydZeSPU/1uRY2By1gaZWPiyVLy
         P3vCl+HkCyGqHvkUfSJaAHUjc5i63XgSI9pwhe8AnrAGCvBrR/wfgF3HwEIiKfHx/OqH
         GszR2HfP7XX8OsU3blhqpaqnItT4qHGdxsMPtyslE1DPqIrGt3QiffPG34xvGl7HF6xm
         m/lfSJ+xbiyptNEFi12jddrgL7T4ZDMNzzhqyo0xpJeKWWrt9N+4vKKF5Z/f2OuXDv5O
         TPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ZOuIw50PiUE4fvxUFx4PNXHitJXDQa6UVMY8YoBCRg=;
        b=5w/537qjOmxd3Qw6+7eRsFp3ZWCXDrAOVmgokTOUnW6ooBB69JBAnv2SJ1S2LUziMA
         ZuecsctPIDaDUlRlTBfBoYFiFs3dz1T09Bg+bsBuWdLKyJbX5O7d065mFeCo5QlP45TH
         N3DBBJqIleo1muxueA9cC0QqCR8J02Cin4ejFS9Y4aIUs5Qw2IRpTfmGF9CdqOQmN6LH
         JUWnKfYNT5VAW2fuzSZJHDfhvaXcbnPexezHPG+ZCGtAyvfN8bZGDaEBITFgK8kFS9Hs
         SHY4lAuu/0L6xzB67ACmcBAeBHxWvLwHI7vaR0CRH63GG5YShN4MryvKVmWPOdMiutaw
         +KYQ==
X-Gm-Message-State: AJIora85W4K6WijUMYyOTeLrkrBPfOwOV6Tb0iVk/WM452cjCxoi8Vta
        RXR/kWnQttEcNRVUIOHNmJkSGP/MubVaxAnS7+HWx28oRYA=
X-Google-Smtp-Source: AGRyM1v29c8ebogjtpMOY3+Qxj+qrTBBJsFS9zhVzJsPUOOj3rADFfLprgoVGXhXnQgcK1B/q12cySSfKK0XJqIn1l0=
X-Received: by 2002:a05:6402:510b:b0:437:28b0:8988 with SMTP id
 m11-20020a056402510b00b0043728b08988mr7769061edd.260.1657318857322; Fri, 08
 Jul 2022 15:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220704140850.1106119-1-hengqi.chen@gmail.com>
 <CAEf4Bzbo0GbLv0YdyLLZq8myGK=eGz_GgYbifw1LMu2Adxhjvg@mail.gmail.com> <111d4f5b-f174-128b-166b-65f91ce965fa@gmail.com>
In-Reply-To: <111d4f5b-f174-128b-166b-65f91ce965fa@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Jul 2022 15:20:46 -0700
Message-ID: <CAEf4BzYrpMXOVTF+JKuEjiLkr=F5XOeRsEhMOtW5nNcuqtmXzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Error out when missing binary_path for
 USDT attach
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
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

On Wed, Jul 6, 2022 at 12:08 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Hi, Andrii
>
> On 2022/7/6 13:05, Andrii Nakryiko wrote:
> > On Mon, Jul 4, 2022 at 7:09 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> >>
> >> The binary_path parameter is required for bpf_program__attach_usdt().
> >> Error out when user attach USDT probe without specifying a binary_path.
> >>
> >
> > This is a required parameter, libbpf doesn't add pr_warn() for every
> > `const char *` parameter that the user incorrectly passes NULL for
> > (e.g., bpf_program__attach_kprobe's func_name). If you think
>
> I understand this is a required parameter. The intention of this patch is
> to avoid coredump if user passes NULL for binary_path argument, not just
> emit a warning. The uprobe handling code of libbpf already did this.
>
> BTW, most of libbpf APIs do NULL check for their const char * parameters
> and return -EINVAL.

Even some of pretty old APIs like bpf_program__pin() don't do that for
path. But ok, given bpf_program__attach_uprobe_opts() checks
binary_path for NULL, let's add check and return -EINVAL. But let's
skip pr_warn(). And while you are at it, can you move the binary_path
check in attach_uprobe_opts up, it's weirdly nested in func_name
check, not sure why is that, tbh. I'm not sure uprobe attach can even
succeed with NULL binary_path, so it's weird that we don't always
reject it.

>
> > bpf_program__attach_usdt() doc comment about this is not clear enough,
> > let's improve the documentation instead of littering libbpf source
> > code with Java-like NULL checks everywhere.
> >
> >> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> >> ---
> >>  tools/lib/bpf/libbpf.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 8a45a84eb9b2..5e4153c5b0a6 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -10686,6 +10686,12 @@ struct bpf_link *bpf_program__attach_usdt(const struct bpf_program *prog,
> >>                 return libbpf_err_ptr(-EINVAL);
> >>         }
> >>
> >> +       if (!binary_path) {
> >> +               pr_warn("prog '%s': USDT attach requires binary_path\n",
> >> +                       prog->name);
> >> +               return libbpf_err_ptr(-EINVAL);
> >> +       }
> >> +
> >>         if (!strchr(binary_path, '/')) {
> >>                 err = resolve_full_path(binary_path, resolved_path, sizeof(resolved_path));
> >>                 if (err) {
> >> --
> >> 2.30.2
>
>
> --
> Hengqi
