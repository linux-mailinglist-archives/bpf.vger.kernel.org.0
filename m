Return-Path: <bpf+bounces-18013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F27814DB4
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 17:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9463F285EC0
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 16:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97493EA7B;
	Fri, 15 Dec 2023 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VEfmU9SF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251474643E
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d34a6b3566so4006735ad.2
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 08:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1702659443; x=1703264243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fAhdkZ+F8I+GayC9l6fPGyUvsCYIkH8sHPv+Mc1BzfM=;
        b=VEfmU9SF/P+o7o6Oi5jkEZePt2Kj3V485Y7kUGgdGH4MvWhe6XRZfV3g/tV4U8WNB1
         gNEFiQb92kOsgYvKsdVRNSxAw5DE6mshMZ1jKyemahKMdCG6D2xHyWd+AfOwRFjypGP4
         SzIvCWzGdEArgYWsYOIsdxQn9BvVozA38K/OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702659443; x=1703264243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAhdkZ+F8I+GayC9l6fPGyUvsCYIkH8sHPv+Mc1BzfM=;
        b=qSCQzzlloCqAbTO91zjV6UWChvaE7kziSCGkHgL62Vt2fUlXVhom899pG+MaDVbDkS
         Frx3uscat+4fA5UUO0taCN/xrI4MxC/riK0ysrfeJBuoTr8U72TEezRUNtcEVqMyUWOD
         D3gJgF4EdGvfQkUrnnvfjeEog2+DX14SxAqv1NrsI/kHsAZj8S7YImcz/HsJUrY/y3p0
         UqZd6i2jCokvHySLq3Zbo6U6ez+D+beX/cadr9WdoCaWPxcMkNyKojj5SNVsM6lmgfXO
         xaGcKzFeN7pxMd2qRV59CKoTpMx6CkJYK2jyQ1KRTL7zCYERPJUWr+l9kOwUki6CL09n
         e6yQ==
X-Gm-Message-State: AOJu0YzarHbJGcJnE8X/gHZ+mpMyBbmMhzg9et6OjLS1pTrLIBD3plre
	ZM7qJQR9WH8W2C6DvyJU/4WWng==
X-Google-Smtp-Source: AGHT+IEpCk3W3FR5WiX7WJfd3b22qh7GWYjzMRIvFQMPuSvwP9BwJ0hS9Sizk8QQGvFUKoBssMwH1w==
X-Received: by 2002:a17:903:44a:b0:1d3:5f7f:c882 with SMTP id iw10-20020a170903044a00b001d35f7fc882mr2780884plb.30.1702659443355;
        Fri, 15 Dec 2023 08:57:23 -0800 (PST)
Received: from C02YVCJELVCG.dhcp.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902eac200b001d36c47b768sm3234068pld.22.2023.12.15.08.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 08:57:22 -0800 (PST)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Fri, 15 Dec 2023 11:57:14 -0500
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, bpf@vger.kernel.org, hawk@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net] bnxt_en: do not map packet buffers twice
Message-ID: <ZXyFW0lIGluM8ipj@C02YVCJELVCG.dhcp.broadcom.net>
References: <20231214213138.98095-1-michael.chan@broadcom.com>
 <20231215083759.0702559d@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215083759.0702559d@kernel.org>

On Fri, Dec 15, 2023 at 08:37:59AM -0800, Jakub Kicinski wrote:
> On Thu, 14 Dec 2023 13:31:38 -0800 Michael Chan wrote:
> > From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> > 
> > Remove double-mapping of DMA buffers as it can prevent page pool entries
> > from being freed.  Mapping is managed by page pool infrastructure and
> > was previously managed by the driver in __bnxt_alloc_rx_page before
> > allowing the page pool infrastructure to manage it.
> 
> This patch is all good, but I'm confused by the handling of head.
> Do you recycle it immediately and hope that the Tx happens before
> the Rx gets around to using the recycled page again? Am I misreading?

Your description is correct, but we use a better strategy that just
hoping it works out. :)

The design is that we do not update the rx ring with the producer value
that was present when the packet was received until after getting the tx
completion indicating that the packet sent via XDP_TX action has been
sent.


