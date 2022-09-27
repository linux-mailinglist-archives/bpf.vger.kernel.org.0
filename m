Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5C15EC988
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 18:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiI0QcI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 12:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiI0QcF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 12:32:05 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B6615E47B
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 09:31:57 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id v192so5202464vkv.7
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gJGC+/Ouclic1G5NWcA8mI3gdxQgzeDHMig0k5vptUA=;
        b=nGzR7oxGt/o7u3ABAt2N1Vg5+IZSQD3Jo+JpBaU/cVEK29h6TwQQ1BRGnKOrkr3miq
         S8Z6VTFF/L2CsB5uxn3aZ9BzRR5mp0owoj+t+pQMZKSyrc2GX2p+bBxZ7R8CBp6Bs7dD
         DB0FOUsRmbXvtmkTdSoHxs3m6lGEeLyO49c+hWC5Ymc+ewJMH2VQvq3THYFgYRFRtWHn
         J+yOhdF0wDmEPDcRvE69yu2xsVuyWxsxta/3Yr85sfdodCUzwOVN6DyiTJx/OOQjHNJo
         mroYjhVFEE3pKPa+Azjsgpi7NK4S0bjFX+dYnYkn+ljhof9h+qA4Sj/Y3Yhh+K0t7jip
         VL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gJGC+/Ouclic1G5NWcA8mI3gdxQgzeDHMig0k5vptUA=;
        b=a6aUAjK7eWnY2IY9+W+Hjhb5F58GUr4kgnlVs3xcG8wJ8DCfOdcfE2nxlcUVwgPoK1
         VAGhv/AjojpF+R89EKnGLDezXuPl97qJZrLBMITVe+QQLS44qbGxRklCl9IcZTnQRuaI
         ognaBDPvJt727eVUSswd+t6kGq0lm4tppZEwunWZ19YRKuUyyQ6i6Mm4FxIpbFHKxFFu
         arWNt5y4K7FJF/IoJHalvhsce+Rt3vOrXgSO5MfYcsWedKKNXQEGIsMUrQaYQGEf+Wqw
         9xf4C3+FcLnNlI0sx4aTsho7PnNGXIIc+TrUU/e0FqggR8oh7cv3hGA1A93ea4F7RvNk
         hNeQ==
X-Gm-Message-State: ACrzQf0McdNOcSq0MuOBc6WtTBsO4YCSt7ZhXjW8UUreT2H+U+/PtTe9
        n6xD4qz08qPh1CRz8/pOcJIBRMJdDfW2DkyjBWI=
X-Google-Smtp-Source: AMsMyM7X8AGMyGZnbzXxf0AwPAIk70tgFnBHIzeLQBzMGDWgA81/eZ7HRQsedGzYg7m5gECp32ReMuv1aAqui3mjiGk=
X-Received: by 2002:a1f:a387:0:b0:3a7:9e05:805f with SMTP id
 m129-20020a1fa387000000b003a79e05805fmr5554711vke.29.1664296316150; Tue, 27
 Sep 2022 09:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAK3+h2z-y0VdTteSF2Bna3dF-n4XKU5x6wZOzu8q+_BCUg3G6A@mail.gmail.com>
 <YzMbnJLL1yYmT9L4@krava>
In-Reply-To: <YzMbnJLL1yYmT9L4@krava>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Tue, 27 Sep 2022 09:31:45 -0700
Message-ID: <CAK3+h2xfbUE5OopdV+1awhgh2odnSUUps67mHYmGZfC2HpX9mQ@mail.gmail.com>
Subject: Re: Multi kprobe ftrace_lookup_symbols question
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
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

On Tue, Sep 27, 2022 at 8:49 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Tue, Sep 27, 2022 at 07:58:23AM -0700, Vincent Li wrote:
> > Hi,
> >
> > I have sample code like below to give duplicate "vprintk" symbols to
> > multi kprobe attachment, it results in ESRCH return from
> > ftrace_lookup_symbols, I assume it should be user space code
> > responsibility not to feed kernel with duplicate symbols, correct? the
> > sort_r() in  bpf_kprobe_multi_link_attach() seems not to remove
> > duplicate symbols.
>
> hi,
> correct, symbols must be unique, ftrace_lookup_symbols (kernel/trace/ftrace.c)
> will fail if there are duplicate symbols on input
>
> >
> > import (
> >
> >         "fmt"
> >
> >
> >         "github.com/cilium/ebpf"
> >
> >         "github.com/cilium/ebpf/asm"
> >
> >         "github.com/cilium/ebpf/link"
> >
> > )
> >
> >
> > func detectKprobeMulti() bool {
> >
> >         prog, err := ebpf.NewProgram(&ebpf.ProgramSpec{
> >
> >                 Name: "probe_bpf_kprobe_multi_link",
> >
> >                 Type: ebpf.Kprobe,
> >
> >                 Instructions: asm.Instructions{
> >
> >                         asm.Mov.Imm(asm.R0, 0),
> >
> >                         asm.Return(),
> >
> >                 },
> >
> >                 AttachType: ebpf.AttachTraceKprobeMulti,
> >
> >                 License:    "MIT",
> >
> >         })
> >
> >         if err != nil {
> >
> >                 return false
> >
> >         }
> >
> >         defer prog.Close()
> >
> >
> >         syms := []string{"vprintk", "vprintk"}
> >
> >         opts := link.KprobeMultiOptions{Symbols: syms}
>
> you can resolve all 'vprintk' functions yourself and attach it through
> KprobeMultiOptions::Addresses array

Thank you for all your clarification!
>
> jirka
>
> >
> >
> >         _, err = link.KprobeMulti(prog, opts)
> >
> >         return err == nil
> >
> > }
> >
> >
> > func main() {
> >
> >         if detectKprobeMulti() {
> >
> >                 fmt.Println(" it works\n")
> >
> >         }
> >
> > }
