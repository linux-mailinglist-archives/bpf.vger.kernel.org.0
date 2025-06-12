Return-Path: <bpf+bounces-60486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6113AD7792
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 18:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21433B3FB2
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 16:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2F029A30A;
	Thu, 12 Jun 2025 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7DolH8a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AFF21FF44;
	Thu, 12 Jun 2025 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744107; cv=none; b=lFaQgs5Yk2LE3W5w/fJYAH1H3w9N4VgL+fFkxV8xMBw1HEwoh3EFrAu8bb6oWwpnTpMiOM08REg/OxwyZRYn0sZHt3xZ5XvkcbL9KNqVSSJla6v93+1wryGKnOpk7bd1R5fETZOrIF/BCtDPO4IbPdgcyfBWhOwLGnfoS0AtyTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744107; c=relaxed/simple;
	bh=qPLi72+ijewVFMB9GpJlxlJPQWm+AQsjprKRy9tlzQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lu9JS6fxTEuNQJQ8IbzpjMCSi+sK5jDBCeZKhfWQIonLF1V4ohfrQ/L7IJmXUYjGcZBcMgT0oDlQbu4tcHsqR8HEivgQhBt6P5R3YMmQR4RG34mEfGkLNwVt1G1FvrJRrzNfBeG8FkNS1Lp+9X2wQup0GG1Zz4GjkT1ANnHwOeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7DolH8a; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-451d3f72391so15276845e9.3;
        Thu, 12 Jun 2025 09:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749744104; x=1750348904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAINP8jtfwBf9f7XazJfnbKKWrxfgv/Nz8lT6porDs0=;
        b=R7DolH8aSJdu7hbU5hq0mlsUQz5fJO/woYrY5vxh51+CFjgHj8cgtuzFTxTfluDAUo
         88eOlKMIOWytreTefzXVtapLegAajgaX8jS3E6JdL6A/oYc6MQaAWpipjfgQIdpv3Sps
         SmVi7UeIcW7ZKqZ9GfI0bPkklJBYzEQyoa0YcuqGn4XyhlHjjjSt3KHAeaoW/FV61yg7
         j9bl393ZPDgQ30xmmzo5N+p/uf2w5C2YnSrhsf0yW6LNmTGGf3nvdDWnc5p4O5Q8l2PB
         EKPL3gzqiecDtURM+6m3YNoz+/NNRiH7n8kXrjf4HFoJdgpblYQHQDrWsnyuJxL4qTah
         wnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749744104; x=1750348904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tAINP8jtfwBf9f7XazJfnbKKWrxfgv/Nz8lT6porDs0=;
        b=Wpg8STiQHROLzcKpYB6w0+1NeAkMLFsxwZjFrtqy/QNje2/wRp90BM5rEcjFzhLSas
         JEduYfvrgBEN0bhQC/fj4nqZdwIZ8k5Ed8ynw611iAwZD9O5Hr3ccJiqSU3eIqT7/qk1
         3Tg3sZWojAz8/3MnszduG3sh4z2muoFqKvJxcQIkSb26wCmMN5BufWRQMpiIikvaXvnj
         KqJ4lBXxyJe80pgRFfR2EVeycoYf/5d6gW8nF6Fs6bIb2Mvvi9ypNJaReaktJzFmSpv5
         k7PQrG+m/q+bBqJ168SJ9ARG5jV0fMLSWSBT0z3eVVYhKUCQciO4TaoLqETh/gwGOPP5
         lZnw==
X-Forwarded-Encrypted: i=1; AJvYcCUJDMiy8WrqEdX2xXgj9bqZzWc8fucnDzWxqroUfVLaFQUc+JRP+cjUJ5idA7BUM+W/fUSPmi5idSSD51N7PUI6U9JP@vger.kernel.org, AJvYcCUweeI+YJZdTr3bXA+koxQu1ST/D4gl+D1jSft6eTRDxO1xS+1PSCjSqKoKNFKyg8iJIzA=@vger.kernel.org, AJvYcCV2qlzH09LEKW3h/2in8pWcwsBZbcra1v83RKwcbrMH6kjdcXSWP4ZSgYAZlkBtiFxe8ZzayEC08TsH+M4o@vger.kernel.org
X-Gm-Message-State: AOJu0YxRyHAbpmhN5hTR4pJfXPFLTMS/lCHiWJIQeR5CL9zg4ZE3vEHs
	MXgIX4Y8X8LOltK/3/EkCBBCMaHSd04m08JpgZNr0LZAWZ5i+4wCXI4b4lSTfYUICop5/7Iy6wP
	lE0dVA6m00/LgpSIzPczFNaCcPBBddJ8=
X-Gm-Gg: ASbGnctDtlO0orrtG4xgGKCxcMxdhTCryVWuxPsRxGH0Yt670YxYLLnGe7Y3VBQbSgN
	fd7XZF2TA8RCDPGzm5OXg5blIJEZXM4W6/ILINyTzOhdEYJvL5FGKE7TNArU3boKBohOR8ZzPwZ
	nuCeUA4xrgzNKQERcq1qSyexL8dPfyYjEsdYF9YOq3Pu3QkbAh4HlR3ZiS6hmcsrBWTGEINNiy
X-Google-Smtp-Source: AGHT+IGZzhesiBoAhBd39t5QJYl1UUrRhXBUdg7MMGUvES7xlp8Qis/+Fs09ENPHIcLDadJQLNKz+xcAIjRafhGoUfU=
X-Received: by 2002:a05:6000:2086:b0:3a4:e6c6:b8bf with SMTP id
 ffacd0b85a97d-3a56080ac65mr3635985f8f.52.1749744103005; Thu, 12 Jun 2025
 09:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612115556.295103-1-chen.dylane@linux.dev> <20250612115556.295103-2-chen.dylane@linux.dev>
In-Reply-To: <20250612115556.295103-2-chen.dylane@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Jun 2025 09:01:32 -0700
X-Gm-Features: AX0GCFv7_UZZ46DAKj75rcN0J8jggt3SPwfPN8e8DTpG5j9BIlDZGybtAdZ_wxQ
Message-ID: <CAADnVQLbpO7PED01OVZXTLib_hBYzwpC5hFyR_WMCCx8obR1Hw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Add show_fdinfo for kprobe_multi
To: Tao Chen <chen.dylane@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 4:56=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> Show kprobe_multi link info with fdinfo, the info as follows:
>
> link_type:      kprobe_multi
> link_id:        4
> prog_tag:       279dd9c09dfbc757
> prog_id:        30
> type:   kprobe_multi
> func_cnt:       8
> missed: 0
> addr:   0xffffffff81ecb1e0

fdinfo shouldn't print kernel addresses.
It defeats kaslr

pw-bot: cr

