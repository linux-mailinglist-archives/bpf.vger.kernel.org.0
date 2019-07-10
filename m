Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C298263F3F
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2019 04:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfGJCVw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Jul 2019 22:21:52 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34079 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfGJCVv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Jul 2019 22:21:51 -0400
Received: by mail-qk1-f194.google.com with SMTP id t8so754069qkt.1
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2019 19:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=unvZDjN9kre6psmsB+/DO8sq0hzYLAmdGDNLpsXbVH0=;
        b=E5gpuJLjFkfovVsP6Ax5iGhesnoLJeEcchd7fuqXH1PfcxfYiTcpgLeb3nVB9kWDGe
         0QN8/CNulZ9xbze4R10L11mIAZM5cqwkpsLcHi2800RvQ4TWRDMAXibRXVR4NaX/yAiP
         IxaFn8AiOYrJvyvtQz9Iqtq1PygO9ZWq1LWucpratJUCkdw5+fhccWls3nd0xEkWRWQ5
         NWOmaSElulZQ17RbioHSICoIKK+n6uT2M15TatxDsFV1FOxOwV6z46T3rWVlnALXHwMN
         Hip7yWXmg7T4ycaKQPo+mG3Cl7l208x9raO4ujB7zTb+hfAVU91ll9p78Q98K839eM0R
         qnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=unvZDjN9kre6psmsB+/DO8sq0hzYLAmdGDNLpsXbVH0=;
        b=q2kQlTjP5LuvMQ8B4lURvr46UEACx4RgaS2u7+KyCi7y3flH8m8MCc3g0Qe1c8UU1/
         d8I2E/9MWvHctOeJvXMzjKpnzDw9MW7ih6raKbCcuHITrjKjLgfmqCACoGngA62jV/Q+
         fU66cZlHvrX7aupcAiWhit+ZjR7Da5IpCmYPytGs0uSxKBI5wA/sGT1jX20Re0fJuBFg
         2FWySLNlTbRLulSHGnZnwLAdTqx/sJhAqc2gXDzoHTvIvNqtUVBaCw4rQiaYK/DDGx9N
         5Cl/HNLLgzPdsfy5stEvriBRIcWokGRZwmC87+Buk+z1WpqQWhrj0n34NyTlTZJYkaUt
         SHDg==
X-Gm-Message-State: APjAAAXDOhdv/VWFv55qR2tJA5PmlR5WF3MHnlH93cwHEeSK9qbFHaQz
        12Hhgwsa+iOvKRuuA4Jo+IPExw==
X-Google-Smtp-Source: APXvYqxCjy5HfKU5iLOE3RPYTY9mZicl5S0/RRVQ5hl4qopBDJc2zNqZ93acRVRcnkU/jmx97KBoeA==
X-Received: by 2002:a37:a94:: with SMTP id 142mr19619112qkk.89.1562725310958;
        Tue, 09 Jul 2019 19:21:50 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id r189sm445843qkc.60.2019.07.09.19.21.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 19:21:50 -0700 (PDT)
Date:   Tue, 9 Jul 2019 19:21:45 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        edumazet@google.com, bpf@vger.kernel.org
Subject: Re: [bpf PATCH v2 0/6] bpf: sockmap/tls fixes
Message-ID: <20190709192145.473d2d80@cakuba.netronome.com>
In-Reply-To: <20190709170459.387bced6@cakuba.netronome.com>
References: <156261310104.31108.4569969631798277807.stgit@ubuntu3-kvm1>
        <20190708231318.1a721ce8@cakuba.netronome.com>
        <5d24b55e8b868_3b162ae67af425b43e@john-XPS-13-9370.notmuch>
        <20190709170459.387bced6@cakuba.netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 9 Jul 2019 17:04:59 -0700, Jakub Kicinski wrote:
> On Tue, 09 Jul 2019 08:40:14 -0700, John Fastabend wrote:
> > Jakub Kicinski wrote:  
> > > Looks like strparser is not done'd for offload?    
> > 
> > Right so if rx_conf != TLS_SW then the hardware needs to do
> > the strparser functionality.  
> 
> Can I just take a stab at fixing the HW part?
> 
> Can I rebase this onto net-next?  There are a few patches from net
> missing in the bpf tree.

I think I fixed patch 1 for offload, I need to test it a little more
and I'll send it back to you. In the meantime, let me ask some
questions about the other two :)
