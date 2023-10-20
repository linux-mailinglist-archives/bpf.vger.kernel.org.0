Return-Path: <bpf+bounces-12783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB907D0683
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 04:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D081C20F18
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 02:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1C080E;
	Fri, 20 Oct 2023 02:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnQV6zSx"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6104369
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 02:36:35 +0000 (UTC)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F97D124
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 19:36:34 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7b61de8e456so151315241.0
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 19:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697769393; x=1698374193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NesduVr/BG1deQGTSgj2+fzQ2Kh7lDgyaPe/Zcp2PI=;
        b=DnQV6zSx1G/F6yccWOm6RJRSm1C3LOvzOZjxS+Fpg0cX6qfy7jlE/pbmvNdvD45tEe
         Fk6rKLAtzLGumwGzk1jvZtKimRd+KM81lx5QNzg12GqA8BCED7hZNf5LRUXIDELIeNof
         23x6OU6oF6vJBP7zreovKQJ8QbrC7GjhOgJJRQBXR/kfOKbcYuAl9qVyX+t22/qKMBAr
         dYCVeTFRxNaitBsC3l4UvPHVf4N4PuYGu3J6+P88c/nHVkXzclZeg8/ibFASHKpSJ/Qq
         x44w3XMq3e2tZg1p/RMaOC17AVeMBkxmP446aBygmjSs4zNOsTOXzfFdqAs+trgS4rKb
         aFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697769393; x=1698374193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NesduVr/BG1deQGTSgj2+fzQ2Kh7lDgyaPe/Zcp2PI=;
        b=bW1tk5ZduIfBNHbac0F3NOra2EMJC1eyah/lRf48s8R/DeLBuWewFXHYiBGrbTeWKB
         8dZqH52zu8Uu8DpFVBAGn23NrQ2dZ2IX3dG/zrB4TvDhT3Xl2yuVrdQ/dWtz7oiv+TZb
         gkoLIayuME/vna41XNy0NO1XvUa7iLzNYeVYxduJgJ8vq3kuIKFqBXNrH7t/nIhc75/y
         z2mqJrKo/+0O0kNY/XEBhTmwzvQxUfRhp1E7AW+p4llq3MIVuM+Q8BNEcq0Cythfqcc6
         SkbAr1chneZSh8pXCUf7mapRgkXfbF5IqhiZD6jkgH5UH8KvIo5wAHVIu7v/LYz2wPD9
         c/4g==
X-Gm-Message-State: AOJu0YxVQO7f3Z6xT+ZBfW61uBGmtCy3GiBnzA6+3UaHOdqpgohnqfqP
	PSD+cZoh/Y5hmOp6kkehJCv5aOVgOJsi4QGG6Mo=
X-Google-Smtp-Source: AGHT+IEn9UfqNsScwgOrtbZoDRRzqtSjJNXW3SRIyhFakoLLOklNUex+uhg76LbQwEwQ6untWCQ5rz2Xf/PsCjD1KmM=
X-Received: by 2002:a67:b048:0:b0:452:9384:139a with SMTP id
 q8-20020a67b048000000b004529384139amr746035vsh.22.1697769393551; Thu, 19 Oct
 2023 19:36:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005084123.1338-1-laoar.shao@gmail.com> <CAADnVQKUBJqg+hHtbLeeC2jhoJAWqnmRAzXW3hmUCNSV9kx4sQ@mail.gmail.com>
In-Reply-To: <CAADnVQKUBJqg+hHtbLeeC2jhoJAWqnmRAzXW3hmUCNSV9kx4sQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 20 Oct 2023 10:35:52 +0800
Message-ID: <CALOAHbA8SKbTLFo=AHauDpsjth77BTuzB1452gWSO56FS993Pw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Inherit system settings for CPU security mitigations
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Luis Gerhorst <gerhorst@cs.fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 8:42=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Oct 5, 2023 at 1:41=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > Currently, there exists a system-wide setting related to CPU security
> > mitigations, denoted as 'mitigations=3D'. When set to 'mitigations=3Dof=
f', it
> > deactivates all optional CPU mitigations. Therefore, if we implement a
> > system-wide 'mitigations=3Doff' setting, it should inherently bypass Sp=
ectre
> > v1 and Spectre v4 in the BPF subsystem.
> >
> > Please note that there is also a 'nospectre_v1' setting on x86 and ppc
> > architectures, though it is not currently exported. For the time being,
> > let's disregard it.
> >
> > This idea emerged during our discussion about potential Spectre v1 atta=
cks
> > with Luis[1].
> >
> > [1]. https://lore.kernel.org/bpf/b4fc15f7-b204-767e-ebb9-fdb4233961fb@i=
ogearbox.net/
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Luis Gerhorst <gerhorst@cs.fau.de>
> > ---
> >  include/linux/bpf.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index a82efd34b741..61bde4520f5c 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2164,12 +2164,12 @@ static inline bool bpf_allow_uninit_stack(void)
> >
> >  static inline bool bpf_bypass_spec_v1(void)
> >  {
> > -       return perfmon_capable();
> > +       return perfmon_capable() || cpu_mitigations_off();
> >  }
> >
> >  static inline bool bpf_bypass_spec_v4(void)
> >  {
> > -       return perfmon_capable();
> > +       return perfmon_capable() || cpu_mitigations_off();
> >  }
>
> Yafang,
>
> this patch breaks several
> test_progs -t verifier

Sorry, I miss that.

>
> tests when system is booted with mitigations=3Doff command line.
>
> Please follow up with a patch to fix this.

will do it.

>
> As you noticed cpu_mitigations_off() is not quite right here.
> The system might have booted without that command line, but
> spec_v1 and spec_v4 mitigations are turned off.
> Unfortunately there is no good way to check that atm.
> Have you seen this patch set ?
> https://lore.kernel.org/all/20231019181158.1982205-1-leitao@debian.org/
> Please take a look at it and comment if you think it will help.

Thanks for your information. will take a look.

>
> In the meantime please fix test_progs -t verifier

sure

--=20
Regards
Yafang

