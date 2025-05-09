Return-Path: <bpf+bounces-57891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CBFAB1B60
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 19:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680C04E6033
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 17:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260EE239E86;
	Fri,  9 May 2025 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf6blenk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145AE2397BF;
	Fri,  9 May 2025 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810712; cv=none; b=TD/OyrCbXfXY5xsj3cbsk09D49moONIx0ftdawfha+X8Lhx/zZubhw0v7MIrkXMSpMrMlbToEkzq2Ub9zRW4nZ/BTZlyPc6s2eov84bhYmHG3z1nsWT2dn2LzLW7JZ1ZhuVOH3NC1vb+ybF9wUFzpdSy2VuluOUdKl2/okRvBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810712; c=relaxed/simple;
	bh=pfQViYo/nRzxZcTZocaRc3EpcPlVpggNSCl92rIMPtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TG/cykJ0xdKesjYnOTK9ntWWdhsBuLq+1sBXik5h2ZQs6atmWOoxtPl3iuBUTKK5f51vfSy4WcZDhTG4xnReRlZcgcnUoM6PNmgJtSpM/mqiHul8daTzdil/oEq0l2gpTLPH9Lonakc738VRXnCgCoIYUsmDQCjUX6FJE0WaDlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sf6blenk; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a1d8c0966fso1130276f8f.1;
        Fri, 09 May 2025 10:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746810709; x=1747415509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QUp7X96uaciaB3lV/3LzKd1Rk93vjwLaOeUmkb3zXk=;
        b=Sf6blenkOk9JbeXixYYXDhtrMaf/rCGgzIktpAfUOnLqEDkcSCqhdWXUlsij+mSWXC
         lW03nHq7bbuZvXS2sHzfEDjWQP/c86SghESAcgBiggs2PSxSAR2Ko3rOgughqKx8fIbp
         2sATxH5+C0qQEs4/QGhlwh0yYC1GVSgw2Zf4/PVnZO5t9YPX9AFC4Uil/NOvcWbNFYpM
         GsvUS6sYxFnLf6O8bRH9srkg9yryShRq7fGTeklVplq6FF4jIWaJrB7ijUwR+Q1B6MGv
         AZKri8PubCbOQbbhiQyYNe/yqOQ4Vn/IUz04GM1vaNJg7XwJb26J36xqLqv1rN6OosfG
         BK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746810709; x=1747415509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QUp7X96uaciaB3lV/3LzKd1Rk93vjwLaOeUmkb3zXk=;
        b=vVpC/KmtCdLUA0QwYYA00kMpr7FbdBZpPNXnv/OVG25OKoB3yfW268ln0vIt+Bs4/n
         JlTGYWBiuSohSxiYSHi+v9nYQ7jYV3hNqYpmIyinhXoo6rZUKt+hXDm0dOF6Gncixqi2
         jcgKne3aUU8SDzwTxtho6764MddKarNYD095B5Ll1Lq+Pyr/yPi2MPpo/TmVdIzbKF/z
         XIlT4XA6HKNpdAVU86B20wp+2lWKSaube2tGO45/2nj2K6zTNZvuH8Tt9LNR8B6a2VX9
         2878M0GuRzhrNjuf0IC2Y2guo0XuxeECAFbekzgy+aNquPon0i67arwL4nxsPed6GOGU
         1n5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVX8QAg1F8rDYh9m+KKcEPjMg8Bk+/MiqaTjrpAnCHXR6k8kEo7S40E9XoF/D86YwjfoRc=@vger.kernel.org, AJvYcCWZ0zrt5BenloNhnO5bk3vAFX5PvZ6iTl74z5wKAHYJd4WSh26bsPfQiKDVR/Tcho0Dksk62ABLjEWCpgXs/shb7AZc@vger.kernel.org
X-Gm-Message-State: AOJu0YwkiPDWZfh6R5kPSjh2pCxLyhuyDQHI0T71wYHXjqPHcck56G16
	pzfj0zxfOuJ7hLA2hxX6smQhb0a6CXjqdMX9sNZu5CROBmSnExppwvfDfySxZ9svBTKZSgKJV2K
	i9sjVN1numCdzkE2wjEQWou2AKdE=
X-Gm-Gg: ASbGncuDIEFg3Hb/l/N4QAwS6PK4oiIcBrporZqQa63Hf52HsdGyNAR5jU61Nk77ldI
	dZL+OoUCv6e4b4Yb6xiJoF7lNoKGJhZqVOiK1mg/v5IL4MxYR1352+lMveVkSwOjX7/K6J2Ab2J
	zkvYE+kPqXzDPC+lK5N8HznChGur6J07dEmWUiQg==
X-Google-Smtp-Source: AGHT+IEhfS7XxQ4K3gEwHah0h4zkgO6NZGR2+v6Kauop7yoH1fZOIVCY9IrlqKAxYgftKkGwWXNIvhovpyZXun4lmKg=
X-Received: by 2002:a05:6000:2203:b0:3a0:7c91:4aaf with SMTP id
 ffacd0b85a97d-3a0b9941c6cmr7074630f8f.19.1746810709170; Fri, 09 May 2025
 10:11:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509164524.448387100@goodmis.org> <20250509165155.965084136@goodmis.org>
In-Reply-To: <20250509165155.965084136@goodmis.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 May 2025 10:11:37 -0700
X-Gm-Features: AX0GCFsa-Q-FOt9uvoZS9muWJ9x0mba317wJL-iHEFQnwaPE0aMl0u96PaOg35E
Message-ID: <CAADnVQK=_SdbJ7WE+pP97aZQ5-EUN4uOc1GyMkLv3wUr5KiSPw@mail.gmail.com>
Subject: Re: [PATCH v8 14/18] perf: Remove get_perf_callchain() init_nr argument
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 10:07=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> From: Josh Poimboeuf <jpoimboe@kernel.org>
>
> The 'init_nr' argument has double duty: it's used to initialize both the
> number of contexts and the number of stack entries.  That's confusing
> and the callers always pass zero anyway.  Hard code the zero.
>
> Acked-by: Namhyung Kim <Namhyung@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/linux/perf_event.h |  2 +-
>  kernel/bpf/stackmap.c      |  4 ++--

Acked-by: Alexei Starovoitov <ast@kernel.org>

