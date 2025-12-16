Return-Path: <bpf+bounces-76651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B63DCC072C
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 02:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35248301F5DF
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 01:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B11C258CE9;
	Tue, 16 Dec 2025 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBS0371E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643A922B8C5
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765848279; cv=none; b=B2oHM7hxWKM7wdRA7BMKzmh8gKiPFnLwV5kv+2pCBkBZpTccyObfi423/QyDOIKTyJd/Ia6hY9vN5f1nwxc87VwseGzB3PFYV+oeqHzlwSfovaP+I48zGgIPRFyblTPk7PwsFgZHN9x0qz7AXz26uRcqtG9TJGOtj2YKGTqG3QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765848279; c=relaxed/simple;
	bh=q8hPouLZ1tqBmJGx2h/O1//9XD7eBcnlMWD3BJ09qFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulBwCb8oHp+dhQhzyihT6t+QaDeB/jjtRruUWUgiU0KHaZFmoY26sm1jY+8rEH+gkhL/THTzY1gXmR4vqjbY/epSaLRxlzqJNOwz3EBj/A/JyCHMo8ykZ3qw0BLsm+0UVgW6NbWb6iZUpjcuY+jUltYTD/vklLXKtiBEaJ/9RQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBS0371E; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso1479007f8f.2
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 17:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765848276; x=1766453076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6O/ayhPvJzUYiXnkNU0wdnwc154Pl8W2YXq/7sVXUbM=;
        b=WBS0371EixhaekEBFguZqLavd/N1IxcJvw/oH7voyqSZJ3rrHkg0bZUa2FclZEwlRH
         hpKomT7yvqMMrqtDh2c0wCmayG6esnDy4EN94lShPndqgLQ35PIJV4iJKkobbF2SJkj9
         J8ZN3KfiUZTqTmIw9Q1O9xgPrq/jggEPYjaQiryID7NhyaHaII+KHkxHM6MV6TQMGGT2
         k6g7U9aui5Y7N2h98/PLLEvdHkI5FM4a51hDp9tD9V5jzl5P+/mF4EhLA7+RpnQjdK3+
         OkGRrQ6jjxwbd9sNltS0wi0kfwkQzDJdJAOxKsCZBwmMJ7qNBQHZyTuLezomX1o7l5+U
         pmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765848276; x=1766453076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6O/ayhPvJzUYiXnkNU0wdnwc154Pl8W2YXq/7sVXUbM=;
        b=uXcG9Q3WUaKaGbioW/LAZsFsLPRTSlWtFfFo2PBulK0MuZJ69oRxGXv0pbaYoR51gJ
         UDtKKt+aJ1+PS7svLQ3Sy3jRlJRAVA/NRp5MWaJosZdhotI5qUfzqK/BJWrj/5/bYSPk
         2fFVhoP1JgmZ6Uuh1gJ9uqx+EOoIhy8YDX2jU6IDE09LvETaVcrTLgM5cWIvqDHyj7fG
         t6CQIekmy9spVNUSh7ubbAZt4H2G2tpupdF8zHpPHE+R3TDyUtdYl0numPMK4OYUaMsd
         R4VgSpsFhJVLsb4FU+F67Rev06K3gzejmHrda8YFnAMLMh/sV0HMyF8FZ8pn/5Z2sRxN
         CoTA==
X-Forwarded-Encrypted: i=1; AJvYcCWnBMta54cnqIfQ5DYQ9eLuWRRkOePA45BOnTOkEl4khg9y7hUrPVzr5SHTwp9zC0W6xjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZAjhc+1rudx0g2whuUPza2qnu1KXf34CB65P9IUpPRboWUP3C
	ZAgdrqPc2kERJkCLI7CmzCPBF9RYgmMqgv0UGvuyjDKO3drFSqYKVgTtze1S+1Qk+FapS7hNqRS
	u+Nc/FlfcOeGi/WGSLyWHIqMmf3Y50mF0eA==
X-Gm-Gg: AY/fxX4O9HgaUiq1K5yrDUMW8qhD8XtYbAK/+GfcbevcI8UDyDFdAASCVm4fBpO1pyZ
	ciOYX9ii81glzWdkTniDVTac6uLPhnu5ijQtv8Fhd2DBQBxReG8hIp4jiSUFEOTQPanCCTSa38E
	N30eUeVsi9Kl8I2Ssx6TtVLFTeJ6qOVXGS2C6JTMokIBea8ojRZm8Uu1YO6WQhaPQHSK1PZjDy3
	IqXwWUormIoeMYBBtrsVY3Z2FkfUh2T+u9HJUX7tIFKNqbgrkIB9aGZvFXXzfqPCYPdmUelwo6T
	BmvktVuBa4tPyFxWvd9s4zgttQ6LBZ5t/gqfDts=
X-Google-Smtp-Source: AGHT+IGMRDt5gPftYQJNw3ZXkdp/9E4YRr0auH1CkY9jKe0cy/McjdvCfIpzaDDVEf27AVQhsEFcECTOPJBCSpGHIXk=
X-Received: by 2002:a05:6000:22c8:b0:431:16d:63d1 with SMTP id
 ffacd0b85a97d-431016d6854mr4185472f8f.44.1765848275505; Mon, 15 Dec 2025
 17:24:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQK9ZkPC7+R5VXKHVdtj8tumpMXm7BTp0u9CoiFLz_aPTg@mail.gmail.com>
 <CAPhsuW4MDzY6jjw+gaqtnoQ_p+ZqE5cLMZAAs=HbrfprswQk-Q@mail.gmail.com>
In-Reply-To: <CAPhsuW4MDzY6jjw+gaqtnoQ_p+ZqE5cLMZAAs=HbrfprswQk-Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Dec 2025 17:24:24 -0800
X-Gm-Features: AQt7F2rljHGwKnYTlrJF8witR3Lr3cIkj99az-pI5YQndy27VQxfGEDL49iyTi8
Message-ID: <CAADnVQKHEOusNnirYLuMjeKnJyJmCawEeOXsTf2JYi4RUTo5Tw@mail.gmail.com>
Subject: Re: fms-extensions and bpf
To: Song Liu <song@kernel.org>
Cc: Quentin Monnet <qmo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 3:46=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Wed, Dec 3, 2025 at 8:30=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Hi All,
> >
> > The kernel is now built with -fms-extensions and it is
> > using them in various places.
> > To stop-the-bleed and let selftests/bpf pass
> > I applied the short term fix:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=
=3D835a50753579aa8368a08fca307e638723207768
> >
> > Long term I think we can try to teach bpftool
> > to emit __diag_push("-fms-extensions"..)
> > at the top of vmlinux.h.
> > Not sure whether it's working though.
>
> Something like the following works for me. But I am not sure
> whether it is the best solution.

Great. Pls submit an official patch targeting bpf tree,
since without the fix the vmlinux_6_19.h won't be usable in older setups.

> Thanks,
> Song
>
> diff --git i/tools/bpf/bpftool/btf.c w/tools/bpf/bpftool/btf.c
> index 946612029dee..606886b79805 100644
> --- i/tools/bpf/bpftool/btf.c
> +++ w/tools/bpf/bpftool/btf.c
> @@ -798,6 +798,9 @@ static int dump_btf_c(const struct btf *btf,
>         printf("#define __bpf_fastcall\n");
>         printf("#endif\n");
>         printf("#endif\n\n");
> +       printf("#pragma clang diagnostic push\n");
> +       printf("#pragma clang diagnostic ignored \"-Wmissing-declarations=
\"\n");

what about pragma GCC ? gcc-bpf is gaining traction...
will pragma clang or pragma GCC work for both?

> +       printf("\n");

here...

>
>         if (root_type_cnt) {
>                 for (i =3D 0; i < root_type_cnt; i++) {
> @@ -823,6 +826,8 @@ static int dump_btf_c(const struct btf *btf,
>                         goto done;
>         }
>
> +       printf("\n");

and here... I would skip printing these two empty lines.

> +       printf("#pragma clang diagnostic pop\n");
>         printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
>         printf("#pragma clang attribute pop\n");
>         printf("#endif\n");

