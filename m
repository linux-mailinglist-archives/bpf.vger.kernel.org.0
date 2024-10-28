Return-Path: <bpf+bounces-43339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F31019B3C05
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 21:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5923286A97
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474DB1DFE31;
	Mon, 28 Oct 2024 20:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLcNMVAy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F8418E03D
	for <bpf@vger.kernel.org>; Mon, 28 Oct 2024 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148041; cv=none; b=aj81aUInCBc4gree9cMkG05TBXEn3FFCyozM3M+R2/JPDARQrLyEE20H1DyjciEwykDrd0qrPxk+NnN26Y0xhQtpiQr+/SqX7fEzShJxifTpA2Jx5cZdoSLq9zdV+6/czvUWMCO5zizZ05RNvy3+fXsP+b3CT/b7pu7WKBK3SIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148041; c=relaxed/simple;
	bh=9dz6xZ6hfPJdTpur8atS5MT/XDt9GvHX8LySPoDh2rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0zwZo6Fqo5h6XL1HbvXO1JJw0fzcUOBMZLi6H77W/CPJZ0r8OCSBFdeKl/wGpUAWdqSD1AVFGsmc+vXnqbIu98/fCSQPz3kiiPYNDikI2J/BBGV5FBVLOqTa1IqRpL0xr382T1Y8vQdP/vGNmWqVH5DFRu1iuxiYiocxRkbD6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FLcNMVAy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20ca03687fdso13255ad.0
        for <bpf@vger.kernel.org>; Mon, 28 Oct 2024 13:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730148039; x=1730752839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9dz6xZ6hfPJdTpur8atS5MT/XDt9GvHX8LySPoDh2rk=;
        b=FLcNMVAyAqQKGnTi1BRcKhCvvUHlB7BK4CjLqHQX95jI/7FvY0RxiIwyV1dfRn6ler
         S74l2VXo8jLVbw5l1WY5zVui7lwZbIBuGPTc4AiYixPKd2IopZMKe/MYQxUKT1q5fSyn
         yAQc/YRZw8haeehYxGtcYTN9G7cKermgcAfjQ9CmNongY2F5zkesn5DlcZIL0nI/ZaU1
         PZRz1YLNEjJK3fFLrsbVBdM+w3UAxrw6qD6fLrQH+X0MeeI58VAuRDGQMucBsw6ZwL06
         NsipFZI+Q5YD5l8lO5/K7qDHzWYF4WsyqsFAsyyTBY/rHBeWrqDtw1DxgI+/DN/U7pGM
         Z0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730148039; x=1730752839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dz6xZ6hfPJdTpur8atS5MT/XDt9GvHX8LySPoDh2rk=;
        b=F9L++SYUwfE0R7gVokEavw7xoOywgWjZdTtKPYVdzeDCK1rE2+yrJsGsojIwugK1lk
         5MoN6kvcBbExsSphT1hKv/65l3DcYL3zp3/7QxQ6+1Me/Hch/G3JFuXM6EaXJ9w4iXZu
         u44nNRX3iC71AdEKXsofDtBWNOJ17SkndWwrW4a/2aeVLFheSip8yVh6ukQfM4yzsiiW
         g3D4w4HjzihqPtTPVYUkHSHxsmfKlAPL/EJRHmcSrvc14B5J/WvED3mgxSp+GQLWtc0M
         Bsh3HCNUgpA2wfTXq+JLiJdoj1wzRh4i9fbfQS813oBYtwz1FJVVdOL1W3Y0TcVI0+go
         /EDw==
X-Forwarded-Encrypted: i=1; AJvYcCWexpOur/CjeMsaeustyYSwNnwItzXOhc+/ss1WqUjtq8vm/7KoDHo2+OAAvFccWxlhTlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxELxHWjxCfBNJMYm2mJi+NwoyLeiPa+IyEcvKirO/bGeiF1kJb
	y0WC2S+uwNhMP92CVmaIOgm7t3qdE+lCQXrylz6ltOQL5X0+j1+zZEMMvnDl7SqYMV+zMnVeUtQ
	B46OpKm/UDW4JmFWKzvShG20KokcGfAM0eusK
X-Google-Smtp-Source: AGHT+IGB1o9kvUvh/QFl8xL0rGLeL+ikmejkDsOlqWvJb4vUOzxHKYG5r6pGtIKwZsTh9QyBvhOiphYmOeU78cjIOKk=
X-Received: by 2002:a17:902:f682:b0:20c:5fbe:4e66 with SMTP id
 d9443c01a7336-210eb03e797mr82515ad.27.1730148039166; Mon, 28 Oct 2024
 13:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028190927.648953-1-mathieu.desnoyers@efficios.com>
 <20241028190927.648953-5-mathieu.desnoyers@efficios.com> <e18e953b-9030-487c-bb8a-125521568e9e@efficios.com>
 <CAEf4BzZgSPXyvtBZuB+W3fp=C8QYSHsd0TduxWE3Le+9e80-UA@mail.gmail.com> <588eb8e1-5035-499f-b19b-8b40a9877433@efficios.com>
In-Reply-To: <588eb8e1-5035-499f-b19b-8b40a9877433@efficios.com>
From: Jordan Rife <jrife@google.com>
Date: Mon, 28 Oct 2024 13:40:26 -0700
Message-ID: <CADKFtnT59wzKxob03OOOfvVh67MQkpWvzvfmzv3D-_bGeM=rJA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 4/4] tracing: Add might_fault() check in
 __DO_TRACE() for syscall
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Michael Jeanson <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"

> I'm still awaiting for Jordan (or someone else) to come back with
testing results before I feel confident dropping the RFC tag.

I can test this later today. Considering there needs to be a fix on
the BPF side to fully resolve the use-after-free issue reported by
syzbot, I may combine your v4 patch with the bandaid fix which chains
call_rcu->call_rcu_tasks_trace I made earlier while running the
reproducer locally. This should give some confidence that your patch
addresses issues on the tracepoint side until we can combine it with
Andrii's fix for BPF that consumes tracepoint_is_faultable(). I'm open
to other suggestions as well if you would like me to test something
else.

-Jordan

