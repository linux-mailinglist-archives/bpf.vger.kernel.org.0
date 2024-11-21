Return-Path: <bpf+bounces-45371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDE09D4D24
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 13:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAF71F21376
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 12:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0741D319B;
	Thu, 21 Nov 2024 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dkq/XEJ6"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31D51CB322
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732193456; cv=none; b=UBadzAU6sdKUeO0nlAjUvPBz+mZZtnZTSsXFFqzFv2oeew5yDvX9QqXBoWx1WPV0cx3sAzYNY4KDEa89tMFMkit74xN2+zPpYS4E74mMtlaP1COQ64G3MNWwY/9yElWdib6k+pGlUQU+4e3oOcruQWJGaaSg5vuIIagLeJbC0xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732193456; c=relaxed/simple;
	bh=hp/rA5GboI6KXkHKCYTGiePu+cBAU3amUicgGeUJH0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fgsOvoW0z5Zfpi5HpBG10cbzYiFCFOD4u7CCw0fdmweAvidBjL1W+hxco9BdyaX971SE6lkRlrRp/QA6oyypLp2GyCAniul6fHWnAPexP8whyGKKjwQuG3tcxZEIjeiCDhbd8RLBOShCq8TQYL5KZ6lIPYkZ3VT4Q1ogR2EQdCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dkq/XEJ6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732193453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0m8HN5tCJGpe9t9MW8TFNZkdTFX091MkcGDpm8iKmhk=;
	b=Dkq/XEJ6K0lnD4Oy6ph0TEcoM8hHgF1VdbBtCvNrEJeYFZ0j3jbuth966g+Kwq3V5uDPGC
	U+YfxrorRR1vS+45u9eHOCq4sBH2TYynZAcw/bv4B84UwzDYKzW1NRXru2P12ReXCnNcmv
	gvlTOCNGowkVrEQBDYeub09a/k+3i7Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-0vZljlVBPMqsyWo_37_zvQ-1; Thu, 21 Nov 2024 07:50:52 -0500
X-MC-Unique: 0vZljlVBPMqsyWo_37_zvQ-1
X-Mimecast-MFC-AGG-ID: 0vZljlVBPMqsyWo_37_zvQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38242a78f3eso491147f8f.0
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 04:50:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732193451; x=1732798251;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0m8HN5tCJGpe9t9MW8TFNZkdTFX091MkcGDpm8iKmhk=;
        b=iX5X4wZlhkDvZSWa1jzQzB+tk/B8pXFbSC9sD6mwDS2a7U1ZoIeNaGfAwmpl9AfdWA
         xkkwMsYdDxN/hHDzXo3pIIvbOHDh6WKztJ70mdF+lHfNj/Fk6sA5RLalCjBtdvW+j8Vs
         1TG/hwptKkd23CgjY8pnMFfbQHLRL+LRr/AWlMhc7HLOfiq6humbLyZJZNqUoeNBSVNN
         H7dNKbGzc3o383fVFxBL6AOxLwN1gInM1ohUqMUAHz7RAze+06vvvapgUg3hUgDoh/7s
         7t3lhvgU7JExw871MAR19tfWOEWHTd8C1Dup0sOR6/mD2vd3T6NcXRaw3GSo4BxH5v+P
         7QXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOt5LDG3Nezp/otRUuoohHTuegckWgHkGSBeHPq/MTHJ07Iu5RATWu7dPAjjdRrRcTZeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh/peAhpVsTBbgpb4abSjpk0oMdMgOQGEGQ0tCzIZhuvUa+uPS
	YrFYXENBSUspFR6x4iGGD1ygaZMCHXKnst/nIbXhOpuoMwyoAUaLDQ2UDLgsE0rO8YrJUq4YZo3
	qb3neh9fd9DdiufOEyHK4AgewWaJGJXj10ZhK91JMIT6NMyfRcg==
X-Gm-Gg: ASbGncuKZWc/35L9wYkP7SKUPIxB84AGNSXDQD/XzTeoszec7D7ud5TVI1jqXAnD+a0
	oR9DwC1H8UvQWZw65RLQSnNDXpz0ilqGMn1nWiWkyOM9mgnUOhCJZ7nudQQmaFDDOVllgvYZevH
	BGMDj8Kok/+0xCqBe9JahLtyrpfY9HohzfpE2/oArlFj4YOKnSb/P3JiCIn0MxznsLjhNsGz7Y/
	gvlbfLPqN/LFMKiAvJDKWV056kj5cTKwW5OSTOtPHhxj8QCzbCfQyFy1w8UngvWcM67rERHrVI=
X-Received: by 2002:a05:6000:1561:b0:382:4a84:674 with SMTP id ffacd0b85a97d-38254ade09emr5473266f8f.6.1732193451160;
        Thu, 21 Nov 2024 04:50:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1Rc4I39I+8xq4+TVBfqfXzPHfYtExOus39kVkgBr0YFCdXqxroHStrhqY3IXCZtq2pZO7Bw==
X-Received: by 2002:a05:6000:1561:b0:382:4a84:674 with SMTP id ffacd0b85a97d-38254ade09emr5473235f8f.6.1732193450830;
        Thu, 21 Nov 2024 04:50:50 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b01e115asm58304855e9.6.2024.11.21.04.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 04:50:50 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4EB03164D90B; Thu, 21 Nov 2024 13:50:49 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, Martin KaFai Lau
 <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri
 Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>,
 houtao1@huawei.com, xukuohai@huawei.com
Subject: Re: [PATCH bpf-next 07/10] bpf: Switch to bpf mem allocator for LPM
 trie
In-Reply-To: <20241121124649-bc310634-8cc9-464e-bb81-6a9ad0f8e136@linutronix.de>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <20241118010808.2243555-8-houtao@huaweicloud.com> <8734jkizoj.fsf@toke.dk>
 <20241121124649-bc310634-8cc9-464e-bb81-6a9ad0f8e136@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 21 Nov 2024 13:50:49 +0100
Message-ID: <87wmgwhhsm.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> writes:

> On Thu, Nov 21, 2024 at 12:39:08PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Hou Tao <houtao@huaweicloud.com> writes:
>>=20
>> > Fix these warnings by replacing kmalloc()/kfree()/kfree_rcu() with
>> > equivalent bpf memory allocator APIs. Since intermediate node and leaf
>> > node have fixed sizes, fixed-size allocation APIs are used.
>> >
>> > Two aspects of this change require explanation:
>> >
>> > 1. A new flag LPM_TREE_NODE_FLAG_ALLOC_LEAF is added to track the
>> >    original allocator. This is necessary because during deletion, a le=
af
>> >    node may be used as an intermediate node. These nodes must be freed
>> >    through the leaf allocator.
>> > 2. The intermediate node allocator and leaf node allocator may be merg=
ed
>> >    because value_size for LPM trie is usually small. The merging reduc=
es
>> >    the memory overhead of bpf memory allocator.
>>=20
>> This seems like an awfully complicated way to fix this. Couldn't we just
>> move the node allocations in trie_update_elem() out so they happen
>> before the trie lock is taken instead?
>
> The problematic lock nesting is not between the trie lock and the
> allocator lock but between each of them and any other lock in the kernel.
> BPF programs can be called from any context through tracepoints.
> In this specific case the issue was a tracepoint executed under the
> workqueue lock.

That is not the issue described in the commit message, though. If the
goal is to make the lpm_trie map usable in any context, the commit
message should be rewritten to reflect this, instead of mentioning a
specific deadlock between the trie lock and the allocator lock.

And in that case, I think it's better to use a single 'struct
bpf_mem_alloc' per map (like hashmaps do). This will waste some memory
for intermediate nodes, but that seems like an acceptable trade-off to
avoid all the complexity around two different allocators.

Not sure if Alexei's comment about too many allocators was aimed solely
at this, or if he has issues even with having a single allocator per map
as well; but in that case, that seems like something that should be
fixed for hashmaps as well?

-Toke


