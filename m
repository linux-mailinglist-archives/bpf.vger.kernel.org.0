Return-Path: <bpf+bounces-10209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5D47A31AB
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 19:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311BA1C20984
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 17:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05A71BDCA;
	Sat, 16 Sep 2023 17:31:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0146FC8
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 17:31:16 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDE11BD
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 10:31:14 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-52a39a1c4d5so3817460a12.3
        for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 10:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694885473; x=1695490273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTOqKMgOTxWc+ByIgGJUsRyRBcjUJImMvcKHDBjT8zU=;
        b=VkCiS6RznpwsGbQ0CFStENtKdUMN5gn+0gYPZhuS5w1zaUp+hEu/bQXURN52z0OxLh
         kY0L/5f+NsiIlQF/mZMKh75+AzNiSxml/DL3ZcvY/CXSgbwSKdSajEnBWJ0U3xMM5e1R
         I0NSThwOwTaK+RyiWjdGYCim+zALUlesl6jqA+lzqL9W2sXDS9tOFrwJdS0xdY+/oK2W
         a8DqrUcs/LHWk0ATkxSjyY/fdjWpcIAgvv65erYqMzCtGKyW6PYvetrOAzMBE1n93Hnj
         ReTK9JJxdaDt6CkdRWmMu8P4cGMEXDtTEq+J+x7RklQ52W1CePJjtZKs2RyurBupIEwa
         51pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694885473; x=1695490273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTOqKMgOTxWc+ByIgGJUsRyRBcjUJImMvcKHDBjT8zU=;
        b=Hs5NhUvmDxSoMZt8RGPbgXoXg8jsUlX4PHfgZFtfSpYlozE0nC8AAnJJS+KKwckbXo
         9+WbYQ68im5gyLCJCZ8ry7PfyzM5cckQgCcQMJwrq+85heiZKSP+N1tWOWzDGovctR/M
         PRgHrNTeYYJaHqHrxk0bnTOe3O2BwWeZ9g4T3xI8vdyKMwDRC2l+1IvtKwW7DHxO1e0H
         KH4fkzTpQaY0P4uDAZZkKTjThBEkbBoE+dl+Q384YzgDzi/9Urc7IDU2u0sc6O52wfy6
         egMDdeypPeVnIMTizlTjWoAVuVzEgcJG9CUjN5Ja5mombQN8bHoiY2i4CeUOkx8RqL/m
         0epQ==
X-Gm-Message-State: AOJu0YxcH7B96dW1aN+srWvecyEFrRrNtbqT2Ae8qUeAflLaZD+qLTw8
	kPFqNYJ0wOa2iNvU1+qMcj29cWXPt++TqY0ZO3AL52hZAqQ=
X-Google-Smtp-Source: AGHT+IFKk7lzHYR2S1m1NodUOe0lrvzSOTFrqFhRb9Ta4fIYe1usrv985+I6Ys1MhOQgsP3ShA2SRVqL3VBbpz5bFNs=
X-Received: by 2002:aa7:d491:0:b0:522:3a0d:38c2 with SMTP id
 b17-20020aa7d491000000b005223a0d38c2mr4044196edr.9.1694885473220; Sat, 16 Sep
 2023 10:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912233214.1518551-1-memxor@gmail.com> <20230912233214.1518551-13-memxor@gmail.com>
 <mb61pmsxq14h4.fsf@amazon.com> <CAP01T7691P9m4ZrDQk63waC9wGu3ToK-cznsHha-r6Lteh0fWw@mail.gmail.com>
 <CAADnVQK-DoX19C-rManYh2p99ixO7QKkd6NrvpaYuoRbco_ubA@mail.gmail.com>
In-Reply-To: <CAADnVQK-DoX19C-rManYh2p99ixO7QKkd6NrvpaYuoRbco_ubA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 16 Sep 2023 19:30:37 +0200
Message-ID: <CAP01T74ZG7q_=1=bbfk-5Q978dR7UN_zwch0KWYkZPObLNSy2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 12/17] bpf: Disallow fentry/fexit/freplace for
 exception callbacks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 16 Sept 2023 at 18:44, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 14, 2023 at 5:13=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> > > >                       }
> > > > +                     if (aux->func && aux->func[subprog]->aux->exc=
eption_cb) {
> > > > +                             bpf_log(log,
> > > > +                                     "Extension programs cannot re=
place exception callback\n");
> > > > +                             return -EINVAL;
> > > > +                     }
> > >
> > > This check is redundant because you already did this check above if (=
prog_extension branch)
> > > Remove this as it will never be reached.
> > >
> >
> > Good catch, will fix it in v4.
>
> No worries. I fixed this duplicate check while applying.
> Everything else can be addressed in the follow ups.
>
> This spam is a bit annoying:
> $ ./test_progs -t exceptions
> func#0 @0
> FENTRY/FEXIT programs cannot attach to exception callback
> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
>
> func#0 @0
> FENTRY/FEXIT programs cannot attach to exception callback
> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0

Thanks for fixing it while applying. I will send a follow up to
silence these logs today.

