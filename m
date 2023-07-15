Return-Path: <bpf+bounces-5056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C642D7545A0
	for <lists+bpf@lfdr.de>; Sat, 15 Jul 2023 02:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8721B1C21659
	for <lists+bpf@lfdr.de>; Sat, 15 Jul 2023 00:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04397E8;
	Sat, 15 Jul 2023 00:23:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF14C163
	for <bpf@vger.kernel.org>; Sat, 15 Jul 2023 00:23:24 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EF33A95
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 17:23:22 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b6ff1a637bso37560491fa.3
        for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 17:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689380601; x=1691972601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mN4ioxzNj7bQxuk2vBcEGRf0mcVVJXxZupsQurmYKog=;
        b=bmu1dgzks5b1IPzM3Zu8n8SO5LpdJ9OLkQFVN9TEV5c/fWH/QGC00L74cPWG59TDje
         c3dFhqAWEv+p2rlbnDfWifPiFi17PajSmWelMRaN1AgjB7lsKv3Ut8FWqUMMj37+J1s5
         6/V0+ae+1j6VgyqVzTUYWhVo0YKebYzSPemST0+H28ZkcC7GHWnuAsV+cyIOJny38Pk7
         VMeqG/pp7WkrCfrVw/96EqXH8APwVoEItzG73fJNUnjg+7bM1x+rTCFqBsb3ONX5IRnF
         tefybUyxU169ibrEBV6b3wHy5F/sqOI6e2MhAYDsEVAwT+u/mp21AWHbJA+z7ahfy38A
         CzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689380601; x=1691972601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mN4ioxzNj7bQxuk2vBcEGRf0mcVVJXxZupsQurmYKog=;
        b=inVI9ixS52Jgfz55msCt1VPYdxpwR8aszLKTok35TUXYCO8jc4xsjJUfNtYAodaBGr
         f5yv2eQV4MFM/Ckr4E2Ol0KtXz3RbylSakqslBScu2t4OdGSOZLhLoBjngol2sOs/RcY
         fZdg2EepXcCrSh+y+vojFL4tus3bBoZgULbWOREEweF0sVZ51O7IgKYIlUL/KuwfcKK1
         xLu1ZzDYP/j8B9U7nsrWlcEMKq9FqAobCM+o0r9PAEmqlw/3PUVkS2KFfNRq5CYV2jIf
         IDf0JJocqV8yODRS9nhSfP43uGq51BP/v0R+tPvBExbHFsxNc5c80oE8x3ZgGTBydiRJ
         /q8A==
X-Gm-Message-State: ABy/qLaMTbBzGcPQhppuBdRpbgih5QM2K2k6jIiLADyPxZE0Kqt+OF2R
	kAEp7u037IlDEQFLDFR8BQ6joODd3Pqt1UGO9Gs=
X-Google-Smtp-Source: APBJJlEtR/O/OebWr2HyF/l3RYvR2nM4QYSQy8wHK+OL/YC5/YE5TwmPzsgwR0sjL/68FjEeyJcmrCwYOR0SGaRj9Rc=
X-Received: by 2002:a2e:9c02:0:b0:2b4:83c3:d285 with SMTP id
 s2-20020a2e9c02000000b002b483c3d285mr5582655lji.38.1689380600507; Fri, 14 Jul
 2023 17:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713060718.388258-1-yhs@fb.com> <20230713060847.397969-1-yhs@fb.com>
 <PH7PR21MB38788F07F700A549DEB96F9BA334A@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB38788F07F700A549DEB96F9BA334A@PH7PR21MB3878.namprd21.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Jul 2023 17:23:09 -0700
Message-ID: <CAADnVQLtdMw_xk84tTOgXvat9NRi7eceRDbiim21rJeR=LDdrA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 15/15] docs/bpf: Add documentation for new instructions
To: Dave Thaler <dthaler@microsoft.com>
Cc: Yonghong Song <yhs@fb.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "bpf@ietf.org" <bpf@ietf.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Fangrui Song <maskray@google.com>, 
	"kernel-team@fb.com" <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 4:33=E2=80=AFPM Dave Thaler <dthaler@microsoft.com>=
 wrote:
>
> Yonghong Song <yhs@fb.com> wrote:
> > Add documentation in instruction-set.rst for new instruction encoding a=
nd
> > their corresponding operations. Also removed the question related to 'n=
o
> > BPF_SDIV' in bpf_design_QA.rst since we have BPF_SDIV insn now.
>
> Why did you choose to differentiate the instruction by offset instead of =
using a separate
> opcode value?  I don't think there's any other instructions that do so, a=
nd there's spare
> opcode values as far as I can see.
>
> Using a separate offset works but would end up requiring another column i=
n the IANA
> registry assuming we have one.  So why the extra complexity and inconsist=
ency
> introduced now?

"another column in IANA" is the last thing to worry about.

