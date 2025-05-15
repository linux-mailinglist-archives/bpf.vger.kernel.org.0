Return-Path: <bpf+bounces-58335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6D3AB8DA9
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 19:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25E33B0904
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 17:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4121325742F;
	Thu, 15 May 2025 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YY3f7zrZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5661425A2C0;
	Thu, 15 May 2025 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329836; cv=none; b=szNZx/sdcx7snNPy4I3SPbW/M1nQmp79vxYpOsOFvA6z8ndSgRxOeh5TO+jCMXxRdItCr0Y1nFpo1vnLPC5TLLv3q6CnTek0xX6ZbQ6UypsxFNPr/YgqhlbI56xVSgaKD5naYj4jvVm9hC1TSl2WJbJifhX8FLPcaXMhtgWaxoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329836; c=relaxed/simple;
	bh=Vvo1U7ZYT/daKTt8DjPAQDotWCOV+WFddjhL4Nt1dv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crrIsmYNwpShqXIO8398fG3ayuRVF8FfHf7JsNtXkhcFGBf/MGpUaxzPgj2AUgLmYMSpiVO0kaEIyiiDvigiR7p8MIiE/v5Asw7l1Ra2aTKsWtpb1IkXDsOK5qbBWiY0N/YGONAPvWFtE505XkQGcjM3qYZxBhMe/53XF/JJ9Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YY3f7zrZ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b1396171fb1so670552a12.2;
        Thu, 15 May 2025 10:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747329834; x=1747934634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gh0S+6m9cMD+k8B9Y4/TUOEGe6CgAna/tacJfPKX/q4=;
        b=YY3f7zrZa/ctJSdsaNo+BY+qRdKuB25xD/9Q4BeJXWQHgSCnDbVYkAR3A8jatzeuF4
         l82LEVaXc7e1B6RTVrgCnQlnHnVmy8wSmS+jFWUyOtZxLUyQve7Oh1B7ZQJl8KAvMltb
         MFr2Sxl69jl/TKdyCSvhE0rh6g6oQZF2XSs7TxXnbPBtHd+9g7Wu4mmnRZF6VSuay1YS
         Dbvvg0JysH3mpE9NoM/RTqR78odUWH2RsjVdgECNGLtlEom/JSDnU8DXvetqtS0D5cdw
         UfI8yX6p2iwCyIkC4gAu+UIvYfMrqQ0GA7lokuJUSHeAOWrBwMJUr/pW9ObPhZbo0zAB
         AA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747329834; x=1747934634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gh0S+6m9cMD+k8B9Y4/TUOEGe6CgAna/tacJfPKX/q4=;
        b=Os1tD1TN2t3foUZYPl6OdIOMR/WI8GCs1y8hZEea8SCGQCclOrk5W4j1dTtXWT3DpZ
         5YmSOJQfgMSgqO8zLZKVOTmOa89UPxcx50dDd7IttZibdxTWmTYxox296Xt8OSlpq85L
         5TRG6EBnXFIc/Zf58rKrTKKEjNqTFCQ7vr2/FK3ru5TKqrrunTVuFcm2M2smXYVycUyQ
         eC/UMlfB1d5VN234P9hnRGhsDLf/uvlxAV5rPCJ/JhjyaqgbkXHPdChFUiR4NFm4tzBv
         12u/A3X2ST7md+DzZ9cLoloQ4Z3wf3luqtiEqW7r6YPjYh9pnHN2pVMW6NR6hrHvZPgS
         FnGw==
X-Forwarded-Encrypted: i=1; AJvYcCV3myr4iLYcKwKybiiyF4wGjoXnYh47oFCoxxdfWFf1KzER7a7Ryng7cJgX8QPsJU8l6+39pSdoQW5wK6x3@vger.kernel.org, AJvYcCWkBQctLP8l0je0pWkPCwclu0mNWAUZHY/mRqUhs937lWK6jQKVf97smfH3rqHwaE6K3Jw=@vger.kernel.org, AJvYcCX6/tklpUzr8Nm3WI4ce5ObXK6mcyY5GfoLlvvXamadOCZ4lR2FoIlqVCBTyb/K3q0Tzu87n4p0w6Ib9FNr3MYrylid@vger.kernel.org
X-Gm-Message-State: AOJu0YwV2MvPs/g/Kmea97sWyFObmAt9pt5uLeHpgu5PGydyhUQu8sIq
	LFMW8/YjayGMrcaXZrgPjGdOAIMNqzmqrbbgD5Hyf9FpchIl6zIwUVjn77WF0b9dM4/oFZr6UqU
	CH0Yof00Dsmq/B7NpvuTqylusicZqYhQ=
X-Gm-Gg: ASbGncvskfl2L5UEoSxFxpmp3cMkarYPi/+2sx1qLBFr0Ua6EwTHKQoM0RChZQ704He
	oqK/GVb/OZVNqSpOGnetzt8E48TBJSkoiJAum0jor0d7SaOMuK4y96uvzQZ5Vm3H2fD2xXhtBwK
	V7naxZ6YoJpWSH85GEhRijf5sreTb4kpy01SUePBxE1x4viZCH
X-Google-Smtp-Source: AGHT+IGjYah1/SPXx6SvyDN8o1y2ePsxsv6DqsRa6TTynY1tgHRXx50j1GQA3eXaMKW6GBvkqZrRlXXahJP3aUZaLb0=
X-Received: by 2002:a17:90b:1d48:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-30e7d507e33mr346708a91.6.1747329834378; Thu, 15 May 2025
 10:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515121121.2332905-1-jolsa@kernel.org> <20250515121121.2332905-12-jolsa@kernel.org>
In-Reply-To: <20250515121121.2332905-12-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 May 2025 10:23:41 -0700
X-Gm-Features: AX0GCFvOzYZGcJMq-FRiyVWwx2RCzFA_BSjewcyS6sZ2xrCVPeVk9qGOofZvUKk
Message-ID: <CAEf4Bzb0SMmKUXJic9Tqi9kLLRCwHPvd4f_9zCY26-5wC1vVng@mail.gmail.com>
Subject: Re: [PATCHv2 perf/core 11/22] selftests/bpf: Import usdt.h from
 libbpf/usdt project
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 5:14=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Importing usdt.h from libbpf/usdt project.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/usdt.h | 545 +++++++++++++++++++++++++++++
>  1 file changed, 545 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/usdt.h
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

