Return-Path: <bpf+bounces-82-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 834F96F7BC8
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 06:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D601C215CF
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 04:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5A81C05;
	Fri,  5 May 2023 04:12:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7001B1854
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 04:12:54 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9556412092
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 21:12:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-957dbae98b4so196244166b.1
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 21:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683259971; x=1685851971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flAExmZz0rzVc3H+kjEgOlxwKnPtUvTbTTd2tnirBD8=;
        b=VBgl9AZ6YAAfa8QrP5H9bSaisZX28FLV1OZxUmMDlgZSM2B3iDUNqpM/M0zX0PoqB+
         ZtBh3voZNS4Gmpsw7ZbWx1QfjACIHtLmLNcvHZSF/k1BbIxpADrVSmcoxVV1PlaJOJxZ
         SeO7k0TsRjgi6XbwtbQnMSw6Maz/8mWtWMVBwNKJSlyqDbcUeGfElf9KrOWArFc6L6sw
         ihalYjjOsQx4yWnT1JYfhajnl4Kz7yu9TmVM/U/K9E3ZeexHKPARb/OQFa7S5OODsk9X
         b8cX8EKO13QDBX44XspibnHFZbQ1g659Qs4iPiymIEJu2y0ApqxkK1LVvpMsSe7eAwHB
         Npxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683259971; x=1685851971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flAExmZz0rzVc3H+kjEgOlxwKnPtUvTbTTd2tnirBD8=;
        b=flAX2mfAlvkpXUzC3g5ymXQ2bDhPauh7/oVrCvkuYkX3N24SYVdo4rhvMzsdwXMb9j
         WXC44r1irgAj/QOwC3PpJzpu2MUBPTKSDznuFDQDG9fOD9QA6hdnp23I3eKDmz2vkZsj
         ewBur7zO6rYePTfqqDVOSPQYnNazwy1NbhU4g2ctqLtfzJc+QVCKLDKzm82duXy+4WOH
         r25x+sE6ufETE5Hx0gtLM6qoyud53ru0zfNzfGJkpVMBanuRhOnyCF7+givTSs4r7Cu2
         BB8HTlIfY1kfwfOeQYAALpsIVe4e2CASQocp8T7Oe+eBAO1hpPGMuL5jnM7heXwsK0I5
         RGnA==
X-Gm-Message-State: AC+VfDz+y/huSiKPWtT2Wbp7ggKQbowmn/H5BZg7n15C27HJ6dRKFoFM
	bXE7fjSjbBzwlxY2Yl1JyGTFXtQYMCHeAUtMhSw66vXG4Cc=
X-Google-Smtp-Source: ACHHUZ583i2N5tS3V/rj29cl5xG7R3zp3/WGfDA4svdBO2bqoKoDRuZ6qar9gyN2bRqovXc8Es2aQ15d0wYfVxtYX+8=
X-Received: by 2002:a17:907:1c18:b0:959:b745:d16f with SMTP id
 nc24-20020a1709071c1800b00959b745d16fmr1004734ejc.51.1683259970841; Thu, 04
 May 2023 21:12:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADxym3ax73kYEyJMZwN+bTwmX9VhZ3WJe+wC9RGGwpfdjLdf3g@mail.gmail.com>
 <d79d6281-845f-c395-79eb-5963389971d3@meta.com> <CADxym3bb6wxF-aRRJBYrfiwMRU8=JjYn69YffSwtKphj7Cetbg@mail.gmail.com>
In-Reply-To: <CADxym3bb6wxF-aRRJBYrfiwMRU8=JjYn69YffSwtKphj7Cetbg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 May 2023 21:12:39 -0700
Message-ID: <CAEf4BzaF4F1rKH=VYVRj0Qapwze-Fj519eoAz+Qq6cHH=52arw@mail.gmail.com>
Subject: Re: bpf: add support to check kernel features in BPF program
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Yonghong Song <yhs@meta.com>, Alan Maguire <alan.maguire@oracle.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 4, 2023 at 7:42=E2=80=AFPM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> On Fri, May 5, 2023 at 12:53=E2=80=AFAM Yonghong Song <yhs@meta.com> wrot=
e:
> >
> >
> >
> > On 5/4/23 4:09 AM, Menglong Dong wrote:
> > > Hello,
> > >
> > > I find that it's not supported yet to check if the bpf features are
> > > supported by the target kernel in the BPF program, which makes
> > > it hard to keep the BPF program compatible with different kernel
> > > versions.
> > >
> > > For example, I want to use the helper bpf_jiffies64(), but I am not
> > > sure if it is supported by the target, as my program can run in
> > > kernel 5.4 or kernel 5.10. Therefore, I have to compile two versions
> > > BPF elf and load one of them according to the current kernel version.
> > > The part of BPF program can be this:
> > >
> > > #ifdef BPF_FEATS_JIFFIES64
> > >    jiffies =3D bpf_jiffies64();
> > > #else
> > >    jiffies =3D 0;
> > > #endif
> > >
> > > And I will generate xxx_no_jiffies.skel.h and xxx_jiffies.skel.h
> > > with -DBPF_FEATS_JIFFIES64 or not.
> > >
> > > This method is too silly, as I have to compile 8(2*2*2) versions of
> > > the BPF program if I am not sure if 3 bpf helpers are supported by th=
e
> > > target kernel.
> > >
> > > Therefore, I think it may be helpful if we can check if the helpers
> > > are support like this:
> > >
> > > if (bpf_core_helper_exist(bpf_jiffies64))
> > >    jiffies =3D bpf_jiffies64();
> > > else
> > >    jiffies =3D 0;
> > >
> > > And bpf_core_helper_exist() can be defined like this:
> > >
> > > #define bpf_core_helper_exist(helper)                        \
> > >      __builtin_preserve_helper_info(helper, BPF_HELPER_EXISTS)
> > >
> > > Besides, in order to prevent the verifier from checking the helper
> > > that is not supported, we need to remove the dead code in libbpf.
> > > As the kernel already has the ability to remove dead and nop insn,
> > > we can just make the dead insn to nop.
> > >
> > > Another option is to make the BPF program support "const value".
> > > Such const values can be rewrite before load, the dead code can
> > > be removed. For example:
> > >
> > > #define bpf_const_value __attribute__((preserve_const_value))
> > >
> > > bpf_const_value bool is_bpf_jiffies64_supported =3D 0;
> > >
> > > if (is_bpf_jiffies64_supported)
> > >    jiffies =3D bpf_jiffies64();
> > > else
> > >    jiffies =3D 0;
> > >
> > > The 'is_bpf_jiffies64_supported' will be compiled to an imm, and
> > > can be rewrite and relocated through libbpf by the user. Then, we
> > > can make the dead insn 'nop'.
> >
> > A variant of the second approach should already work.
> > You can do,
> >
> > volatile const is_bpf_jiffies64_supported;
> >
> > ...
> >
> > if (is_bpf_jiffies64_supported)

you don't even have to use global variable to detect helper support, you ca=
n do:

if (bpf_core_enum_value_exists(enum bpf_func_id, BPF_FUNC_jiffies64))
    jiffies =3D bpf_jiffies64();
else
    jiffies =3D 0;

> >      jiffies =3D bpf_jiffies64();
> > else
> >      jiffies =3D 0;
> >
> >
> > After skeleton is openned but before prog load, you can do
> > a probe into the kernel to find whether the helper is supported
> > or not, and set is_bpf_jiffies64_supported accordingly.
> >
> > After loading the program, is_bpf_jiffies64_supported will be
> > changed to 0/1, verifier will do dead code elimination properly.
> >
>
> Great, that works! Thanks~
>
> > >
> > > What do you think? I'm not sure if these methods work and want
> > > to get some advice before coding.
> > >
> > > Thanks!
> > > Menglong Dong

