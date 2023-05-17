Return-Path: <bpf+bounces-798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C33706EAF
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 18:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908F128176F
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 16:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028B52C724;
	Wed, 17 May 2023 16:51:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3509156DD
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 16:51:18 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E6C59E2
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 09:51:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96649b412easo158964666b.0
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 09:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684342273; x=1686934273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0ALMoC2+4GM+zYvrEbSCHn25i4A+ScOGsLlztBZO6U=;
        b=FYndv425krTUmipXP38e199SiUy+8FbEdkHExW2w+zR+obuE0ZpEwtWSpxdD9BKN48
         qbr8jrkXvSqmmdXD0j9jtqdNuA64C9ZWsxX/GoNVNmnzkfTb4o4+m/6LMzjJT4/L8+9v
         smOB1H/RS64WrDmKzzhlkXDivS6yPvDqjuHrcwmr40nLwP+q3q3G4YC5ZEuxl/GLLTae
         MQ+4rJOT/SozCqGqursnVGC2XZvkCyXCSTdLrK5Zn2NwlvJTNoSnjLbITVJlCT/iMxZV
         zg35AUarry3SIok6nNgm+ZINQuTSZN2XXwOwPyVLXOMq+BY+XagMoyW8/M0DAy4uvnE2
         EzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684342273; x=1686934273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0ALMoC2+4GM+zYvrEbSCHn25i4A+ScOGsLlztBZO6U=;
        b=ADpqdkTg2+kvRtdNrmRdgrixTVrqUmzS9txGlK+FCw0KLJ5yQ5naLgb9QVmm2LvMpE
         0fO3ySoz2UIJtUmdrHrrCY01FYnWekwEEQPuR2SVmY2MuTVAaf9caqICePKncY8pNbat
         Uu/QmWA8RgwVMvQam0uH+iBRf1CSRZ/a5q5Vr8tdYAkD0LhSN3TTprdxrRPHHhm1Fe4C
         VQlV/7mJQkEjymuDaAHSSCTwNfy+47S4UxR9VYfyPRaJl9WzsClEwCURv2wAr3kiCsid
         roNwMQsd6ksAEtfWyQt+Jj6wY0Iu7MXTFzh3p4c98HnVZcoXErzVGXHeAwkvR4G64MCP
         KIuQ==
X-Gm-Message-State: AC+VfDwz9yohJ8D4vZDOj+W8ZZXNIFqNaz86fVxCAYoHX2jDMyDkTXC8
	kcjQ5aKAtuB3tNcK40B4/l1TuKtxAO9MQV9lU/+ftk2au/I=
X-Google-Smtp-Source: ACHHUZ6oBsm4GRhPkHFAKIESsivPYyvzMTFMGkCehoKPIlIpKQBCHFR57KJXnDYHNGXAqJ5N7KJHLN785ZjQaZmkERc=
X-Received: by 2002:a17:907:9348:b0:966:19f8:e919 with SMTP id
 bv8-20020a170907934800b0096619f8e919mr33074276ejc.70.1684342273006; Wed, 17
 May 2023 09:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230515133756.1658301-1-jolsa@kernel.org> <20230515133756.1658301-9-jolsa@kernel.org>
 <CAEf4BzaLAZX_xVyRkavFiz+yLR057TuERcmsOc_amtjQCbHVoA@mail.gmail.com> <387a14cc12e30d713d388a23bb6d986bb16330ae.camel@gmail.com>
In-Reply-To: <387a14cc12e30d713d388a23bb6d986bb16330ae.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 17 May 2023 09:51:00 -0700
Message-ID: <CAEf4BzbgP_MbRYiWt0QByoOLd65sxYfv_1sgTb=D=q7+L8-iKw@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 08/10] selftests/bpf: Allow to use kfunc from
 testmod.ko in test_verifier
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	David Vernet <void@manifault.com>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 7:27=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2023-05-16 at 14:45 -0700, Andrii Nakryiko wrote:
> > On Mon, May 15, 2023 at 6:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Currently the test_verifier allows test to specify kfunc symbol
> > > and search for it in the kernel BTF.
> > >
> > > Adding the possibility to search for kfunc also in bpf_testmod
> > > module when it's not found in kernel BTF.
> > >
> > > To find bpf_testmod btf we need to get back SYS_ADMIN cap.
> > >
> > > Acked-by: David Vernet <void@manifault.com>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/testing/selftests/bpf/test_verifier.c | 161 +++++++++++++++++-=
--
> > >  1 file changed, 139 insertions(+), 22 deletions(-)
> > >
> >
> > Eduard is working on migrating most (if not all) test_verifier tests
> > into test_progs where we can use libbpf declarative functionality for
> > things like this.
> >
> > Eduard, can you please review this part? Would it make sense to just
> > wait for the migration? If not, will there be anything involved to
> > support something like this for the future migration?
>
> Hi Andrii,
>
> I'm not working on migrating remaining test_verifier tests
> to test_progs/inline assembly at the moment.
>
> Regarding this specific change, as far as I understand it is
> necessary for the following tests:
> - verifier/calls.c
> - verifier/map_kptr.c
> Both files can't be migrated at the moment.
> I spent some time today debugging, but the reasons are
> obscure and require further investigation.
>
> As to this particular patch itself, I tested it locally and
> it seems to work fine. None of the changes prohibit future
> migration to inline assembly, should such migration happen.
>

Great, thanks for checking!

> Thanks,
> Eduard
>
> >
> >
> > > diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/test=
ing/selftests/bpf/test_verifier.c
> > > index 285ea4aba194..71704a38cac3 100644
> > > --- a/tools/testing/selftests/bpf/test_verifier.c
> > > +++ b/tools/testing/selftests/bpf/test_verifier.c
> > > @@ -874,8 +874,140 @@ static int create_map_kptr(void)
> > >         return fd;
> > >  }
> > >
> >
> > [...]
>

