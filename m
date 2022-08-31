Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F7F5A8433
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 19:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiHaRXI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 13:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiHaRXH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 13:23:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E90D2E9B
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661966577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Qw1UhrKTnM4IdzxlTeskNvNIVZa+aLSFhW+Yw0Wjd8=;
        b=RHLtz9eDKNNqLAPcwAks5dKDuaf7qkQHXpz9UmuLk0ssZFK007yvUUwBlrxt0RMxCXUjQX
        fKJC4Zu8byJa6teNTTXYHBMhnTAsxafOtyUP0DscxG4SA1+zlbunrFbTNNZm47CoXQ98fE
        X7l+3ZHaV4wFkpQzvKrEq8AbljMOMfw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-607-kVFoMo2hPyKOegSgh3TrWw-1; Wed, 31 Aug 2022 13:22:56 -0400
X-MC-Unique: kVFoMo2hPyKOegSgh3TrWw-1
Received: by mail-lf1-f72.google.com with SMTP id p8-20020a056512234800b0048b12cb7738so3863924lfu.6
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 10:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=6Qw1UhrKTnM4IdzxlTeskNvNIVZa+aLSFhW+Yw0Wjd8=;
        b=S8Aj/7gzrLN17FGbBgF/NclxpZSZfnR3GFZl7AYcKF/kycFEJFeXxQryapRx81xAIW
         Vrfo8PML028xjorvXPDpMoaRgek9JhDFfLnX752ZG9RyZK2glef2jKIaPeqaCAmlg5VR
         MaakTkOeOeqt5Fxf/mqftVHDBUvmVQmTYFCE3eRYUtyY6mZL3JFTC4dYGvCTUcb9N71h
         ddLXpAJMlEj2Tl7XKhSUGFhPRqtYpx9yoDJ1KS/L0ZPqf82YeGe1pjEfFWBlfLNrS6ts
         SF9djpBbfP8tzgr+QOVQWWJwNVmbXnOTdPkIAPqkr+dyaH9dFsehYO6RV+f+7CFAYPe+
         Th+w==
X-Gm-Message-State: ACgBeo1u/aK8lWW/VqLc9FkIJhpFJGrnAVi+w7u2+XQiEnP3EF9N4U5V
        tyx5RpsOvSmS7PYLcI16EWFGzbn9KL9A77wwc/cgIFO4uG2Hd6t8+GNLqXRKGEKCjK9aGS6TGQw
        qmh2zqkovprHS
X-Received: by 2002:a05:6512:3e1:b0:494:64c5:5b52 with SMTP id n1-20020a05651203e100b0049464c55b52mr5688422lfq.420.1661966574592;
        Wed, 31 Aug 2022 10:22:54 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5pnc7eYXnsTgthRG+lXb2BFtSmELH7WJHDEqWOcYHqTehuH0QM5gO8YYZQmy7Fvnp6lzUgNA==
X-Received: by 2002:a05:6512:3e1:b0:494:64c5:5b52 with SMTP id n1-20020a05651203e100b0049464c55b52mr5688413lfq.420.1661966574395;
        Wed, 31 Aug 2022 10:22:54 -0700 (PDT)
Received: from [192.168.41.81] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id q18-20020a2eb4b2000000b00265757e0e66sm1190814ljm.48.2022.08.31.10.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 10:22:53 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <f5c47d95-5ff4-3b5b-98db-c69fbf6538b5@redhat.com>
Date:   Wed, 31 Aug 2022 19:22:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Cc:     brouer@redhat.com, Zaremba Larysa <larysa.zaremba@intel.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        Netdev <netdev@vger.kernel.org>
Subject: Re: How to extract BTF object ID from kernel module?
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
References: <2c7c8f91-a430-719c-5ef7-174cafa6c0be@redhat.com>
In-Reply-To: <2c7c8f91-a430-719c-5ef7-174cafa6c0be@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 30/08/2022 15.17, Jesper Dangaard Brouer wrote:
> Hi Andrii,
> 
> When opening a modules BTF file (e.g. /sys/kernel/btf/i40e), can I
> somehow get the kernels BTF object ID value (via that FD)?

I had hoped I could simply open /sys/kernel/btf/module [1]
and use bpf_obj_get_info_by_fd(), but that fails

  [1] 
https://github.com/xdp-project/bpf-examples/blob/BTF-playground01/BTF-playground/btf_module_read.c#L84
  [2] 
https://github.com/xdp-project/bpf-examples/blob/BTF-playground01/BTF-playground/btf_module_read.c#L48

> I think I want the BTF object IDs as displayed by 'btftool btf'.
> That code walks all IDs via bpf_btf_get_next_id() and then gets the FD
> via bpf_btf_get_fd_by_id().  I'm looking for a more direct way than
> having to walk all IDs...
> 
> (p.s. Cc. Larysa, I also looked at your code, which like bpftool end-up
> walking all BTF IDs and extends libbpf with internal btf_obj_id to keep
> track).

My current approach I end-up walking [3] all the BTF IDs via 
bpf_btf_get_next_id() and then use bpf_obj_get_info_by_fd().
And then searching for the module name like this[4].

  [3] 
https://github.com/xdp-project/bpf-examples/blob/BTF-playground01/BTF-playground/btf_module_ids.c#L144
  [4] 
https://github.com/xdp-project/bpf-examples/blob/BTF-playground01/BTF-playground/btf_module_ids.c#L187-L256

Is this the only approach?

It seems wasteful that I have to walk all the IDs, when I already knows 
what BTF file in /sys/kernel/btf/ I'm interested in...

--Jesper

