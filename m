Return-Path: <bpf+bounces-32891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0125914918
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 13:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498561F24C87
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 11:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BD713B29D;
	Mon, 24 Jun 2024 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XF8W2srD"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6A13B280
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719229600; cv=none; b=JXCpR71ufILXSh4oa61o3Jjtw5W/FktFEVzF/sSHkXk5GcLEJwi50YPaGvnm3f1xtNKi1nPRwfCu52s4s8xyhe2uogpchuxEVRj5/v17AVUkz3N0uOgww4JnEKa2bKE957PPS+JkcxVOOFRS7ahSS9ybf3alas2+2h91HZmgReU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719229600; c=relaxed/simple;
	bh=HTx8wnE3U2h8tlMymsm1WhTMmhSC4PbjI9XPYkCp9p4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Aa9ISTpo99r+lMlpcHZxAn+tsDjeU+ZMUB23ZnyfxpmnU9TWh3tNz82tMmhkvit/H4ydOjkTiqd5MEQcu/TrPgqFElVMq0G/Q9fj4Vnb756rVHJcH81UhCCQ7hSlViBQ3bucSJUR7jPAuUu7CqxjtKfXX26wawxcF+jeHlg41pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XF8W2srD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719229598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HTx8wnE3U2h8tlMymsm1WhTMmhSC4PbjI9XPYkCp9p4=;
	b=XF8W2srDTYC70w+5AWT0JA8B08v7kYwqTjrngatBCyLrMpIg4WBH7HP+TgSv6IcpBjhblI
	STHgbJQ4sx2uxmK5nZBGtPOoXb4RTCurI/ED526hOB0iXPAtGP1XWxYu65bQZ7PFjFPaFu
	XSIpFeIauuQxibuhUIJ9icYNU9s0DEQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-9n2kZcatM1mk4ZUMKdhbzw-1; Mon, 24 Jun 2024 07:46:37 -0400
X-MC-Unique: 9n2kZcatM1mk4ZUMKdhbzw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ec507c1b59so24597001fa.3
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 04:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719229595; x=1719834395;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTx8wnE3U2h8tlMymsm1WhTMmhSC4PbjI9XPYkCp9p4=;
        b=LPJJzwLQ+OdAfb2wee7kWr8qohRaseQHEXWMhKMMPsgukbpdmeNYIk0rEbrl0d16Kf
         1wyG8wijtPVSg+dfIuevZy/oAu/LCXn5hgbG2impkYJnI+0Qtx7Dm/MA05WTTCRhiaFy
         sp2Uj3aQuzhk69s0b4wmziuhZ0Wsb0bgH2XVHgsbOilNEUhE+PcmPNwe4eB757pFz9Ny
         mYhHJmiDJL1VZbyZT8q8IGLz/Rp2b2h08JVGXBuF1q4NGsXcRp+oinvYxgcOd1yANLpE
         9jQlD/Y1GJq52J3y/1ohaVJI7jCeyDGFAmtUpoTHBrqmEilpxNcexn+xd/0p6n0xyUb0
         ufmg==
X-Forwarded-Encrypted: i=1; AJvYcCUyVzMejlxz7aQ5kePyaOgKYLndakmo90/WYIlDCEYixnm3r7GmWeoVE+IXaObSN7WZgLd6KjYr+TNIKVOWrIW2lmCm
X-Gm-Message-State: AOJu0YzMhY+XxD7ehD6GkLGxxD+JGetnEV1SztfKjXYrv2K6IBRr1L2E
	Dhk2Ryx5a6eI4s+9YTc4HTKeDaKXbD2xGLo0V6wx37jENNhfRoJZSnz1KC5ZtVfY5Zlymuic2o2
	NqVBLHMjQeQuspR5jEwrvAd06c/IINQO8stZj/v0pMHgAYjO8Wg==
X-Received: by 2002:a2e:a17a:0:b0:2ec:4093:ec7 with SMTP id 38308e7fff4ca-2ec5b2e7238mr34003891fa.30.1719229595634;
        Mon, 24 Jun 2024 04:46:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJt/VG/AsIrl2IZ1SfnuzF+4i4QpAF4U0KYG5A/8dV/MMwb3a/AvJp8gx45wxoVrlyma0x1w==
X-Received: by 2002:a2e:a17a:0:b0:2ec:4093:ec7 with SMTP id 38308e7fff4ca-2ec5b2e7238mr34003671fa.30.1719229595277;
        Mon, 24 Jun 2024 04:46:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a725e9bd392sm40061266b.23.2024.06.24.04.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:46:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EC475138620D; Mon, 24 Jun 2024 13:46:33 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Samuel Dobron <sdobron@redhat.com>, Daniel Borkmann
 <daniel@iogearbox.net>, hawk@kernel.org
Cc: Sebastiano Miano <mianosebastiano@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: XDP Performance Regression in recent kernel versions
In-Reply-To: <CA+h3auMq5vnoyRLvJainG-AFA6f=ivRmu6RjKU4cBv_go975tw@mail.gmail.com>
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
 <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org> <87wmmkn3mq.fsf@toke.dk>
 <ff571dcf-0375-6684-b188-5c1278cd50ce@iogearbox.net>
 <CA+h3auMq5vnoyRLvJainG-AFA6f=ivRmu6RjKU4cBv_go975tw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 24 Jun 2024 13:46:33 +0200
Message-ID: <87ed8mftra.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Samuel Dobron <sdobron@redhat.com> writes:

>> It looks like this is known since March, was this ever reported to Nvidia back
>> then? :/
>
> Not sure if that's a question for me, I was told, filling an issue in
> Bugzilla/Jira is where
> our competences end. Who is supposed to report it to them?

I don't think we have a formal reporting procedure, but I was planning
to send this to the list, referencing the Bugzilla entry. Seems I
dropped the ball on that; sorry! :(

Can we set up a better reporting procedure for this going forward? A
mailing list, or just a name we can put in reports? Or something else?
Tariq, any preferences?

-Toke


