Return-Path: <bpf+bounces-16694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABF3804566
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 04:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8A61C209C5
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 03:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0517D6AA0;
	Tue,  5 Dec 2023 03:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GIIo97CD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81D7CD;
	Mon,  4 Dec 2023 19:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701745275; x=1733281275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=edD6I/2cJPvUq46ZoGJHjc6YdQlKiXMFui8V5tcUIfc=;
  b=GIIo97CD1kEbmLgG9a95WqzYAPLaMZyhUwe/lbOMFjppnc3Mf0E60+cU
   3jcVWpbjPFt+NWbJhQEU5WMAnQH1eY3zU/gQeV2rmfdmgMG12QFrX1Uih
   8mo9+jhdl+AYG994PFKgVw7GuEW5r8bxRdXJ3Ymj1q0h2KqBoPnsOQai4
   g=;
X-IronPort-AV: E=Sophos;i="6.04,251,1695686400"; 
   d="scan'208";a="169982829"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 03:01:13 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com (Postfix) with ESMTPS id 7FEE4807EE;
	Tue,  5 Dec 2023 03:01:11 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:44108]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.133:2525] with esmtp (Farcaster)
 id 9fd950d9-b1a3-4d34-a170-bdecb523e67d; Tue, 5 Dec 2023 03:01:10 +0000 (UTC)
X-Farcaster-Flow-ID: 9fd950d9-b1a3-4d34-a170-bdecb523e67d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 5 Dec 2023 03:01:09 +0000
Received: from 88665a182662.ant.amazon.com (10.119.0.105) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Dec 2023 03:01:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <alexei.starovoitov@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <edumazet@google.com>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <martin.lau@linux.dev>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 bpf-next 3/3] selftest: bpf: Test bpf_sk_assign_tcp_reqsk().
Date: Tue, 5 Dec 2023 12:00:56 +0900
Message-ID: <20231205030056.96419-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAADnVQKY74ynj8PB62Wf4xgDN6sC=VawQwy5V3YbRx-2tbcwNw@mail.gmail.com>
References: <CAADnVQKY74ynj8PB62Wf4xgDN6sC=VawQwy5V3YbRx-2tbcwNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Dec 2023 18:13:55 -0800
> On Mon, Dec 4, 2023 at 5:36 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > +static __always_inline int tcp_load_headers(struct tcp_syncookie *ctx)
> 
> ...
> 
> > +static __always_inline int tcp_reload_headers(struct tcp_syncookie *ctx)
> 
> please remove __always_inline here and in all other places.
> The generated code will be much better == faster and the verifier
> should be able to understand it.

I confirmed the test worked without __always_inline.
I'll fix it in v5.

Thanks!

