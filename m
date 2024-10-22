Return-Path: <bpf+bounces-42773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBDC9AA02C
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 12:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF28282E9C
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 10:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1FD19ADA2;
	Tue, 22 Oct 2024 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyPTQUKQ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F7219AA5F
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729593486; cv=none; b=Ja+81K9dE0pdUfljdfPz249R7NG9+Hfjd8+0jzCJ9I723yGrlpWlnv+r7AxkZ5P8fSw6NA7xdK1lxrpr4NP4yuUAWnoOdCxbMUvUJRYcUGEJrljeJZsvtAzP38hNJGQLLQGN9YfLw3E/Y0Wv40EZzvfg/Bi6K2bNxLDatIJ0aIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729593486; c=relaxed/simple;
	bh=ffFIq/gaiGrXB3V8+8QiuT3BPvz/9MKGdcuUtNI5Sac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=glzNVqXQ8BCYvodRIeDcntKDnuoSIDbY0O3RD5KrgPQwKd5nHsUdWHXCE2N9xRAxm7LvJDkOG96jg1R8Ugt/0fhbiVs5JY10QTrko6KpMbV6G01Gpq6VFpO9G/BtckdJku2uHOIMEec/s77GUmZXhZMARwNUEe+clFqzlxBrCt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gyPTQUKQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729593483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ffFIq/gaiGrXB3V8+8QiuT3BPvz/9MKGdcuUtNI5Sac=;
	b=gyPTQUKQAhce1afyPssYtxTGk5FprJX3b0qLalpeg2TfQYXVhEBjwzgrZ2sLDQeQJgDBpo
	yWUkZ0xbhcShOJ00lkNaS+EPTSh6zI4L53qzX2wXjk0f51sA/rWTyiGMLcLtW3DzK2V/sT
	aC+BgYYVf1uuL3HykTq/M2ogU7iFlBk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65--Ik2aJwQP4-vOnOPwybA5A-1; Tue, 22 Oct 2024 06:38:00 -0400
X-MC-Unique: -Ik2aJwQP4-vOnOPwybA5A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9a0ac0e554so669250466b.1
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 03:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729593479; x=1730198279;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffFIq/gaiGrXB3V8+8QiuT3BPvz/9MKGdcuUtNI5Sac=;
        b=mBsR7VSyQFBBp+EbDxsy7BMrbm352Vvll7Kzjh4ibPrf5z8c3D4pfvSs/c2rMX9lCU
         uo7l5nGjq7v3lo/Jeetqne6ErqvdC/qADBqJhns8QIkXGo6dGaIw/mXxepo6VMLVUgGE
         k7Udvy6yTiuBW3rC7Sm0L1vxLrg2WLLoMZ+SE0VIHYa2cFgQm79+sAhHXrUCj1xJGwIJ
         AV4IhbY7gojnytd6BhzgUTzZ76gKxmUMU4AnGRUYk2UVrbOV+fKUoQL9nCXu6/HnTcBm
         5xxYUuj0xt4+zwhFiiR/AhrVYPLV3oJ9Owtg9DTlTWRn5OI4y8u92CIgrgwiQOwoAVyc
         lcAA==
X-Forwarded-Encrypted: i=1; AJvYcCXQBo+w5WW45JDk1ZG/QOkUliMEw3Y+zx0I9kHUJ9HspxgVbZ+u2rpygQvl4zRToNfbiwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgGPOMZgg4sUkLb+YMYEkYZeZywRTABf3VqFqlBMbHv97moQ/E
	15k2AGLh2hLzop/kR8zV7LvD1D4WtYKQIOO+IJy/8uvgSGazCzgUCCd+Qn5UmFe8vWeOBT75qPd
	UzJgW6XArp2q/BTmVT4rK4DiIfcae9JhSCA5HXU2sohPkP90ltA==
X-Received: by 2002:a17:907:2cc7:b0:a9a:170d:67b2 with SMTP id a640c23a62f3a-a9aaa5d907fmr283641266b.29.1729593478870;
        Tue, 22 Oct 2024 03:37:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEripPrAITA/WLQwqo9WurNo58xCXU6eZjF2PPYNfcl+DENvnVnrciJi0HPoUTYPFfXpqprVw==
X-Received: by 2002:a17:907:2cc7:b0:a9a:170d:67b2 with SMTP id a640c23a62f3a-a9aaa5d907fmr283637166b.29.1729593478361;
        Tue, 22 Oct 2024 03:37:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9157363asm323363266b.173.2024.10.22.03.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 03:37:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4B16E160B2E6; Tue, 22 Oct 2024 12:37:57 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Andrii Nakryiko <andriin@fb.com>, Jussi Maki
 <joamaki@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek
 <andy@greyhouse.net>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Nikolay Aleksandrov <razor@blackwall.org>, Simon
 Horman <horms@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Hangbin Liu
 <liuhangbin@gmail.com>
Subject: Re: [PATCHv3 net-next 2/2] Documentation: bonding: add XDP support
 explanation
In-Reply-To: <20241021031211.814-3-liuhangbin@gmail.com>
References: <20241021031211.814-1-liuhangbin@gmail.com>
 <20241021031211.814-3-liuhangbin@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 22 Oct 2024 12:37:57 +0200
Message-ID: <87sesoh18a.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hangbin Liu <liuhangbin@gmail.com> writes:

> Add document about which modes have native XDP support.
>
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


