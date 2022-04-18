Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57C7505C07
	for <lists+bpf@lfdr.de>; Mon, 18 Apr 2022 17:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345844AbiDRP4V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Apr 2022 11:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346056AbiDRP4C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Apr 2022 11:56:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E71C3526F
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 08:44:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6D36B80FD4
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 15:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D39C385B6
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 15:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650296671;
        bh=wJamUmVa37bYFg4DctFtvAWAV3VAkkML+CF8Uhud5M8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ko6YB4VPSwz5fkcK45DLToaxkm57sFNwg/TkLYj16Un4smA1BcffC2hXmnImBWicP
         iz9HYaelJ+G/xU8+TaJ0Mzb/nYxTRmh4iqtDEfuTaJFAWuCZzEG8SZJU+CH0QRbJ2q
         c92uPPf00JRUd/ccf8txd71Lh0R0DC35JfPKzn2i79+z9crbmimetMgSBZ9ufJc8zc
         4NAmQYckOQ3cVSau0SmMv1pJjR5OgeHsmxlG2ql87UOcryNNLaDIn5MYRfVG3X1Fxt
         WOg0J8acXokVPY4zHVHWi6FcTRMY+eiYjmiaufBPCZltCQW4GfHMRW+4G2VyJc6Vef
         tXSay74i/lErw==
Received: by mail-ej1-f52.google.com with SMTP id g18so27506079ejc.10
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 08:44:31 -0700 (PDT)
X-Gm-Message-State: AOAM5320riVmtiPWEZjaVM2WaQ/jLgZqPHPZ3hrisj1fY4UFhwSxxnh2
        pb38blPk2Y6QC4PntN4Mdjsn6uFk1LOtf45dkb+PkQ==
X-Google-Smtp-Source: ABdhPJx10y8GIGMfEW+aLwvtOAKspndwnzW7uReLK9kHn3xa+OehvLaj82IhSq6TxfI6E/DMrPT1mg6khcBYLMTO7N4=
X-Received: by 2002:a17:907:3f8a:b0:6ef:8f87:67e with SMTP id
 hr10-20020a1709073f8a00b006ef8f87067emr7029979ejc.383.1650296669718; Mon, 18
 Apr 2022 08:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220418145202.2855726-1-kpsingh@kernel.org>
In-Reply-To: <20220418145202.2855726-1-kpsingh@kernel.org>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 18 Apr 2022 17:44:19 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5p=sMnz-+7PZbOy4tEKwCrQj7aEGj=8zFq9wXiWdCt5A@mail.gmail.com>
Message-ID: <CACYkzJ5p=sMnz-+7PZbOy4tEKwCrQj7aEGj=8zFq9wXiWdCt5A@mail.gmail.com>
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

On Mon, Apr 18, 2022 at 5:33 PM KP Singh <kpsingh@kernel.org> wrote:
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

This is the wrong commit. Please ignore.

> Signed-off-by: KP Singh <kpsingh@kernel.org>

[...]
