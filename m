Return-Path: <bpf+bounces-39139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB37296F624
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 16:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034FA1C20510
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 14:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D089B1CDFA4;
	Fri,  6 Sep 2024 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMv/IHBp"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03741CE705
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631300; cv=none; b=tYRYGiFBrhusaU+EJHTd0z5veyIxFpQ4VbHvrf/VnDip2vFROVTNBu4TX9f9AfO5bQYW8LoddtOogMjn0KqDCtXkDuy5RnRqi19np2n5uqA923O6/tSseW5n3eY0a571ig1uOYEMMEIfp2wN8kXeN5O6HlGgZiofwgE9GNWufc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631300; c=relaxed/simple;
	bh=H9Qvvrts7066PRTQiTdtz7Ndcp7RKGYi8p8LT9X2boA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqFadHxoK/fZ9OlAzB8/qoI23WwwhA5inBmm67UQh2Dtsqcz/xuf26EyIQdVdVi2/hO0jFnuwVu/Iv7kC3hn9w0oyGOFOq9Uj3DTx1JQdFJCh1Bi485mrMFTo2hnzO/e2Lg6Y4bC6EtL8CzUTNSF9BEBG67jAPx9VeBqqbhNFk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMv/IHBp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725631297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H9Qvvrts7066PRTQiTdtz7Ndcp7RKGYi8p8LT9X2boA=;
	b=MMv/IHBp0+sgtSayIpCeaSYj22+gNT2RidcllNXg9f80LxaJaOhCwHomwR8AxHvhEK2//O
	ebD89rpgS/D8FlbGoEEuO1QQb3RNRqwRuU9zqoySOD10WT1v9TH06K1tYhl8yfc3ORVw7Y
	ShVBdtlPVJdEyjUzMJzFCrTZa5z2CoU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-4DWWwcGYNsm6pMNjgFXkbg-1; Fri, 06 Sep 2024 10:01:36 -0400
X-MC-Unique: 4DWWwcGYNsm6pMNjgFXkbg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-53659c3c9bdso567287e87.3
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 07:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725631295; x=1726236095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9Qvvrts7066PRTQiTdtz7Ndcp7RKGYi8p8LT9X2boA=;
        b=faz+tESFROeqiW+h+crJcW8wWUL7rLqtzurdHI7VgzRMo7YYVZRNSZMcqSO15Hu371
         SDVQlb5oYc9l7P8C1k/JACCxKtibrUUw0qrhdkTldru0k7fTn9uNE06hGyxzMai7n79H
         Pwb28R1vbWivfihhk32FcyLiTqYsgXUTt8Ce3DjeD5s0lhyScrCyYbMTZbmu/InL/OBj
         40uvc+laesVxGWl3ZY3BbN86HDpVYcF1MkT26a1ESp31DyNKOZwqydeekmLBamfZTpD2
         c5ZJce4bYEkEH60L0D5EIvIx/ULIjv6iligmV765cS1sQ9WB5w04u7CulZsrqq/waNqe
         mcOg==
X-Forwarded-Encrypted: i=1; AJvYcCV4eN6ZUES7PtAwbrT9xzNRG0aiw3aHABYjRTAGLObY1XtPawgf4+xuhkk/WbO47HvlD4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfu/zf+ugVLFZpoTBXPeUIHgqZ8EObYDybXC0vawigVZPzS2QE
	gDGeeN1hR7sczsLXNE2M6LvLwfpm2fqLUDIrUujPhPWrKNm9bGaY8T5cqOAwpM481o3Kt7OcuT9
	o4KEX7WHstLrl8s8lC9CwGC47sBcaEHlePLuD6QURnXirmeVFow==
X-Received: by 2002:a05:6512:b24:b0:535:3d15:e718 with SMTP id 2adb3069b0e04-536587fcf0fmr1730148e87.50.1725631294278;
        Fri, 06 Sep 2024 07:01:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESh5ryxYIDRtv0PMqngwp2r/5lvvEI+2l0OS3wHQLQGUs23BzE3eAyNjglC8gFpKq8yS+EfQ==
X-Received: by 2002:a05:6512:b24:b0:535:3d15:e718 with SMTP id 2adb3069b0e04-536587fcf0fmr1730009e87.50.1725631291471;
        Fri, 06 Sep 2024 07:01:31 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05ccc27sm21647655e9.13.2024.09.06.07.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:01:30 -0700 (PDT)
Date: Fri, 6 Sep 2024 16:01:28 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 06/12] ipv4: ip_tunnel: Unmask upper DSCP bits
 in ip_md_tunnel_xmit()
Message-ID: <ZtsLOBY/jZi7rrvT@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-7-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905165140.3105140-7-idosch@nvidia.com>

On Thu, Sep 05, 2024 at 07:51:34PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when initializing an IPv4 flow key via
> ip_tunnel_init_flow() before passing it to ip_route_output_key() so that
> in the future we could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


