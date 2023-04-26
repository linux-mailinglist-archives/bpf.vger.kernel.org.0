Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520A96EF291
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 12:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240263AbjDZKsJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 06:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240059AbjDZKrv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 06:47:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34960211B
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 03:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682506022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q7eSG1klkAdyLEaNU1h7MS+MxhJ0DOqewp5Z8jQS+rk=;
        b=F1NAXP23RESFvqE515uSZfCqvlrPgo6WHQ+LKn1Vx/rnL7gR9IbT3buydMNvkKdBLW/qkN
        QrT/X5PpP0KK5j+IdmKII2hWNa6BhdlSgQAIjnv/e41DJjJrMFbfrbcWd8Sirrv2uggk4P
        K0ViDOY0f3sTZ1psLVSnbVEebn8CllE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-fZyjQ4SzPQKHYdDFx92TyQ-1; Wed, 26 Apr 2023 06:47:01 -0400
X-MC-Unique: fZyjQ4SzPQKHYdDFx92TyQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-506a4c0af47so6512766a12.1
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 03:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682506020; x=1685098020;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7eSG1klkAdyLEaNU1h7MS+MxhJ0DOqewp5Z8jQS+rk=;
        b=SdpFF3Pe3UbDKF1scjBh3WGav0ehhFgHDrtkgJmMQ2DuZ1f02JarokJhthETd3nLNH
         FYP2menmOfUoeTGBH6yrzz+uAfgdrgSqxuMkGe+9cTYMdCI284GPtyr0lTB7EI8FfB7q
         1LrH9TZx1ohi7FGTCsHRJ3muIntizRAylrVLbN7M6/0WS4uUYiKE5n4OYL3b6eXyEpNi
         uKJJ6c36JyMGAHvbTmTHmzmrOvCAplNQIao/AZdXWj7CPMLFKzPY1uJbZ2SYMcMjOmKj
         lPG7XD39jJX4bo1MujEfMaYlMucRIuk0T4U0kD2OxrbP/ZbOj2aAGrZjHFBo4tDpBtTD
         aYXw==
X-Gm-Message-State: AAQBX9fpM3nPfZ8gywYU9hIs8GbGQemKo4vN8rN3Xry8I0LPFWyFakzE
        isqcrf8clPanv7ptYiOgof5ozyGe9WgRrVkpskGGe8VoSW/s/MrYU0CpxTiO7hUewp8EzYs8wvA
        8k8IBCiwBsaY5
X-Received: by 2002:a17:906:a84c:b0:947:c8d5:fb2a with SMTP id dx12-20020a170906a84c00b00947c8d5fb2amr17287732ejb.48.1682506019820;
        Wed, 26 Apr 2023 03:46:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350bueCmxCjDSmFglv2TB/hZ+jA43sk3LCYfVFX9cQwRdfdOgUzEC5j8gS5n5MB/sN1wMbcmEvQ==
X-Received: by 2002:a17:906:a84c:b0:947:c8d5:fb2a with SMTP id dx12-20020a170906a84c00b00947c8d5fb2amr17287691ejb.48.1682506019416;
        Wed, 26 Apr 2023 03:46:59 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id lb16-20020a170907785000b0094ee700d8e4sm7946826ejc.44.2023.04.26.03.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 03:46:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 44A81AAA41C; Wed, 26 Apr 2023 12:46:58 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kal Conley <kal.conley@dectris.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Kal Conley <kal.conley@dectris.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v6 2/4] xsk: Support UMEM chunk_size > PAGE_SIZE
In-Reply-To: <20230412162114.19389-3-kal.conley@dectris.com>
References: <20230412162114.19389-1-kal.conley@dectris.com>
 <20230412162114.19389-3-kal.conley@dectris.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 26 Apr 2023 12:46:58 +0200
Message-ID: <87v8hij4yl.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kal Conley <kal.conley@dectris.com> writes:

> Add core AF_XDP support for chunk sizes larger than PAGE_SIZE. This
> enables sending/receiving jumbo ethernet frames up to the theoretical
> maximum of 64 KiB. For chunk sizes > PAGE_SIZE, the UMEM is required
> to consist of HugeTLB VMAs (and be hugepage aligned). Initially, only
> SKB mode is usable pending future driver work.

So I still really don't understand why this is useful without the driver
support, and I think it's premature to merge it before that is present.
It also seems you didn't address any of the issues we discussed back on
v3, but instead just reposted (and didn't even Cc me, so I missed that
until now).

So, FWIW, consider this my:

Nacked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

