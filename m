Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726AB588513
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 02:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiHCAQG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 20:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiHCAQF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 20:16:05 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA87CCE3C
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 17:16:02 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id a15so1791963qto.10
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 17:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZbHc1iEAZVkOCSroOZMrX+NJF9WF2AGs0gYDdDjKIqI=;
        b=Wes9hWt4rUxxS8EfD4lQNuBDh6FZLW2G0p1/zsD08Z/MLFvRRsoH8ub00qjH7TPihF
         WETa1mBrEKqnzd9vD3uYpOLCjn6gGdrR0xL2ER87xtrjcWSSXeLFVucs9ZVgyYzYG7mv
         NMiyxPJ/VYMbgtxFSz+Sc5m4du1qlaLg8Yi6SBHMFWq2S0eUHV2probHStP53F6+yQe4
         xxy7Bjs+4mD/7HFHin+LGujMFpNrc4DfIlfclng4wFN+AEjVvBQztnxpFwjT39V6wFqq
         9P/7XiMVpxtE17Dgq+j8nzP00+OofOs4gSPyjzWi9YkX8lEwOfD7NxH7/UR42xRlJQS8
         Q+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZbHc1iEAZVkOCSroOZMrX+NJF9WF2AGs0gYDdDjKIqI=;
        b=uQOsl/AAqGIPwWuLTPytr3KmAxm7uCb+ryyvDIAtzFLQGL3fKFsISyQinnCyfJwvIm
         1u8CSxoZWveCeRMhL9KX/GwHthb0aPVffW/IGkFYsxl3VJAVRH3fMr+bx/tmBqDbOeE1
         M0be9n/jmGX03n3n9FJn47ov1WTBHN56rEJuEWxJ/HkCSctp6p6SZd0z9F2vkbTRJizh
         jcFj4x3Wbfe4ym/+fE53joBcj5Y6j1ckgjU6KhrnY+XEZdM23zTV7zEIg4vPwyH6A3sP
         QQglO64/k+Z0SO7YOElePJ338yuds7i0X+7S70UjdPjRCQAtsCHhE8Gv/IULkY1lP6mw
         9TYA==
X-Gm-Message-State: AJIora8+21RuIv0zOW9XJhNsbKjoYI0wmgtJN6Xy4+0ZaVMhmqoalnO5
        KAF0L6pZxdqceRiJ74CEGMmFVVMSgiT42DH9Mi1odQ==
X-Google-Smtp-Source: AGRyM1vX9UN+546ucDj3+mulKfBgqsUc1kz4nGhdARP3ax5BGJ++1z+Ddl89PFeSh4Hy/j3DSeXElqlNK9+UgwJX0vs=
X-Received: by 2002:a05:622a:4e:b0:31e:f84c:bf17 with SMTP id
 y14-20020a05622a004e00b0031ef84cbf17mr20355611qtw.566.1659485761782; Tue, 02
 Aug 2022 17:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220801205039.2755281-1-haoluo@google.com> <YukHHCF0DA6Xb/Rf@krava>
In-Reply-To: <YukHHCF0DA6Xb/Rf@krava>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 2 Aug 2022 17:15:50 -0700
Message-ID: <CA+khW7iGQyoxRuOR=fHFzjpXLnHKraJ6=brktaZw6Rqkg85a6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf, iter: clean up bpf_seq_read().
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 2, 2022 at 4:14 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Aug 01, 2022 at 01:50:39PM -0700, Hao Luo wrote:
>
> SNIP
>
> > +static int do_seq_show(struct seq_file *seq, void *p, size_t offs)
> > +{
> > +     int err;
> > +
> > +     WARN_ON(IS_ERR_OR_NULL(p));
> > +
> > +     err = seq->op->show(seq, p);
> > +     if (err > 0) {
> > +             /* object is skipped, decrease seq_num, so next
> > +              * valid object can reuse the same seq_num.
> > +              */
> > +             bpf_iter_dec_seq_num(seq);
> > +             seq->count = offs;
> > +             return err;
> > +     }
> > +
> > +     if (err < 0 || seq_has_overflowed(seq)) {
> > +             seq->count = offs;
> > +             return err ? err : -E2BIG;
> > +     }
> > +
> > +     /* err == 0 and no overflow */
> > +     return 0;
> > +}
> > +
> > +/* do_seq_stop, stops at the given object 'p'. 'p' could be an ERR or NULL. If
> > + * 'p' is an ERR or there was an overflow, reset seq->count to 'offs' and
> > + * returns error. Returns 0 otherwise.
> > + */
> > +static int do_seq_stop(struct seq_file *seq, void *p, size_t offs)
> > +{
> > +     if (IS_ERR(p)) {
> > +             seq->op->stop(seq, NULL);
> > +             seq->count = offs;
>
> should we set seq->count to 0 in case of error?
>

Thanks Jiri. To be honest, I don't know. There are two paths that may
lead to an error "p".

First, seq->op->start() could return ERR, in that case, '"offs'" is
zero and we set it to zero already. This is fine.

The other one, seq->op->next() could return ERR. This is a case where
bpf_seq_read() fails to handle right now, so I am not sure what to do.

Based on my understanding reading the code, if seq->count isn't
zeroed, the current read() will not copy data, but the next read()
will copy data (see the "if (seq->count)" at the beginning of
bpf_seq_read). If seq->count is zeroed, the data in buffer will be
discarded. I don't know what is right.

> jirka
>
> > +             return PTR_ERR(p);
> > +     }
> > +
> > +     seq->op->stop(seq, p);
> > +     if (!p) {
> > +             if (!seq_has_overflowed(seq)) {
> > +                     bpf_iter_done_stop(seq);
> > +             } else {
> > +                     seq->count = offs;
> > +                     if (offs == 0)
> > +                             return -E2BIG;
> > +             }
> > +     }
> > +     return 0;
> > +}
> > +
> >  /* maximum visited objects before bailing out */
> >  #define MAX_ITER_OBJECTS     1000000
> >
>
> SNIP
