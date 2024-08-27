Return-Path: <bpf+bounces-38177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA809611B4
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 17:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20AFA1F21C33
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 15:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC61B1A072D;
	Tue, 27 Aug 2024 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auCxkIZE"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5B17C96
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772150; cv=none; b=OwnUDpg16VtNhAf8/xmvEthnWHmIPmUg6UXAapTVrsZHIU6QMFR3smtsTjWJZ0WUzrNJgqz3EELz9RUBqJDzVsSp5MyWwudUm7cmqLdU7u1LptaJDAtuySmiOLDFEOyP5ObfrTAPGzBGikYIzf3J0A+iM4sMAZexfGu0BZTLRnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772150; c=relaxed/simple;
	bh=465bVayaKxp7NXZ+D/CmC4N6IT94unayOyJURT+WrLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKV9fRuQyxwLKKCIZ2YEwBCSpPuXOTAGqM3zB/kvflEiEkQFwKV+KPgoLu9trK6R0pG7ZjiAc9yoi58kH3OpRjH3323eJRJ+xUMwUKkFXNkfmW+LIDf3pEXsFZ80MPiSPL93dGXnQKDkBguBrlxmdGOl1cZhtrbnenKwR5RYhU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=auCxkIZE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724772147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=465bVayaKxp7NXZ+D/CmC4N6IT94unayOyJURT+WrLQ=;
	b=auCxkIZEVC8qcjTCWAP01RTao8E9oNdBZQzmFQTd81JTxjucwuMOVYPB9mrMY7KNTolK+S
	klJoiR4FNinFHijJB9PjLWCLxokYfRJrNun24CxRDLsKrUJBdGClqiK0SKPj1PYEizD2O8
	wxrPNzKG303ELnfOYFEyeeg8WoDIENM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-afThvWOMNnORYjmyV-AWog-1; Tue, 27 Aug 2024 11:22:25 -0400
X-MC-Unique: afThvWOMNnORYjmyV-AWog-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-371914b5caaso3493648f8f.0
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 08:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724772144; x=1725376944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=465bVayaKxp7NXZ+D/CmC4N6IT94unayOyJURT+WrLQ=;
        b=I5fVOdMVgzJ9fg8p7nClR/PwRl05mdhTWWOo92ueKHSeAKIb7wxKTmcJ5yLFQLaiWX
         9GEoy2MNdcU4Now9Q7jqn+qP3/z9wCx7Qw2A0iZPqE4Eco5Hi0qdI1RfIoJD4CXqmURk
         q4Rb7SYy/NjY4rPx8iE4TIV59bh1Zeiufg8/ult0VxAUC2Ss6nzVEPIc4hZkkHzESxgE
         d6JyRKSMbY1va4a6J73tXuVCwrH3jBzwY0blrqMaU/pVUScaOR/MajZVW5I+KIMuMfmF
         n7FDXqw3J8fujQe11SU0OYvt6St4qSeR5XZLL5/pSwidc7+KZAUN83A54Jhgb4EbU50A
         LBZA==
X-Forwarded-Encrypted: i=1; AJvYcCXtYDfp/0EleTtUDV2UenR2TD1FszM/8c/GMM1xOTYVPIsrVPnMhzph3VgK1sR7JCGWyu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qz8v+xsTR+mTGPwP3fRpoINuVB5WxUn45vs6MdfTX7isJBzT
	ZoCkatX5d1kFHW/bRW4kah/5z7x8XpkJu7rFps9n/dkY2D+kAUzpRGV4CLBtPSaDNxHXh7ncEAO
	8N+NIL0qqV3nHR67+AnVSLuDQJRVZPekdgK/ylbVUQYHfUSElyw==
X-Received: by 2002:a5d:5983:0:b0:371:9156:b3b with SMTP id ffacd0b85a97d-3748c826121mr2563886f8f.53.1724772144420;
        Tue, 27 Aug 2024 08:22:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTKXOd6fyR5kMod0qtqzjP4uOvprEP2k4hJcEdvOz85m+mgpImCFxD0foQYNMNiY4JmVrTLg==
X-Received: by 2002:a5d:5983:0:b0:371:9156:b3b with SMTP id ffacd0b85a97d-3748c826121mr2563860f8f.53.1724772143626;
        Tue, 27 Aug 2024 08:22:23 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac51802a8sm187263845e9.40.2024.08.27.08.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 08:22:23 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:22:21 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 11/12] vrf: Unmask upper DSCP bits in
 vrf_process_v4_outbound()
Message-ID: <Zs3vLflGfnKGRVOX@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-12-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-12-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:12PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_flow() so that
> in the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


