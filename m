Return-Path: <bpf+bounces-15692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751247F4FBA
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 19:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E5B2814EB
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 18:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B954F616;
	Wed, 22 Nov 2023 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cIwzFy16"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1580BD62;
	Wed, 22 Nov 2023 10:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700678328; x=1732214328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ul/VlOLFxjw0gPyqOOK5SAIso094N0vzZ4lMdO5Dw78=;
  b=cIwzFy16POlKGv8wBBkPDjj0LwI1tdDvJQf5NW87lrqzKA4hty90vMEh
   r2lPhViBIMRKlxg9NmOcCzQV1grliRJ3ksihEd7XWseAIy6jbnRy/shEO
   /8ESk/iEKj9TH1z/IeqxKSartDwDJyCvoIl4200PbNO/OlsNoa22QpM70
   c=;
X-IronPort-AV: E=Sophos;i="6.04,219,1695686400"; 
   d="scan'208";a="686510836"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 18:38:38 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com (Postfix) with ESMTPS id 3DDB1C05DA;
	Wed, 22 Nov 2023 18:38:36 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:56960]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.99:2525] with esmtp (Farcaster)
 id 994699e5-52d1-483e-8854-9d77e40c84d2; Wed, 22 Nov 2023 18:38:35 +0000 (UTC)
X-Farcaster-Flow-ID: 994699e5-52d1-483e-8854-9d77e40c84d2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 22 Nov 2023 18:38:35 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 22 Nov 2023 18:38:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<haoluo@google.com>, <john.fastabend@gmail.com>, <jolsa@kernel.org>,
	<kpsingh@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <martin.lau@linux.dev>, <mykolal@fb.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@google.com>,
	<song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v3 bpf-next 02/11] tcp: Cache sock_net(sk) in cookie_v[46]_check().
Date: Wed, 22 Nov 2023 10:38:22 -0800
Message-ID: <20231122183822.3255-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iLmpfo-ihMpZwgCqcvF+bKdJ6is9q3Bks-sckmDz+5YHw@mail.gmail.com>
References: <CANn89iLmpfo-ihMpZwgCqcvF+bKdJ6is9q3Bks-sckmDz+5YHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Nov 2023 15:23:51 +0100
> On Tue, Nov 21, 2023 at 7:44 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > sock_net(sk) is used repeatedly in cookie_v[46]_check().
> > Let's cache it in a variable.
> >
> 
> What about splitting this series in two ?

That makes sense and would be easier to review/respin.
I'll post patch 1-8 to netdev first.


> 
> First one, doing refactoring/cleanups only could be sent without the
> RFC tag right away for review.
> ( Directly sent to netdev$ and TCP maintainers, no BPF change yet)
> 
> Then the second one with functional changes would follow, sent to bpf
> and TCP folks.
> 
> Thanks.

