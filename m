Return-Path: <bpf+bounces-59653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A80ACE296
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 18:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308D5189C811
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 16:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93C21FDA61;
	Wed,  4 Jun 2025 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X76reIEM"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BC61FC0E6
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056131; cv=none; b=QmMY4IQw+shAcxYHunOG7CXlM2DmElhHK6VDhqICoK1tjesTXs2GKkdQjgI2h3xgmy8xgO6kKv8NMdm7y248GaPk9kZNni3P5w7kC01tZhOMiFlXglCzbA20nOayeX3vo3xPV+AxM+GCd5BXWFVzQHxJSd639ySGFSeEhQwuF+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056131; c=relaxed/simple;
	bh=EnhN4jFQnJm7PRT0iNbSmd2PcRrtPdhuDjTVGsmqhS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EabJEW6CyD4zh+sgYYUyDUckSbH5woT+TUnelrPkz7hzJTdM1DWT+5Dg4pvEI6hpDx5uUWiMrwRzN26xUVWgOSkoIvLtmpojABGAe0K2UHEAqnZwGxXib+hv+EWUBPnDSj7yIx9eSqNOQ6fvWbrdn5/yByfhx30AuULCo8DUDe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X76reIEM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EnhN4jFQnJm7PRT0iNbSmd2PcRrtPdhuDjTVGsmqhS4=;
	b=X76reIEMqdgc7ORiIHmizaBp3GUUK8ox60wPouFSricciC25mFBbS++8r/NghXf5mijgFf
	bM0Y1YwuFfDxvgiQSDTihM/YVLdS0r/kcXTBlWQ4lBYexFWZh9sQQBQX3rOJxKbzgwlzyp
	fDjXJyauGB/75xOlQsOyO8TopfcJ5aM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-sLPmYXczO3SDtjvRsCRXTQ-1; Wed, 04 Jun 2025 12:55:24 -0400
X-MC-Unique: sLPmYXczO3SDtjvRsCRXTQ-1
X-Mimecast-MFC-AGG-ID: sLPmYXczO3SDtjvRsCRXTQ_1749056122
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-604793191acso7154872a12.0
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 09:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056122; x=1749660922;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnhN4jFQnJm7PRT0iNbSmd2PcRrtPdhuDjTVGsmqhS4=;
        b=o4ElGh4x3cAef9f2+nuIUuppmI6YhcpxlOo1yAjND58UL6uC+f9Olf/YhXMvWS1wg0
         FMDSsxUGiHhG3gg4BBdPnqOFq63NE2era/K72DkWd1DBo8NukcWj1oN1y/tNQ1AZUhog
         w0kr09nlItKTOdiACWGPtwk0DTVtIm4bMw3paQlw0clZpXw441qCiJQ9+epCG0JduwY6
         uyaKD6kUtCv8SRPSrkFqAzsp7yuUDUCik2bRuTszeVMOPu+iedvwnv17Gnf+roDgrCaZ
         i2+3Zs/K55hC0WWq04Ok0bRQWrmEngcBR+eMI4z20QLJS2IbsNKRr85agsLean7qfy9L
         LpSw==
X-Forwarded-Encrypted: i=1; AJvYcCV3/jKvkCyOlFPXumoyWTcXA32pcWshFYWVO8WogsuDFplQoRQPiv+lJEpwkwAfyK31ciY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyAaD1AHAvi6s8QBjYWzxpjboSFSEQvZ+JOics4aSIQURyNCmH
	sznSMJ5A03lgaoQFzkGuQeBZ62/bovMgA/NkCyi8TZDn+r1W002V2CG+UaGO8AyVQwms2fZAqId
	t48D43/uulVPs1FhuX8AVmGAYeR6mJ3LftuRNPmd8BDQqdOlr1yT0gA==
X-Gm-Gg: ASbGncv0Y3czAP3wPU0ZPe5pMTEZpHJFmyY/l5r/UuiybSj95QdVAhQZvkIf9prMNVe
	b+qigxstfGtbpli533Tvp9pqNyUzz4YlR66WTdr3QGVvP956hl3yroCwJhrVvjCJQTfFhnDh+a5
	t9WliEmDq4aZ1HafLrfeErNhJ8QiwKfnTg0xnuMVi6n608Xh6b6VvKtCkjt5fj8BJb6jc27sxlN
	VO9cbLEB3sdByv0wdMNyQ0n/mVWlpjUnkOwcHn0Jy3+smut5KCZXkWYK0Xe4eE7/gV7laCAn6Fz
	ywCIQirF
X-Received: by 2002:a50:9f8a:0:b0:606:f836:c656 with SMTP id 4fb4d7f45d1cf-606f836d433mr1955702a12.19.1749056122178;
        Wed, 04 Jun 2025 09:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+BjJ2HDUdmh+5/RYHtCz7LviWdEXcE1ZllvhVdcERGB6/R14KgQ+G7LcqUq87LQrs0WIhnw==
X-Received: by 2002:a50:9f8a:0:b0:606:f836:c656 with SMTP id 4fb4d7f45d1cf-606f836d433mr1955643a12.19.1749056121651;
        Wed, 04 Jun 2025 09:55:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60566c5a8f1sm9163889a12.20.2025.06.04.09.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:55:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0ABE61AA9160; Wed, 04 Jun 2025 18:55:20 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
 leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [RFC v4 09/18] page_pool: rename __page_pool_put_page() to
 __page_pool_put_netmem()
In-Reply-To: <20250604025246.61616-10-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-10-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:55:19 +0200
Message-ID: <87sekfv43s.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Now that __page_pool_put_page() puts netmem, not struct page, rename it
> to __page_pool_put_netmem() to reflect what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


