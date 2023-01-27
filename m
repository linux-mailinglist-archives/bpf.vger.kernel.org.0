Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497AF67DE8E
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 08:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjA0Hd7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 02:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjA0Hd6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 02:33:58 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1133516332
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 23:33:54 -0800 (PST)
Message-ID: <b7e314d9-ca96-520c-6923-885baebf20b5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674804833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CixjqpKSijC3jMDfdwPgZ/kvP+VNGzi5cw6rMqvK1xg=;
        b=COmj4WrhX5+Efv0au8OH9eorntpJoAilCBOKgiJOrb75GKYPIaRjwRbB3i71Pj/WSJp4mJ
        gjNcNEtDgZvZZpR9GqrwFJofNwJcNvAYapO2bvUTSxyHmpYrLd7z9jYreeTyzGjBxiXVEn
        9hBhoj9H/MJtDhVH2OaS4r/cSrUyqYk=
Date:   Thu, 26 Jan 2023 23:33:51 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2] bpf: Fix the kernel crash caused by
 bpf_setsockopt().
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230127001732.4162630-1-kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230127001732.4162630-1-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/26/23 4:17 PM, Kui-Feng Lee wrote:
> The kernel crash was caused by a BPF program attached to the
> "lsm_cgroup/socket_sock_rcv_skb" hook, which performed a call to
> `bpf_setsockopt()` in order to set the TCP_NODELAY flag as an
> example. Flags like TCP_NODELAY can prompt the kernel to flush a
> socket's outgoing queue, and this hook
> "lsm_cgroup/socket_sock_rcv_skb" is frequently triggered by
> softirqs. The issue was that in certain circumstances, when
> `tcp_write_xmit()` was called to flush the queue, it would also allow
> BH (bottom-half) to run. This could lead to our program attempting to
> flush the same socket recursively, which caused a `skbuf` to be
> unlinked twice.
> 
> `security_sock_rcv_skb()` is triggered by `tcp_filter()`. This occurs
> before the sock ownership is checked in `tcp_v4_rcv()`. Consequently,
> if a bpf program runs on `security_sock_rcv_skb()` while under softirq
> conditions, it may not possess the lock needed for `bpf_setsoppt()`,
> thus presenting an issue.

Fixed a few minor things like s/bpf_setsoppt/bpf_setsockopt/
and s/skbuf/skbuff/.

Applied. Thanks.

