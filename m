Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB7E6E0BD9
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 12:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjDMKvs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 06:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDMKvr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 06:51:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3341BC1
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 03:51:37 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50672fbf83eso1532340a12.0
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 03:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1681383096; x=1683975096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RxeMOwbpGENb+weUS3Q3c1MqA2boB5pRuOKSrr+VKMA=;
        b=olAgFLXV5pQj078BxZmSCdSLqKQ8QJvL1YxmQNcD4ubNdFmVEZtp0Tj+74ZMtWMOcI
         DE+D3UQfYz/CR4E02hxL+0SMwxIGuIjRO1xaMbbjRWm4tXfmZNgoQWlWlrPAoPHccj6O
         VWdvaFir8HjPgBX+IRWFrxCNRDsXY7R42iz1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681383096; x=1683975096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxeMOwbpGENb+weUS3Q3c1MqA2boB5pRuOKSrr+VKMA=;
        b=GS10ago7KDZBhk67L1HzFq21WGYacQK43k89HdORjXHJN6iBYztfu+kxyGJjvyv9zP
         npnj8QUXjJB7i4wpWX60rjvgmBRf1iIi4zEYhYY1LoHGZi4sG6vkE+RZAVL9L6uaXGV5
         gXva80C3l021slu8uodBvLrSOh3SZ3gwdxnnucKl27uh0TUN1wXYo2qQ9SCF31/USMhK
         Op/ZqW0a0P3VBfWw/nSWBOcUPkSbH351DQLRP0uiQNcONXYI8Td4LjiArZQUfsXVEy9J
         bivSJTdLld3AqIbmgtoC/vYdLgiTENfiPtf1+6eXOni8Rcxaa1C/PEQCQTKcyEhFAD2u
         0q/A==
X-Gm-Message-State: AAQBX9cHQaJtLrOp0IZIzvX5gOt9/yGSsLDKbCPg/GV3PVWuQfrAYahx
        oVHbSk88qM3n+wS8OdmfcXHRsBXK0+T/voLsuo19ow==
X-Google-Smtp-Source: AKy350aJVHJsIM/7Cw5RRVLHjyYZYMjj/wfkGRiEzVOfWIvLI+ptJr0GOC68cQM7cPhDCwcJUYGEhLI0zZpYDF8aKKM=
X-Received: by 2002:a50:bb25:0:b0:502:7551:86c7 with SMTP id
 y34-20020a50bb25000000b00502755186c7mr738815ede.4.1681383096281; Thu, 13 Apr
 2023 03:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230406130205.49996-1-kal.conley@dectris.com>
 <20230406130205.49996-2-kal.conley@dectris.com> <87sfdckgaa.fsf@toke.dk>
 <ZDBEng1KEEG5lOA6@boxer> <CAHApi-nuD7iSY7fGPeMYiNf8YX3dG27tJx1=n8b_i=ZQdZGZbw@mail.gmail.com>
 <875ya12phx.fsf@toke.dk>
In-Reply-To: <875ya12phx.fsf@toke.dk>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Thu, 13 Apr 2023 12:56:20 +0200
Message-ID: <CAHApi-=rMHt7uR8Sw1Vw+MHDrtkyt=jSvTvwz8XKV7SEb01CmQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] xsk: Support UMEM chunk_size > PAGE_SIZE
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>
> Well, I'm mostly concerned with having two different operation and
> configuration modes for the same thing. We'll probably need to support
> multibuf for AF_XDP anyway for the non-ZC path, which means we'll need
> to create a UAPI for that in any case. And having two APIs is just going
> to be more complexity to handle at both the documentation and
> maintenance level.

I don't know if I would call this another "API". This patchset doesn't
change the semantics of anything. It only lifts the chunk size
restriction when hugepages are used. Furthermore, the changes here are
quite small and easy to understand. The four sentences added to the
documentation shouldn't be too concerning either. :-)

In 30 years when everyone finally migrates to page sizes >= 64K the
maintenance burden will drop to zero. Knock wood. :-)

>
> It *might* be worth it to do this if the performance benefit is really
> compelling, but, well, you'd need to implement both and compare directly
> to know that for sure :)

What about use-cases that require incoming packet data to be
contiguous? Without larger chunk sizes, the user is forced to allocate
extra space per packet and copy the data. This defeats the purpose of
ZC.
