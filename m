Return-Path: <bpf+bounces-76529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4564CB882A
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 10:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D45103007C83
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 09:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9982F31578F;
	Fri, 12 Dec 2025 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUBDZmQ8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD821DE4CA
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765532736; cv=none; b=PbRFlJUqVWn8I6HoBgWxAeh1wQ6sbCGt0BYSHKJOFpW2rHslDKSaqc+Z+RHbpgRLkcUJnCrJbuAOVbB7OmmoFPIEshCU1laqDzvIhW8TTIVRroRJmelCgvbJGLVCkFcXiDmaHlooq4ue8mGn8OmsnEZn3obuQL7SKuTq5KUVfaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765532736; c=relaxed/simple;
	bh=KUdDundps4N0ls59VYr7zGlSQpX1cJs93PzzvADXaoI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Gx9zyP7hsf66ZyR7j8/wVzUYlURfkc9SDkj/u0nCjisEv/U9ClUqtEHWOk4m5IZGLrKcielg4SZue81+ILILCxmzHHdX99+UCxCDvrNoxak07Mn7XZ706/M4EF/0gmwvgLy2P17acUZTxL23BTJK3jlI5JhWdUfN31DdKQO3ccc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cUBDZmQ8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765532733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=116xSJ656RTM2ED7ppl3sq+qxbtZc95OtFqrG8ezYKw=;
	b=cUBDZmQ8IR1IYMxmLeuaEkinb1Eu1vI8iHU/Yr35OCI6vm1p0dLJwtO599hV6hDIrsAXcr
	B5s4+AENL/OrSihHZabbrVb4YUnBkydJiUhpct/RMgMlvq7fT382fFbmxE4absYN23qrXb
	kH98hWC2mrEXE/YFSxC+JeiuZOTlXEw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-NRvY7qoBOwCs1LStuUHAog-1; Fri,
 12 Dec 2025 04:45:24 -0500
X-MC-Unique: NRvY7qoBOwCs1LStuUHAog-1
X-Mimecast-MFC-AGG-ID: NRvY7qoBOwCs1LStuUHAog_1765532723
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8A26195609E;
	Fri, 12 Dec 2025 09:45:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 785923000218;
	Fri, 12 Dec 2025 09:45:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20251211021257.1208712-5-bboscaccy@linux.microsoft.com>
References: <20251211021257.1208712-5-bboscaccy@linux.microsoft.com> <20251211021257.1208712-1-bboscaccy@linux.microsoft.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: dhowells@redhat.com, Jonathan Corbet <corbet@lwn.net>,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
    =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
    "Dr. David Alan
 Gilbert" <linux@treblig.org>,
    Andrew Morton <akpm@linux-foundation.org>,
    James.Bottomley@HansenPartnership.com,
    linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
    linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC 04/11] crypto: pkcs7: add flag for validated trust on a signed info block
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <811908.1765532715.1@warthog.procyon.org.uk>
Date: Fri, 12 Dec 2025 09:45:15 +0000
Message-ID: <811909.1765532715@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Note that there are two other potentially conflicting sets of changes to the
PKCS#7 code that will need to be coordinated: ML-DSA support and RSASSA-PSS
support.  The former wants to do the hashing itself, the latter requires
signature parameters.

David


