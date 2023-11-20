Return-Path: <bpf+bounces-15342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863977F0A7D
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 03:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B212D1C20837
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 02:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425D41874;
	Mon, 20 Nov 2023 02:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOmppsRl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E148137
	for <bpf@vger.kernel.org>; Sun, 19 Nov 2023 18:11:24 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3316a4bc37dso1604953f8f.2
        for <bpf@vger.kernel.org>; Sun, 19 Nov 2023 18:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700446282; x=1701051082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wW+wp6eEsOQW68ii1iWR3AwBz4HSmYkYG7SuXtX759g=;
        b=VOmppsRlPmGbLocYbjJGpF+QjdG4n6CyARguX02nOoTa8CJKTOWFbojv4OsdhukTvy
         ik5lEjUXPwb+uxAZuxY7PH7EDrRJW1iU/oAhD3/uW9/QTXK7q0w0IuhM38BjoIsfo9NQ
         BwsgtGn6N9clvg3Yp7ZX0Ur+O8SFV6ntWeGSW/dXfJUdnWMZ90+xdAKSraZ2t4MYY2eC
         8I6+g1B1uSKWWYqVCSavq5lpnELqC4EDgXsdMgfrouIZd/QCWv9dzfRwrA5Yuv3hHo2V
         uwbmWr4naOL9HZFkodQnYCHnuq8rPcHQzoHoYMi2skBOusXXqbxHmEJQ6p4p/zOJw0Y4
         PuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700446282; x=1701051082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wW+wp6eEsOQW68ii1iWR3AwBz4HSmYkYG7SuXtX759g=;
        b=wJl3pYNgCQLbUVIcejCFKHFJNXTHhkez5tsYOIUZJogeYfDyQ12VYpbZ72eFz6I/1g
         W2cPOpfd8M3zvj+xcRdb9IVGHtld4gF0nIVTgVhxsd0HVGlX+8DGcZb+xq0lu7QkChk4
         0stmB5n7kEkydsOnP82qp/ScABiasi56K6mfHjqC9QPT8AEo/4ELg7Tp69A4ddSD9vZk
         G3ionbG3TVQnc+yCZ2wD2IOh5pnvnTbrqNjtSHqIGNUn3/pnHiV4eMTGIc2g9eXCyCvW
         aR2aRSZZCC2FUIsqMb6Yp/bA9hEdViHrGtAeGdGzFVm4SAGnkkR/wez1sNi4ozwF7rMw
         /HJQ==
X-Gm-Message-State: AOJu0Ywo+igWGd6cJIhqEpRtMZ812E7edz2ZklIXkJWsmK3t5VNrez4T
	uhuo5ime+jVKY5Zft+jjk0Le6okGti2CvI/PJ+KdlA0Y
X-Google-Smtp-Source: AGHT+IEzBf01Wo+lRZrk/VaM/tV0+gJNwHq4gY5N2Wf+jyZI5QkXEBOYhglvNK49kYBZPoJI7vnajc5wY5BFVTKBmus=
X-Received: by 2002:a05:6000:4c6:b0:32f:a6fe:9c00 with SMTP id
 h6-20020a05600004c600b0032fa6fe9c00mr3267646wri.35.1700446282568; Sun, 19 Nov
 2023 18:11:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118013355.7943-1-eddyz87@gmail.com> <20231118013355.7943-11-eddyz87@gmail.com>
 <CAADnVQ+Zit-KLSnoo0x-dh7Ek-VGm1K0-oBWZ085dke-ztYLMg@mail.gmail.com> <3f21d362899947f716a0cfa93b9c22bcec66afd8.camel@gmail.com>
In-Reply-To: <3f21d362899947f716a0cfa93b9c22bcec66afd8.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 19 Nov 2023 18:11:11 -0800
Message-ID: <CAADnVQKXG+aydLKE+as9B_S0KTd_cScO4-x12vAiyp_uyuXQQA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 10/11] bpf: keep track of max number of bpf_loop
 callback iterations
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Werner <awerner32@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 6:06=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Sun, 2023-11-19 at 18:00 -0800, Alexei Starovoitov wrote:
> > On Fri, Nov 17, 2023 at 5:34=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifie=
r.h
> > > index 7def320aceef..71b7c7c39cea 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -301,6 +301,15 @@ struct bpf_func_state {
> > >         struct tnum callback_ret_range;
> > >         bool in_async_callback_fn;
> > >         bool in_exception_callback_fn;
> > > +       /* For callback calling functions that limit number of possib=
le
> > > +        * callback executions (e.g. bpf_loop) keeps track of current
> > > +        * simulated iteration number. When non-zero either:
> > > +        * - current frame has a child frame, in such case it's calls=
ite points
> > > +        *   to callback calling function;
> > > +        * - current frame is a topmost frame, in such case callback =
has just
> > > +        *   returned and env->insn_idx points to callback calling fu=
nction.
> > > +        */
> > > +       u32 callback_depth;
> >
> > The first part of the comment makes sense, but the second...
> > What are you trying to explain with the second part ?
> > How does the knowledge of insn_idx help here ? or helps to
> > understand the rest of the patch?
>
> The intent was to explain that 'callback_depth' in frame N refers to
> number of times callback with frame N+1 was simulated, e.g.:
>
>   bpf_loop(..., fn, ...); | suppose current frame is N
>                           | fn would be simulated in frame N+1
>                           | number of simulations is tracked in frame N

I see. Pls use this instead. Much clearer :)

