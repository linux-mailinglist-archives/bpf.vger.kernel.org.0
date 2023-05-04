Return-Path: <bpf+bounces-52-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 614276F7967
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774EC1C215B0
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63096C15B;
	Thu,  4 May 2023 22:51:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1D4156FB
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 22:51:53 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FC6A5CC
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 15:51:51 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so21835498a12.0
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 15:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683240710; x=1685832710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xS0dT1X/Z3mCP0O0YgAiu1gjV8/3HGBclaUjqd89Of8=;
        b=Wb6HRvh/XcWXkD/v0hqOJmoCbAJ9UpikE5hgwDnJLozC5fcHhZjJ+vAr3docGVoUWI
         mWxqiUxJMP2j/p5yw9qfTh8LbsnEGR6011eUdRHnwaZV/cLjN+RuNtcv6vTyk1zi1Hv8
         oZXGx2mNVRUGu3BL97EhmI2uc3QCHgcLM/P+aSbIQrtWfTihtIwLIjlNbFSfzBHpPT4c
         DftLcF5PepBAgW+w0CN8E800ho/5Y4IQ4f0+JFtxr5vsv9i1yEz8GGVE0YhuZI3dgag8
         LbRJ/eNNsn1f9rMTEYYKhYcIS5EwHxDXY8m0xVJsho8PHUGHvdG2OOuxDHz6YBwx2Bom
         yeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683240710; x=1685832710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xS0dT1X/Z3mCP0O0YgAiu1gjV8/3HGBclaUjqd89Of8=;
        b=Kda2eRiu5hiTQeYXccX2Cw7E/rZL1NC/nODamFEY4UnkVIrDVgOsIuaarv0VeDx1v/
         K5u+rz9/gYrW01dGR5HsI9PEBM6cx45YgQu/8qgWio+LhGv4L0W1puQaHzYhVFyhAy8C
         rwIyoOhodf7RZgfe8rNWpD1vamuPtEzt+OV/rdo9bye3Q04EuAuum2dQDz5K05S8rDDm
         wHCwHZY4q/Zc9xMZePT73h1vnZCTvqTbNSqt24jD/9MOPvhsBpw3W2XDwpPHZa+uNNDe
         F3zhVkSMP8LzXDF3PKJSxajX18k1oF/S9qAfMUERDFpvp4QE2ap4JlD1+dIKviAEhd9E
         LsHg==
X-Gm-Message-State: AC+VfDymEskoeCah4Xbdlmj2wdXVkQjK3rUJabSibxlVRssTSeEPMSMc
	VFJnCzhS7hdq/9tmbqz3+yI+SyB1g+BxwIpBF7MLM/Qm
X-Google-Smtp-Source: ACHHUZ7PAj/GXYIT6iJq6NQMvYw0wuLf93qKPKJf6RR3nhFTSM3qeR6SuQsf1oXdWYY1my2bf0sLLk313iUtyjOFk10=
X-Received: by 2002:a17:907:1c0c:b0:94a:653b:ba41 with SMTP id
 nc12-20020a1709071c0c00b0094a653bba41mr253627ejc.15.1683240710156; Thu, 04
 May 2023 15:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230502230619.2592406-1-andrii@kernel.org> <20230502230619.2592406-11-andrii@kernel.org>
 <20230504222033.gw64tn73fverqccf@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230504222033.gw64tn73fverqccf@dhcp-172-26-102-232.dhcp.thefacebook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 May 2023 15:51:38 -0700
Message-ID: <CAEf4BzbuUvJ6zLvJJpMRc6jkx0GqbWdPFKi2GJ7G1WsjXpeUog@mail.gmail.com>
Subject: Re: [PATCH bpf-next 10/10] bpf: consistenly use program's recorded
 capabilities in BPF verifier
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 4, 2023 at 3:20=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, May 02, 2023 at 04:06:19PM -0700, Andrii Nakryiko wrote:
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 4d057d39c286..c0d60da7e0e0 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -661,7 +661,7 @@ static bool bpf_prog_kallsyms_candidate(const struc=
t bpf_prog *fp)
> >  void bpf_prog_kallsyms_add(struct bpf_prog *fp)
> >  {
> >       if (!bpf_prog_kallsyms_candidate(fp) ||
> > -         !bpf_capable())
> > +         !fp->aux->bpf_capable)
> >               return;
>
> Looking at this bit made me worry about classic bpf.
> bpf_prog_alloc_no_stats() zeros all fields include aux->bpf_capable.
> And loading of classic progs doesn't go through bpf_check().
> So fp->aux->bpf_capable will stay 'false' even when root loads cBPF.
> It doesn't matter here, since bpf_prog_kallsyms_candidate() will return f=
alse
> for cBPF.
>
> Maybe we should init aux->bpf_capable in bpf_prog_alloc_no_stats()
> to stay consistent between cBPF and eBPF ?
> It probably has no effect, but anyone looking at crash dumps with drgn
> will have a consistent view of aux->bpf_capable field.

classic BPF predates my involvement with BPF, so I didn't even think
about that. I'll check and make sure we do initialize aux->bpf_capable
for that

