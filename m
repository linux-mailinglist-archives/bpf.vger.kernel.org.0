Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14BA68A7BB
	for <lists+bpf@lfdr.de>; Sat,  4 Feb 2023 03:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjBDCBT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 21:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjBDCBR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 21:01:17 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8F666EEF
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 18:01:17 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 78so4831687pgb.8
        for <bpf@vger.kernel.org>; Fri, 03 Feb 2023 18:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MR1UMa9NQuAw0hKniXicFJam+Vk7pdmWl7enSJwds8I=;
        b=ozNcmix20AdZk6KwMw/XZ8HelBBBmc0ozY0lywRcac8w/cUP01VmmTaFrvVWFM+/FP
         kE6nS2nKshxAwa8ZCz8E/+TIwsglxSfrtksE3eECAjrVyIGCDpjZMdy2OEt3jaXE2FA8
         B16VJu0m175moKuDNBp4SSBO6LOyjFow+4m+l3AfURWTGeLRKCIVpaNJN3UTEokA5Re5
         kgZ0bZQlRASzR4dScx8Zt/8qmkExoR+EQs4Z18bAHOIp4picQJHaX5rEyedQD/fx8ANo
         gMZ/92Iu86wbyIFkinwNujU7uHdL2hQGiua+jcStIuUI1VCSukYB8VuKc5Hg5280c/yE
         V1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MR1UMa9NQuAw0hKniXicFJam+Vk7pdmWl7enSJwds8I=;
        b=zZ2oEE8AIscANP3Scqxrfyce63W1YCy0ba8yvfW7BpnJBFI5Xp2hG3d4xw4Q1DFMF2
         UqQGO0oASuw2PWCZxSH/BwLMeths6F1HyPY+0YcjNkOtYhINyfAde7WSAmQFgbZChT8w
         ZvbJ8GeS0vQEvMPAG80DpjKWMHAXBPcwbrBBGp29NujJX9jpUXB20rFXVAGGvg0YMT46
         C7/nEAhGm7fKLleT7kwKGoXPehuRoXhrFJB7AZYPz+zwFY8Ryqt9Dt8gj0k6cjIMNwbq
         13UVKDxL9IhC2URKEvwKWUMlj/Wwfr7yD6FORT/sAT6XfcVTOhA2Ia0vi5pE4qlu9rgP
         8jHw==
X-Gm-Message-State: AO0yUKVpJb3/TvfHxusTEIWS5Aud6H5DqsjpxCr5bDQeHmVanBbJkiG0
        vsLjnb23IVg4peJnFFjr2Dw=
X-Google-Smtp-Source: AK7set/dEMYMVPk3JtMRcJTMcchyyjHAzFA4l7Y4yBvskaazinjOuyGfquntbpzbCaMTLZGomTaxQw==
X-Received: by 2002:a05:6a00:23d5:b0:58d:be61:4859 with SMTP id g21-20020a056a0023d500b0058dbe614859mr14370246pfc.11.1675476076637;
        Fri, 03 Feb 2023 18:01:16 -0800 (PST)
Received: from localhost ([98.97.116.12])
        by smtp.gmail.com with ESMTPSA id s67-20020a625e46000000b00589c467ed88sm2526143pfb.69.2023.02.03.18.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 18:01:15 -0800 (PST)
Date:   Fri, 03 Feb 2023 18:01:13 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, dennis@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, vbabka@suse.cz, urezki@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Message-ID: <63ddbc69ef50f_6bb1520813@john.notmuch>
In-Reply-To: <20230202014158.19616-8-laoar.shao@gmail.com>
References: <20230202014158.19616-1-laoar.shao@gmail.com>
 <20230202014158.19616-8-laoar.shao@gmail.com>
Subject: RE: [PATCH bpf-next 7/7] bpf: hashtab memory usage
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yafang Shao wrote:
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

This walks the entire map and buckets to get the size? Inside a
rcu critical section as well :/ it seems.

What am I missing, if you know how many elements are added (which
you can track on map updates) how come we can't just calculate the
memory size directly from this?

Thanks,
John
