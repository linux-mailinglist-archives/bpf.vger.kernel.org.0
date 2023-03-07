Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72D26ADA8E
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 10:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCGJlt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 04:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjCGJlp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 04:41:45 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09174AFE0
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 01:41:43 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id j2so11450756wrh.9
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 01:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1678182102;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I4a3zdxZbDzBhyQ9/sHQRV8j04VECSQNPe2EBKSZBmw=;
        b=U10fnQk6QM8VDzTwU3pv1ml1iiJJexwHn+B5MfBiu/scWEoCF18SZdVx5YpEfJDgMk
         6cRwPJEVPUY7bnTYEgsi4C9gHnxF+6RKMa3BNDBas2dkAQeHPgS2dAACxsaBSsaGNw4V
         Z9Ojt95PNLWmnhRLRdeHhpxdcDDmy/gt+tbB0Es8t5Mfyy9t4Dl/cjmfIxK2NXxYNZ1s
         IwLUP7Lc6/NmIW564FZ+HXHcmmTLBcyVlMHSWTUarkydaUDFJ3v0v4wFfWNt7XGgglOF
         jua/m/UDYkRrKH1+xL7GBFsZ9Q06cvEnx4aMH+fjoY+36ROrZi20bmkeZJtV1uWKRc5F
         2/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678182102;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4a3zdxZbDzBhyQ9/sHQRV8j04VECSQNPe2EBKSZBmw=;
        b=6FkBkHzXKb7l3nUGe4lo2+E5wirTBo59H176ZEQYXThMhe7HM6dxrpX0o5VN12QTT2
         Ge3qgjJ6Nwtvcuh9MkbAkbuBFu3CAQEQSAcxb5Wm9rAU0tk4NiZZ943SJQVMU3aisPAN
         f/E0IVDJPuBfQrb1e1hMZ421rHm8QgLFmAKRVuQPqPxdveT8cKCfKnoVjyNKu2nSrXN7
         pNzrgzayL6C/kjQkS0q547JoAZOpHsynmAiL3hh9Nt6GazQqe98H7sO8zrex9RBiC3Nz
         PJSQIusmEIQY2ddvGjbnXle9NdIDU4CXPpoo0BfngfJkowyc2T76qzcpOnxxQ6/SKjy0
         Xe6w==
X-Gm-Message-State: AO0yUKXXMZcKncPPP0wZHXWgxPlm6SZgI1SVftTtQ2GPN8V0obGiwBIj
        C6hEbi7p8vbhYNkuvM3y2hZhiTaPwd5tOwo7IMKk2gOqHKg=
X-Google-Smtp-Source: AK7set9LpK6pRb0fVIgO9vgbQDVS4HyjFAZwtNgyluQbiW89Mcz950lYwWAPHnDFAy+AkUxVM3LIPw==
X-Received: by 2002:a5d:524e:0:b0:2c7:af5:8047 with SMTP id k14-20020a5d524e000000b002c70af58047mr7555166wrc.9.1678182102348;
        Tue, 07 Mar 2023 01:41:42 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:ad85:48e6:59f4:a5cb? ([2a02:8011:e80c:0:ad85:48e6:59f4:a5cb])
        by smtp.gmail.com with ESMTPSA id d18-20020a5d6452000000b002c71dd1109fsm11888137wrw.47.2023.03.07.01.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 01:41:42 -0800 (PST)
Message-ID: <b32ecbd4-4ac8-d925-18fb-735bf7d30ad4@isovalent.com>
Date:   Tue, 7 Mar 2023 09:41:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Suggested patch for bpftool
Content-Language: en-GB
To:     Rae Marks <Raeanne.Marks@microsoft.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     Leonid Liansky <lliansky@microsoft.com>
References: <SJ0PR00MB10058537EA379C1260C3C8A9FBB69@SJ0PR00MB1005.namprd00.prod.outlook.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <SJ0PR00MB10058537EA379C1260C3C8A9FBB69@SJ0PR00MB1005.namprd00.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-03-06 21:46 UTC+0000 ~ Rae Marks <Raeanne.Marks@microsoft.com>
> Hello,
>  
> Thank you for your work on bpftool, a great resource.
>  
> I have a legitimate reason why bpftool might fail to open an individual map to dump its information. I would like to submit a patch so that it does not bail from the loop iterating over all maps on the first map error. With this change, one map failing to open would not affect showing information about other maps. Specifically, I’d like to change this line (https://github.com/libbpf/bpftool/blob/master/src/map.c#L699) to be a continue rather than a break.
> 
> How can I submit a patch if you approve of this suggestion? I see that the GitHub mirror of libbpf/bpftool is not the appropriate place, according to the README.
>  
> Thank you!
>  
> Rae Marks
> Senior Software Engineer | Microsoft
>  

Hi Rae,

Thanks for reaching out.

Let me start with how to submit. The GitHub repository is just a mirror
indeed, the sources of bpftool are maintained as part of the Linux
kernel repository. This means that patches should be sent to this
mailing list, please refer to [0] for more details.

Regarding the patch that you propose, I'd welcome a way to keep
iterating if we fail to retrieve the id for the following map, but we
can't just "continue" in the loop if we don't have the id from
bpf_map_get_next_id(): If we don't get a valid id, we can't reuse it on
the following loop iteration to fetch the id of the following map. We
would have to start again with a null id and to loop over all maps again.

Can I ask in what context you saw bpftool stop before printing all the maps?

[0] https://docs.kernel.org/bpf/bpf_devel_QA.html#submitting-patches

Thanks,
Quentin
