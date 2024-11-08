Return-Path: <bpf+bounces-44363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447E69C2266
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 17:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038E9283F46
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 16:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B4E199949;
	Fri,  8 Nov 2024 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzXA8GiZ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A8C199FA0
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731084437; cv=none; b=NDB1xgn6qwMQ94zzaKd5u/oZcB0/sCxfE23kPQvVhb5HRdwPbsBlqztY+FAJ75GOqiR9M5U+lNFDqaUGZqX+uTInBkvJdV5BosBfTZOXZIu2S9jqAI+nLbNNXcFMeBhn/mlzonjXvNTdqwMIodP3EBPWgdG7vxVpXVPnW+tmvwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731084437; c=relaxed/simple;
	bh=0lLMdGizi93nijTSwK9kWAvMKhLEV+7wHUhXjPx6HlY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YHrRfpglnUzeSsZP85q1txMq5loTvHkLlB43MRFknj79gY4iyhEV2Ba75zrVjhuZYL8TP33rYORocNI/24YLvJjYDYf93N9yywqJGMj7uflJyHGmFGM5NdQ1OcmPn/5bLi/rBdogLob24Tlsy3xFJD20gYo5a3oB1m1r33LRpsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LzXA8GiZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731084435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9RDh7MpNoknOhG/SnT1LyEVJ9M4KJkBIbyiebXiQISA=;
	b=LzXA8GiZggr2hfM+4qE2fM8bpU0IsPgRS+tmfxxIe2eshi5FlEMnWN046ZzCENECKiCoKs
	h7+fq8zN0uVhUiTUaEpGYhQzMO/7ZawtB+c23HKaIb+/IPvm1ZkuoEYgzFYmSxHSbH3SOt
	GFd2MC85rzRI2WtqHEgrlWM3wVgbvDk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-A10gSYdxMemBLyKnckcWkw-1; Fri, 08 Nov 2024 11:47:13 -0500
X-MC-Unique: A10gSYdxMemBLyKnckcWkw-1
X-Mimecast-MFC-AGG-ID: A10gSYdxMemBLyKnckcWkw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43159603c92so16006435e9.2
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2024 08:47:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731084432; x=1731689232;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9RDh7MpNoknOhG/SnT1LyEVJ9M4KJkBIbyiebXiQISA=;
        b=t/9SKsR3geFxmJ8N8qZPX3xy+Nfs6M5mBlx8jYYl9VH7ziEbMY2EJPXv/Ai0CYHMJS
         XdY03/0y3w1R77B6Pij/C4mfN3y4Dif+JLpC5gcCs9m/LrvQ4vnDAtQ52lhQW0VVFCXd
         LrFLgMdzFFJlTcO3cfKXDsNImtDXTKXLaBwCPIq/JrfHLdQMOsja8FjJJ7oL2tj4kR4E
         EBigAmiuOw7vpmod915+hVCIkmyG9jgUkkPAziU4qxHpL2jeFt9pEu01kJUti4p+5W7B
         LAHB8Je1lh1SxOdksJghBGLNBqAEtsaY0XKlglnV2oLHhttkikQZPK8fCzZ2wwki2+5q
         eDkA==
X-Forwarded-Encrypted: i=1; AJvYcCXSwYo75Ap3w+eedcHiXn8m8FvK7CteK/qN0gAERaP4dK1I1P8jlvNRHeKw5yeuBzMyPjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGKG8HFGz04NitHPHVLyjdHeeATCwsg4F4nt7FS4awvRAyE67w
	yPrXTtAxcNnE1SXn6RvjpEQDT2IKXfahaJVH9BDDfvHu58mrxbgXZrn57Vx2Si2UqOyVjj+0Zjz
	MtgmFpLxNadBQtp1RvCi1s1vRQT9BnfCDrXcIS7Mw5+Ek5z+0Ww==
X-Received: by 2002:a05:600c:1e03:b0:431:518a:683b with SMTP id 5b1f17b1804b1-432b7509b0emr31787325e9.18.1731084432322;
        Fri, 08 Nov 2024 08:47:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfye8wQ+Ub3J2hSnZSk8IV9NqHWPlOvi2LP4ozJe+YluRNffApaKLtmgQ4CI8rzrfOsT+aFg==
X-Received: by 2002:a05:600c:1e03:b0:431:518a:683b with SMTP id 5b1f17b1804b1-432b7509b0emr31787075e9.18.1731084432014;
        Fri, 08 Nov 2024 08:47:12 -0800 (PST)
Received: from debian (2a01cb058d23d60039a5c1e29a817dbe.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:39a5:c1e2:9a81:7dbe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5d1bsm77791935e9.40.2024.11.08.08.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 08:47:11 -0800 (PST)
Date: Fri, 8 Nov 2024 17:47:09 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, bpf@vger.kernel.org
Subject: [PATCH net-next 0/2] ipv4: Prepare bpf helpers to .flowi4_tos
 conversion.
Message-ID: <cover.1731064982.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Continue the process of making a dscp_t variable available when setting
.flowi4_tos. This series focuses on the BPF helpers that initialise a
struct flowi4 manually.

The objective is to eventually convert .flowi4_tos to dscp_t, (to get
type annotation and prevent ECN bits from interfering with DSCP).

Guillaume Nault (2):
  ipv4: Prepare __bpf_redirect_neigh_v4() to future .flowi4_tos
    conversion.
  ipv4: Prepare bpf_lwt_xmit_reroute() to future .flowi4_tos conversion.

 net/core/filter.c  | 2 +-
 net/core/lwt_bpf.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.39.2


