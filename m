Return-Path: <bpf+bounces-3441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC1573E079
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 15:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD491C2084A
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 13:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35F7947F;
	Mon, 26 Jun 2023 13:20:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF39474
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 13:20:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A54F186
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 06:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687785622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p/Z1KtTHNDEz/UvhK/uC5AXS1uWtp7gEorowOqjT+2k=;
	b=HlqHyZSuLOfLUnj11cWrTO5hMEOmeHo+x2zxMniqQ2Ho4PDv37JSMuWoZ5SfZSvMXjhCA4
	7rJmheuMzLOGCZgtWATFuu1Mz3Wzb/6ZT1IH3Mnv7F0lkMqs43j4wao2nRPTezCnimJhzP
	MA2Xl23OCct+qVwAF9CTHrVDFPK/J6s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-CPSOP-6FMqeapgcO3dkupw-1; Mon, 26 Jun 2023 09:20:19 -0400
X-MC-Unique: CPSOP-6FMqeapgcO3dkupw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E48B2858EED;
	Mon, 26 Jun 2023 13:20:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3B361C478C6;
	Mon, 26 Jun 2023 13:20:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
cc: dhowells@redhat.com, Matthieu Baerts <matthieu.baerts@tessares.net>,
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
Subject: [PATCH net-next] tools: Fix MSG_SPLICE_PAGES build error in trace tools
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3065879.1687785614.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Jun 2023 14:20:14 +0100
Message-ID: <3065880.1687785614@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The following error is being seen the perf tools because they have their
own copies of a lot of kernel headers:

In file included from builtin-trace.c:907:
trace/beauty/msg_flags.c: In function 'syscall_arg__scnprintf_msg_flags':
trace/beauty/msg_flags.c:28:21: error: 'MSG_SPLICE_PAGES' undeclared (firs=
t use in this function)
   28 |         if (flags & MSG_##n) { \
      |                     ^~~~
trace/beauty/msg_flags.c:50:9: note: in expansion of macro 'P_MSG_FLAG'
   50 |         P_MSG_FLAG(SPLICE_PAGES);
      |         ^~~~~~~~~~
trace/beauty/msg_flags.c:28:21: note: each undeclared identifier is report=
ed only once for each function it appears in
   28 |         if (flags & MSG_##n) { \
      |                     ^~~~
trace/beauty/msg_flags.c:50:9: note: in expansion of macro 'P_MSG_FLAG'
   50 |         P_MSG_FLAG(SPLICE_PAGES);
      |         ^~~~~~~~~~

Fix this by (1) adding MSG_SPLICE_PAGES to
tools/perf/trace/beauty/include/linux/socket.h - which looks like it ought
to work, but doesn't, and (2) defining it conditionally in the file on
which the error occurs (suggested by Matthieu Baerts - this is also done
for some other flags).

Fixes: b848b26c6672 ("net: Kill MSG_SENDPAGE_NOTLAST")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/r/20230626112847.2ef3d422@canb.auug.org.au/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Arnaldo Carvalho de Melo <acme@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: bpf@vger.kernel.org
cc: dccp@vger.kernel.org
cc: linux-crypto@vger.kernel.org
cc: mptcp@lists.linux.dev
cc: netdev@vger.kernel.org
cc: tipc-discussion@lists.sourceforge.net
cc: virtualization@lists.linux-foundation.org
---
 include/linux/socket.h |    1 +
 msg_flags.c            |    3 +++
 2 files changed, 4 insertions(+)

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
diff --git a/tools/perf/trace/beauty/msg_flags.c b/tools/perf/trace/beauty=
/msg_flags.c
index 5cdebd7ece7e..aa9934020232 100644
--- a/tools/perf/trace/beauty/msg_flags.c
+++ b/tools/perf/trace/beauty/msg_flags.c
@@ -8,6 +8,9 @@
 #ifndef MSG_WAITFORONE
 #define MSG_WAITFORONE		   0x10000
 #endif
+#ifndef MSG_SPLICE_PAGES
+#define MSG_SPLICE_PAGES	0x8000000
+#endif
 #ifndef MSG_FASTOPEN
 #define MSG_FASTOPEN		0x20000000
 #endif


