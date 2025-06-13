Return-Path: <bpf+bounces-60565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DFBAD80DB
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 04:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E609F1897E89
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 02:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62C91EDA14;
	Fri, 13 Jun 2025 02:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQwJHL/N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3212F430F;
	Fri, 13 Jun 2025 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749781008; cv=none; b=Dch6LbDiohQhit4tUz9+ky4C5qxrDkStnt9BTbt+PqW2yjrRYjFvGCBwBRdZmL0bbYANLL63NYt2FC+GJUDLKQj6Hd3EPIfIsoxEdwxaGx4yJrW/m0IaYqfjfk89eVI1wEwpHlL0RFUIjFsvxgny//N+fMT89M7WvyVrI46WyRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749781008; c=relaxed/simple;
	bh=iv8OwqKzlShArD3b6aBJkZ4kXGzHylQvt24nLByeNao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GuSy9GWa6yD5P86UP94cSe4LGjulwYNKanCvIGYIyycU/2+9qO6XmXyBI+4knvO4rjLYNgMwyJxGgM54HC5gK1BlJPgpZrRUDs/K+QFtYpxFXjEaXemVwTVJ9IlP3cOIJY0D27zetZC9k1ND51LeqfPcgKBUZm/U+/hUOQ74a+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQwJHL/N; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a5257748e1so1254908f8f.2;
        Thu, 12 Jun 2025 19:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749781005; x=1750385805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIH9ZoFeKAavAYNviPJq/jmpODduVMj46LXZJZk/FqE=;
        b=cQwJHL/NnmZyP9crgw+WiUZ3XhCBqbEkvkF6EwSwUT25YnLh4JwjGQwAljwWUX2LM1
         MNLK3v64NX934fux5uBnB9AI6MGrcXY2TtDC76SAjSeoDzNvlDU4PVPOgliDY7WnHWFx
         pgPFjf7t0MrCXdLwf9X4vJGWG/YtPRGXK1ogreUk/xof1ogN1UbgaYA9e+0erEjXUjLz
         7sSiTYxbRyB//oqoyvzPiu+eXlei9K7K4pA36hHhHFNIF82HghwWrpanH9C/vB9HGteF
         Bp7f7jLH/zi8MKr2KGLdhWnRD0drLa8pR7zmwp8iSndR8IYfqhgsQY60Wnq7noYP7Ti7
         +P/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749781005; x=1750385805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIH9ZoFeKAavAYNviPJq/jmpODduVMj46LXZJZk/FqE=;
        b=p3NHzNLVHkj/rcliR5Rey528I8+Nl2e64TNBa6Tm39X9ehvSLi3N3LYuR5bUvtDH4J
         GNI2oolTPwmRiSTTyEghgssjlwKGgN5ezLMaDiIdw7062ZcZQE9Qkem4hAv6fQwDqQrN
         GURHixLEy+MWBL3zDmwLa9rCBS+RiOzFVbAeT346gGrOKi8E4xxAsuOV7mFiUhDw1s7a
         g35UuqZKwka71VQlIBnVhv7DZvhx9fz81fTOpSH0tgD/GVdOTewBiPsBm2KQIKOhhhnr
         5jIaGiBssy55u3uBnMBnQA4HCwZGnUSO8w9KFwSAnCmy8TdWUD/Vdi59YNJSHXnUsRBq
         IT6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuj+1eEnzfLZSu9iSjwhhvwlimQNiTYi/VSxcCU7E5QlYkmW1n/d5PRgzjIcP2X/X8iTY=@vger.kernel.org, AJvYcCVEFi5qJhMN0wUbkjV/y5QCn9El2Wx9AKyPSKWgzkaMa4lDJQShue3QMc39a/cYfzV75mJ1bYMdAGytwOkV5yM7tH3K@vger.kernel.org
X-Gm-Message-State: AOJu0YxS6zV+Yw/a38C8NedCmWiMUXwLv95BBmdPdCOb8dJjiocuR3mD
	UOJkmZOwiuaQJsmB1obqnqIymOoZNFlrJLq/1U1dhHOvXyrH8OnCRC1f7lDhP44G8UKy75QaMt/
	RNnFm0P8bN485A5Bo9uDOEf8itxv7lrs=
X-Gm-Gg: ASbGncuPP5bXd8xBm32AGpq9rOMVo92rMs2yH4avhVkBjYN8wJ/3e6Vpq9TC4jrFaE2
	iHs1fM3pwEezESULRyVA1M1WpRvVWDuxlFI5FufN/WeH9qS5LRQqBI4v+gqa1hbW9gY7Zi+4CHB
	ELhopJtAPmJeGNyF3kF1/yB1lrM7khb+HbkayP+yNfDZ98U3Mdaw/DVCtgWGjo9M0SSeNGX7plm
	OG3yin4W6c=
X-Google-Smtp-Source: AGHT+IE3UBohRmxNY53rfDeHZhD16dECIZAcyzR7m+kSApXDomkBHKH67PzH0uHucp9UnGwZJ6LcjejUmdCjcZcYYSQ=
X-Received: by 2002:a05:6000:4313:b0:3a4:f7db:6ff7 with SMTP id
 ffacd0b85a97d-3a56878834emr1180960f8f.52.1749781004810; Thu, 12 Jun 2025
 19:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612182023.78397b76@batman.local.home>
In-Reply-To: <20250612182023.78397b76@batman.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Jun 2025 19:16:33 -0700
X-Gm-Features: AX0GCFukmSDK4MldUnXSNClp0UyLOyR-xCPLpLDprlAnhyzYf7TuxQvZ-qCCYZU
Message-ID: <CAADnVQKEosaLbpLg4Zk_CcDSKT+Jzb3ScKQWBA51vLHt-AoQ8A@mail.gmail.com>
Subject: Re: [PATCH v2] xdp: tracing: Hide some xdp events under CONFIG_BPF_SYSCALL
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 3:20=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> From: Steven Rostedt <rostedt@goodmis.org>
>
> The events xdp_cpumap_kthread, xdp_cpumap_enqueue and xdp_devmap_xmit are
> only called when CONFIG_BPF_SYSCALL is defined.  As each event can take u=
p
> to 5K regardless if they are used or not, it's best not to define them
> when they are not used. Add #ifdef around these events when they are not
> used.
>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/20250612101612.3d4509cc@batman.=
local.home
>
> - Rebased on top of bpf-next

We can certainly take it, but you mentioned you're working
on some patches that will warn when tracepoint is not used.
So do you need this to land sooner than the next merge window ?

