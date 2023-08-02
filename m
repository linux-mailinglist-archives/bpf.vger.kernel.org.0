Return-Path: <bpf+bounces-6747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA0276D828
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 21:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DBD11C21146
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 19:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33F41097C;
	Wed,  2 Aug 2023 19:48:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E734100D1
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 19:48:29 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0EF19AD;
	Wed,  2 Aug 2023 12:48:27 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so2496621fa.1;
        Wed, 02 Aug 2023 12:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691005706; x=1691610506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXpNsLUTVNX9sFjFzmjiCCJcWZd1K7Cg3XGCsj2KKNo=;
        b=sQ2U1U8IIoBh/ny1VCsSidkVurHcchk62vCBvykv+inOZa8u3oRLhx2yX8U/YL+cEF
         salGgBTvsOgGURhMCOzlTCrSJ6i9k3vpu1blDlBgh5UbWsFbEjyKXwVBPbGvGwwMj0SX
         hjv2IYhdV9H42t4qX2SRiJWKkil4pmkqRZsAFDybxmgEHzbWKkIg8cauv29JByaj0Dkz
         RXy42dGSiHmvzUa1ZKA5uvXzbr61ddy4GPW91NSl+eTtaxl7kaKBAXMMaopirhZI6GuG
         L3BWtI/x9AryBODOIZMJfcuRkW7hTj5+h8LnefyB1RuVzHTIkQeEqPpFoylN6brBMVby
         votA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691005706; x=1691610506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXpNsLUTVNX9sFjFzmjiCCJcWZd1K7Cg3XGCsj2KKNo=;
        b=FhAIhHRG+MNNpAfre+a0P2AzWfVHw8KwmUJVW1yBLt8PPq27Wq47jAy2yUaG5kD77B
         QmHU8IEXPiRfQQAcwh/Q1zUsqKWYMxgtN1LXT5/f56Qb9nl7HTsUVn48+3YBACbUYveh
         y+JxY9Umeqa7cBQcoS6Ab3RAn8yI8D6wKPINBQ4aLWemAFn3h/Rer2rg0KbeVFxP5xbP
         TQPRRMT8NsHeTzbW5P8SUYHt+7bE/pcv9OqR4XuxqE4Hfd4R6bIU4Vugt3FzcGQBeLSD
         L/iw+GxjTf7IBYQLbGJVOMxHSfactsQakMULWxzn5hcqXhR1MSeYkA6AcdH8Sx+aumUf
         E9Ng==
X-Gm-Message-State: ABy/qLbxssHI+IQJhTqu5gl7Yh0iiP2c5VuRxdHaw1Pr4jLpd5yb4y1o
	syWcj/2ap4tJlCNSSSVKlVHlNmz2Mv9hqSLln30=
X-Google-Smtp-Source: APBJJlHlxMdggwopQssuoCt8lzP5bNn6ZIJV546T5xLie+1ywQnrCL0NC/a+gB3Z1wkMD2n3cccZnZeaIMW6H4G6OS0=
X-Received: by 2002:a05:651c:201:b0:2b6:dd9a:e1d3 with SMTP id
 y1-20020a05651c020100b002b6dd9ae1d3mr6025265ljn.44.1691005705801; Wed, 02 Aug
 2023 12:48:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
 <169078863449.173706.2322042687021909241.stgit@devnote2> <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
 <20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org> <CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
 <20230802000228.158f1bd605e497351611739e@kernel.org> <20230801112036.0d4ee60d@gandalf.local.home>
 <20230801113240.4e625020@gandalf.local.home> <CAADnVQ+N7b8_0UhndjwW9-5Vx2wUVvojujFLOCFr648DUv-Y2Q@mail.gmail.com>
 <20230801190920.7a1abfd5@gandalf.local.home> <20230802092146.9bda5e49528e6988ab97899c@kernel.org>
 <20230801204054.3884688e@rorschach.local.home> <20230802225634.f520080cd9de759d687a2b0a@kernel.org>
 <CAADnVQLqXjJvCcuQLVz8HxF050jDHaSa2D7cehoYtjXdp3wGLQ@mail.gmail.com> <20230802143845.3ce6ed61@gandalf.local.home>
In-Reply-To: <20230802143845.3ce6ed61@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Aug 2023 12:48:14 -0700
Message-ID: <CAADnVQKrL3LZaRcgoTdGN-csPt=eyujPbw9qoxgv9tPYPmZiZA@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a struct/union
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Florent Revest <revest@chromium.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 2, 2023 at 11:38=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 2 Aug 2023 11:24:12 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > This is a non starter.
> > bpf progs expect arch dependent 'struct pt_regs *' and we cannot change=
 that.
>
> If the progs are compiled into native code, isn't there optimizations tha=
t
> could be done? That is, if ftrace_regs is available, and the bpf program =
is
> just using the subset of pt_regs, is it possible that it could be compile=
d
> to use ftrace_regs?
>
> Forgive my ignorance on how BPF programs turn into executables when runni=
ng
> in the kernel.

Right. It's possible for the verifier to do an offset rewrite,
forbid certain access, always return 0 on load from certain offset,
and so on.
It's all non trivial amount of work.
ftrace_partial_regs() from ftrace_regs into pt_regs is so much simpler.

