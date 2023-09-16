Return-Path: <bpf+bounces-10206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B35337A3179
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 18:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985991C20929
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 16:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D668818E27;
	Sat, 16 Sep 2023 16:44:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8185F12B9A
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 16:44:40 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CE2CCF
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 09:44:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31aeef88a55so2733514f8f.2
        for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 09:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694882677; x=1695487477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0N1j/D25A+lCGZOMWswfWaApqqqquISpnpXyWUb4tFI=;
        b=Ed3cMMUxnWXu91mn/y6jNg0/Efk6j7vwLeYerkakU0gsklJ0E7nL8yq0mF2yPcLAXB
         iSlhXJKGz1tCT2PNPwppLEJDW68kxh6oT5anvTphXb1+WhUMTGzXIjkFRicd4MYyPEnS
         Gratc2g5ZfiRvQF3Zh+AZhZTk2xT6klNGmkSecAPp9hH63JbQnMwlFhpsXTcts3u3n6k
         uc4OrHgW8pr1+JaN76mCEtEV+pjja1rbfkWXu5BQT+27PmK+4QYUTtxE2EWs4+Adjuuv
         bWMl6fjyg7lQdKyTQO8PHFSH59MOydaotGp2gnpzC9p4jbYLTrE7vTiwf3zpsrrRDHlz
         BY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694882677; x=1695487477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0N1j/D25A+lCGZOMWswfWaApqqqquISpnpXyWUb4tFI=;
        b=ZX8Mkaiot6D2tICyhf+H8GeYvcK3QE/0us01E52WgottX0xWvwhErk2pdBbPPcImtg
         XKUFMCFmq7hMwPp+24bdqSD7E6jqpNa0qlzVRgqral8eqPEwxMnHpiBF3pAYmObKc/5l
         NbhHXY7u4ThWQGTIyUa/Zcs/Qbnq+dgXApdcF8CfCjgCmXPYJcMmOJvj/3pyKmlrvzL6
         ILbxs1vJgpO2p+ULXjV0XlkZHMj6NQzPt/96MRWRrQHBWJm8uDEahLtEAPkHDjRQH26B
         6ewwfu1c1EVq76+tsGoNIQiInCnnqEPTFR2TP2aurCv+2fqt6Zszg6MXn0D2KSAFhsOY
         cLyw==
X-Gm-Message-State: AOJu0Yxq6p1hsF1Uv9teb4wU2bDaLI0q20QN/dQGnINQnu6yLxGRzJgJ
	+KTMKIj+GgsLPxp3Xxi3BJFMbhDaQXy+BwMj9t8=
X-Google-Smtp-Source: AGHT+IEpTaBn4+LHWTwirWPRT09RZyuIezKLAbuDcfLAxdPjh77KkJN78Vwj5XWKwsbQBHZpSSQUDZVGvpcuBxVXKG0=
X-Received: by 2002:a05:6000:98a:b0:320:261:b87f with SMTP id
 by10-20020a056000098a00b003200261b87fmr1887372wrb.62.1694882677099; Sat, 16
 Sep 2023 09:44:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912233214.1518551-1-memxor@gmail.com> <20230912233214.1518551-13-memxor@gmail.com>
 <mb61pmsxq14h4.fsf@amazon.com> <CAP01T7691P9m4ZrDQk63waC9wGu3ToK-cznsHha-r6Lteh0fWw@mail.gmail.com>
In-Reply-To: <CAP01T7691P9m4ZrDQk63waC9wGu3ToK-cznsHha-r6Lteh0fWw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 16 Sep 2023 09:44:25 -0700
Message-ID: <CAADnVQK-DoX19C-rManYh2p99ixO7QKkd6NrvpaYuoRbco_ubA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 12/17] bpf: Disallow fentry/fexit/freplace for
 exception callbacks
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

On Thu, Sep 14, 2023 at 5:13=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> > >                       }
> > > +                     if (aux->func && aux->func[subprog]->aux->excep=
tion_cb) {
> > > +                             bpf_log(log,
> > > +                                     "Extension programs cannot repl=
ace exception callback\n");
> > > +                             return -EINVAL;
> > > +                     }
> >
> > This check is redundant because you already did this check above if (pr=
og_extension branch)
> > Remove this as it will never be reached.
> >
>
> Good catch, will fix it in v4.

No worries. I fixed this duplicate check while applying.
Everything else can be addressed in the follow ups.

This spam is a bit annoying:
$ ./test_progs -t exceptions
func#0 @0
FENTRY/FEXIT programs cannot attach to exception callback
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0

func#0 @0
FENTRY/FEXIT programs cannot attach to exception callback
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0

