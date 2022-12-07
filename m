Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF076460DB
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 19:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiLGSGA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 13:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGSGA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 13:06:00 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557D15FB86
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 10:05:59 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id f3so17081215pgc.2
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 10:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C3DV9l9zsQfHltjnuJ5yMubwGSae2S2bmpGgboE2nP8=;
        b=Prd6LTqRLZeS8XTw/gvJ8Q2gfHm1a5NPKg+JTD0/GTWchbjrAbYTQ5V9AeyT7EJM9R
         durRWfVvMEdRtO/jdT33KU3R03JL3vLoNpiAMW4UZu/vbTajASHlSfbQ4Ej5+0vcRAt4
         5/I6XAxEef25yBisdlJ10CtucOW+YzKoN6SruxL7O/MVe23ShZiOpx0+5x3NdNciP+Gr
         xLliSHt1QbVRGvJHoWQ4S4wnkse0PQ2cMshCe0J3YqcCx/s3eghN9aZau+g+IKs5r9Ed
         yVvGeENXNWqYYV45QSNHmyJHJS1HM8YWVezFReXZUxZbkyAYbbNBArGrhHJic5x4u4gs
         9qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3DV9l9zsQfHltjnuJ5yMubwGSae2S2bmpGgboE2nP8=;
        b=jxzpanIzuZqpII5O02W7Xb6XAjiJV7EzlgrQnUqBldRBX9xBHTaE0i9Ev6QY/vXPU4
         iapHBgi+M0AtQlRqJRPgq4aS7xEWaBVkE1YbkQvcwdXTclvdnAUupF26ndm9va3jIouU
         vUfxyaQt9CMuSJmHn5e88gbbCR1kAsc3EaW2rqmZdY1ltcLynW8ixuzHsLO9a0RDwvee
         JF9LLxStr4FjdFaNoz7LYbn2OrkSN8iMxH7G77BZL7LuhLVJSMXTroswFo88AHJgUXJv
         geT34IyCCOVN4Rxj3QPW0OL2DdAtcefJHvRBY8kFl5TmuCNZmz1Sv7OXCLw7Yq/d2Y/L
         01Zw==
X-Gm-Message-State: ANoB5pmBDC4mXvAObsd2gEAyk/bPxw2OIfte+11hr0K/9A3sMgE6y0YB
        A1ls3Cc2di7pElFJKURZ6k5hk+0/75W7NEYcwtpcoQ==
X-Google-Smtp-Source: AA0mqf6V98W1Ea96QHbk4wRxDCKU/FpjbtMSK4RNn96lTbLyo7G5+5AtMHilaQI2eAgDXLqxNz2hHPUDW+FUaLdQDNo=
X-Received: by 2002:a63:1747:0:b0:478:1391:fd14 with SMTP id
 7-20020a631747000000b004781391fd14mr44296746pgx.112.1670436358455; Wed, 07
 Dec 2022 10:05:58 -0800 (PST)
MIME-Version: 1.0
References: <20221206024554.3826186-1-sdf@google.com> <20221206024554.3826186-4-sdf@google.com>
 <Y5AWkAYVEBqi5jy3@macbook-pro-6.dhcp.thefacebook.com> <CAKH8qBuzJsmOGroS+wfb3vY_y1jksishztsiU2nV7Ts2TJ37bg@mail.gmail.com>
 <dfcfd47a-808f-ee1c-c04a-dcfedd9a2b23@linux.dev>
In-Reply-To: <dfcfd47a-808f-ee1c-c04a-dcfedd9a2b23@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 7 Dec 2022 10:05:46 -0800
Message-ID: <CAKH8qBuNM_A65LEi6G+wyU5sUEsX1AmAr8J3kKd58AFOADnW0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 03/12] bpf: XDP metadata RX kfuncs
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 6, 2022 at 11:24 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 12/6/22 8:52 PM, Stanislav Fomichev wrote:
> > On Tue, Dec 6, 2022 at 8:29 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Mon, Dec 05, 2022 at 06:45:45PM -0800, Stanislav Fomichev wrote:
> >>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >>> index fc4e313a4d2e..00951a59ee26 100644
> >>> --- a/kernel/bpf/verifier.c
> >>> +++ b/kernel/bpf/verifier.c
> >>> @@ -15323,6 +15323,24 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >>>                return -EINVAL;
> >>>        }
> >>>
> >>> +     *cnt = 0;
> >>> +
> >>> +     if (resolve_prog_type(env->prog) == BPF_PROG_TYPE_XDP) {
> >>> +             if (bpf_prog_is_offloaded(env->prog->aux)) {
> >>> +                     verbose(env, "no metadata kfuncs offload\n");
> >>> +                     return -EINVAL;
> >>> +             }
> >>
> >> If I'm reading this correctly than this error will trigger
> >> for any XDP prog trying to use a kfunc?
> >
> > bpf_prog_is_offloaded() should return true only when the program is
> > fully offloaded to the device (like nfp). So here the intent is to
> > reject kfunc programs because nft should somehow implement them first.
> > Unless I'm not setting offload_requested somewhere, not sure I see the
> > problem. LMK if I missed something.
>
> It errors out for all kfunc here though. or it meant to error out for the
> XDP_METADATA_KFUNC_* only?

Ah, good point, I was somewhat assuming that xdp doesn't use kfuncs
right now and I can just assume that kfunc == metadata_kfunc.
Will make this more selective, thanks!
