Return-Path: <bpf+bounces-56466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B29A97B58
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 01:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87860173827
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 23:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17B921D00E;
	Tue, 22 Apr 2025 23:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUkHJLgT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EDD21ADCC;
	Tue, 22 Apr 2025 23:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365744; cv=none; b=ewU0Lp/vM0I50ndkPzx0YpGnxGi+pEyugBpA/tDTS4+65JkZbfWAPzRxeo9oeBQaIEeu1NPkElS3iip51zvBnXGBpS5l7kbxSgFgOYCbmzL2s1RMD53DAVJet7r8QqkEsuhZURfSXINBBPITjoXZnoR+QyYDh6VXZB3Yk+uUx2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365744; c=relaxed/simple;
	bh=uCrFfvmY1BWeKTC4R7IzOKHCm6s+8c+i+P3vgFxqjbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtyPv/aDY8Mlx2jS0GCTdj/otKQIUd3HSnCbdFAUz7hDpijDwKL8Jj6BcxTbBFM91okideuNFBm/9XC73CjooS/asKmt433KTea1DDR6TkccLLSrENa2SY3NJQR2kj/PsIg+jRl+eJ0KTIQKMs1KYvg1orG5n0NN665547u9X5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUkHJLgT; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aca99fc253bso823692166b.0;
        Tue, 22 Apr 2025 16:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745365741; x=1745970541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtAP/RpD8stbdGj2PAPKdLKPGruPCzPaX6EBxNabXGQ=;
        b=NUkHJLgTgdmBjXTpk8reQq1XJYDPAKs/jcKf0LCzAKg/gxcN3Z0qvuwlWKntBo8v0/
         Q3S/8t3Lv9Twd4yzSizGx8UI4UUsY4EA93hp9fH6L+ENQjgEQ7DlAhvjP5kW8sWvhfZ0
         V9LWfn2M1c3HLE9R7EMItWkEbnWWrIffPhRbiK9RGok1ECqrjpq61MyiPfAk4FS/GojR
         CsIo5T446IdVQjNMZEFseCK9yVdUcZT7Rw84ejMIP2KSq1KF5kOMqd+jP8j/YxXYJbh8
         b55DN7hoCt++qlFzr8YqyBItKxD+DhuOZ6H2E77H/6p92MNN8mT/4KqlVcxXLn5SNjNd
         euhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745365741; x=1745970541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtAP/RpD8stbdGj2PAPKdLKPGruPCzPaX6EBxNabXGQ=;
        b=XYEKLbC5hZeQ5fdXqbtF4vx1mbX/u1vWwqBUTkLLq2F2/zgCKPvJWBTdaIu3ixGg/l
         eIJk2liwx9ZoKJ10mz94EvEMuV2CJzzLdbnQkJJDPXm6PdddneRowIFOb9vkvmPuk4bi
         KWRIcKwIXlID2ZZ0OKuIFpsV5Dzuac8JXkKcAk3Kw/2PEklblQRQ9g4H6z4tGW4+eZgv
         kASkXg7nOfnrI9pZhq3KFacuWLSClo5PU2j76DNzifdntC7tR7Mm2YK9jR10fEYvL5JL
         KOkEockLRvd1JzaAfsI2MYKyrxMvrUYHdbD1JVHiMwLX9vcWVFbYDe5+XI3fviuzowfA
         TuBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkQgPcwv2/AOGTsTZVoaacQAeOcZinR+YZp8bn3/j2H+I4o63KJ2KgrS4WoN276vPfbzCSWs5S7ej5o4Ks@vger.kernel.org, AJvYcCXhlGu9B58IjIOLDChsW3nQhacCt2CPPO7he64SmSpEDk19HIVdAz65uViAEBFbsjFntxg=@vger.kernel.org, AJvYcCXs+EV2fqZNSy1Je4NL2WvxY4xhh64vTrI1+hIdp7C0Hd8n38WKN0jT1KrhQ88+3DyhKBWNOaPGTbsECE43u639ndaj@vger.kernel.org
X-Gm-Message-State: AOJu0YwpJKcEHsxqJJVhGUs6hCtVvUIDO/J4p8gLRrl0lxs1wtPaaaLC
	RlWR89yAd/qVQud0fanDVB3FmG0VZuy8nXb6/3cRdhfDpJiMSlT2K4jBO2IxBqWxpJ9xzxMZWIQ
	7TU33jZaHcpob0dmTJCFNjZBHOXI=
X-Gm-Gg: ASbGnctlQMbFyMyETLR3TxT+WzscPD5hRYsXRJo9qTjZjXiWSQpdMf4VI1CpXqR9JAc
	sVOWUj1w7DLckdVm1nkzg8YAHEnpVFV21zPl8lKk47IL5pO/ddMb7QrQVsIS6B4a06orogk8iad
	hh+uHU4jjB5JTlZFwFopGfUS6faxRd3eab63g4WA==
X-Google-Smtp-Source: AGHT+IGNstO+C4N74G28rymkR+8fQJxcFUcHnCcmnL0LBDEAN+PiVtK/evW1vnuqN6yEh8T+DV/sbCOLnag7SG9RYuQ=
X-Received: by 2002:a17:906:f58e:b0:ace:3c0b:1947 with SMTP id
 a640c23a62f3a-ace3c0b20f4mr109777866b.4.1745365740500; Tue, 22 Apr 2025
 16:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421214423.393661-1-jolsa@kernel.org> <20250421214423.393661-8-jolsa@kernel.org>
In-Reply-To: <20250421214423.393661-8-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Apr 2025 16:48:24 -0700
X-Gm-Features: ATxdqUFWNCbaUTk_sukSB1n225IEm5eGMWbID4RHtc4FUhdzAtpifAa7AsJvsjE
Message-ID: <CAEf4BzbtUMCCY8FPjRjc8i5newEoKkz7S-j-LOpD6TJzOogNtg@mail.gmail.com>
Subject: Re: [PATCH perf/core 07/22] uprobes: Remove breakpoint in
 unapply_uprobe under mmap_write_lock
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 2:45=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Currently unapply_uprobe takes mmap_read_lock, but it might call
> remove_breakpoint which eventually changes user pages.
>
> Current code writes either breakpoint or original instruction, so
> it can probably go away with that, but with the upcoming change that
> writes multiple instructions on the probed address we need to ensure
> that any update to mm's pages is exclusive.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/events/uprobes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Makes sense.

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index c8d88060dfbf..d256c695d7ff 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1483,7 +1483,7 @@ static int unapply_uprobe(struct uprobe *uprobe, st=
ruct mm_struct *mm)
>         struct vm_area_struct *vma;
>         int err =3D 0;
>
> -       mmap_read_lock(mm);
> +       mmap_write_lock(mm);
>         for_each_vma(vmi, vma) {
>                 unsigned long vaddr;
>                 loff_t offset;
> @@ -1500,7 +1500,7 @@ static int unapply_uprobe(struct uprobe *uprobe, st=
ruct mm_struct *mm)
>                 vaddr =3D offset_to_vaddr(vma, uprobe->offset);
>                 err |=3D remove_breakpoint(uprobe, vma, vaddr);
>         }
> -       mmap_read_unlock(mm);
> +       mmap_write_unlock(mm);
>
>         return err;
>  }
> --
> 2.49.0
>

