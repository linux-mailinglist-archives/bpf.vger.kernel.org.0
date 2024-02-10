Return-Path: <bpf+bounces-21705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD478504BB
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 15:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F001C20D5F
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 14:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A705BAC4;
	Sat, 10 Feb 2024 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSHrau34"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28B9364BA
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707575645; cv=none; b=eUB9ZflaSFCs+Ry2rBE9lQbNRi/ERKAV3pCZ4cnnl/jFkX9mojN9DzIKi7RjhOHgImETjM/Mt9JejStrLuSGE9psl2/vl07pshrmBAEGx71smxCQE2Z1dRNFbo9dVj/MjKcDd4JGgNd/IX58j4nygQCZIc3BI8I0jKoZnuauuxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707575645; c=relaxed/simple;
	bh=JrxDib52UG/Eb8nWQCU2M2fdjl6LJobAMyy2htoutmc=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmm5Vu7sKQ+jOdhMnBpaFea4uVRhq5fTWYD3BBizLDUx5T2tyLMHoxhtTipa3scNPFumb1B3hE908OeAg1eaLRvPS+TjznD6FN8q8uijYa5bO9YOJndNIAZVGtRYzbMODYG74B8lETxzVz8PvVQe2aX84vmfdZXrayKkZBWLc7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PSHrau34; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707575642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JrxDib52UG/Eb8nWQCU2M2fdjl6LJobAMyy2htoutmc=;
	b=PSHrau34Hc2WJWrBVPvhCAcXBhnZ25e9/S2S39axGq4VS4hrNRksGe9hPyzfYGu6IgmdS9
	tyGDOrIkHHjq4a+xWfz7lZPdixA+24/dRRCajDwMeHekwkmSPS4Bxb7QpAZU38J76FRkdK
	RDUBJCR5GSee2gbcHurZPMSIv4Af8cQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-Jak6Q0DFM9WIjQ5_YxNZpA-1; Sat, 10 Feb 2024 09:33:59 -0500
X-MC-Unique: Jak6Q0DFM9WIjQ5_YxNZpA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-561601cca8eso276385a12.3
        for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 06:33:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707575638; x=1708180438;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JrxDib52UG/Eb8nWQCU2M2fdjl6LJobAMyy2htoutmc=;
        b=vTUddqZcwZFv+Ba03LXdR1wmzsBRZmfIT6qAjmVpo6MBx2pkN7Unu52yPvr61Be6Pe
         /SpWokxK4C8f6jjavQ4luB6FZdhMJNs4dOcPyOPNt3GKZ7mtCzbQGnRRIcHF5PmRM40q
         oJPfhlOq5z6jqpWMFppC8PQrPyOY179L1jGAK0G/zxBnE6olU0IdROArx8WEZIefKDr/
         7Yl7oYHo2+ORWsdsxJVZSvAMOyNd/ejkqh/fW/cMoqweHjPHsfCSdIJ9MKycGeCai8aP
         Uj0ariz1Rp0xCY0EOAX4fEwvGPfjY+YpQlUO7ws5oc7vHYtRjXn7ZGTyddo4HYGf8tu7
         iXXQ==
X-Gm-Message-State: AOJu0Yz9UFfxYXY+JDCsbfvbwMjTboKnTZSPIGqsimb1fpAx+h8lw3Sr
	1QhRnD68ampo4O879I8PzDx98NxbdSVstBXglAPGyp2OWdQrMn9n3iazb9lhbt6x0orH26vZazU
	xma+iaDUHywRkdLU9LaEDXGbSsckXTrX4qqKwh5h76PvyK3iZisocsUiT/f8/mXoTWHgUY0mDqf
	+kJrU1yGVDcnHM/aiMpT+sJ2jq
X-Received: by 2002:aa7:c457:0:b0:561:55d1:371a with SMTP id n23-20020aa7c457000000b0056155d1371amr1139980edr.41.1707575638712;
        Sat, 10 Feb 2024 06:33:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMzEa0bLcFMd2O3IO1pyXYCkJt2PEVRcgC5pq7ur/ODwsmTrg25woeMT7rR51EX2mTT7OxAjYJDc/4zWiRwz0=
X-Received: by 2002:aa7:c457:0:b0:561:55d1:371a with SMTP id
 n23-20020aa7c457000000b0056155d1371amr1139962edr.41.1707575638206; Sat, 10
 Feb 2024 06:33:58 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 10 Feb 2024 06:33:56 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-10-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-10-jhs@mojatatu.com>
Date: Sat, 10 Feb 2024 06:33:56 -0800
Message-ID: <CALnP8ZYvrZZW7arqEs1geyt=peukjBB-EHi+VL0qKD=zWOj0VA@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 09/15] p4tc: add template action create,
 update, delete, get, flush and dump
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:55PM -0500, Jamal Hadi Salim wrote:
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


