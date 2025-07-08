Return-Path: <bpf+bounces-62576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECA4AFBF23
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D64D3AE570
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 00:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D9C22615;
	Tue,  8 Jul 2025 00:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gy/XEwaV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D14A1401B
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 00:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751933579; cv=none; b=dZ7xnhbeI3EN0jeAaXL8bXhpfBhpZn04aRdsCHBIjp88D0BHJuyRCbCjq0tAtOQsNcE1rJo6bw4PmOr2m85/3UpFOYQwWAYV/ThqVX+8sfbVNDTSbI9Zlod5t9adi003X8rlNnaXzqRB7nnJiLZ6vxOjYSZ/IiGRVXdekceMQPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751933579; c=relaxed/simple;
	bh=vxadECEYu0ux2kyObmGNTDDMNqqGgO42IpNa6aZWPwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVB7mCL/B8q//DthDP14P55jJNrp1S1pBs+97a+ZWkWfxC3Yt7SnHFL4go2X2LWiqAFvQ3Adg2f9U6+4Gq/IpZ08hA9UuzF12TlE6hroRDNB3JPzTaY2RO0OfOq217iafcPHMMRfhf+FsAcOvkUHO8NpL+k2AagW8zw54GpToeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gy/XEwaV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso3326435f8f.1
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 17:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751933576; x=1752538376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAKxcaOMKj1TROIzaPqNh1IRiohJgwvw0JfXNYJGffs=;
        b=Gy/XEwaVKePhAanIMJiba9L1RapulhfEpYJZ21dfEhCB2+Yj9mDvKGecL29L5b6PYo
         RKTX2GGv4lrQniZ7O/9Pw2lYRXO5drjMRG7dbhnglJBYqZT1Ljc4jgLPfFoV3gWeuekK
         qPhc4RXgvyKGC1oIahuuMXC/4SvNDroJ6TL4eWkz3R5rX0WmKNwT242YkJj2RwsOdtF0
         upXyvy43TSij5fh10aG8s2AbYcVzRsMeV0Um/jU7ra/jyjs+WRUM0bW1Kp2nR34EZp6G
         eQEUsSueBQ2sf5F/XGBrOvIBj06AlL8SAkjUPRs/8uFOhFB7H2dslNLno2XldVS9aetW
         69Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751933576; x=1752538376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAKxcaOMKj1TROIzaPqNh1IRiohJgwvw0JfXNYJGffs=;
        b=DADPyBLk/oyWkTX5OMe6RrBru/klvkfsjw5qZyAnLy+MpFwTlEXXUGzzwXddu1DWx3
         se9ZNhLGyCrm0JISXcfb1Nhcqml6gPrRA26nHMgPIiClklGn/ndomMdxBsE51khZPSAu
         ktRz/H7fRW7DpRQkSCsG/UYmdGUyni/s7exdOiAxph0a8IBiRC3G24suT6xdJhvKMSrI
         YBcn8tZRals/OzJazDbQbMh/PzE0NPDpvybZx8ptz2Q0vqU3fIA6kaQRP5Ie+YSgDYIi
         73Lt6ospmyaffF/YCKQteDPMTi/ycT5E10yB1YGBPwlcXpfLk4mp7spsvB+NBDr37hlK
         cvFw==
X-Forwarded-Encrypted: i=1; AJvYcCVDGQLIyJa7Tpziph+lrH0+tv8RGqG1QNn7BF9NYVqpl+FYoK8BDlpEiIdts2QRWv0poIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytSbBah94LRN6PXSrgUIzcwyZSKMGsJacO4XTxg2sKKzAcef/l
	3Zsl6nl5RCgYrFGAcoYzZ0lGMyT5X5q0mrXAbNekwEgl7WaC1NBku0oo3BTT3M7T3q/KVATTOQs
	Mho3pV+S5f1KOOoAjYbWQKf1bIp2MFUI=
X-Gm-Gg: ASbGncv7O2KcBqm74XgE/xO9GN7ziby8ELTIRzOmyLBGQWEoMQsTqHhZX9NR3Ln4EA9
	HTgPfYfcFGwJTY4l9KiKuBeG3j+t3xmbzyy6SpM2j1ivTbXA8rWwwn/Tjv2X75+zT9qfwbMX60t
	I7yCdpvLznMIgBoH3vgbBzFRwRZ/XRs/MJ6abVipWppiDDSl8davX/YD5JtLHzynMcKoJJ2EFU
X-Google-Smtp-Source: AGHT+IFYQF8Hp/q18yBRNH7toZuGAqT/BN7wJNMVYqFK/IEMiqTjlT9qb5kQkxQo9y5pj8ukzXvZhRNhYHRGOM3t34o=
X-Received: by 2002:a05:6000:2281:b0:3b4:4876:9088 with SMTP id
 ffacd0b85a97d-3b49702e7e1mr11061962f8f.46.1751933576154; Mon, 07 Jul 2025
 17:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-9-a.s.protopopov@gmail.com> <CAADnVQKhVyh4WqjUgxYLZwn5VMY6hSMWyLoQPxt4TJG1812DcA@mail.gmail.com>
 <aFLWaNSsV7M2gV98@mail.gmail.com> <e726d778a3cf75e3ceec54f5f43b9d5d66ba5e97.camel@gmail.com>
 <CAADnVQLaBuDYBoQvVtug63MJO+2=oqb9PYap8Jv+U8HB4ETe9Q@mail.gmail.com> <88c63c574dfd7d3845ac4e558643ab52e77f81dc.camel@gmail.com>
In-Reply-To: <88c63c574dfd7d3845ac4e558643ab52e77f81dc.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 7 Jul 2025 17:12:44 -0700
X-Gm-Features: Ac12FXwPZPPhO4tjW0dYKUfe4p-iL2CNWrZGE1VszYUif1vzG17CZ7p2QJKp6Vk
Message-ID: <CAADnVQLp=ED2XAVhgO5jgSt6Cptkw6-H19Qr+s63m+jjCDwXRg@mail.gmail.com>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Anton Protopopov <aspsk@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 5:01=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2025-07-07 at 16:49 -0700, Alexei Starovoitov wrote:
> > On Mon, Jul 7, 2025 at 4:45=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Wed, 2025-06-18 at 15:08 +0000, Anton Protopopov wrote:
> > > > On 25/06/17 08:22PM, Alexei Starovoitov wrote:
> > > > > On Sun, Jun 15, 2025 at 1:55=E2=80=AFAM Anton Protopopov
> > > > > <a.s.protopopov@gmail.com> wrote:
> > > > > >
> > > > > > The final line generates an indirect jump. The
> > > > > > format of the indirect jump instruction supported by BPF is
> > > > > >
> > > > > >     BPF_JMP|BPF_X|BPF_JA, SRC=3D0, DST=3DRx, off=3D0, imm=3Dfd(=
M)
> > > > > >
> > > > > > and, obviously, the map M must be the same map which was used t=
o
> > > > > > init the register rX. This patch implements this in the followi=
ng,
> > > > > > hacky, but so far suitable for all existing use-cases, way. On
> > > > > > encountering a `gotox` instruction libbpf tracks back to the
> > > > > > previous direct load from map and stores this map file descript=
or
> > > > > > in the gotox instruction.
> > > > >
> > > > > ...
>
> [...]
>
> > > > >
> > > > > This is obviously broken and cannot be made smarter in libbpf.
> > > > > It won't be doing data flow analysis.
> > > > >
> > > > > The only option I see is to teach llvm to tag jmp_table in gotox.
> > > > > Probably the simplest way is to add the same relo to gotox insn
> > > > > as for ld_imm64. Then libbpf has a direct way to assign
> > > > > the same map_fd into both ld_imm64 and gotox.
> > > >
> > > > This would be nice.
> > >
> > > I did not implement this is a change for jt section + jt symbols.
> > > It can be added, but thinking about it again, are you sure it is
> > > necessary to have map fd in the gotox?
> > >
> > > Verifier should be smart enough already to track what map the rX in
> > > the `gotox rX` is a derivative of. It can make use of
> > > bpf_insn_aux_data->map_index to enforce that only one map is used wit=
h
> > > a particular gotox instruction.
> >
> > How would it associate gotox with map (set of IPs) at check_cfg() stage=
?
> > llvm needs to help.
>
> check_cfg(), right, thank you.
> But still, this feels like an artificial limitation.
> Just because we have a check_cfg() pass as a separate thing we need
> this hint.

and insn_successors().
All of them have to work before the main verifier analysis.

