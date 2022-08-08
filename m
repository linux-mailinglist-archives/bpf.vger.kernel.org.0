Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDE758CD36
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 19:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbiHHR6t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 13:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235853AbiHHR6s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 13:58:48 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D46A448
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 10:58:48 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x10so9227176plb.3
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 10:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=zj2XQsOgKZZnHB19kV8QSPhVGsC1xRdcFksQYVJJAqQ=;
        b=Vo13qczpWav996hYCXHzPxMM1g+UyIl6fegNqT4sWMp3msiCl+mFbD1iIgnHdRcwJo
         f1U7/Ch1wglriKegyZLCABplwH9VcngfsZeh7Q9YgP9KrYdcFhgW2g1khWpinFvXgEC5
         X2KOWNIadK2Wb3WcqsZ6WVzKMponJIAr8Ml05CuG2vUXHhgpmkKruiBB5QcpzI/vjqPx
         8Pzmaa+inhHvlCDkWvFHFPCHjn09MwMONH7jhXnHXG1WhMZrzhx9kKhpnTIZfPWowpvl
         Pfr8hsLxcDZHNZxoVU1/rOi6T91tNNVnb8iyBAzwh9IQJVOlx4RdzAkg6o5uTbx0s2Al
         o8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zj2XQsOgKZZnHB19kV8QSPhVGsC1xRdcFksQYVJJAqQ=;
        b=a0URDVLWO56xlSGzOb2/cvon+6zwUJbdtn+Qckq1gSJvGFyi9j3biX29FIejIWwFF7
         OkvMw92LnVfBxeFX6BcdzFrRWtx9iuZfAm4qWEDhlfMf+IeXQ1qEHO0qk/KVHpohBUa8
         VAB3DAF5NYe8QrKQJGMdJdaiYQXTFITJlfAE35GK9BRm3S0AVCOZYeeAk54DYmPgah72
         FFSNEAh3DFS6r2mAUuftvjl66vgLxnueIQybeFS57pbp+1fUhhp4Un860xplnfq7ehx7
         faQCRmrz00OybiUreIOb4rQsgICJLbzSgaGLICjpfuWBwSIuamp0nyrVizdLD1c/4MQW
         7GOA==
X-Gm-Message-State: ACgBeo1vZXxWr6t1gqVvhQ8+RbvU/SV9+tOJvPtxeZiqP3WJ5X71GSxt
        z1qaxpTDrr1Qu/HnozGhqqyeU+APuSaD0Xl0oll4Wg==
X-Google-Smtp-Source: AA6agR6UD0upph0YRRy6meK/jXEyAoWTCjFo2SxI6GA0/8dshFfEyeNRIEfusbtQ/HFihyS2aMkwikAewOIkGPlh+ow=
X-Received: by 2002:a17:902:70c7:b0:170:9030:2665 with SMTP id
 l7-20020a17090270c700b0017090302665mr10594378plt.73.1659981527409; Mon, 08
 Aug 2022 10:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220808140626.422731-1-jolsa@kernel.org> <20220808140626.422731-2-jolsa@kernel.org>
 <CAPhsuW4GKZ8_6mwGwTDjkGx_0TSzzBvvV-EsmfVBXCobMEnDzw@mail.gmail.com>
In-Reply-To: <CAPhsuW4GKZ8_6mwGwTDjkGx_0TSzzBvvV-EsmfVBXCobMEnDzw@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 8 Aug 2022 10:58:36 -0700
Message-ID: <CAKH8qBs49nedJEm4qS=P2c0XjH9wCUP3q_+oC6Q5XQMwgrz64w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 01/17] bpf: Link shimlink directly in trampoline
To:     Song Liu <song@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 8, 2022 at 10:40 AM Song Liu <song@kernel.org> wrote:
>
> On Mon, Aug 8, 2022 at 7:06 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > We are going to get rid of struct bpf_tramp_link in following
> > changes and cgroup_shim_find logic does not fit to that.
> >
> > We can store the link directly in the trampoline and omit the
> > cgroup_shim_find searching logic.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/bpf.h     |  3 +++
> >  kernel/bpf/trampoline.c | 23 +++--------------------
> >  2 files changed, 6 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 20c26aed7896..ed2a921094bc 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -841,6 +841,8 @@ struct bpf_tramp_image {
> >         };
> >  };
> >
> > +struct bpf_shim_tramp_link;
> > +
> >  struct bpf_trampoline {
> >         /* hlist for trampoline_table */
> >         struct hlist_node hlist;
> > @@ -868,6 +870,7 @@ struct bpf_trampoline {
> >         struct bpf_tramp_image *cur_image;
> >         u64 selector;
> >         struct module *mod;
> > +       struct bpf_shim_tramp_link *shim_link;
> >  };
>
> Hi Stanislav,
>
> Is it possible to have multiple shim_link per bpf_trampoline? If so, I guess
> this won't work.

There is only one shim_link per bpf_trampoline. But I'm not sure
storing the pointer is enough. We have to do 'shim_link=NULL' when the
(final) shim is removed. (multiple lsm_cgroup progs can share the same
shim)
