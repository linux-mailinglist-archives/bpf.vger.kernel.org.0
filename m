Return-Path: <bpf+bounces-38169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6D1960D94
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 16:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09B81C227FF
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 14:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5881C4EDC;
	Tue, 27 Aug 2024 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTLFg2eD"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5E473466
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768951; cv=none; b=HP8voTnekbYPonSWSSh2tIVjBCP/iBYWjTsHoceBTQdab7kZFlU5WN+/+4r2SBB+QGCkYflvTjXLrbqLWqGFZJ4CftjlSa2lONbz4kQiAbc3hobcBrcBvWjDCIvfI06UrH2xTR/QhdWxjPAppRZFOadZn9tJgmAwpxqAt21osII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768951; c=relaxed/simple;
	bh=XEDPr4WOAkirqSp12c15L6XcOtIYReNICHT5/RJr5y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6I0NZfWLGiaiSSdrZkhDQyOHrSCCErzb14JjGfYd2xwh+9j+fqD3PRtOZnKZFhelvu9Ik9tOji1cdVNf4i45e/w2pbsk3fxuoPGFZindI0DGQS/+blMsscRwa630LYfXuaRREd2biGopsVzBmlfFzOaUGT2nLRfLJvUwwBR36k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DTLFg2eD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724768948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PgVRezl+3Y13Dxo4oGt/1Z0OKjfZrBalmuo0EvD0nD4=;
	b=DTLFg2eDzLqRRpXvc+AjP55nE5/cVK5HKb5lfBtFKaVo71K8BB8WJnQrxs9aPKcsYaKdMW
	3FpfV45R9Jvlndrjsc+BRSJvJVLuPXaSnA0u1hbqdQQ+T9HIGxLcCtOne0igV2+r1FTucm
	HeZ0OGUpsmnm6CUwzVT4UDEwwP1zQCg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-7s_sM6eNPESRxzybXyFrDQ-1; Tue, 27 Aug 2024 10:29:07 -0400
X-MC-Unique: 7s_sM6eNPESRxzybXyFrDQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-429e937ed39so52457425e9.1
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 07:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724768946; x=1725373746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgVRezl+3Y13Dxo4oGt/1Z0OKjfZrBalmuo0EvD0nD4=;
        b=XWARDCZ3KnBI4KgIR00ImH0sX1kGNsFZ4ya3I9WrAD7KieD641H1wO/f3SbxfBB3rS
         zQ5wogMeFCc7UEpn3RM8bZ5qT7Shw1QOJ2vtGeqoQSd52ZGK7zJwll5C4p4drOh0kO2X
         CwtTBf1qjH672z5zP2vJB+LdXg2cK3tLD549A2P8UUes/XqTXzPvDS2S/O/1fDXiiBPV
         etlVoRbgN0IgAyxSnlCL/YW1zsbcfymnbIrJemzqVntuxXL/IbCIllSCtU6dRVQdcxY/
         cDZLtWfOGZTyKOZFQjquhwfS2OWiQYUbOvfaiVfpnGaUkTvqAFOh0JUXo7Qjvrv9330H
         sEtw==
X-Forwarded-Encrypted: i=1; AJvYcCVMpImz4iOQlUy2fGkfG9rFc2tV08SwF1AY5ESKZeHCak/WQbKMp3YJ+VCfIYYNW5HT+3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG6No+jyNSAhrd6XsjMP4p0vOC4ddsN6Xyqj9bFgQHNhKHmLfB
	9w2nLcT1D3ORuhouyjYf+BDGQeFSGNV3o9qOri6GcW0P86m5ZGVvD2ezKz4Y32jULvi0g3KUfE3
	lTZ8r8WmFDds3lQZVXrqv1nqOU1QadRiu+mRMkDIZNqsebp56FQ==
X-Received: by 2002:a05:600c:1909:b0:428:1e8c:ff75 with SMTP id 5b1f17b1804b1-42b9ae4b2f4mr19740065e9.35.1724768946189;
        Tue, 27 Aug 2024 07:29:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFJXBA+TgtLOFs5onkG6FkZIYtlBLDuS8EzKnHJ9mOfyqPrQoz0idm9IxP/FCAp77EJ8Tiww==
X-Received: by 2002:a05:600c:1909:b0:428:1e8c:ff75 with SMTP id 5b1f17b1804b1-42b9ae4b2f4mr19739695e9.35.1724768945275;
        Tue, 27 Aug 2024 07:29:05 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac517a68dsm190967095e9.33.2024.08.27.07.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:29:04 -0700 (PDT)
Date: Tue, 27 Aug 2024 16:29:02 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 04/12] ipv4: Unmask upper DSCP bits in
 ip_sock_rt_tos()
Message-ID: <Zs3irqw8lmiPb0PJ@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-5-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-5-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:05PM +0300, Ido Schimmel wrote:
> The function is used to read the DS field that was stored in IPv4
> sockets via the IP_TOS socket option so that it could be used to
> initialize the flowi4_tos field before resolving an output route.
> 
> Unmask the upper DSCP bits so that in the future the output route lookup
> could be performed according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


