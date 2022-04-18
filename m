Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E99A505C08
	for <lists+bpf@lfdr.de>; Mon, 18 Apr 2022 17:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346064AbiDRP4b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Apr 2022 11:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345939AbiDRP4T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Apr 2022 11:56:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D041331225
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 08:45:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 920BAB80F63
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 15:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59578C385AB
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 15:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650296729;
        bh=AsXYlrlnwIa3KQs0f83qAnUtd0S5pHiR2sK0VD0MjKk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W5Ek0Owoe5Vl2g1Rpk9INnupECkp0IOI6yjK60yUIuJ4zP4FyIF1rKjtydL9cTq11
         XElDVX73UrVgxPJoFJHvcWcXQitTTkpeLA845S6U0OjYbYABxUWRke1ddDOBzt6jVX
         ErVLWxqhRpMtzqpacFUEQA8nQXD2PsCwp8ZAITzhwM3GfiRVDp6IY17VZXzdjvN/hG
         HjAXmaRX0LVIuDi1hqhPtKptgcooNMk0WvrI7WdHhvXumHpRFp3nbuby1JqaISrgin
         RmHdL0vTKFBQ/pIZbMK+BQhhGWAi6lLjJcyCUWhOyDDH8eXfIGv8+BXrnD1XJc40Rb
         4tiWXfu/rLDHg==
Received: by mail-ej1-f41.google.com with SMTP id ks6so27580412ejb.1
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 08:45:29 -0700 (PDT)
X-Gm-Message-State: AOAM533XLiOdF5xwGnA7xkJpImM7wCjFPmUobk6/jEywfTA4eJLrH9au
        7+sFs+CWuw12Xy8oNUUFfGHyMA/F9/enx6fgWEu9PA==
X-Google-Smtp-Source: ABdhPJx/6GN04UanhiDpyS/l6I9LVPtM4PGeDHf9bb0VSmtGLjaas4aMjgMYQgZT2BTPM8A+hDYU9+zrWJW//0Aohgk=
X-Received: by 2002:a17:907:7f1c:b0:6eb:c702:7f4e with SMTP id
 qf28-20020a1709077f1c00b006ebc7027f4emr9536443ejc.496.1650296727631; Mon, 18
 Apr 2022 08:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220418142929.2600589-1-kpsingh@kernel.org>
In-Reply-To: <20220418142929.2600589-1-kpsingh@kernel.org>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 18 Apr 2022 17:45:17 +0200
X-Gmail-Original-Message-ID: <CACYkzJ55WjmPtUsozYQQwU5ZwYe2GnY8OyUHseRfcnW_1EVnRA@mail.gmail.com>
Message-ID: <CACYkzJ55WjmPtUsozYQQwU5ZwYe2GnY8OyUHseRfcnW_1EVnRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix usage of trace RCU in local storage.
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 18, 2022 at 5:25 PM KP Singh <kpsingh@kernel.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> bpf_{sk,task,inode}_storage_free() do not need to use
> call_rcu_tasks_trace as no BPF program should be accessing the owner
> as it's being destroyed. The only other reader at this point is
> bpf_local_storage_map_free() which uses normal RCU.
>
> The only path that needs trace RCU are:
>
> * bpf_local_storage_{delete,update} helpers
> * map_{delete,update}_elem() syscalls
>
> Fixes: 8553c67b1b54 ("bpf: Reduce usage of trace RCU in local storage.")
> Signed-off-by: KP Singh <kpsingh@google.com>

Please ignore. I messed up gitconfig today. Apologies for the noise.
Sending a v2 today with the right Fixes commit.
