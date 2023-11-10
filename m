Return-Path: <bpf+bounces-14734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FE97E797B
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 07:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91574B20FE5
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 06:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF221C2E;
	Fri, 10 Nov 2023 06:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EodgsCuU"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A2B15C5
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 06:39:23 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FB27A91
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 22:39:22 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9dd3f4a0f5aso280163666b.1
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 22:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699598360; x=1700203160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPJG19NXSW90R6JTliT22rKxQ/1hfWR1dfyf0pXGroI=;
        b=EodgsCuUWx6DEF/I62banqePzzCX0Z8qHOtNas/VPlaznu+w4x3liZTwvlhlS2pxdU
         +9LyEHly5G7/HxWZ7f4lZXsX6KtHYv2TFDJDa01M1VGz5Pw2p1gClh+fBkhMDBqrLWS5
         iFoldi8ydkqScw+7VECSLGqvyJUhTkTCOWaWW9vnAUeBnHehegfhIIwlBBCsxlhnDYuE
         kJjB2N9goGVcA6vhSRofs9ZbkuWMFkt41myoGTYIzLLqBKM5TiKqcyYbjJL6afrOPyBh
         T/qKU0DGUu9laJD3EXFgYGLLBQfeJ8ZMNsVDQE/wIfPC2TywY8pqct6faeuzK/zIRGXd
         yxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699598360; x=1700203160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPJG19NXSW90R6JTliT22rKxQ/1hfWR1dfyf0pXGroI=;
        b=rGqBWrE6o4u8eSejY4UH2MObCDCmdHD/dlP2RQcfhCFgWsXZnEN0tyrxFfHj3TNTHF
         B1VfAB3IMtVK1psma8CDftOr5QbnSn1lP6jdL4uCOz3LAXXo6fiubhJgJHMei8L8OSc6
         1RDVgvdd4KH9eYHai+LdyQfInSAmGUIGZzLmK5dg3lGxnGpnvm2N3WT79kG8aiXdhqco
         wuuuyCJuDIxwoiy1weNu9Um/WYLKxIXHiCZLLVNFgLIyrYsFlHfqbhgVoXYNP+EmJqPR
         jKenLby1axWCFQtRPe8SBXhk/sQenc46NPxFv9/65P25fyfdia8G5x5fxafrds9mEwFm
         BT1A==
X-Gm-Message-State: AOJu0YxZAF4xgqpDjq97eWIO6ItSK5zy4W57nY6SJpS++KB1d0c3O+sI
	q88zyrqezrKMzZCSklXBU1fNO0QkaqVJEvV88Pq77BiZ
X-Google-Smtp-Source: AGHT+IHCsAjaQ5NBaZl9W3qZajQDSQUMGgFnacb9AxZWfsH5ke5M/Jneuprefo1pGVJGCvDtdyzxVtBZnz5LhMaYWTE=
X-Received: by 2002:a17:906:c152:b0:9de:993b:d897 with SMTP id
 dp18-20020a170906c15200b009de993bd897mr6223558ejc.61.1699591715267; Thu, 09
 Nov 2023 20:48:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110002638.4168352-1-andrii@kernel.org> <20231110002638.4168352-4-andrii@kernel.org>
 <CAADnVQ+KtueBdD=8DazMhM3Xz0+YpLVW1-5-N4ZFiBOzji4vbg@mail.gmail.com>
 <CAEf4Bza1nxvLcBORkV+bKbKCz=f1jhRYM=PPaJxXDfQ7rmfJvA@mail.gmail.com>
 <CAEf4BzZFc6t5KCdCH4zYA1jp9UgRWHsEKgfMjVcc72qgH-FHXQ@mail.gmail.com> <CAADnVQ+GzfdYSYAK5MYJ4cbOXsFPKG_Ly5CO5raCP7sopj9AXA@mail.gmail.com>
In-Reply-To: <CAADnVQ+GzfdYSYAK5MYJ4cbOXsFPKG_Ly5CO5raCP7sopj9AXA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 20:48:24 -0800
Message-ID: <CAEf4BzZT_Sgpgtm2yrUCUoCLAdJey_rofJi7jOq0603N2ELRcg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 3/3] selftests/bpf: add edge case backtracking
 logic test
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 8:14=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 9, 2023 at 8:05=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > >
> > > When I was analysing and crafting the test I for some reason assumed =
I
> > > need to have a jump inside the state that won't trigger state
> > > checkpoint. But I think that's not necessary, just doing conditional
> > > jump and jumping back an instruction or two should do. With that yes,
> > > TEST_STATE_FREQ should be a better way to do this.
> >
> > Ah, ok, TEST_STATE_FREQ won't work. It triggers state checkpointing
> > both at conditional jump instruction and on its target, because target
> > is prune point.
> >
> > So I think this test has to be the way it is.
>
> I see.
> I was about to apply it, but then noticed:
> numamove_bpf-numamove_bpf.o |migrate_misplaced_page |success ->
> failure (!!)|-100.00 %
>
> veristat is not known for sporadic failures.
> Is this a real issue?

No idea what this is, I don't have it in my local object files, will
need to regenerate them and check.

