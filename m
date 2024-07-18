Return-Path: <bpf+bounces-35009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C60993501A
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 17:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47631C20DCB
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 15:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCDC1448FF;
	Thu, 18 Jul 2024 15:45:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B861B86F8;
	Thu, 18 Jul 2024 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721317525; cv=none; b=Q11xckeWiDMqfY/eoXJetHU6/IjfY//haMJ4Umhuz93ZwV2BzpHJUlidVYfq6odQUSpxwOifxPnU+Y+26CZgk3/RluUC8q+Z5++2uH3xqQV3O9ZRUBVl9Omw/yTvP1R/HuzfRwQE4wyo9eIiYi6ss1ZRzpDI3ob1JKOH2vuJaAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721317525; c=relaxed/simple;
	bh=puR0kF+FiPaWcr4LOEMGYUolzOZNEuto09BbeswveUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJ2TsEuQE1a+ItL6qYPo0KZjwVLl3QSc67zPkrlTd439glW77rE0/vMn8+JFQL2NGjw1Bv7C9HKHxY0Y5DBvTfpJzk4t+nYFvCnOZFiUxSI4TQNb1S/QwfAzEljRr2B9jQQoGgPlZdwb04OuP12MsbzSYLU+cDzs4YlJ8lkMX7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B91C116B1;
	Thu, 18 Jul 2024 15:45:23 +0000 (UTC)
Date: Thu, 18 Jul 2024 11:45:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 peterz@infradead.org, mhiramat@kernel.org, x86@kernel.org,
 mingo@redhat.com, tglx@linutronix.de, jpoimboe@redhat.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, rihams@fb.com,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5] perf,x86: avoid missing caller address in stack
 traces captured in uprobe
Message-ID: <20240718114521.4b0220b7@rorschach.local.home>
In-Reply-To: <CAEf4BzaTEUkRU37fsuGy+-otWk9K0-c9=hs0APRz7pJy7rq-5w@mail.gmail.com>
References: <20240710193653.1175435-1-andrii@kernel.org>
	<CAEf4BzaTEUkRU37fsuGy+-otWk9K0-c9=hs0APRz7pJy7rq-5w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 08:29:23 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> Ping. What's the status of this patch? Is it just waiting until after
> the merge window, or it got lost?

It's probably best to re-ping after rc1 is out. With recent events, a
lot of us are way behind in our work.

Thanks,

-- Steve

