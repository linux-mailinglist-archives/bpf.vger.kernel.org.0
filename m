Return-Path: <bpf+bounces-75371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D116CC81D92
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 18:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738263A2326
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B0B20E00B;
	Mon, 24 Nov 2025 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6CwbMFm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3A6339A8
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004515; cv=none; b=uyhfMKGJDi8POaIY2H2I9CiTkTARaYesAP9zSJRAxauBrlZPm8D16ZSsSertRbve7RhKarB5KWMIFW3KnrrCdkDbb7iK80TRGCnPCAZuNoF8zr4o/FwXsBC7S0pO5iYgKMg9yDXbe+ZRRHTd6hIr2TdKoGt+91icHbbVejFFtEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004515; c=relaxed/simple;
	bh=Q+/DyZjLvOXPct7tmBqaRGe93isBz1eaNThEZqONNBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHQNNe/y5dHC+sYoJrZK3GguT0hDi+/zB9B1OL6gfjlKRtRZTcqGvFLdZb0qgRHfb5mg0PunomBKfSps/UqEtyn9BDSti/yGhc58tkuVsFQVSiwicZ6rQxS1C1KzoiCkge5j6Yzuy0LhtA+MgHW0/R8nTnQdP46jPHFQroK/9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6CwbMFm; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b32a5494dso2436751f8f.2
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 09:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764004511; x=1764609311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xf0R6pgOXPMXXlrBatSlZLsanZIehujUAI56eNnYOFI=;
        b=j6CwbMFmvUkrejn1t00An/fHZQBzs1m58wHKDmA9m+gxcNz2NcyVZfQO07VJaE67JV
         kHX3OB0HfzSWLmAKPbZXlfo/CYNuxqL71SVSJfhWHJfHQcRF1GWjEFIM/NdRm+fQWqh/
         DpOMIu3oLaotfiCPRCGp7O1Ja4gx8sGZ3/T4WsBk2djl2dPoiocjDbe4rO1MeHHEli8a
         j59ZaypikLjf3D0tvGqd/IORSB/vQjZUhqXKqvev8F3+KdrgAj7giCQQstbjgRuYQ9Es
         3UMUEXGRWhUa12samq0pyXOFGt9LZCb1+tnf56+w4beJCYbMUOgleXKzRmkkoiI5spNH
         xwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764004511; x=1764609311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xf0R6pgOXPMXXlrBatSlZLsanZIehujUAI56eNnYOFI=;
        b=E0iE9ieKOX5GloTKLVfaE5HYrMBW5IsTm2z7isGNv8OuGeAXoGp7F31Ix5KK3bS7No
         6ybEGXiu40mR8WAM+gAYB/bgXYrl1fQ2QqNiRbwAVrC9MPN+bqRhOhw1ZisuwisxOKNy
         qlUIlE+aNinYeZggo1Gctz4HUGTSi/mRGI+65yIjM2m3ov62hZY97NqLEaU6aD5AXipY
         UTSlt9EYfzMihKO0G1lQTfpj7kkHaCYlsphMaxP41j48Q9cK1mvN//qkBhjjfRQv7537
         2idFLuF9MfShzZe4yPRu6w6qTJVpWslZQ8kfG6eOd4L9kKMxdSxf2LBojHAw7wansFGU
         J57g==
X-Forwarded-Encrypted: i=1; AJvYcCXqQVH4HcVTC1HUBQnJSByOiYdJOOv0Kcc1GOtvgsA92bsOwiwEKWGzlG6iSsjxq+46sR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMw7dOwL1KQGJc/C8T0MUJT9HFMp3rg+yfvEdLLo/jThih6dof
	n1FDTm9uOZ4Bs4V42Q1yFVN6Hvysp2fd82JU8b8Q8wDyruABLS+63/WjNMBNF/Ds8kTPdStXJR3
	LRFcNhkerTgKUu0iAK1gYani98OjEknA=
X-Gm-Gg: ASbGncvmFtIjmwl7/U+c5Xek4wgqOyBWOnQk2/BrBc/i3Tcxkh7yjq3SoRBvuFln2eQ
	DCVHbvLb0N3WFrMms7CYU6EXdtjNZ4kfxpYyHOYyWs6DorbTi/iLbYtO4ea91E099kT1XUmC1Wu
	IybTjrin8GdOSReH2/eqv/cLqxGKNeupj5vI0o7pNo7vUXUSxWRKXzKdtmc2B10xugUstV8sipu
	Ietf1NeEKxh3Xg/lbGQJNTo81bVql3FJB0ozbdrSbM5h4Q0cBxWOsZpTN7BMhE/a0o1n7ABPSLm
	sVFKgWUX59E=
X-Google-Smtp-Source: AGHT+IG3TQCF29k3/0oYfxapdRYF5ShpO49z+GSv5pNz/JHDiUd1ARlPgUy0GdJeiH1icTPuVTT1M6WZAWhtxA0ZJYg=
X-Received: by 2002:a05:6000:2601:b0:42b:3da6:6d32 with SMTP id
 ffacd0b85a97d-42cc1cf3bedmr11909705f8f.23.1764004510865; Mon, 24 Nov 2025
 09:15:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e555733-c670-4e84-b2e6-abb8b84ade38@crowdstrike.com>
 <alpine.LSU.2.21.2511201311570.16226@pobox.suse.cz> <h4e7ar2fckfs6y2c2tm4lq4r54edzvqdq6cy5qctb7v3bi5s2u@q4hfzrlembrn>
In-Reply-To: <h4e7ar2fckfs6y2c2tm4lq4r54edzvqdq6cy5qctb7v3bi5s2u@q4hfzrlembrn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 24 Nov 2025 09:14:59 -0800
X-Gm-Features: AWmQ_bkiKRGI6g0lyXxVEwqBqGMSF5stePJqiIL5GsG4k3OfAlcU5urtEOCg-mw
Message-ID: <CAADnVQLWD5-z6uajf=WzKj1J2V6+fc1wNBTzBJj3ufbskMEoPA@mail.gmail.com>
Subject: Re: BPF fentry/fexit trampolines stall livepatch stalls transition
 due to missing ORC unwind metadata
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Miroslav Benes <mbenes@suse.cz>, Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, 
	bpf <bpf@vger.kernel.org>, live-patching@vger.kernel.org, 
	DL Linux Open Source Team <linux-open-source@crowdstrike.com>, Petr Mladek <pmladek@suse.com>, 
	Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Raja Khan <raja.khan@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 4:56=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
>
> Maybe we can take advantage of the fact that BPF uses frame pointers
> unconditionally, and avoid the complexity of "dynamic ORC" for now, by
> just having BPF keep track of where the frame pointer is valid (after
> the prologue, before the epilogue).

...
>                         EMIT1(0xC9);         /* leave */
> +                       bpf_prog->aux->ksym.fp_end =3D prog - temp;
> +
>                         emit_return(&prog, image + addrs[i - 1] + (prog -=
 temp));
>                         break;
>
> @@ -3299,6 +3304,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
>         }
>         EMIT1(0x55);             /* push rbp */
>         EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
> +       im->ksym.fp_start =3D prog - (u8 *)rw_image;
> +

Overall makes sense to me, but do you have to skip the prologue/epilogue ?
What happens if it's just bpf_ksym_find() ?
Only irq can interrupt this push/mov sequence and it uses a different irq s=
tack.

