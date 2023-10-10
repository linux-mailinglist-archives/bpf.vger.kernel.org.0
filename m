Return-Path: <bpf+bounces-11836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5367C410A
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 22:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30931C20E46
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 20:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCFF31581;
	Tue, 10 Oct 2023 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="C491yruG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641F12745F;
	Tue, 10 Oct 2023 20:20:48 +0000 (UTC)
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BDEB8;
	Tue, 10 Oct 2023 13:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696969247; x=1728505247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o4u11zrx7eA11CZzeyTu4a0TO7Mfy7hjPMsW7SqOWgU=;
  b=C491yruGHLAoAl9Wa6Tqk+xpDVAX0NgDZzvvk38aYKGrxO+8YhafPGBz
   3iDe3r8mIS5oGHiN8SjlK6NZd+cb+2TzFOS14WiIp2lzELrfFd5HXKW4i
   qsakhXG/JBYVLNU0QfKQ6f/vXC7gYCCoaSM1gQVehKYKHroN9BYA8EkXO
   E=;
X-IronPort-AV: E=Sophos;i="6.03,213,1694736000"; 
   d="scan'208";a="363425396"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 20:20:43 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com (Postfix) with ESMTPS id 2FC9B80760;
	Tue, 10 Oct 2023 20:20:42 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 20:20:40 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 20:20:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <bpf@vger.kernel.org>, <daan.j.demeyer@gmail.com>, <kernel-team@meta.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v9 3/9] bpf: Add bpf_sock_addr_set_unix_addr() to allow writing unix sockaddr from bpf
Date: Tue, 10 Oct 2023 13:20:30 -0700
Message-ID: <20231010202030.32676-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <bdffefed-8945-e5ac-052d-0f0b49a30d39@linux.dev>
References: <bdffefed-8945-e5ac-052d-0f0b49a30d39@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.11]
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Tue, 10 Oct 2023 13:07:54 -0700
> On 10/10/23 10:00 AM, Kuniyuki Iwashima wrote:
> >> +__bpf_kfunc int bpf_sock_addr_set_unix_addr(struct bpf_sock_addr_kern *sa_kern,
> >> +					    const u8 *addr, u32 addrlen__sz)
> > I'd rename addrlen__sz to sun_path_len or something else because the
> > conventional addrlen for AF_UNIX contains offsetof(struct sockaddr_un,
> > sun_path).
> 
> The "__sz" suffix is required by the verifier. It is the size of the preceding 
> argument "addr". While at it, addrlen__sz should be just "addr__sz" (or 
> sun_path__sz, depending on what name is decided here) for consistency with other 
> kfunc.

I didn't know that, thank you!


> 
> I don't have strong preference on the argument name. However, if it is 
> sun_path__sz, then the preceding argument should be renamed to "sun_path" also 
> for consistency reason and then the kfunc should probably be renamed to 
> bpf_sock_addr_set_sun_path.

I prefer sun_path, sun_path__sz, and bpf_sock_addr_set_sun_path() that are
clearer and consistent with uAPI, sockaddr_un.sun_path.

