Return-Path: <bpf+bounces-780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CC0706B0E
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 16:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8A71C20EE5
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 14:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487DD31135;
	Wed, 17 May 2023 14:27:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F7731128
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 14:27:47 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C6C768A
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 07:27:45 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-309438004a6so426124f8f.2
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684333664; x=1686925664;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FvGN9GGSeHWc0U3WJN4kyeHpvQipVEQ+CKfroAq5qK0=;
        b=SZNdHklFePdxgUpmgwG+U9ZFXAIqh2r7t3MZqPluJUkqtkBOvPhoT0DJJy+sUE4oxF
         oblxgq60YZvcjzep0aZXAgl97k/zrBamh3RWFn26Brm202PlzedZttP+qfuit3bGbGGD
         mQCza6a1M1q8ew7pzmdwTGeWPpd4hjvpz+pzE4DfLKOsGEzGMW3yNNh0VRwJ26zE10ZP
         3SbJYZU/ShkGXyMnJgPvguhVSzIitFcJKHx66jddj1mRDo2VOluEerb+bBalnZ7UajK1
         aZx28kYVZmPYsAT7+PYF1HSJ0sVMncwKQDfOPHgsRdnu3UNqeG39pJoO2D5kSgyGfn2Y
         cVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684333664; x=1686925664;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FvGN9GGSeHWc0U3WJN4kyeHpvQipVEQ+CKfroAq5qK0=;
        b=LCPGzYKrworZey+aThzmgfJaKZ4RtJLltvqqsq7m0+VV6GY8ULauhBefF3cAZNhNkn
         1c8exT9PwwwBKlWLBmRd+cutSHYBwKBXfBAkLTDrDi8HXevPN4Eyx/5PRK8GrS5Hl463
         7JOmyCpiU3IXCaXMFD1cYG6DSHc+fn4aoPHDBL669kv2PPeEc3ziwOqQM/bY4D4s/iLu
         VmBbJs1s0JBlzfk5xlYe7jmrPLCd7nBu0/mIm5NAs5qP4HZpsn51w7c16sTgmwIvF/E9
         IYM9eiQ61i4DZnor9hXHP+ufJxFoCNhP4OgbPR6wC81H8yz8H4lJ4D00HsMgKutpy5qX
         a/AQ==
X-Gm-Message-State: AC+VfDx21YRKde5ufgPwk4LKN5GizxYqNqs+XbRPQGr3RF82ABLXQVUZ
	la/HCZd7O/bj2XM20uVYLBQ=
X-Google-Smtp-Source: ACHHUZ62fljMbfPGQibBT2G3ptNUGP0adgcBpMixR41XpiSu1EFKiW3bOYefl+33zsMc8ld21BT3nA==
X-Received: by 2002:adf:eac6:0:b0:307:9d2a:fd35 with SMTP id o6-20020adfeac6000000b003079d2afd35mr973755wrn.53.1684333663838;
        Wed, 17 May 2023 07:27:43 -0700 (PDT)
Received: from [192.168.1.95] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d4489000000b00301a351a8d6sm3038534wrq.84.2023.05.17.07.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 07:27:43 -0700 (PDT)
Message-ID: <387a14cc12e30d713d388a23bb6d986bb16330ae.camel@gmail.com>
Subject: Re: [PATCHv4 bpf-next 08/10] selftests/bpf: Allow to use kfunc from
 testmod.ko in test_verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, David Vernet
 <void@manifault.com>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,  John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>,  Hao Luo <haoluo@google.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 17 May 2023 17:27:41 +0300
In-Reply-To: <CAEf4BzaLAZX_xVyRkavFiz+yLR057TuERcmsOc_amtjQCbHVoA@mail.gmail.com>
References: <20230515133756.1658301-1-jolsa@kernel.org>
	 <20230515133756.1658301-9-jolsa@kernel.org>
	 <CAEf4BzaLAZX_xVyRkavFiz+yLR057TuERcmsOc_amtjQCbHVoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-05-16 at 14:45 -0700, Andrii Nakryiko wrote:
> On Mon, May 15, 2023 at 6:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrot=
e:
> >=20
> > Currently the test_verifier allows test to specify kfunc symbol
> > and search for it in the kernel BTF.
> >=20
> > Adding the possibility to search for kfunc also in bpf_testmod
> > module when it's not found in kernel BTF.
> >=20
> > To find bpf_testmod btf we need to get back SYS_ADMIN cap.
> >=20
> > Acked-by: David Vernet <void@manifault.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/test_verifier.c | 161 +++++++++++++++++---
> >  1 file changed, 139 insertions(+), 22 deletions(-)
> >=20
>=20
> Eduard is working on migrating most (if not all) test_verifier tests
> into test_progs where we can use libbpf declarative functionality for
> things like this.
>=20
> Eduard, can you please review this part? Would it make sense to just
> wait for the migration? If not, will there be anything involved to
> support something like this for the future migration?

Hi Andrii,

I'm not working on migrating remaining test_verifier tests
to test_progs/inline assembly at the moment.

Regarding this specific change, as far as I understand it is
necessary for the following tests:
- verifier/calls.c
- verifier/map_kptr.c
Both files can't be migrated at the moment.
I spent some time today debugging, but the reasons are
obscure and require further investigation.

As to this particular patch itself, I tested it locally and
it seems to work fine. None of the changes prohibit future
migration to inline assembly, should such migration happen.

Thanks,
Eduard

>=20
>=20
> > diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testin=
g/selftests/bpf/test_verifier.c
> > index 285ea4aba194..71704a38cac3 100644
> > --- a/tools/testing/selftests/bpf/test_verifier.c
> > +++ b/tools/testing/selftests/bpf/test_verifier.c
> > @@ -874,8 +874,140 @@ static int create_map_kptr(void)
> >         return fd;
> >  }
> >=20
>=20
> [...]


