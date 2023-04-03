Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD986D44BD
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 14:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjDCMp7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 08:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjDCMp6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 08:45:58 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584266A7F
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 05:45:56 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cn12so116861781edb.4
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 05:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680525954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=riaahXQBertKmx+xq8cDyjwCTBDh/mDGE8BYFdxvDOM=;
        b=AeSvW6k+w78JQQFr9P84dSFQCVc5yWUTGPRgEnDHdFwlVw9CYaiBmcDl62NmVB2m+P
         q+wT/xqMJAOOqGvy4SL9Dnl6o8rkx79ToJ8CGJwSjyLEDHJwnID7BQmCiq3QOUFdDqu2
         dO8LrYKTbRXrjZiyz6EIV2UCzBJDpu3oCb9pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680525954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riaahXQBertKmx+xq8cDyjwCTBDh/mDGE8BYFdxvDOM=;
        b=lIFAHZDaUx7mQ4KcDWUgvdyyqc/f23t+glKZxPCRjZj3oaDohWxHxRzw/XgDNXEakt
         gvx73vdgCzVruux3aDtb6Z9YRmUEUQxUXyBLkJGGqGA8X2NYB8VAhlIpTBUQ8Y4okDTk
         PyAv5lKg+6rQ/xhSNk+NU213P9YTzF1WqtEfQ05xBBKSdv9ETjGv1Uc+b3yHbfBdd7GY
         +5+JQSR3XUUgUDX4JQ7GyKGRU6zNCT4ptfVZ5192uE6G0QzV9nOdrYfFZf7aDB3FC3gx
         q8W37QsuiTLq1HRcJtfTnUqYcrZvWZTTcK3AELOKnqp5vgEGGdW+g4o6GNk5qjXakKI+
         +GMw==
X-Gm-Message-State: AAQBX9cZbgl/Idjfom7XHKeoc/tJ4cMGNM4kQFkQ8HW1bCBr2R6MbDVO
        UX+O4PhjPkFBZVBh4WTCiEJn0piyQcluigk81M1Fdg==
X-Google-Smtp-Source: AKy350aP1ukG9/ndrpQD+GGShI9OQ5v16FM6kUzhb3kdhVgjodsHmgZPsLsStm33czUEzkZ7t/sTNPgmYme8DnWkACI=
X-Received: by 2002:a50:cd47:0:b0:4fc:532e:215d with SMTP id
 d7-20020a50cd47000000b004fc532e215dmr18039003edj.6.1680525954661; Mon, 03 Apr
 2023 05:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230329180502.1884307-1-kal.conley@dectris.com>
 <20230329180502.1884307-7-kal.conley@dectris.com> <CAJ8uoz0a3gJgWDxP0zPLsiWzUZHmGqRbrumdRq2Gv1HdVm4ObQ@mail.gmail.com>
In-Reply-To: <CAJ8uoz0a3gJgWDxP0zPLsiWzUZHmGqRbrumdRq2Gv1HdVm4ObQ@mail.gmail.com>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Mon, 3 Apr 2023 14:50:34 +0200
Message-ID: <CAHApi-mCm1hWyc1jfB3isPqWqaJUuqn7vN1hfSgPb741ngJK9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 06/10] xsk: Add check for unaligned
 descriptors that overrun UMEM
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>
> Let me just check that I understand the conditions under which this
> occurs. When selecting unaligned mode, there is no check that the size
> is divisible by the chunk_size as is the case in aligned mode. So we
> can register a umem that is for example 15 4K pages plus 100 bytes and
> in this case the second to last page will be marked as contiguous
> (with the CONTIG_MASK) and a packet of length 300 starting at 15*4K -
> 100 will be marked as valid even though it extends 100 bytes outside
> the umem which ends at 15*4K + 100. Did I get this correctly? If so,
> some more color in the commit message would be highly appreciated.

Yes. You don't even need to cross the page. For example, if you have a
packet length of 300 _within_ the final page then it could go past the
end of the umem. In this case, the CONTIG_MASK would not even be
looked at. The explanation is in the next commit message with the
test. I will improve the commit message here though.
