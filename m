Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDCD4BE84F
	for <lists+bpf@lfdr.de>; Mon, 21 Feb 2022 19:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355268AbiBUKma (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Feb 2022 05:42:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355356AbiBUKkt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Feb 2022 05:40:49 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F714B433
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 02:02:55 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id f17so1179507wrh.7
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 02:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=4spbP8g3kH8kWJj7au2RUQjlvz8vP+xcK3qZ2pF3cn8=;
        b=Gg5vB8sQY2JfVjfQx2R5+fSVYczoNT+p/XvGOctR3yJER4y5YNmcMNPjyTtMxAAyPO
         KVsnH9PQ3MNlTuVEzm9E1MS/3ji0IzkB19LTKyjAklzuqQrxoBPUDEwoi+ORrTdC1xbf
         Zxz2MTtovhVxZ6xzBVQagIKHq/wsZXJo5uKg9TYa7UIovwDrkdvpir17gtf7tDF8cjhq
         YemyZuo/wd8a2s2f62lXIQ/cmtNIikheaw7JCz6jzeaYpM/M7vuVCxzUlzNxE/pfACYb
         Q7KhrEnie2B5awn9p5TRtMidNpn7L7MRodWl26L4KZYH3tjNrg4d59NHI7sR49eBmA0L
         w0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:organization
         :in-reply-to:content-transfer-encoding;
        bh=4spbP8g3kH8kWJj7au2RUQjlvz8vP+xcK3qZ2pF3cn8=;
        b=MKEVS3H2J2eQo+rTciItoiJEbMSinnSsL3UgvUzM8coO9XQyiMfjCluE6D8gGTYvHJ
         m7/hnqqRhwd7Q9z8cGwGiCmojtske6ctngQFVNedZuazbaX0T8dbCaxWBcZhuR58uJeo
         muHqDBuaPI30lVbcABXcoMdkv+VIT55koSh7FoaYXeGNjWUQbJgsRqgUqcL/Wc6ps+v+
         FVHYVSfN7usgBOoHTZJSAgZmyPzusd49dqT/sPckY/lycD+NK3rBbE54xto0Au5pRXnI
         cJCA2Ie8+7vLlRJeoJNVkiAU9mxIM3GTlrjNrem7kSzVl9/TaevYHm3eNz9Dj5I43Qwh
         hrhQ==
X-Gm-Message-State: AOAM530qJrAqWMZ89veAaPezUUNpdDu5lydl4ZkIeifaAypyaTzbsA2G
        Jx6AOkkxf7KWqT0VnAQzZ4nKmQ==
X-Google-Smtp-Source: ABdhPJylZCA6xTSnt41gx8pHMBxY0LxZ+rJcNeqm+wB61rgZCKWqTRHWRpKsePNT7SfM9w7wxxQyeQ==
X-Received: by 2002:a5d:6606:0:b0:1d5:e69d:884c with SMTP id n6-20020a5d6606000000b001d5e69d884cmr14212282wru.160.1645437773990;
        Mon, 21 Feb 2022 02:02:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:bc91:e50c:999:2115? ([2a01:e0a:b41:c160:bc91:e50c:999:2115])
        by smtp.gmail.com with ESMTPSA id a10sm25032012wrt.59.2022.02.21.02.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 02:02:53 -0800 (PST)
Message-ID: <571939bd-724c-3f10-e220-b581eb307b34@6wind.com>
Date:   Mon, 21 Feb 2022 11:02:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH] bpf: cleanup comments
Content-Language: en-US
To:     trix@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220220184055.3608317-1-trix@redhat.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20220220184055.3608317-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org




Le 20/02/2022 à 19:40, trix@redhat.com a écrit :
> From: Tom Rix <trix@redhat.com>
> 
> Add leading space to spdx tag
> Use // for spdx c file comment
> 
> Replacements
> resereved to reserved
> inbetween to in between
> everytime to every time
> intutivie to intuitive
> currenct to current
> encontered to encountered
> referenceing to referencing
> upto to up to
> exectuted to executedYou can add them in scripts/spelling.txt


Regards,
Nicolas
