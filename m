Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E456DE36B
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 20:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjDKSE2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 14:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjDKSEN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 14:04:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1617D8C
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 11:03:25 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94a34a0b531so216276866b.1
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 11:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1681236198;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=FSV9ANwS/wR3TMlpX59Z+o8+oSeSsPkRIA8GfM21izo=;
        b=IyKp4+yJOL4HqQdq5au8hSAoVHJzeGywYXkqyfPBXt4xMNMDxKdpvWLyIlZCy1a9fW
         iTVmzB/EH2J0/S93squa4mR0T18GpVJNwIi+/dztM9ELu5l5CAfS9ex7+WFciu81HE8i
         3jJF+mIyPKKJXyJTPmZaRt32DwAiV3bgi9aNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681236198;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSV9ANwS/wR3TMlpX59Z+o8+oSeSsPkRIA8GfM21izo=;
        b=AjaR8btWTGSB97FHLjM1pI7ZdktXbt3eKixGMAyw+pWwISVCQh4wiuovXcotfe3FKm
         541WZISi0punuspKynVVsCQWsJtKgsgi2knbziSOtbaaeis0Gq9MLzxeIgr+xylKI+Ql
         fCc/KvcqTWTUDC71daEC7evJdF5VjImYtoTLR2LaCG9ISZ22UznCAiPuQcZf+v1HxFL8
         hOY+hDr3CNtHE/NZkV7PuKXDU879h7pH52CDLXvGzzKkBla1K81MtZeuyFta1RfHPCtz
         i0nP+aY4riPGSSe4K0yslx12nbtM+H8cvv+0ghM0HSUqkcbIRh7GJfmqx7g67KMw708i
         Fl6g==
X-Gm-Message-State: AAQBX9dP86OEhkmhptTkEIpnZTEv7diK8i6X6t1vJAvd64qVCA7fFc6M
        lWNr2En1Pzqp+UJ6sHDfiQv65A==
X-Google-Smtp-Source: AKy350YPJeBAIwR5Hh+HhFZ+dTLHFDnqHa+cI5ic7CSD2DixpEsnETrYkW0er9CoMxpEB3eo32ylgA==
X-Received: by 2002:a05:6402:88b:b0:4fa:d83b:f5da with SMTP id e11-20020a056402088b00b004fad83bf5damr8825217edy.30.1681236198249;
        Tue, 11 Apr 2023 11:03:18 -0700 (PDT)
Received: from cloudflare.com (79.191.181.173.ipv4.supernova.orange.pl. [79.191.181.173])
        by smtp.gmail.com with ESMTPSA id cm4-20020a0564020c8400b00504b2d9f4d7sm1531298edb.54.2023.04.11.11.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 11:03:17 -0700 (PDT)
References: <20230407171654.107311-1-john.fastabend@gmail.com>
 <20230407171654.107311-5-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     daniel@iogearbox.net, lmb@isovalent.com, edumazet@google.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, will@isovalent.com
Subject: Re: [PATCH bpf v6 04/12] bpf: sockmap, handle fin correctly
Date:   Tue, 11 Apr 2023 20:02:53 +0200
In-reply-to: <20230407171654.107311-5-john.fastabend@gmail.com>
Message-ID: <87leiyguu3.fsf@cloudflare.com>
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

On Fri, Apr 07, 2023 at 10:16 AM -07, John Fastabend wrote:
> The sockmap code is returning EAGAIN after a FIN packet is received and no
> more data is on the receive queue. Correct behavior is to return 0 to the
> user and the user can then close the socket. The EAGAIN causes many apps
> to retry which masks the problem. Eventually the socket is evicted from
> the sockmap because its released from sockmap sock free handling. The
> issue creates a delay and can cause some errors on application side.
>
> To fix this check on sk_msg_recvmsg side if length is zero and FIN flag
> is set then set return to zero. A selftest will be added to check this
> condition.
>
> Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> Tested-by: William Findlay <will@isovalent.com>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
