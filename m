Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CCB58DB39
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 17:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiHIPhk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 11:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244934AbiHIPhY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 11:37:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AEB558E
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 08:37:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q30so14707286wra.11
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 08:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=VqzY97Hwy2bxw6VcSJ85drCVtic8+BFcOq2r2JHTqLc=;
        b=Wfo9ZwGqLluNYf1fdAv3QiEhagEbV0rD3XoOX4tauT8jfLGfF2ZgQ3pVIchE3Ag5dM
         kkZebqJhRdJHoe04RYI7FJn8oAqBO+UhYwoecVnJjKPig/9raf7EeqcXjMaLsqeiTUmC
         uAUqeAVbHCFagmWfR7aygmMxYesPTLR2wRjprBVKpKygdHfD7fl3UrIVvHmyyr8YxaCA
         PKlJPvMcG0tOhzo59iyHooy87NpVqoJ03bWAflPZ5wSSIsSuHdb1jRuF/Oh0pDb9qpaJ
         JX7QODod+tf5nhNUMS3XDnUPKi5ceVHmIoGWUuknmVG+PTqD5EUMCTezTHtnVcsguOdc
         55pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=VqzY97Hwy2bxw6VcSJ85drCVtic8+BFcOq2r2JHTqLc=;
        b=zo5VN9KiiZvbwddH52OuV3yNwhGn2d2eGMDlG6ca0ZZZ0yXw4hduAWe9rcWzd1xvC3
         QbJCBFnPVH+gdgXIy9R7qu149Cnmcq1PkEtgx2Miwrj2/uzHGOglQSj+q0k04rX/nq0p
         FKgXkGGs4h8D8UR+VuHmuuwCmq9FccU++Xj6QIJarDm5oMyVfbGufROj9jscgv4DNhCo
         ulZazvNSXTdqxXhP+1EkQr37b1xaerT1+ubARlE7x9rdKkI+ZOxoZiV6jrfL8PqJlOUz
         IZQ997WkRLeVAuGL2pE4f/BkxpxW6VGD2VCAXcminlROWQsxnK+KoD16edDj5gJwXmIw
         O/ZQ==
X-Gm-Message-State: ACgBeo3eqC+NOD2iAR3AUUm1vYzN81w9Z9SY0MmYMNz6w7pwK48RDQPS
        yimB8o0HAMS7gt0nsOrResU=
X-Google-Smtp-Source: AA6agR5lNpDFXI/Pz9IcCpfu7iLaxJ+IgDxoil67/gHHJpl1t5VocaO/8WVKogD33cvHRWQAYDTB4g==
X-Received: by 2002:a5d:64ca:0:b0:220:6247:42c1 with SMTP id f10-20020a5d64ca000000b00220624742c1mr14671643wri.478.1660059419043;
        Tue, 09 Aug 2022 08:36:59 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id o5-20020a056000010500b0021f0af83142sm13705632wrx.91.2022.08.09.08.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 08:36:58 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 9 Aug 2022 17:36:56 +0200
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>
Subject: Re: [RFC PATCH bpf-next 01/17] bpf: Link shimlink directly in
 trampoline
Message-ID: <YvJ/GGiRkFtqMdoC@krava>
References: <20220808140626.422731-1-jolsa@kernel.org>
 <20220808140626.422731-2-jolsa@kernel.org>
 <CAPhsuW4GKZ8_6mwGwTDjkGx_0TSzzBvvV-EsmfVBXCobMEnDzw@mail.gmail.com>
 <CAKH8qBs49nedJEm4qS=P2c0XjH9wCUP3q_+oC6Q5XQMwgrz64w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKH8qBs49nedJEm4qS=P2c0XjH9wCUP3q_+oC6Q5XQMwgrz64w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 08, 2022 at 10:58:36AM -0700, Stanislav Fomichev wrote:
> On Mon, Aug 8, 2022 at 10:40 AM Song Liu <song@kernel.org> wrote:
> >
> > On Mon, Aug 8, 2022 at 7:06 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > We are going to get rid of struct bpf_tramp_link in following
> > > changes and cgroup_shim_find logic does not fit to that.
> > >
> > > We can store the link directly in the trampoline and omit the
> > > cgroup_shim_find searching logic.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  include/linux/bpf.h     |  3 +++
> > >  kernel/bpf/trampoline.c | 23 +++--------------------
> > >  2 files changed, 6 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 20c26aed7896..ed2a921094bc 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -841,6 +841,8 @@ struct bpf_tramp_image {
> > >         };
> > >  };
> > >
> > > +struct bpf_shim_tramp_link;
> > > +
> > >  struct bpf_trampoline {
> > >         /* hlist for trampoline_table */
> > >         struct hlist_node hlist;
> > > @@ -868,6 +870,7 @@ struct bpf_trampoline {
> > >         struct bpf_tramp_image *cur_image;
> > >         u64 selector;
> > >         struct module *mod;
> > > +       struct bpf_shim_tramp_link *shim_link;
> > >  };
> >
> > Hi Stanislav,
> >
> > Is it possible to have multiple shim_link per bpf_trampoline? If so, I guess
> > this won't work.
> 
> There is only one shim_link per bpf_trampoline. But I'm not sure
> storing the pointer is enough. We have to do 'shim_link=NULL' when the
> (final) shim is removed. (multiple lsm_cgroup progs can share the same
> shim)

ok, will check on that

thanks,
jirka
