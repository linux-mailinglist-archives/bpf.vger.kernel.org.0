Return-Path: <bpf+bounces-62000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC8FAF041C
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 21:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61164189BD5C
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 19:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB7A27FD5D;
	Tue,  1 Jul 2025 19:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTejyEKK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A822272E48
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751399442; cv=none; b=Nxqtd5XUgEND5r0yjap6JVP6fusKtH//YpTCM+ww6Ymnh3W2kxt6IUyavisAFpSjP0uUeGglLhNHpis5TkV/vVDEqXBBQQNMRW+WffAPeJgbI+73+SXLhD3+YYK3qFNvdzfmByYUTj+jfCxot4FnRxryDEGSy2nKw1lwj5wKVTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751399442; c=relaxed/simple;
	bh=Ul+zbXDIDyKSp5sDr7JTq84LKkiCg/K49g+EWPZAYkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFqC65bDPsyGKGUVDmrW9tK2ntNWpVVYsagL3BuFj5XE23sF5piIWeU+FDtkKHsr6Vy3KKEdnCguVFzHsD3iqQaNHRQe9cNrMJtX/yHUu7n98ECkUXrroMpHMeO3Bb21sN1s6PdF2yUzz6djYKKTC6X7jtRUh970xjmsuP7Xtbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTejyEKK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so36124505e9.2
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 12:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751399439; x=1752004239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ul+zbXDIDyKSp5sDr7JTq84LKkiCg/K49g+EWPZAYkI=;
        b=hTejyEKKU4OLyB5n6azx8EhHkS8Ctw9rGDROWsBaEMFoR/sGmVqf0iGjcyaG8qs9mB
         dMnjHUEyia1kR6FODyUi++UOdyEAae5H9K3nb5CKn20wlYmP+kLtTotLeR+veM4JBpmp
         DTcXfW5fBhQ3dLzGnT7Geqxe5PF0/7MqGdLzrrL3CDJUshZUCimL1qjmyiVmnquK7LiH
         X+ZSNVZB3BFo+H6y17ajmDVR0AbIMKxj5MKp9JZ5FRunEpeHnmdU7ZF8yw9xmXm90vit
         r6e0vFrv7fSCv7K2Ohd3R5gTwKTmNq+7g7WHqxTlQqnUA5AEwYfvI7uMA+O5cBZyxy+/
         rj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751399439; x=1752004239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ul+zbXDIDyKSp5sDr7JTq84LKkiCg/K49g+EWPZAYkI=;
        b=ZNyswrBjfTEtZohHBnMjGfsrLOcRpnHtnZID0uFPoZgQB1XuW+Z9bqCJ7N5iRSTsAJ
         3V7TItmjB2NU5TeUwaXJ/jLqcxKyg7Gqsa76iCP+asmcrDUNan47Ix7QC2tGewRKRt/N
         9dpL+twq1CqepgEZny4dUcoPKHrQ56aJzCxqs5BbpURQTFXaMv6Ad3tEzRRcsY5TpnGZ
         ASwkau/ueovcOqJHrACfShgCffaE+C2oop/ww+OOXeKFwwnyIQIPiFU74LCAfwHBF3Ee
         WICzH2BIsJK6JCAOY4XRi1bFoVWbefEDCXLkDvrNoX6c0VlGe+4rZb9fB62URpJ30sf/
         3uEA==
X-Gm-Message-State: AOJu0YxFs4NRig4fW6+lkzfGayw25lwG9RRlCg496C3NW5f02vnWogYd
	9VvPfRWQawNShQX1Zn409qb0LfxvE2B0TG/zW+ktXYXaVqy792pOiUX5A5daErz+sDfs8uAnMTr
	RFs8hqRLPYCFk6e8r1nywJX0XeMBXxMw=
X-Gm-Gg: ASbGnctw6aYW3kTDAPRWXDANPTSqlYAYoWAtlw68Vz5liDWkF2wn+QFAlW1A5jFbrIM
	QoRBIJG02ynqBZ2t+VKm0Af2lntiywKwaa0nYcMPQ/wGrY/w2FyWZfjGIdSwwwkn2UaLhz7hHjO
	kKi9c1rRcKTJ88UAV8Ym3hYRWtLu7FyG9qLBTix/klusek1xgzHzrlhUXF8zU=
X-Google-Smtp-Source: AGHT+IEhfhzNCa3B9J67hJOrIFXK8tQNPt/Z9A/ABlqyb1KFB/8iEqS905qxehtmVBVaAQ4VunjseWPT00Ykp7nR2sw=
X-Received: by 2002:a05:600c:3f05:b0:451:e394:8920 with SMTP id
 5b1f17b1804b1-454a372e226mr3106575e9.27.1751399438317; Tue, 01 Jul 2025
 12:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630133524.364236-1-vmalik@redhat.com> <CAADnVQJF8-8zHV75Cf7v8XWGVrJwU5JaQjBm0B-Q3JUUMqNmcQ@mail.gmail.com>
 <49fcc6c3-8075-4134-bdbd-fbd8a40f4202@redhat.com>
In-Reply-To: <49fcc6c3-8075-4134-bdbd-fbd8a40f4202@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Jul 2025 12:50:24 -0700
X-Gm-Features: Ac12FXyyJLzCXT_xbExJtHdcCAzTUCO1Ml4YvcOclgxSONQivX2uX6oVlwOT0aI
Message-ID: <CAADnVQKQTLDP1W1ao-mCPfLDbZWykW1TdcouJPSVapNWu=bCBw@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Re-add kfunc declarations to qdisc tests
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Feng Yang <yangfeng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 12:43=E2=80=AFPM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> On 7/1/25 19:46, Alexei Starovoitov wrote:
> > On Mon, Jun 30, 2025 at 6:35=E2=80=AFAM Viktor Malik <vmalik@redhat.com=
> wrote:
> >>
> >> BPF selftests compilation fails on systems with CONFIG_NET_SCH_BPF=3Dn=
.
> >> The reason is that qdisc-related kfuncs are included via vmlinux.h but
> >> when qdisc is disabled, they are not defined and do not appear in
> >> vmlinux.h.
> >
> > Yes and that's expected behavior. It's not a bug.
> > That's why we have CONFIG_NET_SCH_BPF=3Dy in
> > selftests/bpf/config
> > and CI picks it up automatically.
> >
> > If we add these kfuncs to bpf_qdisc_common.h where would we
> > draw the line when the kfuncs should be added or not ?
>
> I'd say that we should add kfuncs which are only included in vmlinux.h
> under certain configurations. Obviously stuff like CONFIG_BPF=3Dy can be
> presumed but there're tons of configs options which may be disabled on a
> system and it still makes sense to compile and run at least a part of
> test_progs on them.
>
> > Currently we don't add any new kfuncs, since they all
> > should be in vmlinux.h
>
> This way, we're preventing people to build and therefore run *any*
> test_progs on systems which do not have all the configs required in
> selftests/bpf/config. Running selftests on such systems may reveal bugs
> not captured by the CI so I think that it may be eventually beneficial
> for everyone.

Not quite. What's stopping people to build selftests
with 'make -k' ?
Some bpf progs will not compile, but test_progs binary will be built and
it will run the rest of the tests.

We can take this patch, but let's define the rules for adding
kfuncs explicitly.
What are you proposing exactly ?
Anything that is gated by some CONFIG_FOO _must_ be added explicitly ?
Assuming we won't be going back and retroactively adding them ?

