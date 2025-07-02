Return-Path: <bpf+bounces-62087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F19AF0EB2
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 11:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6051C24C69
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 09:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679FB2405F9;
	Wed,  2 Jul 2025 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6fk/H7g"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5CE6AA7
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446906; cv=none; b=Mtqyl/VcHViRS4eDPRpyKqJaVSEYy/BTEgbBNxp1VFsz4V3F0gFjEE39LffGb3Om7kh1HU2RqVpvTvW+kaiGcx32QmO+Fk5AFM37CHGl8urX1xBHwW5g/M4npoBGEV8NVytTPWuz+rcPvhwCEyIJswgM1bNlrq82LViYjmw1tR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446906; c=relaxed/simple;
	bh=rT/1yTCUYgsKJSyTh5ACsF+g/jBCPapT4DPjXtyBeC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OF7zUbldyTz/SaXHbkEazXicy5GDOByiETLKLrZxIVOTPQorxs3TXIpd4Byhz1geDC8cZ+E9cBycKZYAUS80zigYVXm+Q26QKfj8dAIRhXLOTWcFBio3skndSgBrlMaMz3A005FNixdsBiOtr7SsIWneKa3XFiK88HiumxwLyDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6fk/H7g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751446903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rT/1yTCUYgsKJSyTh5ACsF+g/jBCPapT4DPjXtyBeC8=;
	b=b6fk/H7gtm8IyYp9H6svKea+cpFQ1Sk7G44ya6qv1MaM6TQLOp/DJec4d+yCZMKftAl6Lk
	XX/ZKvvRQtJYdNpH4EUokdx0YNNNTsqf/LRyPhSjs7F6WCDcBZww7IlKUBXlSSy5l2G+QQ
	Vgxbivo6EVdM5U0qzzzRuTtkIPmqR+E=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-DQk5e6UsOAOi0M634JN78Q-1; Wed, 02 Jul 2025 05:01:42 -0400
X-MC-Unique: DQk5e6UsOAOi0M634JN78Q-1
X-Mimecast-MFC-AGG-ID: DQk5e6UsOAOi0M634JN78Q_1751446901
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-553acdcd539so3777695e87.0
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 02:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751446901; x=1752051701;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rT/1yTCUYgsKJSyTh5ACsF+g/jBCPapT4DPjXtyBeC8=;
        b=aTVzj900v7e2YmXw0bYAIT2vaQPf0HdXORyYtAHq49AdE5x5RHBuzzIRZ6CG74Xte/
         1Z4/BGCy5VFgal9r7s44M740GYkKkRHLZ3YO7Uq3yX3toaTRUPC6KJ0UgNh+THDTb2NA
         qwldA/+UyEA3BzJPH+S35rOS7OKepL0emESY8PikSa6Fx/bvcE3j0PIZ4freDGjd3cPs
         tl6IiqQx2pn17590d1n+vFLNkh7E0Utc0bZuNuL7bw7TvyFzwPuv/b+EeXbQJfNhpaP2
         fARolMVSnua1e8qDDXGPjX8auqf15gfp394BYaJZKV68+Jq7pybVeSA3TGI1MEJsv36H
         Sqfw==
X-Gm-Message-State: AOJu0YznBfpTSq4T/zMp7Vwx9QMLJwMzTeVBCVIJYtHDN9Y3gvxZnO0E
	EN5e8U+4OhaveU3znBwlkicW9Uwolu4b0cS/2XLTenTVf1NTven/CouafOfeSjhdqU68mHkVVKY
	gAn/cmyjpnWmjl3gDdkVpHoaow6TAvK+C9oB9gv56I+Jv31SQzlDT6w==
X-Gm-Gg: ASbGncu/qanSnx7jQvaezZwGbjcmBuCeJoQc4hoD+CGCUBk6hPG2+/3ON+qF1c7fth8
	9zGxBWD2QVLrygkeY6ExhpPxn3dSTSLbmuen9C8wUrcE/RIAgGE22yEGqvOpVBIQIp+JhZ/tlKB
	JGk5zUHGwEOB52OaZk3VcRV8UBqukbo9U03Lqu9e5RdbFeEJI62xKSRmYn16cvy5sQw96mX3pPc
	9duEeqE5zAtvy+3ZeMKpSOS2giRwIKBK2fBTugxvAbeqpOHS5RzaGwIuKolKn09REkjV+Aybx5B
	PH+kSxv7vcO49IcHJmU=
X-Received: by 2002:a05:6512:2245:b0:553:addb:ef5c with SMTP id 2adb3069b0e04-55628372cfamr635071e87.54.1751446900605;
        Wed, 02 Jul 2025 02:01:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4L3Lr7zlS5Q7UNzNUPT3l26X2dNCoG8GtYzZzEmFsARCZIaKREcNHDzAIVt/eK0EazCxBZw==
X-Received: by 2002:a05:6512:2245:b0:553:addb:ef5c with SMTP id 2adb3069b0e04-55628372cfamr635048e87.54.1751446900110;
        Wed, 02 Jul 2025 02:01:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b24046csm2071324e87.20.2025.07.02.02.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 02:01:39 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C45C61B3803C; Wed, 02 Jul 2025 11:01:37 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 joe@dama.to, willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2] Documentation: xsk: correct the obsolete
 references and examples
In-Reply-To: <20250702075811.15048-1-kerneljasonxing@gmail.com>
References: <20250702075811.15048-1-kerneljasonxing@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 02 Jul 2025 11:01:37 +0200
Message-ID: <87plejezke.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing <kerneljasonxing@gmail.com> writes:

> From: Jason Xing <kernelxing@tencent.com>
>
> The modified lines are mainly related to the following commits[1][2]
> which remove those tests and examples. Since samples/bpf has been
> deprecated, we can refer to more examples that are easily searched
> in the various xdp-projects, like the following link:
> https://github.com/xdp-project/bpf-examples/tree/main/AF_XDP-example
>
> [1]
> commit f36600634282 ("libbpf: move xsk.{c,h} into selftests/bpf")
> [2]
> commit cfb5a2dbf141 ("bpf, samples: Remove AF_XDP samples")
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


I'll make sure to update the document should we ever decide to move the
example code :)

-Toke


