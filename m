Return-Path: <bpf+bounces-3555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE2073FA7B
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 12:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C60F1C2032A
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 10:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F355174D3;
	Tue, 27 Jun 2023 10:48:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FCB12B9C;
	Tue, 27 Jun 2023 10:48:26 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C1210FF;
	Tue, 27 Jun 2023 03:48:23 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qE6FA-0003Jr-AG; Tue, 27 Jun 2023 12:48:20 +0200
Date: Tue, 27 Jun 2023 12:48:20 +0200
From: Florian Westphal <fw@strlen.de>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
	fw@strlen.de, daniel@iogearbox.net, dsahern@kernel.org
Subject: Re: [PATCH bpf-next 0/7] Support defragmenting IPv(4|6) packets in
 BPF
Message-ID: <20230627104820.GF3207@breakpoint.cc>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687819413.git.dxu@dxuuu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Daniel Xu <dxu@dxuuu.xyz> wrote:
> Patches 1 & 2 are stolenfrom Florian. Hopefully he doesn't mind. There
> were some outstanding comments on the v2 [2] but it doesn't look like a
> v3 was ever submitted.  I've addressed the comments and put them in this
> patchset cuz I needed them.

I did not submit a v3 because i had to wait for the bpf -> bpf-next
merge to get "bpf: netfilter: Add BPF_NETFILTER bpf_attach_type".

Now that has been done so I will do v3 shortly.

