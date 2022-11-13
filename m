Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A799627370
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 00:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbiKMXVW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 18:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiKMXVV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 18:21:21 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55A06594;
        Sun, 13 Nov 2022 15:21:20 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o7so8908404pjj.1;
        Sun, 13 Nov 2022 15:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lU2zeH3gqay6YpSqUA1zpWLMQhU9hqj91l1iL/eamsw=;
        b=SXt4AoCA5+A1ZcMJ9qtuYu46M0Jp1iU7XV0RQk2jUMrBhkSHFvWdyvDpPRWYIjW6ug
         k2NJIOeJxf8YhqxE0e2Bw74VT8n4Xd1NsW5Hm75ODm7UNS5UQmFPz5ABdmlHc8MyWokA
         qv+l+jMO+b2xyxfaGxUULgYjAUkEWGedISjYdTe8lH/DbFF2dNylX34+vfdY6G3nhAba
         SkaTyDYfaGy0r/iFgFJOtGiSaqzYrX/Hwi+6fGYENmxjAw52MV8U9j0jAhTwyVQF2Mhj
         R5BXgNkcoSh1UaBrdqBif9+ugT6mBqU+kFVp06QoPQypHb1j2H1HhC9UKrdWuYFPZ5/G
         ivZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lU2zeH3gqay6YpSqUA1zpWLMQhU9hqj91l1iL/eamsw=;
        b=hGzbA6bhijg25UKUnIwEBLgwGkXbfnqxe/uGBeJWSZo3IqVmftehmxK9EFDRMRCCy5
         0kfsFjgIFo8zsZ5tlmU6PBzRX/YnGQMbaIUxyAS8pYFiOOeYaz/DZ0FooRXpVz5hnaNC
         UHQNsFH/TlwjW+9HdVubUDs1ZHxUK+N0tfVuILhMw6ZEBlnyXC0vpu2Csbpe7gYO/NN/
         ldDVz9mZ1/vlwL5W1TtM4z5uEGtTNynE+JpYZdt+56KObHgn7/O5tfDHW1/fkprJLe8n
         +8xwQf9+E5vRRe1FnhwW5GbH/fupaZo8Y8/gSe6aDG8I+UYsebHMQkvgpbZBZ7aQ1DC8
         2Kzg==
X-Gm-Message-State: ANoB5pmD0sof1qDU93cH0K/TShvUhyiF41QLyVPGfAcSPd1Ei1Fqn/+a
        ZFtklXtqtrzbmVUK+Ed0ePY=
X-Google-Smtp-Source: AA0mqf7y/ckKVgK2mONq6O76Q/8DNXEPGqisPxJVMPduqCtmZDBkw64gQHiyM0djMe1eidZaI+PD2Q==
X-Received: by 2002:a17:90a:c251:b0:216:92a9:fd50 with SMTP id d17-20020a17090ac25100b0021692a9fd50mr11307560pjx.126.1668381680286;
        Sun, 13 Nov 2022 15:21:20 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902edc700b0018693643504sm5757685plk.40.2022.11.13.15.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 15:21:19 -0800 (PST)
Message-ID: <5ee856e5-d65f-d342-0c84-1e39f9a5a251@gmail.com>
Date:   Mon, 14 Nov 2022 08:21:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH bpf-next v1 1/1] docs: fixup cpumap sphinx >= 3.1 warning
To:     mtahhan@redhat.com, bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        Akira Yokosawa <akiyks@gmail.com>
References: <20221113103327.3287482-1-mtahhan@redhat.com>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20221113103327.3287482-1-mtahhan@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 13 Nov 2022 05:33:27 -0500, mtahhan@redhat.com wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Fixup bpf_map_update_elem() declaration to use a single line.
> 
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
> Reported-by: Akira Yokosawa <akiyks@gmail.com>
Tested-by: Akira Yokosawa <akiyks@gmail.com>

        Thanks, Akira
> ---
>  Documentation/bpf/map_cpumap.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/bpf/map_cpumap.rst b/Documentation/bpf/map_cpumap.rst
> index eaf57b38cafd..61a797a86342 100644
> --- a/Documentation/bpf/map_cpumap.rst
> +++ b/Documentation/bpf/map_cpumap.rst
> @@ -48,8 +48,7 @@ Userspace
>      program will result in the program failing to load and a verifier warning.
>  
>  .. c:function::
> -    int bpf_map_update_elem(int fd, const void *key, const void *value,
> -                   __u64 flags);
> +    int bpf_map_update_elem(int fd, const void *key, const void *value, __u64 flags);
>  
>   CPU entries can be added or updated using the ``bpf_map_update_elem()``
>   helper. This helper replaces existing elements atomically. The ``value`` parameter
