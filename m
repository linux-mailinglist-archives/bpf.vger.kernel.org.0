Return-Path: <bpf+bounces-23256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C918886F29D
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 22:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8A5281640
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 21:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3385641766;
	Sat,  2 Mar 2024 21:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Utje04hv"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0DD3FE4E
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 21:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709416262; cv=none; b=NMkFV2utPulYRFX6Zkb9NOYxTqAzdRHrmt23mvLy1qbRqNfPaS7b0IkNfMdGUG1rXb8LLEC+3r3ZwlTtejtCkE6mBJRVGNaSxOcSRY1DmReotbrpMUNn/fe4ZT6XpfVco1iCiJoIOFV5R9qY9bhbZvSVnRW3/cwmiV7Q3iDZgmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709416262; c=relaxed/simple;
	bh=ylQe5N1vgO0FEovM7bSJu2OIQjWDJQ5UrgtWCxM4tog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kacw5BQ52Uo2eOEgIdgkTA2+s7aBMIm1/2/Mi4euSXUc/gh6teAZTBQpakis4yA9b49wppDbYBDxLSk0MUdgcHHgSZsgbPGynGz4WrnyIF9gBsoQ6JG9g7FM9uGBLDfiHNcfwYhpRj09jA7hWAhi1jvuD8iXFsPnHALHnK7jd4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Utje04hv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709416259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C4CcuHZrGxKll/2ejZUgdZj3ot3k4kc/fGNvO9cfFDg=;
	b=Utje04hvhkPWXhhT6mHYn0Oqxgs5svt+7GKyS1rzfBcrV/0C/2hQ1IDxFlwX4RM3yI4nOp
	57AZFrJSMT+vwYqgmK3/MfYvzl4hYWLr1xcs0hLDuE7Q0rcvhayialjpHRDeeAiJ7oJedE
	2NoqU63TrM2aMml8b2epXbJuQhy4iiQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-SyVxhjxBMw6ygOjBxLchYw-1; Sat, 02 Mar 2024 16:50:56 -0500
X-MC-Unique: SyVxhjxBMw6ygOjBxLchYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBC2682DFE2;
	Sat,  2 Mar 2024 21:50:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.18])
	by smtp.corp.redhat.com (Postfix) with SMTP id 93350C0348B;
	Sat,  2 Mar 2024 21:50:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  2 Mar 2024 22:49:35 +0100 (CET)
Date: Sat, 2 Mar 2024 22:49:32 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, yunwei356@gmail.com,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
Message-ID: <20240302214932.GA4411@redhat.com>
References: <ZeCXHKJ--iYYbmLj@krava>
 <CAEf4Bzbs4toMxw62kVTWNHA7sW-CncamyKHCWynCT0GnG+fOfQ@mail.gmail.com>
 <ZeGPU8FRqwNuUJwd@krava>
 <CAADnVQKW4Qk55NjaApx1caPDF_pA8f5JZFE12DKA2R8cKWmtcw@mail.gmail.com>
 <ZeOQOE08x0fUpA7d@krava>
 <CAADnVQKPmJxya14T=BPTK3rfy9sOYMQQ6-oaNHcBtJa5z2nQ=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKPmJxya14T=BPTK3rfy9sOYMQQ6-oaNHcBtJa5z2nQ=g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 03/02, Alexei Starovoitov wrote:
>
> I suspect it's all working fine already.
> Only x86 is using single byte uprobe.
> All other archs are using 2 or 4 byte.

Yes, so we have UPROBE_SWBP_INSN_SIZE

> So replacing an insn or two with a call should work.

Please note that  __uprobe_register(offset) fails if
!IS_ALIGNED(offset, UPROBE_SWBP_INSN_SIZE)

Not to mention that if "call" replaces 2 insns we have another problem:
what if another consumer wants to probe the 2ns insn ?

but perhaps (quite possibly) I misunderstand you.

Oleg.


