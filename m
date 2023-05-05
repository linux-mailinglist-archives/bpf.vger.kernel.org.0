Return-Path: <bpf+bounces-78-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 794DC6F7B2A
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 04:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E07280F36
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 02:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C71139C;
	Fri,  5 May 2023 02:42:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07964EDE
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 02:42:47 +0000 (UTC)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99431120AE
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 19:42:46 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id 3f1490d57ef6-ba1911d60f5so1880240276.2
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 19:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683254566; x=1685846566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4iCfYgPXpRMYNG09bg/WYuGD0IF0PA4+uLma0wOICc=;
        b=OI75NSg7sw0+sWhy1GTWmi0CFfGtq4sYRMYsfk7W1oG4LRzxwLiOm5+Dfw5kXKKp85
         csbxNHTvf9P0+CO84FzfUvlXtUe65cGhOxV8c/Y+KLNuupzJTI1YwQCN5lhE3JOTJFOQ
         eMCSQKyl+BqgmK4/mq5O/aeM499G0niqBK7viPezhQEQsX8DbkJT2C1UWZZUSnHh8Kjy
         iJkz5aCNNtVAz/G4EKtOk2xSExFyVplopVUPVn7vO3whxevzY3rAoQTQ/kAiGrLkBWIM
         Vn9iWfZg9f+OrkPdzQ+QYaMy3lFx7iRyFj4FdmidcHH9hrQF8h2YpWhBZMbzziI4D0ew
         k+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683254566; x=1685846566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4iCfYgPXpRMYNG09bg/WYuGD0IF0PA4+uLma0wOICc=;
        b=ex5NZwOMT6sz4lXdzI+Vz3f3NfkzZBNerUpE7h9Os9BggWe2KxidvKdbk0RPAFt+8p
         JmUz3czmFdJmDrMjuSREAHwpa8Lasgai+bb/Vt+lKTvOdGPw3VqPu6qr2/d+y/69Mla8
         vcRlyv4ij/ReUu/ENfFIqsUtvzgylBoTX+ycHGHpwnh03pAUWSaaVk7LkzWJfFAlrMWH
         VdeBgyJRVpPh5CqTVMgvrI+fwAb/YKSWBTwEe1KtFtG6PbCcrUEKFWG1IppQDlBum0QR
         t0cB5OHtjXmwmHg32sPnzOaBDLg/C3/wdfTiWM0J1gwmmf1Ug7l+vJZrp5KPJGEdyhAr
         MNVg==
X-Gm-Message-State: AC+VfDwQScvgrvqlXghxtTsgw7M9mA85rzIccFdDpoB1phnYRpiit/gu
	h9ydEBkfmrG3GoD220RfTGemfff0ECtu2oLhuAm5Z1Ua4hY=
X-Google-Smtp-Source: ACHHUZ4T5Xz6syQZX5RZXtrcl9XqT98X62L8phJo8RdfExutDxpmNR6e6xeDo2uj6nRe4Xc9fpgu3Nx/4IoGQ5NeJsM=
X-Received: by 2002:a25:348a:0:b0:b9d:72dd:5f61 with SMTP id
 b132-20020a25348a000000b00b9d72dd5f61mr116874yba.1.1683254565803; Thu, 04 May
 2023 19:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADxym3ax73kYEyJMZwN+bTwmX9VhZ3WJe+wC9RGGwpfdjLdf3g@mail.gmail.com>
 <d79d6281-845f-c395-79eb-5963389971d3@meta.com>
In-Reply-To: <d79d6281-845f-c395-79eb-5963389971d3@meta.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 5 May 2023 10:42:34 +0800
Message-ID: <CADxym3bb6wxF-aRRJBYrfiwMRU8=JjYn69YffSwtKphj7Cetbg@mail.gmail.com>
Subject: Re: bpf: add support to check kernel features in BPF program
To: Yonghong Song <yhs@meta.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 5, 2023 at 12:53=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 5/4/23 4:09 AM, Menglong Dong wrote:
> > Hello,
> >
> > I find that it's not supported yet to check if the bpf features are
> > supported by the target kernel in the BPF program, which makes
> > it hard to keep the BPF program compatible with different kernel
> > versions.
> >
> > For example, I want to use the helper bpf_jiffies64(), but I am not
> > sure if it is supported by the target, as my program can run in
> > kernel 5.4 or kernel 5.10. Therefore, I have to compile two versions
> > BPF elf and load one of them according to the current kernel version.
> > The part of BPF program can be this:
> >
> > #ifdef BPF_FEATS_JIFFIES64
> >    jiffies =3D bpf_jiffies64();
> > #else
> >    jiffies =3D 0;
> > #endif
> >
> > And I will generate xxx_no_jiffies.skel.h and xxx_jiffies.skel.h
> > with -DBPF_FEATS_JIFFIES64 or not.
> >
> > This method is too silly, as I have to compile 8(2*2*2) versions of
> > the BPF program if I am not sure if 3 bpf helpers are supported by the
> > target kernel.
> >
> > Therefore, I think it may be helpful if we can check if the helpers
> > are support like this:
> >
> > if (bpf_core_helper_exist(bpf_jiffies64))
> >    jiffies =3D bpf_jiffies64();
> > else
> >    jiffies =3D 0;
> >
> > And bpf_core_helper_exist() can be defined like this:
> >
> > #define bpf_core_helper_exist(helper)                        \
> >      __builtin_preserve_helper_info(helper, BPF_HELPER_EXISTS)
> >
> > Besides, in order to prevent the verifier from checking the helper
> > that is not supported, we need to remove the dead code in libbpf.
> > As the kernel already has the ability to remove dead and nop insn,
> > we can just make the dead insn to nop.
> >
> > Another option is to make the BPF program support "const value".
> > Such const values can be rewrite before load, the dead code can
> > be removed. For example:
> >
> > #define bpf_const_value __attribute__((preserve_const_value))
> >
> > bpf_const_value bool is_bpf_jiffies64_supported =3D 0;
> >
> > if (is_bpf_jiffies64_supported)
> >    jiffies =3D bpf_jiffies64();
> > else
> >    jiffies =3D 0;
> >
> > The 'is_bpf_jiffies64_supported' will be compiled to an imm, and
> > can be rewrite and relocated through libbpf by the user. Then, we
> > can make the dead insn 'nop'.
>
> A variant of the second approach should already work.
> You can do,
>
> volatile const is_bpf_jiffies64_supported;
>
> ...
>
> if (is_bpf_jiffies64_supported)
>      jiffies =3D bpf_jiffies64();
> else
>      jiffies =3D 0;
>
>
> After skeleton is openned but before prog load, you can do
> a probe into the kernel to find whether the helper is supported
> or not, and set is_bpf_jiffies64_supported accordingly.
>
> After loading the program, is_bpf_jiffies64_supported will be
> changed to 0/1, verifier will do dead code elimination properly.
>

Great, that works! Thanks~

> >
> > What do you think? I'm not sure if these methods work and want
> > to get some advice before coding.
> >
> > Thanks!
> > Menglong Dong

