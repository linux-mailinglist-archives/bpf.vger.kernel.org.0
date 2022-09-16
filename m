Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876F25BB23F
	for <lists+bpf@lfdr.de>; Fri, 16 Sep 2022 20:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiIPSh4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Sep 2022 14:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiIPShz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Sep 2022 14:37:55 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D2D14D0E;
        Fri, 16 Sep 2022 11:37:54 -0700 (PDT)
Message-ID: <7c01a2b8-bfb7-df72-faae-0b940ea0f149@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663353472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F3RNLEuF8buEC8QUWl8Z2CEswmdqvtMcE8bEVXrKec0=;
        b=TfoqqXo3iCxx0PHrv+jEu26Nlcw222jcGOVZm43Yn+SujQwDsLaOsEz9j5t5UjX/xwtBbE
        OxALioATvD6PdqBPO2eowC6PR6CqalYKOlOvM9n7UM92jUtsmwT7fsze7zlIZE+AM5LxYB
        kJTu2TYph7cDk9wZyn6K1gXvdIF1KJA=
Date:   Fri, 16 Sep 2022 11:37:46 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf/btf: Use btf_type_str() whenever possible
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Peilin Ye <peilin.ye@bytedance.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220914021328.17039-1-yepeilin.cs@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20220914021328.17039-1-yepeilin.cs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/13/22 7:13 PM, Peilin Ye wrote:
> From: Peilin Ye <peilin.ye@bytedance.com>
> 
> We have btf_type_str().  Use it whenever possible in btf.c, instead of
> "btf_kind_str[BTF_INFO_KIND(t->info)]".
> 
> Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
> ---
>   kernel/bpf/btf.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index cad4657ba2ce..81dc7423d723 100644

This clean up makes sense.  The patch cannot be applied though [0], so 
it is marked as 'Changes Requested'.  Also, where is the cad4657ba2ce 
coming from?  It can't be found in the bpf-next tree.  Please rebase on 
the bpf-next and resend.


[0]: 
https://patchwork.kernel.org/project/netdevbpf/patch/20220914021328.17039-1-yepeilin.cs@gmail.com/
