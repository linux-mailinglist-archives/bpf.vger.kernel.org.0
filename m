Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAE562D7FF
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 11:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbiKQK2N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 05:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239379AbiKQK2J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 05:28:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C695528BF
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 02:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668680827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xlbf4XMXjAAtZtTfrsNX3coW79/AxwrRMideQvPGziY=;
        b=bET3uoQtbrsQK/yVauVZm41145LBFctSn3JtWB/o+SROC1V2yd1Nf9OAhoByMPxkPDTY7P
        COYFnQrbfkFObtKVCGVC0EwYMZPJTmlca6+ouke9og/S44CEqMnPpyOB8bU/G2dW2OFt6Y
        ol8t+09peNJKh+Qpc6F9CEUbJD/mz2g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-209-R1MMfDy3P3aoI6S9j5A32w-1; Thu, 17 Nov 2022 05:27:05 -0500
X-MC-Unique: R1MMfDy3P3aoI6S9j5A32w-1
Received: by mail-ej1-f71.google.com with SMTP id xj11-20020a170906db0b00b0077b6ecb23fcso882422ejb.5
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 02:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xlbf4XMXjAAtZtTfrsNX3coW79/AxwrRMideQvPGziY=;
        b=nsdBpGqm5Na3mfAPClLsRr40Snu94gwPyTB3wj7j2G5BAk+5Va2m9bMjapHPrBozmZ
         GJM1b9DYiFJenan45mwj/8ESX2arBwmoh8jzUSzoqh0zAqSrQQLzPXSfssvCG/yUbWwf
         Q0aYrYz1xRwm5Amrg+6qtK3Ia1HCAVgQj7a92FV6mD4MnAUunexCbK2UhOXmPYeVcdGd
         yIhLk1w9m9qktRPDvWylJWiQvZEg4aSX7kLEXxpl0klSlBhmPO39nyuMnk534mGnaWSx
         cwdDrrNI+JhLa8xYyVV3sV9sDjXvRZa0gvu0v6RHguZ99qvGDsheyv4vtWroH/IBaG68
         p20Q==
X-Gm-Message-State: ANoB5plj+PBuDKOKeOg39+8ktVE9c5d3JLnL5O9DGShEh7BNbAYBrf0p
        i0GqodGIPO/ieGvwRq8GlJfURFvUV439t15008DXxvrM3oVRANBIP83Si/7JU4pW0kdl0Hy4XWO
        yqpDpIgjurn9N
X-Received: by 2002:a17:906:254f:b0:7ac:d0ae:feba with SMTP id j15-20020a170906254f00b007acd0aefebamr1573822ejb.646.1668680824267;
        Thu, 17 Nov 2022 02:27:04 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7LIpp0Gv2shAYk1X+0qGt/Bbdy+J07gPYzUVDRuy1tpjEPTaB+4v//C8khZ3yBq2rJTWDoAw==
X-Received: by 2002:a17:906:254f:b0:7ac:d0ae:feba with SMTP id j15-20020a170906254f00b007acd0aefebamr1573792ejb.646.1668680823936;
        Thu, 17 Nov 2022 02:27:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d23-20020a056402001700b00461aca1c7b6sm351336edu.6.2022.11.17.02.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 02:27:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D11907A6F2C; Thu, 17 Nov 2022 11:27:01 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Subject: Re: [xdp-hints] Re: [PATCH bpf-next 05/11] veth: Support rx
 timestamp metadata for xdp
In-Reply-To: <637576962dada_8cd03208b0@john.notmuch>
References: <20221115030210.3159213-1-sdf@google.com>
 <20221115030210.3159213-6-sdf@google.com> <87h6z0i449.fsf@toke.dk>
 <CAKH8qBsEGD3L0XAVzVHcTW6k_RhEt74pfXrPLANuznSAJw7bEg@mail.gmail.com>
 <8735ajet05.fsf@toke.dk>
 <CAKH8qBsg4aoFuiajuXmRN3VPKYVJZ-Z5wGzBy9pH3pV5RKCDzQ@mail.gmail.com>
 <6374854883b22_5d64b208e3@john.notmuch>
 <34f89a95-a79e-751c-fdd2-93889420bf96@linux.dev> <878rkbjjnp.fsf@toke.dk>
 <6375340a6c284_66f16208aa@john.notmuch>
 <CAKH8qBs1rYXf0GGto9hPz-ELLZ9c692cFnKC9JLwAq5b7JRK-A@mail.gmail.com>
 <637576962dada_8cd03208b0@john.notmuch>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 17 Nov 2022 11:27:01 +0100
Message-ID: <87zgcp511m.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Just a separate comment on this bit:

John Fastabend <john.fastabend@gmail.com> writes:
> If you go with in-kernel BPF kfunc approach (vs user space side) I think
> you also need to add CO-RE to be friendly for driver developers? Otherwise
> they have to keep that read in sync with the descriptors?

CO-RE is for doing relocations of field offsets without having to
recompile. That's not really relevant for the kernel, that gets
recompiled whenever the layout changes. So the field offsets are just
kept in sync with offsetof(), like in Stanislav's RFCv2 where he had
this snippet:

+			/*	return ((struct sk_buff *)r5)->tstamp; */
+			BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_5,
+				    offsetof(struct sk_buff, tstamp)),

So I definitely don't think this is an argument against the kfunc
approach?

> Also need to handle versioning of descriptors where depending on
> specific options and firmware and chip being enabled the descriptor
> might be moving around.

This is exactly the kind of thing the driver is supposed to take care
of; it knows the hardware configuration and can pick the right
descriptor format. Either by just picking an entirely different kfunc
unroll depending on the config (if it's static), or by adding the right
checks to the unroll. You'd have to replicate all this logic in BPF
anyway, and while I'm not doubting *you* are capable of doing this, I
don't think we should be forcing every XDP developer to deal with all
this.

Or to put it another way, a proper hardware abstraction and high-quality
drivers is one of the main selling points of XDP over DPDK and other
kernel bypass solutions; we should not jettison this when enabling
metadata support!

-Toke

