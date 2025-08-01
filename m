Return-Path: <bpf+bounces-64907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B59FB18558
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 17:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4BB562D09
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 15:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7538287501;
	Fri,  1 Aug 2025 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ev2Qd1D4"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC628150A
	for <bpf@vger.kernel.org>; Fri,  1 Aug 2025 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754063958; cv=none; b=JuovMR97FgZe//Vi/DrVjkzUHBjSHW4iXVG4ppVYwvbcgve3y1iSo9kCjDiH5rnMpTvbUkFPifc9a8hCBScwA1/p/ljgIchuROaBzI/P6h9VktxsUtr/Hc19xVrHdhatZXqIFwLKjtTOC0jqDS7Kn/vlwb7bHN4hzI1A7GuTH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754063958; c=relaxed/simple;
	bh=OWS+qszPxynxUdX7fOxWHDslTPoHW3w9/GGcefClUyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+erfT09DRBN9VL1aHYLjBdu10H2mBvMtFFpS7TCGlXgAashLBT/T7azmh9YNriewQ7iC+8YjCXGQOpE/6dys/XSBZfgPyb6WFihYpMlIvXSxEJu0E4053n+WRRLq+ieJLIHqTSbnIx0n/MZGqN8B3Ok/zl+y7r1apZS857LJ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ev2Qd1D4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754063954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWS+qszPxynxUdX7fOxWHDslTPoHW3w9/GGcefClUyo=;
	b=Ev2Qd1D4SyjFHheRvMyHJFaXULm7JVudBCeg4z6IVJDq352RhTR1mKirv2KsSMWqpQOJXU
	2c0oz98tsNlm+g2DA26a4i9pZuitZlsc3a0GRQxLG4mlUUbLg05rmBnBTriChDTSs99jG2
	j5J9qdi3KuYtjBCzzXghUDH+VbB3d6g=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-KxafpbJsPICWIzzxbTkQSg-1; Fri, 01 Aug 2025 11:59:13 -0400
X-MC-Unique: KxafpbJsPICWIzzxbTkQSg-1
X-Mimecast-MFC-AGG-ID: KxafpbJsPICWIzzxbTkQSg_1754063952
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-60835716983so2205520a12.1
        for <bpf@vger.kernel.org>; Fri, 01 Aug 2025 08:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754063952; x=1754668752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWS+qszPxynxUdX7fOxWHDslTPoHW3w9/GGcefClUyo=;
        b=Ik649mntrFHCB9qILxJcOcpTlAzatWys/Zkl73OXiTnQx9GTwXbwLFUf1Jil7jhhLD
         2lSp8Y+fTywrZwH5cnOx8LF+qdTAfQqL+pLQ5aNJDchagUtlYAvMohmWm43X5gg4U4hD
         +wTOL2BudGCcnXEBxASiOKoMBCQfxhNjcTpD2487SknOUS0mv0NTvw1AXXI/qkbSaUHS
         n5zprRJ5oTABulQvlTx4CmmaCGTR+88L/BSgui4Sf1VIdoYKgShIRFqOl4V5cFd6HEp4
         w8D4kLOw83VWFuyQVyZcajMl39YVa91Lh4Z4afTliuteZwVAW66PhFe9joES2xLkqDsq
         gaPw==
X-Forwarded-Encrypted: i=1; AJvYcCVj5vbw1F83qUHxWnGOzNqfrCWfA+CgnG4Y5TEQj2Die3SzIj4F60yzzZ18xCT/RyueAUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL6g1WZSX1s/gcmjItcjLXAhVSVV6ryFIUD9sVrGxWO/EppHg8
	RG3AaRfM/mSqijILICeI9XcwBoX5pVnxIQoZOrJtHKNBvyEp30sHq+VvpRTWjjCDLhDJTKTDenT
	ZL3iA70kQGvssoLc6+4/oDCy7EMPDUvnXIUf7H6heBwPZIRmiit/Ng7pNqg+DVemyIzSkts+FS3
	9/q6ptvowkeGvtFFv2YLv8lD/j9WbB
X-Gm-Gg: ASbGncs0aAi4hz/TLd5A7AiT1VmcwtE4A/Sw8EAWqNJf2zrrfONFVSsDRuaMzYT33E0
	Q5Y0wuPS7u4SXqmQ4WD32xXp+WkwGiWYCUfm/Kcg/iNH6So/JWeDIUAe/2U2D4ToTU1lgx9JBmH
	IQhLxKsLSHa+uWcL4Wk/WhdrXsRIyBAC1/Ji4Chm0TevP9LbIlS4Q=
X-Received: by 2002:a17:907:72cd:b0:ae3:eed1:d018 with SMTP id a640c23a62f3a-af93ffce9e9mr31675266b.9.1754063952279;
        Fri, 01 Aug 2025 08:59:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7gDLgqDRY4tShzR8qch1OHQdTeFZwbZn86L1VGXm8xMl9d9FjpVxU37mgy2WPfkCsyOBoNeq6AkntpSnGTks=
X-Received: by 2002:a17:907:72cd:b0:ae3:eed1:d018 with SMTP id
 a640c23a62f3a-af93ffce9e9mr31673166b.9.1754063951899; Fri, 01 Aug 2025
 08:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801071622.63dc9b78@gandalf.local.home> <CAADnVQLky+R-tfkGaDo-R_-tJ8E3bmWz8Ug7etgTKsCpfXTSKw@mail.gmail.com>
 <20250801110705.373c69b4@gandalf.local.home> <CAADnVQLFLSwrnHKZUtUpwQ1tst71AfYCcbbtK2haxF=R9StpSw@mail.gmail.com>
 <20250801111919.13c0620e@gandalf.local.home> <CAADnVQJnTqXLNT9YWWkpLqjxw7MGMrq_CTT7Dhb__R0uO2-COA@mail.gmail.com>
 <CAP4=nvSNeviiHg89L3dB9pGzi4Obf_s=bWJ8v89Q-fsJbuqymQ@mail.gmail.com> <20250801115649.0b31f582@gandalf.local.home>
In-Reply-To: <20250801115649.0b31f582@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 1 Aug 2025 17:59:00 +0200
X-Gm-Features: Ac12FXwcKBqQk5Q39rPaZjcF8K0IpRgeY7lVuPr9-grtekwZqZCa6oQn2sVe4Us
Message-ID: <CAP4=nvQEtaMY9t81ZzyWFtDzy+jVfQubotW7ypg-Kt9aoA-hbQ@mail.gmail.com>
Subject: Re: [PATCH] btf: Simplify BTF logic with use of __free(btf_put)
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 1. 8. 2025 v 17:56 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.=
org> napsal:
>
> But regardless. This will just be a difference of opinion, and I respect
> that Alexei doesn't want to use it in his code.
>

Of course.

I just wanted to point out this is (in my opinion not nearly) as bad
as what C++ is doing.

Tomas


