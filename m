Return-Path: <bpf+bounces-45937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B829D9E0635
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 16:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D39228350B
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 15:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC411204F9B;
	Mon,  2 Dec 2024 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVis5HW8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBD7204F81
	for <bpf@vger.kernel.org>; Mon,  2 Dec 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151895; cv=none; b=f6n9maOkXvMFf2plPPEaMyWcYx1+9OZjUmH0r5CPVH6VOmIJczaQ9KbF2ZwWgm36xR1TVeX72OhitJxHoTedDpYWCgGfCL2P2v9E9JGwEezlPna41NdI7LpH7I5HTDpJkNLlVxhk7pCR3DGb7QM3LVW1/0zEthvawQu9/sW86ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151895; c=relaxed/simple;
	bh=nKPz1YY8z9eVQgn3Z1CFf00Z+fJBx2iIvDW8235cJHI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YAf8XMsFPqlHP8HKHqLWy33qe3LGiRWSqGfLc0AyBakr5txGP0m+z40cmDXPfupjnwpyyKbgPyYqNhsnmFx0E68pBaQFrr4rvnEzeHBxvZWx8TGaxB/q89L5dX1BmzNh3ARLBOfW6gj3wdigBe0eXOk8TSXPkMGNMYeZTVuT0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TVis5HW8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733151893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iFDi5MCDReFoFa9/JUYYh+TH5TgtLAOTwQ3k4sJjTO0=;
	b=TVis5HW8evDL7vNHsSYbZcozvLCyKzSxM0OnpKg3eVu5MY/ZVeiUikvJoU6DU6IhHYKwf8
	68Q22oaTq0bNJMH5LZHY+9AvLJZ0HXpywkfO46LFdDqWbi0uqZ+4y2qdygaFNaeqHhIc+W
	wduWL1tileUIuowxX+7VMTU5UXJ819w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-zFSlmO-kPYeTmveNXq0e8w-1; Mon, 02 Dec 2024 10:04:51 -0500
X-MC-Unique: zFSlmO-kPYeTmveNXq0e8w-1
X-Mimecast-MFC-AGG-ID: zFSlmO-kPYeTmveNXq0e8w
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5d0ca174864so1502547a12.2
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 07:04:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733151890; x=1733756690;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFDi5MCDReFoFa9/JUYYh+TH5TgtLAOTwQ3k4sJjTO0=;
        b=xG+5AfkgmU2XO0bJGdJ9f7TGcIRr1JjuEtIyZ3tabv0QluGNEijmGkrkqhIwjFuQeX
         CAOKA/iZmN+Qa/BKVv2z3iZ/bKX/s8/5QlNePN4mDWiVc13iezP36zYrKL/EOiiUSOyN
         0nJlVyJs5V1ZpFlsM4tmlkqabs4MaVidekABuPKpdjnbPfEKPRNZVyTQDGmfXqxwyzyi
         nUeubImIeAaYebs7TVaVMsuKybkGMXtfrrispMvyKtVLZrE24Nnt3qiMoXRRCAP/XJAP
         6VPKRcJM71vgT6pjdvLYobC4dxoZtbHz9gLDkFQU1b6ouqMfuqlYJMyjMd6715D0RE8b
         UuEg==
X-Forwarded-Encrypted: i=1; AJvYcCWDz1I0ursrJxnyrt5ZU7fHSKVuB5me26cXbkSUk3gcZW+lv5MQPxgGG6PHUNgIqffDRgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzHDxcSOYTReIHsWtrHYSj3hUFwQ2oKhuevDRR3q3DC+cs5JK8
	xUoZ7pNMJOuviAo4quFX9Dsh5SXGfMEm9CLbjotypOB6t5LmyXhyD4YUQYqOZnsxed0+5cn74CX
	oowDyMfdYQJ552BoRf8yYng660BWpc1XEj55yTO8hCjfoaU0h6Q==
X-Gm-Gg: ASbGncvYO3NK5d6ltpR3QZfrI0/qlWKUDOr2+cm1eS4I4ToDmlyIFq0hXEmuO/UT0cC
	33gpzfEbnATWpponeM7O1C5UwpJiBWVyyY5zvQhDz8C1ZBaIO2Or22gvSZTAXpkxovCWyZVItv2
	Rq4GdlITgeH7J1cxeYR+wQ1Ak2SBe2onHsFmpRbqytq6+FNlKZfGXzmNvjXtLoFslM6nMZFXZAk
	FKq0M/UHNgPQKMuh1Xf9vnfpQYgnlZ0TwVeWp3LtK40I61+f2TY5/jKy1aILxY6dySCKx1iRc8=
X-Received: by 2002:a05:6402:34c1:b0:5d0:fcb9:1530 with SMTP id 4fb4d7f45d1cf-5d0fcb91ad7mr1824352a12.33.1733151890159;
        Mon, 02 Dec 2024 07:04:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETLR/sXsq6Fk998Z/jlBpMBEgh4hn4DMDmdQypRs3S7xxuQPi+56Hm4GoUjp9vR+XHyq443Q==
X-Received: by 2002:a05:6402:34c1:b0:5d0:fcb9:1530 with SMTP id 4fb4d7f45d1cf-5d0fcb91ad7mr1824264a12.33.1733151889387;
        Mon, 02 Dec 2024 07:04:49 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097dd6902sm5061534a12.45.2024.12.02.07.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:04:48 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 070A3164E98D; Mon, 02 Dec 2024 16:04:48 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: Daniel Xu <dxu@dxuuu.xyz>, aleksander.lobakin@intel.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Lorenzo Bianconi
 <lorenzo@kernel.org>
Subject: Re: [PATCH bpf-next 3/3] bpf: cpumap: Add gro support
In-Reply-To: <20241130-cpumap-gro-v1-3-c1180b1b5758@kernel.org>
References: <20241130-cpumap-gro-v1-0-c1180b1b5758@kernel.org>
 <20241130-cpumap-gro-v1-3-c1180b1b5758@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 02 Dec 2024 16:04:48 +0100
Message-ID: <87o71ugm7j.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Introduce GRO support to cpumap codebase moving the cpu_map_entry
> kthread to a NAPI-kthread pinned on the selected cpu.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Pretty neat with such a straight-forward conversion. Just one nit:

[...]

> +	rcu_read_lock();
[...]
> +	rcu_read_unlock();

napi_threaded_poll_loop() already does local_bh_disable/enable() around
the polling function, so these are redundant :)

-Toke


