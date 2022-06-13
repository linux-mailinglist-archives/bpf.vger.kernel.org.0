Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1D5549CD9
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 21:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348109AbiFMTGo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 15:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346426AbiFMTGZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 15:06:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600105520D
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 09:57:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FB9DB8110A
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 16:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFD7C3411B
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 16:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655139428;
        bh=CttcP1ORZtchLBZZPGaFZZGXn8OJpby+Wh8lL0lratk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OQm4eFNhNqO/JIocWSz1SEz/BIEkMrT9xoBxCEsmUYI1nGkKP2dJLM19Dv/YJNtRO
         NS7JVuxQgbeCfNCSzPbwTLXUVzB32mR2cVssK+Ysh6XVpO5t8nMCo09JYDtk9O29cm
         zxjWQ5sR5Z3tRP1mHkVwWImfM1snk4O/ghUGG0UiGgOONvlryOP3H9UM1PKFfNIivF
         AvjsMyNM70XrRimLZpTIbBvqrsd514Yf7/itTvP6OD/pSXAn7EcTesr8lyR6XD+SQG
         cO8nFKp+NSk93vlImtWHYLD/2Mx8RC5TfpgHIi7zdMjyJP4afMhmIQmfwpnM8e86gV
         pjWdESag78r0w==
Received: by mail-yb1-f177.google.com with SMTP id w2so10855117ybi.7
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 09:57:08 -0700 (PDT)
X-Gm-Message-State: AJIora+XxOCaZToRQQF1t1vrdG13+UG+aHaQ4zfUtjztvq/BkUllpg0q
        Vj4IBKYt2/QUYfbwSsR7nnn+fQhOm2IqV1UkUAk=
X-Google-Smtp-Source: AGRyM1sDfRpb0r/JczMwmZOEfUn6Sjuhxbr6ZVyhV+lwO7XMGzFqCaWHhnHS00I2gCF/HwxRcqFfYKfVGpkYXNOg6tY=
X-Received: by 2002:a05:6902:50f:b0:65c:d620:f6d3 with SMTP id
 x15-20020a056902050f00b0065cd620f6d3mr599693ybs.322.1655139427970; Mon, 13
 Jun 2022 09:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220613150141.169619-1-eddyz87@gmail.com> <20220613150141.169619-4-eddyz87@gmail.com>
 <CAPhsuW44ryeaWog0+md=q-MgdaUqJQczcoksybKzmCy9j=w7hA@mail.gmail.com> <97c0de337b9471caf91c203885676e5078aac0f1.camel@gmail.com>
In-Reply-To: <97c0de337b9471caf91c203885676e5078aac0f1.camel@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 13 Jun 2022 09:56:57 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7K5LOLJYtsr_YSTqBKVJ+1nfCsqJ43ih9yL032E0fj_A@mail.gmail.com>
Message-ID: <CAPhsuW7K5LOLJYtsr_YSTqBKVJ+1nfCsqJ43ih9yL032E0fj_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/5] bpf: Inline calls to bpf_loop when
 callback is known
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 13, 2022 at 9:22 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> > On Mon, 2022-06-13 at 08:48 -0700, Song Liu wrote:
> > > +static int optimize_bpf_loop(struct bpf_verifier_env *env)
> > > +                       new_prog = inline_bpf_loop(env,
> > > +                                                  i + delta,
> > > +                                                  -(stack_depth + stack_depth_extra),
> > > +                                                  inline_state->callback_subprogno,
> > > +                                                  &cnt);
> > > +                       if (!new_prog)
> > > +                               return -ENOMEM;
> >
> > We do not fail over for -ENOMEM, which is reasonable. (It is also reasonable if
> > we do fail the program with -ENOMEM. However, if we don't fail the program,
> > we need to update stack_depth properly before returning, right?
> >
>
> Ouch, you are correct! Sorry, this was really sloppy on my side. The
> behavior here should be the same as in `do_misc_fixups` which does
> fail in case of -ENOMEM. In order to do the same `optimize_bpf_loop`
> should remain as is but the following part of the patch has to be
> updated:
>
> > @@ -15031,6 +15193,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
> >               ret = check_max_stack_depth(env);
> >
> >       /* instruction rewrites happen after this point */
> > +     if (ret == 0)
> > +             optimize_bpf_loop(env);
> > +
>
> It should be as follows:
>
> +       if (ret == 0)
> +               ret = optimize_bpf_loop(env);  // added `ret` assignment!
>
> Not sure if there is a reasonable way to write a test for this case.

Some error injection will catch this. But IIUC, we don't have it in
the selftests
at the moment.

> I will add this change and produce the v7 today. Do you see anything
> else that should be updated?

That's all the issues I can see at the moment. Sorry for not catching this one
in earlier versions.

Thanks,
Song
