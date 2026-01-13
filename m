Return-Path: <bpf+bounces-78684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69444D18142
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 11:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1A5C302CF62
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 10:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EED33161BA;
	Tue, 13 Jan 2026 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLxVIXLS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/BldoKD"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820A928314C
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300501; cv=none; b=ElTmxQU5Q5HfMrFjEpGpGcmlaKPKWENUhmIAsqErTtwS2doNE6V6K7QjBjRf0WJISm5t8XQAfS/6xGFxrLDb1GmeYxHS2T93ju6+gaXGo/LeMxIt7PUtUe1T9J6s22bQNBW74BSOSAgvy4WC4Lzbbk9niv0CKkJHCFt1+NmgS7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300501; c=relaxed/simple;
	bh=Ce/nJEZGmO6L0kVT9kwF9kuqtSrijP123A9vTXnzjo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGHwg8xdo5UGksc4zhR2///C04IgVCg9+KTlsfKcwS24O7Z3PC7CXk1Ws+4SxLzvPlmB5yp55Wfc0fL8V/5CRSaUkmH5boMvCyIBG2fTmJGiTtbee9xhzvxClmjdILdMr/3yzdjt71mbLt7WAMLwEfgcAFmtCFo9USr10nzzdw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLxVIXLS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/BldoKD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768300498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rp88EAkvfg7NazK48Kg9GATXkhl8V5Ket6LfkoWWXus=;
	b=hLxVIXLSIx82KCrBqxVHv7uGcuTpw5x0BoTbOcaQUtxgJXD4szDVENDVmSLj3INUxbszTt
	Mn7NeN8Yks00K2rEH5rveW2iLZrGVNuc78gWxhMzKLU7jilp5O3mJRKuQTBD6szadNM72j
	C1z1GgF6hSlxBrJMnuFu9this8jKumw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-RX6mHDk0PPycTAdmnMqQMA-1; Tue, 13 Jan 2026 05:34:57 -0500
X-MC-Unique: RX6mHDk0PPycTAdmnMqQMA-1
X-Mimecast-MFC-AGG-ID: RX6mHDk0PPycTAdmnMqQMA_1768300496
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso57717515e9.2
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 02:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768300496; x=1768905296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rp88EAkvfg7NazK48Kg9GATXkhl8V5Ket6LfkoWWXus=;
        b=I/BldoKDFrmM/AO6uquFDiuDV89YIRCDuCy+/EISJHa8n3W7Qy3XKx+h3cpF55rgS/
         3k+/857zy66cTkNp3ajj5M/k+57No+J/t52KsY4k4Iw3mQEZtktNa86w2HRePSs4k3nW
         StyJVv/a1fHz6n6EerUaD/TTE7fuh+2LWUIAaV9eHAeDPrOMpSQpOtdnqvchwMTj+336
         F5acjg1VpS1qdlOO1Dw/hPb4EDd6Vn6o4Yg3JJTWmhmFlgFfIwp7TVWD4y4fCbd9jzD6
         +YyUsQO2gj2pfTcxoTNfNbTWaTrHXS6OLvHKnRS+onyFaE+me9f2MWkFkaI4ROJjdule
         QOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768300496; x=1768905296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rp88EAkvfg7NazK48Kg9GATXkhl8V5Ket6LfkoWWXus=;
        b=JP3tNFq4+hpFNzUTGXAlWV+uzMxKIaH9+d/DrnpQFvARumfsXkdOBat4w0bh9M+2fX
         kYrzDei47yj/FRwWRhgHrDo3bcZ9ph3wKbr8iE29iVpICb7lAQqu0pNM+uNqM3h9xTTj
         Lbd/lu9z64cHunvmH6TcBG0yZ0n0tWnu1m4fftEWI/qDXb5OYO6HYJhmkZR/6AsIC6XC
         mi2OKsh17e3wAM6EukU20dD8LTAUFDD9YiAbrpZI7XUSJ3A0u8SE6qL671fZhYUSewy0
         1J9GIZp/MXR+P9kQUXizB1juSdgq25cVyoJdoG5y9AIGv6Z7MRupGswlOFcI0j20fADi
         Jgnw==
X-Forwarded-Encrypted: i=1; AJvYcCVHxWyTCG5oEHDv+VUzPIaD6WnMjM/du1pVXUvOwGjlRPWxtSDi0mbbF9Um+HEdEKT3qhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzJP2L5F7Bk/1uZlA9UCKToqIiT/51Bg6A+vE+LYsG91U6H4G9
	8I+B3C34FOlxrj6PeUSp8Exf5vTTLT8iFxhwBByBWheKgh1ogib+8ByEo1r/URwW3gIWBNA+ObL
	mBBe6xFNYk94U/FlY2PYyuCzuHrSCxrxy9xNSzAzSryvVoiS2of+nVQ==
X-Gm-Gg: AY/fxX4hqSM8f8uUjdYMoocKo0s2V6bbEevswizgejvc38eJDLVUDhAWG4EzzWwKXdW
	OOoF4wCbvN19S2C8s1MSBYJ9gi9QGlUxze8ZQ9nmAoMWO6KG22GFUzOumJpLgl/Pby33cGm86Hi
	KipaUwLwLGF5nqchtwYXVjXEh/LdmbhtjxFLC4WnRPvgAhCASkicBcv91KNfFeM6Oc0T6QnDyGV
	kzJ0TnHMzz461PVWwVgf5sdcxGzzacenXrHBrZReQNzPEWJOzH+v+gb0HHiXS4BXOULhE8XFF42
	laAOyt0JJlr8lcsNSxbkJdgiTFuFyoiapk8V/JTSTYyjdunqU5egA7ljruw6F71UrdE8HJUO9PD
	wmAKOwIP3cpIZ
X-Received: by 2002:a05:600c:3b1f:b0:477:8a29:582c with SMTP id 5b1f17b1804b1-47d84b52b9cmr217868265e9.34.1768300496039;
        Tue, 13 Jan 2026 02:34:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH39g2T92Y4/kmCEQ96bzsNq0jo0zpd85gtHjgmQsLxOO+v0ajp2k6EhijDpMlzAG7BPPZlZA==
X-Received: by 2002:a05:600c:3b1f:b0:477:8a29:582c with SMTP id 5b1f17b1804b1-47d84b52b9cmr217867695e9.34.1768300495534;
        Tue, 13 Jan 2026 02:34:55 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm414015045e9.7.2026.01.13.02.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 02:34:54 -0800 (PST)
Message-ID: <6d4941fd-9807-4288-a385-28b699972637@redhat.com>
Date: Tue, 13 Jan 2026 11:34:51 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 8/9] selftests: iou-zcrx: test large chunk
 sizes
To: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan
 <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>,
 Alok Tiwari <alok.a.tiwari@oracle.com>, Ziwei Xiao <ziweixiao@google.com>,
 John Fraker <jfraker@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Joe Damato <joe@dama.to>,
 Mina Almasry <almasrymina@google.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, David Wei
 <dw@davidwei.uk>, Yue Haibing <yuehaibing@huawei.com>,
 Haiyue Wang <haiyuewa@163.com>, Jens Axboe <axboe@kernel.dk>,
 Simon Horman <horms@kernel.org>, Vishwanath Seshagiri <vishs@fb.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, dtatulea@nvidia.com,
 io-uring@vger.kernel.org
References: <cover.1767819709.git.asml.silence@gmail.com>
 <bb51fe4e6f30b0bd2335bfc665dc3e30b8de7acb.1767819709.git.asml.silence@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <bb51fe4e6f30b0bd2335bfc665dc3e30b8de7acb.1767819709.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/26 12:28 PM, Pavel Begunkov wrote:
> @@ -65,6 +83,8 @@ static bool cfg_oneshot;
>  static int cfg_oneshot_recvs;
>  static int cfg_send_size = SEND_SIZE;
>  static struct sockaddr_in6 cfg_addr;
> +static unsigned cfg_rx_buf_len;

Checkpatch prefers 'unsigned int' above

> @@ -132,6 +133,42 @@ def test_zcrx_rss(cfg) -> None:
>          cmd(tx_cmd, host=cfg.remote)
>  
>  
> +def test_zcrx_large_chunks(cfg) -> None:

pylint laments the lack of docstring. Perhaps explicitly silencing the
warning?

/P


