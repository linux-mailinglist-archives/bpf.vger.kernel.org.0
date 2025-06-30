Return-Path: <bpf+bounces-61824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165A5AEDD83
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 14:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4533BD839
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 12:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C6A286D52;
	Mon, 30 Jun 2025 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdDNwxLh"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69E82CCC9
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287873; cv=none; b=XJG+WttE8kw/pffNYBo3X8lT4Se4KFmWH0e9z2SjZXx1TORHmc3I26Dhy+B0prN91UBtRQ69j7Hvac8X//AUNkUWVJ4ytxMGeXxfJFGYo7EuSgBW80NyrmQ+aMrtbUUxDGy1Lu3VbE1ykARjuWnXOxQJSfAMsS2w8JB6Hm52A6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287873; c=relaxed/simple;
	bh=8ujMhUl7i4M3zObpjxjLUh1ZT+VHzlsAgD+fcoPERC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RsF7WtYLe4qV0+rkZDlCsWzrN7zzhaUqozXPfng3Qmv8NfGzKuiouZbI3aeAZA8LCyJEWdHYSieXToLkftZSIeqUMekoW2+vCulGT8zALZvYWRvCdOn4szCwr5SRnF30tH/BMzGT2LLcXPMRag4kufiPvW/Za37SjdUndVZ7FsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HdDNwxLh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751287870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84LuPZ9pN40vZZj6LotxaTZH2u/8fUAdfMA409beGHI=;
	b=HdDNwxLhov6uXy2jQgBEQPiA+5LbMAgG6JL1HMnS6pbB6B+kTD8GvMojgGVEjujRHjJwIQ
	R/1jN85q9NKsqr/vzoZaIpxOP3/DPzXVL8+YSEdMOUhsUhnBpb2VADDBaHqE9QBDVjlbk+
	VxYzXxkmz6ZcTC8of4wQVEoQBEqWoLw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-CKIX6GAvPeiF6kLzFqpz0Q-1; Mon,
 30 Jun 2025 08:51:08 -0400
X-MC-Unique: CKIX6GAvPeiF6kLzFqpz0Q-1
X-Mimecast-MFC-AGG-ID: CKIX6GAvPeiF6kLzFqpz0Q_1751287866
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D6061800287;
	Mon, 30 Jun 2025 12:51:05 +0000 (UTC)
Received: from oldenburg3.str.redhat.com (unknown [10.44.33.80])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57A451956095;
	Mon, 30 Jun 2025 12:50:56 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,  linux-trace-kernel@vger.kernel.org,
  bpf@vger.kernel.org,  x86@kernel.org,  Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Josh Poimboeuf <jpoimboe@kernel.org>,
  Peter Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@kernel.org>,
  Jiri Olsa <jolsa@kernel.org>,  Namhyung Kim <namhyung@kernel.org>,
  Thomas Gleixner <tglx@linutronix.de>,  Andrii Nakryiko
 <andrii@kernel.org>,  Indu Bhagat <indu.bhagat@oracle.com>,  "Jose E.
 Marchesi" <jemarch@gnu.org>,  Beau Belgrave <beaub@linux.microsoft.com>,
  Jens Remus <jremus@linux.ibm.com>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v11 00/14] unwind_user: x86: Deferred unwinding
 infrastructure
In-Reply-To: <20250625225600.555017347@goodmis.org> (Steven Rostedt's message
	of "Wed, 25 Jun 2025 18:56:00 -0400")
References: <20250625225600.555017347@goodmis.org>
Date: Mon, 30 Jun 2025 14:50:52 +0200
Message-ID: <878ql9mlzn.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

* Steven Rostedt:

> SFrames is now supported in gcc binutils and soon will also be supported
> by LLVM.

Is the LLVM support discussed here?

  [RFC] Adding SFrame support to llvm
  <https://discourse.llvm.org/t/rfc-adding-sframe-support-to-llvm/86900>

Or is there a secone effort?

> I have more patches on top of this series that add perf support, ftrace
> support, sframe support and the x86 fix ups (for VDSO). But each of those
> patch series can be worked on independently, but they all depend on this
> series (although the x86 specific patches at the end isn't necessarily
> needed, at least for other architectures).

Related to perf support: I'm writing up the SFrame change proposal for
Fedora, and I want to include testing instructions.  Any idea yet what a
typical =E2=80=9Cperf top=E2=80=9D or =E2=80=9Cperf report=E2=80=9D command=
 line would look like?

Thanks,
Florian


