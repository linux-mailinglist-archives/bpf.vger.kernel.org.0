Return-Path: <bpf+bounces-39186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D453C96FEE9
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 03:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3DD1F235AB
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 01:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93CDA93D;
	Sat,  7 Sep 2024 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSIIw7Ey"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201272F52;
	Sat,  7 Sep 2024 01:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725671693; cv=none; b=p/OuLX4M0/RQa7Xarn1aP0tOAMzA+y4NwQNCw1kmQ3mo7ft0DRWNh9hp7efrO0TbnwqwxSWN6udc5f1nQqoDQ4x5L92HZUlDMpwuro5Mph5Vzh5csiloensO/QSwhGct1RqQIBnYUbkMlxMUXp4G9pxEy6vTn14Af1uXK6t8zlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725671693; c=relaxed/simple;
	bh=wmcJcp94EOTHIsxfCCd/OEk2MIpQ+Mrcl0KERmI/3FQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkZDbrWVrs7177uozx+3pu0T6tHTAxqBszb4KVtqLQHvJ3AT61liheXNnG3thVSpHSC8wwwQOAcIVZyAKq9JmCjQRYNv+Wxppvz+KLe+5fJQNBoC6U1tEP/yIIoS0gV927+BrlIOXQ0x/qxFY7XRS/GatV3kDVhiIejC++uZxZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSIIw7Ey; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d86f713557so1859177a91.2;
        Fri, 06 Sep 2024 18:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725671691; x=1726276491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvctePgCvAAzGhdjEKtvnHQ4S+uDUzziPkTzICuQLog=;
        b=XSIIw7EyrnRF0ZgZ5QBBhOORhd0YGfEMcc0igMzIALrxw4QsDS+CyEuG6G1Fs9svHg
         7RcqROBC3AHfkKhP9NhRPi8rE3lXjSAFQX5dvzoqaebwMAXlZlIognIxjLO0e6DMB4EE
         J14wYytts14k1qTfA4SyslIScjzKJaWbDwaixhkJgVVptDj39UutFZiVAHj2yevib4aD
         lEt2U6HW5uP8M0KETBCUHiHyHekhd6cdi5C7wzxNCUp4BT5EesYcbRMbUEqMniFZefmI
         Lp/GhqtJhjIMmhXn5VqgiFpRGaL4GqdxncXjLWFcNydTceaRsq0FLrqOjZvod55wvlaD
         grlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725671691; x=1726276491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvctePgCvAAzGhdjEKtvnHQ4S+uDUzziPkTzICuQLog=;
        b=U2eT1s+0XrT6orn2AfJg/A64aoMm0ikYmaiMdpMlRIKz4kDpT+C2qtgc/bYUEzPxa5
         /n6C3SAk8gvuC2/nUiDDwwPh//pOtK4J77JTMECxMQ2vZ4gjUjVU51x7wDs/ljwskDbg
         33dByNaYccEYfei+eeClX0oJVJKb6wCkP0svBMWHn1Gp8B6h+Bfna/D3n/ajhhlg5e7J
         eOu8HMyGC9yq+vyTahgNW4N8jl/baPIW3HwkSV1d15P64ARPBcasNl8FstXeRzZ1IrKW
         2EDVDnOyQlAaKeZLfzgdh+E/2hIjFNOYq6jBYNS2qVUnbQ47c7amuBstChERUMyaKzQM
         E1SA==
X-Forwarded-Encrypted: i=1; AJvYcCVX2QjE62YkBpp6breEJV/NzZolW/1uC4DT/kfDQRJeU8nAvrwIMqaM6pN/Jxr53zlNO2/+jdcE@vger.kernel.org, AJvYcCXeeKOydo7sTrZnj82/DWmGmqD7UTbu39Xf2pcR3tMXgc0I+rG5jlhC0Iubg4II9lQgtSu/0YB794E76bh6JUaR7g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YylWGlsfA47C7jCE1a4izLXT4JnwVbdwvbtuNlDRkMlT9krUuvN
	x0ywT77brlacjbH9tNx2wOx0yXdXUqIHoLwXc9jNgyDeCmonkcBNWlwJHE8wxn6uLLPfdzvPTEv
	a+H727TSXQX2sJIY7aNR8omdMsMI=
X-Google-Smtp-Source: AGHT+IGAP7bhfD+orgofgr5c6dOS8zqEvIXedwk30QSgrFLFirghlTnNKqM5cMNr7sr7WBgog0cu7T12FPQ9WptIZOE=
X-Received: by 2002:a17:90a:5802:b0:2c9:5c67:dd9e with SMTP id
 98e67ed59e1d1-2dad50139d8mr5252575a91.19.1725671691238; Fri, 06 Sep 2024
 18:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905075622.66819-1-lulie@linux.alibaba.com> <20240905075622.66819-2-lulie@linux.alibaba.com>
In-Reply-To: <20240905075622.66819-2-lulie@linux.alibaba.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Sep 2024 18:14:39 -0700
Message-ID: <CAEf4BzZv55t8jzUupK1_cMk9M46AHXiFc7KWO5y64upfkLc6Eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Support __nullable argument suffix
 for tp_btf
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, edumazet@google.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, martin.lau@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com, 
	shuah@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	thinker.li@gmail.com, juntong.deng@outlook.com, jrife@google.com, 
	alan.maguire@oracle.com, davemarchevsky@fb.com, dxu@dxuuu.xyz, 
	vmalik@redhat.com, cupertino.miranda@oracle.com, mattbobrowski@google.com, 
	xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 12:56=E2=80=AFAM Philo Lu <lulie@linux.alibaba.com> =
wrote:
>
> Pointers passed to tp_btf were trusted to be valid, but some tracepoints
> do take NULL pointer as input, such as trace_tcp_send_reset(). Then the
> invalid memory access cannot be detected by verifier.
>
> This patch fix it by add a suffix "__nullable" to the unreliable
> argument. The suffix is shown in btf, and PTR_MAYBE_NULL will be added
> to nullable arguments. Then users must check the pointer before use it.
>
> A problem here is that we use "btf_trace_##call" to search func_proto.
> As it is a typedef, argument names as well as the suffix are not
> recorded. To solve this, I use bpf_raw_event_map to find
> "__bpf_trace##template" from "btf_trace_##call", and then we can see the
> suffix.

BTW, just curious, is it a pure coincidence that I solved the same
problem in retsnoop with the same approach (see extensive comment in
[0]) about 2 weeks ago, or retsnoop's approach was an inspiration
here?

  [0] https://github.com/anakryiko/retsnoop/commit/7b253fc55b51d447e5ea91d9=
9f60d9c34934f799

>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> ---
>  kernel/bpf/btf.c      | 13 +++++++++++++
>  kernel/bpf/verifier.c | 36 +++++++++++++++++++++++++++++++++---
>  2 files changed, 46 insertions(+), 3 deletions(-)
>

[...]

