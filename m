Return-Path: <bpf+bounces-19162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55646825E26
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 04:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482DE1C23BC5
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 03:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393C117CB;
	Sat,  6 Jan 2024 03:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vtmvtgxq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A81E15B3
	for <bpf@vger.kernel.org>; Sat,  6 Jan 2024 03:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33761e291c1so26184f8f.0
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 19:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704512793; x=1705117593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToYotUcIt1lbFUS2hnSvW2LY0zd9ddI4zr6uXpn6vSc=;
        b=VtmvtgxqT4zHgHuUnVLhAWXRGtlxU107s8UhBrjujwezNwlJ3gfDwI3zT3EZKS4WqJ
         eTGsGFvtYaZXlIa1SJTmZYApRRiQewyQrIRqJXZ+d/pRWmxzBfsQ2rqHiiVEu+LbBLko
         PApcmedVrsb0axqwp+tYOD0bHP7+i+n2h/fy8yxNAcVNGPJxwKjRhOk/uOuKOfuLbDwC
         Ml0TvtTlY5XvSPrGNEsxy4H/GyHiPJtkLQ14owetJ4Oq9bZWR8R/wmGmyTJQ09yoKX3t
         dZjAawxXeP0sAWPLwFlu1Vko1/0+4lO9NKJDFLsvIrd63Olx0uPck0eWOPGzkCzo1FoM
         5CHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704512793; x=1705117593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToYotUcIt1lbFUS2hnSvW2LY0zd9ddI4zr6uXpn6vSc=;
        b=PafTdWXZ0/ff9/vl2XKvBfwqlVaBUQgCz17568WPipSjuzNtJkyPWjFgXM2YTeLYl/
         XK0W1FZYPFB+Lczs6cqDukvsXl/9c8l++766MGrHyru99HJg+1ObZMjb9BbGDimTqJym
         VG6qGyj8xzamS4K+3AslhBFCuaJLkzJi0y+7GWqn9ZQz5EEshRhGboRmnPYFyOMA3Wyz
         EF5nEopt9nBtdHsJr4nfahmi5ZXW7CdEG4kGF+rDrb+GG//4AqyB79ezel9MHFIVBIiA
         9guq0pQixX3ZoM0iQIi8Or3XSbQUqMoB03EDVhsj8psT3xCJRGrQQWls9imYgbqiiE9p
         E3wg==
X-Gm-Message-State: AOJu0Yw8cfgvY3dtBiYvFIkEUGQt9z2Tev5FYgnCMvPXaW1cnOyxMdZ1
	n2WeRFN2IFyAm5KutlX0ujXEtwyMiUCWCuJYAhk=
X-Google-Smtp-Source: AGHT+IFy4trhT8AojK19TntDWmvVbmWmjmLUdRN2sHeir+Oe9T2tVALkB+74qUmX/b4Nsggn36zl6IiJbmzQDQ90rFQ=
X-Received: by 2002:a5d:4e8d:0:b0:336:74e1:4561 with SMTP id
 e13-20020a5d4e8d000000b0033674e14561mr142080wru.30.1704512793270; Fri, 05 Jan
 2024 19:46:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104142226.87869-1-hffilwlqm@gmail.com> <20240104142226.87869-3-hffilwlqm@gmail.com>
 <CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggAiCZrpw@mail.gmail.com>
 <ZZf4uXuSvFq1JwU1@krava> <65989c459a6b6_3a2dc208c1@john.notmuch>
In-Reply-To: <65989c459a6b6_3a2dc208c1@john.notmuch>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 5 Jan 2024 19:46:21 -0800
Message-ID: <CAADnVQJTVroV5_975+gY3PF4Es84_9bHzu_EJy2wfWk7uZd9NQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf, x64: Fix tailcall hierarchy
To: John Fastabend <john.fastabend@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Leon Hwang <hffilwlqm@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 4:18=E2=80=AFPM John Fastabend <john.fastabend@gmail=
.com> wrote:
>
> > > -       if (!bpf_prog_map_compatible(map, prog)) {
> > > +       if (!bpf_prog_map_compatible(map, prog) || prog->aux->func_cn=
t) {
> > >                 bpf_prog_put(prog);
> > >                 return ERR_PTR(-EINVAL);
> > >         }
> > >
> > > This will stop stack growth, but it will break a few existing tests.
> > > I feel it's a price worth paying.
> > >
> > > John, Daniel,
> > >
> > > do you see anything breaking on cilium side if we disallow
> > > progs with subprogs to be inserted in prog_array ?
> >
> > FWIW tetragon should be ok with this.. we use few subprograms in
> > hubble, but most of them are not called from tail called programs
>
> We actually do this in some of the l7 parsers where we try to use
> subprogs as much as possible but still use prog_array for calls
> that might end up being recursive.

So you do tail_call into a prog that has subprogs. Ok.
Any pointers to a code? (Just for my own education)

Anyway, we need to come up with something better.

I've been trying to play with a few ideas on how to propagate %rax
back from subprog into caller, since frame layout is known, but
struggling to x86 asm it.
Roughly:
RESTORE_TAIL_CALL_CNT
emit_call
copy from already dead stack area back into tail_call_cnt of this frame.
Since IRQs on x86 are using different stack it should be ok?

If I'm wrong about stack usage and dead stack can be scratched
the emit_return() can store ttc into %rdx and after emit_call we
take it from there.

