Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3742622331B
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 07:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgGQFwt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jul 2020 01:52:49 -0400
Received: from verein.lst.de ([213.95.11.211]:37196 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgGQFwt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jul 2020 01:52:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 33E7D68BEB; Fri, 17 Jul 2020 07:52:46 +0200 (CEST)
Date:   Fri, 17 Jul 2020 07:52:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: how is the bpfilter sockopt processing supposed to work
Message-ID: <20200717055245.GA9577@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alexei,

I've just been auditing the sockopt code, and bpfilter looks really
odd.  Both getsockopts and setsockopt eventually end up
in__bpfilter_process_sockopt, which then passes record to the
userspace helper containing the address of the optval buffer.
Which depending on bpf-cgroup might be in user or kernel space.
But even if it is in userspace it would be in a different process
than the bpfiler helper.  What makes all this work?
