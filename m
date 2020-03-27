Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09B1A195C7F
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 18:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgC0RW1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 13:22:27 -0400
Received: from correo.us.es ([193.147.175.20]:37190 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbgC0RW1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 13:22:27 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B16591228C0
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 18:22:25 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A38D5FC5EF
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 18:22:25 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9892FFC5E9; Fri, 27 Mar 2020 18:22:25 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CBD24DA736;
        Fri, 27 Mar 2020 18:22:23 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 27 Mar 2020 18:22:23 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id A2EFD42EE395;
        Fri, 27 Mar 2020 18:22:23 +0100 (CET)
Date:   Fri, 27 Mar 2020 18:22:23 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:NETFILTER" <netfilter-devel@vger.kernel.org>,
        "open list:NETFILTER" <coreteam@netfilter.org>
Subject: Re: [PATCH 4/8] netfilter: Add missing annotation for
 ctnetlink_parse_nat_setup()
Message-ID: <20200327172223.4bsns76lkjumwn3q@salvia>
References: <0/8>
 <20200311010908.42366-1-jbi.octave@gmail.com>
 <20200311010908.42366-5-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311010908.42366-5-jbi.octave@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 11, 2020 at 01:09:04AM +0000, Jules Irenge wrote:
> Sparse reports a warning at ctnetlink_parse_nat_setup()
> 
> warning: context imbalance in ctnetlink_parse_nat_setup()
> 	- unexpected unlock
> 
> The root cause is the missing annotation at ctnetlink_parse_nat_setup()
> Add the missing __must_hold(RCU) annotation

Applied, thanks.
