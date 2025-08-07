Return-Path: <bpf+bounces-65222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C12B1DC71
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 19:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8135809EF
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 17:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317E6273D8E;
	Thu,  7 Aug 2025 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Trf7IV+n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D226FA5A
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754587678; cv=none; b=WYGvVBDpfFb7X5LocvoXnsW/6jDVPE1ls9FxJ2W6vbHy6T0CTUaVDRPZYl5e9eGhOPZkRqGHV2+STBrzUCYG5FVC6mJRZZWSW+WaotZUiwTlAcZvRGYoJS2yxflJyAIrPJuajIFG3n2WJQtivlvaTaUC7Ihb7ayNKW1BuZ9Rlwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754587678; c=relaxed/simple;
	bh=i8iqz0ameMlIuvIUImuxAEg9/PZ5tSkWPhcqw0lCiak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+xkhowkbctZD3TlLwzX52QTNeRX5VRuB07APMua9XdME5d6SyarayN4lLIDdqb4anAXwCZzbMqsbHymtm2zrldmpi7ucJSd1+ycoEDmPIdu30cJqm3Xg69a4GZq8D+cTTKhBMtGVcVpEllS5eQgk36ngXD9hgX7UqlO40MyeJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Trf7IV+n; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b78315ff04so966625f8f.0
        for <bpf@vger.kernel.org>; Thu, 07 Aug 2025 10:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754587676; x=1755192476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPnWA+65HwIfpm2luHDdDCgy4lTx/1nb52TRk16aSl4=;
        b=Trf7IV+nAb3FKKY5s2eK0WOCA/HDipVpIPowT4DyP2qCHlyUpujZ0pMB4xEnB0w1wq
         D8dTqj5bgPifmVsUh1vtQNH10nN9C8TUYzgFxWZbWKhoaw15ICPjVkw1nwciJxdFBaFn
         HUeHoAvtVz9jvFgqmO0s7QEjROIVskuJRBPHIf4x2GYxvZcNLJc4RJuxmV5+kXCfUO1S
         hD5cj2mjNLaS7Fz1J6Ktesy8qrb5F2hdgcugKzUB4Dxn1QyA4p+ar5bBpfBXRg7NOEQk
         m7VVAouuWy6u5Hb0Uc0vp+vhqesrAuAS1nzDBWlTl2f7ESddSX44Q83fZkqq9V63hKMv
         cs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754587676; x=1755192476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPnWA+65HwIfpm2luHDdDCgy4lTx/1nb52TRk16aSl4=;
        b=NB8q/On/hBX7pxStpftWr3AlbgvUNK9FZe6g9q5/w1Pn1uwAq00OBYX8cJ136erDpW
         bYetmrP09ZVPZF/N5Vr0kA/JlbzmjugapX56+ELtfTKZ5OjDdaItqNY49hbnGlDvlb+n
         YIc1TjTcnK2AYsncQ68W7Fj8kJDv7lgBlfzptApsDzFmeGQvM7h3Df4asxBWs3PPDclX
         mJdns9atvKdbm4CVe0PSZNl4nz1YD6Dxwjc/u+JCztQfz9ZCXGdyPZGti01RZH/D59Ab
         pMdpWouhwK8tsbHv0mh/BgyNa/8M1hyhe9SOeu0bDqr1/7CgH3kpoQvv8oUaAQ+d0/fT
         WuDw==
X-Gm-Message-State: AOJu0YxjG/HW10/QGjEjbEbcOevD1TmR4s6yWaUHohebsB+TMGFQzx47
	FBvkUzfqEEQlC2/vRMt2dYzyIeClnAFNPBfzMuBF+oNkNQqXxd08Is+Jnwe5WfqsfHvC/c3RdMa
	gPgV1rUjM7mSyCND9GvKycg67PSYbmt0=
X-Gm-Gg: ASbGncsUhQpr15VIEZfh8TA9mn/tId/1Lo2SnoCh0fyk6v0Abej80bwAYWHZ6ZqE39Z
	DQTtKccuHfqDSGQjzNYMJn/Zh4M+MWpS4/Ey9TRPU/iWQHQrkVBP74Kzh/gFY9i5ADX3FPcTST5
	7PcYKUKm2NONor3W9mUROA0yKHeN7Zt711orgu+WE/P+tgR4tlOj1VzCu5a0YvJ72bWbndthnZE
	In6PxDy/vl7k6e/Qkzcs2M=
X-Google-Smtp-Source: AGHT+IEq9fABCFfiJjsUJAgkeb49Wll1XHDoYD14/OAMnkUHjxvxmCXXcpP1ohxvb//IZ8ZJ13GZBox4m5GiCy27MKo=
X-Received: by 2002:a05:6000:1448:b0:3b8:d0bb:7541 with SMTP id
 ffacd0b85a97d-3b900b783d1mr43384f8f.40.1754587675426; Thu, 07 Aug 2025
 10:27:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806144554.576706-1-mykyta.yatsenko5@gmail.com> <20250806144554.576706-4-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250806144554.576706-4-mykyta.yatsenko5@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Aug 2025 10:27:42 -0700
X-Gm-Features: Ac12FXz7k8ssJ8m9SMGnb-sTEpErLt6uB0O_VKLLr9kcBexP0VvHRX1iJCv6ZLs
Message-ID: <CAADnVQJy0tAj9jkLrD1cBFkLK-DayjG6uNGZ3OBQh4V5Zt=WnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: task work scheduling kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 7:46=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
> +
> +struct bpf_task_work_context {
> +       /* map that contains this structure in a value */
> +       struct bpf_map *map;
> +       /* bpf_task_work_state value, representing the state */
> +       atomic_t state;

a hole

> +       /* bpf_prog that schedules task work */
> +       struct bpf_prog *prog;
> +       /* task for which callback is scheduled */
> +       struct task_struct *task;
> +       /* notification mode for task work scheduling */
> +       enum task_work_notify_mode mode;

another hole

> +       /* callback to call from task work */
> +       bpf_task_work_callback_t callback_fn;
> +       struct callback_head work;
> +       struct irq_work irq_work;
> +} __aligned(8);

and
+struct bpf_task_work {
+       __u64 __opaque[16];
+} __attribute__((aligned(8)));

This is way too fragile.
A bunch of data structures in above are not in our control
and might be changed without any one mentioning anything
on the bpf mailing list, and things will break.
If all of the fields were plain pointers we could consider
placing bpf_task_work inline in the map value,
but with inlined irq_work is imo no go.
Indirection is the only option here.

