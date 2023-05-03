Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824B86F554F
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 11:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjECJvy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 05:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjECJvP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 05:51:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7A140F3
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 02:50:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so4905716a12.0
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 02:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1683107415; x=1685699415;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=nzMTrFJeM0hfAdWKmiaQPg61F2DkBF+Q5b+R7LJGe18=;
        b=dbIROcpIDkKA5++Dx8M1SceUo8/P/zf+SuuTFmmJO3yXxk+jWsBlsRrDs/+/kbYsud
         MdfDLV8URC5f5omRN1osLqpYoiOIZad+xEwYbrB1f3Do3tv99Z7Jb5ugnWRBJ/AFIy+0
         HJaxVUWNnD+2hQAsP+9GcD9iAYflpxwZJmEmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683107415; x=1685699415;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzMTrFJeM0hfAdWKmiaQPg61F2DkBF+Q5b+R7LJGe18=;
        b=NXTX4SpLQ/fy6N7Z9JxkZt5ZWiXQLDyKC2ggy+lVD7xmUDp+Spyw9w6U2z5Bj+urkb
         06FHSptPV+8j8Xm+EAqlgP9H0497GYTjWcE+NiX5WbgtbQ1w7I7M2tGY41RPLkHik+n1
         STVr9bMpecT9jz/8KLGqf73eCkMAH8KsiPfEj1qfbzXVazomqt8avx9WOdGpuvVzzk/O
         Gud5LdJthoyV/ebOlWVKTx/Xp2LmdO+GPAhcfWBEiZr2+mgKR9JbD3nxNeYckrnksVR7
         pnOzDoOrq3iHQIDRkvZ+zD6Nq4fwMiEaTQRTSjCyWcFPwCwCTrsm0pCrNk6WLm9/K1SA
         O6ag==
X-Gm-Message-State: AC+VfDy677E9te5OEI4uEfZYouuN22i8Thzi8O5wOSFlu9sESKhkdo5X
        2ixy9M7mqLDxH25cj9QBsxiFgw==
X-Google-Smtp-Source: ACHHUZ75wXd/QPqZRtaNQ+NzishUu9C0BDp22gA5MUVyvohW2Z2xI7CsaBCC+fmzj6LjNvOIBcMc1Q==
X-Received: by 2002:a17:907:7288:b0:961:ba7d:c5f4 with SMTP id dt8-20020a170907728800b00961ba7dc5f4mr1388892ejc.29.1683107415269;
        Wed, 03 May 2023 02:50:15 -0700 (PDT)
Received: from cloudflare.com (apn-31-0-32-7.dynamic.gprs.plus.pl. [31.0.32.7])
        by smtp.gmail.com with ESMTPSA id i25-20020a170906851900b0094f1b8901e1sm17126342ejx.68.2023.05.03.02.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:50:14 -0700 (PDT)
References: <20230502155159.305437-1-john.fastabend@gmail.com>
 <20230502155159.305437-4-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     daniel@iogearbox.net, lmb@isovalent.com, edumazet@google.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, will@isovalent.com
Subject: Re: [PATCH bpf v7 03/13] bpf: sockmap, reschedule is now done
 through backlog
Date:   Wed, 03 May 2023 11:49:57 +0200
In-reply-to: <20230502155159.305437-4-john.fastabend@gmail.com>
Message-ID: <87bkj13fsa.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 02, 2023 at 08:51 AM -07, John Fastabend wrote:
> Now that the backlog manages the reschedule() logic correctly we can drop
> the partial fix to reschedule from recvmsg hook.
>
> Rescheduling on recvmsg hook was added to address a corner case where we
> still had data in the backlog state but had nothing to kick it and
> reschedule the backlog worker to run and finish copying data out of the
> state. This had a couple limitations, first it required user space to
> kick it introducing an unnecessary EBUSY and retry. Second it only
> handled the ingress case and egress redirects would still be hung.
>
> With the correct fix, pushing the reschedule logic down to where the
> enomem error occurs we can drop this fix.
>
> Fixes: bec217197b412 ("skmsg: Schedule psock work if the cached skb exists on the psock")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
