Return-Path: <bpf+bounces-49061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 807A7A13DB0
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 16:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1AEC188D38F
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7933324A7F6;
	Thu, 16 Jan 2025 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H31/a6OS"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8680422AE55
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041520; cv=none; b=HIscYL1WsZKXQfNvSxsmQSfx2k19hRKp1k1uPe8sywUa+6hYWflhwbi4jC4O3YJ/Cje9CZ0w6n2dFjVDrniJAGaR5mIz0fY2+mTPkV5To8OS6uB/QmXbPxZ4+v8igjiC2b7L2i4ZxVdiQXYEuhxifxnertj4U5QJ4H92BxTUrBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041520; c=relaxed/simple;
	bh=EyHBWBwzh6AHGhhhlCyzXjGA36x06KnwFSPExi66IrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sr/crIWLvkXsYvDzbhe2Zvgl6F8C4cbVp3RdLJtj2whmZJajN39gZJms6JkAJzhdZ5psFO/a+ZLMe4jc7uIGpjullnVcQN2vjgoNb4oretBhg5I/n0juUkVcZyYOQfOZZBXrT7wrGIOEyGUwbWne/2Ly0HrEB4TiQmS5IvPCwLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H31/a6OS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737041517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EyHBWBwzh6AHGhhhlCyzXjGA36x06KnwFSPExi66IrE=;
	b=H31/a6OSHhtfQC8SXn6Y0XATwKRG8Xk9SKBGX/7RMKHUGeiz0vkgr9zx3SwwRSofErxB8E
	hU92Lwr+qbYh6lGgYp+BU6iNNsKVWGWC8BDTSD96rxbzILJcFW3QM+MSR4B8q/6nrxKhDm
	D9k1AyznwDM+frdlmCRbe9Yhk/tZ/xU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-uxurKbNRNzexCwgC_jtTRQ-1; Thu,
 16 Jan 2025 10:31:51 -0500
X-MC-Unique: uxurKbNRNzexCwgC_jtTRQ-1
X-Mimecast-MFC-AGG-ID: uxurKbNRNzexCwgC_jtTRQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E31601955D72;
	Thu, 16 Jan 2025 15:31:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.118])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1E86B19560BF;
	Thu, 16 Jan 2025 15:31:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 16 Jan 2025 16:31:20 +0100 (CET)
Date: Thu, 16 Jan 2025 16:31:11 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
	Linux API <linux-api@vger.kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <20250116153044.GF21801@redhat.com>
References: <20250114172519.GB29305@redhat.com>
 <Z4eBs0-kJ3iVZjXL@krava>
 <20250115150607.GA11980@redhat.com>
 <CAADnVQJjroiR0SRp69f1NbomEH-riw53e_-TioqT4aEt3GSKGg@mail.gmail.com>
 <20250115184011.GA21801@redhat.com>
 <CAHsH6Gu1kXZ=m3eoTeZcZ9n=n2scxw7z074PnY5oTsXfTqZ=vQ@mail.gmail.com>
 <20250115190304.GB21801@redhat.com>
 <CAHsH6Gtd5kYPife3hK+uKafjBMx=-23UzvQgnOnqNDzSZgHyqw@mail.gmail.com>
 <20250116143956.GD21801@redhat.com>
 <CAHsH6GukV+ydR+hw_-RF=0=_x6aO7xZzkCmbc53=Pk0Kv=8hUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHsH6GukV+ydR+hw_-RF=0=_x6aO7xZzkCmbc53=Pk0Kv=8hUQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/16, Eyal Birger wrote:
>
> Ack. I agree.
>
> Do you want to send a formal patch, or should I?

Please send the patch ;)

Oleg.


