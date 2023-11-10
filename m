Return-Path: <bpf+bounces-14793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79A47E824B
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 20:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81218280E25
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 19:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9DD3AC2B;
	Fri, 10 Nov 2023 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b43QXTL/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4233AC24
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 19:13:44 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7102B250A2
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 11:13:41 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso4909561a12.0
        for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 11:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699643620; x=1700248420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idfDv+IdWGVF7JnORF0ccmMspcxFzMig8ERikg65fgg=;
        b=b43QXTL/Zo8G3fKShDLe8W2Pc+NOvh8STcPMXS8mluLCDzPoYIIwBzkenMMpLixXYd
         4bNM1ZA3o8/JiDYIKnuxvCE5SnrAzsTCH0M4m9VGHkCrGXT+xkw+8hk1h69P4HheEHwA
         pQuRa0LKtE8SbYIt/HMhXezEsuVMBJNFk1ZnqlVMOzZVx5eN+JBqwkUn5O3Z+ji2MkWs
         wJ38vjo8XEvDfLdPMbXuQ/c1bYax1nVPZptUiJ6ExcWbvvgPlOR6zU6JSAKX9BMOiHmD
         XAMJYLf7A3fwSgcKM7gENxH0FDZg91TKRRwt7jlq8Sz5riXLlN/ig5vdp+nciQ9D/EhB
         U6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699643620; x=1700248420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idfDv+IdWGVF7JnORF0ccmMspcxFzMig8ERikg65fgg=;
        b=WHLPiKNaSFqwtsVrlhnd/wlqCUSafZ9o23sEL6GVarMna3QXkbT9SQou1iQTbn1OVF
         /gLz4WCT7o8y0+xTRhJJ+eGbVnDq1ZuMFwLSOz1WcBMGzGff44WIxep8inRshw6uHf2s
         cP/ptuXqKxA3PADTrYfk+pRasFjowVFwMZGwI4SmO9Dl+PGJ6yegzG/r5oVQzFCD/w25
         X+oMcV2ihYeIuiumXCV99QDlNWWC2j/cwShb496X+6wqc9dWT+oRHqSHEIz03gnfwFnp
         RGiR08r4p7pHXpb8W+GhRijQAuRCpb8ZyoXwF/EInSSn7boHs8XvY+RVDELccn1931+J
         BWGw==
X-Gm-Message-State: AOJu0YwmcIhv2Z/Iy3gwem8yddXURax+jdgGkhN0tbobiTnScNNp+lFi
	ql2qFCoYb/CPVgnLTdJh09qRyuiCNSerc9a5+4FGcMj1GGM=
X-Google-Smtp-Source: AGHT+IGXkjenPGqSJkTFFSu6U4h3wnUzADutlpF2Q+qbyXuoBzkF+AUZkLBGovT+VR2vmlt1FGmkNc6D6G5Du5Sba08=
X-Received: by 2002:a05:6402:3547:b0:540:16be:6562 with SMTP id
 f7-20020a056402354700b0054016be6562mr3033505edd.15.1699643619679; Fri, 10 Nov
 2023 11:13:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110161057.1943534-1-andrii@kernel.org> <ZU57YmTj7GDY3ogk@google.com>
In-Reply-To: <ZU57YmTj7GDY3ogk@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Nov 2023 11:13:28 -0800
Message-ID: <CAEf4BzaZAC5KOMiCwH8wxyppWqxTwWp+zA-gUEN9hxT_k=JhBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/8] BPF verifier log improvements
To: Stanislav Fomichev <sdf@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 10:50=E2=80=AFAM Stanislav Fomichev <sdf@google.com=
> wrote:
>
> On 11/10, Andrii Nakryiko wrote:
> > This patch set moves a big chunk of verifier log related code from giga=
ntic
> > verifier.c file into more focused kernel/bpf/log.c. This is not essenti=
al to
> > the rest of functionality in this patch set, so I can undo it, but it f=
elt
> > like it's good to start chipping away from 20K+ verifier.c whenever we =
can.
> >
> > The main purpose of the patch set, though, is in improving verifier log
> > further.
> >
> > Patches #3-#4 start printing out register state even if that register i=
s
> > spilled into stack slot. Previously we'd get only spilled register type=
, but
> > no additional information, like SCALAR_VALUE's ranges. Super limiting d=
uring
> > debugging. For cases of register spills smaller than 8 bytes, we also p=
rint
> > out STACK_MISC/STACK_ZERO/STACK_INVALID markers. This, among other thin=
gs,
> > will make it easier to write tests for these mixed spill/misc cases.
> >
> > Patch #5 prints map name for PTR_TO_MAP_VALUE/PTR_TO_MAP_KEY/CONST_PTR_=
TO_MAP
> > registers. In big production BPF programs, it's important to map assemb=
ly to
> > actual map, and it's often non-trivial. Having map name helps.
>
> [..]
>
> > Patch #6 just removes visual noise in form of ubiquitous imm=3D0 and of=
f=3D0. They
> > are default values, omit them.
>
> If you end up with another respin for some reason:
> s/verifierl/verifier/
> s/furthre/futher/
>
> (in the commit description)

thanks, fixed it up locally, but will wait for the other feedback

>
> > Patch #7 is probably the most controversial, but it reworks how verifie=
r log
> > prints numbers. For small valued integers we use decimals, but for larg=
e ones
> > we switch to hexadecimal. From personal experience this is a much more =
useful
> > convention. We can tune what consitutes "small value", for now it's 16-=
bit
> > range.
>
> Not sure why not always print in hex, but no strong preference here.

for small values decimal is usually much more sane. E.g., if you have
some index into `int arr[100];`, seeing that register's range is [0,
396] is much more convenient than [0x0, 0x18c], IMO. So I don't think
we want to abandon decimals completely.

>
> > Patch #8 prints frame number for PTR_TO_CTX registers, if that frame is
> > different from the "current" one. This removes ambiguity and confusion,
> > especially in complicated cases with multiple subprogs passing around
> > pointers.
> >
> > Andrii Nakryiko (8):
> >   bpf: move verbose_linfo() into kernel/bpf/log.c
> >   bpf: move verifier state printing code to kernel/bpf/log.c
> >   bpf: extract register state printing
> >   bpf: print spilled register state in stack slot
> >   bpf: emit map name in register state if applicable and available
> >   bpf: omit default off=3D0 and imm=3D0 in register state log
> >   bpf: smarter verifier log number printing logic
> >   bpf: emit frameno for PTR_TO_STACK regs if it differs from current on=
e
>
> Acked-by: Stanislav Fomichev <sdf@google.com>

thanks!

