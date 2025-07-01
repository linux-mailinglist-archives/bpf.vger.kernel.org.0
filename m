Return-Path: <bpf+bounces-61930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7807AEEC54
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 04:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF2547AB0EA
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D48D1991C9;
	Tue,  1 Jul 2025 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P49AsdA0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A37D173
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751335831; cv=none; b=WrSg8YSRjoPpM96tsb4a8wNbkY49GVpMaYyaoekcVjxEGepfGvgKv/r9X1iuLKb+scaMbGVwdTe1owA+ImsmebcHeNXD7zrHzAzykyVH1CVTcmmZc0cDmgrNTQLNdbGSj9ub+ROtFm6hI8CSqn0b+GprCgtQ4a5hKcJ8txtM+6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751335831; c=relaxed/simple;
	bh=chZSupA45hhC66A5Nbn69IBMjngEXaYkp2gQAo5xfl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVzdZ+B0rJJzZMcyZTHZLDnfGTTiyXRJvghpkl8ticpkzGkHYxvweGz8vdG8iDgxySKEz1CAZuxj8vBVCDVUVqL6a2c5DYqlAp9mkXAjcxhQ6uVz0QTr1ULPdduYppokN2W73d1oDzEBEbjOfR95Far4ZwK0+7AUBpUEVEDeH7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P49AsdA0; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so941957766b.3
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 19:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751335827; x=1751940627; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=//ycUvlATJpUfVbD8kzQ8AkDWoLdct992Z4BuFsvuYY=;
        b=P49AsdA0J0tDSprXdDXv+Npn4mQ9O9F1gdS+PPtbukTNPpbjUjQ8dg35LVzyZ0/GEO
         t2oZ9FnWa8Wj0UqKJFg3q4AZq2RRsETHQrIWNYvlSHS+cnR+FcE4T7FI3xe01XWnaT3+
         5qdR9+9g+RCrw5nfT0WfVte4cvQMSMQ7NkryM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751335827; x=1751940627;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//ycUvlATJpUfVbD8kzQ8AkDWoLdct992Z4BuFsvuYY=;
        b=NnCp0isxM7phcsojRp7MuKCii7fku9IbnsW4xhRdrU3WA7iakuOcJ4SL9GNY6GRo94
         ihW8rrcif0Rxjj30ksYX0X6W8hz2yzzcC1eZ8EB7nMdzwHfgOJeDRSiitJCd4wY/Y6kF
         UA2k/Tla6R7zMuQqnqN9ZhiBXUPKmfEP/V+vBIGR72JwSjJVbgK0/QWuMMhWtE4UA/6g
         lkzVOzm4npuHgedCGbVcop7tEDgpJ5rtowfht1vyFIf6b9iuktoVZR9Dg9s1KRJKKaaR
         yNAyjI/1+2Al4bne42nBhEt2uPw9ggbPlWY5M/vhMMiYd/rJj7HwJ28EoeoE7DugMAFG
         D+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXLVq20rWUxTjMYVsp2g5e/wUOty+X2povDmvSxHgGSmHPVEnPiVtsJ4uS2U/OpkQNSQUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPjPTkJlBpgeVDL+Gqin5pokqsWyZnQ3C9OL+qXe5ngkPWpSJB
	LyuSZZ7VXHiMQgAyO4h/TtMEzEbTdZ4XnCEXFPLto7JFrJk0KJnu2x37UibCdBSVYHhd2dOhA/a
	2PThgbtU=
X-Gm-Gg: ASbGncvz/WxWeZ41iO8V04ISEmZsoSBSSuVFtLduq9DSA5yx3LsQYpI8YZ/XeF9Xm6v
	LYUZp288v8XbJLQNgYqsHPkByUUqEiOvLbG21N6UZNuZPDkhdf+vaEg3zKwuBbDn7bKi3BpAd7b
	QEpxjHZBXI4fwAS3OJ2Dskk60b1iWGJImE4hww0qyxGQLMUwvqbN75xoSKxS5Yb65s16Qs6eu1f
	xxZzo2RKBzAHrOdHx8iLerRfhoDHZX5onzb4in+McwOryyU4ZQtUB5qXbWTcUzTYwO4L0tWwyP9
	zG/bZk1dwHjwiC+7C0nLhctDI1MTv6/7d8H1OQN9QbN2GLgSuL/PN/Eppz4FJI/xU4u2t9Uvo+H
	M4lPpPVOhY5ljeWVgi9F2KFi1CQ2FbHUj+1OB
X-Google-Smtp-Source: AGHT+IFrKvv1Ln5dAjBl35ELsdDENdZ6Dq5ilLzW60GtmXWDOAWwB9QQi30fG5Jw5uufxiK0nsV5SQ==
X-Received: by 2002:a17:907:96ab:b0:adb:428f:f748 with SMTP id a640c23a62f3a-ae34fddfe8dmr1517493666b.21.1751335826699;
        Mon, 30 Jun 2025 19:10:26 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bbf2sm760556466b.129.2025.06.30.19.10.26
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 19:10:26 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so9768058a12.1
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 19:10:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPa+q+n4aMpwgS1ah74Y2ibkrdtbA8y+w94UPkpFKL4jMmV/Kpc7290xdRpKD+d2F3nZY=@vger.kernel.org
X-Received: by 2002:a05:6402:90a:b0:5fd:c426:9d17 with SMTP id
 4fb4d7f45d1cf-60c88e750a8mr13090570a12.34.1751335826112; Mon, 30 Jun 2025
 19:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701005321.942306427@goodmis.org> <20250701005450.888492528@goodmis.org>
In-Reply-To: <20250701005450.888492528@goodmis.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Jun 2025 19:10:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiWOYB4c3E-Cc=D89j0txbN4AGqm0j1dojqHq3uzJ+LqQ@mail.gmail.com>
X-Gm-Features: Ac12FXySn_pdB3lLzP12Vm5gk2T8ADap-82-V7Zr3xVfhtlJ2K8g-e3E8mi3zzI
Message-ID: <CAHk-=wiWOYB4c3E-Cc=D89j0txbN4AGqm0j1dojqHq3uzJ+LqQ@mail.gmail.com>
Subject: Re: [PATCH v12 02/14] unwind_user: Add frame pointer support
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Jens Remus <jremus@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Jun 2025 at 17:54, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> +       /* stack going in wrong direction? */
> +       if (cfa <= state->sp)
> +               goto done;

I suspect this should do a lot more testing.

> +       /* Find the Return Address (RA) */
> +       if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
> +               goto done;
> +
> +       if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
> +               goto done;

.. and this should check the frame for validity too.  At a minimum it
should be properly aligned, but things like "it had better be above
the current frame" to avoid having some loop would seem to be a good
idea.

Maybe even check that it's the same vma?

             Linus

