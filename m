Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C82662BD9
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 17:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjAIQ4n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 11:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjAIQ4V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 11:56:21 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DF0266D
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 08:55:52 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so7455613wms.4
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 08:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dtLMvP18dkYHoVljLFe7j+bzjVfAz6hbh+D3S9IKCN0=;
        b=JCE9PsZ7Zvf7lizlPDkx/SJxRtQqDJvv7TReqA6/Mt7TbtQfBVlf+XGqkx9/Ei5khR
         mkij1lbsf9aah4AeKuWtDt5lTrOgcs/oolHjUOFX43Y/722Syz9RCACeNTUhuaXRiNlT
         pF03+zMQA0grlW+cl6REGjQog6lNLPobDMd2qPuwYDhDUiPgTo/TTZFLkJ37uVrHeS4h
         tTWWtzQ1u+mwZT1KqRcOVH40O/t6VI+d/q3xRxf5epkXIg+4GT3aZX/vlBu8OOqFWdF8
         WoB8S99/Gm+TWtiLTcALOYLkf8bIo764dJ7Ya+d5ZEtAiQi4mvVewwSNYielZVZyVD0i
         rGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtLMvP18dkYHoVljLFe7j+bzjVfAz6hbh+D3S9IKCN0=;
        b=PrBxz/DVHtHRP2/e2I854lYkZU1iUvnThgHzlhewwyuClN7Nl5uVuw2SbCN6dohfiH
         /w7yfJfzneg55IR9bAsdyoKKJfO1iVK2EIx3+H1iOax5HMT958gSM0Ljc6CcjaVdnCUG
         l6sJ3SSG39itFUV+jrs4ww3WPCa9p3DCyuR/hLJE+e/Es2RlXRihecpFoLgdYGkyWHUV
         XqBqwbB34l4pu39qXsUgwfVTU/k1nt31eza9nSJ1Thm1U+A/21szVF8JEhVgTqsPFwVY
         SEU5PQU7KPBAPsXfF7mIRjkhWdaHKroS8dpOvtAZCoIe71brgySLBBDc4LNVsGoNQfN+
         wcKw==
X-Gm-Message-State: AFqh2kp40RHgqxQFhau17u0ZY4FgQrC6eOY/632ESJTFxcxA3Jy7iZcA
        nUTxjqtZBamV6SkM39cwMK8cSj1Z7jWJrpo1
X-Google-Smtp-Source: AMrXdXusBxfjlAXcSbVsBkMs2iAfVY3Hft3pH/NAHlu9U9aF2/xj8XIwYkYN1sJDuXKFVtjfHBgPSw==
X-Received: by 2002:a05:600c:4e08:b0:3d3:5c21:dd9d with SMTP id b8-20020a05600c4e0800b003d35c21dd9dmr46611251wmq.19.1673283351142;
        Mon, 09 Jan 2023 08:55:51 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id j30-20020a05600c1c1e00b003d9f14e9085sm3767627wms.17.2023.01.09.08.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 08:55:50 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 9 Jan 2023 17:55:48 +0100
To:     Song Liu <song@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next] bpf: Do not allow to load sleepable
 BPF_TRACE_RAW_TP program
Message-ID: <Y7xHFCgXmjqpwXka@krava>
References: <20230109143716.2332415-1-jolsa@kernel.org>
 <CAPhsuW4n4ZM2yF+tDQ8=hicyyRExSyhMkGTT15G8asbBkhyHCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4n4ZM2yF+tDQ8=hicyyRExSyhMkGTT15G8asbBkhyHCg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 09, 2023 at 08:19:31AM -0800, Song Liu wrote:
> On Mon, Jan 9, 2023 at 6:37 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Currently we allow to load any tracing program as sleepable,
> > but BPF_TRACE_RAW_TP can't sleep. Making the check explicit
> > for tracing programs attach types, so sleepable BPF_TRACE_RAW_TP
> > will fail to load.
> >
> > Updating the verifier error to mention iter programs as well.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index fa4c911603e9..121a64ee841a 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -16743,6 +16743,18 @@ BTF_ID(func, rcu_read_unlock_strict)
> >  #endif
> >  BTF_SET_END(btf_id_deny)
> >
> > +static int can_be_sleepable(struct bpf_prog *prog)
> 
> Shall we return bool?

ok

> 
> > +{
> > +       if (prog->type == BPF_PROG_TYPE_TRACING) {
> > +               return prog->expected_attach_type == BPF_TRACE_FENTRY ||
> > +                      prog->expected_attach_type == BPF_TRACE_FEXIT ||
> > +                      prog->expected_attach_type == BPF_MODIFY_RETURN ||
> > +                      prog->expected_attach_type == BPF_TRACE_ITER;
> > +       }
> > +       return prog->type == BPF_PROG_TYPE_LSM ||
> > +              prog->type == BPF_PROG_TYPE_KPROBE;
> > +}
> > +
> >  static int check_attach_btf_id(struct bpf_verifier_env *env)
> >  {
> >         struct bpf_prog *prog = env->prog;
> > @@ -16761,9 +16773,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
> >                 return -EINVAL;
> >         }
> >
> > -       if (prog->aux->sleepable && prog->type != BPF_PROG_TYPE_TRACING &&
> > -           prog->type != BPF_PROG_TYPE_LSM && prog->type != BPF_PROG_TYPE_KPROBE) {
> > -               verbose(env, "Only fentry/fexit/fmod_ret, lsm, and kprobe/uprobe programs can be sleepable\n");
> > +       if (prog->aux->sleepable && !can_be_sleepable(prog)) {
> > +               verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter and kprobe/uprobe programs can be sleepable\n");
> >                 return -EINVAL;
> >         }
> 
> Maybe add a verifier test for this?

ok, will add

thanks,
jirka
