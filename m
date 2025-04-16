Return-Path: <bpf+bounces-56017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B187CA8AD15
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 02:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311AA3BE7CD
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 00:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE6A1E5B7B;
	Wed, 16 Apr 2025 00:55:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2AE1D90A5;
	Wed, 16 Apr 2025 00:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744764942; cv=none; b=a+xEGqrgTw8xT8Jn10XjXk4GLL10sH2W3N76Ya1FwObPRqDs7hhlave5WxwIkCRQ3tE027KC9ulnfaObel2N48iRJvD5l4AgYQ550dwO4qZCnOjy7Nrzo7MpcGqtTprO/e/oFU9nSH9zgnZNzMep2ifQLzwmIIXBAxPy36qm2Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744764942; c=relaxed/simple;
	bh=VhXDg+HaETjX6mRSrq+Zl1gFu5zv4Nk9K0mjPrhoPpg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XqP9A7Q7oJuS3rr7Fh9hrTYNgYILV9uFuE9kjUHvUEOYLACusljv1+ugbIna8qajLn7S4irjt6XsgRAGnFxO/p852pvmigFm2Z/VEQc4hsac39UPDKFDdST7UHIYLge0cP3wIs1c/Fl1BUEHAKoIDYIbO+SK8DLXs55SdY3cSbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25691C4CEE7;
	Wed, 16 Apr 2025 00:55:41 +0000 (UTC)
Date: Tue, 15 Apr 2025 20:55:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Menglong Dong
 <menglong8.dong@gmail.com>, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Menglong Dong
 <dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf v2] ftrace: fix incorrect hash size in
 register_ftrace_direct()
Message-ID: <20250415205539.5712e5c5@batman.local.home>
In-Reply-To: <CAEf4BzbyqNAPrOR7cR+2PKCy+cXoEftWufFbhMv73QPFZM+ysw@mail.gmail.com>
References: <20250413014444.36724-1-dongml2@chinatelecom.cn>
	<20250414160528.3fd76062ad194bdffff515b5@kernel.org>
	<CAEf4BzbyqNAPrOR7cR+2PKCy+cXoEftWufFbhMv73QPFZM+ysw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 16:14:01 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> I'm a bit confused by the "[PATCH bpf]" prefix... This fix doesn't
> seem to be BPF-related, so I'm not sure why it would go through the
> bpf tree. I presume Masami or Steven will route it through their tree,
> is that right?

I can take this in my tree.

-- Steve

