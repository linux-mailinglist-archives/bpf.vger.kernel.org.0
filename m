Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6855A6CA253
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 13:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjC0L0t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 07:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjC0L0s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 07:26:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA61B4C1C
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 04:26:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id cn12so34663350edb.4
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 04:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679916405;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1X4MwQKdFclwbk9BBWPhEizWXJusalvyvIAyz1IJtK8=;
        b=ijS/a7N+dDjR36BYCr/dKPMETWkDceoKEMz2+qJCsYgGXdBwb3m9BSr29IAfhjyfRu
         8nnLP3gIP39VFODSWiPUogpSatMcAzHsArEAEWkkC45POW0dTDhMEh+qZzFDX6AjlXBA
         J1JWwsrnBMXSZZ3SgeVy8doZG05VbVNCVj9orPm4hdFS8qzKrO3PiE9A+cFFHkT77k5s
         TPtLX/s2+oKmyR2Q54B68tnod+sY+05lxz/4D1ZZbsOJZtZ4xZKhq8BYoY3ZxQ//AYKI
         WPlr5Kamfs3EuZz0tTBCtwBiTiQzzfwts0z8u9YegjmqHdzlEL/Yl7h+IlccwWjwy2Iy
         51Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679916405;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1X4MwQKdFclwbk9BBWPhEizWXJusalvyvIAyz1IJtK8=;
        b=Z7qiNju1dAy9qRYP5AnMJNEqJDu/aBwGPtjXpwEzFgsVn+Io9BdLV1+Ov1N2yvWWy4
         1Ho4QIlgzl6RzDQS7NX2Tk3MmuJvaa4lmWsvOOk1IYgWnv1AaXFsT/0T3Bo4V7ukAN4E
         MgsiQXiTRbFjX2/jrle9NpBHSC0xUvvscBiZLPQqLr2WWWLc14Oz2dRt6K+PBH341Yhu
         AWtNULlMOQUfXG3Q9qe8WqATWY/aNC5hnfqcLyOr3O/oSq1myq7VsGiYM/Z4YkOiB0zP
         9JjtcQubKgiNl+LPmDUU1BgnpPpzN7Sbt3nEjJfm+hB3/hl2xz6gurdoj0ThQTeUf1TP
         Vdpg==
X-Gm-Message-State: AAQBX9f6rkgAMUJCWEN3jfPUUMvf7ElfwG7ml7Pda2Pf7aZTMGry3kua
        +D0TzmNnqoDlCUnczaxowV70NQQMl+nWZg==
X-Google-Smtp-Source: AKy350Zx98QaC4751Fyu/g4Q9sPMWLeFN1kWcasadtgEXEseWnNu+FCTY38Dpsp/B1SErtRpuwF2KA==
X-Received: by 2002:a05:6402:cd:b0:502:26b7:7a44 with SMTP id i13-20020a05640200cd00b0050226b77a44mr8366474edu.1.1679916404772;
        Mon, 27 Mar 2023 04:26:44 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id u2-20020a50a402000000b004c4eed3fe20sm14667455edb.5.2023.03.27.04.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 04:26:44 -0700 (PDT)
Message-ID: <0671a6df0f76b37e377cb0cb55076833141799e5.camel@gmail.com>
Subject: Re: [PATCH bpf-next 00/43] First set of verifier/*.c migrated to
 inline assembly
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Date:   Mon, 27 Mar 2023 14:26:43 +0300
In-Reply-To: <CAADnVQJRDfM=iofPZF2QLPzuxYjBQLMmm1dU25xMcEueEfaNoA@mail.gmail.com>
References: <20230325025524.144043-1-eddyz87@gmail.com>
         <ZB5pFYZGnwNORSN9@google.com>
         <2ac4f6037719e25e3e8b726def6ece2907d785f0.camel@gmail.com>
         <CAKH8qBv9vYZsMFivzJ9s=i_w-RakGqECfwXBZfWnDigi6oP1EQ@mail.gmail.com>
         <CAADnVQL5O4FaDDOUn0q1urfhquek4dE9nrhWa7mVYwvMhi311A@mail.gmail.com>
         <CAEf4BzbbgLg3w5ySX8XxBHBR0gzr71XPvJ5s1Tw=A6ScA6Vmwg@mail.gmail.com>
         <CAADnVQJRDfM=iofPZF2QLPzuxYjBQLMmm1dU25xMcEueEfaNoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 2023-03-26 at 20:57 -0700, Alexei Starovoitov wrote:
> On Sun, Mar 26, 2023 at 8:16=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >=20
> > On Sat, Mar 25, 2023 at 6:19=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >=20
> > > On Sat, Mar 25, 2023 at 9:16=E2=80=AFAM Stanislav Fomichev <sdf@googl=
e.com> wrote:
> > > >=20
> > > > >=20
> > > > > It was my understanding from the RFC feedback that this "lighter"=
 way
> > > > > is preferable and we already have some tests written like that.
> > > > > Don't have a strong opinion on this topic.
> > > >=20
> > > > Ack, I'm obviously losing a bunch of context here :-(
> > > > I like coalescing better, but if the original suggestion was to use
> > > > this lighter way, I'll keep that in mind while reviewing.
> > >=20
> > > I still prefer the clean look of the tests, so I've applied this set.
> > >=20
> > > But I'm not going to insist that this is the only style developers
> > > should use moving forward.
> > > Whoever prefers "" style can use it in the future tests.
> >=20
> > Great, because I found out in practice that inability to add comments
> > to the manually written asm code is a pretty big limitation.
>=20
> What do you mean by "inability" ?
> The comments can be added. See verifier_and.c
>         r0 &=3D 0xFFFF1234;                               \
>         /* Upper bits are unknown but AND above masks out 1 zero'ing
> lower bits */\
>         if w0 < 1 goto l0_%=3D;                           \

Yes, /* ... */ work as expected.
// work as well, but one has to be careful, because without \n the full
string after first // would be a comment.
