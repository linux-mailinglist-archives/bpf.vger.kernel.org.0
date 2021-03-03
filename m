Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0401732C1BF
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449582AbhCCWwn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 3 Mar 2021 17:52:43 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:35460 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243100AbhCCRoY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Mar 2021 12:44:24 -0500
X-IronPort-AV: E=Sophos;i="5.81,220,1610406000"; 
   d="scan'208";a="495963565"
Received: from lfbn-idf1-1-708-183.w86-245.abo.wanadoo.fr (HELO mp-66156.home) ([86.245.159.183])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 18:39:15 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: XDP socket rings, and LKMM litmus tests
From:   maranget <luc.maranget@inria.fr>
In-Reply-To: <29736B0B-9960-473C-85BB-5714F181198B@inria.fr>
Date:   Wed, 3 Mar 2021 18:39:14 +0100
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        parri.andrea@gmail.com, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        =?utf-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <F6EF0AE0-F0AA-4158-988B-C2638738B054@inria.fr>
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
 <20210302211446.GA1541641@rowland.harvard.edu>
 <20210302235019.GT2696@paulmck-ThinkPad-P72>
 <20210303171221.GA1574518@rowland.harvard.edu>
 <29736B0B-9960-473C-85BB-5714F181198B@inria.fr>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On 3 Mar 2021, at 18:37, maranget <luc.maranget@inria.fr> wrote:
> 
> I have made a PR to herd7 that performs the change. The commit message states the new definition.

For those who are interested
<https://github.com/herd/herdtools7/pull/183>

—Luc

