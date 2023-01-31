Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0823682657
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 09:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjAaI3O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 03:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaI3N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 03:29:13 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3B2AD26
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 00:29:12 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q5so13464239wrv.0
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 00:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pMKXmFlFADTmJM7smrLNCt+x6xAZVhWPwLFVxWKfsLc=;
        b=nnKQ3l+wPJcvqdjIX0Lmkip+H+Az0jNxqRuKdZl0Wxetzjif2u8RUZo3pVifDqrI4e
         ZAA1cHjYIJSqTOd3f7GIBFlPxlfeBeRxuq6vFOuSeksSNbzTZT0gACN9wXxn44mL119Y
         GO0BRxgjGrKZ75CFO7szKmkzpHrzt7Y9m2VdNt29EfCvakn0JYdr6ibPD5mF97atH1xO
         eMT+/ylDDBswumvgskhE6DOiG4k62LeiLUeTnnYwldbg+w6RJk14U1brsGkgGkrB/Aam
         0dnQRTY0imrmZlceW/9DWUnTQH99hqO+dvRN+/Hu2c0FHK/9FCIPoO7rS+TFc2higRdx
         iNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pMKXmFlFADTmJM7smrLNCt+x6xAZVhWPwLFVxWKfsLc=;
        b=h67N9DjseQFOOFoGteHbsva+fP82Ek++12XJjIkFAL9pmdkyNqZQLX3MkQ7fWyqT8T
         3hLgTzvyeOXX7k7/nuZZx+p3P6bEkkrrIjTI0+v5VwzgCbxCaxu6tQcm9JDa5SECN7zA
         dFJSMUthVZ3fBHle5XV6Nr3suivX8sfB2edDpbAxI4ozUBHlXGRnPH3W87M6inpAXuNQ
         9ofZhPVi1F8AkOD1Z2VmtxQU1q+dLwWUfSz4Hhk22N0pW18XDFzl2ppSBb9d120v8IHW
         MzbVPgYQv1/cRpMzz7DkN4JTeq6Bokb2nE0IW3rF+K0H3xRdpmAtc9RcNatpnNRcYw6T
         nXFg==
X-Gm-Message-State: AO0yUKXSHrj2xNy9Jco0dkXQjp3kFRrZOoNumDb9OBYm6xEyd7782UMz
        R5UvPfhbPh/YtNe4S77b/Gc=
X-Google-Smtp-Source: AK7set9LIOh5me18eZ2L6EvKZWG0uLn7cdgYaRvaa9HdFthdMizv2Dc0o+9ORpaCjvadjRSISpaFfA==
X-Received: by 2002:a5d:6411:0:b0:2bc:7d3c:5a57 with SMTP id z17-20020a5d6411000000b002bc7d3c5a57mr2007513wru.1.1675153750509;
        Tue, 31 Jan 2023 00:29:10 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id e21-20020a5d5955000000b002b57bae7174sm13910452wri.5.2023.01.31.00.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 00:29:09 -0800 (PST)
Message-ID: <082fd8451321a832f334882a1872b5cee240d811.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix to preserve reg parent/live
 fields when copying range info
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Date:   Tue, 31 Jan 2023 10:29:08 +0200
In-Reply-To: <20230131024248.lw7flczsqhi3llt2@macbook-pro-6.dhcp.thefacebook.com>
References: <CAEf4BzYoB8Ut7UM62dw6TquHfBMAzjbKR=aG_c74XaCgYYyikg@mail.gmail.com>
         <e64e8dbea359c1e02b7c38724be72f354257c2f6.camel@gmail.com>
         <CAEf4BzY3e+ZuC6HUa8dCiUovQRg2SzEk7M-dSkqNZyn=xEmnPA@mail.gmail.com>
         <b836c36a68b670df8f649db621bb3ec74e03ef9b.camel@gmail.com>
         <CAEf4Bza8q2P1mqN4LYwiYqssBiQDorjkFaZDsudOQFCb2825Vw@mail.gmail.com>
         <CAEf4BzY9ikdrT5WN__QJgaYhWJ=h0Do8T7YkiYLpT9VftqecVg@mail.gmail.com>
         <CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3rNV+kBLQCu7rA@mail.gmail.com>
         <CAADnVQLybn06cYYV3uf3FeAGMjOiL5riRzhV6f9fuFOHr9bL=g@mail.gmail.com>
         <dd76a0254d08b25d83ad30d6f07acef36e6223e1.camel@gmail.com>
         <CAEf4BzYsVOiQLXu8tH75FA0Zvey2b7-0TR3aW2Wuqi+fKEtwgA@mail.gmail.com>
         <20230131024248.lw7flczsqhi3llt2@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2023-01-30 at 18:42 -0800, Alexei Starovoitov wrote:
[...]
> > >=20
> > > Hi Alexei, Andrii,
> > >=20
> > > Please note that the patch
> > > "bpf: Fix to preserve reg parent/live fields when copying range info"
> > > that started this conversation was applied to `bpf` tree, not `bpf-ne=
xt`,
> > > so I'll wait until it gets its way to `bpf-next` before submitting fo=
rmal
> > > patches, as it changes the performance numbers collected by veristat.
> > > I did all my experiments with this patch applied on top of `bpf-next`=
.
> > >=20
> > > I adapted the patch suggested by Alexei and put it to my github for
> > > now [1]. The performance gains are indeed significant:
> > >=20
> > > $ ./veristat -e file,states -C -f 'states_pct<-30' master.log uninit-=
reads.log
> > > File                        States (A)  States (B)  States    (DIFF)
> > > --------------------------  ----------  ----------  ----------------
> > > bpf_host.o                         349         244    -105 (-30.09%)
> > > bpf_host.o                        1320         895    -425 (-32.20%)
> > > bpf_lxc.o                         1320         895    -425 (-32.20%)
> > > bpf_sock.o                          70          48     -22 (-31.43%)
> > > bpf_sock.o                          68          46     -22 (-32.35%)
> > > bpf_xdp.o                         1554         803    -751 (-48.33%)
> > > bpf_xdp.o                         6457        2473   -3984 (-61.70%)
> > > bpf_xdp.o                         7249        3908   -3341 (-46.09%)
> > > pyperf600_bpf_loop.bpf.o           287         145    -142 (-49.48%)
> > > strobemeta.bpf.o                 15879        4790  -11089 (-69.83%)
> > > strobemeta_nounroll2.bpf.o       20505        3931  -16574 (-80.83%)
> > > xdp_synproxy_kern.bpf.o          22564        7009  -15555 (-68.94%)
> > > xdp_synproxy_kern.bpf.o          24206        6941  -17265 (-71.33%)
> > > --------------------------  ----------  ----------  ----------------
> > >=20
> > > However, this comes at a cost of allowing reads from uninitialized
> > > stack locations. As far as I understand access to uninitialized local
> > > variable is one of the most common errors when programming in C
> > > (although citation is needed).
> >=20
> > Yeah, a citation is really needed :) I don't see this often in
> > practice, tbh. What I do see in practice is that people are
> > unnecessarily __builtint_memset(0) struct and initialize all fields
> > with field-by-field initialization, instead of just using a nice C
> > syntax:
> >=20
> > struct my_struct s =3D {
> >    .field_a =3D 123,
> >    .field_b =3D 234,
> > };
> >=20
> >=20
> > And all that just because there is some padding between field_a and
> > field_b which the compiler won't zero-initialize.

Andrii, do you have such example somewhere? If the use case is to pass
's' to some helper function it should already work if function
argument type is 'ARG_PTR_TO_UNINIT_MEM'. Handled by the following
code in the verifier.c:check_stack_range_initialized():

        ...
        if (meta && meta->raw_mode) {
                ...
                meta->access_size =3D access_size;
                meta->regno =3D regno;
                return 0;
        }

But only for fixed stack offsets. I'm asking because it might point to
some bug.

> >=20
> > >=20
> > > Also more tests are failing after register parentage chains patch is
> > > applied than in Alexei's initial try: 10 verifier tests and 1 progs
> > > test (test_global_func10.c, I have not modified it yet, it should wai=
t
> > > for my changes for unprivileged execution mode support in
> > > test_loader.c). I don't really like how I had to fix those tests.
> > >=20
> > > I took a detailed look at the difference in verifier behavior between
> > > master and the branch [1] for pyperf600_bpf_loop.bpf.o and identified
> > > that the difference is caused by the fact that helper functions do no=
t
> > > mark the stack they access as REG_LIVE_WRITTEN, the details are in th=
e
> > > commit message [3], but TLDR is the following example:
> > >=20
> > >         1: bpf_probe_read_user(&foo, ...);
> > >         2: if (*foo) ...
> > >=20
> > > Here `*foo` will not get REG_LIVE_WRITTEN mark when (1) is verified,
> > > thus `*foo` read at (2) might lead to excessive REG_LIVE_READ marks
> > > and thus more verification states.
> >=20
> > This is a good fix in its own right, of course, we should definitely do=
 this!
>=20
> +1
>=20
> > >=20
> > > I prepared a patch that changes helper calls verification to apply
> > > REG_LIVE_WRITTEN when write size and alignment allow this, again
> > > currently on my github [2]. This patch has less dramatic performance
> > > impact, but nonetheless significant:
> > >=20
> > > $ veristat -e file,states -C -f 'states_pct<-30' master.log helpers-w=
ritten.log
> > > File                        States (A)  States (B)  States    (DIFF)
> > > --------------------------  ----------  ----------  ----------------
> > > pyperf600_bpf_loop.bpf.o           287         156    -131 (-45.64%)
> > > strobemeta.bpf.o                 15879        4772  -11107 (-69.95%)
> > > strobemeta_nounroll1.bpf.o        2065        1337    -728 (-35.25%)
> > > strobemeta_nounroll2.bpf.o       20505        3788  -16717 (-81.53%)
> > > test_cls_redirect.bpf.o           8129        4799   -3330 (-40.96%)
> > > --------------------------  ----------  ----------  ----------------
> > >=20
> > > I suggest that instead of dropping a useful safety check I can furthe=
r
> > > investigate difference in behavior between "uninit-reads.log" and
> > > "helpers-written.log" and maybe figure out other improvements.
> > > Unfortunately the comparison process is extremely time consuming.
> > >=20
> > > wdyt?
> >=20
> > I think reading uninitialized stack slot concerns are overblown in
> > practice (in terms of their good implications for programmer's
> > productivity), I'd still do it if only in the name of improving user
> > experience.
>=20
> +1
> Let's do both (REG_LIVE_WRITTEN for helpers and allow uninit).
>=20
> Uninit access should be caught by the compiler.
> The verifier is repeating the check for historical reasons when we
> tried to make it work for unpriv.
> Allow uninit won't increase the number of errors in bpf progs.

Thank you for the feedback. I'll submit both patches when
"bpf: Fix to preserve reg parent/live fields when copying range info"
will get to bpf-next.

Thanks,
Eduard.
