Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2A353F9D8
	for <lists+bpf@lfdr.de>; Tue,  7 Jun 2022 11:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239593AbiFGJcF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jun 2022 05:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239549AbiFGJcE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jun 2022 05:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2EFC527CF
        for <bpf@vger.kernel.org>; Tue,  7 Jun 2022 02:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654594321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mor27Ix7CQqr7sI/B/SXdxQjG+ZwvZDcW+NUbHg0Jjo=;
        b=MKT+JtjmxB/1E/WQFetJhQeQ+C+mmPTpq3gB51YIHogTNd8huoDwcGCb4J9XcW5JucBy8V
        PGDUusZlnbDSdaQzCgVw+zl640Xd6oGYwhM3TOlTRdB0XpaZ9qNwt8iDRebJVtf9hxnC0c
        OPR8/rZXlPDH361VuSsZ7EKJfWWsc5A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-1D11-Cy-OdyjZVIyYVrQcg-1; Tue, 07 Jun 2022 05:32:00 -0400
X-MC-Unique: 1D11-Cy-OdyjZVIyYVrQcg-1
Received: by mail-ed1-f69.google.com with SMTP id t14-20020a056402020e00b0042bd6f4467cso12209454edv.9
        for <bpf@vger.kernel.org>; Tue, 07 Jun 2022 02:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Mor27Ix7CQqr7sI/B/SXdxQjG+ZwvZDcW+NUbHg0Jjo=;
        b=ClR0POSY4GdMO+qAnxokZjHq07Tuu8iGtQaBxk93rXQJ4S0NwzR0d6IxseuquziYVN
         G8qGX9m0E+RjQF25fwuWFCphJXDVPdy93BRf+F563Ja/GRKwgd8eP5N15AzLhJs8dgxz
         IjIWK3AMm3MzjYb4ijC67S9JSu+1p08KuzoioNgNWq+cEI1CqQtpHVLWYl7xPUBlu8bW
         s5U1a4G1NsE7TozhVbUph/oRR86rpbYBL/FEC5Uv3eHebUvY/7yuBBFMKZRo3c7gbGi6
         4UCdAwlDjDjk4VGaFEqSAVMG7MsGUo2MB0zm6Q/V/StvZY1C/Of/pYS1jHFuJ7QUFpDR
         cJ+g==
X-Gm-Message-State: AOAM532lFEgyHmtMuovo6eAY0Woyo9hblfrtXXzy6/2FAm+gvGDnlJ6R
        YH50khOJd0pDZJKChEegeabTi/RsfT19IdXidBVlN5YiyqVuGPPjCAjoD1MLbWU5pBgCjG8lqPc
        PdSiVoJfed/Co
X-Received: by 2002:aa7:c990:0:b0:42d:e15f:e65a with SMTP id c16-20020aa7c990000000b0042de15fe65amr32037725edt.221.1654594319549;
        Tue, 07 Jun 2022 02:31:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfz9PcPtSYJP1adAl+dThoDwwJAIwHOMATjjRDp0srpiZ1m/lui3BHTufUZOEZV+kiLln97w==
X-Received: by 2002:aa7:c990:0:b0:42d:e15f:e65a with SMTP id c16-20020aa7c990000000b0042de15fe65amr32037688edt.221.1654594319229;
        Tue, 07 Jun 2022 02:31:59 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id b8-20020aa7c6c8000000b0042617ba637bsm10305431eds.5.2022.06.07.02.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:31:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0712940566C; Tue,  7 Jun 2022 11:31:58 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
        Hangbin Liu <liuhangbin@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next 0/3] move AF_XDP APIs to libxdp
In-Reply-To: <20220607084003.898387-1-liuhangbin@gmail.com>
References: <20220607084003.898387-1-liuhangbin@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 07 Jun 2022 11:31:57 +0200
Message-ID: <87tu8w6cqa.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hangbin Liu <liuhangbin@gmail.com> writes:

> libbpf APIs for AF_XDP are deprecated starting from v0.7.
> Let's move to libxdp.
>
> The first patch removed the usage of bpf_prog_load_xattr(). As we
> will remove the GCC diagnostic declaration in later patches.

Kartikeya started working on moving some of the XDP-related samples into
the xdp-tools repo[0]; maybe it's better to just include these AF_XDP
programs into that instead of adding a build-dep on libxdp to the kernel
samples?

-Toke

[0] https://github.com/xdp-project/xdp-tools/pull/158

