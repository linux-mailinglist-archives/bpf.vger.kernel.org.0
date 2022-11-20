Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30A6631758
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 00:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiKTXcd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 18:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKTXcb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 18:32:31 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A8E273B
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 15:32:30 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id h23so6104217edj.1
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 15:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2vH7CaspSfOv0yFdPtoIRPf9eJTqDVx1lM47pAAdf18=;
        b=kXLJ5Fet6hsMSvebG/1qLKTNg1nQbickGOFkrNF54fgczA3Eie/cOnym2pM7/vJf9v
         s27M7+R+6AiIu4LNzYpGzI7Gsr5EjC4O9/YLSH0KVC3CRVjiVndBI2aD/8CZ7487lIny
         PmXgOmOQdCuz2Gef0o53LgFxV7zOE38W/SkA3EBI7G2gwkNjZhpUh1JyReeJlcOF53Ts
         WpCLSpkGKRK2DsSlGsPYfs7/1N7ZcYYj+NdeAe4/h8OHwHZZHYZQh+ktWPWNTYDQZIQ6
         JEaXbRsod/qy66XbpNSsXFB66pIQjyIks6FnS4+RDaa+tLeTM5knfAUHdGJ6nYssRoSO
         fcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vH7CaspSfOv0yFdPtoIRPf9eJTqDVx1lM47pAAdf18=;
        b=5048Ap5bv8TrHyMqXA67M04zPUQKv8j1ZNgj6jI3EqfDbrd2UfSMNHT/ByuNuDoN0W
         QLA0yKxQiaU/jG6xqY1kCh1ulQD8iT6+4e/cdnjXdG8aB/aXxp2sFoCX3qUvGmENN2SV
         XisngHPOXxNJWow0YBuBab5wOvEBS4RW7QtgsMlnj+OtvmyL0sXnWVDELSfbLsS3aJAH
         hmUY6nasLdpQ2y0ZPl0iho3lLW5VsSs+43uROm3wULXlAlTgpfnvxSkj5CZI6EkNwtaa
         o9nDdXiyOeNPLamd8tY33EzdpTxAlJlwY7evkaxVL3KgHDoyjG2BW6s3PAnuAPSgGyb1
         qJtg==
X-Gm-Message-State: ANoB5pnW+uGtXSyXZiyrm5I5HFbHLWFoiouMRaC+oyJvWNVr6etL2wfT
        NeGua4mGJbYLxA21mcw6ImVuoO9pI1WKoUUjtBQ=
X-Google-Smtp-Source: AA0mqf5faS5Nc6NOGc59eRnHGe8MhRmiHXtYAjlUMUOpgcnbLa/JbpO74wax5RJANLMF8QAGcwCatAjyXlftRNFPnYo=
X-Received: by 2002:a05:6402:5289:b0:462:70ee:fdb8 with SMTP id
 en9-20020a056402528900b0046270eefdb8mr14267730edb.66.1668987148251; Sun, 20
 Nov 2022 15:32:28 -0800 (PST)
MIME-Version: 1.0
References: <20221120195421.3112414-1-yhs@fb.com> <20221120195437.3114585-1-yhs@fb.com>
 <CAADnVQ+92vwqUB=J-QJYtrW0Yqvx2HAJJBREkXPJtW0+gyS1mQ@mail.gmail.com>
 <20221120204930.uuinebxndf7vkdwy@apollo> <20221120223454.ymzd4oqt7nsrbgkn@macbook-pro-5.dhcp.thefacebook.com>
In-Reply-To: <20221120223454.ymzd4oqt7nsrbgkn@macbook-pro-5.dhcp.thefacebook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 20 Nov 2022 15:32:17 -0800
Message-ID: <CAADnVQLMi-5Avxxd89+wpWksZnxGkCxzjDHrBLzuGUoVmp1Azw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Add a kfunc for generic type cast
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
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

On Sun, Nov 20, 2022 at 2:34 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 21, 2022 at 02:19:30AM +0530, Kumar Kartikeya Dwivedi wrote:
> > On Mon, Nov 21, 2022 at 01:46:04AM IST, Alexei Starovoitov wrote:
> > > On Sun, Nov 20, 2022 at 11:57 AM Yonghong Song <yhs@fb.com> wrote:
> > > >
> > > > @@ -8938,6 +8941,24 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> > > >                                 regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_TRUSTED;
> > > >                                 regs[BPF_REG_0].btf = desc_btf;
> > > >                                 regs[BPF_REG_0].btf_id = meta.ret_btf_id;
> > > > +                       } else if (meta.func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
> > > > +                               if (!capable(CAP_PERFMON)) {
> > > > +                                       verbose(env,
> > > > +                                               "kfunc bpf_rdonly_cast requires CAP_PERFMON capability\n");
> > > > +                                       return -EACCES;
> > > > +                               }
> > >
> > > Just realized that bpf_cast_to_kern_ctx() has to be
> > > gated by cap_perfmon as well.
> > >
> > > Also the direct capable(CAP_PERFMON) is not quite correct.
> > > It should at least be perfmon_capable().
> > > But even better to use env->allow_ptr_leaks here.
> >
> > Based on this, I wonder if this needs to be done for bpf_obj_new as well? It
> > doesn't zero initialize the memory it returns (except special fields, which is
> > required for correctness), so technically it allows leaking kernel addresses
> > with just CAP_BPF (apart from capabilities needed for the specific program types
> > it is available to).
> >
> > Should that also have a env->allow_ptr_leaks check?
>
> Yeah. Good point.
> My first reaction was to audit everything where the verifier produces
> PTR_TO_BTF_ID and gate it with allow_ptr_leaks.
> But then it looks simpler to gate it once in check_ptr_to_btf_access().
> Then bpf_rdonly_cast and everything wouldn't need those checks.

Noticed that check_ptr_to_map_access is doing
"Simulate access to a PTR_TO_BTF_ID"
and has weird allow_ptr_to_map_access bool
which is the same as allow_ptr_leaks.
So I'm thinking we can remove allow_ptr_to_map_access
and add allow_ptr_leaks check to btf_struct_access()
which will cover all these cases.

Also since bpf_cast_to_kern_ctx() is expected to be used out of
networking progs and those progs are not always GPL we should add
env->prog->gpl_compatible to btf_struct_access() too.
