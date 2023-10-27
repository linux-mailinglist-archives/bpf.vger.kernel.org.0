Return-Path: <bpf+bounces-13524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFC27DA41D
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 01:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5CFA28280C
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 23:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3954120D;
	Fri, 27 Oct 2023 23:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHj014Qs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5489347D3;
	Fri, 27 Oct 2023 23:37:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F93C433C7;
	Fri, 27 Oct 2023 23:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698449864;
	bh=aCJLWjdhU+5nCV6MY/j5MaIJfk6Y70haoZWhwkapETs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JHj014QsOtLjRB9STmY/QRoHaYnrnyBpcw9by28Jtet59hAM6hbi9ii8GgCrSzIKO
	 Hm8Ul3DdYBKuWXK/qDqmcnwQjWsjGGrfbQu8LDWTv/NbFR+Z7/X8ZM4CLSYTwLNW46
	 lhLQoBh5xa+CwpOnFz59bFl8W8HoVqywfhC74JRyomxoeWNlc0PezUY3uLAvZLVpOP
	 F23DDQ+DB/ck9aRuglLbsmuSgOVkakOEjQY9k4ZyqD7nEwEQOELwdqiwWyfknVQSgg
	 yba36D9LSAOC2fTfdBQZ91LRKLXa9AIF4ea0LVOg33Fvl9uw7fwYr+zqySDI73NMJJ
	 zWYY0NkVnxAVg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-507a62d4788so4022933e87.0;
        Fri, 27 Oct 2023 16:37:43 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy91cJ8TRqcRVxNZS/99iGJX7V15jzHJ4TlYX7+h1L6uEnmgQiQ
	tNUY47LGmS6RlwLL8Pwr3ac9v6/KMDwuVIjLFVk=
X-Google-Smtp-Source: AGHT+IErVIa16OdIYg71SntJ/eEKyZs7geS5tG2hC3qrU6xcJtP1SoEw0chQzTcaA7dv3gPNQ+TRXyUSWSpAYpANjDo=
X-Received: by 2002:a19:7710:0:b0:508:1c45:f998 with SMTP id
 s16-20020a197710000000b005081c45f998mr2314308lfc.48.1698449862246; Fri, 27
 Oct 2023 16:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027233126.2073148-1-andrii@kernel.org>
In-Reply-To: <20231027233126.2073148-1-andrii@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 27 Oct 2023 16:37:29 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4aLOvH7t2m6tm8CjPWKr_hvsvh_TacDgpggg7bL3b7aw@mail.gmail.com>
Message-ID: <CAPhsuW4aLOvH7t2m6tm8CjPWKr_hvsvh_TacDgpggg7bL3b7aw@mail.gmail.com>
Subject: Re: [PATCH] tracing/kprobes: Fix symbol counting logic by looking at
 modules as well
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, Francis Laniel <flaniel@linux.microsoft.com>, stable@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 4:31=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Recent changes to count number of matching symbols when creating
> a kprobe event failed to take into account kernel modules. As such, it
> breaks kprobes on kernel module symbols, by assuming there is no match.
>
> Fix this my calling module_kallsyms_on_each_symbol() in addition to
> kallsyms_on_each_match_symbol() to perform a proper counting.
>
> Cc: Francis Laniel <flaniel@linux.microsoft.com>
> Cc: stable@vger.kernel.org
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func mat=
ches several symbols")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Song Liu <song@kernel.org>

