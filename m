Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2169D3C92EE
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 23:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhGNVUC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 17:20:02 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:54160 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhGNVUC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Jul 2021 17:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1626297431; x=1657833431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z+1n98LeYJ8ni9/CvCo+iySlbmFcMHGdo5yW6ZgeUGs=;
  b=ok4LRylT+pi234kiPlEFUlJYgu6KE7gSLAlTXMxQlXkaOtHVzWVILaUQ
   L8X77ZUQW0kZ0ECLzdouSbox+nxe5K3NZl24MN5sZcDY5jiYlnhbmhtFZ
   0k2RMy22a1+xoffVN856O+gWs9IKjgqdYTR5G/sHEUYz9fjrxi0h6eLUO
   8=;
X-IronPort-AV: E=Sophos;i="5.84,240,1620691200"; 
   d="scan'208";a="120999300"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-4101.iad4.amazon.com with ESMTP; 14 Jul 2021 21:14:50 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id AB90CA28D3;
        Wed, 14 Jul 2021 21:14:49 +0000 (UTC)
Received: from EX13D04ANC001.ant.amazon.com (10.43.157.89) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Wed, 14 Jul 2021 21:14:49 +0000
Received: from 88665a182662.ant.amazon.com.com (10.43.162.164) by
 EX13D04ANC001.ant.amazon.com (10.43.157.89) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Wed, 14 Jul 2021 21:14:45 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.co.jp>
To:     <kafai@fb.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <kuni1840@gmail.com>, <kuniyu@amazon.co.jp>
Subject: Re: [PATCH] bpf: Fix a typo of reuseport map in bpf.h.
Date:   Thu, 15 Jul 2021 06:14:41 +0900
Message-ID: <20210714211441.16251-1-kuniyu@amazon.co.jp>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210714174013.oksmjoc5l5bq4b5o@kafai-mbp.dhcp.thefacebook.com>
References: <20210714174013.oksmjoc5l5bq4b5o@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.162.164]
X-ClientProxiedBy: EX13D14UWB001.ant.amazon.com (10.43.161.158) To
 EX13D04ANC001.ant.amazon.com (10.43.157.89)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From:   Martin KaFai Lau <kafai@fb.com>
Date:   Wed, 14 Jul 2021 10:40:13 -0700
> On Wed, Jul 14, 2021 at 09:43:17PM +0900, Kuniyuki Iwashima wrote:
> > Fix s/BPF_MAP_TYPE_REUSEPORT_ARRAY/BPF_MAP_TYPE_REUSEPORT_SOCKARRAY/ typo
> > in bpf.h.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
> It could be bpf-next.

Yes, and sorry for forgetting adding it in the subject.


> 
> Fixes: 2dbb9b9e6df6 ("bpf: Introduce BPF_PROG_TYPE_SK_REUSEPORT")
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Thank you.
