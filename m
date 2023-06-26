Return-Path: <bpf+bounces-3420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3C073D8CA
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 09:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8AA8280D12
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 07:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441F24A14;
	Mon, 26 Jun 2023 07:48:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C1546A0
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 07:48:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5554BE42
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 00:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687765715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ocXyG+slkr0gL4aywexn0lNOfJV4nZ/IWmE7AdPVwQ0=;
	b=b9DuhgmB/4Fo/y4Eqa+nI5wRiT2LF+NvovDOpX9w7MuC62TYOnx/HwR+CHB7H54T1SN5Ds
	xPtcNoxgeZEZTf/uXYn6HINU0/AEjKVxOAAUGcMzNZeq30aLfhkfutHYgbN+bl/UTthxLF
	rVSVRP+8wD/BEXsV/gcC7r1WGwHo6zk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-LZEMRXVMNku8ZOzuiFUVAA-1; Mon, 26 Jun 2023 03:48:30 -0400
X-MC-Unique: LZEMRXVMNku8ZOzuiFUVAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FBDE29A9D2A;
	Mon, 26 Jun 2023 07:48:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 173F640C6CD1;
	Mon, 26 Jun 2023 07:48:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20230626112847.2ef3d422@canb.auug.org.au>
References: <20230626112847.2ef3d422@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: dhowells@redhat.com, Peter Zijlstra <peterz@infradead.org>,
    Ingo Molnar <mingo@redhat.com>,
    Arnaldo Carvalho de Melo <acme@kernel.org>,
    Mark Rutland <mark.rutland@arm.com>,
    Alexander Shishkin <alexander.shishkin@linux.intel.com>,
    Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
    Ian Rogers <irogers@google.com>,
    Adrian Hunter <adrian.hunter@intel.com>,
    David Miller <davem@davemloft.net>,
    Networking <netdev@vger.kernel.org>,
    Jakub Kicinski <kuba@kernel.org>, linux-perf-users@vger.kernel.org,
    bpf@vger.kernel.org, linux-next@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the net-next tree
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2947428.1687765706.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Jun 2023 08:48:26 +0100
Message-ID: <2947430.1687765706@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> After merging the net-next tree, today's linux-next build (native perf)
> failed like this:
> =

> In file included from builtin-trace.c:907:
> trace/beauty/msg_flags.c: In function 'syscall_arg__scnprintf_msg_flags'=
:
> trace/beauty/msg_flags.c:28:21: error: 'MSG_SPLICE_PAGES' undeclared (fi=
rst use in this function)

I tried applying the attached patch, but it doesn't make any difference.

Any idea what I've missed?  Also, why do we have duplicates of all the ker=
nel
headers in the tools/ directory?

David
---

commit 878ff45f5f746f6773224ff952c490b5812462f2
Author: David Howells <dhowells@redhat.com>
Date:   Mon Jun 26 08:08:12 2023 +0100

    tools: Fix MSG_SPLICE_PAGES build error in trace tools
    =

    Fix the following error:
    =

    In file included from builtin-trace.c:907:
    trace/beauty/msg_flags.c: In function 'syscall_arg__scnprintf_msg_flag=
s':
    trace/beauty/msg_flags.c:28:21: error: 'MSG_SPLICE_PAGES' undeclared (=
first use in this function)
       28 |         if (flags & MSG_##n) { \
          |                     ^~~~
    trace/beauty/msg_flags.c:50:9: note: in expansion of macro 'P_MSG_FLAG=
'
       50 |         P_MSG_FLAG(SPLICE_PAGES);
          |         ^~~~~~~~~~
    trace/beauty/msg_flags.c:28:21: note: each undeclared identifier is re=
ported only once for each function it appears in
       28 |         if (flags & MSG_##n) { \
          |                     ^~~~
    trace/beauty/msg_flags.c:50:9: note: in expansion of macro 'P_MSG_FLAG=
'
       50 |         P_MSG_FLAG(SPLICE_PAGES);
          |         ^~~~~~~~~~
    =

    There is no MSG_SPLICE_PAGES in tools/perf/trace/beauty/include/linux/=
socket.h
    =

    Fixes: b848b26c6672 ("net: Kill MSG_SENDPAGE_NOTLAST")
    Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Link: https://lore.kernel.org/r/20230626112847.2ef3d422@canb.auug.org.=
au/
    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: "David S. Miller" <davem@davemloft.net>
    cc: Eric Dumazet <edumazet@google.com>
    cc: Jakub Kicinski <kuba@kernel.org>
    cc: Paolo Abeni <pabeni@redhat.com>
    cc: Jens Axboe <axboe@kernel.dk>
    cc: Matthew Wilcox <willy@infradead.org>
    cc: bpf@vger.kernel.org
    cc: dccp@vger.kernel.org
    cc: linux-afs@lists.infradead.org
    cc: linux-arm-msm@vger.kernel.org
    cc: linux-can@vger.kernel.org
    cc: linux-crypto@vger.kernel.org
    cc: linux-doc@vger.kernel.org
    cc: linux-hams@vger.kernel.org
    cc: linux-perf-users@vger.kernel.org
    cc: linux-rdma@vger.kernel.org
    cc: linux-sctp@vger.kernel.org
    cc: linux-wpan@vger.kernel.org
    cc: linux-x25@vger.kernel.org
    cc: mptcp@lists.linux.dev
    cc: netdev@vger.kernel.org
    cc: rds-devel@oss.oracle.com
    cc: tipc-discussion@lists.sourceforge.net
    cc: virtualization@lists.linux-foundation.org

diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/t=
race/beauty/include/linux/socket.h
index 3bef212a24d7..77cb707a566a 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -326,6 +326,7 @@ struct ucred {
 					  */
 =

 #define MSG_ZEROCOPY	0x4000000	/* Use user data in kernel path */
+#define MSG_SPLICE_PAGES 0x8000000	/* Splice the pages from the iterator =
in sendmsg() */
 #define MSG_FASTOPEN	0x20000000	/* Send data in TCP SYN */
 #define MSG_CMSG_CLOEXEC 0x40000000	/* Set close_on_exec for file
 					   descriptor received through


