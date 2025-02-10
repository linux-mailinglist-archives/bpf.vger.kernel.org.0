Return-Path: <bpf+bounces-50962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33023A2EC4B
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 13:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEABE1889AD0
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 12:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5703221D8B;
	Mon, 10 Feb 2025 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFJ4T1bq"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E392206B7
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739189275; cv=none; b=Mh1JQI9FkUqdkQw5P2+nmyN1w6+QchBhZavwOV9oyXjMOC8/h0h0IvVsbVn8YyuDvSn0qQMt7uRzOOevmy3FCIsggPomAgPMh4Vxu3bhsjLRaUOtketlKmrfcDzyBGIbXirn4LEOSYOlX2gG5u1sC5SIs1yjERwpDkUjz5iITIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739189275; c=relaxed/simple;
	bh=BtQ9N1MvirivDuLCQDNFtrplYfp2RM+U8t6UQeof8HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOB1QpUrmsa7ult81uzfNsQrfvdQkk09bc4PBBJlJ1f9zV9THEF50dT65fxusRO8WQZawmVuDBPVmU+3E7+NKct5SGG/s1X0Dhm9SLeXliUOf3RqRgJK+scDwP+5IXxBSpV3j3p02VAiB13g8Qg2r9P44R+yDtDYnni1zXbJuTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFJ4T1bq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739189272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TNwsmie5gRPqqyVCLb3IhqDqH4N/saJWdmlC5n8Dh5I=;
	b=PFJ4T1bqs3jrSk3fKB0EIoSm4GaHiXw65N27M1G1Wiq2KWpasrBMSZTBN2yp888mlCtfmd
	pTt+gqWYHMdKmP1ixwdZCDVwQnd5M16mn6wD5AeNxI1kfWjqtf/TtWbwCJxDIIG7OC2NM9
	cGByEL1VsAonjLQm6hlnpjqVgto8+vk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-jW7P-b8EOCOzDHiXADTIjw-1; Mon,
 10 Feb 2025 07:07:49 -0500
X-MC-Unique: jW7P-b8EOCOzDHiXADTIjw-1
X-Mimecast-MFC-AGG-ID: jW7P-b8EOCOzDHiXADTIjw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98008195608E;
	Mon, 10 Feb 2025 12:07:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.113])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 811B8180035E;
	Mon, 10 Feb 2025 12:07:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 10 Feb 2025 13:07:19 +0100 (CET)
Date: Mon, 10 Feb 2025 13:07:10 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>, stable@vger.kernel.org,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, bpf@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH bpf-next] uprobes: Harden uretprobe syscall trampoline
 check
Message-ID: <20250210120710.GB32480@redhat.com>
References: <20250209220515.2554058-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209220515.2554058-1-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 02/09, Jiri Olsa wrote:
>
> [1] https://lore.kernel.org/bpf/202502081235.5A6F352985@keescook/T/#m9d416df341b8fbc11737dacbcd29f0054413cbbf
> Cc: Kees Cook <kees@kernel.org>
> Cc: Eyal Birger <eyal.birger@gmail.com>
> Cc: stable@vger.kernel.org
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


