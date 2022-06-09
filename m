Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBA8545135
	for <lists+bpf@lfdr.de>; Thu,  9 Jun 2022 17:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243225AbiFIPtb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jun 2022 11:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbiFIPta (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jun 2022 11:49:30 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4418C10789B
        for <bpf@vger.kernel.org>; Thu,  9 Jun 2022 08:49:29 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h19so31808653edj.0
        for <bpf@vger.kernel.org>; Thu, 09 Jun 2022 08:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OhCiSaVtT7PzOt/+N9WARlegY6/nQxckbmVX3EBXzw=;
        b=Yrn1SM70gINJwTXekRwIHZyoXYUfYA9MQgEUvyt4//S3iIKz4gs8/fPq2SuwZtcEip
         OYPzREzRFkIt6/INCBOcTHn2N/tMmAX/hLqfpy+VvFNOAiJYeh09w1/JP0YHbofQSYtC
         YAav+BLYMhioXaOwDrcBkYFG6JWHRbx0eZS82hDeEVfSaA/Z5PIN5kOzs+74/u7pPDUr
         fcepX6ZmpPpAUWqCM+gtUpaoD/EgteNvM9YBiUxOLOWcNrCJpI8aJUuFNfyBuxiwnuRt
         VE7hm5F6/Q0zT5j2VFwsC25cMCAYPJQEaeSsBXCgBj/ReUl/qgTc57fdGRKjUcyNPESI
         ugcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OhCiSaVtT7PzOt/+N9WARlegY6/nQxckbmVX3EBXzw=;
        b=olSN2wlaQN9kcbfm2sUDq+zhCnvnm489aujASfm/023usXnLRcETJjNoZj05QMcCbx
         Uy8FM1icvLinnrYQbvtaJK7WJuWt8mUaSC+raXddLfWQF2szAp5H1aHeZBku4RCT7FL/
         a7EFtAGofd1cGWqj7K+brWSnoX/iJFRD8ibFPraz03LVha46Pr5/cZBQsucg6xlJMBCF
         o82uR7WhX25f9GJsY/y56ABT9l5MiesuDWnvbAWbjUa/MYOey2AMa/jRihI820eO9Ete
         GGYOdGZFJ+4GW/gotqE3kTV+1OwprOnzA/C3DIYZgcuFLLCnh8x5bvvfAlKGz+BSoGo7
         CrnQ==
X-Gm-Message-State: AOAM531f8rtZ0XEM0DCsoOpT8LIbFVmVQu3nYLWZL1NEfYR7wlvjKP+/
        r0oVg1ZvS95aT2ru71XM6xbxHOO5dVWiQ9xBExk=
X-Google-Smtp-Source: ABdhPJxPO4OWX+ToybIoWqe0Vfaxm6C2bzCCxst3F02Bj3kLoEwMi+ZGlVffRwt3AgDTaxn8LvnTMP8n9BiWkbQS9xk=
X-Received: by 2002:a05:6402:56:b0:431:6f7b:533 with SMTP id
 f22-20020a056402005600b004316f7b0533mr21202063edu.333.1654789767805; Thu, 09
 Jun 2022 08:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220604222006.3006708-1-davemarchevsky@fb.com>
 <20220608230226.jywist5cdgu3ntss@kafai-mbp> <79b4e95c-437d-45c5-c7a8-c077f692c18a@fb.com>
In-Reply-To: <79b4e95c-437d-45c5-c7a8-c077f692c18a@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 9 Jun 2022 08:49:15 -0700
Message-ID: <CAADnVQJ+q6gmSt6E7YmhrdbNbW53tAwC3JKHEF1ts7VBU=x5GQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next] selftests/bpf: Add benchmark for
 local_storage get
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 9, 2022 at 7:27 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >> +
> >> +    if (use_hashmap) {
> >> +            idx = bpf_get_prandom_u32() % hashmap_num_keys;
> >> +            bpf_map_lookup_elem(inner_map, &idx);
> > Is the hashmap populated ?
> >
>
> Nope. Do you expect this to make a difference? Will try when confirming key /
> val size above.

Martin brought up an important point.
The map should be populated.
If the map is empty lookup_nulls_elem_raw() will select a bucket,
it will be empty and it will return NULL.
Whereas the more accurates apples to apples comparison
would be to find a task in a map, since bpf_task_storage_get(,F_CREATE);
will certainly find it.
Then if (l->hash == hash && !memcmp ... will be triggered.
When we're counting nsecs that should be noticeable.
