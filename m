Return-Path: <bpf+bounces-27127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A068A963D
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 11:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92814B234EF
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 09:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6180115ADB1;
	Thu, 18 Apr 2024 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVzV3tZ4"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6ED15AD86
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432833; cv=none; b=ptSxiWqUZl69/VHI8fkoXmlTy9GEdAdXgIcKkODdZBjocIVfs4YfThs3i5Jbco113r5XX2EcmpVWzUkG/gzv4lZ5CweoU50wK0pzAfbUkR5VpPvAc5x5ltqhbGV1yj5H9EF+cDyPO85UUFqzKBBCQye5pohynqaguSclSkTxmOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432833; c=relaxed/simple;
	bh=+MXJB/ptM9FTPWPjxgDkAlUjeWnuks3pPWNXEWYClJ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SrcQ9CJkUaLDLUcC+pCNdIYTR4vzEaPEETid1rWr/2MOeFgqlhsINzE1GPD6bmjMtvEJAd+gjluRttK214JnaIMamenFfjFemh60mwym40RJrPMqwRu7HndkQG5PzkzXrUNy8eHZK9ql2efJt6qNMcDoaLD1d3sfkzRHG79VBxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVzV3tZ4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713432831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y3DuwMuv3Zm1nako5cRJVWGwfyWPAgo99+tBjI8y8is=;
	b=cVzV3tZ4FVD+3mCTwZrlQQi33u74Y1EeM2TTGtjtx4iiGSjW/M+SaJmlV+RKY+LXKqxgB/
	3xgj/vfK+ye2D+UEMIFSpkgYniPduQ/4ytXv019uc9nxW4QM2bHK64to5R9wreAxF6f6Vz
	AMU1TNJGe4L4xwKh1yfrAaAzMYHDs/Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-3UaZ34wcPvmpe61YlJ6h-A-1; Thu, 18 Apr 2024 05:33:50 -0400
X-MC-Unique: 3UaZ34wcPvmpe61YlJ6h-A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-349d169170bso93262f8f.3
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 02:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713432829; x=1714037629;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3DuwMuv3Zm1nako5cRJVWGwfyWPAgo99+tBjI8y8is=;
        b=BjhH7fcB2v8EUc++D0z/q/QX001i5jp+SJTqG2xWTZMqlWWgd33PSDr/LB+xd6pC8+
         vYfQETOlKAzVI6V6fyvIXKC+2KEvzQEMg2dhvQRuc0LUz7RuyOJNYj+LTU55CWFOoe3b
         m28UR3XVO11MO1m84YBrUuY/BolR6rScQwKrum0CUGuTdwEhOLAXcTOwbW5lTfwDGowD
         7tP0CLI2ddpo/D4M3cg3kN+t2aboQRJeucSy4q77Ca30vHv5m2PHKwITRe4VCRdKD+xY
         p7BEoF9FXsFKudBZN5Tx3ELZex15qlbWIAlD0VJw45RL5RfuhHD/oESS3VF7HnLcfcm4
         cgbg==
X-Forwarded-Encrypted: i=1; AJvYcCWRTjlwsCks3AYk5oFfAommttaOgsb9PhTI0VtSFvh6HELRSeBVU8JlbahQQWMUud8utLXMdUMsGDUZZD1oExwY15gn
X-Gm-Message-State: AOJu0YxkUJoDGrVQoYigUfXz16ARA4quFZAQmKxtl8k4YcwkOtQ1DTlV
	0ndm+hFac32JFh8cxgexyDNZiXiJyBEq3pBYliqSXzdmeIMtgB6QTLlO7Iokfr9mKu1CPM1SunO
	HkI3nm3LQU/56q1SMPzeoMVpoOR4ni5lfkqzFdcsiNxqIMa2ChA==
X-Received: by 2002:adf:eac7:0:b0:343:72f5:8e7c with SMTP id o7-20020adfeac7000000b0034372f58e7cmr1288825wrn.7.1713432829058;
        Thu, 18 Apr 2024 02:33:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlMVGQUxGXbIrh4G8D9Ycs0kxgBi6EvF56S9YBrW1LT7emhlWGKPF0oiJBPuVn5wnM4v9V1Q==
X-Received: by 2002:adf:eac7:0:b0:343:72f5:8e7c with SMTP id o7-20020adfeac7000000b0034372f58e7cmr1288812wrn.7.1713432828660;
        Thu, 18 Apr 2024 02:33:48 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-236-143.dyn.eolo.it. [146.241.236.143])
        by smtp.gmail.com with ESMTPSA id r2-20020adfb1c2000000b00347c187a3a0sm1379137wra.24.2024.04.18.02.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 02:33:48 -0700 (PDT)
Message-ID: <3f487ef495da476e5b0564dbb024dca54e8bee10.camel@redhat.com>
Subject: Re: [PATCH] neighbour: guarantee the localhost connections be
 established successfully even the ARP table is full
From: Paolo Abeni <pabeni@redhat.com>
To: "Li, James Zheng" <James.Z.Li@Dell.com>, Eric Dumazet
 <edumazet@google.com>,  Zheng Li <lizheng043@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	 <bpf@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"jmorris@namei.org"
	 <jmorris@namei.org>, "kuba@kernel.org" <kuba@kernel.org>
Date: Thu, 18 Apr 2024 11:33:46 +0200
In-Reply-To: <IA1PR19MB6545F5F1940C0B326058987ABB082@IA1PR19MB6545.namprd19.prod.outlook.com>
References: <20240416095343.540-1-lizheng043@gmail.com>
	 <CANn89i+TKbGbmy0JJbyhUxQ9Zc_jj=EHv=bYXT5dUvQY7hw12g@mail.gmail.com>
	 <IA1PR19MB6545F5F1940C0B326058987ABB082@IA1PR19MB6545.namprd19.prod.outlook.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-16 at 10:36 +0000, Li, James Zheng wrote:
> On Tuesday, April 16, 2024 6:02 PM Eric Dumazet <edumazet@google.com> wro=
te:
> > Hmmm...
>=20
> > Loopback IPv4 can hold 2^24 different addresses, that is 16384 * 1024
>=20
> There is only one Loopback neigh "0.0.0.0 dev lo lladdr 00:00:00:00:00:00=
 NOARP"
> existing even you have configured 2^24 different addresses on the loopbac=
k device.

Eric, I think James is right, in __ipv4_neigh_lookup_noref():

	if (dev->flags & (IFF_LOOPBACK | IFF_POINTOPOINT))
                key =3D INADDR_ANY;

	return ___neigh_lookup_noref(&arp_tbl, neigh_key_eq32, arp_hashfn, &key, d=
ev);

So there should be at most one neigh entry over the loopback device.
The patch looks safe to me, am I missing something?

Thanks,

Paolo


