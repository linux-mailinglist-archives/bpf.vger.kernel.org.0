Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0244F6D9FFB
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 20:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbjDFSi6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 14:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240243AbjDFSi5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 14:38:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C885BA9
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680806290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cL0xEv36os7K6igc2mQAflPTjWsCcGWjiQ4JpavLjnU=;
        b=Cr8tLDK55u7GUqpdvXiBhkvjbDO5OMjA5SMh3GQmkiH1pvjQ9WCa6xg0edmV6AeFgjDZXU
        Kbp2bC55KQ9Qd7QSUhasUlCVFCe2VCFmOEIhAQ+6b9umkctQo9OzqjYzCrUEbi07yrMkSM
        kc2irYiN8DCIWYvXs68yqoCBJ90Hpfc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-vMqSGRm6MtObFWHAlcBI4w-1; Thu, 06 Apr 2023 14:38:08 -0400
X-MC-Unique: vMqSGRm6MtObFWHAlcBI4w-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-50270e74786so759590a12.0
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 11:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680806287;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cL0xEv36os7K6igc2mQAflPTjWsCcGWjiQ4JpavLjnU=;
        b=EJ/bqKNcJAj0X+P0VoDj9DpLWLMdhZNDo3rHvf1z9ooDWtt3qyA5rpE/ErJKgtUnTG
         Hbd91G4zB21cfx4wU+Tz8RFkBrF6X5MUnMMKImnLWMIoaPLAnzW7m63nVfFDu/DpeG08
         UFe5TQ0tosWJT/hVp+rRkJ4zZnXWpw1iExmjFlvvdKBku8twQ7DOgWRONI3afb6aye1w
         Ag5gDY2n0NCAX9RqDlkMW2yF3OoK764u+ouYd833tRJ9UbgDQwbmjK42u1vkr0e9ucSJ
         Pt/DN5mTa5gihT7pq0eCkvo0qJL14uuwvcpDCQxm/PElx0IvHrT7KFCfjcH9M5fyKVR/
         RrlQ==
X-Gm-Message-State: AAQBX9fZtTxeRia7apIx1NHvTYtTSAhM7PsGI7kODfB0ojaMXPJyrKFE
        0eGm3+Y7Im9fJS1avHbknC/9ljRhlSWujy11qsBs/DkRYAfzhuR/fFByescmmMGUSLPMvisCg6T
        LZbS+ONRo9Yhz
X-Received: by 2002:a05:6402:70e:b0:4fc:535c:3aa1 with SMTP id w14-20020a056402070e00b004fc535c3aa1mr475744edx.10.1680806287233;
        Thu, 06 Apr 2023 11:38:07 -0700 (PDT)
X-Google-Smtp-Source: AKy350bn8KXU73iNBODtP7YbUGAxE1utUCnkQ8ktBabX2iMDmsXj0FzDJn95e86pszBxnyLCKIdpYQ==
X-Received: by 2002:a05:6402:70e:b0:4fc:535c:3aa1 with SMTP id w14-20020a056402070e00b004fc535c3aa1mr475715edx.10.1680806286873;
        Thu, 06 Apr 2023 11:38:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id x102-20020a50baef000000b004af73333d6esm1047561ede.53.2023.04.06.11.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 11:38:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3FD93A746CA; Thu,  6 Apr 2023 20:38:05 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kal Conley <kal.conley@dectris.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
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
Cc:     Kal Conley <kal.conley@dectris.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/3] xsk: Support UMEM chunk_size > PAGE_SIZE
In-Reply-To: <20230406130205.49996-2-kal.conley@dectris.com>
References: <20230406130205.49996-1-kal.conley@dectris.com>
 <20230406130205.49996-2-kal.conley@dectris.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 06 Apr 2023 20:38:05 +0200
Message-ID: <87sfdckgaa.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kal Conley <kal.conley@dectris.com> writes:

> Add core AF_XDP support for chunk sizes larger than PAGE_SIZE. This
> enables sending/receiving jumbo ethernet frames up to the theoretical
> maxiumum of 64 KiB. For chunk sizes > PAGE_SIZE, the UMEM is required
> to consist of HugeTLB VMAs (and be hugepage aligned). Initially, only
> SKB mode is usable pending future driver work.

Hmm, interesting. So how does this interact with XDP multibuf?

-Toke

