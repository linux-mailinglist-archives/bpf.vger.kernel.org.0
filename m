Return-Path: <bpf+bounces-34651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C81F192FC6D
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 16:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8921F227B4
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 14:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950B4171663;
	Fri, 12 Jul 2024 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3Zk1dhA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9585316EB6E
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794253; cv=none; b=gUehnfC89J1aVHkhP5vFKQyq7n3Y9sQPoaSOIge68fZRjllAWbZdA9L3BhPvy7kprZiEpBPp8kkwz1y3n3cUhR+H1nWrTTw1HklcF0m+FizZOqlczJuYiAdpLBZ5LvUVKJGuEoMJg5P8DUykcRvVr3PckA5sQJS7TV824DbuIPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794253; c=relaxed/simple;
	bh=BOH7U0iRAglhyvlay65Hj/JyRrJKhvdqir3LLKUspvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsQXUpyVfoPlJKoeDxr2rceavcfVIDDNi535yFh07JXxQBp73Y8pWayt7pfzGFRDE7eWg8Nmbbpv/OfRr93dAO76pvtKkKE+MQZ6FsIUMdVdOJWDto3LHs0lyNTyAsanYfwf4kg4sGJBLVoAExUdThIeP3y/nx6nDjc/ug1nZeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3Zk1dhA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4267300145eso16432105e9.3
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 07:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720794250; x=1721399050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SZil+ATHlaGE5zCvvje24kGJN4m7ILYadv3dONuB/E=;
        b=l3Zk1dhAjaFOtJpe3+4+PlsKynsq7QfNsdx8UaHjntWltyXVFQF1yDPKyhkzl67mW9
         VDFt7ttmKWh7JnmuKB3+tlfat8CCB5N04oxTdo7jioh+r0O5Z5w2VXNe2+YPYB7/QloE
         5KhO3XfcNxAjOheakQBilJ7x08ygJtUoPFNe8MqijsMw68ot8Jt6K6bjneJFmpOb4P6d
         uozS68Cd5D7RU6eD8CAvkeOUyx/zJhGOqpCCZ+XP4S8AACZ3vLLn/jw8M9KxODNAKDKo
         ZXd+ujF/ZA821U1WH8yB4ugwtray33Sj0luErTXSVu0uIMOpv3PDqUJH+a3yETENiqRQ
         TQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720794250; x=1721399050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SZil+ATHlaGE5zCvvje24kGJN4m7ILYadv3dONuB/E=;
        b=tdyevRKU7mvhaxqmG3GJzsQGS//jlqUPDMRwmk2vPadOTg8hTFrMuzd7zf1i3J1IW8
         yIpGns2QuPeK9JJreBpTxP1ynODs2qtlDODBvyQuXnnrMFowS2AxtujT++wS5qZt1Wu7
         uWS1qxXfPiodXCK+FnBIhlMFlaw1w7gpkZejQD3WUAku5Gmane4yFujcixS0N1w11NLA
         k/xFaRiL3qUH937E2l8kZtGk+CMAGgltZetgBdG3TaFO70mDh5ywb6AssfFN2kKhyWS/
         BjkDeERT+k2nKzlLo4UzRkFRdpI+giLSte2raRSpJNLrYVwNWMzv3N7ZTJBYSDMKf50i
         jJDA==
X-Gm-Message-State: AOJu0Yz08vuMvVOEgaO1Cb8kyUMqIcZoOQ3fw3pigEmawbXC0nk5nYKH
	6QD+ROW6vecOVyo0SZSI0nXVHvnTMv0uCOu9bn3wcd8iyNcufaFZtxAOwNo8IbiQRJ6r6jUE1jO
	wYeSnOwMLpxw/B+r0DeF5URFeEbg=
X-Google-Smtp-Source: AGHT+IF8pRQ6daSIu9vg87t/bgjqwm19660v8zTod6j/8LnasL10fap77zss5S0+b06IJw6q2IdVpV+EgDxURpN8C4g=
X-Received: by 2002:a05:600c:2d48:b0:426:55a3:71b5 with SMTP id
 5b1f17b1804b1-426707ce9c0mr87695425e9.9.1720794249512; Fri, 12 Jul 2024
 07:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619011859.79334-1-alexei.starovoitov@gmail.com> <myyr3qp5h4bnzd3j4qypqxhjixebmwxmw3dknud3rbkohpmewl@ncmply4puxgk>
In-Reply-To: <myyr3qp5h4bnzd3j4qypqxhjixebmwxmw3dknud3rbkohpmewl@ncmply4puxgk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Jul 2024 07:23:57 -0700
Message-ID: <CAADnVQLSuhupzTgNDTT_rOR9wv7BV_HE=8ScN37DOmnwfLDB8Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 1/2] bpf: Fix the corner case with may_goto and
 jump to the 1st insn.
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Zac Ecob <zacecob@protonmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 11:41=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.co=
m> wrote:
>
> On Tue, Jun 18, 2024 at 06:18:58PM GMT, Alexei Starovoitov wrote:
> ...
> > +static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delt=
a)
> > +{
> > +     struct bpf_insn *insn =3D prog->insnsi;
> > +     u32 insn_cnt =3D prog->len, i;
> > +
> > +     for (i =3D 0; i < insn_cnt; i++, insn++) {
> > +             u8 code =3D insn->code;
> > +
> > +             if ((BPF_CLASS(code) !=3D BPF_JMP && BPF_CLASS(code) !=3D=
 BPF_JMP32) ||
> > +                 BPF_OP(code) =3D=3D BPF_CALL || BPF_OP(code) =3D=3D B=
PF_EXIT)
> > +                     continue;
> > +
> > +             if (insn->code =3D=3D (BPF_JMP32 | BPF_JA)) {
> > +                     if (i + 1 + insn->imm !=3D tgt_idx)
> > +                             continue;
> > +                     if (signed_add32_overflows(insn->imm, delta))
> > +                             return -ERANGE;
> > +                     insn->imm +=3D delta;
> > +             } else {
> > +                     if (i + 1 + insn->off !=3D tgt_idx)
> > +                             continue;
> > +                     if (signed_add16_overflows(insn->imm, delta))
>
> Looks like this be signed_add16_overflows(insn->**off**, delta) instead?
>
> I'll proceed assuming so, and include a fix for this in v3 of the
> overflow-checker refactoring patch-set.

Ohh. Good catch. Thanks!

