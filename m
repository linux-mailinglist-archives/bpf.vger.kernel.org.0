Return-Path: <bpf+bounces-49972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB16A20D5F
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 16:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79253167C95
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 15:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93491D618E;
	Tue, 28 Jan 2025 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P90yyR8z"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9DD1AA1DA
	for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079116; cv=none; b=BmYQ08aWb34YgeSU6C2Htd/5ZgOt2PPeC2npJuuThNPm3OpUfIghfAPnYlesmjBnCgMd2yh1ZVgYn/pdSUhQvCeqXCnbAhPlm8zXkABdDITXMqiDffKP/3OqZWI0J+e57dTEXPLovmztPH/WF2SAkOdjaFaudzfOk5aYIXA67B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079116; c=relaxed/simple;
	bh=noXyBqI87BE5bKgzA/bkBi5QPBLeFamw8wGuZmVJ96I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIA2/ONFrF8W0rIPTVIhl7x4YpXt/JTBAzJJr4davzKRkJG72qvbrA8JaSRBKpajtWKV7tSCjx2pm4DXc8+QL/ZX/g4b/It6aFRDbBBYiBCq4fn0gcMoXG158NYwHZV5e6nG62ZV8LBwet9eq0/N13KJFi1xdhTrIvXwygFhNE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P90yyR8z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738079113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J1t6D/PIMIyABHQaylKfMHsHw7I0DV8eA6V4Mnp8hC4=;
	b=P90yyR8zwhAWwUR8uKLFPiMw44IVx3hQNQRexebS1B6gNHqHdPrFtf4qPuG3Y1Fn1yFgt4
	z3Ab05c8FRgng55RTaf3YY357ygA6pxuZeuCvi74pOP79YdsW1AEd6UNeflowamLqITwun
	Lh7z9AkKps23MKdInxdgZyrz/R/R9MI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-_UDh5xabOfuNR0SA5QAVhQ-1; Tue,
 28 Jan 2025 10:45:05 -0500
X-MC-Unique: _UDh5xabOfuNR0SA5QAVhQ-1
X-Mimecast-MFC-AGG-ID: _UDh5xabOfuNR0SA5QAVhQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F7CB19560B3;
	Tue, 28 Jan 2025 15:45:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.70])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 88BFC30001BE;
	Tue, 28 Jan 2025 15:44:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 28 Jan 2025 16:44:35 +0100 (CET)
Date: Tue, 28 Jan 2025 16:44:25 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: kees@kernel.org, luto@amacapital.net, wad@chromium.org,
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org,
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <20250128154424.GB24845@redhat.com>
References: <20250128145806.1849977-1-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128145806.1849977-1-eyal.birger@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

can't review, I know nothing about seccomp_cache, but

On 01/28, Eyal Birger wrote:
>
> +static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
> +				   struct seccomp_data *sd)
> +{
> +#ifdef __NR_uretprobe
> +	if (sd->nr == __NR_uretprobe
> +#ifdef SECCOMP_ARCH_COMPAT
> +	    && sd->arch != SECCOMP_ARCH_COMPAT
> +#endif

it seems you can check

            && sd->arch == SECCOMP_ARCH_NATIVE

and avoid #ifdef SECCOMP_ARCH_COMPAT

Oleg.


