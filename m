Return-Path: <bpf+bounces-11122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB437B3930
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 19:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 34A802840EF
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 17:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E148E66673;
	Fri, 29 Sep 2023 17:52:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE514175B
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 17:52:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A960E19F
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 10:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696009924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrhgtFn3DqnnanRjqqwM7PgR1zObGJV8iFjkRmEB/KY=;
	b=TccIfqwHhuToe7I1OvUAy6T/C7maikccpIsJF6sdAPYnKYjsNBGpPFRwp+2Mihmf+NRBT2
	DmX8A9kbUaN8AIDSEKiUDmlS9fhZqmEJA30WY6JNcSc2lNHAVFeRl4K0mr2PNuxnvIPl04
	lbGDqfwVxiCGdgZWblOZc3A4ILwGTBs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-pv8KuFtzNFSSnuSuBBEkHg-1; Fri, 29 Sep 2023 13:52:03 -0400
X-MC-Unique: pv8KuFtzNFSSnuSuBBEkHg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a348facbbso1216546866b.1
        for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 10:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696009922; x=1696614722;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrhgtFn3DqnnanRjqqwM7PgR1zObGJV8iFjkRmEB/KY=;
        b=uOYhx5bcgkKDcKSIdu0TSx54WDNGhKBJzah6brbAbicVajPbJfF2JiGAGfyJKFQRx0
         yNYq2rKOJQa8/VjgG23zVFtsnSP4tbmYrR81OKsfpYZpTjiQqALlNCMKJao7KI49bc6a
         HGx0TzLfAgbKiC8QMQV+TKmiPZsx5ZRMlvWJeLyuGIKOB4NOAl4kOWab9A4ELhD1Uarv
         JydIr6ER5pp15Z1kJsOdATYtrmljRVo6p2qV2r1gkWSJv7fVE5Bj7PLIJnnsuLzMqeir
         Lhm2qjdq7rAOCTTZT/77KTWBcpxJo/zCFDlgXhTH66wgmHF0waHunoAPYZSAoXuFSPzY
         xGTw==
X-Gm-Message-State: AOJu0YxGFSu2SUjmRobw4Ke0Vyc/5sCT7vjZB/q0fgAInVBpSloVw4WQ
	hWErpxR3k1EJDi3YrOTQyB5X5pLIjRBx5jXG/p++hdKQpu6cSc1TggkCQG2rYZoCEprHJUOVuQQ
	qzaB/odwA2B1z
X-Received: by 2002:a17:906:76d2:b0:9ad:a46c:2936 with SMTP id q18-20020a17090676d200b009ada46c2936mr4601755ejn.8.1696009922122;
        Fri, 29 Sep 2023 10:52:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMba+2B05k7z2zqtYzOtyT/Ljy4zOkaZz84FGS1ez9Jx2bLtNxL/R8mTeJYLXM5nnxadcn9A==
X-Received: by 2002:a17:906:76d2:b0:9ad:a46c:2936 with SMTP id q18-20020a17090676d200b009ada46c2936mr4601723ejn.8.1696009921735;
        Fri, 29 Sep 2023 10:52:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090619c900b009ae54eba5casm12762989ejd.102.2023.09.29.10.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:52:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8BC3BE264A6; Fri, 29 Sep 2023 19:52:00 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, =?utf-8?B?QmrDtnJuIFTDtnBl?=
 =?utf-8?B?bA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet
 <edumazet@google.com>, Hao Luo <haoluo@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jonathan
 Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Song Liu <song@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Thomas Gleixner <tglx@linutronix.de>, Yonghong
 Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next] net: Add a warning if NAPI cb missed
 xdp_do_flush().
In-Reply-To: <20230929165825.RvwBYGP1@linutronix.de>
References: <20230929165825.RvwBYGP1@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 29 Sep 2023 19:52:00 +0200
Message-ID: <87y1goc1fj.fsf@toke.dk>
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
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> A few drivers were missing a xdp_do_flush() invocation after
> XDP_REDIRECT.
>
> Add three helper functions each for one of the per-CPU lists. Return
> true if the per-CPU list is non-empty and flush the list.
> Add xdp_do_check_flushed() which invokes each helper functions and
> creats a warning if one of the functions had a non-empty list.
> Hide everything behind CONFIG_DEBUG_NET.
>
> Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>
> This is follow-up to
> 	https://lore.kernel.org/all/cb2f7931-5ae5-8583-acff-4a186fed6632@kernel.=
org
>
> It has been compile tested.

Both with and without CONFIG_DEBUG_NET enabled, I trust? ;)

Anyway, LGTM!

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


