Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3756C3EA0
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 00:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjCUXgT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 19:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjCUXgS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 19:36:18 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549BF567BF
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 16:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1679441767; x=1710977767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IfwNyzBPb2WkqgTfwWw6LgEczTh4zfj303p5dj9ehZo=;
  b=JJbFbNUwa9cUXS9Og9RL4G4HPy7U5GdHroc0PS9s5bHdu0hwBkLquUCi
   dMQC1Z87CtHSGV6n+CFrb8RK/MnMMJjS2ptoyeVEgvIbsbSiKkrXbENV4
   ogOfz0mnv/eVsImYc56OcS688MH/gDC733gruFZff+h3In0bOsRKuSB/Y
   s=;
X-IronPort-AV: E=Sophos;i="5.98,280,1673913600"; 
   d="scan'208";a="196023721"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 23:36:03 +0000
Received: from EX19MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com (Postfix) with ESMTPS id C3BE944A55;
        Tue, 21 Mar 2023 23:36:00 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 21 Mar 2023 23:35:56 +0000
Received: from 88665a182662.ant.amazon.com (10.94.217.231) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.24; Tue, 21 Mar 2023 23:35:54 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <daniel@iogearbox.net>
CC:     <bpf@vger.kernel.org>, <kuniyu@amazon.com>,
        <lefteris.alexakis@kpn.com>, <sh@synk.net>
Subject: Re: [stable] seccomp: Move copy_seccomp() to no failure path.
Date:   Tue, 21 Mar 2023 16:35:44 -0700
Message-ID: <20230321233544.25287-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2a09e672-5cc4-346d-2536-5efa5a59bae1@iogearbox.net>
References: <2a09e672-5cc4-346d-2536-5efa5a59bae1@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.94.217.231]
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From:   Daniel Borkmann <daniel@iogearbox.net>
Date:   Tue, 21 Mar 2023 23:26:09 +0100
> Hi Kuniyuki,
> 
> On 3/21/23 6:09 PM, Kuniyuki Iwashima wrote:
> [...]
> >> Link: https://github.com/awslabs/amazon-eks-ami/issues/1179
> >> Link: https://github.com/awslabs/amazon-eks-ami/issues/1219
> > 
> > I'm investigating these issues with EKS folks.  On the issue 1179, the
> > customer was using our 5.4 kernel, and on 1219, 5.10 kernel.
> > 
> > Then, I found my memleak fix commit a1140cb215fa ("seccomp: Move
> > copy_seccomp() to no failure path.") was not backported to upstream 5.10
> > stable trees.  We'll test if the issue can be reproduced with/without
> > the fix.
> 
> Good to know that 5.10 EKS kernel is based on top of stable one. It indeed
> looks like this could be happening there given a1140cb215fa is missing. I
> wonder given it has proper Fixes tag why it didn't made it into stable tree
> already. Thanks for checking, if it confirms, then lets ping Greg to cherry-
> pick.

The commit conflicted with 5.10, so it was missed, I guess.
I'll send a backporting patch for stable.

Thanks,
Kuniyuki
