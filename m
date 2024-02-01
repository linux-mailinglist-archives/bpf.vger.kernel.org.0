Return-Path: <bpf+bounces-20983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E074846095
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 20:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5EA28BB15
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 19:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CA985266;
	Thu,  1 Feb 2024 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iu/WaaK4"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF1482C64
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814181; cv=none; b=oXGObolwqEIPEk/i25o/Ag8CXZLTSdzQjG58TSiKN5TxBaFR7AfvFQBU0sFjKRK7XhB47zNrOrSUBMsCg2yjIw/ceiuRKXP6Sqf1TQEq5ZiKteEk7/xwBm7AZQpCYEwuH4KfK2aWpMI/ZbJw8r7H3vWFAoDjHeudjuDU7dRVq7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814181; c=relaxed/simple;
	bh=Acifw2aO4y44QZkkG4j8Gu47MIJAm3ELhRCF0CUk7Ec=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4Gr7W0ETgtgSvcd71tKm8cp2iFX+XB5drmUdEfb+xDF3AJzPkN458lg/jcM+J8LnR57WMmDjaSIukHDk05+5tQpLa5POPRwgF0LZ10tyJL0cLjw6lEoF1RqZesME7VYDjzQLmuap+B61kQKNlSym7J12tdpGMejyNE4fOmEOM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iu/WaaK4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706814178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Acifw2aO4y44QZkkG4j8Gu47MIJAm3ELhRCF0CUk7Ec=;
	b=iu/WaaK4cERRASWUSZwG7ja12LRSKrGoFOclRB1HBq1DnlDHH7JGXaNzlWwNJ5aynH59rB
	IXfZ2FXkjB8XCQcztS8YIHP6kvqiWkmBVNy457EKkHnaHpagbxOZTZVKvqp1rZ9hD9bqUr
	sbUDK+se7jOAZJcGLOKjySxIr6utz3c=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-oeRWzVHtNSej2gC9QTLsBQ-1; Thu, 01 Feb 2024 14:02:57 -0500
X-MC-Unique: oeRWzVHtNSej2gC9QTLsBQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d048c320eeso12167141fa.1
        for <bpf@vger.kernel.org>; Thu, 01 Feb 2024 11:02:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814176; x=1707418976;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Acifw2aO4y44QZkkG4j8Gu47MIJAm3ELhRCF0CUk7Ec=;
        b=oJcslC84VYdgPPwnjj93HsqASvSMOtUMCHVL06HVFLxPu9fM2fD4n2E6XBnvqT74LX
         5Gb1lmW9NcJGB54Zcyk5FioaGNC9H13q1avMjldmihaSoEVUbuLSmeJ2EOSsy2iVIEGY
         VvbznzpdnmlXbOqc20IciM8b7UirOb3twutAMDJTnM30/d7PIunogPcqrPTE3gzQ5cOM
         p/gjAyFe1koaMYSBB3VbDbMoOGYEulaN+PVe6dyl1fmV2WEFRE+IO4CcBMw6hU8SmsED
         prtVSTcU8MhsxV2pAdmy85Y5U+7w/PlpSNlwlo5u7DgryfpGiB3wRNZvnlUB8pHlbZ0p
         zbvQ==
X-Gm-Message-State: AOJu0YzobO34j7oBYJDXF7yndvEE0wrLnI541XQqAVzFVaIgkJynbzl0
	PHiZ6kmhdN0FM3q6PseU8If6LbnFQMgyk/wN8jYRvfiNYHF/z7fNjN8ZWRDFZJoX0T08NP3x37a
	q3hIRuB7KLynUw2bzk3H1xPuKgpc2OTqHtJBcLCCNMAHjKwZIGrO1l4hBO8DykHgc3gK1Efs6yB
	uXDpBFIX98ulU9XFF4Zz602MYC
X-Received: by 2002:a05:651c:311:b0:2cf:276f:83e3 with SMTP id a17-20020a05651c031100b002cf276f83e3mr1803368ljp.28.1706814176011;
        Thu, 01 Feb 2024 11:02:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEy4lBH4E+hDaZ+LWF/+yr0kHTmJHCD3X/mQ+0iuenxVQPxxPHjUJJGsksFSXcvp8DiwsHDdMKJYLId4rRMLNU=
X-Received: by 2002:a05:651c:311:b0:2cf:276f:83e3 with SMTP id
 a17-20020a05651c031100b002cf276f83e3mr1803348ljp.28.1706814175691; Thu, 01
 Feb 2024 11:02:55 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Feb 2024 11:02:54 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-5-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-5-jhs@mojatatu.com>
Date: Thu, 1 Feb 2024 11:02:54 -0800
Message-ID: <CALnP8ZaqDp1e5qRQ6o3cs6bSt1zJ+m6u3CpVoWsN-nLbAb76sg@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 04/15] net/sched: act_api: add struct
 p4tc_action_ops as a parameter to lookup callback
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:50PM -0500, Jamal Hadi Salim wrote:
> For P4 actions, we require information from struct tc_action_ops,
> specifically the action kind, to find and locate the P4 action information
> for the lookup operation.
>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Vlad Buslov <vladbu@nvidia.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


