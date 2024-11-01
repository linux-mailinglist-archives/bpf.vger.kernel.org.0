Return-Path: <bpf+bounces-43725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EDE9B909B
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 12:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7EF61C21460
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 11:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4E219CC32;
	Fri,  1 Nov 2024 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eco3gkaC"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0388317C227
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461667; cv=none; b=bvt26cAIxp0ZLoTGPxUUcC92nCgF7kPD+ECT889Dz5kz/yx4QnPVWWm24iEPAADeZrqsmCUhxkXEl+v3Vk2LZUqQqXGH4n91MWLvoAnNZsLNRVOPaI24xNZ7aV5zbMV36GP4AC8iXQiN/WQlgBbwjYWsDKf1+jhrx3YynpCtMCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461667; c=relaxed/simple;
	bh=rFzzuYAv2SKccWouLovsdeghCh1s+OmcwrhbhkmvI6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SQnTIy0SI5kYGV6MAbPu/0AC/Y4LFbNXxqxwjA88+GuZwrbVhC1eNJ1lag98l9bf3/veVW+KSXtv0Yaj7nTHj8iPSYbG2HLmcUf06i9/piEegcux3q6s4PRgCgN2rs9QsRNZfgwXsst2tIjCiWwJoTWoj49Ge5ixRocHjJgXLvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eco3gkaC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730461665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFzzuYAv2SKccWouLovsdeghCh1s+OmcwrhbhkmvI6g=;
	b=eco3gkaCUal2jsBudP/0QfivQkDelZUhrbiRCw5RyCOfGtNl/ArWssUY8+n2sepImBqpH+
	cbNOJ9Ok18P+UnyKU9DkyT0QOQXCp+AsY714qb2GvsdaF+tT79qkSjz9imMp34XPMVlueu
	CHxFHn7YysZyy9A1dCqlfs364hHL7Uk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-Yy4IaK7yOZ-q__W6n4k6ZQ-1; Fri, 01 Nov 2024 07:47:41 -0400
X-MC-Unique: Yy4IaK7yOZ-q__W6n4k6ZQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-431673032e6so11885555e9.0
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 04:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730461660; x=1731066460;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFzzuYAv2SKccWouLovsdeghCh1s+OmcwrhbhkmvI6g=;
        b=wm+eMxJbgSjaeVjX7WfvSjRjOZQDKs+hj+dZI2CmHd2K5hrjgSeYht/5gG/q4pm+VG
         U10wiQUHK7SfwT3dABQjIGBX/Ave8PCHVzor6XTsFiwwAdgBdWHhtMM3f0ebCSouq6Tj
         H90oJrMAAQyWk1l+kCHxvXobV/s4tHaaUEE6vQrRETl5pzkQeHjEPbMhUFpq/ty1ogzr
         s4tBP5w79rbC2dsqmqan2JUZib44aQZaT6s5CLk40CrH3kx4l3m6MVg7MO8NGI3lvOOY
         A1JB/Qn3sXqsYi84ooE86ojfqgTcZEa8qXqW0o5wfkrT3PerHey2K10Bvr9jTKX1Y/cK
         AcOw==
X-Forwarded-Encrypted: i=1; AJvYcCUUfQenvxeQghBam3C9LkcZp7SUDNNbzkl3sMMOW1PU+oSsr/3alslYK2pGdw+lTvaP0yw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypm0RWjERgrznyYlhf52XIG9VT5RNIqQYSjcTSHq0VAILVHxPq
	TXJEwp//DZPOLXgE+H1H/vwcVSKqP3YeuZURwNcH5Dsyj1M9dx5dd7aRui5mOQlnR148puWEKzc
	pFMttWtNL7xwcGO5xOGr1E+c6Zwm9IY/s1Jx5e0cqczdr8Zs8aA==
X-Received: by 2002:a05:600c:1d97:b0:431:5459:33c2 with SMTP id 5b1f17b1804b1-431bb99053bmr107786715e9.17.1730461660614;
        Fri, 01 Nov 2024 04:47:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNlCYVzQ8SAbhWfaM5n3nvXcLZFSRiXEpUvQ8tFWfAU9tvUBvRq0rnYNEnYa0nWbeMoxReGw==
X-Received: by 2002:a05:600c:1d97:b0:431:5459:33c2 with SMTP id 5b1f17b1804b1-431bb99053bmr107786455e9.17.1730461660233;
        Fri, 01 Nov 2024 04:47:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7365sm4783523f8f.54.2024.11.01.04.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:47:39 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BA4BA164B94E; Fri, 01 Nov 2024 12:47:38 +0100 (CET)
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
Subject: Re: [PATCH net-next v3 05/18] xdp, xsk: constify read-only
 arguments of some static inline helpers
In-Reply-To: <20241030165201.442301-6-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-6-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Nov 2024 12:47:38 +0100
Message-ID: <87v7x79nvp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Lots of read-only helpers for &xdp_buff and &xdp_frame, such as getting
> the frame length, skb_shared_info etc., don't have their arguments
> marked with `const` for no reason. Add the missing annotations to leave
> less place for mistakes and more for optimization.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


