Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AB169B1EF
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 18:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBQRk6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 12:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBQRk5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 12:40:57 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9015472E1A
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 09:40:56 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id m13so981042pgq.12
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 09:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ubunDlU9msRDy+3uOkSF8XjE+wanE2T00XUNyd5oMi4=;
        b=n7JsjgktBMNQx/ldOcn9KJaPpxJY8SsZEOiU4Xo1R4zL6ExHCOj0Yj94XdW0J66mvc
         USpev9GnAFcZtOZrFrFbEKgWVItPVm6PYkyYUJRLjORlAKa83SlKVotqPfp8WaG9cIUx
         qXAxZkqcTRxCov0aQFpciyQLpCEcMzRXRNlL83ghhehWjmdfdXorYwDUcmx7oa9gRVPT
         siLvPyM+Zin7onvBc/X/dw4d8P3VJ1OQdX2VxRshwJRPM1xgejIi1lPHsk8IvhG/+orq
         ux52+anRax9gUa37WsbHP4ux/5sqBgefE8Wbf/igMNI/iC3pKuxoqaE1StOSuiq0dcqC
         RPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubunDlU9msRDy+3uOkSF8XjE+wanE2T00XUNyd5oMi4=;
        b=Pjamoenh7n0jzPweIwpkIGK27zwrAUzBenkYIFc6q2JYzlRgQk/WvWzMsy05rr1zyq
         rmVkefDESg+vN3ztdsw4IhcQ+UvXp/WqhsbscKxFjcGGHavlO11P7Ab9aT4xafYWQFcN
         FIOb/+4WsNI6niXHtKWthaAR00J9cw9M/8Ep8xuMcZBum8PjOSV0ccugZRxGZJDfqPQs
         Fh46afmUy5DG1TA3NY4EsS70uo09pbEbhB9+0F5Irj5AmO+z1K4AzKX0MY5xmXorkBbE
         OMobF83awY3byIZgkBPpBIB52x7plptwt44ti9YtdyOA4nvyD3Nd1ATjTuV6+vzvBSpp
         yA+A==
X-Gm-Message-State: AO0yUKVq32oCWhI5jMW+80mzQnGzRqMc0/GYCE+RggMWF0NAvIS9qqsE
        TYGY1HZ8q98/ADspo1C5pFKQ+O8O5k74cQf40T++nrVHVX3JzN6s
X-Google-Smtp-Source: AK7set9SoDrlXc7kV0zAOGDzQwuHDlEYDM53FMBDlAsUKbE7egGCacsLce+wVUlPMffrnZ2XuTtPYBwCiEM8EXodpG4=
X-Received: by 2002:aa7:8642:0:b0:5a9:c941:43d2 with SMTP id
 a2-20020aa78642000000b005a9c94143d2mr579538pfo.16.1676655655824; Fri, 17 Feb
 2023 09:40:55 -0800 (PST)
MIME-Version: 1.0
References: <167663589722.1933643.15760680115820248363.stgit@firesoul>
 <Y++6IvP+PloUrCxs@google.com> <514bb57b-cc3e-7b7e-c7d4-94cdf52565d6@linux.dev>
In-Reply-To: <514bb57b-cc3e-7b7e-c7d4-94cdf52565d6@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 17 Feb 2023 09:40:44 -0800
Message-ID: <CAKH8qBujK0RnOHi3EH_KwKamEtQRYJ6izoYRBB2_2CQias0HXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next V2] xdp: bpf_xdp_metadata use NODEV for no device support
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, martin.lau@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, alexandr.lobakin@intel.com,
        larysa.zaremba@intel.com, xdp-hints@xdp-project.net
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

On Fri, Feb 17, 2023 at 9:39 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 2/17/23 9:32 AM, Stanislav Fomichev wrote:
> > On 02/17, Jesper Dangaard Brouer wrote:
> >> With our XDP-hints kfunc approach, where individual drivers overload the
> >> default implementation, it can be hard for API users to determine
> >> whether or not the current device driver have this kfunc available.
> >
> >> Change the default implementations to use an errno (ENODEV), that
> >> drivers shouldn't return, to make it possible for BPF runtime to
> >> determine if bpf kfunc for xdp metadata isn't implemented by driver.
> >
> >> This is intended to ease supporting and troubleshooting setups. E.g.
> >> when users on mailing list report -19 (ENODEV) as an error, then we can
> >> immediately tell them their device driver is too old.
> >
> > I agree with the v1 comments that I'm not sure how it helps.
> > Why can't we update the doc in the same fashion and say that
> > the drivers shouldn't return EOPNOTSUPP?
> >
> > I'm fine with the change if you think it makes your/users life
> > easier. Although I don't really understand how. We can, as Toke
> > mentioned, ask the users to provide jited program dump if it's
> > mostly about user reports.
>
> and there is xdp-features also.

Yeah, I was going to suggest it, but then I wasn't sure how to
reconcile our 'kfunc is not a uapi' with xdp-features (that probably
is a uapi)?
