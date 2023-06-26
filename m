Return-Path: <bpf+bounces-3444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D0D73E10E
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 15:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFAAE280DFC
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 13:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C72A944;
	Mon, 26 Jun 2023 13:51:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53408F6A
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 13:51:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AF0E7B
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 06:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687787496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tK/iiYQUluNE0Uml8JHqAJ8sgWk+hiwneX6EQmjmmc8=;
	b=KhwLN96IzUWBH1915+m5/Q6A3v/FsWAD9/qM2qtTbhSd4mNv/PQ6mefYSfkKStSFaN2pOl
	DfUBHyLcJaeY3S2g3Xd0BSnNlzt8GEDWOTD+i62glC8FxQlt/v9EaAbzxX8W5CpDI2XA+B
	GBiLjz8y+SagVqBwdTndD/I6e2jaBeg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-wGqdrhGLPYGKkT2K6gg_og-1; Mon, 26 Jun 2023 09:51:32 -0400
X-MC-Unique: wGqdrhGLPYGKkT2K6gg_og-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E171429AB41D;
	Mon, 26 Jun 2023 13:50:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5984240C2070;
	Mon, 26 Jun 2023 13:50:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <5791ec06-7174-9ae5-4fe4-6969ed110165@tessares.net>
References: <5791ec06-7174-9ae5-4fe4-6969ed110165@tessares.net> <3065880.1687785614@warthog.procyon.org.uk>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Arnaldo Carvalho de Melo <acme@redhat.com>,
    David Miller <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
    Matthew Wilcox <willy@infradead.org>,
    Peter Zijlstra <peterz@infradead.org>,
    Ingo Molnar <mingo@redhat.com>,
    Arnaldo Carvalho de Melo <acme@kernel.org>,
    Mark Rutland <mark.rutland@arm.com>,
    Alexander Shishkin <alexander.shishkin@linux.intel.com>,
    Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
    Ian Rogers <irogers@google.com>,
    Adrian Hunter <adrian.hunter@intel.com>,
    linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
    linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tools: Fix MSG_SPLICE_PAGES build error in trace tools
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3067875.1687787456.1@warthog.procyon.org.uk>
Date: Mon, 26 Jun 2023 14:50:56 +0100
Message-ID: <3067876.1687787456@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Matthieu Baerts <matthieu.baerts@tessares.net> wrote:

> So another issue. When checking the differences between the two files, I
> see there are still also other modifications to import, e.g. it looks
> like you also added MSG_INTERNAL_SENDMSG_FLAGS macro in socket.h. Do you
> plan to fix that too?

That's just a list of other flags that we need to prevent userspace passing
in - it's not a flag in its own right.

David


