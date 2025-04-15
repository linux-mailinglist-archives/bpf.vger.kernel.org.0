Return-Path: <bpf+bounces-55972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77342A8A4EB
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 19:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D2B17FA4D
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 17:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24401ACEBE;
	Tue, 15 Apr 2025 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fD+wIOA0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30AD84FAD;
	Tue, 15 Apr 2025 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736746; cv=none; b=Yx/H4Je6r7gZyrmBmEuN3eWpq9AZyXgLMX5fz8DHc8vYhFYpVQioafWkx9gNX4b5X8DLWJ2FZ6eOCHE6DhKkvEf72Fe6+KOVg83zV8nsOBQ1o+K1VCmNbMfG5wItGswqDnJiGPBDkf6x7qvS6KkWTZD51DsbgoA0J0H779Qsn3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736746; c=relaxed/simple;
	bh=ZkblCK2OfPSPmJSFFzHT0HQx5TYG9c06icogDcimMQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJKJuMEJbGFUsQpBbY5ZyRHlnpAbk3fHySq+vmLKcXz/KSKrSiAhYwLymAISntjF8Q+/CasrdcMabIKNuxSg+7Z9OWAG1xBg0ewz+gb6QV20aDebayExl1Vyn2DhwLHczK4aquwiZMOUawNG9eHDe5hGkLy2mb6qlgJ+e/aucLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fD+wIOA0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so61125265e9.3;
        Tue, 15 Apr 2025 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744736743; x=1745341543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkblCK2OfPSPmJSFFzHT0HQx5TYG9c06icogDcimMQs=;
        b=fD+wIOA0UEluB3RuE4SYKlMdpU4IO9alrnYUOJs6e8OllFfOOlUw9TenqbtoMBni5g
         A+fcJF0ZTXXQfkqpw4lSn+VSLv5BtXtRq3CBPtBhDFwJwT074/pUXpVudqVRR6SL3Jrf
         86qIA016GOYaZiXOr6RIQjCeDP3sqDjGzCoh2iwek2VIYLRJcAZejlmt3xHE5Z+yUsq8
         UgCX+7Ap1U4Y5e66VCNSfRkr10gYqk+VaxEAoFcT2SY8Ms4FiR326+Cwx5EVFDj/GS5b
         7Gv8/yJneDBrRfVAPNKp41re3Jl0CvkGxlbZ8dFfDBBrkWoSzyu9yeE5MlO7+60vI5gb
         Q5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744736743; x=1745341543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkblCK2OfPSPmJSFFzHT0HQx5TYG9c06icogDcimMQs=;
        b=Yca+S5L2wiRLzW3vtWFFRdbiGSbux57C1GO9fHurr9tVX6hPQYhTYwjSBhykf+ZwB+
         V1+zOkX6NH1ucCuMJIeOImpMhGgTWUZoV0QARkAelmBnXACdIBuRM+CWVQdhO+Ob51ah
         dimPyRpTzOF8tz/vYB7xt0VYe+wOeVMDDGTcLYCh0h1EGiqii8U46u6DJCKFpalrWhLR
         r3NWhzka0kKBS3PP1q39h6iAJSEyPS8zPl204kwUSYNhvvmusmkZxwTve7WotHQu3cVd
         DgD/J1Eunr4Rzl3ArUcKrYYReAcBvpYnTcVERrHmJysJZAQjcXb05E6ZZkQ4iorl4y4L
         at9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSt+oLZruLTlTXM2zqVx97J62D2SClA9+ldMTqvqduoWazoYaQJIELJWzKYbF1U+Wwwm/lyNcC@vger.kernel.org, AJvYcCXhtP/viNl51tjv+FejQsKqWZsUXWB9Q3DM8UiuDRByT4mDcogKcLkaoyiYwRVXHcA+Li8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyckvJksAqeVABSj+vc/HCx/RxFCNPHh/bCOfn9eMEtOsRlUfSq
	V+O0Sg46U01i6Due1/4Z088hzBktjJLGnHdFQjyLAqW3XNwfKaNOw8Hq1bg+xwSPqtzOUqHidoM
	oKHMGilLdln2Wy3n82BVDSZAIS4Q=
X-Gm-Gg: ASbGncuy53cJD4GUeV0wXz3+J7liRc+6NY6zv1O6oSHTBE51BIHud/jUD6zocFAh4cE
	TaTHJM30JA9hwCClC4LKhCHku5+7unhijSGkQh+TgFo/ReEdH/76s4s5OVsCo2xEO2rnwgIiaXQ
	fWl2k2dw7sh3ByBfwtR2tuBlEQpwSLB+daUYRX
X-Google-Smtp-Source: AGHT+IHdBCvqQXZzDYomPgk55GCxp8UVjtV4CQ8xrapURgs4B5z8euqZezmpznKTnioXbjbWqdFdwFvwxCgqny1kEwE=
X-Received: by 2002:a05:600c:1e8f:b0:43d:683:8cb2 with SMTP id
 5b1f17b1804b1-43f3a93f78amr158399225e9.14.1744736742921; Tue, 15 Apr 2025
 10:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415163332.1836826-1-ihor.solodrai@linux.dev>
 <3cb523bc8eb334cb420508a84f3f1d37543f4253@linux.dev> <02aa843af95ad3413fb37f898007cb17723dd1aa@linux.dev>
In-Reply-To: <02aa843af95ad3413fb37f898007cb17723dd1aa@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 15 Apr 2025 10:05:31 -0700
X-Gm-Features: ATxdqUHcb7bcMj8apUeK-XfKrRx216OshBplciVzk_clunJ_ecSIlG9tQ2HJ98g
Message-ID: <CAADnVQ+5_mqEGnEs-RwBwh7+v2aeCotrbxKRC2qrzoo2hz_1Hw@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: remove sockmap_ktls
 disconnect_after_delete test
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mykola Lysenko <mykolal@fb.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 10:01=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
> On 4/15/25 9:53 AM, Jiayuan Chen wrote:
> > April 16, 2025 at 24:33, "Ihor Solodrai" <ihor.solodrai@linux.dev> wrot=
e:
> >>
> >> "sockmap_ktls disconnect_after_delete" test has been failing on BPF CI
> >> after recent merges from netdev:
> >> * https://github.com/kernel-patches/bpf/actions/runs/14458537639
> >> * https://github.com/kernel-patches/bpf/actions/runs/14457178732
> >> It happens because disconnect has been disabled for TLS [1], and it
> >> renders the test case invalid. Remove it from the suite.
> >> [1] https://lore.kernel.org/netdev/20250404180334.3224206-1-kuba@kerne=
l.org/
> >> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> >
> > Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >
> > The original selftest patch used disconnect to re-produce the endless
> > loop caused by tcp_bpf_unhash, which has already been removed.
> >
> > I hope this doesn't conflict with bpf-next...
>
> I just tried applying to bpf-next, and it does indeed have a
> conflict... Although kdiff3 merged it automatically.
>
> What's the right way to resolve this? Send for bpf-next?

What commit in bpf-next does it conflict with ?

In general, avoiding merge conflicts is preferred.

