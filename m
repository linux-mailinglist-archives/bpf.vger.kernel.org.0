Return-Path: <bpf+bounces-52556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B7EA449E3
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 19:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66033BE486
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 18:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F5C176FB0;
	Tue, 25 Feb 2025 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4oifWZd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D8B156F3A;
	Tue, 25 Feb 2025 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506797; cv=none; b=YDfASeEtKn/8SCRcpNTtmr8MPdKgU21cNMcF/+Tn2PgA+L/PUTEZitlayVIznqZ/RpD5DAYZGJqmeeNyBhRio1m9XG957mzr2heW2Px0QJ6+vz2PNEl1fwvhwHbJTRPzScWKGX6ily+7EzmZk0oLZyOa+i94rp4bQFe2osdwoM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506797; c=relaxed/simple;
	bh=zchtCEfEGcKd3MAmswqArfI+K6HNuL7Cz7XDtG3NbNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omw6/bzf5Pe6xaULbxanKbDmdZ3z+FCMz5POjx50taJ6op7mYhFE8BllNZf5S7P/VQd5xeGvfSWHC4nA4VR2JEHGZY7XixRyswRp83RJJY+c3+VKB67pmT1Y1eypFxGS5z7xWhUEdvJ2wWHNsLkHx/zgJH5HvXDbiXTHJUJ2T/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4oifWZd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43aac0390e8so15406255e9.2;
        Tue, 25 Feb 2025 10:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740506793; x=1741111593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zchtCEfEGcKd3MAmswqArfI+K6HNuL7Cz7XDtG3NbNA=;
        b=Y4oifWZdg4UIF2bN0BfWa9urTM3jRZzoW1QN6DcLlXirvkiAKj6aDDGEBMjrfKlL+t
         xy+Lz7k6BMECbFed8A9wnsL1S4Oge1kJMqY9YTUET1/NUEiGbl0jAP86uCdoZ8UeUMEg
         HAm2NrCOaPHlheOnwOM9dAw0k7ZW//nadzEYUyUXfzygwjuqi4nlUt4YC4Zz67C4vw2f
         UJq6GrmNEkfmo5SZk5vRuOk5nwdPEEGi/rjNHs4pcJbSgqg5uAXokHPWlCxBrWmJBQBi
         9aLvPPaKm3bNZ7BZTHvzMKFO5MauM8hzUS8+j9BKcwnAiQIDfzbwjTjmghel+fL1t12V
         LuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506793; x=1741111593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zchtCEfEGcKd3MAmswqArfI+K6HNuL7Cz7XDtG3NbNA=;
        b=HP68725Feem9g5QDjwLjxfpAPzaRagT8+URSKDSvV+3axFBae72g8nabqztGn/+Og8
         B4/UDbEEBqOO6SOB/di66VqvgYTJNRc3I/uCVuL6Xse+rVy7Ta57i4Rwh36fnIbXmpSq
         4YXYhZD15pa+8up3ZqbxuBjwwt4bOAdOchrYd9S9OvNlK4VCFkXzuiIB1zQPCTYVdTyY
         oqoq4x4a3rRdLEmC/uBcrJWGGR1ONxHiL4aNkI/IAuP6fL3yAtEBuI45/NNcKGNYv+Qc
         AXT2x1+he3pc5iZIyngfRYOuEeV/K6eYRLg7fxqvuc32f2Eov5sFDALtCo2RBQevo4ah
         hxew==
X-Forwarded-Encrypted: i=1; AJvYcCW4t5davvoATg/D+1oVAeqj/VUP7dnwfXP8f+0AKzxlsmSVeoD80FnfbzBO8GcR7Q7FNis=@vger.kernel.org, AJvYcCWl6QkI3dmc/XohEhTW5Y5IaLdwpSnX1LjQ7cEJY45szxpSMCA25gEqWT2lVCe4er8odv/ya4QdcjbQEbrk@vger.kernel.org, AJvYcCX7PjBgC546bUBAbYlyL7YYWEer8bvrCz4zaSUBaRUqKb7gxkGvA5ZWW991LSBTniRTFi3YrwkLq3TQtZjB3H4rN+Jg@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7KIyi6TnoVNDeu48TmByxQzP/FKAX0Tm1LEuPyYYU5xQiff6
	2HUK5ZhDC0EonB2HQNDHSjnDF4jzhPUi3fhm8AnvBQOM5hyeEFR3jzSdZvOCwTxoEa4PW1YyvD+
	l3NXlYwk/LzCSLIGJpq+j/OS85L+WxMUB
X-Gm-Gg: ASbGncuNiOaYT9OkRy/Bhrv490UDKGvP8MiamexKrP6162v+2xROlF2tJsP4Bi57vb8
	VEcT/QIs9U3hY2xZ6lRwYTbeI5oG8FOEEY30HhJxAiObYKsnauIoqLXyIfvvsQooVTqvgDtU+lP
	jefdjSLAksVdarprttrpV+sXs=
X-Google-Smtp-Source: AGHT+IGlwkwtt8yLazHetKUrxIo1z6pDXtJnI2CGJXL07EgtfUktZVrpKCWsb3EHD1nsxtvSR1Y7t73KP/dUgPFF8CA=
X-Received: by 2002:a05:6000:1fae:b0:38d:cbc2:29f6 with SMTP id
 ffacd0b85a97d-38f6e947434mr14144173f8f.17.1740506793340; Tue, 25 Feb 2025
 10:06:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224140151.667679-1-jolsa@kernel.org> <20250224140151.667679-9-jolsa@kernel.org>
 <CAADnVQJ_-7cB3OaeFWaupcq0fRPh3uP62HBGxq0QbyZsx3aHqA@mail.gmail.com> <Z73HDU5IZ5NV3BtM@krava>
In-Reply-To: <Z73HDU5IZ5NV3BtM@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Feb 2025 10:06:19 -0800
X-Gm-Features: AQ5f1JonQ3bzFeYH2MPwYc-bN0juQN4SqNxsA6Q12e74EuGvHeE7xiA9aTlZ6Xg
Message-ID: <CAADnVQKNeWKFkZxb_-Fuenvmfy47-t6Z7KLY_j3UUOrj5pFP-g@mail.gmail.com>
Subject: Re: [PATCH RFCv2 08/18] uprobes/x86: Add uprobe syscall to speed up uprobe
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 5:35=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> > In later patches I see nop5 is replaced with a call to
> > uprobe_trampoline_entry, but which part saves
> > rdi and other regs?
> > Compiler doesn't automatically spill/fill around USDT's nop/nop5.
> > Selftest is doing:
> > +__naked noinline void uprobe_test(void)
> > so just lucky ?
>
> if you mean registers that would carry usdt arguments, ebpf programs
> access those based on assembler operand string stored in usdt record:

No. I'm talking about all normal registers that trap-style uprobe
preserves, but this nop5->call will scratch.
Instead of void uprobe_test(void)
add some arguments to it, and read them before and after nop5 uprobe.
They must remain the same.

