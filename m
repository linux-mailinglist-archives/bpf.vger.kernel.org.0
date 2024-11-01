Return-Path: <bpf+bounces-43729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 533C89B91A3
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 14:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D03E0B22C68
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 13:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E5A1A01C3;
	Fri,  1 Nov 2024 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bj1uino/"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AD2156C5E
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466823; cv=none; b=TeS85v/+OoY34Oga9FKarS72ehu0yNJTG8ZmFUvyFSg0Egjp7yHsAQZjsICaZ6LjM8uLUVkTB8kYPZsorE3zeob0agFJ1G6lWtjbA0O71/SU2RnAkE632Rn8AdSWv2N8hjbSjeKhI9GPWsppaEIWTn7egl4lD/M9LIy6B8ameeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466823; c=relaxed/simple;
	bh=L5CVurix7+30nzpI9IV03X7MQodXDpgxTJqDlhMhtTg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oMy/hhugYGNeORwdJeqGDIggZ3hCB4qC5gQvxsCnwvo7m+aQlZNVUAFpLFfVtlkjHaWN7WKT6SHNlRcecdApv0kSYOC7lKXrpxr2IftWutqQAL1sB8o4mKQnRC8X+77TrCoqs6LYrovwbRHM1qw0WdzxX9nSDtIitmlYCwQpiSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bj1uino/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730466820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5CVurix7+30nzpI9IV03X7MQodXDpgxTJqDlhMhtTg=;
	b=bj1uino/aWHMlY3ex+CyFQrp1+LBsV4RdpBs8ih90YzdKA2GFH5U3qf+Iu5nnoS5BPYQ+z
	sn4AaqxcG7s3eNQxovqc8GjQfIS+gcVDvm34kthj+YHpC+P1U26gYs4uKwEik96R8749hq
	qD0yj6Xu/QCCOeOytWt/CzkspCrKvMg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-P8n1AnygMFeRHrFlc6NBMw-1; Fri, 01 Nov 2024 09:13:38 -0400
X-MC-Unique: P8n1AnygMFeRHrFlc6NBMw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9e0eb26f08so168812166b.0
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 06:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730466817; x=1731071617;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5CVurix7+30nzpI9IV03X7MQodXDpgxTJqDlhMhtTg=;
        b=W6PDEoIv+p//WYwy/JH2gE40csSgktgIO5J9t4fYbPfkrgAxF68Pjl5IgZvSGT77iY
         BT5QAWZjMnmX0l6/BfYbwSZOXOxfAhMpaiAC/EGPu5M/6go9simvu5swOUfdnRGfjIzO
         E3VkCoT3JIlVeQFEf/Qid2jwosj6NXs9c7vK49BMgbKvua8UNmZntP+RpCWOZNMhosRJ
         e13BAjp+AZpEP8N+1kwWbq8MLFFxNkLRRPhJj8WFeHiPpa3g3svD3On0E2tN/Ve71ZSb
         KdNaXfQnPd+uyeXdGeyzkkOKSqrkdAx13s29COb9OQFUtgCFfO0Awh4hDHvULfAhMTdM
         ixeg==
X-Forwarded-Encrypted: i=1; AJvYcCXjDt12EmX91vSSvviIyqdmgL/bxpR7CqKJk7vhRVvcdm8XWDx/i3iXryu/pE0B4jLJpD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvdc8EhSjty+iv3xGuD4NmHFxXcnF4nscPtFXvHQNmrG3U8zD2
	NibODi9VXYN7qdJoziTA8LmQDOiGucH6hYY+WUKxIw/Kra/mdN5g/7karVaTjWV8fnkD1Co7spi
	uYJFb8jyLT3ZA5ZvOV+eYeL+1jj52CkhrtO7rANL+ebW1AFB9XQ==
X-Received: by 2002:a17:907:3f99:b0:a9a:bbcf:a39f with SMTP id a640c23a62f3a-a9e3a6ca281mr1084509966b.43.1730466816972;
        Fri, 01 Nov 2024 06:13:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuHAS1/AYRkBTQXHwF48y6LdOUW+QPelszDi8D+myCfGJMI1eTs1lFcGd+BkSBw+5Z+W4uKA==
X-Received: by 2002:a17:907:3f99:b0:a9a:bbcf:a39f with SMTP id a640c23a62f3a-a9e3a6ca281mr1084504966b.43.1730466816491;
        Fri, 01 Nov 2024 06:13:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565e098asm178704566b.132.2024.11.01.06.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:13:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E7766164B965; Fri, 01 Nov 2024 14:13:34 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 10/18] xdp: get rid of xdp_frame::mem.id
In-Reply-To: <20241030165201.442301-11-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-11-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Nov 2024 14:13:34 +0100
Message-ID: <87ikt79jwh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Initially, xdp_frame::mem.id was used to search for the corresponding
> &page_pool to return the page correctly.
> However, after that struct page now contains a direct pointer to its PP,
> further keeping of this field makes no sense. xdp_return_frame_bulk()
> still uses it to do a lookup, but this is rather a leftover.
> Remove xdp_frame::mem and replace it with ::mem_type, as only memory
> type still matters and we need to know it to be able to free the frame
> correctly.
> As a cute side effect, we can now make every scalar field in &xdp_frame
> of 4 byte width, speeding up accesses to them.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


