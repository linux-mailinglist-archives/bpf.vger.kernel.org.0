Return-Path: <bpf+bounces-17188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ED680A559
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 15:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2606281A9D
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 14:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1741DFD7;
	Fri,  8 Dec 2023 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hi5sJtY5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC021723
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 06:23:27 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c2308faedso22372965e9.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 06:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702045406; x=1702650206; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qpTEuL4xLEg3/6u/TMHcNlMGRyzu/zgxV09b0DSC5wU=;
        b=hi5sJtY5nAxRUIqFIttxgkfTdyFttVOdKiidAHze1l6Dd3VhN/nqMpn2yUOSLWiH69
         P5TUG/T215TZTnSfqb6ynfXLKSiKwUEcf/n1+0r941eZccILb2r1qyfMLww8d2kdPDf/
         48dgO+fkBTyL/8DhRRfiqVLFmoxX3tMaeTK+2kLK7OiziBbvXYwwy8ozfLa0nw0XLK7V
         4uyeggH1bcRgovYUOTWEvBzhCETnr2dg1eskfwICHhx5KvOllc6tH8la3HikyrrxX/gM
         L2fH5ADigSyz6Nw/bG9jaY2H/1hPxdqNfyPAcnWwkPP6LoMcu6oXmmR80a2bIxaVJMpl
         R9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702045406; x=1702650206;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpTEuL4xLEg3/6u/TMHcNlMGRyzu/zgxV09b0DSC5wU=;
        b=Nt+rLronVRs6V+K1fDXB6gDmLsXdKoDxISFNUOWmmA6LJHi4QZIfrrU72KZ5p4jVjc
         a9H+Cwp0gkJui9my6boksqn8J4UboJDy74P2B+F85Bepma79w8qpPrI8bFcxSGaXzrmw
         IO7cqhvpIcO+/FmVdUDW/popOZw9cEi1sT7c7agpXbmvLgXQWhzpQyCvwJe08odd16/6
         z5IGY0zLVYy5fGPSl/rOSgC+ktn4pxHit/qhKNIzdH9HqrJ3qCyr5fwQoQoAuNcd9A0D
         bO2tazv3iAG/D/qH+GdGYvpP/M0jmVXm0B+TqJ34oHX2cpOiiHPlEpNfIJFnP5bOeLgr
         nOOA==
X-Gm-Message-State: AOJu0YwywXu+OVtoSb2oNe4kViPhiTbStTgb1lyuyTDJGU8khpsZYloJ
	4wtPrDFUM0XFJ2BzTuNl6pM=
X-Google-Smtp-Source: AGHT+IGzkymBlRL6u7JDjKE6ROVD+KLIxSPfP2rP/Ncavx+lL56W/V2JXoFdWOIMMSZdLqeWZfFP7Q==
X-Received: by 2002:a05:600c:6022:b0:40c:2102:d6c6 with SMTP id az34-20020a05600c602200b0040c2102d6c6mr17350wmb.138.1702045405502;
        Fri, 08 Dec 2023 06:23:25 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id he15-20020a05600c540f00b0040b5517ae31sm5343037wmb.6.2023.12.08.06.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:23:25 -0800 (PST)
Message-ID: <982be04066715573651896336600e975d3df4d2f.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Mark virtual BPF context structures
 as preserve_static_offset
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, jose.marchesi@oracle.com
Date: Fri, 08 Dec 2023 16:23:24 +0200
In-Reply-To: <6ea56936-1aca-4bcc-9a63-c61f8bcfabb9@linux.dev>
References: <20231208000531.19179-1-eddyz87@gmail.com>
	 <20231208000531.19179-2-eddyz87@gmail.com>
	 <6ea56936-1aca-4bcc-9a63-c61f8bcfabb9@linux.dev>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-07 at 19:36 -0800, Yonghong Song wrote:
[...]

> >   struct bpf_pidns_info {
> >   	__u32 pid;
> > @@ -7280,7 +7286,7 @@ struct bpf_sk_lookup {
> >   	__u32 local_ip6[4];	/* Network byte order */
> >   	__u32 local_port;	/* Host byte order */
> >   	__u32 ingress_ifindex;		/* The arriving interface. Determined by ine=
t_iif. */
> > -};
> > +} __bpf_ctx;
>=20
> should we undef __bpf_ctx at the end of the file?
> The same for below bpf_perf_event.h file.

Yes, that makes sense, thank you.

