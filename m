Return-Path: <bpf+bounces-78000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 010D9CFA3F3
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 19:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDBA53185DF7
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A67435F8A5;
	Tue,  6 Jan 2026 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2L+cvjc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oUgA4ZzH"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B6B35E559
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721682; cv=none; b=MRKo1OX3KEAwKpjQym6BIdJEklTUsljRhSADzSVjfqBmJn1ASdx3e0B8VvqTSVhP89E54R3EfZXPmnc3LgFyxCuGmZs43CsqGAJevUSoGTqy2dc5j3Dd78RAsTvaEzJ5G6CtzAhjsjDFnVqfnM2PbuhcIthymY+ryNMtwJ4q/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721682; c=relaxed/simple;
	bh=ViV00lj7QgZuijk1QbwmF3QeewIeKfNhLoJfNv7HKwk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B6a3N68bBnzuo5/+2uf7McEV4LV6e0ubHfUMYCA84CuOJZGONzVDOlK5PmAQdWmXeg/j5f8p5sfmefihHQQRepu/FH9hTDUzzby7L7wM3vw+yilBUF1vefS/EkoLeNgxq+fFLUT+UmDSB6Cy4S9zBrTypu/AzeneaxVZjRcViF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2L+cvjc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oUgA4ZzH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767721680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJWDVsQrdjkI82W7XIRW9GZaQx38RzjOYQDx4fy9JYc=;
	b=H2L+cvjcEhsghpimg+v0937w511anwlPF7+MphCkRm82AnnMapuThpD7BxQ23woChZvf+p
	EXNjKwJGSmnJUdqholdK1xirLNO90t1gbey20DQA25x7g27cZdQ2lmjCsiROcfuhNsnJxr
	VeCWuaJ7oiiwuzPsbzewyWLyXyvVcQE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-S3dNK5iDMUOnZYixvhDJQQ-1; Tue, 06 Jan 2026 12:47:59 -0500
X-MC-Unique: S3dNK5iDMUOnZYixvhDJQQ-1
X-Mimecast-MFC-AGG-ID: S3dNK5iDMUOnZYixvhDJQQ_1767721678
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8ba026720eeso331901585a.1
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 09:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767721678; x=1768326478; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oJWDVsQrdjkI82W7XIRW9GZaQx38RzjOYQDx4fy9JYc=;
        b=oUgA4ZzHJqK9hSjfbITtnSapTt5AjtuyXhH6qFZFbohNES54kiaqtAnNQZKBGIZUpr
         wKBqHo59bdrPZuFIhxT2wQL8E+5AQxplAGfz/MgNx3Bx5p9KGp9CPDYF94BnACuqSz41
         HehbfY/uDPkMirPGmLMkMjGnGnrl82B4x3QJaOIGFS3tsYrqvj9mkS9uFvGqnJjxw7iZ
         yWvTvxpMfPpniEVSujjS8yAOH5k1bcz3SvKDUbtUYdzCM6TF34M3d4Y6ktcXq5g13Gls
         WuAf8ila4XZ60krrYNrm5O9x5T93BWfg8ANSmXYs/35+rf4wmkd4eTQdNvASuGhXgz2U
         QfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767721678; x=1768326478;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJWDVsQrdjkI82W7XIRW9GZaQx38RzjOYQDx4fy9JYc=;
        b=VRpJTEt9AEtr1jKQ5fg8ZfQ3G6aYdeLEQNV93vnE0pEKQSy9Hjdo4lEh8gqvw9/T0k
         +z4LMIi41mAGrFChVtvU7XylGqb2vbiuG92/6ldpXJiL9/EbsBQM/ofNyneldDfLn7ZF
         elhPV3FDUYdG/ADJaNIkoNMOStPiQLoYt1/m52Awmxbx+ioaRBr19Zthz3IRNlt+i4Kf
         gyggHKGmVbHy9do2kO5qcHypbRZE2YWyhacbqf3MUw1aS1AbW+Fnt1zmZgi7Xm0w2Ony
         0aeVEysMafWr7c1E9yJBMU5ERkkwl0zqEE5L0Gz0VLpEQt/LRRH2ry3e2/H7NyrM7KEa
         sgKg==
X-Forwarded-Encrypted: i=1; AJvYcCWbLyWplFe541Au9/pwQJnKS7eYpqgPs1oMi19H6yWIduZc9fm1ay0lAwfyzAZEkhBgdl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywWoYR7YWtdQY4jnFaaLAe+HOEqaXuWKiNAh0ZB9zhwUo6NWVM
	mTzQk203MSutmRG5J42L4/+FvjUNrWx8uBn3DGDQeEUz/hntR16HST2lxtvgIDPBAb+ZmO+9fkx
	Ta7W6eWujTDaR5vq97qN9OVrTmWHg/KBtSNjnKUlPAf5xLpzyWafweA==
X-Gm-Gg: AY/fxX4AGLkg2H05pe2sq41Re6t9TkwxA2FXhd7av+KWjV/6Guut8wxcU8ti4/E2oHi
	qB9gWuNlEkWcSIkkaL/wwwq73RI5QyR/EINvM5c7Q5ylgOOHefPTqWLR2AZ8ZPRAxThLZWM6YgI
	SXKkoU0d5dEQEbT8tMN4C+npHphwJufIq//RyuueYSUFJkJ8gLSY5jJdGnajItwZIOqKJOK2I6C
	bc3+3eFDscAI8gUJk6b99UbuwxfqwgtuIeqXq1P4hl+uregd0KOiRerQU9DKf/QIAQJJ0IhtvS2
	S3ajsdX1aIBbWM+g1X3yPUPayyY2SSSTuZ9eS8qfr/4b3mNZNjbFQYicrwUxyA1gij0U1dNpkAe
	qPwaO6ZYi8/fJloZnTJsyJyJLb66oZ+vRrKk3H4SYpA==
X-Received: by 2002:a05:620a:460c:b0:8b2:ef70:64f5 with SMTP id af79cd13be357-8c37eb9531fmr459174885a.48.1767721678537;
        Tue, 06 Jan 2026 09:47:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYhjDvwxLGXHNf6+LajgJjCf5rsdNaikOD40LwMHuIfDWWifrsAEjgFG5uPe7nk6mz2ZtTmw==
X-Received: by 2002:a05:620a:460c:b0:8b2:ef70:64f5 with SMTP id af79cd13be357-8c37eb9531fmr459172285a.48.1767721678151;
        Tue, 06 Jan 2026 09:47:58 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f53c422sm212786185a.46.2026.01.06.09.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 09:47:57 -0800 (PST)
Message-ID: <d40f598776e7995c9f1559514e89ccff51d91f9c.camel@redhat.com>
Subject: Re: [PATCH v2 15/18] rtla: Make stop_tracing variable volatile
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
	 <wander@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>, Ivan Pravdin	
 <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>,
 John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, "open
 list:Real-time Linux Analysis (RTLA) tools"
 <linux-trace-kernel@vger.kernel.org>, "open list:Real-time Linux Analysis
 (RTLA) tools"	 <linux-kernel@vger.kernel.org>, "open list:BPF
 [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)"	 <bpf@vger.kernel.org>
Date: Tue, 06 Jan 2026 11:47:56 -0600
In-Reply-To: <20260106110519.40c97efe@gandalf.local.home>
References: <20260106133655.249887-1-wander@redhat.com>
		<20260106133655.249887-16-wander@redhat.com>
	 <20260106110519.40c97efe@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-06 at 11:05 -0500, Steven Rostedt wrote:
> On Tue,  6 Jan 2026 08:49:51 -0300
> Wander Lairson Costa <wander@redhat.com> wrote:
>=20
> > Add the volatile qualifier to stop_tracing in both common.c and
> > common.h to ensure all accesses to this variable bypass compiler
> > optimizations and read directly from memory. This guarantees that
> > when the signal handler sets stop_tracing, the change is immediately
> > visible to the main program loop, preventing potential hangs or
> > delayed shutdown when termination signals are received.
>=20
> In the kernel, this is handled via the READ_ONCE() macro. Perhaps rtla
> should implement that too.

Or just get it from tools/include/linux/compiler.h.  No need to reinvent
the wheel (even though several other tools do).

That said, signal safety is a pretty routine use for volatile.

-Crystal


