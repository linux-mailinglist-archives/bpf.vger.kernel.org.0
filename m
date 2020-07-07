Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADC421695D
	for <lists+bpf@lfdr.de>; Tue,  7 Jul 2020 11:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgGGJoa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jul 2020 05:44:30 -0400
Received: from mail.katalix.com ([3.9.82.81]:39228 "EHLO mail.katalix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgGGJo3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jul 2020 05:44:29 -0400
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jul 2020 05:44:29 EDT
Received: from localhost (unknown [IPv6:2a02:8010:6359:1:21b:21ff:fe6a:7e96])
        (Authenticated sender: james)
        by mail.katalix.com (Postfix) with ESMTPSA id AF05F7D334;
        Tue,  7 Jul 2020 10:37:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=katalix.com; s=mail;
        t=1594114650; bh=rWMVo3n+VG2d9mXJTl8i+XGMu0AM2A68PuT38oOAmw4=;
        h=Date:From:To:Cc:Subject:From;
        b=sk1Y8/mpvFLR270+sBLuRO6bNJX1fsmCSyZ6zpqNLeXCOpLDHBreMUTrDKgzAkcbn
         G+Jq8SbSR5dgSgw6A3lIHRyV790DSCG30Q0sxqe9KtjKeIETs6vbaZ+7jmQ29V3XHr
         cTxPK4RDbgep8wvb9DrnmXRVy1Uev8Gr3njCdXHBcLQrnOmnP0tnUwo1tmbHY45pGI
         v6GP6MKZ9DSyxV3HEqxdOeaz2ksnkakH6NWIJCtqNMJlN/53SJ8gcoNm8LHNR7o+xs
         oX7I3OFFMLxce1IRGjJHskSF8K+QM0Tvb8XQyehusTBiq5e6Bb7zkH7KZ/QQ4LzlNc
         85iUkWq9vImNA==
Date:   Tue, 7 Jul 2020 10:37:30 +0100
From:   James Chapman <jchapman@katalix.com>
To:     bpf@vger.kernel.org, kafai@fb.com
Cc:     netdev@vger.kernel.org
Subject: bpf's usage of sk_user_data
Message-ID: <20200707093730.GC21324@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm investigating a crash found by syzbot which turns out to be caused
by bpf_sk_reuseport_detach assuming ownership of sk_user_data in the
UDP socket destroy path and corrupts metadata of a UDP socket user (l2tp).

Here's the syzbot report:
https://syzkaller.appspot.com/bug?extid=9f092552ba9a5efca5df

I submitted a patch to l2tp to workaround this by having l2tp refuse
to use a UDP socket with SO_REUSEPORT set. But this isn't the right
fix. Can BPF be changed to store its metadata elsewhere such that
other socket users which use sk_user_data can co-exist with BPF?

The email thread discussing this is at:
https://lore.kernel.org/netdev/20200706.124536.774178117550894539.davem@davemloft.net/

