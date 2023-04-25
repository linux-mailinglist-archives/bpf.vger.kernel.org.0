Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6AD6EE597
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 18:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbjDYQVS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 12:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjDYQVS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 12:21:18 -0400
Received: from out-42.mta0.migadu.com (out-42.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE042684
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 09:21:16 -0700 (PDT)
Message-ID: <9f190e7d-81f8-6a19-2c40-efff3840a606@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682439674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YpGWfUJ0YMTDR6T0J5WKJSYaJmv5JlIf/hIRBqTGkpI=;
        b=PMo/9yMtGDKIqQ7sYIzXnOppoaZSJKvCyHyVHE9davobTWNYII+dKwAYm6jsx3kF/91nis
        VR82KqhI+A1pZ25lTUW9PkwIiqi4VywwMapKYyRib2o+g95YucgRL06ASKxiD1BaVGkkbq
        ztY9SZgzDD4kjrAPPMhZyr3ABVQ7ceQ=
Date:   Tue, 25 Apr 2023 09:21:08 -0700
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] KCSAN: data-race in __bpf_lru_list_rotate /
 __htab_lru_percpu_map_update_elem (5)
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com,
        yhs@fb.com,
        syzbot <syzbot+ebe648a84e8784763f82@syzkaller.appspotmail.com>
References: <0000000000002d14f305fa241e67@google.com>
 <CAADnVQK3m34RPCgw-7qWxE4gBb+ZoX4ZmEtbe-Ku0_ZOSG+5vA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQK3m34RPCgw-7qWxE4gBb+ZoX4ZmEtbe-Ku0_ZOSG+5vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/25/23 8:08 AM, Alexei Starovoitov wrote:
> Martin,
> 
> 
> Please take a look at the trace below.
> I think we just need to annotate bpf_lru_node_set_ref() with data_race().
> wdyt?

Agreed. node->ref needs a data_race(). I will post a patch.


