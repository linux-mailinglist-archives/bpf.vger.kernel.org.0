Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63034031D4
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 02:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhIHA0u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 20:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbhIHA0t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Sep 2021 20:26:49 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048BDC061575
        for <bpf@vger.kernel.org>; Tue,  7 Sep 2021 17:25:43 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id v10so605759ybm.5
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 17:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jOYaCFmHQ3XX6jkW0V8kgW7Sf7G2JHYYEnKwhEE4I0M=;
        b=Onk/8zexrsf3KQm0mWeFiWxwm8XBj32+aR7dAUxYT+irpu6JRg/HnQQf1SZHZQ9uU7
         fev8A7Xvojg7ULhcpidwaoesHJBOUaJ0PHv68saGHTLTgENOLW81QRR5AYPlMKqtYhGH
         D3FsxIIq9gjBJtDQcTCOC9JqFP4zlx4xWZGFHDbhi4W7C517vyVdbGePZgITL4+HYpdg
         USCdUCVXpPF9NpzunvVPMm4suwe9PfsDq6VTBVdurFOKoYn2bwxHjh7h5yTq6EFrmnLa
         qeri/E+1Pi7QGZ4jaRt0QV+POWwsXS91kvMizoQ1ZNgbhWYvFMNPcf6GZA3y2lqRMTa2
         7MvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jOYaCFmHQ3XX6jkW0V8kgW7Sf7G2JHYYEnKwhEE4I0M=;
        b=pqWNQ8+copVhtUL+NeeNI/pRymj9kWE/h9L9xkuQLWElV9M3fDRg7oVU2zbIuRjcIU
         JMac90HCglGzwx1E0wcCv+tV8CZK2FOeh6GNMtfMO2pOvEv36K9F0ExdEaYJ8/h9cHH4
         OWcASlPIjaYEmE9+9L91OCjyZ5BHncKXKrTUMJ6tsHDBYVyc6ItwDu5GR9ZOeyL4MbJI
         /ObH6LWnbfsBuOGxZOQlbc50zpC3AFW0CKjhWMQDnywEIrAXj9emLBZxrKybA7HRqrNd
         mDbWzK+LF5DJZWYJgv8rudn5/eEtlObsePMcHXTZ2Iow1V2hc2Bq5Uw4kcHL5cjPSEJE
         yJtw==
X-Gm-Message-State: AOAM531akQNjcNRb4a1zhUz1chp0ds3b3/TgHf6LbVKRzTnFAfaMM6EO
        jOMp/TkjjranUvEegj1wrPpdFYc6BMp7woCDZIs=
X-Google-Smtp-Source: ABdhPJxMCCEDFjWiVDox/9ePOSLkUyHWRZ9PI7+MsfsHpyy2GHN/tEDXoGcb/MZ1XsHj7XLCywwRW1LghncKQ2BYFE8=
X-Received: by 2002:a25:5406:: with SMTP id i6mr1396472ybb.4.1631060742289;
 Tue, 07 Sep 2021 17:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <1630564633-552375-1-git-send-email-jiasheng@iscas.ac.cn> <20210907222443.gygy7eohzybpiq47@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210907222443.gygy7eohzybpiq47@kafai-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Sep 2021 17:25:31 -0700
Message-ID: <CAEf4BzZ1KQfZKyRVn--SpvfFZMsoATrUBw4PyYhLNM97LJkePA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Add env_type_is_resolved() in front of
 env_stack_push() in btf_resolve()
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     jiasheng <jiasheng@iscas.ac.cn>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 7, 2021 at 3:37 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Thu, Sep 02, 2021 at 06:37:13AM +0000, jiasheng wrote:
> > We have found that in the complied files env_stack_push()
> > appear more than 10 times, and under at least 90% circumstances
> > that env_type_is_resolved() and env_stack_push() appear in pairs.
> > For example, they appear together in the btf_modifier_resolve()
> > of the file complie from 'kernel/bpf/btf.c'.
> > But we have found that in the btf_resolve(), there is only
> > env_stack_push() instead of the pair.
> > Therefore, we consider that the env_type_is_resolved()
> > might be forgotten.
> It does not justify a change like this just because
> one of its usage looks different and then concluded that
> it _might_ be forgotten.
>
> Does it have a bug or not?  If there is, please
> provide an explanation on how to reproduce it first.
>

Both places that call btf_resolve() check that env_type_is_resolved()
first, so there is no issue here.

> >
> > Signed-off-by: jiasheng <jiasheng@iscas.ac.cn>
> > ---
> >  kernel/bpf/btf.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index f982a9f0..454c249 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -4002,7 +4002,8 @@ static int btf_resolve(struct btf_verifier_env *env,
> >       int err = 0;
> >
> >       env->resolve_mode = RESOLVE_TBD;
> > -     env_stack_push(env, t, type_id);
> > +     if (env_type_is_resolved(env, type_id))
> > +             env_stack_push(env, t, type_id);
> >       while (!err && (v = env_stack_peak(env))) {
> >               env->log_type_id = v->type_id;
> >               err = btf_type_ops(v->t)->resolve(env, v);
> > --
> > 2.7.4
> >
