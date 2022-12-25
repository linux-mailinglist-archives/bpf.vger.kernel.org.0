Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1FD655E2A
	for <lists+bpf@lfdr.de>; Sun, 25 Dec 2022 20:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiLYTON (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Dec 2022 14:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYTOM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Dec 2022 14:14:12 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB97E87
        for <bpf@vger.kernel.org>; Sun, 25 Dec 2022 11:14:09 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id d2so6412854qvp.12
        for <bpf@vger.kernel.org>; Sun, 25 Dec 2022 11:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9k4ddpmPgxClO2/idn9r0y8xUw2nToQbpPtNTZGn7o=;
        b=adgSxHvv0+vIDN1ymUd/dWRNkNljBngGO3fSZWf9EQvOI+r+tduBwu+4oGqCDhPXVE
         6vctBqOKeCFZPcmpSoNyn1Le7pl0AYNjVQ2nCkledWdIEpNAVPMMoX19T+TrKd2zWaE7
         9wR5feeQUiweMbeIT76Q8n2gnTzp8GDDiroYKThkGE2k1/+jt1KJG2+SlFYUzhpwmIRu
         zk/ceFkpMUOVO15W9wOnxgZV/xu48sYLVfmCCjjzXSiaDTzOCo3aOyuFD4S8u2kIwF9h
         fjMoqmVIGRsc0zjdPY4YiTpXkEltFfYmC+T8l9KTACRqOlrZ9YcpPY2qQsdWyV/o1UsZ
         XoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9k4ddpmPgxClO2/idn9r0y8xUw2nToQbpPtNTZGn7o=;
        b=ic8p8HvB8zqfjcqwUwuP/yE94JGRZScTKi02qItyl/BaHZ+1JXwskpv0epkEPlghHl
         xghWDjr4ZVVHmFqN899VKVHpTf3goexjmuOIbHFrE4D3tvZ6nzbkoVAvC79mNfcZQm+L
         tfedxei76PQWkcdH508Zqq+SCtSngOEqvf/vNzpMGNaLSGlfIradXgByZK+PgCh3zdjI
         UM/skaEoin19SsyCz4ILy79gCt4GjG0v2lIFLniedxo2AcRSuv/5P6jKFdTpBiT+zIcc
         Wu/TIRcZbz3TGZoNBzZMjgiiopXD2Pdo8wtM89pyC7DafQ5GFpL69MGJWhom0KGDBxxe
         xFGA==
X-Gm-Message-State: AFqh2kpn4tUk49cpvMK/BaGOqTJjEWmL5tkYcsqansK5Jb5/9aE3mSVu
        Jq6ULBrxZLb0P9S3PAoAd+H6
X-Google-Smtp-Source: AMrXdXvkgJcevqx0yEBp/OXwofy0Rj3yDKjefHgBfl6xVW0EqX7iDT+jkS0A6I+mPjKThlUW55g3og==
X-Received: by 2002:a05:6214:418e:b0:515:5e33:5059 with SMTP id ld14-20020a056214418e00b005155e335059mr21909271qvb.26.1671995649068;
        Sun, 25 Dec 2022 11:14:09 -0800 (PST)
Received: from [10.104.7.245] (mobile-107-107-57-41.mycingular.net. [107.107.57.41])
        by smtp.gmail.com with ESMTPSA id x14-20020a05620a258e00b006fcb2d3f284sm6468823qko.67.2022.12.25.11.14.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Dec 2022 11:14:07 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     Jiri Olsa <olsajiri@gmail.com>
CC:     <linux-audit@redhat.com>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Burn Alting <burn.alting@iinet.net.au>,
        Stanislav Fomichev <sdf@google.com>
Date:   Sun, 25 Dec 2022 14:14:06 -0500
Message-ID: <1854ab4e030.28e3.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <Y6hakaFw+Oph7xmB@krava>
References: <20221223185531.222689-1-paul@paul-moore.com>
 <Y6hakaFw+Oph7xmB@krava>
User-Agent: AquaMail/1.41.0 (build: 104100234)
Subject: Re: [PATCH v2] bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD and PERF_BPF_EVENT_PROG_UNLOAD
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Apologies for the top post, but as I mentioned in my last message in this 
thread, next week I'll post a version without the getter/checks so this 
should not be an issue.

--
paul-moore.com

On December 25, 2022 9:13:40 AM Jiri Olsa <olsajiri@gmail.com> wrote:

> On Fri, Dec 23, 2022 at 01:55:31PM -0500, Paul Moore wrote:
>
> SNIP
>
>> diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
>> index 50854265864d..2795f03f5f34 100644
>> --- a/drivers/net/netdevsim/bpf.c
>> +++ b/drivers/net/netdevsim/bpf.c
>> @@ -109,7 +109,7 @@ nsim_bpf_offload(struct netdevsim *ns, struct bpf_prog 
>> *prog, bool oldprog)
>> "bad offload state, expected offload %sto be active",
>> oldprog ? "" : "not ");
>> ns->bpf_offloaded = prog;
>> - ns->bpf_offloaded_id = prog ? prog->aux->id : 0;
>> + ns->bpf_offloaded_id = prog ? bpf_prog_get_id(prog) : 0;
>> nsim_prog_set_loaded(prog, true);
>>
>> return 0;
>> @@ -221,6 +221,7 @@ static int nsim_bpf_create_prog(struct nsim_dev *nsim_dev,
>> struct nsim_bpf_bound_prog *state;
>> char name[16];
>> int ret;
>> + u32 id;
>>
>> state = kzalloc(sizeof(*state), GFP_KERNEL);
>> if (!state)
>> @@ -239,7 +240,8 @@ static int nsim_bpf_create_prog(struct nsim_dev *nsim_dev,
>> return ret;
>> }
>>
>> - debugfs_create_u32("id", 0400, state->ddir, &prog->aux->id);
>> + id = bpf_prog_get_id(prog);
>> + debugfs_create_u32("id", 0400, state->ddir, &id);
>> debugfs_create_file("state", 0400, state->ddir,
>> &state->state, &nsim_bpf_string_fops);
>> debugfs_create_bool("loaded", 0400, state->ddir, &state->is_loaded);
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 9e7d46d16032..18e965bd7db9 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1102,7 +1102,7 @@ struct bpf_prog_aux {
>> u32 max_pkt_offset;
>> u32 max_tp_access;
>> u32 stack_depth;
>> - u32 id;
>> + u32 __id; /* access via bpf_prog_get_id() to check bpf_prog::valid_id */
>
> it breaks bpftool that uses
>
>  BPF_CORE_READ((struct bpf_prog *)ent, aux, id);
>
> and bpffs selftest because of preload iter object uses aux->id
>
>  kernel/bpf/preload/iterators/iterators.bpf.c
>
> it'd be great to have a solution that keep 'id' field,
> because it's probably used in many bpf programs already
>
> jirka
>
>> u32 func_cnt; /* used by non-func prog as the number of func progs */
>> u32 func_idx; /* 0 for non-func prog, the index in func array for func prog */
>> u32 attach_btf_id; /* in-kernel BTF type id to attach to */
>> @@ -1197,7 +1197,8 @@ struct bpf_prog {
>> enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at 
>> attach time */
>> call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
>> call_get_func_ip:1, /* Do we call get_func_ip() */
>> - tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
>> + tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
>> + valid_id:1; /* Is bpf_prog::aux::__id valid? */
>> enum bpf_prog_type type; /* Type of BPF program */
>> enum bpf_attach_type expected_attach_type; /* For some prog types */
>> u32 len; /* Number of filter blocks */
>> @@ -1688,6 +1689,12 @@ void bpf_prog_inc(struct bpf_prog *prog);
>> struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
>> void bpf_prog_put(struct bpf_prog *prog);
>
> SNIP



