Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D413318C55C
	for <lists+bpf@lfdr.de>; Fri, 20 Mar 2020 03:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgCTCii (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Mar 2020 22:38:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12104 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbgCTCih (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Mar 2020 22:38:37 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A4D4C318BC775374E515;
        Fri, 20 Mar 2020 10:38:33 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 20 Mar 2020
 10:38:27 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lmb@cloudflare.com>, <daniel@iogearbox.net>,
        <jakub@cloudflare.com>, <john.fastabend@gmail.com>
CC:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrii.nakryiko@gmail.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH bpf-next 0/2] minor cleanups
Date:   Fri, 20 Mar 2020 10:34:24 +0800
Message-ID: <20200320023426.60684-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20200319124631.58432-1-yuehaibing@huawei.com>
References: <20200319124631.58432-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Minor cleanups for tcp_bpf.c

YueHaibing (2):
  bpf: tcp: Fix unused function warnings
  bpf: tcp: Make tcp_bpf_recvmsg static

 include/net/tcp.h  |   2 -
 net/ipv4/tcp_bpf.c | 152 ++++++++++++++++++++++-----------------------
 2 files changed, 76 insertions(+), 78 deletions(-)

-- 
2.17.1


