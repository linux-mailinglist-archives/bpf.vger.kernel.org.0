Return-Path: <bpf+bounces-59657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC148ACE2A5
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 18:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10ECE166D94
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 16:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918FB1E5714;
	Wed,  4 Jun 2025 16:59:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F881F181F
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056369; cv=none; b=WnOHK9e8dIafIHVPSj3ccW//kmXvq7mOVWZHqhF3PC94+2jx8QVce4hJ012BmrdfG8t7uPzLVz+Ov1YrMAefJY9Q0Thscz2jiDnhUXf/2updyQAX3x/lz9xFspllO4HnkNw5aHag+my1Jm/OCmh9SwmIbOAuc/eZNmo+nwlDwso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056369; c=relaxed/simple;
	bh=AwLlp//63F4GIVocx29/odhVq+nfcN5ufbpel09x4kk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JOWutqrVfa0ds0EWrvAm44VndvlIYriaQuxjIKLARsdhXtI+U8q1v3tbrwAnm6WeAd+sIDCB1vTqoYtkBI2M/Uga9yJFON+vSRGIceKij5SKfbyJlbuJ5Y6VZjBO6YRIpaaCy8XYUWRNSjRRpLiwjfXLmarYLC43lh+CLpuv7Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-mdJbUTnCP2K9TGvwMYwc_w-1; Wed, 04 Jun 2025 12:59:21 -0400
X-MC-Unique: mdJbUTnCP2K9TGvwMYwc_w-1
X-Mimecast-MFC-AGG-ID: mdJbUTnCP2K9TGvwMYwc_w_1749056359
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ad51ceda1d9so110513366b.1
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 09:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056359; x=1749661159;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwLlp//63F4GIVocx29/odhVq+nfcN5ufbpel09x4kk=;
        b=vuZsNDcs04egUuBqszWLfAk5McOOgo6XlUIUThHCJheQ9qJU6LmXsByfqbFQ52NAt1
         1vASdQ5Z7g20alznTib7ndLQ+FSyP17QL/x+6aRFZex8XHsghhCXtiKNMSe5+aSYhP/F
         WwLeesaApAnnBUWnGvoxcNKPUKPqTbK/E/7L/37ZViIKfKIOdn1Iz1uRZXoFzEzDag7p
         XBEaP+OLVu2MbSEXplmRh89rocoBghHSFLOTWMiVqZ9wnnPQY2TfCxlDZ4HHkQwf7zBV
         tHGGw6Z4bgRLZDN6wNNzmYbDhhifZuwR0CHlfjxJcYIyVUNl4916xhks0qXvDgi0HMRz
         +Vzg==
X-Forwarded-Encrypted: i=1; AJvYcCVgx/DkpOF3reINJtnlHTAMaqNnkiK30K6UlV/i6p1GchHTld4loTA8EbyPJcrMNBJ3tu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo1PFiJGd8AYPkaxE2LlT08pf6MZsgKWqfEB0j9F3N7YCn0VrK
	2Th9JmidbF1xwh33TuyrmIOK2QUis58izwPy7kypMkygipAcq8b9xHl4DI0T/xFPlwCDKzVBKUU
	+KcfP/4EkCXL0y8wM+VRgnXAY4VxWe/HBRAFpwk4XpiUp0LiTBL52zQ==
X-Gm-Gg: ASbGnctCM4BZzpz1H1yQ+j7X/VmsQID44+PQmW/6GM7p/rqqH4FEF2aNEdpIDQpasOy
	1x3H1y6zrN5LpJfUcMLyEiZA1ecMGpHyo0YoOZraqVVyJGfDj83a9eaeFRDWUlDosHfY7Ul1yOB
	4xrrvjjZ/lNqb1+n9rvDOevqhiGe3Ut2cNihqqsviz44+So6So7gIgFHkeCX7q4kOdesb7Zrjqa
	WOoEdQ0MFRJ1+qCPQLWsG5Gbl6lf+MTkjpoOOU5C+7myryyJ31oIi6MGlNCbxfMcb0+Pz2Mt/ci
	8Un1Xr+v1+bg2mXF9jw=
X-Received: by 2002:a17:907:3d02:b0:ad5:7048:5177 with SMTP id a640c23a62f3a-ade07826795mr23293266b.23.1749056359072;
        Wed, 04 Jun 2025 09:59:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4ivvclbp7JuzcZvieRJ0FZQ1qJdp5hxjTJ3O1n+o2T0S7e90wjVjWqBmgYnG1KObQxDSmLA==
X-Received: by 2002:a17:907:3d02:b0:ad5:7048:5177 with SMTP id a640c23a62f3a-ade07826795mr23290366b.23.1749056358629;
        Wed, 04 Jun 2025 09:59:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adb2d1e2d32sm1031777366b.60.2025.06.04.09.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:59:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1929B1AA9168; Wed, 04 Jun 2025 18:59:17 +0200 (CEST)
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
Subject: Re: [RFC v4 16/18] netmem: introduce a netmem API,
 virt_to_head_netmem()
In-Reply-To: <20250604025246.61616-17-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-17-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:59:17 +0200
Message-ID: <87h60vv3x6.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> To eliminate the use of struct page in page pool, the page pool code
> should use netmem descriptor and APIs instead.
>
> As part of the work, introduce a netmem API to convert a virtual address
> to a head netmem allowing the code to use it rather than the existing
> API, virt_to_head_page() for struct page.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


