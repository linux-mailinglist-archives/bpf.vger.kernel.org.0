Return-Path: <bpf+bounces-67893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565A8B502E1
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84D21C654D8
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 16:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2564F35334B;
	Tue,  9 Sep 2025 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0+xqNGy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B2F2FD1D8;
	Tue,  9 Sep 2025 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436103; cv=none; b=ke21wWaE5gvJyuE9WjHL8l19pm8potJVOadWps4KXXrVEdpXPnyYV3fCK9z7bRMmG61+pS/tRMK98iVT6M5vrNJqC87woffInF43zw1lfTbQQV2xehqxD3cR/e7o0cKLkIVeqkfsxvm+mk3m1F0OF323nT2TSdcyg50AEV8lV3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436103; c=relaxed/simple;
	bh=sE+54cTetqTW8l2sgbIbuSfULf9SMJk/2p38cYnLlII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZbYTNlkt44+lsr+Egt8lYQ0jwI28A1BIvevNgPKhRfTaAUc2FrGu8rw/0c7ECKVIcjTFA4uvLD9z6vhPHkLxk1E3qri2Wgf1Lnd7N0N4st3hn2IyKocYVjRCx297+azcrncQ40FP8YWe9yQyG5729RsHJVhlRVN3xRzC1copsQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0+xqNGy; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-329b760080fso5734745a91.1;
        Tue, 09 Sep 2025 09:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757436101; x=1758040901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kk4Wab53KOqVHzBBwTop8biFtl8+//r37MLHjmIT+pE=;
        b=T0+xqNGyQKp3vPTnHCbSjeXzZaAqowvkkX1siVmeUkcigI9cCDlV3dDni4hT9k/OPR
         BRTNMyeIRynQHric5+hEXld7vkRVqR03iUT15k+6RpCqxt8MDKmNhJp4o2l+s5RogbqL
         16N7DTnnE4i4KBj+VaQWmXwEunQvsExiOMbJnPFUU2GpsDSowJWow3AZ85hqeiQpbP2s
         2rVNDNykj22Wn8XVWJqegquQ1k2lVCRTJdRLzvrs2hBpVw2thlF+J4GzuqgrRaLyC9FE
         SDuDtJhEFr4TalKOH2zIY9rVSVs1d5yv68ekVIIta6Jo+2k0WX+2WUpDeB18qsU6uLsk
         7+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757436101; x=1758040901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kk4Wab53KOqVHzBBwTop8biFtl8+//r37MLHjmIT+pE=;
        b=Ga/r9jdFmdoOqv178RoqI70drelugdwj1CcAGtjiqSwAH6h/mAELytTtqVd40I3vuZ
         Ju4rBBfswDa+W3B0TlLO0xG4s3xI9kQiWjyeI38+VD8o1HPBU9csSxD2BB0v8GBuXWTG
         +ebmHpXvuVBDc1c43xe+vhNgj7EZKcYCGLwf8sPkRrHC7bxY5HlyogiQqS1FkHYaicf5
         noWXV+LSfgVcR9pXlaOoRg1P6sPgO5E0BKo7rCn/ucKIsA1AZHr5qpesB/BtMIeJMIfL
         J9GT3SrzrSjbgpHRckpX71Eul8s9pFxhanR9kAc0xfdoLbQCaNVWj3XgB9DEP/YVAcZm
         930g==
X-Forwarded-Encrypted: i=1; AJvYcCUIfK5O8oXM0wrtLyv4czsZUd1/wag21PSCPlD2YxrWPpCrQ7DPrmKSGDVgW8W4ajVdpTtT4+wtllEEYv901WJlxqo4@vger.kernel.org, AJvYcCVnMtSO43ciXEvHlX20HuMHb1TSgfbMBECRhyh7WkHQIlYFGjXxDJiW58Z+/TdQ7CVX2wE=@vger.kernel.org, AJvYcCWI4OwWLNfAYHBYOycumgHT7mJ2DQPt/eY6sTMuMA/Fjd2fnjfEO39TXljHyfti6oVXXr1HqpPeAcORvcH/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6R0jcXOo6eu6ywXxwvNiqQRc/9P0r+Wpf4xrbk6NMHRMZ0qPe
	4ieLnna8ykkP3111xn7J1Rlm/wlspO14Il5OsKnmAmXLZ5li0jj+zlcN6vrymXlHLU11BXIpYh2
	cJJJqoB02VAYbbEU0SK35B/44vtIBX2Y=
X-Gm-Gg: ASbGnct4E95YpyPu0lZkhXxkT/guPci6Z0KsmAp8cMagPzeXJwnFfYyfJhAaU1fD7jN
	IKDwWOHcA+xyFxOlrrF96VyEDV/MrCGAxxOtGXyEz0YSe9fKygtqbVzqO4Y8c67C69jDoCC3nLx
	p/2Z/l/NPyGA6T3kfTyOoHU7HzXYf/GN1tp9gwFoPLOM9+F7BELxsZ5qspqfPQIcug9YMiIoEe8
	2SnYzF0hUdi6MhmWgKSX0Y=
X-Google-Smtp-Source: AGHT+IFs6bnt99qVuT5n41o0ik4LkSgJjGedVGkUGf7QaHTrjZ9R7XvYldnZA/eYzc2gGJF+vIHoKVUeG+5+7NBBE+s=
X-Received: by 2002:a17:90a:d403:b0:327:9345:7097 with SMTP id
 98e67ed59e1d1-32d43f003bemr17114028a91.10.1757436101507; Tue, 09 Sep 2025
 09:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909123857.315599-1-jolsa@kernel.org>
In-Reply-To: <20250909123857.315599-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Sep 2025 12:41:27 -0400
X-Gm-Features: Ac12FXzcQ2yxKgJ8Vv5PJ7St7b3CIBMMt99WCQui8QjMFDnS97lkogR1V2s7twE
Message-ID: <CAEf4Bzb4ErWn=2SajBcyJxqGEYy0DXmtWuXKLskPGLG-Y9POFA@mail.gmail.com>
Subject: Re: [PATCHv3 perf/core 0/6] uprobe,bpf: Allow to change app registers
 from uprobe registers
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 8:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> we recently had several requests for tetragon to be able to change
> user application function return value or divert its execution through
> instruction pointer change.
>
> This patchset adds support for uprobe program to change app's registers
> including instruction pointer.
>
> v3 changes:
> - deny attach of kprobe,multi with kprobe_write_ctx set [Alexei]
> - added more tests for denied kprobe attachment
>
> thanks,
> jirka
>
>
> ---
> Jiri Olsa (6):
>       bpf: Allow uprobe program to change context registers
>       uprobe: Do not emulate/sstep original instruction when ip is change=
d
>       selftests/bpf: Add uprobe context registers changes test
>       selftests/bpf: Add uprobe context ip register change test
>       selftests/bpf: Add kprobe write ctx attach test
>       selftests/bpf: Add kprobe multi write ctx attach test
>

For the series:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

Question is which tree will this go through? Most changes are in BPF,
so probably bpf-next, right?

>  include/linux/bpf.h                                        |   1 +
>  kernel/events/core.c                                       |   4 +++
>  kernel/events/uprobes.c                                    |   7 +++++
>  kernel/trace/bpf_trace.c                                   |   7 +++--
>  tools/testing/selftests/bpf/prog_tests/attach_probe.c      |  28 +++++++=
++++++++++
>  tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c |  27 +++++++=
+++++++++
>  tools/testing/selftests/bpf/prog_tests/uprobe.c            | 156 +++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++-
>  tools/testing/selftests/bpf/progs/kprobe_write_ctx.c       |  22 +++++++=
++++++
>  tools/testing/selftests/bpf/progs/test_uprobe.c            |  38 +++++++=
++++++++++++++++
>  9 files changed, 287 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/kprobe_write_ctx.c

