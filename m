Return-Path: <bpf+bounces-64985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D913B19D64
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 10:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2EF93B1914
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 08:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752BD23BCF0;
	Mon,  4 Aug 2025 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBhcDovW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1CB7DA6D;
	Mon,  4 Aug 2025 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295142; cv=none; b=nGb6W+BzcX44Rdp8iC72LyPt4Gt29vQcwGksoZhcAqO8qr1wWRFZcxLmgaaMGO9yBH2ILQ8nCM07F20nAyC7p45F4Nn9Uy2oDvJKQhOwjvKhijnn4j0DICVr2auh2aJ4sDSp2lLucaMsUz5w5rlxWLn9Qx6vslFmrE34tRYIasU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295142; c=relaxed/simple;
	bh=z6w/6xrZTPx1/JYccx/DkCW5CUjLt0xgLK4W0SJ94oI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPaX8mg0PWlDi6fdZSXXRwHpUPHWpoy0seOy2lNB5HwyNqK9aMlIxxRQCCdULJpGbypVp6KZ+NjOFa0esLaDnnyRR0vte2gqKA3zRVC+T3d/Blbsmb9STnUAW2e3SN1D1t3ctn8Yz9ZhipbUrKEr+awovYqyA7H7p1NRssUCtOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBhcDovW; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-615d0b11621so4861720a12.1;
        Mon, 04 Aug 2025 01:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754295138; x=1754899938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P6A9VOTXftwrZocPOuFJBF8MCGL/qg/z2FIpBCz4p9U=;
        b=DBhcDovWNYrjoOeTDt/02AXZ8dP+Dhd3QVhtdJICfB46Ma5zHrrJABoOy/sNMKV+dO
         38NxuJzgC3gojYFGklU+w3wbqrcew40s2G9y1hYDR27XXFNR0OAZg7EBT+N9bk3x8M21
         6CsNzDoraogx53WHcYnSoFr362WQrP3s8P09FvvPyRrLoVsWnU0aLOGvjP9wC7UYbtmc
         LDzecem/NMcDFNq/0Kv+JbJ5UzbSw0wbEAoon4gkpvkLnrZ2Ut26Hg0IHhjoSomyWn5Y
         AVr2LdyUiSYCaqi9DXFYJMZQXr1MCE2ZDY0ezQuN4Rl1is9hYKVkcy3+vr15LASEXLUo
         qNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754295138; x=1754899938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6A9VOTXftwrZocPOuFJBF8MCGL/qg/z2FIpBCz4p9U=;
        b=bHkYMiCibtdbrGxDdtXl/NR7DI6bRMKOlIrz9GYbZCXisKuo0rDQNbwRCpDtcx8UhE
         BzqxQmegWBZY5AQNhhao3HnEfy826NsI/clUpfCFDLtl7I6a/I4EGgu1QO/nmcsnXeCI
         PCZ00QugAtU3Qpg4S4u7iowyfgx7xBSpkGWlRhCLDQUvL4oMPWk6YMcTRhOW3KA61H98
         WTvKRrGiA7NLydEyJM7eYjLWyDl83avBkIwmEIYYIG3Emf7PZKF7hEj4KM+LRZploNwo
         5aUBLcBBEQz55Cx5MhUaJgSpLyekGVPsEy+QF8Sv5c6f7HfEwWsHhTeB/sdpPXULNRtu
         OKbw==
X-Forwarded-Encrypted: i=1; AJvYcCWEFvwYJz/cUWk5i4e4Dahz48ODK7gRmSft9fW1PN018ulvo+tvTTimKL5qvMjHCdSV8HM=@vger.kernel.org, AJvYcCWFkkPFz3OndRojIGyp00Hp5ORh7Q4hx3y72xQqjVWYRUaUnSi6LSNin2RvmmkRjfMcDIqMW8lRZqtjVLBUSDGaxItJ@vger.kernel.org, AJvYcCWpVkJR4jEq7WPVDh3NM4j0Wy45nI9Yz8wyaZPHr0ZdLIqe6UV+aFUXp2YU3vPRXIFZi7atXKXQpjHb1d/n@vger.kernel.org
X-Gm-Message-State: AOJu0YymSyD/NWOKfeXhecSxIkp6Lwt/QmLm3oPubnZXqKPUdZKWYVbz
	HaY17+dlQ/twBWjR8xEKkb7XoLePbarQaqBjVQYcttc4VlZIfIm3W7f6
X-Gm-Gg: ASbGncsqWwHA+/aKd1uY7uVDEQS7cZQR3HUawGY84BhF60lDWgJntCS5y+k1IbIy7rJ
	bFJSRJuUSrJtkf+m/1wnOzt4hT8cGWwqU9lCkfr+hI4B4Cob3HmYdOqJcUMBfDEtVTYcvcYq7Uk
	xxXia87LS/KO+jNKpJAVbEDNvySngLwIHFede0tfSldqFcadTmbelyB0X58FlONGHEBl1McZk5z
	hNs77CjgTXqC0vFFzNXyRa+bFPrzzZObGB1+t4VU4JZJuD79XTcL3dPNUUSxiY7KZIGi/WH2yoE
	h2Sbz31U8UzT2gJzvrx1COaVzLi1EBhiMIkrzLhGpXpbahwcrCyp+TexxhKUuQ3FPcJqwgRTf31
	6RDAILkpK
X-Google-Smtp-Source: AGHT+IFtC/x0epJl8duczwK3r+e004kzrcGl2Uf9DrilSxfFUt6RyIoEkK8qF040TYocEZDB+jdWjw==
X-Received: by 2002:a17:907:9446:b0:af9:6159:8826 with SMTP id a640c23a62f3a-af961599598mr430081466b.20.1754295137335;
        Mon, 04 Aug 2025 01:12:17 -0700 (PDT)
Received: from krava ([173.38.220.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e82bbsm698751466b.81.2025.08.04.01.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 01:12:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 4 Aug 2025 10:12:15 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC 1/4] uprobe: Do not emulate/sstep original instruction when
 ip is changed
Message-ID: <aJBrXwHESPRTpwYa@krava>
References: <20250801210238.2207429-1-jolsa@kernel.org>
 <20250801210238.2207429-2-jolsa@kernel.org>
 <20250802103426.GC31711@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802103426.GC31711@redhat.com>

On Sat, Aug 02, 2025 at 12:34:27PM +0200, Oleg Nesterov wrote:
> On 08/01, Jiri Olsa wrote:
> >
> > If uprobe handler changes instruction pointer we still execute single
> > step) or emulate the original instruction and increment the (new) ip
> > with its length.
> 
> Yes... but what if we there are multiple consumers? The 1st one changes
> instruction_pointer, the next is unaware. Or it may change regs->ip too...

right, and I think that's already bad in current code

how about we dd flag to the consumer that ensures it's the only consumer
on the uprobe.. and we would skip original instruction execution for such
uprobe if its consumer changes the regs->ip.. I'll try to come up with the
patch

jirka

