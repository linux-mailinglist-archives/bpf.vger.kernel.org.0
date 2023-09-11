Return-Path: <bpf+bounces-9625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7BC79A6AB
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 11:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA551C209DB
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 09:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DCBC129;
	Mon, 11 Sep 2023 09:20:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD37AC121
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 09:20:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE71ACD3
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 02:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694424031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bPNf+LMH2dPWsk1O9R4yW1taYmiwMEwNxmfzPkZ8n54=;
	b=fTvuAB4+L5f4QO53dDmctIhh3b9NnS2qpTLhoa+T0Ci9oebJi5p2jEX+baT8FUO9I9LlNq
	z7GwwiocgFRFbesFvk8UCtr8P+l1Ys6//7NffSz9f815SkaFYLpTyciOhhsNDTEQlOWHK0
	jvMQ3rQJ4D+DdcCmkyojShRVCHPoWTc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-GAevZkZbNHKRlR5d1RXapA-1; Mon, 11 Sep 2023 05:20:29 -0400
X-MC-Unique: GAevZkZbNHKRlR5d1RXapA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-993eeb3a950so291567066b.2
        for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 02:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694424028; x=1695028828;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPNf+LMH2dPWsk1O9R4yW1taYmiwMEwNxmfzPkZ8n54=;
        b=HE18mnO3wxkKkjPSgrHmaKiKEdmT1wizCtHqniXarNjvfkV0xkh3T46PSiey7SJ20y
         Do1sU4PmGuHftgxiImyNanAJQlSdGSaftF0d+/dSYgVs0szUX0Qlr27wLvHC1Toh+Cd3
         UfPl4/vjBlnV9XYxcRXc2cT7nLrOYsqejfXeMjK/tAJLNGbRzV8dK8govNxDFFLlO73Q
         7wDqtYENIr/8aVhcmRJy/EM8ejYg793A5XpiCqCD4s/SlJm7rgjq28sstMxoGjkLCS9J
         In+CpAYtBPL45vdrJRGTUT6HytTkb1Q6BbMvxcT29GT/Xn9yxaGwgS2x9LPT3Fr/cA9h
         JFtA==
X-Gm-Message-State: AOJu0Yx7CWe5aFMgRKU40t7leyaavnDDMZ5p8WHf2LklnA6HJg3BzHPe
	QsufDFVRhlloLicKI1h/AmL+UanDiqNf/m7aZCVpAMtEMntL21q0HUVwcu6MYCHmwq4kv5TJK3N
	cjhC8cmIOp4CA
X-Received: by 2002:a17:906:24b:b0:9a1:fc1e:19af with SMTP id 11-20020a170906024b00b009a1fc1e19afmr6786243ejl.36.1694424028611;
        Mon, 11 Sep 2023 02:20:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGijDggNvdmqYqoLEDD9Wp9ri92BPlaUPd4uWRjxNU59f99NwK55C+xsHG7LTncUSgylxp7Hg==
X-Received: by 2002:a17:906:24b:b0:9a1:fc1e:19af with SMTP id 11-20020a170906024b00b009a1fc1e19afmr6786233ejl.36.1694424028295;
        Mon, 11 Sep 2023 02:20:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id z10-20020a170906074a00b00993cc1242d4sm5019863ejb.151.2023.09.11.02.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:20:28 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A1042DC709F; Mon, 11 Sep 2023 11:20:27 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH net-next 2/2] bpf: Remove xdp_do_flush_map().
In-Reply-To: <20230908143215.869913-3-bigeasy@linutronix.de>
References: <20230908143215.869913-1-bigeasy@linutronix.de>
 <20230908143215.869913-3-bigeasy@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 11 Sep 2023 11:20:27 +0200
Message-ID: <87msxtkqw4.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> xdp_do_flush_map() can be removed because there is no more user in tree.
>
> Remove xdp_do_flush_map().
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


