Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9050D5628C3
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 04:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiGACKJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 22:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiGACKJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 22:10:09 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA555926A;
        Thu, 30 Jun 2022 19:10:08 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 65so1085885pfw.11;
        Thu, 30 Jun 2022 19:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TPzc9hzYI8k2FxRM2hpn3voDVDIHF4dVpsXHC+1Tu7s=;
        b=gBVeDZ03KcvJBES5Mel1TOuI2RwnXE1c+L+ElZyTILyKlhCDOTKIeR9wnAKnsJUrvh
         LnQd3AEdwMe2LtE37lwEiG2FO0InKy3L1hPLVU7CFErPYWI5R3ZhpHL6p94/Ys4i6mQt
         PCQYrqI81+OzYptpJ8cHOxY7OLO+7KQBzU4GIocEDipCIKb4DjcanZx6qWBsoe5cRqH9
         VEdZkpUV2D8ZsTofzGFNh8R4LIJvZxDL4EoC4UgdcVdbaQ0sPF3liu59uBojSsrBxHGG
         TH8UNxYgLynwWXNhlgGqMzxPbe/mmdB/n64hexi79uZ6Yq3gJwxh2WuXNelCrCcW22xh
         zZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TPzc9hzYI8k2FxRM2hpn3voDVDIHF4dVpsXHC+1Tu7s=;
        b=mSR5h2dQTZnz+R971Vo8V1s2RpBienSqSkd3OQDtu70IcGwKnjGUBw4Laal9Mg4wPb
         pv67ZLJkSxrDAcnlaHuESO/uprveiB5SvEIbYCEkIk28yu/7xDmML2YofxvCngoBGv4T
         ah/H2dM4IYObfBABPlPGa8IVRcHi6YkeSnm+IuPbMwEqSDSdzl9dljE94bJLnOukwezK
         S8Yvi8347sJeybhwd4rckHiJFg6ONKyKMgwWBkmgDSmaKKpWjbNfLv2RHUoyIGeSazta
         JzdKnqU87fproWuZv2oG3dboyxnAz0k644opk9MDNlZm7JkYiMuj2GUv5Djn80FB5riS
         HPAw==
X-Gm-Message-State: AJIora8mKKD33OyQd3AqPgi5U8MzN51wpUhDDsD9fZtv1BFz5m/cXc/N
        KaQDuLAO1rjN9LyhTXiQjm8=
X-Google-Smtp-Source: AGRyM1tjvQMaTJXcBGxQwkQiQom0kfqFUwwOpv3sLBzgVMyjtxprWaW6B8FqExhFOrlktzQCqqWGrQ==
X-Received: by 2002:a05:6a00:430e:b0:525:26c1:973e with SMTP id cb14-20020a056a00430e00b0052526c1973emr17594804pfb.52.1656641407899;
        Thu, 30 Jun 2022 19:10:07 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-70.three.co.id. [223.255.225.70])
        by smtp.gmail.com with ESMTPSA id b184-20020a62cfc1000000b0050dc762816asm14497108pfg.68.2022.06.30.19.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 19:10:07 -0700 (PDT)
Message-ID: <06e90032-95ee-25ff-cf66-a1a31eded210@gmail.com>
Date:   Fri, 1 Jul 2022 09:10:01 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 bpf-next 1/2] bpf, docs: add kernel version to
 map_cgroup_storage
Content-Language: en-US
To:     Dave Tucker <dave@dtucker.co.uk>, bpf@vger.kernel.org
Cc:     corbet@lwn.net, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-doc@vger.kernel.org
References: <cover.1656590177.git.dave@dtucker.co.uk>
 <8fd94a697b41cd39e600b87c59954c703bc75850.1656590177.git.dave@dtucker.co.uk>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <8fd94a697b41cd39e600b87c59954c703bc75850.1656590177.git.dave@dtucker.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/30/22 19:04, Dave Tucker wrote:
> This adds the version at which this map became available to use in the
> documentation
> 

Shouldn't this be separated from [2/2]?	Because I see cover letter ([0/2])
only mentioning documenting BPF_MAP_TYPE_ARRAY, so I expect that only
[2/2] is included in this series.

-- 
An old man doll... just what I always wanted! - Clara
