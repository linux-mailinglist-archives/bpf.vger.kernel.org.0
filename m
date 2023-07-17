Return-Path: <bpf+bounces-5147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C12C7570AE
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 01:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8461C20A6D
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 23:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E52E134C4;
	Mon, 17 Jul 2023 23:51:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406ABC2C2
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 23:51:46 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14191A6;
	Mon, 17 Jul 2023 16:51:42 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b74310566cso78763541fa.2;
        Mon, 17 Jul 2023 16:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689637901; x=1692229901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McGeq4gzWKMTfoTpU8ziCfU154QNGr/o0s2kT0NrIYg=;
        b=Uv73YvIt/v4CQ+2kBF46bFB0fpiCU/lRYcvWZ86lYTOiM51KT5f0g/YWuprrSUkFCA
         agclquZC5i/XoFaUbmUE3vtzxB2AxaDDawO6xw8JongqtgRYsKLlRtPXNsK192jlVyEV
         ElaxKcok/51ZWrlA1InkfTnQbOytaIm7CgvlJn7ivXn87wQJnY+q6w5/EM1hQ74yUF6G
         WE6c4jjX4vL7Zocbb7NbD133o6J73wfl01X/obxqTO6op3j85kTA6x9VGJpoYx6oPKto
         2sdTj0XmK6EMNRWZxw1WZ2zR0PlW5tO4/Nm2XHBmnYtt4U/7Aq4JI0K79gERwwqpwF2G
         pr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689637901; x=1692229901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McGeq4gzWKMTfoTpU8ziCfU154QNGr/o0s2kT0NrIYg=;
        b=U69cXEcnqrf7fIvKud2JGMwFA0k/29VzWRjc0YxlbhYMgguqslmk2dxven//40Vc8V
         lfku00v95Csg9itD/Pu9zVkoj+AoL7fJD696yUX4N1dV5Tx1urdcsmrJUpPcUvSFH9Q8
         zeDh9AgHWcUyrdrI+PrlXMXO93ucxRC9L/mYbk793idbipYfwKBVOSERxV3s0BABkH/Z
         NnGCQGGgQ1ufFzpRt+yUUGsXzC6jee1onZIr5zn42zwnG2fqwSd2rJ05PN4ZD4evxO5i
         7lsAdJ0CwF3MCF7h0ZfENmJHYk8jLwor81iqMqNhi9ycFOJfUphMu9UI2OaRMtfPr/HW
         3ADQ==
X-Gm-Message-State: ABy/qLb7HPvJQ56776yT9NdgFy21ZYQvShsyBl73udE1KSOKUZe3/Yle
	A1CWxgLJkfGl3lM8BcVMM7xCO4Sq4Qe3CPzz0CTrs3jt
X-Google-Smtp-Source: APBJJlGlz+Mr9LD2SBeqAcDjjFixVxTFWBSUKFJSGbKDQ+KY1MLfNQ0RpiJTG2ZhKhUNNCBiR4VSCwgmusGMiO6/kDs=
X-Received: by 2002:a2e:9e4b:0:b0:2ac:82c1:5a3d with SMTP id
 g11-20020a2e9e4b000000b002ac82c15a3dmr8393448ljk.23.1689637900633; Mon, 17
 Jul 2023 16:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
 <168960741686.34107.6330273416064011062.stgit@devnote2> <20230717143914.5399a8e4@gandalf.local.home>
 <20230718084634.7746b16b470f5fa1b0d99521@kernel.org>
In-Reply-To: <20230718084634.7746b16b470f5fa1b0d99521@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 17 Jul 2023 16:51:29 -0700
Message-ID: <CAADnVQK6J2TNNRMaZDkC7NNHO6uGs4MrUvocWW-TXsSNg_7s5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] bpf/btf: tracing: Move finding func-proto API and
 getting func-param API to BTF
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 4:46=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> >
> > > + * Return NULL if not found, or return -EINVAL if parameter is inval=
id.
> > > + */
> > > +const struct btf_type *btf_find_func_proto(struct btf *btf, const ch=
ar *func_name)
> > > +{
> > > +   const struct btf_type *t;
> > > +   s32 id;
> > > +
> > > +   if (!btf || !func_name)
> > > +           return ERR_PTR(-EINVAL);

Please remove these checks.
We don't do defensive programming in the BPF subsystem.
Don't pass NULL pointers to such functions.

