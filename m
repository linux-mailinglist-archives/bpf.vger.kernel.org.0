Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE765756CD
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 23:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbiGNVTl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 17:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGNVTk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 17:19:40 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43BC13CF9;
        Thu, 14 Jul 2022 14:19:37 -0700 (PDT)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oC6FD-0000Xu-Sf; Thu, 14 Jul 2022 23:19:35 +0200
Received: from [85.1.206.226] (helo=linux-3.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oC6FD-000XEQ-KJ; Thu, 14 Jul 2022 23:19:35 +0200
Subject: LPC 2022 Networking and BPF Track CFP (Reminder)
References: <cd33ca74-aec9-ff57-97d5-55d8b908b0ba@iogearbox.net>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     xdp-newbies@vger.kernel.org, iovisor-dev@lists.iovisor.org,
        linux-wireless@vger.kernel.org, netfilter-devel@vger.kernel.org,
        lwn@lwn.net
From:   Daniel Borkmann <daniel@iogearbox.net>
X-Forwarded-Message-Id: <cd33ca74-aec9-ff57-97d5-55d8b908b0ba@iogearbox.net>
Message-ID: <fa09a9f1-7d99-cafb-3c10-7a3e474d8da6@iogearbox.net>
Date:   Thu, 14 Jul 2022 23:19:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <cd33ca74-aec9-ff57-97d5-55d8b908b0ba@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26601/Thu Jul 14 09:57:26 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a reminder for the Call for Proposals (CFP) for the Networking and
BPF track at the 2022 edition of the Linux Plumbers Conference (LPC), which is
planned to be held in Dublin, Ireland, on September 12th - 14th, 2022.

Note that the conference is planned to be both in person and remote (hybrid).
CFP submitters should ideally be able to give their presentation in person to
minimize technical issues if circumstances permit, although presenting remotely
will also be possible.

This year's Networking and BPF track technical committee is comprised of:

    David S. Miller <davem@davemloft.net>
    Jakub Kicinski <kuba@kernel.org>
    Paolo Abeni <pabeni@redhat.com>
    Eric Dumazet <edumazet@google.com>
    Alexei Starovoitov <ast@kernel.org>
    Daniel Borkmann <daniel@iogearbox.net>
    Andrii Nakryiko <andrii@kernel.org>

We are seeking proposals of 40 minutes in length (including Q&A discussion).

Any kind of advanced Linux networking and/or BPF related topic will be considered.

Please submit your proposals through the official LPC website at:

    https://lpc.events/event/16/abstracts/

Make sure to select "eBPF & Networking" in the track pull-down menu.

Proposals must be submitted by August 10th, and submitters will be notified of
acceptance by August 12th.

Final slides (as PDF) are due on the first day of the conference.

We are very much looking forward to a great conference and seeing you all!
