Return-Path: <bpf+bounces-11819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C3F7C0269
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 19:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75EC9281F57
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 17:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1B918C31;
	Tue, 10 Oct 2023 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CcI1kjqk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324E92FE01;
	Tue, 10 Oct 2023 17:18:24 +0000 (UTC)
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AF394;
	Tue, 10 Oct 2023 10:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696958303; x=1728494303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6tEKY9o/6c0wiT1/4/0rQ2JeZqiNi8iBbE1ygCZ4L7Y=;
  b=CcI1kjqkpdoBzDADqCcW+avlLXwJK7PipLlvVbMjn3SU4MlBnvPOTwXc
   ymgtR6yx23tqB578i3j6WWu6wj77e2qG05v0aYQvh48LDOeE7Ljk+/5ch
   aaDK67HSgxTrURWAIGTRlsJHMnZFlTL4xYxz0wvf5XwPuSA0cZ66Wx2xG
   8=;
X-IronPort-AV: E=Sophos;i="6.03,213,1694736000"; 
   d="scan'208";a="368977892"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 17:18:17 +0000
Received: from EX19MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
	by email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com (Postfix) with ESMTPS id EDA044867D;
	Tue, 10 Oct 2023 17:18:15 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 17:18:13 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 17:18:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <daan.j.demeyer@gmail.com>
CC: <bpf@vger.kernel.org>, <kernel-team@meta.com>, <martin.lau@linux.dev>,
	<netdev@vger.kernel.org>, <kuniyu@amazon.com>
Subject: Re: [PATCH bpf-next v9 4/9] bpf: Implement cgroup sockaddr hooks for unix sockets
Date: Tue, 10 Oct 2023 10:17:52 -0700
Message-ID: <20231010171752.7580-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231006074530.892825-5-daan.j.demeyer@gmail.com>
References: <20231006074530.892825-5-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.11]
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Fri,  6 Oct 2023 09:44:58 +0200
> These hooks allows intercepting connect(), getsockname(),
> getpeername(), sendmsg() and recvmsg() for unix sockets. The unix
> socket hooks get write access to the address length because the
> address length is not fixed when dealing with unix sockets and
> needs to be modified when a unix socket address is modified by
> the hook. Because abstract socket unix addresses start with a
> NUL byte, we cannot recalculate the socket address in kernelspace
> after running the hook by calculating the length of the unix socket
> path using strlen().
> 
> These hooks can be used when users want to multiplex syscall to a
> single unix socket to multiple different processes behind the scenes
> by redirecting the connect() and other syscalls to process specific
> sockets.
> 
> We do not implement support for intercepting bind() because when
> using bind() with unix sockets with a pathname address, this creates
> an inode in the filesystem which must be cleaned up. If we rewrite
> the address, the user might try to clean up the wrong file, leaking
> the socket in the filesystem where it is never cleaned up. Until we
> figure out a solution for this (and a use case for intercepting bind()),
> we opt to not allow rewriting the sockaddr in bind() calls.
> 
> We also implement recvmsg() support for connected streams so that
> after a connect() that is modified by a sockaddr hook, any corresponding
> recmvsg() on the connected socket can also be modified to make the
> connected program think it is connected to the "intended" remote.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

