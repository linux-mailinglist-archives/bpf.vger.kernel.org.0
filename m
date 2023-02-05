Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A9368B220
	for <lists+bpf@lfdr.de>; Sun,  5 Feb 2023 23:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjBEWOY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Feb 2023 17:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBEWOY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Feb 2023 17:14:24 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441191A97F
        for <bpf@vger.kernel.org>; Sun,  5 Feb 2023 14:14:23 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id h24so11123569qtr.0
        for <bpf@vger.kernel.org>; Sun, 05 Feb 2023 14:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YRwBessYltnVl27VyWC15atdLwY8Z7C93TnQdOZlZQw=;
        b=niOBgCzknPFZRDNIEiLf+vWUNwLMBkPhwxsQVSRlM8YqLvXTmAvIh6txQ8YHUuxi04
         EoxA5l4jOR/G4v9I35cAN1lbQ2L5cLELDZTfEUdyl8xtpjYAz4YCr7GvgnP54d2F3OXr
         X8zSB0i0IlJ6+IcUYgYYHw9W86whUkBIrYUnEp6u9XA8P6cvwJmYi5px49H1NKcqQ5vS
         ZwaUcMIGtbHh+9rnscvR0OjI8VQNfcn+H0giyfoim2Gotz3HOH9TXD789WjfBJet5YXD
         yXVmZQfp4aaCNuOvpUGeD5XJNJN1XrY3oGvAhlmfWKM9h+cmBoYFUG8vtfYC2QRieUbg
         nCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRwBessYltnVl27VyWC15atdLwY8Z7C93TnQdOZlZQw=;
        b=hDQDufMu7phYjJAtamzYr98qguC9DBYB4IE4LzsGd2cemMx334zAVDbXPvnMNihnBL
         EM4gL63pTSrQ4UYlcG6mnRlYOqnnWqNbGVN/NK7cOtwyJhsuxe7eESXfuWmHxq7EYPsC
         PSJjsV0fSdIfIKegQm9cMlS8XhPhViZQIuCTdrNgbo8/+oxFi9+H7ilzX13KQGhW07W7
         iVJZG1WwZTTfeA5ExOauT39yRJK5WN1oqiNsNL006CTjgHKiuw82/c9bWAkAitwX3Uyo
         ZmWRtL5fvyHtnZ5nhnJ7787g1N5jg7AZc9McLsURZ7rgXNbHmKW8JN5w7+n3zX2pzk1u
         4rvg==
X-Gm-Message-State: AO0yUKU1uFTpslgUVUcv6C/iv+jqAu/K6jRp5aN5T/XONhUCldr7dgh6
        OozlaYVLdZcixW37x/xcAoY=
X-Google-Smtp-Source: AK7set+kz4HpH3tFLp7lAmDe31VhB6UBIyJIhtaaej/n4SYoYLCUCr7qx6G3Ez/hSMcydh+woNDD4A==
X-Received: by 2002:ac8:7f11:0:b0:3b9:c08f:219c with SMTP id f17-20020ac87f11000000b003b9c08f219cmr28331246qtk.29.1675635262393;
        Sun, 05 Feb 2023 14:14:22 -0800 (PST)
Received: from localhost ([2600:1700:65a0:ab60:88e1:3b3a:d596:a5ab])
        by smtp.gmail.com with ESMTPSA id h62-20020a37b741000000b007283b33bfbesm6167874qkf.121.2023.02.05.14.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 14:14:21 -0800 (PST)
Date:   Sun, 5 Feb 2023 14:14:20 -0800
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        urezki@gmail.com, linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 7/7] bpf: hashtab memory usage
Message-ID: <Y+AqPJSBnAN830p3@pop-os.localdomain>
References: <20230202014158.19616-1-laoar.shao@gmail.com>
 <20230202014158.19616-8-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202014158.19616-8-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 02, 2023 at 01:41:58AM +0000, Yafang Shao wrote:
> Get htab memory usage from the htab pointers we have allocated. Some
> small pointers are ignored as their size are quite small compared with
> the total size.
> 
> The result as follows,
> - before this change
> 1: hash  name count_map  flags 0x0  <<<< prealloc
>         key 16B  value 24B  max_entries 1048576  memlock 41943040B
> 2: hash  name count_map  flags 0x1  <<<< non prealloc, fully set
>         key 16B  value 24B  max_entries 1048576  memlock 41943040B
> 3: hash  name count_map  flags 0x1  <<<< non prealloc, non set
>         key 16B  value 24B  max_entries 1048576  memlock 41943040B
> 
> The memlock is always a fixed number whatever it is preallocated or
> not, and whatever the allocated elements number is.
> 
> - after this change
> 1: hash  name count_map  flags 0x0  <<<< prealloc
>         key 16B  value 24B  max_entries 1048576  memlock 109064464B
> 2: hash  name count_map  flags 0x1  <<<< non prealloc, fully set
>         key 16B  value 24B  max_entries 1048576  memlock 117464320B
> 3: hash  name count_map  flags 0x1  <<<< non prealloc, non set
>         key 16B  value 24B  max_entries 1048576  memlock 16797952B
> 
> The memlock now is hashtab actually allocated.
> 
> At worst, the difference can be 10x, for example,
> - before this change
> 4: hash  name count_map  flags 0x0
>         key 4B  value 4B  max_entries 1048576  memlock 8388608B
> 
> - after this change
> 4: hash  name count_map  flags 0x0
>         key 4B  value 4B  max_entries 1048576  memlock 83898640B
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/hashtab.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++-

What about other maps like regular array map?

Thanks.
