Return-Path: <bpf+bounces-11591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A197BC2C9
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 01:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417E81C209EE
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 23:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C8945F72;
	Fri,  6 Oct 2023 23:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGGt2VDb"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D011344487
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 23:07:08 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F075393
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 16:07:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so24019115e9.2
        for <bpf@vger.kernel.org>; Fri, 06 Oct 2023 16:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696633625; x=1697238425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IvT8HUUMWyErGis/DYt2jgKfgnESMJvheoFrfgEBGA=;
        b=UGGt2VDb5SDjQap7B88zeI4NXZkXY3iwxyIquauIQuM9x+e16VnRnEl+deohlNLRpP
         SkfXnXAjkUxhnNW3jqb83tWXvEhHRnLD0xbw8XEuPgyHSA8l2TZQ3bYoVgpVW8FSPPhM
         /3gSJe7B8elFsb2r4cWoFfELIlw34yDBg1b4kFiiprNE8HlnCCt3B4WBPwDiusQJiujO
         AQ8jTrKNj806Ii0qQEScea6UubUNbH4DpElA8L9X4ShxcTezHHrECeCy4b2EprZ6vZPv
         9DX42Nl1jlJIVyi+M5kSrPnUvzZBDuhebFGgEJwe3WP2iVlPXyvZoV2l6GOhRHvFBt3E
         7f9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696633625; x=1697238425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IvT8HUUMWyErGis/DYt2jgKfgnESMJvheoFrfgEBGA=;
        b=eEOrbimruX4rDaxWrnIewit66D3fOx8tQNzO+ViLX5fSu3R4nSheoCXwqQnh5SQh2c
         mcrReZs+jvKCEHUQodLEAuFe4bUlx+PQMxp3mHPWCWjmx/F/C6Dm/3IgLUU+6CjuxaBD
         uogLTUKc/uY3C/GS8h6OKx2gg5JOBr4zYkYRd08RycJ/VkW3rRCOx/+b8WjGx2QDgo1G
         YFFBttHkReT9d+zNO6tHm8ZMdQ+TGPt6pWG3TTZMyRTE0FtL2jsmL+vW+hJDzX0InQLp
         6rVq4BFG7YQk3kmAwL9vWjwVj4AsrBvLoBqpr6tkVNI7PEpNXlcsAcoE1XNsuxI0SUE4
         dcmQ==
X-Gm-Message-State: AOJu0YwpPqIufTcBdZQ2GxyxoLVb5XefLMyIyv1kPYV8SXaHcX2vJBvv
	sGClD2Pup6cEbIOkpoQ+WziJmUUIp2bfQnv1tL71ohMc
X-Google-Smtp-Source: AGHT+IFxxFDXENFsO3nDRIcNThd6pM9Q6AC2KQGdHxMCEjqyZIWvK4DABdZqTi7BsZ7iIa76lIT4zfV1wLyId76k+qc=
X-Received: by 2002:a7b:cd0a:0:b0:405:3dbc:8821 with SMTP id
 f10-20020a7bcd0a000000b004053dbc8821mr8395683wmj.22.1696633625036; Fri, 06
 Oct 2023 16:07:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR21MB387850B8DB6A2A5FB87DAC06A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <PH7PR21MB3878027C6E6FB01651023912A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQL69iqzxsNRDLKW22B=3sJpO0Yy2yHzioWZmhtQvUwtTQ@mail.gmail.com> <PH7PR21MB3878A25F817337EF14FE039FA3CAA@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB3878A25F817337EF14FE039FA3CAA@PH7PR21MB3878.namprd21.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Oct 2023 16:06:53 -0700
Message-ID: <CAADnVQ+BOdrU4x3qKHJVbpZCJwTWe6HXWhuMqOk-x5UK22yPDQ@mail.gmail.com>
Subject: Re: [Bpf] ISA RFC compliance question
To: Dave Thaler <dthaler@microsoft.com>
Cc: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 5, 2023 at 1:14=E2=80=AFPM Dave Thaler <dthaler@microsoft.com> =
wrote:
>
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > On Fri, Sep 29, 2023 at 1:17=E2=80=AFPM Dave Thaler
> > <dthaler=3D40microsoft.com@dmarc.ietf.org> wrote:
> > > Now that we have some new "v4" instructions, it seems a good time to
> > > ask about what it means to support (or comply with) the ISA RFC once
> > > published.  Does it mean that a verifier/disassembler/JIT compiler/et=
c. MUST
> > support *all* the
> > > non-deprecated instructions in the document?   That is any runtime or=
 tool that
> > > doesn't support the new instructions is considered non-compliant with=
 the BPF
> > ISA?
> [...]
> > > Or should we create some things that are SHOULDs, or finer grained
> > > units of compliance so as to not declare existing deployments non-com=
pliant?
> >
> > I suspect 'non-compliance' label will cause an unnecessary backlash, so=
 I would
> > go with SHOULD wording.
>
> Yeah, but if each instruction is a separate SHOULD, then a runtime could =
(say)
> support one atomic instruction and not others.  Having that level of gran=
ularity
> would really complicate interoperability and cross-platform tooling in my=
 opinion.
> So it might be better to list groups of instructions and have the SHOULD =
be at the
> granularity of a group?

I guess we can group them based on LLVM evolution of the instruction set:
-mcpu=3Dv1,v2,v3,v4
but it would have mainly historical benefits and not practical.
Grouping atomic vs not is not realistic either, since atomic_xadd
was there since the very beginning.
I suspect any kind of grouping scheme will end up in bike shedding.
My preference would be to agree on either SHOULD or MUST for
all insns currently described in ISA doc.
We can go with MUST to force compliance.
Some archs, OSes, JITs won't be compliant in the short term,
but MUST wording will be a good motivation to do the work now instead of la=
ter.

