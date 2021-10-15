Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF0842F7A2
	for <lists+bpf@lfdr.de>; Fri, 15 Oct 2021 18:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbhJOQGD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Oct 2021 12:06:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29900 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236270AbhJOQGD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 Oct 2021 12:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634313836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dsDEKtYCRzpfGHfWuRln3LBcuvT/rlU9WF50B32EWSQ=;
        b=e4GX/OESvypgTn5BmIps4Jpqwi61GyOGWXCF2XKHVWUYNBrlJCfq9BB19FhtBrfmO8KYOG
        vahZ/TzuJZmzq22gYnFnbI6WbA0UtsRE23Al4klq/wj1qY288iDFlmNhFNkqR/0cztLGrQ
        oMkGaEFak7waDqtqxMVQyJ+ViB2EJi0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-1Er5WMLONp2LeFGV7HfcYA-1; Fri, 15 Oct 2021 12:03:53 -0400
X-MC-Unique: 1Er5WMLONp2LeFGV7HfcYA-1
Received: by mail-ed1-f69.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso8591507edj.20
        for <bpf@vger.kernel.org>; Fri, 15 Oct 2021 09:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dsDEKtYCRzpfGHfWuRln3LBcuvT/rlU9WF50B32EWSQ=;
        b=kuiw8TI/qV4Rowal24p/D1Dd9puSVmHXuiY+8fovPdbq8ZXAebgkRO56JK5Kkn9haA
         EEdKYCPMmcFCOG5ah9nYgiTUU62r4KSQ3ATs05ARu9cPmjm4UJT/gg1kCx5XHziOuUD5
         GG59ZosVxE5EgsVwgGk/50XA/UOQBiY+AP1YW73iyFgny/cy7FrK0KZazwoaeNodg9Ox
         NTLeIDFIBNnvtXgTRz9GzI6v1Vgixnsf3Sey31QFAnsXam59ocG2z3OegzWtht7Bf+5s
         j2pDptHcU7r5Ubqc3LS0tcinhFgVU6CDbUFfwZdGUmUkdHyo0RJQ1R5ibOu0AtAXSE5y
         /RlA==
X-Gm-Message-State: AOAM533pG7XMEKTfxtFE8myGKIOWjuQIt9KN0yeJz3+xQteACy2Ey5JY
        rzsahvDYb0pzrhhNLEheQn2i0H+XQisnW3KK9bE12BoZY+weZzTkRRptHq7ViUy5Vx3HUlN9/Nl
        zn8bJrCZUhHjl
X-Received: by 2002:a17:906:a382:: with SMTP id k2mr7572516ejz.454.1634313831268;
        Fri, 15 Oct 2021 09:03:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVpl3COZZa10m9FGGCOulI/IilZO1BZ1AmzpG9vXvqWXM/Vr6tYrv3GMPd7axLellHTaPsIw==
X-Received: by 2002:a17:906:a382:: with SMTP id k2mr7572303ejz.454.1634313829001;
        Fri, 15 Oct 2021 09:03:49 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i21sm4370071eja.50.2021.10.15.09.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:03:48 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DDB3218025F; Fri, 15 Oct 2021 18:03:47 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, shayagr@amazon.com,
        john.fastabend@gmail.com, dsahern@kernel.org, brouer@redhat.com,
        echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com
Subject: Re: [PATCH v16 bpf-next 09/20] bpf: introduce BPF_F_XDP_MB flag in
 prog_flags loading the ebpf program
In-Reply-To: <YWmCLlLelmG2ElyV@lore-desk>
References: <cover.1634301224.git.lorenzo@kernel.org>
 <0a48666cfb23d1ceef8d529506e7ad2da90079de.1634301224.git.lorenzo@kernel.org>
 <87y26uzalk.fsf@toke.dk> <YWmCLlLelmG2ElyV@lore-desk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 15 Oct 2021 18:03:47 +0200
Message-ID: <87lf2uz34s.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> 
>> > Introduce BPF_F_XDP_MB and the related field in bpf_prog_aux in order to
>> > notify the driver the loaded program support xdp multi-buffer.
>> 
>> We should also add some restrictions in the BPF core. In particular,
>> tail call, cpumap and devmap maps should not be able to mix multi-buf
>> and non-multibuf programs.
>
> ack. How can we detect if a cpumap or a devmap is running in XDP multi-buff
> mode in order to reject loading the legacy XDP program?

I was hoping we could copy the same mechanism that tail call maps to
ensure that callers and callees are the same type. And amend that to
also consider the xdp_mb flag while we're at it :)

> Should we just discard the XDP multi-buff in this case?

If I'm right in the above, we won't have to because the verifier can
ensure that the program types match...

-Toke

