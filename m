Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E093B0901
	for <lists+bpf@lfdr.de>; Tue, 22 Jun 2021 17:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhFVPaa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Jun 2021 11:30:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:59820 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232300AbhFVPaW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Jun 2021 11:30:22 -0400
IronPort-SDR: yEXnMxGlnJ+mjduxsM/V/jlGpbGt2aY5kTE2XoRvajC6ToqMP7GDLoU75yC79COGVVW3u4RE4M
 GgjtCOjsGPHw==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="207118740"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="207118740"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 08:28:05 -0700
IronPort-SDR: 0iqapwYpeD60iNtSqfzgQoep8q9psdQMahxgU4E479lILA+8aa6x66dVioxMyF0ZsC8kdIhiuq
 dLzZqmRDjP6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="452654802"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga008.jf.intel.com with ESMTP; 22 Jun 2021 08:28:01 -0700
Received: from alobakin-mobl.ger.corp.intel.com (klisowsk-mobl1.ger.corp.intel.com [10.213.19.83])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 15MFRx63015038;
        Tue, 22 Jun 2021 16:27:59 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     xdp-hints@xdp-project.net
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Marcin Kubiak <marcin.kubiak@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@intel.com>,
        Piotr Raczynski <piotr.raczynski@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        bpf@vger.kernel.org
Subject: Fw: [Netdev 0x15] Submission #5 "XDP Hints / hardware offloads..."
Date:   Tue, 22 Jun 2021 17:27:43 +0200
Message-Id: <20210622152743.102-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi folks,

I got this email from Netdev 0x15 today:

From: submissions-0x15@netdevconf.info
Date: Tue, 22 Jun 2021 12:24:47 +0000

> Dear Alexander Lobakin,
>
> In regards to your submission:
>
>        Title: XDP Hints / hardware offloads interaction
>         Site: https://0x15.netdevconf.info/paper/5
>
> We need to incorporate this topic into a wider XDP workshop
> with multiple topics.
> We need one or two people to chair the general XDP workshop.
> Please find a co-chair or if you need our help we can
> coordinate finding you a co-chair. Also, if you feel you
> can handle being the chair of the larger XDP workshop on your
> own do let us know.
>
> Thanks!

So instead of XDP Hints dedicated workshop a global one will
take place.
Is anyone willing to take a (co-)chair? I bet many of you have
a knowledge of eBPF/XDP stuff wider than mine.
Just PM me or drop a line here in Lists.

Thanks,
Al
