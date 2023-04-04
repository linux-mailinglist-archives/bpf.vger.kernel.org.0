Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFF16D5CCD
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 12:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjDDKNV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 06:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbjDDKNK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 06:13:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9157D30C7
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 03:12:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b20so128408267edd.1
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 03:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1680603158;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=MsABVrreatlMEIk5ifFYOGlU/Qa3W4KtZtzz73o+Deo=;
        b=esaFaSMcMzQaTfsN3nuStmY6blStob9qtYeGECCmqrIM2P/hYCBSAPCU+iLe/3eoz8
         y2ZyKrS8szTi1ddlaKgIKwtSPQEUFxYblDLq5LcYk2cmJVJo3f+Rxd/YJ3i53VlfeKih
         OMSWNdwq2tuijCldGNWdYMRuSldPgDG0U52HY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680603158;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsABVrreatlMEIk5ifFYOGlU/Qa3W4KtZtzz73o+Deo=;
        b=f65GBGPRgq+wM/Qn2yFSu4ftW1IAXikzGgeTovh586oeSG02Ze/E1fjEyvYO4sFjuU
         bdldrhn1KkIZGWXxzmM1CQ4nWkT7nkN/nQcy9HH7+a1NujLues0+WukkNJDk91idGJi2
         MfGQb0bBE2xWd7vWZ4zoRdD3AUmGHN1uiflDcmQhWf1VBqYs5qmc1nrzyekszeFO0HA3
         KjoU3vmjpMM8vdwTMqThm6vHxNJOeLpF0OyQkIQXWa74di5pA5ZQu1zfuAsj5QFYo0DP
         hZvXwMfd3Mf6stgQeUc/P2SHvs1GWtJG/b11Fh1RoijUBCSmzg2n1e+qoSmmEoh1z/XX
         xbPg==
X-Gm-Message-State: AAQBX9eQj+dVQDRdUN7maat6LsIGoxeyHgWlmhxN4/jXGTx4etckiNZR
        oyPzZZeqHW4GaT+UdQZ8I5I/NQ==
X-Google-Smtp-Source: AKy350ZovQlnVF9nduapVqvOrfjrblcJjX+y6nb41zSmImnDp5S5FPLoq8TLD0+1uvgxCMPdGQqvMQ==
X-Received: by 2002:a17:907:b60e:b0:930:d17b:959b with SMTP id vl14-20020a170907b60e00b00930d17b959bmr2578146ejc.22.1680603157945;
        Tue, 04 Apr 2023 03:12:37 -0700 (PDT)
Received: from cloudflare.com (79.184.147.137.ipv4.supernova.orange.pl. [79.184.147.137])
        by smtp.gmail.com with ESMTPSA id o12-20020a170906600c00b0092bea699124sm5723973ejj.106.2023.04.04.03.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 03:12:33 -0700 (PDT)
References: <20230327175446.98151-1-john.fastabend@gmail.com>
 <20230327175446.98151-5-john.fastabend@gmail.com>
 <87a5zpdxu7.fsf@cloudflare.com> <642b3f94f13df_e67b72086@john.notmuch>
User-agent: mu4e 1.6.10; emacs 28.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     cong.wang@bytedance.com, daniel@iogearbox.net, lmb@isovalent.com,
        edumazet@google.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, will@isovalent.com
Subject: Re: [PATCH bpf v2 04/12] bpf: sockmap, handle fin correctly
Date:   Tue, 04 Apr 2023 12:11:32 +0200
In-reply-to: <642b3f94f13df_e67b72086@john.notmuch>
Message-ID: <875yacdkhf.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 03, 2023 at 02:05 PM -07, John Fastabend wrote:
> Jakub Sitnicki wrote:

[...]

>> tcp_bpf_recvmsg needs a similar fix, no?
>
> Yes, I had lumped it in with follow up fixes needed for the
> stream parser case but your right its not related.
>
> Mind if I do it in a follow up? Or if I need to do a v4 I'll
> roll it in there.

That works. Totally your call.
