Return-Path: <bpf+bounces-45348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 227349D4ACE
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 11:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C9D1F22C00
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 10:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F54F1CCB26;
	Thu, 21 Nov 2024 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZQ4LReN"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50391CD1EE
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184580; cv=none; b=R8pyE4wVXvLcVSArgya2irHDwMapPTybVOUVOsLobCVkLNGbQhS/jZ14k8oLlnNEad33NmMRgY7jBithNbO9C2j+RxlQCyn1AE3tVNlqCKnl5JAk3WMVzeEyjBkB0UddsRCn452RXWtc++7JhwgbVL/pSHYL0jKltAELyu+P5wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184580; c=relaxed/simple;
	bh=MEEW3GaIo/BZ3XAUIwizKD0IUMvjTjImwRsmnJBN/y0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gxJoFmXVahQqbFRF8Z3aGPO5t3NZdQ4NXZZ3M8W9iVW1TWz/EuRLGgaPfV7adCoh322xAtpL6f3SF/B6sAyt3r6x6LRTz4eGUOEFY+1GevNeR/HGmw25MQJdb57SNYVfehoMY+2R2nTvBdLd8RK/qXHvqTLvOSqTnuqvJMDiBGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZQ4LReN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732184576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MEEW3GaIo/BZ3XAUIwizKD0IUMvjTjImwRsmnJBN/y0=;
	b=UZQ4LReNOfU6qs8+Gk/ZS2u7RdwiHncWxPnclThDms6ALBah4Qi4XmHVKkV2z5O9R+OG0E
	NV+VcAF5VuWqqYmGlAqM3ezQaC8f8qVKqBbg32/Fa67dubbI79Cpx/B78S6c/8heD/Ene+
	5uC7Xd+9yA8kl9F0UatcDHe2qYTWze0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-T_1vY5ItO-KYno-UuoanBA-1; Thu, 21 Nov 2024 05:22:55 -0500
X-MC-Unique: T_1vY5ItO-KYno-UuoanBA-1
X-Mimecast-MFC-AGG-ID: T_1vY5ItO-KYno-UuoanBA
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9a1af73615so50711266b.0
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 02:22:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732184574; x=1732789374;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEEW3GaIo/BZ3XAUIwizKD0IUMvjTjImwRsmnJBN/y0=;
        b=qEYbS0HGyLSt4lz0+Y2nLvYV9TKEUXcyusezLu8Fhb79G5Hi441JDatKpNDPF/aUyh
         2HFsvPEuIO8wdfjHFdgVtqIG/81ccaNwyObDAM/BuyiJDRynwQzDRps2Hx2nAI/qZK8H
         lATee24NYgxDYNyG9UU86EB+SbUIKvW1QN67xeswPsGO3zHHxkwXx574e/nYStb7tw06
         ktslaIqvyKw11ylVynYGsG2TGNhLVUu+k8aejjT1p+fGMdRliCHHVNal94CoXLWB3uSx
         +3GTc6POcgoPABZ9wZSF6pnaVUePCK4Bkj6y+BRBiP4ljlVOS5lWhPv64Ahl2wqjhLc2
         dHmA==
X-Forwarded-Encrypted: i=1; AJvYcCXiApimLdet7mOTMA7P0nyRFin75DAys04fHjy/e13Bm5uzQjs8GbooHPMQUlXF5Ld3HVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTy/IUuShUsBc+ysbZAWX7eNxrYwmki8JQO+JX3ePAGP0REzg0
	zrzHQzvgyW/j1wygWb2ON8Ld8q/nhCmoCK8IFgdhmsB2YxU1wV9Lf9T68WS2p4a9O7H0iTgtXQS
	rcdm4qWYXHjfP0oeKn6K+qfd5QtAMHBkMuudOg+pXXXSpAw3hqg==
X-Gm-Gg: ASbGncvzXLC68zVwh1+nB3MqTC5Akvwj1q/TK4Qlj0CavNfo4ZtOy9bJ0DjszE83doM
	sQQP6K6zbhrsvko1Gj2b5yC9RDm9KnwvOZOa7wpyrx3jbbiyolFdbSsbUdPzW6YcSf2U7HF/p6x
	TVxUQUzZTwLwyMrNXnlP0xsirb/keOBZJ2sIK+5Q/0aoK/nS9/zI9saGn/mWEGTQHcftjv1uhxw
	nL1mFVyIYvx7qZm7WnvO7CD7qyzsagM5t9yZAp0mCTHxNnCk9g1Y/RSmdJ6MNsJlP/6oRSpmsc=
X-Received: by 2002:a17:906:da81:b0:a9a:6477:bd03 with SMTP id a640c23a62f3a-aa4dd71b750mr659101966b.38.1732184574445;
        Thu, 21 Nov 2024 02:22:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFm2wxojHyCsmpPj5AcS5tr6hu0mr2MUwhZGu9tXey0poXKu7ocPeRXDl+vgXp1X2FfZIdlnQ==
X-Received: by 2002:a17:906:da81:b0:a9a:6477:bd03 with SMTP id a640c23a62f3a-aa4dd71b750mr659098066b.38.1732184574093;
        Thu, 21 Nov 2024 02:22:54 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f437ff05sm63292966b.191.2024.11.21.02.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 02:22:53 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 790AD164D8D4; Thu, 21 Nov 2024 11:22:52 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, houtao1@huawei.com,
 xukuohai@huawei.com
Subject: Re: [PATCH bpf-next 01/10] bpf: Remove unnecessary check when
 updating LPM trie
In-Reply-To: <20241118010808.2243555-2-houtao@huaweicloud.com>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <20241118010808.2243555-2-houtao@huaweicloud.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 21 Nov 2024 11:22:52 +0100
Message-ID: <87h680j37n.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hou Tao <houtao@huaweicloud.com> writes:

> From: Hou Tao <houtao1@huawei.com>
>
> When "node->prefixlen =3D=3D matchlen" is true, it means that the node is
> fully matched. If "node->prefixlen =3D=3D key->prefixlen" is false, it me=
ans
> the prefix length of key is greater than the prefix length of node,
> otherwise, matchlen will not be equal with node->prefixlen. However, it
> also implies that the prefix length of node must be less than
> max_prefixlen.
>
> Therefore, "node->prefixlen =3D=3D trie->max_prefixlen" will always be fa=
lse
> when the check of "node->prefixlen =3D=3D key->prefixlen" returns false.
> Remove this unnecessary comparison.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>


Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


