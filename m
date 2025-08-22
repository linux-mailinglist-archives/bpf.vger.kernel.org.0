Return-Path: <bpf+bounces-66287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0690AB31FDD
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 18:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8583F6482E9
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 15:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887351E47B7;
	Fri, 22 Aug 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUYko0xs"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646BD393DDE
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877967; cv=none; b=pGSDDHldsbBFQKomPGx25bZ/PjFQRP6AHMXlZr3eHXJNmSYtvejOAmP0ymuQAkRSBl+lOU4rVFOMjuggwJcwtTeURPVoo6GG2aJgjxd80v4TVkj3Tok4ubc1O/4vmXouHHDqq6Uwufr7lP/bk1ISnQu5OjCJCUIe10K9Wa8XkVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877967; c=relaxed/simple;
	bh=8jiqxKcTQFnXGxn3hNE6OwU4CsdOECgb7lkMtk00LGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psX6jY6r3ZP7i7BGyaSwMbMhqGs+0FW1IzjUkGe9JA1CHnhkjCoR97Wm28q/Jri8hk8RWLVwL/vtTbE+U3n8SI7ih+nQS9I5+gFRXV//ojwmE+i7iIPWjvuBMB4Gvpr8tFlMHkyfAi6BIFH69cO/MOs3cDMgBhmYjvLEoZpFaC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUYko0xs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755877965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mYRySiryXy1ygKi86fAgkp72E4RJ1lkZ+6KjdD+UoBA=;
	b=bUYko0xsvpN99xtajvR2Zlr14FIYD3yuuKIluRp2Py0JFC8GvSMp2xWi9jNYhpxM+FjlmY
	d4HOe8IzIIfj9dQ6IOAshhuljjHf+wkBSRiRcuDqk/gyqS9zEqHdLzwond82+6HomB7KPg
	IKcYoL/CdzUeCmFgUaEexUCearR7ulo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-GIJgJcYWMtGJh7-xXoNtFA-1; Fri,
 22 Aug 2025 11:52:41 -0400
X-MC-Unique: GIJgJcYWMtGJh7-xXoNtFA-1
X-Mimecast-MFC-AGG-ID: GIJgJcYWMtGJh7-xXoNtFA_1755877959
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BDBE1956096;
	Fri, 22 Aug 2025 15:52:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.227])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 06D6B1800296;
	Fri, 22 Aug 2025 15:52:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 22 Aug 2025 17:51:18 +0200 (CEST)
Date: Fri, 22 Aug 2025 17:51:05 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: jolsa@kernel.org, andrii@kernel.org, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, alx@kernel.org, eyal.birger@gmail.com,
	kees@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	haoluo@google.com, rostedt@goodmis.org, alan.maguire@oracle.com,
	David.Laight@ACULAB.COM, thomas@t-8ch.de, mingo@kernel.org,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH 0/6] uprobes/x86: Cleanups and fixes
Message-ID: <20250822155104.GA32136@redhat.com>
References: <20250821122822.671515652@infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821122822.671515652@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/21, Peter Zijlstra wrote:
>
> These are cleanups and fixes that I applied on top of Jiri's patches:
>
>   https://lkml.kernel.org/r/20250720112133.244369-1-jolsa@kernel.org

Can't review 4/6 due to the lack of knowledge.

Other changes look good to me, FWIW

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


