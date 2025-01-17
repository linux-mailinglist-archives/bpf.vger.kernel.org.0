Return-Path: <bpf+bounces-49192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0620A14FD2
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 14:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A3E188A6F7
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 12:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA97200121;
	Fri, 17 Jan 2025 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrYtg9ZO"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8941FF7C2
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118734; cv=none; b=J3iCwMZdMF6o2QhHj0LUddaQyehTpsqL1tv/8K4r2en83svNETZmQJdH2MfONJQFOIA6YEZIfZnAOisJvIVrgR5mb6O0ZUcW1/qUZ57o4FTbKQGPnzj4e/yr9fhHFBsQj8evh7UoIdjanQQi2TIhU1/IRA4x/93fhsR9kLziiXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118734; c=relaxed/simple;
	bh=LUZN6UQM4fLoP0BmXx1jU/m3Jz1LnC0DxZ30eVflpy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JtLpki9echywseSKzaRRRBLQlYLEGftbdDuLmA4/5JeyhCuXuOtjpt3W3YsSxmORKCTKDuEBSEl+uivxK6OpRTQGEUak3+un4oM2fje+cfMvIDLhviqGsjSjThLQQ0G0sqyua0fezb3Y4tLyKZav5xr6LoEfeiQLHl96Usr0P0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hrYtg9ZO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737118732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LUZN6UQM4fLoP0BmXx1jU/m3Jz1LnC0DxZ30eVflpy8=;
	b=hrYtg9ZONP/2iZHgEdHrB4vl2CX+IZc3MQ1QGNacNoOZ9JZT7Cb+xCK+4jh3bEIHyxMO20
	Y4MoCk9nSCupkdVnBRHDn+YoRg3E4Sc3liHbEWwDbpMjnz3Oalwhr0njnVpCRrmKfaHV4h
	jChJ1062LmDMv2mY0bzpz9DMX0XfH6M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-yFak7BFmM5S7lcvXMMZwBQ-1; Fri, 17 Jan 2025 07:58:51 -0500
X-MC-Unique: yFak7BFmM5S7lcvXMMZwBQ-1
X-Mimecast-MFC-AGG-ID: yFak7BFmM5S7lcvXMMZwBQ
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa683e90dd3so189227266b.3
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 04:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737118730; x=1737723530;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUZN6UQM4fLoP0BmXx1jU/m3Jz1LnC0DxZ30eVflpy8=;
        b=otkhjqprTT0flYKuYfcJV+XGy9nJJhEvPMOegudpDMwzRyUxXgdO0rxQ5aV45q8TSI
         eZ5hzisfJsQlhmF8sVTQWbTE7UVFkMU1TCKrYRHJohX3TFQT+AdVkohWU3Z1m6GY1STZ
         8l8UMJ42kkPXUBk34jG41aizzw80DRrZy/CNC1CjS+vP3Y3+YYdfyhdEBHeDjYXyjsbl
         3AwGV/CgDYSU6+Io+opD+ogXYJ9GEnIyrdhVFzeZbra38VuwgB6hkweK3LX5nlvaAJBH
         ZWgxDntWlDks5OMRo1C85JA3AYaecIgBGjqYduCOn4UvCY0GwD9/iSsQL3FysTx4Q7iL
         aEpA==
X-Forwarded-Encrypted: i=1; AJvYcCWHpr0LB1EmLclfBrCRHoq2zU3g4sfJXaxBaA7sBuIhszm/9JpLryNT5Y1RCuCZEg13HEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg9HGSjJgVJDCV8oAYXFzgiHvx4q/j0e0ak6ijrvhZ5AO3OKwI
	e5UtfD+9nJNKR9ZgUW22RXTty4KC/mUnG6biOJ2o/7G0lT/l6+fY0RqYNYuFaOG8IJ8yibsWqwE
	tZgwEEN/27gOuOftaGaWeIG1T7atOiqJbxXzizlDuVioCngLkiw==
X-Gm-Gg: ASbGncvpexpOhwFm5SGw6u8a9BSdRjdWZqKuHNvUmAdsNX+cZEsVsqB6VnfbhBoREVP
	eNPtywnzAjiwdxcxk6I/+Hzz7Y7IUsM+UXwA4xuPeCTZ9O/nAb+WhV+ch8pwOH1TmH48j4Gjygr
	Z/Uh/oIpoVpIGIrImWDkGjzfGL9lZVur0ZBNnZPom1XeJYJn/v1M6uNs5VT3KV+uekD4gLFMZzI
	+bOO6WeJHNvBceKs0mNCZUP/6jcv1dGDJIe+6aJP9PC9AKrEaOmPkxaoT5A+iecefpZ2W79nPN7
	8+4CUQ==
X-Received: by 2002:a17:907:7eaa:b0:ab3:398c:c989 with SMTP id a640c23a62f3a-ab38ada1546mr328706766b.0.1737118729757;
        Fri, 17 Jan 2025 04:58:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLmD1GTGTSt675IQTRpthCfqVA1AbcSDMJl9EZkTXmZm66OBCCVwcEUSSLmPrXc8rBhS/6Cw==
X-Received: by 2002:a17:907:7eaa:b0:ab3:398c:c989 with SMTP id a640c23a62f3a-ab38ada1546mr328703366b.0.1737118729365;
        Fri, 17 Jan 2025 04:58:49 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384fceb0dsm164970866b.185.2025.01.17.04.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:58:49 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1C46D17E7877; Fri, 17 Jan 2025 13:58:48 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 8/8] xdp: remove xdp_alloc_skb_bulk()
In-Reply-To: <20250115151901.2063909-9-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
 <20250115151901.2063909-9-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Jan 2025 13:58:48 +0100
Message-ID: <87y0z9mwaf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> The only user was veth, which now uses napi_skb_cache_get_bulk().
> It's now preferred over a direct allocation and is exported as
> well, so remove this one.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


