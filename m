Return-Path: <bpf+bounces-11958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311AA7C5D44
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 20:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619401C20C94
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 18:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DFC12E4C;
	Wed, 11 Oct 2023 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="i5WZan49"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A46F12E48;
	Wed, 11 Oct 2023 18:58:34 +0000 (UTC)
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2183EA9;
	Wed, 11 Oct 2023 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697050712; x=1728586712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OBLtXvYkpP2dJlnKnj5QT1SIsIZu7BoIndfSENwTaQQ=;
  b=i5WZan49iy9adl310SOgYafn8nnG30LlLK8T0RZMktEeA779c6SGNx1x
   YFR98XRdd1BtbqtwYsy5QxjRVQPklSYl6AGcBkJ+vV4qroSIpcfZx8gby
   Rrg5ADzOZma+N+czp18NOg5GkuFfvWhk4nddstl6Dgd7LEEvtnOBPKin+
   4=;
X-IronPort-AV: E=Sophos;i="6.03,216,1694736000"; 
   d="scan'208";a="677811921"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 18:58:25 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com (Postfix) with ESMTPS id C00FDA0509;
	Wed, 11 Oct 2023 18:58:24 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 11 Oct 2023 18:58:24 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.37;
 Wed, 11 Oct 2023 18:58:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <daan.j.demeyer@gmail.com>
CC: <bpf@vger.kernel.org>, <kernel-team@meta.com>, <kuniyu@amazon.com>,
	<martin.lau@linux.dev>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v10 2/9] bpf: Propagate modified uaddrlen from cgroup sockaddr programs
Date: Wed, 11 Oct 2023 11:58:14 -0700
Message-ID: <20231011185814.53217-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAO8sHc=FfDo_LnpV_tF5aPF4BjpWkQk2jLxLWH50X0JzSQ+s6Q@mail.gmail.com>
References: <CAO8sHc=FfDo_LnpV_tF5aPF4BjpWkQk2jLxLWH50X0JzSQ+s6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.62]
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Wed, 11 Oct 2023 20:37:49 +0200
> > > @@ -1483,11 +1488,18 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
> > >       if (!ctx.uaddr) {
> > >               memset(&unspec, 0, sizeof(unspec));
> > >               ctx.uaddr = (struct sockaddr *)&unspec;
> > > -     }
> > > +             ctx.uaddrlen = 0;
> > > +     } else
> > > +             ctx.uaddrlen = *uaddrlen;
> > >
> > >       cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
> > > -     return bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> > > -                                  0, flags);
> > > +     ret = bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> > > +                                 0, flags);
> > > +
> > > +     if (!ret && uaddrlen)
> >
> > nit: no need to check uaddrlen here or maybe check ctx.uaddrlen.
> 
> Are you sure? uaddrlen can still be NULL if uaddr is also NULL

How?  In the patch 2 and 4, it seems uaddrlen always points to an
actual variable.

