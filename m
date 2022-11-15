Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9107A629E31
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 16:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiKOPzy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 10:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiKOPzx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 10:55:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E982CE19
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 07:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668527689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aAB2Hg+RMDMT5I1x428ws21lBRjRICs3mcInuPW5LFo=;
        b=RJbCUBCA1Yd5JuHlPhp+0Hq8S2tWef4t3kt1dvoe3HH2pTOiwVi8t+jeK4vk1+meAP8usS
        BLQUSot3pSdxLCJp/MMum3ANNbPTHeB3ZspcqtoIC3q3f32g9wfNYfSaLy1PaQ0LQRwu2w
        DvY+B5Y5eBVxvteWbiXQcSTKlzPAVZ8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-252-_ZRv0t1HM6mNV9bqDvCJqA-1; Tue, 15 Nov 2022 10:54:48 -0500
X-MC-Unique: _ZRv0t1HM6mNV9bqDvCJqA-1
Received: by mail-ed1-f70.google.com with SMTP id dz9-20020a0564021d4900b0045d9a3aded4so10444537edb.22
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 07:54:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAB2Hg+RMDMT5I1x428ws21lBRjRICs3mcInuPW5LFo=;
        b=gMi0oYUXjvmAdcHa29B/cp5qtxjPpMztTyOEwA+GFH6jW5UD85b0jGu9aM4VMc+C7G
         TSzdhFOgqL58+eX7NFxI/cK9bREcqso9oU/z/nvfn0OYqKQdKhdJ7eXqsi6iKjJR/4Xx
         GH+7UPk5AjSkojc3Y7WUmB6czfLuxV7bOWTxHikpIabCC5P0HCBpbM2ZmQ672a9qa9lv
         Ff7je0DIZxTgfzksb99bRxYJyYI/rROgmT9rwfmhL98BjjhSF91ceWzEj5FIRlq/YZm0
         D+2e3Hlzpxck2s24V3KBaQuh9V5ZeyuqwWuLBT5/doaNWsToFCSUnWAYAcMzcLOI/ocL
         kHvg==
X-Gm-Message-State: ANoB5pnmhEADtKi/b2z5xKqocT6/0Ja4PPk6QEseN5QCD6aE/VSol6Ii
        KbCI+VqitxtcZlKlN0weLyEqsdweZfruDaUOh1Yc3OFi26bJb6c8huVPLbhaxqgnIWvVC4yBlMx
        zmLiVJaDp3lsz
X-Received: by 2002:a17:906:2cd6:b0:78d:20f7:1294 with SMTP id r22-20020a1709062cd600b0078d20f71294mr15377377ejr.442.1668527686622;
        Tue, 15 Nov 2022 07:54:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5cWcobPYDT3WRhyKVYgNuEsHOuqtMADP3XcGH3zCnehqQcGtUwi3vBUpyahiaXASHL4ecy3A==
X-Received: by 2002:a17:906:2cd6:b0:78d:20f7:1294 with SMTP id r22-20020a1709062cd600b0078d20f71294mr15377338ejr.442.1668527686254;
        Tue, 15 Nov 2022 07:54:46 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id cf6-20020a170906b2c600b007ad94fd48dfsm5623540ejb.139.2022.11.15.07.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:54:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2F0CE7A6CC4; Tue, 15 Nov 2022 16:54:45 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Subject: Re: [xdp-hints] [PATCH bpf-next 00/11] xdp: hints via kfuncs
In-Reply-To: <20221115030210.3159213-1-sdf@google.com>
References: <20221115030210.3159213-1-sdf@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 15 Nov 2022 16:54:45 +0100
Message-ID: <87mt8si56i.fsf@toke.dk>
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

Stanislav Fomichev <sdf@google.com> writes:

> - drop __randomize_layout
>
>   Not sure it's possible to sanely expose it via UAPI. Because every
>   .o potentially gets its own randomized layout, test_progs
>   refuses to link.

So this won't work if the struct is in a kernel-supplied UAPI header
(which would include the __randomize_layout tag). But if it's *not* in a
UAPI header it should still be included in a stable form (i.e., without
the randomize tag) in vmlinux.h, right? Which would be the point:
consumers would be forced to read it from there and do CO-RE on it...

-Toke

