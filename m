Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D8757A826
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 22:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiGSUVC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 16:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiGSUVB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 16:21:01 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA253719B
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 13:21:00 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sz17so29310653ejc.9
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 13:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AcXwQcGrXewSZkVRWGQaRmreUYyrqx5ExBA+agIpqog=;
        b=g4G1et/FDsXX1L8hv3ZsPvt5A3OU4VH1favXJE6HuUaj2fsKwf687PzQm2RVJBySfN
         67HJ9jy3Xnx2+C9vzhAdMR2MUnOVuQdVVpimohzyUkLqVyliNjduJiYYAnUB3KR1PuVm
         c/jtWaYhkcU6bZQxAU09Uq4PqHCJVlW1PwDkcI5cmTrqp2FTH6po+P/idgDvs06pN8B8
         6QfzCGFLr0+xMC2X3SrDeoXRGQhaalXfu527weV4G2d5/eLmPe5Nwt3Vld0MGBM/cDy6
         5k+oK166V1e+JnumVuKJJywmRCcPiGYv9XrE6Icf7NKqWysczfKiJbaq1fAoRi8ZOrtG
         IJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcXwQcGrXewSZkVRWGQaRmreUYyrqx5ExBA+agIpqog=;
        b=OX18TZQVaI20Ouc+8uFSgEkF3uWHgoLWn6dQRBfvc1VK4RLOw+0CScqNIzeEI64/O5
         SQq/IE/QfY11ogBYuwwWnkW44eyG5lua57IHJRc4V0pl7ABeyTnJ+MIC+XtU213QUNC6
         Vt7DT3NO7ggkVhiuwLB7mF8+BWjMHmHmnGtFISEmRLsYM1Xgakp84HoSQD5Ysc01uIhL
         il3oNDjrhTJmFBUtL3LucNOsWA3PiMe+jj6ez7sZKfuCTu6n1Um8BXpSQz+pecB8yIab
         XUUIPhKkyquZ9IS9ClnRtFfoXnFw+1937Auu7QrYicWyn5ZVzF9fM9GI7DWc9s716xq9
         4/+w==
X-Gm-Message-State: AJIora/qANwuK8APOri2hTFboAcDn2rqv1pFpnQk6qRT/n17Voz5Tbk/
        x6j2ybTHG5XTBWdA3r1vwaz3Q5pq1Od3in0yrs0=
X-Google-Smtp-Source: AGRyM1tGbFRsRl5SELxUMdlEIURgHAFBaSBIhVIfmSS6OS1XRXJzo//rjcnRTvru+P8h/BLUPyrHy1N1kac9Yor/CQU=
X-Received: by 2002:a17:907:971c:b0:72b:83d2:aa7a with SMTP id
 jg28-20020a170907971c00b0072b83d2aa7amr32759949ejc.633.1658262058654; Tue, 19
 Jul 2022 13:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220718190748.2988882-1-sdf@google.com>
In-Reply-To: <20220718190748.2988882-1-sdf@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 19 Jul 2022 13:20:47 -0700
Message-ID: <CAADnVQLxh_pt8bgoo=_CS3voab7HuQautZGfHQMM=TmQmVr2pQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] RFC: libbpf: resolve rodata lookups
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>
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

On Mon, Jul 18, 2022 at 12:07 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> Motivation:
>
> Our bpf programs have a bunch of options which are set at the loading
> time. After loading, they don't change. We currently use array map
> to store them and bpf program does the following:
>
> val = bpf_map_lookup_elem(&config_map, &key);
> if (likely(val && *val)) {
>   // do some optional feature
> }
>
> Since the configuration is static and we have a lot of those features,
> I feel like we're wasting precious cycles doing dynamic lookups
> (and stalling on memory loads).
>
> I was assuming that converting those to some fake kconfig options
> would solve it, but it still seems like kconfig is stored in the
> global map and kconfig entries are resolved dynamically.
>
> Proposal:
>
> Resolve kconfig options statically upon loading. Basically rewrite
> ld+ldx to two nops and 'mov val, x'.
>
> I'm also trying to rewrite conditional jump when the condition is
> !imm. This seems to be catching all the cases in my program, but
> it's probably too hacky.
>
> I've attached very raw RFC patch to demonstrate the idea. Anything
> I'm missing? Any potential problems with this approach?

Have you considered using global variables for that?
With skeleton the user space has a natural way to set
all of these knobs after doing skel_open and before skel_load.
Then the verifier sees them as readonly vars and
automatically converts LDX into fixed constants and if the code
looks like if (my_config_var) then the verifier will remove
all the dead code too.
