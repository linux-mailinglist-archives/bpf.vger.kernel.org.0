Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA9125876
	for <lists+bpf@lfdr.de>; Tue, 21 May 2019 21:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfEUTtX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 May 2019 15:49:23 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:39168 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726767AbfEUTtX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 May 2019 15:49:23 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us3.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E32609C005B;
        Tue, 21 May 2019 19:49:21 +0000 (UTC)
Received: from [10.17.20.203] (10.17.20.203) by ocex03.SolarFlarecom.com
 (10.20.40.36) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 21 May
 2019 12:49:17 -0700
Subject: Re: [PATCH 0/9] eBPF support for GNU binutils
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiong Wang <jiong.wang@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Yonghong Song" <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, <binutils@sourceware.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
References: <1B2BE52B-527E-436E-AE49-29FA9E044FD3@netronome.com>
 <CAADnVQJcfnEh4_ok1o9oWNiaBAdd-2XHiguu1FvPZdnAuXuWBg@mail.gmail.com>
 <9430cd91-9344-8bb7-27da-c6809f876757@solarflare.com>
 <87tvdnlhyl.fsf@oracle.com>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <3be85ea0-2f81-a6bd-5291-6d6aed5aa554@solarflare.com>
Date:   Tue, 21 May 2019 20:49:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87tvdnlhyl.fsf@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.203]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24628.004
X-TM-AS-Result: No-5.841900-4.000000-10
X-TMASE-MatchedRID: VPleTT1nwdTmLzc6AOD8DfHkpkyUphL9IiTd2l7lf6H3msKSd1g4xR1Z
        oYOHk+aurAcfB2a374AmYILGS2LR4y8ptaR5MzFyoezu6s3sLuA2vbWaKPnQ2wUNFj359fb25vX
        VAEnFbKaEgl0njLljkhPR2B0aYIaNy6sqiZ9hS8YD2WXLXdz+AS3S35ohUu37oxpw+aZeXUejxY
        yRBa/qJQOkBnb8H8GWDV8DVAd6AO/dB/CxWTRRu92KvEVWmYr1Zp4+3//ccZix9nU+lq9422EQW
        3HcKaWR5na0rb9xLa3sp3/Doy0M4A==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.841900-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24628.004
X-MDID: 1558468162-FZtJ_IU9L9eL
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 21/05/2019 20:34, Jose E. Marchesi wrote:
>     On 21/05/2019 19:18, Alexei Starovoitov wrote:
>     > I think Ed had an idea on how to specify BTF in asm syntax.
>     Specifically, see [1] for BTF as implemented in ebpf_asm, though note
>     that it doesn't (yet) cover .btf.ext or lineinfo.
>     
>     [1]: https://github.com/solarflarecom/ebpf_asm/tree/btfdoc#type-definitions
>
> Thanks for the reference.  I just checked out your `btfdoc' branch.  I
> will take a look.
>
> Where would you like to get feedback/suggestions/questions btw?
For ebpf_asm?  Either through GitHub Issues, or this address (ecree@solarflare.com).

I'm not actually on bpf@vger (though maybe I ought to subscribe...)

BTW I'm really happy to see someone working on eBPF support in the GNU
 toolchain; being tied to an LLVM monoculture has been bad for eBPF imho.

-Ed
