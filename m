Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1D96EFA8F
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 21:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbjDZTCG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 15:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDZTCF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 15:02:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB547EEC
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:02:00 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50847469a7fso10957673a12.0
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682535719; x=1685127719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+aNExW0Z1q6nb0N7z0B5Yvv26PB0AXApeM3jmK2eYk=;
        b=SC4WlZfr/PP+nrBM08WL2cHLfKg/MVqVPxUDcOe+OCY7ZWlQ5WDjQ9lYFum9F/oPpH
         qck55iieNE0nogCkPqSgjEsF7fxVa16NqsZeuIK/8TKpqLg/T/pylj2klbwxMA+1GL6/
         B+bYAuY4y3q+mi3ArcvYnBmTx9s1s/EIuMph8hY2l+De0t48u/uRegoEf4zEVejRvZfp
         S9p8g8KFE2S5AEkgbpxhpmBy/RJVK7QlscA5bwCGxPTvRkWxdyptOGxvHs7v6zOq/mvJ
         qu0l2m9PTmxXvzDyhZEFjDoLbd7HR2CeBDNwbcAKk4OCFhn9v7VVy86xJjmR9cpmY2B5
         Z8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682535719; x=1685127719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+aNExW0Z1q6nb0N7z0B5Yvv26PB0AXApeM3jmK2eYk=;
        b=YtPFhj0GeOcFUr4W0QdXeHe5GszF2ycjJ5UVPy5ORiiUYgL7L+LYhSMDD8f1VleZ1v
         t8DFlqOSp3ekkleAa6W0gXjaaNhNEBxic1LmHAa3CXvtnQj853tH5mDuLw5tlunCsK8Y
         bLxBWodEs2d9cCI+4WLO4fF1/c1gXOoZ7A9JEbjMAYEA880nwk7zzzPVPH7NvtiPs3Jh
         4z5DqVQIZuBrQj8OKKBaOFNQJjzC50k3UZe6ObKzrpdyZQOsHrQwuudj84NR4nqismBY
         5omggA2eWEeYm51mZ1l87o6yCBmVRDKUyDGEYSIa6Cy4XFbmvRLrIzzNo/lYYqDJqrlA
         hAag==
X-Gm-Message-State: AAQBX9d6PRMw7IQZ5PsRTNstj2U7Qm4i6HZ9GqPThZ6mpQBDIJRvtYjm
        1NCdD9OnyikJl2UbH9gA2CPpOh1MyayKMwgQjOI=
X-Google-Smtp-Source: AKy350YSFZM7XJgV/+heDN7Mwdm6Mzvw6f8bfthhyG9XdSV+iHBTiK+CPLIH/1irpyfvTk9vrbZ3yBtkW8rlMYUOtRI=
X-Received: by 2002:a05:6402:1849:b0:506:7d34:51d1 with SMTP id
 v9-20020a056402184900b005067d3451d1mr19982049edy.29.1682535719228; Wed, 26
 Apr 2023 12:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230424160447.2005755-1-jolsa@kernel.org> <20230424160447.2005755-2-jolsa@kernel.org>
 <20230424221120.h3vdmuehxi33st4n@dhcp-172-26-102-232.dhcp.thefacebook.com> <ZEejcYDRbxDGebAr@krava>
In-Reply-To: <ZEejcYDRbxDGebAr@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 12:01:47 -0700
Message-ID: <CAEf4BzbuKeukcsch7NRFwLPGD7nkLEJXEm8ps+3RYzopy2YiUA@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next 01/20] bpf: Add multi uprobe link
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 25, 2023 at 2:55=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Apr 24, 2023 at 03:11:20PM -0700, Alexei Starovoitov wrote:
> > On Mon, Apr 24, 2023 at 06:04:28PM +0200, Jiri Olsa wrote:
> > > +
> > > +static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> > > +                      unsigned long entry_ip,
> > > +                      struct pt_regs *regs)
> > > +{
> > > +   struct bpf_uprobe_multi_link *link =3D uprobe->link;
> > > +   struct bpf_uprobe_multi_run_ctx run_ctx =3D {
> > > +           .entry_ip =3D entry_ip,
> > > +   };
> > > +   struct bpf_run_ctx *old_run_ctx;
> > > +   int err;
> > > +
> > > +   preempt_disable();
> >
> > preempt_disable? Which year is this? :)
> > Let's allow sleepable from the start.
> > See bpf_prog_run_array_sleepable.
>
> ok, we should probably add also 'multi.uprobe.s' section so the program
> gets loaded with the BPF_F_SLEEPABLE flag.. or maybe we can enable that
> by default for 'multi.uprobe' section

"uprobe.multi.s" rather, to follow "kprobe.multi.s". But we can't make
it sleepable always/by default. Sleepable BPF programs are not just
better types of programs, they have their own limitations, so it has
to be the user's choice to go with sleepable or non-sleepable.

>
> >
> > Other than this the set looks great.
> >
> > > +
> > > +   if (unlikely(__this_cpu_inc_return(bpf_prog_active) !=3D 1)) {
> > > +           err =3D 0;
> > > +           goto out;
> > > +   }
> > > +
> > > +   rcu_read_lock();
> > > +   old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> > > +   err =3D bpf_prog_run(link->link.prog, regs);
> > > +   bpf_reset_run_ctx(old_run_ctx);
> > > +   rcu_read_unlock();
> > > +

[...]
