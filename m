Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648125B404D
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 22:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiIIUFA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 16:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiIIUE7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 16:04:59 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CF22714A
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 13:04:52 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-12ab0eaa366so6667881fac.13
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 13:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=PBBkfqyKEKmoKSlfumXcfswFTGpWKdlelDU3j7TdrR4=;
        b=MHywHitd5io7XuRWQ1rvvt5OziBwdtSQkH6YWIvZJXhDzI0hK+yn26ZtZ5AmtVG4Kn
         HrSjUsuHgDOXfTP8N9TWP1x7NIkLdK3/t7GT0g6yajI4+GpgY/j5nwOq5W31DjCxx02e
         zZqdEAnp7y1AUW/yFAsJvidtJ+MkBYVTCp5RIFpFktu/KdD4mPTB/H1E5VweTBovTVgg
         8s4tsTJK5l4foiGE66je2O3u9GdFIaFWajCgl7jrckozwvMYP/rnSzwIilaQLxl2Wqbo
         gXzk+Q//svkPmlif8IuOV2mdB32O1jMWIpjNAJl0YwB4Q645aETejfaBmjUNXUlDpm3C
         mQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PBBkfqyKEKmoKSlfumXcfswFTGpWKdlelDU3j7TdrR4=;
        b=TRudA86M0JodOgos+75n9yEZNO0KoEqalDFP6U86tDAIYgq4nubpjFVc8J6MdQyWsz
         QJhUJPuJd9fgcGQPr4F+yK1nOAs+OEQyqm4aEGqRCJvSXy+t8Pc1nde/UrCFpKgfqAQ9
         GO2NXPg9+r3SncrNE0bQ5EEXsTmgdhie+ZvuDq1eqkzBmrZwJOJv8WUHr0wki4E2mDvk
         YM5CHlpGOjmHqcYT5Qv/P3l/gRKKFSSa5OQguuX8RUHZFQFER9pwcSiZh1VDYdI3IovG
         cvGBKXqldrPKAFc9ujnmKXsgWSRKRVbzU7ZxkDVGlxjwxDw8fjrf6iyjxCQTqirQNkOv
         XQhg==
X-Gm-Message-State: ACgBeo3kCM36A8jvu/2+OjmEF+iRmVXeULxcrO+Yz0ZDMyVUTPO0P315
        iNGt7djrrP1IlERGmr8UJ1Rd/g==
X-Google-Smtp-Source: AA6agR5RYgasVurh3aZ6wjP27XeqkU/V82in/0/Rq3d0A0Fg9HJAYXaPlZLWbDr6iVRloG2uUuMB9A==
X-Received: by 2002:a05:6870:a197:b0:128:4c:ffd7 with SMTP id a23-20020a056870a19700b00128004cffd7mr6050134oaf.176.1662753891117;
        Fri, 09 Sep 2022 13:04:51 -0700 (PDT)
Received: from ?IPV6:2804:1b3:7000:8f29:b747:519c:23a4:77ca? ([2804:1b3:7000:8f29:b747:519c:23a4:77ca])
        by smtp.gmail.com with ESMTPSA id a65-20020a9d2647000000b006391bdbb361sm184640otb.31.2022.09.09.13.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 13:04:50 -0700 (PDT)
Message-ID: <6d627826-94ac-6c44-9a26-2e2662b58ee0@mojatatu.com>
Date:   Fri, 9 Sep 2022 17:04:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH net-next 0/8] add tc-testing test cases
Content-Language: en-US
To:     Zhengchao Shao <shaozhengchao@huawei.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, shuah@kernel.org
Cc:     weiyongjun1@huawei.com, yuehaibing@huawei.com
References: <20220909012936.268433-1-shaozhengchao@huawei.com>
From:   Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20220909012936.268433-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> For this patchset, test cases of the ctinfo, gate, and xt action modules
> are added to the tc-testing test suite. Also add deleting test for
> connmark, ife, nat, sample and tunnel_key action modules.
> 
> Zhengchao Shao (8):
>    selftests/tc-testings: add selftests for ctinfo action
>    selftests/tc-testings: add selftests for gate action
>    selftests/tc-testings: add selftests for xt action
>    selftests/tc-testings: add connmark action deleting test case
>    selftests/tc-testings: add ife action deleting test case
>    selftests/tc-testings: add nat action deleting test case
>    selftests/tc-testings: add sample action deleting test case
>    selftests/tc-testings: add tunnel_key action deleting test case
> 
>   .../tc-testing/tc-tests/actions/connmark.json |  50 +++
>   .../tc-testing/tc-tests/actions/ctinfo.json   | 316 ++++++++++++++++++
>   .../tc-testing/tc-tests/actions/gate.json     | 315 +++++++++++++++++
>   .../tc-testing/tc-tests/actions/ife.json      |  50 +++
>   .../tc-testing/tc-tests/actions/nat.json      |  50 +++
>   .../tc-testing/tc-tests/actions/sample.json   |  50 +++
>   .../tc-tests/actions/tunnel_key.json          |  50 +++
>   .../tc-testing/tc-tests/actions/xt.json       | 219 ++++++++++++
>   8 files changed, 1100 insertions(+)
>   create mode 100644 tools/testing/selftests/tc-testing/tc-tests/actions/ctinfo.json
>   create mode 100644 tools/testing/selftests/tc-testing/tc-tests/actions/gate.json
>   create mode 100644 tools/testing/selftests/tc-testing/tc-tests/actions/xt.json
> 

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
