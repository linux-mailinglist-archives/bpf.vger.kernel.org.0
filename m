Return-Path: <bpf+bounces-65080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4701DB1B8C6
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 18:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09DC18A6E94
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 16:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D49292B3F;
	Tue,  5 Aug 2025 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiMBIApO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0958229CE6;
	Tue,  5 Aug 2025 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754412511; cv=none; b=DOvAlj20v8P97vJuOViMe0viuIqKMaBJFJ0DR2x/MYFBdILLzSZtWEGU8nGGL+T6zU5Yspi7lkF5Ic/Q9kQdO8lechChbiG8T3hs3PZee/g2onPq3xNX/IT+dXHcK2KbbtPP/SN7iCyPSVaRq+3IF9M7HzWfsnlUmmO6GT9XoJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754412511; c=relaxed/simple;
	bh=tD9/IW1P/chUuwwlC3pab5UNLAW+3M+OCj7jJmu2fZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3Bxw6axdpweypb4XTNQyES4kzbqdG/EQat5N8Dgm8EhmjW5aVFR+uk27QKIjZPOGdYsFgnAwr3KgQ/6R1PH4va8ln1SHYBVApXA4Eob41+rlSUXjCBV5a4FgobB0ehhNxf24vc8V/kUaCCrxrOX18EmKyrCHivtA0SknUeBin4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiMBIApO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b7961cf660so4623257f8f.1;
        Tue, 05 Aug 2025 09:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754412508; x=1755017308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TitTOVSCQjcaMIR+Ftv9d95GFhmE5w5mLVKjBAMlGV0=;
        b=GiMBIApOayH4CVojQdO6m6YhAW68HYs2q3xtrDThUJRMjbX9VpPp8FSoFX9b91R/UT
         T4oyOGlB9or80A1YqO6X0C1j4srTvVNMZJ28EX/yxw5K2qHQg0jUh8l7s1rsNdgN5f1O
         9kqrjIYJIlmvBn286yy0aZCJ3DMGzcWY7C0uOkcmdX7XOAVT3Gys2RuUydoqvipDEEB7
         G+hzlMMYWZ75Gwa7plvq4Yr96N2+1Uj1ONQ5gbNulQzvyT+AXR5ri+yRC5xLd4Z5zOY0
         TcpTVj/DsOsXxTyzBCW3jpr0cMbPE7yfSTM2nB+JLe1GVN5WYPlfvNSm9yTajoZenhGP
         xnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754412508; x=1755017308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TitTOVSCQjcaMIR+Ftv9d95GFhmE5w5mLVKjBAMlGV0=;
        b=boR82rfYNMImxVh/PDKRfTKioanwbpvvsYBe9mxTT0LMVBQTkH3n1js+Xp+yddre83
         H1BO0A5sNQuwI9OfAOrMr2ANaQulbnY1aqQGCZ3HFjuZk2Gnn57dsqbNdXwLly6xMnUM
         /oK0Y3c4jMSbhqcaqfHwWHslGwrZ75vRWfyBZ/RdwNrx2Qp4g/Qfq/WcFif54+oIeHMV
         5HD3pJvBG3EPoe0Do06TfmPYLzjhF3rePZ44gZygZd0oKmKB18Ws8c6dclodFL8vzh88
         yZjAHdJgxsUiJ4DFearO+wfku3ORFLY5bzLhLXN0jIZmv0CadPJ6CkHLbg+J7Sa/5GJ3
         Jx/A==
X-Forwarded-Encrypted: i=1; AJvYcCURxmFNNEHQMciHCjiftP1lKnvW9rxC/ks0U4JEv2JlRkE8sTmvMOKJcIDoQ9L3Vjt2Mpk=@vger.kernel.org, AJvYcCVqexXaDqWtoOK2pmGMgsDaARPb8LyFrWhDVfIBLe9ZLEBdvczjvt0n0Sl3MfOrZWTpfiDVlrg0dujgCZCy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+QpJwEPoAzbujPZqFv7h5ibnqq9CVmF9qEYCVFomdR19pz7Xm
	Mx6c96Z27MqDp4J3VE66JAlYS6O2XGshyyUgPc2CCQE2kypK58S3XfqxvUQZ4vMVyKG1upLD7lX
	pz7SiCz7Iv0iozAh5r1abebnBrNpDe18=
X-Gm-Gg: ASbGncuj8NXAilIVp5lidQ6gtFVo48OpRH987DCIASp8z8j47rZUJEd0/vGZ7r9BtKj
	x6wBFyvmsOYzuqYo1DhPafnHuTkwoA5zU2BEtWH3qgsf3cZ7LWRrYuC2fRIaZid+zSMVRzUcojO
	MDxbW5GkxJLdEW96CARAmA9gaOxvzKi/blrKJIe6gljmk+MzETcagl5R7jF5ROykWjuNXPnj3a6
	Iov0EggbBWH0M/tABHE6MU=
X-Google-Smtp-Source: AGHT+IFDDxMZGzh29A7XgQGmMQCOXO/gLBv1LnUWI1BPa74b357i7JTkNrCVGMeZyz3BIY3D0TD4oZ+GRLY0T65yW9o=
X-Received: by 2002:a05:6000:2383:b0:3b7:810f:6caf with SMTP id
 ffacd0b85a97d-3b8d94bc74bmr10182227f8f.32.1754412508273; Tue, 05 Aug 2025
 09:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710115920.47740-1-iii@linux.ibm.com> <8a20f7ba33426bb6ced600f97f5f67e9d67ea503.camel@linux.ibm.com>
In-Reply-To: <8a20f7ba33426bb6ced600f97f5f67e9d67ea503.camel@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Aug 2025 09:48:15 -0700
X-Gm-Features: Ac12FXzJrVOCtxx-b__JkZg5NmhIN5qVqKUjvDCPeuoZQ6XLyX-pme0z1RlfqBw
Message-ID: <CAADnVQ+MYKvqRNSHFkMPxENNaZfrvEN8npY2JfiO_izxk1gUFw@mail.gmail.com>
Subject: Re: [PATCH 0/2] scripts/gdb/symbols: make BPF debug info available to GDB
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Kieran Bingham <kbingham@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 6:23=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com>=
 wrote:
>
> On Thu, 2025-07-10 at 13:53 +0200, Ilya Leoshkevich wrote:
> > Hi,
> >
> > This series greatly simplifies debugging BPF progs when using QEMU
> > gdbstub by providing symbol names, sizes, and line numbers to GDB.
> >
> > Patch 1 adds radix tree iteration, which is necessary for parsing
> > prog_idr. Patch 2 is the actual implementation; its description
> > contains some details on how to use this.
> >
> > Best regards,
> > Ilya
> >
> > Ilya Leoshkevich (2):
> >   scripts/gdb/radix-tree: add lx-radix-tree-command
> >   scripts/gdb/symbols: make BPF debug info available to GDB
> >
> >  scripts/gdb/linux/bpf.py          | 253
> > ++++++++++++++++++++++++++++++
> >  scripts/gdb/linux/constants.py.in |   3 +
> >  scripts/gdb/linux/radixtree.py    | 139 +++++++++++++++-
> >  scripts/gdb/linux/symbols.py      |  77 ++++++++-
> >  4 files changed, 462 insertions(+), 10 deletions(-)
> >  create mode 100644 scripts/gdb/linux/bpf.py
>
> Gentle ping. Any opinions on whether this is valuable? Personally I've
> been using this for quite some time, and having source level debugging
> for BPF progs (even if variables can't be inspected) feels really nice.

Looks very useful to me.
Not sure which git tree it should be routed to.

