Return-Path: <bpf+bounces-58449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 050F9ABAAEB
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 17:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A5C77AFA45
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 15:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D9C207A22;
	Sat, 17 May 2025 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T6Tl0Xli"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584921EA90
	for <bpf@vger.kernel.org>; Sat, 17 May 2025 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747497103; cv=none; b=cmmNQZn0E3xiyr3zGQN3ZP2gUOQE+1b6TnCZsE81EHcOHkzZMfN4wXnjvYGdzJoTsaE+IpYRfyd7UwOgW2mUUGiaNhJl7DN11whKiletM3X/gHyDbQGSPz/y7JmeporujeAPrnWuQpenHUILbX4Dpt/6LClQCRdgneGdrchvO44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747497103; c=relaxed/simple;
	bh=RHWJ7+ENK3ysA0wQdgi4xpA/oVgeGeZVO91GkRJOnw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxQ+h1/tyChRSEyni+i6t5YHVKLq/LiBcnGjIcq+cs96ab86NKG8tTsJSv9x141+XKQXXu9ePoy6U/zxZ1wL6qMgeRhww9WeZUTXnbgFx2H1WWu52GDXzAJyszKqxpAdUSfXwJdm+xqHw1TzycjiaWSbTG8BI+DkEKjBBMCX5DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T6Tl0Xli; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Gm-Message-State: AOJu0Yyc6ISYTPPKJMt34rA0qN8YIUMhqjbGZYVYgZykq0pPoo1ce3eM
	tO2MBeif1JSy9NI2cCU9aX+c5mX6zqgDOPAV5ibE1k460VphBxOyoRSFitcxyZUW/Pbp/IbQLlB
	kI5eKvh/Z1KmKrpA1kffpthd17imJ604=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747497098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RHWJ7+ENK3ysA0wQdgi4xpA/oVgeGeZVO91GkRJOnw4=;
	b=T6Tl0Xli6m/hcTpaHxG6QnRZ/q9B/NtyIQT1xuJJmRfWouYGAIF9cWKkUiBA+H6q9vhJB0
	VcTdOju7QyBioKICApV/qQXbVxNxm/kwYA/HXCcL7t19PykM8HrULWDFWTvxlj4j8P3/l1
	R/zZYYDLLLlK6JYj3ybnVXbHw6NpnWo=
X-Google-Smtp-Source: AGHT+IEHSSjPWy/qXRanpcH3xItL5zGinbj2b9UGOKzW+e5q4qnanKkoEfAc3rLX8Nkq+YI0L5gVkddT+rlmHM4pt58=
X-Received: by 2002:a05:6102:1587:b0:4db:e01:f2db with SMTP id
 ada2fe7eead31-4dfa6944a54mr9571173137.0.1747497093752; Sat, 17 May 2025
 08:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517003446.60260-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20250517003446.60260-1-alexei.starovoitov@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Sat, 17 May 2025 08:51:23 -0700
X-Gmail-Original-Message-ID: <CAGj-7pVLm5m76PNemK6MNJNY1YPwKjqpyGHKaWycTdF-u8tqtw@mail.gmail.com>
X-Gm-Features: AX0GCFtpkNRiL3dVzhEom5a8SOJgCUkGBbnQWpoANlkSwijZVuftIoZkBvLUA-o
Message-ID: <CAGj-7pVLm5m76PNemK6MNJNY1YPwKjqpyGHKaWycTdF-u8tqtw@mail.gmail.com>
Subject: Re: [PATCH] mm: Rename try_alloc_pages() to alloc_pages_nolock()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz, 
	harry.yoo@oracle.com, mhocko@suse.com, bigeasy@linutronix.de, 
	andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org, 
	peterz@infradead.org, rostedt@goodmis.org, hannes@cmpxchg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Fri, May 16, 2025 at 5:34=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> The "try_" prefix is confusing, since it made people believe
> that try_alloc_pages() is analogous to spin_trylock() and
> NULL return means EAGAIN. This is not the case. If it returns
> NULL there is no reason to call it again. It will most likely
> return NULL again. Hence rename it to alloc_pages_nolock()
> to make it symmetrical to free_pages_nolock() and document that
> NULL means ENOMEM.
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

