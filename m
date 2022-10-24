Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED3660B8CE
	for <lists+bpf@lfdr.de>; Mon, 24 Oct 2022 21:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiJXTyr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 15:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiJXTyE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 15:54:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197D526C1AA
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 11:18:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a5so19884095edb.11
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 11:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mZUDyc84xU6t7EyAZemTNQlHNQx48lvkAA1zCdMYbFo=;
        b=A2VslYbC1GV4AU5OnVSMoBOaJhVBsV1Fr5/3HOYQf7FklZg1RK5cjU5IkUbT7IMexe
         mxWuV4+0XjvS8JK97GDKYBVKENk6GW164NbzS6nlVe8kXOLlePqj6Odyt9gmZlm3dIgP
         BXlTUDOopgtPyOSoaPUAT4zpPmO0rLd5jOchPgJr0aOO1CuiXSgIbb+dwNqdbzoVk42W
         Alzvdpu2oJ3+Q+K9Q1uI/PUuwmdRMP1X1ofGAjzBLI2/9yyyp1y6Jn1fFxgx2VhW4V04
         t8Rn6Iz5fMJHRI1qPbMHb4qNeSGj/ECUpyBT3lrvlXpqVOnUJls2hZZlKAh6WcbGzaso
         GaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZUDyc84xU6t7EyAZemTNQlHNQx48lvkAA1zCdMYbFo=;
        b=V0Jlm2wXOaslvv/iwKqlasGfHY/TnKzZ9xLoNugqoWt4nESgL933IndwKZgum3MX90
         Hqw9qkZbUPfeo87GrGKuaIF4hJYPjTbzmNIg/oeiplXeNDtPzoaYH+vyHrX9d0K/5KIT
         COAFOxb42zK/qVNPTlf0BJZdjdgBsPH1gCXQj9w4986p49Ln0b1RlmxCgaPyFC9cC3kQ
         JhHR6RluKOlUZ6RveTC2xuaAOKWEHJu4KcnSBlM/9e3M6+sEUeYUrdnRAW5/HZy63NZM
         gRVcX1q54+lHdpOjRGWGxUG0NSNzaVwT8hbLI2ppLxo1i5UnnRM8526iJfspFNoQDCD5
         yFLg==
X-Gm-Message-State: ACrzQf1VjXEB+tyU5OxLhOSSB5LVnc6wofVHUzoqPpoZhptnQWneHS21
        ZLTiFPXVHekbHRm0e4pRV6LuD4Y9DXN6fyh0pFk=
X-Google-Smtp-Source: AMsMyM4OoNFOkMJLK61Dz2R6JPHqrpuVRqBB2AnFeLQoDRehI7O8YsCjgPuIuQn46NZx5//M7fUvQGHrx02FDLtL36Q=
X-Received: by 2002:a50:eb05:0:b0:457:c6f5:5f65 with SMTP id
 y5-20020a50eb05000000b00457c6f55f65mr31228878edp.311.1666635442960; Mon, 24
 Oct 2022 11:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221019135621.1480923-1-jolsa@kernel.org> <20221019135621.1480923-5-jolsa@kernel.org>
 <CAEf4Bza1p-HZtng4AdAPiV5jbBEstKckWbtAj2aJd2fNqoziZQ@mail.gmail.com> <Y1ZJwOR0rLIkGzVa@krava>
In-Reply-To: <Y1ZJwOR0rLIkGzVa@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 Oct 2022 11:17:10 -0700
Message-ID: <CAEf4Bza0UXUgsbVvyuK60kkEWjKPOtqnG6OLUXvNsS6nbD=56w@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 4/8] bpf: Take module reference on kprobe_multi link
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
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

On Mon, Oct 24, 2022 at 1:16 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Fri, Oct 21, 2022 at 03:02:30PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> > > +       if (err) {
> > > +               kprobe_multi_put_modules(args.mods, args.mods_cnt);
> > > +               kfree(args.mods);
> > > +               return err;
> > > +       }
> > > +
> > > +       /* or number of modules found if everything is ok. */
> > > +       *mods = args.mods;
> > > +       return args.mods_cnt;
> > > +}
> > > +
> > >  int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> > >  {
> > >         struct bpf_kprobe_multi_link *link = NULL;
> > > @@ -2773,10 +2850,25 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> > >                        bpf_kprobe_multi_cookie_cmp,
> > >                        bpf_kprobe_multi_cookie_swap,
> > >                        link);
> > > +       } else {
> > > +               /*
> > > +                * We need to sort addrs array even if there are no cookies
> > > +                * provided, to allow bsearch in get_modules_for_addrs.
> > > +                */
> > > +               sort(addrs, cnt, sizeof(*addrs),
> > > +                      bpf_kprobe_multi_addrs_cmp, NULL);
> > > +       }
> > > +
> > > +       err = get_modules_for_addrs(&link->mods, addrs, cnt);
> > > +       if (err < 0) {
> > > +               bpf_link_cleanup(&link_primer);
> > > +               return err;
> > >         }
> > > +       link->mods_cnt = err;
> > >
> > >         err = register_fprobe_ips(&link->fp, addrs, cnt);
> > >         if (err) {
> > > +               kprobe_multi_put_modules(link->mods, link->mods_cnt);
> >
> > I don't think bpf_link_cleanup() will free link->mods, you have to do
> > it explicitly here
>
> hum, so bpf_link_cleanup sets link->prog to NULL so bpf_link_free
> won't call link->ops->release, but will call link->ops->dealloc,
> so it should be fine AFAICS

oh, I completely forgot that bpf_link_free() will be called eventually
due to fput(primer->file);

so yes, you are right!

Please add my ack for next version, this was the only (non-)issue I found.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> jirka
>
> >
> > >                 bpf_link_cleanup(&link_primer);
> > >                 return err;
> > >         }
> > > --
> > > 2.37.3
> > >
