Return-Path: <bpf+bounces-37720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A44095A006
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 16:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4EB1C22866
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ED7136328;
	Wed, 21 Aug 2024 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgsgiDJC"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6094A763F8
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250950; cv=none; b=p2jaztKG/r/dF+1M992aJ/5jhrnrfTBYMSHcN5Dqvv1X2ggIfeF0wyTSI6wTrsqUYubysKc4xE2xNBxS+XfxYzTCeOarjMdzwjh8UxPDMGOJ3243cymm6aqnX+SOC+BTX4UmdpnMZCgj4geGcQ9thu1VFkwQq6SrZ+XPvKOqJYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250950; c=relaxed/simple;
	bh=phxy8Nt1OqlzmKYCd5FABRPmYnLA1V4MuusvN9MrHXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsG/PKy4rfSFgVNuADxkMNtcAwauJBMjdvqxiBnjihbeN0TxB7mEMfh+s2kJpDTXXK2Iyoq2OY9tjo2wjmPUKzTLqGpsKgtkCGCFCiqlE9mFizwDOPrtncxXT8EZ4oM5eD/VFY6pqooxHH2YNRMviwD1QF0KfEtVI4i0U5gYNkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SgsgiDJC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724250947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=phxy8Nt1OqlzmKYCd5FABRPmYnLA1V4MuusvN9MrHXA=;
	b=SgsgiDJCHpEsrkvStAMX9yN0EalhGwmr631XCOIfgt/WSFW4kuuMPVvsUTI1cV/iwl82gf
	XyDyslD6XjV19TViMzEeNLoE53dWrghe61KQfgaqYNOIXqSHErJOT2CdjCz2pg6trQhTiz
	BdFXijfPN+qCQUnPDji+u/pY4/ESo50=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-orfajppWMdqOZpXL2-RHIg-1; Wed, 21 Aug 2024 10:35:45 -0400
X-MC-Unique: orfajppWMdqOZpXL2-RHIg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3718ce3f6bdso4542310f8f.2
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 07:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724250945; x=1724855745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phxy8Nt1OqlzmKYCd5FABRPmYnLA1V4MuusvN9MrHXA=;
        b=flmEe5vdtF27FYQj3cHp2xQ/+UtxaqueuWyE2oRictOGvdtvHqooa9Cj8J+dt/vmMT
         yIOjPQkUyMEF66G71o3Q/UTRPRcKoe/WrNzWVwDET8vCFe596nvWrlJUJqW4lDNEJnXP
         iE3+WVD8L9UQAMN2Pa7n/zFymhW80PJLUiLxD71n0WGNdz3Vl8u/3UY2WL49K2mEDSOA
         8XHP+gNvz1+TxLON1rHx/tqfbeOiH9YrHa7v+rxWQPV3SHGrdTATZ80ABMZys3Vg8wnd
         XPMV5epxGUavLn3qCUqTakbiNTiLxt2JjAmwsnOu/Ie68nTh87Z14GHYOEWgc6k4SFcJ
         JR5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6H0S1atl934RgX5MyHpSizBAdanG19AIr4VDRF7F++f2aDMRQxy6GU26JxgfU2u0Da7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHKYFgUdeBWH+bPWp9NQrVxZdrRG8evyLw5GCXZ2LQ40UVF1/r
	5XdNgbnyDRpMmQERDDaQ91thUoX1k1RfVcfAegYPQYsrOBbS4ToCvSFAnytxpx+tkd7X5qEgfwD
	gjXctM4oFXpDye+6w/cKCVpGYneXiIokZEZzjYsvu2apxwL6RDw==
X-Received: by 2002:a5d:4252:0:b0:366:efbd:8aa3 with SMTP id ffacd0b85a97d-372fd57fb24mr2452544f8f.2.1724250944648;
        Wed, 21 Aug 2024 07:35:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFguEF2AfMMWHH9u4at0L9cYsD4b608kMRe3EHd4+r93puOqWjRitnQ5PtgsiIk3CRcl7anlA==
X-Received: by 2002:a5d:4252:0:b0:366:efbd:8aa3 with SMTP id ffacd0b85a97d-372fd57fb24mr2452513f8f.2.1724250943820;
        Wed, 21 Aug 2024 07:35:43 -0700 (PDT)
Received: from debian (2a01cb058d23d60064c1847f55561cf4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:64c1:847f:5556:1cf4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898ac79esm15887277f8f.110.2024.08.21.07.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 07:35:43 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:35:41 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net-next 01/12] bpf: Unmask upper DSCP bits in
 bpf_fib_lookup() helper
Message-ID: <ZsX7PQNRh+9Cz7ig@debian>
References: <20240821125251.1571445-1-idosch@nvidia.com>
 <20240821125251.1571445-2-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-2-idosch@nvidia.com>

On Wed, Aug 21, 2024 at 03:52:40PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits before invoking the IPv4 FIB lookup APIs so
> that in the future the lookup could be performed according to the full
> DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


