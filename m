Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F33257F8
	for <lists+bpf@lfdr.de>; Tue, 21 May 2019 21:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfEUTCb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 May 2019 15:02:31 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:37578 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727990AbfEUTCb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 May 2019 15:02:31 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us4.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id B468FBC0072;
        Tue, 21 May 2019 19:02:29 +0000 (UTC)
Received: from [10.17.20.203] (10.17.20.203) by ocex03.SolarFlarecom.com
 (10.20.40.36) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 21 May
 2019 12:02:25 -0700
Subject: Re: [PATCH 0/9] eBPF support for GNU binutils
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiong Wang <jiong.wang@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        "Andrii Nakryiko" <andriin@fb.com>
CC:     <jose.marchesi@oracle.com>, <binutils@sourceware.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
References: <1B2BE52B-527E-436E-AE49-29FA9E044FD3@netronome.com>
 <CAADnVQJcfnEh4_ok1o9oWNiaBAdd-2XHiguu1FvPZdnAuXuWBg@mail.gmail.com>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <9430cd91-9344-8bb7-27da-c6809f876757@solarflare.com>
Date:   Tue, 21 May 2019 20:02:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAADnVQJcfnEh4_ok1o9oWNiaBAdd-2XHiguu1FvPZdnAuXuWBg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.203]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24628.004
X-TM-AS-Result: No-1.617100-4.000000-10
X-TMASE-MatchedRID: ZrceL/U8jXTmLzc6AOD8DfHkpkyUphL9IiTd2l7lf6H3msKSd1g4xR1Z
        oYOHk+aurAcfB2a374AErxo5p8V1/L9ZdlL8eona0C1sQRfQzEHEQdG7H66TyN+E/XGDLHcMrYj
        3umI9X4VucsyxQ0cbFCkQ1nYVqasg/+nUSjJgvwie/M+VV+G7TdF7sFeLpOISQt5iBDekSTNHiC
        vDVdWzQxs9ieDM+KaohXICXPkDTMLvGyaLyWJvBWLqcdF40kDywzhVZiqhieFqbamnjuWv4A==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.617100-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24628.004
X-MDID: 1558465350-X34mi8XE0NQU
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 21/05/2019 19:18, Alexei Starovoitov wrote:
> I think Ed had an idea on how to specify BTF in asm syntax.
Specifically, see [1] for BTF as implemented in ebpf_asm, though note
 that it doesn't (yet) cover .btf.ext or lineinfo.

-Ed

[1]: https://github.com/solarflarecom/ebpf_asm/tree/btfdoc#type-definitions
