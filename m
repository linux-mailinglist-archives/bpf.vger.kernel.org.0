Return-Path: <bpf+bounces-63964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34D2B0CD59
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 00:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F605446A4
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 22:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84645242D71;
	Mon, 21 Jul 2025 22:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ25C3R9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63BE8F40;
	Mon, 21 Jul 2025 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753137545; cv=none; b=AQ8hbBop1F4mrwDEE95kkXfwXPsmGFb3D7vK9TxYXGSaf+kihUIQRQqVIHHk4j2xiyB62OH9/QdJICC8NSsUbR2t152gxKGjq41ts0jrjGdMeL4qqi34OG3Vrj+GLdd25KwqDQ58kiDSnv/rqlOetd8OpxMWx59bEoPZWh8BwrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753137545; c=relaxed/simple;
	bh=UbpXCOpSVnI6N9IQrEqmNGNfsdb/u83IjJbbivKICtg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VWgIKTDceA2pW53rtbqMH5o0GiqLjAIDILZAD1y2S88SrCIGhrybkm0xh3qjhmyA/2/q939hxs1rr5toKUbZzpH2W1O+i+hPQ9tQMGAMhPpeQ6kQUS2YH7DLT1Ymd6+Y017YU63metVZdKqRLc+U0/s6DVnxl7JqiONr8LE8TaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZ25C3R9; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74b54cead6cso3100835b3a.1;
        Mon, 21 Jul 2025 15:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753137543; x=1753742343; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+flNOTHZGwl5tQTzAtuKBDIQ+jwApZ1+t8fvYYT5Rs0=;
        b=bZ25C3R9ga/ThlxFm5Qo4lyiV/eTaHB9Mopl5IyI9CFcOnAye2jky9ETWkbdgjlXws
         CT9uEmFWTA+WYaOqWD8izWu3nBxItkiau+Pv7fv+Dh6YFQ74By6+eZ4S360bNSiwXVPE
         sJ3p3QpmHcCWHHbG33JvCYd0ohw8Zjek5MvVZcd4W6YLk9Dy97AebJxR5Yf2xOmGET6T
         Pt7qXgC1Leybf9J4cHYwHoCPFfcQOzQiA1kX/CAHZFH98igJXGvFXyYcmeg5aJ0RwirP
         QE+FELokSTUGRvLiu73bNck7wFO6ZFRYlcOybss8zHVZd3JweH9Myt/A6/KHX0hbYErI
         G9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753137543; x=1753742343;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+flNOTHZGwl5tQTzAtuKBDIQ+jwApZ1+t8fvYYT5Rs0=;
        b=I/PFCFLoeTy6i2bWT7ZGXm4Hs1wlqk8r8WVw7Viti0ux70D0ghFt1C56b7tL//Ba9Q
         Ewm6a2XHrHppWtIMl4tHBzcBjYvo38crwukm/hnOrssci2j5PO32CpD74xvU0e8Fr/Hx
         /quQtGhA5HuZjuOt4gBvdPT8F7PrHwCmdlPtc6vx+AfZp3ZK/ZZgGVfT7JcGbh7TwZXY
         M1vWibYV/efOz12QRUneopChjKEf6POWeCWmPhM+MYxZjbB8lPsoVGorTvpEhz7v2Mp5
         hU2UYqovI8XZj/CyUxvL5Vlion96V/OAOCUFRvash8NDUVx0tCKGoSisyVDAh+FCVc8c
         ICAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8O9lPwTmiBr/0bcDOJaCYbsBIj7zIvxEvMbM07ARpcHwsxqSIIFS1+YTqUCQ7F30OugeOnZOh2ajwW2q5IzNf7scY@vger.kernel.org, AJvYcCW6EcTO05DX5uXPp1lHNPfWHPGGEkhqTYwDpiAldNecMBIXqfYlIQ2eaj5nng9Fov5sT7EGqpxA03dnG2dK@vger.kernel.org, AJvYcCXWfLKOPu+AfiotMu+gOo97e8PK0t6ZEmfQLiVZapnYGGapRNtI0NbYEEL1PAIMZq2qhWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ67HJ0/cLJzTFnvU6urWZBCKq8owf1TkeQKi1lkxnNDyH28ZJ
	uI0xisN8ldUhLb3fGT+eqST5A9KbYJfCruH8CEyG5V8de/P3m6586n2l
X-Gm-Gg: ASbGnctNwRO21Mc8Gq8GxAp8XVaezTYS3WFOeZ0Tv7whBxsgwdFJW0EBQXv4g2U2cEG
	nKf2scAKFKJ7tZaR/7QdEjh1jzp+IgLMbqGkzNbGUGW7L/FeBAxyvw/EaskaGRdUTcpDrOkTPWY
	Jsav93b8HZ0K6tJxXIC6wgMgLQqC3jKFc9CnRNO/STd7k7GAlapEsrlDcHhwWBCSnPRcfjrBece
	pwgNo6C9O8xdsMkWEX294URHLD3jf5h52bNXL1C/dBNBigN0NdJDbIGz1RwUzF9dt9q5x11GZX0
	Ao+th7ntsD7B6vKbkEe0qqGdn4+8SlMEitmj71R49VUAzbB4bQFPdimAuIz38e9F+6Qbo0IYCwu
	cM4qw9kgPYt3H84D1tXByoyNCBAeQ
X-Google-Smtp-Source: AGHT+IGHuL6EcqmV2YbTKaTZXfPkI9SvE9yeb5FM/NP9QXasZt5olfZKPRuC/PrXh8bdWBDrRNYceQ==
X-Received: by 2002:a05:6a00:2194:b0:742:a111:ee6f with SMTP id d2e1a72fcca58-7572286b05emr25926354b3a.10.1753137542824;
        Mon, 21 Jul 2025 15:39:02 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:7203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb15761dsm6393291b3a.67.2025.07.21.15.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 15:39:02 -0700 (PDT)
Message-ID: <ac8266f19ecde10a49911192014dddf35b3b496d.camel@gmail.com>
Subject: Re: [PATCH PATCH v2 v2 2/6] bpf: Add bpf_perf_event_aux_pause kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim	 <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers	 <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, KP
 Singh	 <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>,
 Song Liu	 <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend	 <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu	 <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,  James Clark
 <james.clark@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, Mike
 Leach	 <mike.leach@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Date: Mon, 21 Jul 2025 15:38:59 -0700
In-Reply-To: <20250718-perf_aux_pause_resume_bpf_rebase-v2-2-992557b8fb16@arm.com>
References: 
	<20250718-perf_aux_pause_resume_bpf_rebase-v2-0-992557b8fb16@arm.com>
	 <20250718-perf_aux_pause_resume_bpf_rebase-v2-2-992557b8fb16@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-18 at 16:25 +0100, Leo Yan wrote:

[...]

> +__bpf_kfunc int bpf_perf_event_aux_pause(void *p__map, u64 flags, u32 pa=
use)
> +{
> +	struct bpf_map *map =3D p__map;
> +	struct bpf_array *array =3D container_of(map, struct bpf_array, map);

Verifier makes sure that p__map is a not null pointer to an object of
type bpf_map, but it does not guarantee that the object is an instance
of bpf_array.
You need to check map->type, same way bpf_arena_alloc_pages() does.

> +	unsigned int cpu =3D smp_processor_id();
> +	u64 index =3D flags & BPF_F_INDEX_MASK;
> +	struct bpf_event_entry *ee;
> +	int ret =3D 0;
> +
> +	/* Disabling IRQ avoids race condition with perf event flows. */
> +	guard(irqsave)();
> +
> +	if (unlikely(flags & ~(BPF_F_INDEX_MASK))) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	if (index =3D=3D BPF_F_CURRENT_CPU)
> +		index =3D cpu;
> +
> +	if (unlikely(index >=3D array->map.max_entries)) {
> +		ret =3D -E2BIG;
> +		goto out;
> +	}
> +
> +	ee =3D READ_ONCE(array->ptrs[index]);
> +	if (!ee) {
> +		ret =3D -ENOENT;
> +		goto out;
> +	}
> +
> +	if (!has_aux(ee->event))
> +		ret =3D -EINVAL;
> +
> +	perf_event_aux_pause(ee->event, pause);
> +out:
> +	return ret;
> +}

[...]

