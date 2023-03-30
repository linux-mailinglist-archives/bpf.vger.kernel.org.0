Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030266D0EB4
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 21:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjC3TZO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 15:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjC3TZG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 15:25:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374A4EC4D
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 12:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680204254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HBqpSW6QK4EA+LClEvnqsikCHd1YVrQiiftMR2XV5Rc=;
        b=CXeQaZnnJus+YpVIjfyzfmyvnzSdWS4iQ0U+28GIZqN9yNSYb+gOCfztXf4NSxPWAz5c4J
        HAeJx+BwbhnHdei2LdEH2wwp4Ei8TmwfC4zvb6pZNFVEvtOSDwAJkCI5DvYxrKvLc/ATEF
        TlvQzAe0cbTO2tLUJIluSA7cEdvvE/Y=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-C9A0rL4gMfyhadfE0LrR6A-1; Thu, 30 Mar 2023 15:24:13 -0400
X-MC-Unique: C9A0rL4gMfyhadfE0LrR6A-1
Received: by mail-ed1-f72.google.com with SMTP id c11-20020a509f8b000000b00501e2facf47so28613964edf.16
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 12:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680204252;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBqpSW6QK4EA+LClEvnqsikCHd1YVrQiiftMR2XV5Rc=;
        b=GriTxIe1vYrrJ1JlRHLDzMYoEr0jTc2a76LuW6pl9tgouX7DfL9f4TzvKnJuEMcm+c
         BFCcTBcQMcDqP6LromPVWTCcO/+DK81g0uupyjCO7UFmEXOTcVuZCtNSt32NQJs3o1AT
         OBbMS42nkm0Scr4L3GWjnpLOC75f7R4A/eiNGsKdLMvVCkiLP13y0//xL+zsmlTGo0LD
         aIT/tv5CYvjpN5RDXW+Qdte5wd5HsaEZCRlcAAeS8Bqqh/VTLh7OroWosRcaxJzzgHbL
         rpJKyY6/eoerlZY4f+8No4/3IDgVsK5fFTjN47KhyjP7DLVVDyz2uD0aYdoA5XMIl5pd
         GIqw==
X-Gm-Message-State: AAQBX9dSw9Bz+1qsfOGgndJ8ZgxKIOW+IzH/BC5YSQI+rDTWm213KrN2
        aTCvBOKnEHt7SCQMAGNmA3+iXFukcAbuKQToBaWhKAT22OURzJuldLqhPdFZTZCFYe42uNWRRFD
        dASwlPX+jjJGT
X-Received: by 2002:a17:906:f29a:b0:933:816c:abb9 with SMTP id gu26-20020a170906f29a00b00933816cabb9mr6510527ejb.36.1680204251869;
        Thu, 30 Mar 2023 12:24:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350YRFH6WV6KD6S27b8VZNNgwBJYd+z/cdioM+cIk73QZtr3NowyOAQvVk7LllNJraDEBULrnPQ==
X-Received: by 2002:a17:906:f29a:b0:933:816c:abb9 with SMTP id gu26-20020a170906f29a00b00933816cabb9mr6510517ejb.36.1680204251499;
        Thu, 30 Mar 2023 12:24:11 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id h27-20020a50cddb000000b004c19f1891fasm264876edj.59.2023.03.30.12.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 12:24:10 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 38E96A22D4A; Thu, 30 Mar 2023 21:24:10 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>, bpf@vger.kernel.org,
        Stanislav Fomichev <sdf@google.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, alexandr.lobakin@intel.com,
        larysa.zaremba@intel.com, xdp-hints@xdp-project.net,
        anthony.l.nguyen@intel.com, yoong.siang.song@intel.com,
        boon.leong.ong@intel.com, intel-wired-lan@lists.osuosl.org,
        pabeni@redhat.com, jesse.brandeburg@intel.com, kuba@kernel.org,
        edumazet@google.com, john.fastabend@gmail.com, hawk@kernel.org,
        davem@davemloft.net
Subject: Re: [xdp-hints] [PATCH bpf RFC-V3 0/5] XDP-hints: API change for
 RX-hash kfunc bpf_xdp_metadata_rx_hash
In-Reply-To: <168019602958.3557870.9960387532660882277.stgit@firesoul>
References: <168019602958.3557870.9960387532660882277.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 30 Mar 2023 21:24:10 +0200
Message-ID: <87o7oam49x.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> Notice targeted 6.3-rc kernel via bpf git tree.
>
> Current API for bpf_xdp_metadata_rx_hash() returns the raw RSS hash value,
> but doesn't provide information on the RSS hash type (part of 6.3-rc).
>
> This patchset proposal is to change the function call signature via adding
> a pointer value argument for provide the RSS hash type.
>
> Alternatively we disable bpf_xdp_metadata_rx_hash() in 6.3-rc, and have
> more time to nitpick the RSS hash-type bits.

LGTM; for the series:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

