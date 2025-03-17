Return-Path: <bpf+bounces-54188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14925A64DC7
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 13:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3962D3B567A
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 12:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7471A5BB8;
	Mon, 17 Mar 2025 12:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Y55g/SNU"
X-Original-To: bpf@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B132376E2;
	Mon, 17 Mar 2025 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212915; cv=none; b=pPZmVQz9qaLufaMtevfIrMeJIILL4uBMBbLG14mUFWyWh5+x3pRNIqGkzDQVHb4IkRUa6YKmew3gryign1Uvt1CAt+thhjQuTD7+j4NnzOF2H00lHXzp/6owRNQ4bF88n5EkknUvYMvOd1PUtze8DhKwjcAAz5phvr6pwoXATKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212915; c=relaxed/simple;
	bh=e//kaCk1vRZTdS2dCVhMc2Ngigol75AG3VvCbyxcVW0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q3LIUSy1ArVuo2f7UdUp3YnVhGuGfdwKN52GbPqp4+DuSVGF2aGseN0v169yJPDb2/cXuJ6bjqypRhZwiI3I7PfA50Io+DdjPcD5K2b7MdGRXrV0UUR9GSJco1qLoVf3qBXlzt6RoENPaTwahJvf7NEVYVEH9hWv+mLRPxOce/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Y55g/SNU; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=e//kaCk1vRZTdS2dCVhMc2Ngigol75AG3VvCbyxcVW0=; b=Y55g/SNU36PGJ4EjmeuBcvtlYg
	i4FYSLwYnXka0pzjDAa17TbccPXQI8KpiuywzdZWRysVz1ppiLJ9FqZ4uXxKoVMgwRgA6xqg7VTKk
	/uzcrzKelGixrU/GBkalkFs9RBEyROlxqA/AHghtvWn/xkejH0FHxH8UAEAMlGWaruKG9pG+ZuhJI
	YylW/pm/H7H73Tx//DADVYxp+xDnZzUVRzYf9PmPu9PzcZgMu71sRUTK7lHjIC8AMF+ZGjp1bw7Dh
	pdiBqx+70vTSzTLVBfcyM3NsQs5A2SddHE4kjrV1hgfaVtFNzVbiYxXoK4xQHZlk2+5IRmXZHsFO8
	/rCVbNeA==;
Received: from 79.red-83-60-111.dynamicip.rima-tde.net ([83.60.111.79] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tu9A5-002DDy-Uw; Mon, 17 Mar 2025 13:01:42 +0100
From: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
 Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Use after free in BPF/ XDP during XDP_REDIRECT
In-Reply-To: <874izshrvs.fsf@toke.dk>
References: <20250313183911.SPAmGLyw@linutronix.de> <87ecz0u3w9.fsf@toke.dk>
 <20250313203226.47_0q7b6@linutronix.de> <871pv0rmr8.fsf@toke.dk>
 <20250314153041.9BKexZXH@linutronix.de> <875xkbha5k.fsf@toke.dk>
 <20250314172749.hsmtyM3N@linutronix.de> <874izshrvs.fsf@toke.dk>
Date: Mon, 17 Mar 2025 13:01:34 +0100
Message-ID: <87plifc1cx.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17 2025 at 11:29:43, Toke H=C3=B8iland-J=C3=B8rgensen <toke@ker=
nel.org> wrote:
>> This is the or version as asked for. I don't mind doing any of the both.
>> I everyone agrees then I would send it to Greg.
>
> Sure, with the above, feel free to add my:
>
> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>

Thanks a lot, Sebastian and Toke, for looking into this.

Ricardo

