Return-Path: <bpf+bounces-54326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F19A67737
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 16:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41BA188EBE1
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 14:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5020D20E6E4;
	Tue, 18 Mar 2025 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tcl1EMrK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DC720E32D;
	Tue, 18 Mar 2025 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309983; cv=none; b=LJ1GYn5TnK2H6LX6ffrQJnpX2dCChmAbxPn7eiOjl1PbQDlEgwPAnXGmiR5Xx0R54SVBywHc0WfS6oUC9/X5Apae4+6ZTKssz/rqQsmGCfL34bG0vl77Fco0pMLYEBw62faj5RStwrbD2PnGK85znjyHt1guyytUVx+XuWHK8zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309983; c=relaxed/simple;
	bh=XwilzGJMW8mM4pGtyarra4CPyHRb5PyQklPDZcCkCH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jriavGUsTBBQH6EGPlxw6OuDQSl1xSP8Kdy+mCpqoC5+kezMeL7Qae9JqUD78p2JyoW7Pgj2BZFQyMHhRrufroNzTIPQ/0EvS4Kp6SGxGAdoDpk0qg0u0yojulJljTr3+veCMra7fsGhXGvzabYTKKNBJyI0qmd/C1rXLxM8I2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tcl1EMrK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3913fdd003bso2881698f8f.1;
        Tue, 18 Mar 2025 07:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742309980; x=1742914780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3IbVGPp8x3aPQM/NAuxeO0wEhGFzpjK3YTpNlFq24U=;
        b=Tcl1EMrK9ChWzO72ExZkUbbQzJeutybX622KJJanVqLABjsA66TWHAxRGNJmnqeH+H
         231EYm1ATdRVcPRrAIkxOU0M8hg1GSNanBU6Ftvk+ygOh4KhmCFfw26t0KxbV3V7HRlM
         ixRIgAh2oSzpMVgPWhYVk/YOLhNT0sBwznBHpeXF6FhwCP0tHzrtVOCn+7ZxTtett0sJ
         /Vs3BrcYITfP/tn3s0QeeGSiScG0yqYSLJ9iDfIi/XcIuH2WX1fV3nobAVMcal3+Fz4u
         4o5+wIn07cOJ/9u/nrM9bR7HcT2M90oGZq7Hb0+JG9OkwQL0aZsdEcALQgxavKrd+Vy+
         AFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742309980; x=1742914780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3IbVGPp8x3aPQM/NAuxeO0wEhGFzpjK3YTpNlFq24U=;
        b=qkAis8xLJ9n6Gb/R4w3wea38qIR9wbcfYeJI+AgcYwgO30kiqY4s3BSqJF2Zh90uHr
         EMR8/TP1yNv0ygL9txJuGOnSHJGO9+cmw92+O/V4xehkejbLoaNAfLtLnc2BB90zR0fA
         D+PmysC9BHOfDyNiIapn557LhLLy1ebJ0v4nyz4drrdoVvcmy/8VKfZUb8jir4h3Mwg1
         bArZYAmLHt0BMXdEcTPACFihESm5hK/V/jyWtCYBuqMjKMP8sb6U0GMXpZDpor6yQxy1
         IN/W4DdwdhsrVKnOxoSWFCLeo5Fp7RimJZAvDNq/qYRS0SH6cyFmBCmhxLdiCwHgJzHM
         h9Pg==
X-Forwarded-Encrypted: i=1; AJvYcCV7rN6s9FF2yLoOmFwWuMqO/MMv5w8dOuiPZwPyFre/45sZp6lQF2nxOa0H0+7qS6g+Nw21J6uZo6ea1MdB@vger.kernel.org, AJvYcCWXZ+rntcwa/qKDpGd6ui4B65Mv3aOzlLkvAFPxePG8mgiaqFc454BX94lhOsLPf7I6NUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhOs17Z2rpticXTy06qAKo1snz5aQzlwavCMjC3nkxem+rfDRR
	PDy51TAAah9WGt4wPuh0iNW/B2LGGniu9hVQ37mvkq0TNMIMMPPrvaLgR/4UY5ebBlOJC3+u/FU
	MibvRxS19qQEzW9G12AIq/gNyTpM=
X-Gm-Gg: ASbGncvNQLhEwi5LgkdemXQak1x4oz9+hkD3swVK0Y88HL5O4TG0ouQL3neYyMIOhaR
	l+2o0tu8bvbCnvUfQWEKSLrwhr5QJ2SnWlwoS2gm8e4XiBRjg60CVyrgNe+xvg2T1fHPeTDFneS
	DG+1blfYxP6+czY4HwqMcK52kWcEhqOmu0EKjte7Mlmg==
X-Google-Smtp-Source: AGHT+IH4VMrSU8CH3fHTu3TWM9X4Y+Aj4OA/wwwq1QoM9Pr2Bm3kF1mnBySxJ6FOPRPrTiWS44zHpNl8ysPSefs7OYo=
X-Received: by 2002:a05:6000:156f:b0:390:e904:63ee with SMTP id
 ffacd0b85a97d-3996bb772d8mr3319530f8f.17.1742309980223; Tue, 18 Mar 2025
 07:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318062557.3001333-1-chen.dylane@linux.dev> <Z9k8216IwpMZnHaA@krava>
In-Reply-To: <Z9k8216IwpMZnHaA@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Mar 2025 07:59:28 -0700
X-Gm-Features: AQ5f1JpuNmApueA2NblJk1D2carJ_ymdqh37wITwJgxYi2WYSF0p3vX9smBPYGw
Message-ID: <CAADnVQLULbENAnJqOVn4m_xmS+T7FvYSFf70mxVSdusgL85m8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Define bpf_token_show_fdinfo with CONFIG_PROC_FS
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tao Chen <chen.dylane@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 2:29=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Mar 18, 2025 at 02:25:57PM +0800, Tao Chen wrote:
> > Protect bpf_token_show_fdinfo with CONFIG_PROC_FS check, follow the
> > pattern used with other *_show_fdinfo functions.
> >
> > Fixes: 35f96de04127 ("bpf: Introduce BPF token object")
> > Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > ---
> >  kernel/bpf/token.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> > index 26057aa13..104ca37e9 100644
> > --- a/kernel/bpf/token.c
> > +++ b/kernel/bpf/token.c
> > @@ -65,6 +65,7 @@ static int bpf_token_release(struct inode *inode, str=
uct file *filp)
> >       return 0;
> >  }
> >
> > +#ifdef CONFIG_PROC_FS
> >  static void bpf_token_show_fdinfo(struct seq_file *m, struct file *fil=
p)
> >  {
> >       struct bpf_token *token =3D filp->private_data;
> > @@ -98,6 +99,7 @@ static void bpf_token_show_fdinfo(struct seq_file *m,=
 struct file *filp)
> >       else
> >               seq_printf(m, "allowed_attachs:\t0x%llx\n", token->allowe=
d_attachs);
> >  }
> > +#endif
> >
> >  #define BPF_TOKEN_INODE_NAME "bpf-token"
> >
> > @@ -105,7 +107,9 @@ static const struct inode_operations bpf_token_iops=
 =3D { };
> >
> >  static const struct file_operations bpf_token_fops =3D {
> >       .release        =3D bpf_token_release,
> > +#ifdef CONFIG_PROC_FS
> >       .show_fdinfo    =3D bpf_token_show_fdinfo,
> > +#endif
>
> there's many more of such cases.. I'm not sure if it makes sense to fix t=
hat,
> because it does not break the build and only save space for !CONFIG_PROC_=
FS
> kernels

+1.
let's keep the code as-is.

pw-bot: cr

