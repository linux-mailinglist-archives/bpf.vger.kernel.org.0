Return-Path: <bpf+bounces-14940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2547E9161
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 16:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 838CEB20975
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DD714286;
	Sun, 12 Nov 2023 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lE3yf2SW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B7D14AA2
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 15:15:23 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D080B30F7;
	Sun, 12 Nov 2023 07:15:21 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53e70b0a218so5583812a12.2;
        Sun, 12 Nov 2023 07:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699802120; x=1700406920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWkWGOolKVqLhuHATbl4rWq/d1njCCLIAQIEOqDgmtE=;
        b=lE3yf2SWstVWrrCPxuhZ2lsJEgSKWpAHgj9ZdtkESBCdQekc0JwIrSM/9R06dPc0RY
         mwgRjdSCUVXwEuSTRd1UItBnPRstGZyLqRdvgej3r7+s4fAebXEUj9h2OhdOKp14DPzl
         on44FfFgZY3z/qN8jikj5nAdPDXEcsfQZUQU9driudNUzuAxYe4kYOHjxCFrlRQwO0B+
         U61MxwvTHKpY7HyTPTdRoSrlNcdAJWbfUv97ZkV8L8QI7uZF5dZt8RIwijk0fs7ENlvE
         FQm0ohYMMU7carVLJw8aZDPu5Do64gtcli4mpTgAT1iXvdv7HmZOxEBHETAngDrp4ZmJ
         ZuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699802120; x=1700406920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWkWGOolKVqLhuHATbl4rWq/d1njCCLIAQIEOqDgmtE=;
        b=GoUbb4TTGJL4vQhHTvjfBI/9uHGJGwJ9qBkOV6Irk3eETGfnEzhZ+tZUpnum6gxnHW
         6XF8mVaqiHKpDTNw5Yh8aHIg87qhWhSmShL3MlSXnQbE2IfitT5n0/vdfKeXDmOHUBa8
         DrrlkJWmrjPk1ZnH3Blr33GX0WSx6wBm+U4rFlT23r49xdZqIuHlcEIBOaJ9jSLLfm2I
         FjqkdknYlthiaz8qKD0KIc0I7cFVWzQZefwVnf5Hcpia0ZaV9jHS2Gvz6X4mb6D70HOd
         BdxNWjetkrqE2SJk5SM4wgfH3kdacV45kX41N3BcoPwlaQPLDy87C0/K4qYOCtEN6Fj1
         UYnQ==
X-Gm-Message-State: AOJu0YzT9sbNKqcYdgJ62uFc7KeDCtKWx4Ftiq46n9NbIzpzkWSOYefo
	RQERy19tpDrEMBIIGUkuuwcyfgFxIYta2mnUh58=
X-Google-Smtp-Source: AGHT+IHhcQeZS4l0FxVUjzLdh/PvSOf9/l30fg+7Wb3JlcfIf/QP6qN0xgz8NAEBPl3e+fd9MzqNOR/UxXMO7eKmF7U=
X-Received: by 2002:aa7:c691:0:b0:543:6588:555e with SMTP id
 n17-20020aa7c691000000b005436588555emr2935394edq.9.1699802120036; Sun, 12 Nov
 2023 07:15:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsbUytfJS1ns0pp=o=Lk5qbQ5weD4_f8bPFrW5oV0tCXZw@mail.gmail.com>
In-Reply-To: <CACkBjsbUytfJS1ns0pp=o=Lk5qbQ5weD4_f8bPFrW5oV0tCXZw@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Sun, 12 Nov 2023 10:15:08 -0500
Message-ID: <CABWLsev9g8UP_c3a=1qbuZUi20tGoUXoU07FPf-5FLvhOKOY+Q@mail.gmail.com>
Subject: Re: bpf: incorrect stack_depth after var off stack access causes OOB
To: Hao Sun <sunhao.th@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the report, Hao. I'll reacquaint myself with this code and
investigate tomorrow.


On Sun, Nov 12, 2023 at 8:57=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wrote=
:
>
> Hi,
>
> The verifier allows stack access with var off, but the stack depth is
> only updated
> with `fix` off. For the following program, the verifier incorrectly
> marks stack_depth
> as 221, yet the smin of r8 is -12 and is overlooked, and thus the interpr=
eter
> incorrectly calls `__bpf_prog_run224`, leading to the OOB:
>
> (bf) r6 =3D r10                      ; R6_w=3Dfp0 R10=3Dfp0
> (bc) w8 =3D w6                       ; R6_w=3Dfp0
> R8_w=3Dscalar(smin=3D0,smax=3Dumax=3D429496729)
> (47) r8 |=3D -12                     ;
> R8_w=3Dscalar(smin=3Dsmin32=3D-12,smax=3Dsmax32=3D-1,umin)
> (0f) r8 +=3D r10
> (72) *(u8 *)(r8 -221) =3D -19       ;
> R8_w=3Dfp(off=3D0,smin=3Dsmin32=3D-12,smax=3Dsmax32=3D-1,..
> (95) exit
>
> verification time 231 usec
> stack depth 221
> processed 12 insns (limit 1000000) max_states_per_insn 0 total_states
> 0 peak_states 0 m0
>
> This C program can cause a stack OOB access:
> C Repro: https://pastebin.com/raw/5ReUbCar
> OOB: https://pastebin.com/raw/DzVz3NDn
>
> Andrei, you added support for stack access with var off in
> `01f810ace9ed3`, in which only
> `allocated_stack` is updated, should we also update stack depth?
>
> Best
> Hao Sun

