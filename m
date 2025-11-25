Return-Path: <bpf+bounces-75463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC076C853EE
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 14:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CD83B18D9
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 13:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC13123EA95;
	Tue, 25 Nov 2025 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRcUabGl"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6B723D7F4
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078601; cv=none; b=Y1Eagi0R1RBSP0hkOgMAKNAP6pfwA8X6C+qfSc2btbnNaJ4g5qYvTrdFSqJG0+LMeKYa8sznIPEkMzNAzIRrGOVArdetTxSgHFrV0dR9k99hCnII6ZcD8YmhYcAVrpa3UU9MhI1bju8cHs8htXN3dGQmjFqpeiIg7NHq3yW4hTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078601; c=relaxed/simple;
	bh=igOW+fPyxFxvlCfmPvcdrUqhCsRNYwHE4m7Ueubr/Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sugZ5lvTnD/UAREmVX5IYEPIwnaBEqEUPrl/4QXaSypr9ctQV8D3kV6BQ32K0y24a9Kpqm798NM1QKPjrMdcBXT8yNCrnhzOqp4HTUtYJDS+kp0bZdyQlgTWbER3x7ws+GLerYJyCDhgMq+ahN87bJk1OxFD8tbhACuoBto1nj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GRcUabGl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764078598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XN8CLa/8dlj8vakXKNRK1KkqlSNx6IT+QyayqEI84vg=;
	b=GRcUabGlEnRY/v4ZqgqiVD6SKatTNNGg/RBujJBsJBjX6P0FZyXs+oytk2u9IJtZ3zh+4c
	VdGNknYdW4dZc1/L4qZAPUuQAEO0bNSlE2bPrC7NC5S1of5i72oc5bDqpoTM8ztxw7tTdr
	7gSFwvVpyXroVGEix0XwSc4qNkx/9Fk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-CLtErqg-OF68EOTPXYr5YQ-1; Tue,
 25 Nov 2025 08:49:54 -0500
X-MC-Unique: CLtErqg-OF68EOTPXYr5YQ-1
X-Mimecast-MFC-AGG-ID: CLtErqg-OF68EOTPXYr5YQ_1764078593
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC16F1954B21;
	Tue, 25 Nov 2025 13:49:52 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.102])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 904683003761;
	Tue, 25 Nov 2025 13:49:48 +0000 (UTC)
Date: Tue, 25 Nov 2025 10:49:46 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Tomas Glozar <tglozar@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [rtla 04/13] rtla: Replace atoi() with a robust strtoi()
Message-ID: <y7jj2z6jmqb3fq4mzsgtwlbfeocumlcocbgtsx64sgkaornbhy@wus4cz33ijla>
References: <20251117184409.42831-1-wander@redhat.com>
 <20251117184409.42831-5-wander@redhat.com>
 <CADDUTFyAAAv641OfGf_U4hVdegyAVyp5rgruF=NSNd+UPkjOzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADDUTFyAAAv641OfGf_U4hVdegyAVyp5rgruF=NSNd+UPkjOzQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Nov 25, 2025 at 10:35:39AM +0200, Costa Shulyupin wrote:
> On Mon, 17 Nov 2025 at 20:55, Wander Lairson Costa <wander@redhat.com> wrote:
> > To address this, introduce a new strtoi() helper function that safely
> > converts a string to an integer. This function validates the input and
> > checks for overflows, returning a boolean to indicate success or failure.
> 
> Why not use sscanf() for this purpose instead of adding a new utility function?
> 

The strtoi implementation properly detects:

1. Empty strings - via the !*s check
2. Conversion errors - via errno from strtol
3. Trailing garbage - via *end_ptr check ensuring entire string was consumed
4. Integer overflow/underflow - via explicit lres > INT_MAX || lres < INT_MIN
   bounds checking

sscanf has the following limitations:

1. Trailing garbage is silently ignored

   int val;
   sscanf("123abc", "%d", &val);  /* Returns 1 (success), val=123, "abc" ignored */

   While you could use "%d%n" with character count checking, this becomes
   cumbersome and defeats the purpose of simplification.

2. Integer overflow has undefined behavior

   sscanf with %d doesn't guarantee overflow detection and may silently wrap
   values (e.g., 2147483648 -> -2147483648). There's no standard way to detect
   this has occurred.

3. No detailed error reporting (this is minor, though)

   sscanf only returns match count, not error type. You cannot distinguish
   "bad format" from "overflow" from "trailing garbage".

> Also, using a boolean to return success or failure does not conform to
> POSIX standards and is confusing in Linux/POSIX code.
> 

Ok, I will change it.

> Costa
> 


