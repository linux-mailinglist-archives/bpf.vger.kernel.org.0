Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A3467A36A
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 20:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjAXTzF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 14:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjAXTzE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 14:55:04 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A824F2E0DC
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 11:55:03 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qx13so41928079ejb.13
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 11:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1NwmGJq5GkpPDxwqC5jmIGRPpZOGpRKuvvxYGQGG0eg=;
        b=a0Izh+LMAClxoFw0a7y10VFks5z4H/X9B40id0icfAFeMjbzREMNwmjFPIYFlUlkrP
         pr71iatTufCpp7Iw0RfDiOw4xSHug1eVMTxEKGQ5ZXm7+QQqNulr58S3eIiwkb6IPnvA
         yP/pRvafiqZlgTNqm8quWTamINxmEZvhLpvRc8oMHb6AidzjBhjcnsurN6vVw//ya49d
         uXwh4vB8WT6ATIPfe9YayM+sUh7IF/VZYDjlFj83vdd9cYSgKDkiiWJuzjtXlFPhu/sH
         s3/J+lt4jHqTNomn+8We97mtya+HmOu3/3keyTypJYDbKCWsCkhNlEpusDlj9Osk/tyL
         RP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1NwmGJq5GkpPDxwqC5jmIGRPpZOGpRKuvvxYGQGG0eg=;
        b=pmQJvG2wFKnXP4xEMhziZ0JRsHPZcGQNbF/ASdxcXExwbAJUAatU1zlUhGYkToTkKh
         7k+MofuJLQiqR6Ozz00pWk6T78uNdFi2axxHGQtHUdVbrC1JhtDr9AZbG4DSk4cby41K
         QL90GyW+YPTDRnIg3U4hN/ZZUzZm1taF4QJclVyQjiBKV8V+V08DP8vQvxTdqQvTOVLp
         eRESZ5a0NOEEr6l2SrfdKa1NNwYqtcNeks40qYf9Bkg2n+EoDUiuOdkHkfzpknMT3oRG
         I3p6aef0HOyJLDwnBMUQJhSAlYQpA79gc2vF0LQObbwsXQ8aUlyryCtStCJaVoYyWOzL
         0Pdg==
X-Gm-Message-State: AFqh2kpmfNf7TninYla7DWyufhImP+nDcf2145O09LSbIefqWWM6fdhz
        BmZ5NdN+gNMxnw8AP/D2VHTCEHi+PgXQH6PIe9o=
X-Google-Smtp-Source: AMrXdXu9kFpYFDZdlVXJ97Jd/ZFlrzfiAanuHF8dPf61pDKcB4/+PGJsp1dn+woY9o78jAMNLW9rvWOhjPiqag0Jfgg=
X-Received: by 2002:a17:906:b106:b0:86d:d78d:61a5 with SMTP id
 u6-20020a170906b10600b0086dd78d61a5mr3173217ejy.253.1674590102065; Tue, 24
 Jan 2023 11:55:02 -0800 (PST)
MIME-Version: 1.0
References: <20230117212731.442859-1-toke@redhat.com> <CAKH8qBuvBomTXqNB+a6n_PbJKSNFazrAxEWsVT-=4XfztuJ7dw@mail.gmail.com>
 <87v8l4byyb.fsf@toke.dk> <CAKH8qBs=nEhhy2Qu7CpyAHx6gOaWR25tRF7aopti5-TSuw66HQ@mail.gmail.com>
 <CAADnVQKy1QzM+wg1BxfYA30QsTaM4M5RRCi+VHN6A7ah2BeZZw@mail.gmail.com>
 <CAKH8qBvZgoOe24MMY+Jn-6guJzGVuJS9zW4v6H+fhgcp7X_9jQ@mail.gmail.com>
 <3500bace-de87-0335-3fe3-6a5c0b4ce6ad@iogearbox.net> <20230119043247.tktxsztjcr3ckbby@MacBook-Pro-6.local>
 <CAEf4BzbAt_Yp-GkAr3Ov4x_v2cawzuJXC5ux4NA-FZ2rv6PCAg@mail.gmail.com>
In-Reply-To: <CAEf4BzbAt_Yp-GkAr3Ov4x_v2cawzuJXC5ux4NA-FZ2rv6PCAg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 24 Jan 2023 11:54:49 -0800
Message-ID: <CAEf4BzZ-CuxBq8U953bfwzQVJn6YA2z4OnvnG47qZ11JLZ68Eg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] Documentation/bpf: Add a description of "stable kfuncs"
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
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

On Tue, Jan 24, 2023 at 9:17 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jan 18, 2023 at 8:32 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Jan 18, 2023 at 11:48:59AM +0100, Daniel Borkmann wrote:
> > >
> > > My $0.02 is that I don't think we need to make a hard-cut ban as part of this.
> >
> > The hard-cut is easier to enforce otherwise every developer will be arguing that
> > their new feature is special and it requires a new discussion.
> > This thread has been going for too long. We need to finish it now and
> > don't come back to it again every now and then.
>
> I wish that we could grant exception at least to complete dynptr
> basics (bpf_dynptr_is_null, bpf_dynptr_get_size,
> bpf_dynptr_{clone,trim,advance}) so that it is consistently provided
> as a unified set of helpers. Similarly, for open coded loop iterator
> (3 helpers), I believe it would be better for BPF ecosystem overall to
> work on any BPF-enabled architecture and configuration (no matter JIT
> or not, BTF of not, etc), just due to generality and unassuming nature
> of this functionality.
>
> But it is what it is, let's move on.

Just to expand a bit on the above and make it clearer. I don't like a
hard-cut ban on helpers, but I'll disagree and commit and will move
open-coded iterators to kfuncs. And whoever is waiting on the helpers
vs kfuncs decision should stop waiting and use kfuncs.


[...]
