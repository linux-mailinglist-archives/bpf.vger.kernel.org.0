Return-Path: <bpf+bounces-70768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB81ABCE347
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 20:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832825481A5
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 18:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC73321CC61;
	Fri, 10 Oct 2025 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWcuQMpE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB683594A
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120242; cv=none; b=QKZ3EQFjhVbTXg3hdFVWqGeaSAOfCxEn8mRmG7VPgW/BZUAOFLblvXLCCDzPdoQxaBR/qNGgqkIRuFPnzy9mO0d2572LuJ9MnYMapSrULOM4/q/BmA7c3HJwqGr7Nm2qF9ZkibM0BagtFvZBnklSAuUXF65ZzGsc2FBiw7FK6Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120242; c=relaxed/simple;
	bh=jio/W8y5N4ApUkQniRwNsT6B5nPgsxKMES1OClPyBc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2k3/0njps3+ENCvdf0Yt4gf2N/cKf79V65hk/AJXRFsTOipoV6jzDAH92ItDTffqhhMwDv2tpoLm1RtRy1Qcz/R6lKm+7fJggD5OGz0OXVKv1hBHH/0BbbDiP5XziPCv2VrW101BdTNx6QNRAZSI+CTBPTX/TCo9La+Wwg4JBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWcuQMpE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so1463845f8f.0
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 11:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760120239; x=1760725039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jio/W8y5N4ApUkQniRwNsT6B5nPgsxKMES1OClPyBc4=;
        b=QWcuQMpE9zl0FvqDXTz2MDSLBIfeMvP5ANHbLSqFgZdUTSv/eg0QtUroCKTKgvfBxK
         6Bjzn8/Fb6ZOmU3hLjF0KdXlwaGVZfU8ZObx4O4iRSWsMx8HivtLKilMvFI8f+XQ61J3
         PW/0wgcSogNNz+jRYcpf3Cf2yxphKuffSC3GLvULRgNkOQt+mOSkT5x+4wSxkvYhWHkR
         b9Q0gdBU7gHWL+G5+5JrvN6A21TYVI66pM1mkHmGB49dx+C/+tAzJ6y83PZMqcefnie3
         hM2TOgB5pj+Bw8meylzoarOLuViMo8mhFlHppuyvIQpK1vwz6ajC8qzGWfBpdLRwvZ+J
         y1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760120239; x=1760725039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jio/W8y5N4ApUkQniRwNsT6B5nPgsxKMES1OClPyBc4=;
        b=VWkuY6jKH0/tZPg8nJvAFwsS70t4y1Dr4uGn5DK3eVCR64zPwz36pjW/veYBz/cg+V
         5MFSUB0WYSBWaGEx+zgsPW04TxgNJ5g0xdsiE1f8WWmFR0BBxtkVqSgPsZrHJTJjnnWo
         8o9e75QD1YawVvtreQPGvfCL7NakffhN+eSIzGm+Oj2qkUu469YU0Tsmy7dlvLmzV5td
         75mva/q8V+oEeWxnACpg4q5UM3R2vkHJ8y3saBnsO+WhmEyO4y1ZfCyNxfxaJGS1w4rD
         IP5sZDeiJGDJY6MbO/oVz5vzjEnfSOXw/+QaIqd7q2AblxBcy1HAgnV8BIHgDrLHV76w
         M/5w==
X-Gm-Message-State: AOJu0YwjDZS3rYRpst6LQFYdyGQ0MAq1u7t+h1A5R0GzpwSlG6H5t1IY
	5QiagzmSLlp3uUhDjgmZDmNK9vQV8mAp/dF14ti7Kr1snBKe+3yk1gbALSrgSb8WcaHukPY8LSA
	02n8JnBtAypjbbZE2KPF451Ly94RZ4r4=
X-Gm-Gg: ASbGncsfxtZb8daLIdixIANmmroUaBz6zBlxsZex2aCpCsOihoI2xd5z1MwwV52izS1
	LbmkSgEaNzqHgfCmgq+87Av1KdyAKRLw39T7epJwjkcDAjcnUarJUacUUWExKcpFrgkq5a3P93R
	auSQyxoj/7yldwTTUaUMzY5QlAwhnKxpYk7BsQPgDC8MTRQONaV8j91qOIkBUhvYrj4S86trYpR
	NGS6bfAYKDuvF9d/8uKUk5zbeqczFwHmg2cP6xwFA==
X-Google-Smtp-Source: AGHT+IG79W0TMmhN3TShs3gEVKTZi+LWuVh2ZHa0z6K1mrh5YUNuzMwgwVcwrfgiPl+Y6TlDScr05D3HyHoilV1ULnY=
X-Received: by 2002:a05:6000:290d:b0:425:7168:44c3 with SMTP id
 ffacd0b85a97d-42666ab9684mr9028936f8f.5.1760120238580; Fri, 10 Oct 2025
 11:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010164606.147298-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251010164606.147298-1-mykyta.yatsenko5@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 10 Oct 2025 11:17:05 -0700
X-Gm-Features: AS18NWD9RcfMlgQhE1jZcw9uFcCmb6SzMz7DUKKD1P0aQUqfRC9NxqQhYXnzYDs
Message-ID: <CAADnVQK4QKdg1CVRp=ZS704dtmxq9GEKOKxBkzX-fkqsdLDzVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] bpf: verifier: refactor bpf_wq handling
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 9:46=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Move bpf_wq map-field validation into the common helper by adding a
> BPF_WORKQUEUE case that maps to record->wq_off, and switch
> process_wq_func() to use it instead of doing its own offset math.

This was leftover from some previous version. I removed it while
applying and fixed the subject, since it wasn't correct either.
Please capitalize the first word in the subject line in the future,
and don't use 'verifier:'. Just 'bpf:' is enough.

> Fix handling maps with no BTF and non-constant offsets for the bpf_wq.
>
> This de-duplicates logic with other internal structs (task_work, timer),
> keeps error reporting consistent, and makes future changes to the layout
> handling centralized.
>
> Fixes: d940c9b94d7e ("bpf: add support for KF_ARG_PTR_TO_WORKQUEUE")
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

There shouldn't be an empty line between Fixes tags and the rest.
checkpatch.pl noticed it.

