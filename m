Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7514F6C3A4F
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 20:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCUTWL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 15:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCUTWK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 15:22:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420062139
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 12:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679426463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rB+PzEgnKkqk2k+vvj3p24uGcCixq7dziCTji95CjO8=;
        b=XS8pv2hoWt4VEFyWFTzbz7fXVDfnXAY7+8q+kZGg5X9/mczqzen1RdNQi9io57LNlyD7eK
        yG8bhcG1T7Sik4syB98KTicoO43FecCVOBzmB71NlSVr5X5+sQ+d9LlRnGr7GZcdlNuMml
        GSbw/WncyM+5+j09+BoqfMf4iRVPMW0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-Hdd_rr3kMEaIik2L97x0KQ-1; Tue, 21 Mar 2023 15:20:59 -0400
X-MC-Unique: Hdd_rr3kMEaIik2L97x0KQ-1
Received: by mail-ed1-f69.google.com with SMTP id ev6-20020a056402540600b004bc2358ac04so23718438edb.21
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 12:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679426459;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rB+PzEgnKkqk2k+vvj3p24uGcCixq7dziCTji95CjO8=;
        b=fx+BFshXq4PkLWDJP6tzf4lbqk3qKxKXcyvQm325d7E7i1dM53qK77+RpEV2318p5d
         Y8wZavHbSBBoR08R3+BbRG2pZo2t8IuT3orswo6gvZDkGFfmN8JAHTRY5g6q+hGtxpNp
         yDDhisIfY9Y6ir8ST0pEK6bmQoCTFLn45pEwHWzjzHMvj1tzTVBb5eIDPxHa4mcG5OoP
         EO+g3aTRr59ersnnNTi6IFnerMmBwjkuDNK/ap3lcP/afym+y8GKdlL1tAf1UbgREkmG
         QGXnT8y5TkVgeVrPlnBAcGohd3pa80UHEaZ/mMlmHaUI9fTqD3e7TLwjAtvFpL8r9A4w
         +vlw==
X-Gm-Message-State: AO0yUKWAdmA/h5vpJKE31FcOU8aV0fNaFQpuOeS/4mIXRyUZtUJJR6uV
        T9gxaQPFV7PK8oIIA3q+Ll07qYstrXw/DW0Xh3vo4ZMkPdBEKP5njLDMPcXkiUkamFHJxU9FZ2J
        BK7enTiQwM6F9
X-Received: by 2002:a17:906:fad5:b0:931:5630:a23 with SMTP id lu21-20020a170906fad500b0093156300a23mr3658975ejb.50.1679426458390;
        Tue, 21 Mar 2023 12:20:58 -0700 (PDT)
X-Google-Smtp-Source: AK7set9PAjldqIVfgFwiw/sf3tp8nVNBWfUz5CMSnpL+CdmdP5wxKPXBBH2ukPUBvKl8JW297p5lsg==
X-Received: by 2002:a17:906:fad5:b0:931:5630:a23 with SMTP id lu21-20020a170906fad500b0093156300a23mr3658943ejb.50.1679426457816;
        Tue, 21 Mar 2023 12:20:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id b17-20020a17090630d100b009300424a2fdsm6180946ejb.144.2023.03.21.12.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:20:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D24AC9E34C5; Tue, 21 Mar 2023 20:20:56 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>, bpf@vger.kernel.org
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        Stanislav Fomichev <sdf@google.com>, martin.lau@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, alexandr.lobakin@intel.com,
        larysa.zaremba@intel.com, xdp-hints@xdp-project.net,
        anthony.l.nguyen@intel.com, yoong.siang.song@intel.com,
        boon.leong.ong@intel.com, intel-wired-lan@lists.osuosl.org,
        pabeni@redhat.com, jesse.brandeburg@intel.com, kuba@kernel.org,
        edumazet@google.com, john.fastabend@gmail.com, hawk@kernel.org,
        davem@davemloft.net
Subject: Re: [xdp-hints] [PATCH bpf V2] xdp: bpf_xdp_metadata use EOPNOTSUPP
 for no driver support
In-Reply-To: <167940675120.2718408.8176058626864184420.stgit@firesoul>
References: <167940675120.2718408.8176058626864184420.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 21 Mar 2023 20:20:56 +0100
Message-ID: <87ttyd7vxj.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> When driver doesn't implement a bpf_xdp_metadata kfunc the fallback
> implementation returns EOPNOTSUPP, which indicate device driver doesn't
> implement this kfunc.
>
> Currently many drivers also return EOPNOTSUPP when the hint isn't
> available, which is ambiguous from an API point of view. Instead
> change drivers to return ENODATA in these cases.
>
> There can be natural cases why a driver doesn't provide any hardware
> info for a specific hint, even on a frame to frame basis (e.g. PTP).
> Lets keep these cases as separate return codes.
>
> When describing the return values, adjust the function kernel-doc layout
> to get proper rendering for the return values.
>
> Fixes: ab46182d0dcb ("net/mlx4_en: Support RX XDP metadata")
> Fixes: bc8d405b1ba9 ("net/mlx5e: Support RX XDP metadata")
> Fixes: 306531f0249f ("veth: Support RX XDP metadata")
> Fixes: 3d76a4d3d4e5 ("bpf: XDP metadata RX kfuncs")
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

