Return-Path: <bpf+bounces-34674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CCD930078
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 20:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D95B21F96
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 18:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678301BC3C;
	Fri, 12 Jul 2024 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+81KW75"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A014F18AF9;
	Fri, 12 Jul 2024 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720808830; cv=none; b=CvoA8KwobvXHpTtPETRCichovr9tIL8OU8OvAEzQ3IMH3INb1ojMTjGt1g+E7FChq3g+6hh4eqfSuty/aunmCegRnh0C5X7At7ZESWXq7oce7M4tU/YkK5YF+9JXdpAIEPP5rYFf4e5tcER7+ADrGRQQmxuFvryXtz+wEzLsxRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720808830; c=relaxed/simple;
	bh=ySTzuCWe1WZtgrrB2Ofesp8DBEZhlfXalI9LWz4BmC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nclcZ2n1uEGPamnj524fbOhlEJS2Lg4g1y99+f+pi+zMwrSCHVRdMpIXNZnW/sawC2SGcDPGel4GNbFCsjNlCqxZo5nGJe4lRdIRMNXuu6Pdjc+MwqjhTvExndk2C5VDiCZuTy5DSvIwRZIwjJW5QfAUly9f1heXrqqNCg2ZwCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+81KW75; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2bfdae7997aso1815717a91.2;
        Fri, 12 Jul 2024 11:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720808828; x=1721413628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWlzuBs0JVjSsrquzlDZxy9XAzKcfAZio8DZyGUFpyU=;
        b=V+81KW75dA0Ke/w4epimQ1T6qUFX54T+Ie/+V4IU9lcCytI1zE/Duf68PswGv3u0Go
         POGV3mVEH+Uys1nK0H5msbYT2zE7irM5+GMyj7UM3YxR4QSMtuUgHAJPSVWii0ZtmWww
         1N20pEx590ZKNM+jW89/P/XiuENKsZEghkilK41kSygXbZprsOBkJRj0RnNY48X1LV6n
         EVj3GnCqVdHJzceLWJ+ZkF0GBeTqDxdZwh1ZWeILXo8fO1fOMxgy9YGAngLQmleXyVlH
         y2KmvLC97sd8g3dDa/uAgJBrgZqTvqrlYl2OqNoo3LfxdQk0l+E4PHm4zhNpLx2Gf/CT
         3BHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720808828; x=1721413628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWlzuBs0JVjSsrquzlDZxy9XAzKcfAZio8DZyGUFpyU=;
        b=nrmWZaUUAWHAthdhsLYGfztt55T6b9tJ4BZiFvLBv9Q0m/FEWaCozHow+DMi1pAQJT
         V2A9mok2zPo59QgfIH/nzjA7/HeWpo2oCLZ3mRbgmnTh0pZDwWie0clNwK04VcdI0AE6
         utQUT6VY1cWFUDjmX4Mc/JW6qE9GN94gtkZyQyzD6U8JUvEi1eejce7o9G1XZ/8zng+J
         7uRUKwrU23INBQP4k1BqQvBT//uB+HI3mVUX6RYj3EWROv4x8GFohTATC5lSMMLk1KsA
         pUygmSSAifbB1x+afZ3vb1kDqvhxKRgSEYaRHa5wXMAWfcB5UGHrA/iuCypjxv9IhuCp
         UtJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzb/obnDPsqD9sJIsMKdsIxkQXV3tzFHI+ObiVoIiUZgvhEMYzVpL1q3e3hGo2dhXal+J6GgNaxpMYXEX8XZ795WgEr/RbXua+dFdH0AlMNFlJ+PmkF0GpsN5yRK8qON6ZI4Nz9j1pqpO2bPHRcZ8B30+9x54bliIjT4l2hys5TX7dbdGYxxQdLj6qwob8dzhofWiWGBlRUdn9Y2npgzVJ
X-Gm-Message-State: AOJu0Yyg5KduzAnRSD/6JNSNKawXeGjw8EgHOiUGlV3yQOOhbTMm7eGF
	v1TZ+asbw3gYf6cPddbwBSBR3Zi4DFYM6s76H9jgRyBF1hnUnqCZBROmefNJRfK16Ks+mlIYpEj
	kvMwWEADDN4xqnSmUJQl4gXcWTfU=
X-Google-Smtp-Source: AGHT+IGLopBIwpc+2USkp/PiI+T5/l6GSue2R9EDzDT5841MwRMyYJEbmNCoR3BjszWiyagYOQlpBK7jirXqPCRnk9E=
X-Received: by 2002:a17:90a:d917:b0:2c9:83f3:128c with SMTP id
 98e67ed59e1d1-2ca35d4407emr10421111a91.31.1720808827772; Fri, 12 Jul 2024
 11:27:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712135228.1619332-1-jolsa@kernel.org> <20240712135228.1619332-2-jolsa@kernel.org>
In-Reply-To: <20240712135228.1619332-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 12 Jul 2024 11:26:55 -0700
Message-ID: <CAEf4BzbGVGkoCW3xE9yvMUhMDESEZEpQohKoTvy8w7V9o70vBA@mail.gmail.com>
Subject: Re: [PATCH 1/2] uprobe: Change uretprobe syscall scope and number
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	bpf@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Deepak Gupta <debug@rivosinc.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 6:52=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> After discussing with Arnd [1] it's preferable to change uretprobe
> syscall number to 467 to omit the merge conflict with xattrat syscalls.
>
> Also changing the ABI to 'common' which will ease up the global
> scripts/syscall.tbl management. One consequence is we generate uretprobe
> syscall numbers for ABIs that do not support uretprobe syscall, but the
> syscall still returns -ENOSYS when called in that ABI.
>
> [1] https://lore.kernel.org/lkml/784a34e5-4654-44c9-9c07-f9f4ffd952a0@app=
.fastmail.com/
>
> Fixes: 190fec72df4a ("uprobe: Wire up uretprobe system call")
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/entry/syscalls/syscall_64.tbl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

sure, why not

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/sysc=
alls/syscall_64.tbl
> index 6452c2ec469a..dabf1982de6d 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -384,7 +384,7 @@
>  460    common  lsm_set_self_attr       sys_lsm_set_self_attr
>  461    common  lsm_list_modules        sys_lsm_list_modules
>  462    common  mseal                   sys_mseal
> -463    64      uretprobe               sys_uretprobe
> +467    common  uretprobe               sys_uretprobe
>
>  #
>  # Due to a historical design error, certain syscalls are numbered differ=
ently
> --
> 2.45.2
>

