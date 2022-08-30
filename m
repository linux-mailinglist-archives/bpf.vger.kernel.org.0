Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55475A6482
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 15:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiH3NRi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 09:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiH3NRg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 09:17:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5409D21D5
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 06:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661865454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tLji9PqzACdoD0jhQqAERUm3wAY5ioYdj8s6bxIG4ac=;
        b=g3EBiyBDbsySJII/VffEff3hPi5BL5A8tuR06SkuNVVZtz0+gwQyIy/q0d2iWf9nsIKJvd
        WdRtf8BkruDJ8Ec9FeNlU9wATZa1mObikn9psAvURbYQYOzW12/yKdAWtmvtXK7Ma0EV/W
        rrX4Qn/pw8ih7rlws+XVtuLJqqeOYKs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-175-LGkhs8Q2MNWAqtXmL_mbRQ-1; Tue, 30 Aug 2022 09:17:32 -0400
X-MC-Unique: LGkhs8Q2MNWAqtXmL_mbRQ-1
Received: by mail-ej1-f72.google.com with SMTP id xh12-20020a170906da8c00b007413144e87fso3777435ejb.14
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 06:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:to:content-language:cc:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc;
        bh=tLji9PqzACdoD0jhQqAERUm3wAY5ioYdj8s6bxIG4ac=;
        b=WBCcwvVL8Xrk6tSmU8sJGUxKN+L0j3OZdgoLOUz07qVQf2QcCRDv7HArr9X/oP401E
         FQnGsHaGgHQ6y675J4YS7/lsXNYPN7IXV5pFTNQXYuyPN+1iB2EvpFgbuuHWkpLPNPca
         0fbLFgQfGS/5bQGJ4lmF813lqrEdVvMFadri4Bv+TVHlrEsi99CT77kggUZ7A9mJ0abV
         HGHQEXy1YdDO+xxwJbsz/QPWUh+fO9++Dw1hg/Qx/553vlGLuhbEGwyQgLVnO3Kjxmq7
         zZZIFcDnNx/rH+K1Xvy50i33LqP9SEa7faAqCkl4+4Jtt/ieHrG94e+lmHWyjpQpDeXl
         5ZXg==
X-Gm-Message-State: ACgBeo0sja7gCyPHdRbPYeMtzzSiNMn5XhIVcGOE2C6os4hn7quAvXFA
        nrclkYOLERPjkYCBvcovSvu+jLF97NdLHj+SsY7U6n1FbjViz/MTPAWaL2b6KAGAl3KKW5TIuA9
        BVYRLAaUHrphN
X-Received: by 2002:a17:907:1614:b0:73d:7c02:e090 with SMTP id hb20-20020a170907161400b0073d7c02e090mr17228619ejc.166.1661865451552;
        Tue, 30 Aug 2022 06:17:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5Kv7/jefJEzid56UIrzGzNQG32b3nmEL9ieXpBa/TWbfIb++L0caNkhGQA9IfW0DiwDNf40w==
X-Received: by 2002:a17:907:1614:b0:73d:7c02:e090 with SMTP id hb20-20020a170907161400b0073d7c02e090mr17228600ejc.166.1661865451301;
        Tue, 30 Aug 2022 06:17:31 -0700 (PDT)
Received: from [192.168.41.81] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id lo5-20020a170906fa0500b0073cf8e0355fsm5704754ejb.208.2022.08.30.06.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 06:17:30 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <2c7c8f91-a430-719c-5ef7-174cafa6c0be@redhat.com>
Date:   Tue, 30 Aug 2022 15:17:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Cc:     brouer@redhat.com, Zaremba Larysa <larysa.zaremba@intel.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>
Subject: How to extract BTF object ID from kernel module?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

When opening a modules BTF file (e.g. /sys/kernel/btf/i40e), can I
somehow get the kernels BTF object ID value (via that FD)?

I think I want the BTF object IDs as displayed by 'btftool btf'.
That code walks all IDs via bpf_btf_get_next_id() and then gets the FD
via bpf_btf_get_fd_by_id().  I'm looking for a more direct way than
having to walk all IDs...

(p.s. Cc. Larysa, I also looked at your code, which like bpftool end-up
walking all BTF IDs and extends libbpf with internal btf_obj_id to keep
track).

--Jesper

