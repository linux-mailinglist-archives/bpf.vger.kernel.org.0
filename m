Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030C754DA7F
	for <lists+bpf@lfdr.de>; Thu, 16 Jun 2022 08:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358953AbiFPGZS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jun 2022 02:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiFPGZR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jun 2022 02:25:17 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D273B27FF4
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 23:25:15 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id r3so561545ybr.6
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 23:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QhpRsnpqN2gDwCjPZET5E+75fQS7DQEBgjpXAx4Kmk=;
        b=npsR0pb0hYDQy/2YFqxITKWKTPhOUq+ZEcflVvrSPzv2bVu2Z4b269qCW4/jzmRG2E
         Tzb7lZ5TeO06lSe2zl9dzLdR4ANrzYR47XT3+wcXTw2pnPXWy4pwpyoKvDIte6qP2gxW
         oOkuMH+hPCwa2pY9+LPWAfmTVwYinXiYx5PL/CCVIZ+ykEh007tXAvnBsyk33Mc/PCBS
         P9rpqZwpQaGpxqwrjKjmsWrsQVckQu87C8fyIeFLKF8WemK/aOuKPp8dVWwFWONTn+L6
         7OanJQotSZIqCu2xAXF/1BKkOMY6MF5QUbWMkDP1FchJaaCHC1hBhxNxofIYMPzYZV8b
         cuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QhpRsnpqN2gDwCjPZET5E+75fQS7DQEBgjpXAx4Kmk=;
        b=2Ku7hXfhup69H2AqRqnRzs2RxjNAHxXhV3gDbKy9Wecl+lwhjpOvaRV5MH6EZOhxnx
         3L5bZg2iBbBk9tEc3oARJ4dwrUSZgKMJD6CCXFvGCj2T44DyvtPE8HAHsCO/qG37Pv99
         UUgP9noMZ0UzsXikKnSrR+F3eTyD25lpRn34rcLvwnvbeHT1AEHFMlMRu9yyD9fsS5lz
         bUymXCkRHmuMBnPMVPcKBIlCGLWeFuh3RaRFRoNS/eeLt9TRxgb74DKSxfqUqvx4bQwE
         zPKYaHILJfAVsdHJvYchD58jfU1vUBWb7tyQmjNjUxOt2QS2r/RJjXZNdSSYtAAE/+FI
         7siA==
X-Gm-Message-State: AJIora/e0LF2+wEuxMQF5oNMDu0D9VQ62K0HU8+4reJP/JEe1ApOYaMr
        XwoEd+J0TLiURRkgvHf53BQAoc1VnNj5AHE+nHJVJQ==
X-Google-Smtp-Source: AGRyM1tLwkKIpZSHFrZnDBLK2MWSKsEfoLz77zmc1heDP5n1J31F07UOmLPleXo9xMjAHkEYSYWaMJ7Q57+5jY1N8B8=
X-Received: by 2002:a25:d649:0:b0:65c:9e37:8bb3 with SMTP id
 n70-20020a25d649000000b0065c9e378bb3mr3732105ybg.387.1655360714776; Wed, 15
 Jun 2022 23:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220615162014.89193-1-xiyou.wangcong@gmail.com> <20220615162014.89193-2-xiyou.wangcong@gmail.com>
In-Reply-To: <20220615162014.89193-2-xiyou.wangcong@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 15 Jun 2022 23:25:03 -0700
Message-ID: <CANn89iJY2fY_fa+ECJaOgzcR12VOTpqmET8h4ZhgSo_uA=d27g@mail.gmail.com>
Subject: Re: [Patch bpf-next v4 1/4] tcp: introduce tcp_read_skb()
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 15, 2022 at 9:20 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> From: Cong Wang <cong.wang@bytedance.com>
>
> This patch inroduces tcp_read_skb() based on tcp_read_sock(),
> a preparation for the next patch which actually introduces
> a new sock ops.
>
> TCP is special here, because it has tcp_read_sock() which is
> mainly used by splice(). tcp_read_sock() supports partial read
> and arbitrary offset, neither of them is needed for sockmap.
>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
