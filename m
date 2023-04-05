Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEC86D874F
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 21:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjDETua (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 15:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjDETuQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 15:50:16 -0400
Received: from out-60.mta1.migadu.com (out-60.mta1.migadu.com [IPv6:2001:41d0:203:375::3c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF4A83E6
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 12:49:51 -0700 (PDT)
Message-ID: <1ec1178e-7a7a-d49c-ba3d-fb2349a55c24@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680724190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jcwcfq1HabL06YWO4RYJWNsbg0LRNmnhjGzEhY3v8ro=;
        b=DZ69gwEDf0j5AmC9Cl+z0KORJM6Mhc+EukY91YY2oUECbUcFGKMdpXllJtXwp0+rwe0oBU
        zCrkQIkdG4dLMwfm1roSyC3kdrAUiw0IaTmF528P4LGU6bAkzpL8WzqgKAWWyMWA7nRBUo
        R4DBbBltODJG7SHW8YsvC9hTzn6gmGI=
Date:   Wed, 5 Apr 2023 12:49:47 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 0/2] selftests: xsk: Add test case for packets at
 end of UMEM
Content-Language: en-US
To:     Kal Cutter Conley <kal.conley@dectris.com>
Cc:     Magnus Karlsson <magnus.karlsson@gmail.com>, bpf@vger.kernel.org
References: <20230403145047.33065-1-kal.conley@dectris.com>
 <00f36cce-f186-2d39-ae5c-67da3f43129b@linux.dev>
 <CAHApi-k9G6o_Xf9piDKRPLGTMa+CD-1F2-aDqth-dz0_yoYZfg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAHApi-k9G6o_Xf9piDKRPLGTMa+CD-1F2-aDqth-dz0_yoYZfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/5/23 12:31 PM, Kal Cutter Conley wrote:
>> I tried test_xsk.sh. The changed subtest runs ok, so applied.
>>
>> I got failures from test_xsk.sh (even before this set) though. Are these
>> expected or something missing in the environment like kconfig?
> 
> I fixed the other errors here and here (please apply those):
> https://patchwork.kernel.org/project/netdevbpf/patch/20230403120400.31018-1-kal.conley@dectris.com/
> https://patchwork.kernel.org/project/netdevbpf/patch/20230405082905.6303-1-kal.conley@dectris.com/
> 
> One is against bpf and one is against bpf-next (because someone told
> me to move it). I guess they should both be applied to the same
> branch, probably bpf?

They are all fixing a selftests, so applied both to bpf-next also. better but 
still has errors. The errors are down to 'fail:2' now:

./test_xsk.sh
PREREQUISITES: [ PASS ]
1..42
ok 1 PASS: SKB RUN_TO_COMPLETION
ok 2 PASS: SKB RUN_TO_COMPLETION_2K_FRAME_SIZE
ok 3 PASS: SKB RUN_TO_COMPLETION_SINGLE_PKT
ok 4 PASS: SKB POLL_RX
ok 5 PASS: SKB POLL_TX
ok 6 PASS: SKB POLL_RXQ_EMPTY
ok 7 PASS: SKB POLL_TXQ_FULL
ok 8 # SKIP No 2M huge pages present.
ok 9 PASS: SKB ALIGNED_INV_DESC
ok 10 PASS: SKB ALIGNED_INV_DESC_2K_FRAME_SIZE
ok 11 # SKIP No 2M huge pages present.
ok 12 PASS: SKB UMEM_HEADROOM
ok 13 PASS: SKB TEARDOWN
ok 14 PASS: SKB BIDIRECTIONAL
ok 15 PASS: SKB STAT_RX_DROPPED
ok 16 PASS: SKB STAT_TX_INVALID
ok 17 PASS: SKB STAT_RX_FULL
ok 18 PASS: SKB STAT_RX_FILL_EMPTY
ok 19 PASS: SKB BPF_RES
ok 20 PASS: SKB XDP_DROP_HALF
ok 21 PASS: SKB XDP_METADATA_COUNT
ok 22 PASS: DRV RUN_TO_COMPLETION
ok 23 PASS: DRV RUN_TO_COMPLETION_2K_FRAME_SIZE
ok 24 PASS: DRV RUN_TO_COMPLETION_SINGLE_PKT
ok 25 PASS: DRV POLL_RX
ok 26 PASS: DRV POLL_TX
ok 27 PASS: DRV POLL_RXQ_EMPTY
ok 28 PASS: DRV POLL_TXQ_FULL
ok 29 # SKIP No 2M huge pages present.
ok 30 PASS: DRV ALIGNED_INV_DESC
ok 31 PASS: DRV ALIGNED_INV_DESC_2K_FRAME_SIZE
ok 32 # SKIP No 2M huge pages present.
ok 33 PASS: DRV UMEM_HEADROOM
ok 34 PASS: DRV TEARDOWN
ok 35 PASS: DRV BIDIRECTIONAL
ok 36 PASS: DRV STAT_RX_DROPPED
ok 37 PASS: DRV STAT_TX_INVALID
ok 38 PASS: DRV STAT_RX_FULL
ok 39 PASS: DRV STAT_RX_FILL_EMPTY
ok 40 PASS: DRV BPF_RES
ok 41 PASS: DRV XDP_DROP_HALF
ok 42 PASS: DRV XDP_METADATA_COUNT
# Totals: pass:38 fail:0 xfail:0 xpass:0 skip:4 error:0
XSK_SELFTESTS_ve5350_SOFTIRQ: [ PASS ]
1..42
ok 1 PASS: SKB BUSY-POLL RUN_TO_COMPLETION
ok 2 PASS: SKB BUSY-POLL RUN_TO_COMPLETION_2K_FRAME_SIZE
ok 3 PASS: SKB BUSY-POLL RUN_TO_COMPLETION_SINGLE_PKT
ok 4 PASS: SKB BUSY-POLL POLL_RX
ok 5 PASS: SKB BUSY-POLL POLL_TX
ok 6 PASS: SKB BUSY-POLL POLL_RXQ_EMPTY
ok 7 PASS: SKB BUSY-POLL POLL_TXQ_FULL
ok 8 # SKIP No 2M huge pages present.
ok 9 PASS: SKB BUSY-POLL ALIGNED_INV_DESC
ok 10 PASS: SKB BUSY-POLL ALIGNED_INV_DESC_2K_FRAME_SIZE
ok 11 # SKIP No 2M huge pages present.
ok 12 PASS: SKB BUSY-POLL UMEM_HEADROOM
ok 13 PASS: SKB BUSY-POLL TEARDOWN
ok 14 PASS: SKB BUSY-POLL BIDIRECTIONAL
ok 15 PASS: SKB BUSY-POLL STAT_RX_DROPPED
ok 16 PASS: SKB BUSY-POLL STAT_TX_INVALID
ok 17 PASS: SKB BUSY-POLL STAT_RX_FULL
ok 18 PASS: SKB BUSY-POLL STAT_RX_FILL_EMPTY
ok 19 PASS: SKB BUSY-POLL BPF_RES
ok 20 PASS: SKB BUSY-POLL XDP_DROP_HALF
ok 21 PASS: SKB BUSY-POLL XDP_METADATA_COUNT
ok 22 PASS: DRV BUSY-POLL RUN_TO_COMPLETION
ok 23 PASS: DRV BUSY-POLL RUN_TO_COMPLETION_2K_FRAME_SIZE
ok 24 PASS: DRV BUSY-POLL RUN_TO_COMPLETION_SINGLE_PKT
ok 25 PASS: DRV BUSY-POLL POLL_RX
# [is_pkt_valid] expected seqnum [703], got seqnum [704]
not ok 26 FAIL: DRV BUSY-POLL POLL_TX
ok 27 PASS: DRV BUSY-POLL POLL_RXQ_EMPTY
ok 28 PASS: DRV BUSY-POLL POLL_TXQ_FULL
ok 29 # SKIP No 2M huge pages present.
not ok 30 [xskxceiver.c:xsk_configure_socket:1236]: ERROR: 16/"Device or 
resource busy"
# Planned tests != run tests (42 != 30)
# Totals: pass:25 fail:2 xfail:0 xpass:0 skip:3 error:0

