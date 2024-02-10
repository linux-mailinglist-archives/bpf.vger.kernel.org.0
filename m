Return-Path: <bpf+bounces-21688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28702850290
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 05:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC5E5B239B1
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 04:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7015C9C;
	Sat, 10 Feb 2024 04:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpjaqcD9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C206AB7
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 04:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707540693; cv=none; b=ualkSji1wnCvGg4T9mWpXOvJI+4LvBZqLhkYP53qyWrgDz6yezw1vjbvTDPnL34Z+juWjAf6YvDojHwvgewdCjTofdyA4j4mwo57FFeSTOXYjII5YVcU3L7S1USuqPhV/bHqLWAi08iYP7lXqquUbL/IrXb4SrYYbCwjiI+uN3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707540693; c=relaxed/simple;
	bh=lm5mhGsGxEyxIO5BKr7Wbgt8tZKL0bod5Tz1MxiIzeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2pIr71WRHu/s390w4eRc3cd9jVPv8P0TYJgZOei15ZAQ2FL5hv2PcIkCrpT4/JZ4FVF27RlNWP6RlVcdYanP1xTJAyfYetoi3GUW6r9NbKb0dzxcKFJ+AVmbPyJSTD9GM9S/ufbPB1wb1Cm4h5OyMRKGw/bePizwGBiNZJptkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpjaqcD9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707540687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ro8rUn2VeTdW1n/4yHjYsv5KEEL3rbmZwbel3sqRTQg=;
	b=hpjaqcD9LxWEBOGsJaHKn7wAli209zsiWinnWCMLL6PlkvkTjBAIcq4phdiDyX3Nx+G4FV
	KCuYG5J2lYiz+E/WkSHNc7WHs20ti0FYyzqw1tXe32mbdYEVHJIbo1eNK2Sk8P9VvnUCpb
	AIH1tgPfLG3AzqsI7se2pMNIczlqtQQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-4iDbVx2BN9uxqJO_PVzkBQ-1; Fri, 09 Feb 2024 23:51:25 -0500
X-MC-Unique: 4iDbVx2BN9uxqJO_PVzkBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 485B4811E79;
	Sat, 10 Feb 2024 04:51:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 30E98AC1D;
	Sat, 10 Feb 2024 04:51:23 +0000 (UTC)
Date: Sat, 10 Feb 2024 12:51:21 +0800
From: Baoquan He <bhe@redhat.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org,
	Kexec-ml <kexec@lists.infradead.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH linux-next] bpf: fix warning for crash_kexec
Message-ID: <ZccAyalp+NyKQoGp@MiWiFi-R3L-srv>
References: <20240209123520.778599-1-hbathini@linux.ibm.com>
 <ZcZ6myvln-v0Y98S@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcZ6myvln-v0Y98S@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 02/09/24 at 11:18am, Stanislav Fomichev wrote:
> On 02/09, Hari Bathini wrote:
> > With [1], CONFIG_KEXEC & !CONFIG_CRASH_DUMP is supported but that led
> > to the below warning:
> > 
> >   "WARN: resolve_btfids: unresolved symbol crash_kexec"
> > 
> > Fix it by using the appropriate #ifdef.
> 
> Same question here: how did you find this particular kconfig option
> (CONFIG_CRASH_DUMP) to use? Looking at the code, crash_kexec is defined
> in kernel/kexec_core.c and it's gated by CONFIG_KEXEC_CORE. So the
> existing ifdef seems correct?

This patch is based on the latest next tree, I have made some changes to
split the crash code from kexec_core.c. If you check next/master branch,
crash_kexec is not in kernel/keec_core.c any more.


