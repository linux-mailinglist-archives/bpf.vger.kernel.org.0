Return-Path: <bpf+bounces-54467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2A9A6A63D
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 13:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39DB8A29FB
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389CC221F21;
	Thu, 20 Mar 2025 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diH5hrVo"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B22212FB3
	for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742473474; cv=none; b=O4cyFv4ms/Y0RMDxHZ+JTXpP1ryEEsnLc4IBmTzVZRuKgjck6mG+nglREAo2arWts3S7Y/LtaUcxhxGg02YQ6u4df8owVnLsb4wdvQijpSQRRpzCwKMPPV7W1HP9jT2D2te2oA2ucH5J5VZwTzoSMJwrm3/o2lNYO4BAXredPCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742473474; c=relaxed/simple;
	bh=dpO6ubdCV4Jcojf4GwweKX78np6EMp++yJkz2nXW+U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhvPpf26KLvat9MwymmDVUwhxdQe80mrVXNzU4Qyj1Rt9mKQnDwbO09fu2HeNmHjMBZPluK8flQRJkDOisDQTm8akqghZsz3twIRx5vZKzcH3frwoQQcLkxzB99GtOYppGghZL2FLdjyGVkZkiJAYXPLwxyAatKOwRVTEMSXbAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=diH5hrVo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742473471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4uGZqzYjztCp2uORK/QZb2BhLpTrU8dIV38xdYBgzA8=;
	b=diH5hrVoIQn3Jr/Cl8X5KWoYDiXesrCkxTloAQ8PQ3M6MrWQtL3vys0xX9cDvTwjcgDnyj
	3qUFaLX0moPKed50bNhFHOMBGtGrG6sHnhLsOL7mOAAGw4JuSI8/wrT3dNI/YXVD9Q+G3Q
	NJwHWUKjV+bguZ4ofnFyw/0lAvI1hgk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-oED42QQlNRmQAD0mRp2UNQ-1; Thu,
 20 Mar 2025 08:24:27 -0400
X-MC-Unique: oED42QQlNRmQAD0mRp2UNQ-1
X-Mimecast-MFC-AGG-ID: oED42QQlNRmQAD0mRp2UNQ_1742473465
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EADB01933B41;
	Thu, 20 Mar 2025 12:24:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1B77C1800370;
	Thu, 20 Mar 2025 12:24:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 20 Mar 2025 13:23:52 +0100 (CET)
Date: Thu, 20 Mar 2025 13:23:44 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>, kees@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH RFCv3 00/23] uprobes: Add support to optimize usdt probes
 on x86_64
Message-ID: <20250320122343.GC11256@redhat.com>
References: <20250320114200.14377-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320114200.14377-1-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 03/20, Jiri Olsa wrote:
>
> hi,
> this patchset adds support to optimize usdt probes on top of 5-byte
> nop instruction.

Just in case... This series conflicts with (imo very important) changes
from David,

	[PATCH v2 0/3] kernel/events/uprobes: uprobe_write_opcode() rewrite
	https://lore.kernel.org/all/20250318221457.3055598-1-david@redhat.com/

I think they should be merged first.

(and I am not sure yet, but it seems that we should cleanup (fix?) the
 update_ref_ctr() logic before other changes).

Oleg.


