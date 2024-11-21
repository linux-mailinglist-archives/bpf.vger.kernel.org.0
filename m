Return-Path: <bpf+bounces-45349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C7B9D4AD8
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 11:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF79E287EE2
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 10:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C9F13B58B;
	Thu, 21 Nov 2024 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2aMupyJ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572D31C7299
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184750; cv=none; b=UvmtFn/Vn2Z0FOERFeZXRjgdXjSqFSedmgR4/9Eq42hHlZ3HULszeSqpG2IlWtxpPKyFKWaGU0a4pfTfcZsmYHDEJfMOszo5Y9nuZEEbV4YpKRP6gZh87WqwrUFv13JXlp+PCmyH9jvvRpIHkV5mz5NecUzaOfpKnCEjkKqmXjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184750; c=relaxed/simple;
	bh=UZ8cM1uYdrYJxP47AFHdB0yp4Zg7D4x+JNIYLbXJ1qw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HNoSmGpRIcHY0OkBeWERARbNoUim2hg1Ko0fG1ky8KJGL4nYMNb9Qc7UUHCvSJh5hsnmlo7v1+r2ez96O/2aFqvpl+ec/hZa8e5jkm0vDHPY4TVZeJQCVWWXGvN0MfU72dHz03I19jfIpdo9bTagM9d+bR5xmuSKk0c0KsiKcDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y2aMupyJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732184747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZ8cM1uYdrYJxP47AFHdB0yp4Zg7D4x+JNIYLbXJ1qw=;
	b=Y2aMupyJBKCnuNjKFAfHGChHqJRTgweLbGFnAMdC4BnzS2PZmRw28RaP0qzqySXEaYopzd
	ROfd+7eok/x7iL1H3SLla7pedko7OfUd/gZMb3GqwIwdFKz8HsppxIAYrG+H643Yvbe9/K
	wQy1qL+T2i0OL0+NRnFwdzQshiR1YTo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-R44CVUi4Od2zGXro5oDFUA-1; Thu, 21 Nov 2024 05:25:45 -0500
X-MC-Unique: R44CVUi4Od2zGXro5oDFUA-1
X-Mimecast-MFC-AGG-ID: R44CVUi4Od2zGXro5oDFUA
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-539ebb5a10cso597362e87.3
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 02:25:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732184744; x=1732789544;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZ8cM1uYdrYJxP47AFHdB0yp4Zg7D4x+JNIYLbXJ1qw=;
        b=sWUbxA+Ig9WrElzIFhvcho2Yy/8ASjZ2kjw2uNNcQuJQMQj3ch6yUAYsZL5Via8vmn
         efq4vKUYpWccxV6YnsWHKjJMWfqt7USnedGoTkHxJuazjEXMpaylp9XFLF3u2k/0j3P9
         QSwEPUik/1RcdiP9sUUiPh4nswKOqlfWCWuYKsiAsVOuUvOtoHZclrMVgTwXpcWDm1PL
         5pAe8bw08XwWJAVBF6UJhvUe7dXvhrJfmm/uXsjoGllod+IQmOEddWE/rV7k/vwUxXnR
         Ms9mFeJ9XyRh7v8q+17WAOv5RK2glJmVIDH3aX1goJ6BlBEDMiqZBmlMVLL1d3/3GSc9
         sKhg==
X-Forwarded-Encrypted: i=1; AJvYcCVAIbI5vQLdH61T0Zw3LPbF3NiaL4WxhfStHorTMx3COKRAJyqGn8sKK/fnWfmec9XMVfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5iS7Um+2fmNDHOEZowUfvn8oO954wsW84A4mv9WmKyge8+yp/
	mMWVlU0r+a4aM4ot4vGVYH6nAs0tuMN76i5gikcaBlCib6cbe7K7voO2F86k6GEhOZ4p1g2T3py
	gofb87FXBZxDT1+FHBzWwL2DdXH2+y5Jw2y/DF+sToj8ONWZMUg==
X-Received: by 2002:a05:6512:2214:b0:539:8f3c:4586 with SMTP id 2adb3069b0e04-53dc136babemr5242607e87.55.1732184744189;
        Thu, 21 Nov 2024 02:25:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9jJCbFHMGfga3YWld4LxJ9T0RLL8xE1KFiQpn2IKAtLVQ8a4Lkxu6tK+1wpz6Im+uXCHAoQ==
X-Received: by 2002:a05:6512:2214:b0:539:8f3c:4586 with SMTP id 2adb3069b0e04-53dc136babemr5242575e87.55.1732184743763;
        Thu, 21 Nov 2024 02:25:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f41805bfsm64092666b.71.2024.11.21.02.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 02:25:43 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5B1D1164D8D6; Thu, 21 Nov 2024 11:25:42 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, houtao1@huawei.com,
 xukuohai@huawei.com
Subject: Re: [PATCH bpf-next 02/10] bpf: Remove unnecessary kfree(im_node)
 in lpm_trie_update_elem
In-Reply-To: <20241118010808.2243555-3-houtao@huaweicloud.com>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <20241118010808.2243555-3-houtao@huaweicloud.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 21 Nov 2024 11:25:42 +0100
Message-ID: <87ed34j32x.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hou Tao <houtao@huaweicloud.com> writes:

> From: Hou Tao <houtao1@huawei.com>
>
> There is no need to call kfree(im_node) when updating element fails,
> because im_node must be NULL. Remove the unnecessary kfree() for
> im_node.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


