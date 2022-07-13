Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA04E573CD8
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 20:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiGMS7b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 14:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiGMS7a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 14:59:30 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE332B606
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 11:59:27 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y8so15302699eda.3
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 11:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bo9pob7wUa7+gIR5S4uYcEPlCknUmzXXnn8/iPFP7CA=;
        b=ie95XXLYQ5mKiZLpBIrqgT3wbLFCApToA1Pgmx4j4uxKbUr7NDgvZRz5dHuT6EoZp0
         rUfjXNFFKNjcCogi3ie2wdlV+6rdInoltqXsmaHecbU5WE5frBEPNs6pTymC6DrJ4qTj
         PKNgtVjqMptyOwCOEWUCifI8/hK+eRTUTgHfsEKwI8rLvGjhpYnFG86BVgcp9OD/LBZQ
         8oAsBM93xcRV5QSvs0ezW59UFdyUnXyV4tKiAwDQRg/ISvFCqy4blO1rqx+auEw2wh68
         It5uSB4d4TDJcA0WG5l8NN/D/2S+Ot+HcuulbCsEGk8YNcRXBy6WsqE2HmETsU+8wPU6
         OYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bo9pob7wUa7+gIR5S4uYcEPlCknUmzXXnn8/iPFP7CA=;
        b=CPhhISIaiVN6kXwY+q5QbsW24FJKpl9P/InTQ5NqoTPI6GkW1zq8gyUf7PmHJ6bSfW
         OnvUoIUx0GbnaiU0FP9CscUdLLcXDI3v8iz8Ep2YrzTxpJ6hnBP/6/bUIXatLAYsDcy2
         bUa+N3neOtHQ6btxaSlssMFxLjKLt1PmddE6BLGzQ5J51x1Zf+mZO+aS4cRC5pGSTNj0
         AvgfFRDfAxdX0poedTCgjKDx4MnlVu05I90/z47DG/ELItbhXGqEKs25idavjPu9zpbB
         4xaCNfbYWOZwdfj/7xrsvQkc5jILwMPwapPk0K7NoIe+Pg1RclkMsaf48FXnqcEHR+V2
         Ahfg==
X-Gm-Message-State: AJIora/yEDc/jYnPhU8X1g2eKCLJoPjreCmgzgpNKpvu5aaMikcsyloK
        qQGc1TEK4C8CD2vKcvMTRKSHXiQkArzwSIjTU9M=
X-Google-Smtp-Source: AGRyM1tmGY+rmW77F3rewDqYHKpfnrTV3+ngJJZdGOx2KvSmXr+MRnwz5vbhojs1LkjZt5nsyU5ibh6OJJlfZhmMTtQ=
X-Received: by 2002:a05:6402:1c01:b0:43a:f714:bcbe with SMTP id
 ck1-20020a0564021c0100b0043af714bcbemr7125782edb.14.1657738766563; Wed, 13
 Jul 2022 11:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220712025745.2703995-1-hengqi.chen@gmail.com> <Ys0poNMCnkNUQ1VE@krava>
In-Reply-To: <Ys0poNMCnkNUQ1VE@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 13 Jul 2022 11:59:15 -0700
Message-ID: <CAEf4Bza+9A7kYggsiWO7uG6NfxRqa28oNy5AXx90k8bFNgkcDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Error out when binary_path is NULL for
 uprobe and USDT
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Hengqi Chen <hengqi.chen@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
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

On Tue, Jul 12, 2022 at 12:58 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Tue, Jul 12, 2022 at 10:57:45AM +0800, Hengqi Chen wrote:
> > binary_path is a required non-null parameter for bpf_program__attach_usdt
> > and bpf_program__attach_uprobe_opts. Check it against NULL to prevent
> > coredump on strchr.
>
> binary_path seems to be mandatory so LGTM, cc-ing Alan to be sure ;-)
>

Right, what will happen for attach_uprobe with NULL binary_path is
that it will be passed as zero to perf_event_create() and kernel will
reject it with -EINVAL. So this looks all correct to me, applying to
bpf-next.

Thanks for the fix!

> thanks,
> jirka
>
> >
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index cb49408eb298..72548798126b 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -10545,7 +10545,10 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
> >       ref_ctr_off = OPTS_GET(opts, ref_ctr_offset, 0);
> >       pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
> >
> > -     if (binary_path && !strchr(binary_path, '/')) {
> > +     if (!binary_path)
> > +             return libbpf_err_ptr(-EINVAL);
> > +
> > +     if (!strchr(binary_path, '/')) {
> >               err = resolve_full_path(binary_path, full_binary_path,
> >                                       sizeof(full_binary_path));
> >               if (err) {
> > @@ -10559,11 +10562,6 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
> >       if (func_name) {
> >               long sym_off;
> >
> > -             if (!binary_path) {
> > -                     pr_warn("prog '%s': name-based attach requires binary_path\n",
> > -                             prog->name);
> > -                     return libbpf_err_ptr(-EINVAL);
> > -             }
> >               sym_off = elf_find_func_offset(binary_path, func_name);
> >               if (sym_off < 0)
> >                       return libbpf_err_ptr(sym_off);
> > @@ -10711,6 +10709,9 @@ struct bpf_link *bpf_program__attach_usdt(const struct bpf_program *prog,
> >               return libbpf_err_ptr(-EINVAL);
> >       }
> >
> > +     if (!binary_path)
> > +             return libbpf_err_ptr(-EINVAL);
> > +
> >       if (!strchr(binary_path, '/')) {
> >               err = resolve_full_path(binary_path, resolved_path, sizeof(resolved_path));
> >               if (err) {
> > --
> > 2.30.2
