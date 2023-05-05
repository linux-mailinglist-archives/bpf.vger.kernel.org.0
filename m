Return-Path: <bpf+bounces-101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED236F7D4A
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 08:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7500A280F78
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 06:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3811FC5;
	Fri,  5 May 2023 06:54:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716B0156EF
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 06:54:37 +0000 (UTC)
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2371AD14
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 23:54:35 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-55a14807e4cso24529517b3.1
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 23:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683269675; x=1685861675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AD88EaPY0HqtwvfTmGRTaGk4SkNa1Cq3aZCXxwVvnQY=;
        b=M/BBusTyzgEYnbqGsckuHxNXTJCSA5BN7wNJdqOinkt9/E7SjQ12E0fqRKQwgXbGMj
         +3NrQ2pnEBtXIyPhPStCo7LOWfXCbS8S0uEReVJ8zCH8abxBWPh1Dq/iAElRPZrxX2Ij
         K8odb/3/UCYFEgoVYZhyKsVhfCVwjcoazq6Jwo5GJdEvLddCCTKm4CJ4vfCB+z6lGABf
         SZsciRfbgn9AEgpPns31IuTK4C+s7jqCSNEpf83m6SP3UVqfxZTSJlnICaX2j3QFo8Vh
         c5thOMeDJRfxfqAzHUBvkyEfhVBFx8LpiVFC+YVdzMYTeO1OEmyCIsdP15Kd0xKc9Zja
         GMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683269675; x=1685861675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AD88EaPY0HqtwvfTmGRTaGk4SkNa1Cq3aZCXxwVvnQY=;
        b=KvrrDhZKy/89kN693XkqlSJ+BfSeBsrkb7EwfK+XygN/YlJI5yzJnZx8q1gzlo8atX
         Dijw5XQ8anNWv00QzBU0QGI3mCs3fZ5i2MqCSKwdR8y5ThDahkl3MU20Rl6znsSlZ62F
         +vwSi0X+Fzk+TjDdX/Edfvix+ihotYH0zo8jlp1R3nE5cYB7swnakwOM+MBk4BdhXO7W
         SEalpmqibDjuKNQib2JKWSVQQ7f6sgOx4tNWbQbwFMV3Y4cchNNbuOPGYuovKHvaSoES
         pSBcM37NAOqh60psGMU4kOiLvYchmej07eIEHjjcnqOajS2zlvwIeZgJkyIzo0646jJv
         2iMw==
X-Gm-Message-State: AC+VfDySLsfHr1KF6aTS61ThIa2w80PqEbkSttLerc+LLXIkmDn65wCd
	orRBYilQc2iWFS3e3a0OBx84FQCdjCQn1PuhVdK7cH3LwhGsFQm8
X-Google-Smtp-Source: ACHHUZ76TjPf5fW69LHf/jVLKwvPjlTSNv6Ti4htuGzsB9j1WNrnWgrLEvRamtPsNemI/J1FBnEruyPJbc2oAMgPS/M=
X-Received: by 2002:a0d:eb4d:0:b0:556:e3eb:de38 with SMTP id
 u74-20020a0deb4d000000b00556e3ebde38mr730822ywe.0.1683269674834; Thu, 04 May
 2023 23:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADxym3ax73kYEyJMZwN+bTwmX9VhZ3WJe+wC9RGGwpfdjLdf3g@mail.gmail.com>
 <d79d6281-845f-c395-79eb-5963389971d3@meta.com> <CADxym3bb6wxF-aRRJBYrfiwMRU8=JjYn69YffSwtKphj7Cetbg@mail.gmail.com>
 <CAEf4BzaF4F1rKH=VYVRj0Qapwze-Fj519eoAz+Qq6cHH=52arw@mail.gmail.com>
In-Reply-To: <CAEf4BzaF4F1rKH=VYVRj0Qapwze-Fj519eoAz+Qq6cHH=52arw@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 5 May 2023 14:54:23 +0800
Message-ID: <CADxym3bf_-2tgtviiE1azAWGofZK1waR44KBuq1PnmOg1pe07Q@mail.gmail.com>
Subject: Re: bpf: add support to check kernel features in BPF program
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yhs@meta.com>, Alan Maguire <alan.maguire@oracle.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 5, 2023 at 12:12=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, May 4, 2023 at 7:42=E2=80=AFPM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
> >
> > On Fri, May 5, 2023 at 12:53=E2=80=AFAM Yonghong Song <yhs@meta.com> wr=
ote:
> > >
> > >
> > >
> > > On 5/4/23 4:09 AM, Menglong Dong wrote:
> > > > Hello,
> > > >
> > > > I find that it's not supported yet to check if the bpf features are
> > > > supported by the target kernel in the BPF program, which makes
> > > > it hard to keep the BPF program compatible with different kernel
> > > > versions.
> > > >
> > > > For example, I want to use the helper bpf_jiffies64(), but I am not
> > > > sure if it is supported by the target, as my program can run in
> > > > kernel 5.4 or kernel 5.10. Therefore, I have to compile two version=
s
> > > > BPF elf and load one of them according to the current kernel versio=
n.
> > > > The part of BPF program can be this:
> > > >
> > > > #ifdef BPF_FEATS_JIFFIES64
> > > >    jiffies =3D bpf_jiffies64();
> > > > #else
> > > >    jiffies =3D 0;
> > > > #endif
> > > >
> > > > And I will generate xxx_no_jiffies.skel.h and xxx_jiffies.skel.h
> > > > with -DBPF_FEATS_JIFFIES64 or not.
> > > >
> > > > This method is too silly, as I have to compile 8(2*2*2) versions of
> > > > the BPF program if I am not sure if 3 bpf helpers are supported by =
the
> > > > target kernel.
> > > >
> > > > Therefore, I think it may be helpful if we can check if the helpers
> > > > are support like this:
> > > >
> > > > if (bpf_core_helper_exist(bpf_jiffies64))
> > > >    jiffies =3D bpf_jiffies64();
> > > > else
> > > >    jiffies =3D 0;
> > > >
> > > > And bpf_core_helper_exist() can be defined like this:
> > > >
> > > > #define bpf_core_helper_exist(helper)                        \
> > > >      __builtin_preserve_helper_info(helper, BPF_HELPER_EXISTS)
> > > >
> > > > Besides, in order to prevent the verifier from checking the helper
> > > > that is not supported, we need to remove the dead code in libbpf.
> > > > As the kernel already has the ability to remove dead and nop insn,
> > > > we can just make the dead insn to nop.
> > > >
> > > > Another option is to make the BPF program support "const value".
> > > > Such const values can be rewrite before load, the dead code can
> > > > be removed. For example:
> > > >
> > > > #define bpf_const_value __attribute__((preserve_const_value))
> > > >
> > > > bpf_const_value bool is_bpf_jiffies64_supported =3D 0;
> > > >
> > > > if (is_bpf_jiffies64_supported)
> > > >    jiffies =3D bpf_jiffies64();
> > > > else
> > > >    jiffies =3D 0;
> > > >
> > > > The 'is_bpf_jiffies64_supported' will be compiled to an imm, and
> > > > can be rewrite and relocated through libbpf by the user. Then, we
> > > > can make the dead insn 'nop'.
> > >
> > > A variant of the second approach should already work.
> > > You can do,
> > >
> > > volatile const is_bpf_jiffies64_supported;
> > >
> > > ...
> > >
> > > if (is_bpf_jiffies64_supported)
>
> you don't even have to use global variable to detect helper support, you =
can do:
>
> if (bpf_core_enum_value_exists(enum bpf_func_id, BPF_FUNC_jiffies64))
>     jiffies =3D bpf_jiffies64();
> else
>     jiffies =3D 0;

Perfect! Now I don't even have to probe the helper support
in the user space. It maybe a good idea to introduce a:

#define bpf_core_helper_exist(name) \
  bpf_core_enum_value_exists(enum bpf_func_id, BPF_FUNC_##name)

to help the users who don't know this method.

Thanks!
Menglong Dong

>
> > >      jiffies =3D bpf_jiffies64();
> > > else
> > >      jiffies =3D 0;
> > >
> > >
> > > After skeleton is openned but before prog load, you can do
> > > a probe into the kernel to find whether the helper is supported
> > > or not, and set is_bpf_jiffies64_supported accordingly.
> > >
> > > After loading the program, is_bpf_jiffies64_supported will be
> > > changed to 0/1, verifier will do dead code elimination properly.
> > >
> >
> > Great, that works! Thanks~
> >
> > > >
> > > > What do you think? I'm not sure if these methods work and want
> > > > to get some advice before coding.
> > > >
> > > > Thanks!
> > > > Menglong Dong

