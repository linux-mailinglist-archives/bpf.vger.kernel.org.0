Return-Path: <bpf+bounces-37723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E31F95A048
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 16:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DB491F235B5
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63857199958;
	Wed, 21 Aug 2024 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0DrJowW"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872E87406D
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251601; cv=none; b=QJdjpX75m1WzcdoT49F0FtepMqOya8zQ+3Odq/rMI5jl3Hz7pfcapyoIDZ8smlSeFNLLqHHR1YbbSM3YdYpb4wKTMldSLUgoaDozp+w5/diTiUpZZ30h71rT57+W7U1PCjpe7jlQCBzrcGTv1T1cQN3m131qnJVSDOt4ot8r3YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251601; c=relaxed/simple;
	bh=6xdt2jDZXSBwFTljtG80OL2SpBvSmFFJQpZtCWyxgIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJRFhc9RrjFA+72PpJAlLLl22pT4wrTrqwOGUCAVR5MpoctoMGvzanDjW5Y0JxNNrobVi+q7xgK28iwYrAzQGAMSktWMl6T0zGRWmAZpc9KeygnTSi3s/OqftINWwjqWOpCA/zM3eCMv83F1kops+mtXHWKNsuiaAX2AK0ijRcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C0DrJowW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724251598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6xdt2jDZXSBwFTljtG80OL2SpBvSmFFJQpZtCWyxgIo=;
	b=C0DrJowW8dJoOMuDeS0W6fSNdAug8yj003k2Ia8PhIdios4AOpyek+is4l6cgfBA3y26KT
	Hu75yjH/TUq/gdg5XROvY0wCxBF88Jt0TcCs0df6DsTDkKZCSAsw5VF7cT7sXFkPYy52dd
	Y6uuMqQ6MyoiTaDe//V09iGKZQYbDKU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-2GbpWbpEOvmlanbJc3SlDg-1; Wed, 21 Aug 2024 10:46:36 -0400
X-MC-Unique: 2GbpWbpEOvmlanbJc3SlDg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3718c1637caso3641180f8f.0
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 07:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724251595; x=1724856395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xdt2jDZXSBwFTljtG80OL2SpBvSmFFJQpZtCWyxgIo=;
        b=IYs8qlSPfDqEeAJcsvxuhHzl0sNaU8qgAnjuqud9lPq6vqGBHh2iWgEXB4YAlESwZ2
         AWLlj24ck9fDv4VC5uy7Tyxk+LH+MeFOjX5uMk72Lv0r/sFH2QvvkCqKapR7WE703E+6
         uVrPWRlA94JvWoQLuwFjyaugDnAfWnCrF5FrYqEoPa7mCG8sHfHEJ/d9yAz7C4PjWYt6
         pssEiFEwvDbRnkvtDUb0H+lZjyKW1Yes+J312hSkbC2WM+jkCpEgFT4nio8K/XYtTRu2
         xgBrcy55JkKsc49vwiKsDTA6N+5/+7nZAsBKMLgtgQR4duH/IjPn+QORGz5tC52pjZW4
         n6Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXp0wribsOS6DOa3yMLmxEbfo7Ss928VHRzceDm3soqqb0mB8K6358Jg0Yd0nQKnfs16Is=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXqcIf5qFd4OAnCeZFT5V4uFfXqloHHM82wdG1OKOw8xidiE0E
	TH77YLXvwijT80fs9bohiuEb+V3kmtgr+6VCDoejKuVVcqz5MiBxebSsMEEacEIsw+okprW7mO3
	pq3apA/owJVE0yoz1GbVM6B8IFiqCdvDyPHkX6gs3gdrxea0mwA==
X-Received: by 2002:adf:e9cb:0:b0:366:e64f:b787 with SMTP id ffacd0b85a97d-372fd57c8f9mr1579778f8f.8.1724251594800;
        Wed, 21 Aug 2024 07:46:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbLPnszvW1b2ldVOkF9ZIUwdca7WTLBwLo/0pq1z+jsL2swELRra5Q+Ml//UK9bmMhggFv3g==
X-Received: by 2002:adf:e9cb:0:b0:366:e64f:b787 with SMTP id ffacd0b85a97d-372fd57c8f9mr1579748f8f.8.1724251593939;
        Wed, 21 Aug 2024 07:46:33 -0700 (PDT)
Received: from debian (2a01cb058d23d60064c1847f55561cf4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:64c1:847f:5556:1cf4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee8bce1sm28211825e9.16.2024.08.21.07.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 07:46:33 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:46:31 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net-next 03/12] ipv4: Unmask upper DSCP bits when
 constructing the Record Route option
Message-ID: <ZsX9xyKUa8pYEXVo@debian>
References: <20240821125251.1571445-1-idosch@nvidia.com>
 <20240821125251.1571445-4-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-4-idosch@nvidia.com>

On Wed, Aug 21, 2024 at 03:52:42PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when performing the lookup so that in the
> future the lookup could be performed according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


