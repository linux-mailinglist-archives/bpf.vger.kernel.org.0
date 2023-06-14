Return-Path: <bpf+bounces-2605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AA673092B
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 22:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49BD281594
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 20:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40732EC33;
	Wed, 14 Jun 2023 20:32:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5DA2EC0B
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 20:32:17 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D40212D
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 13:32:16 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-75d4dd6f012so248979585a.2
        for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 13:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686774735; x=1689366735;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1NltGidQAgV431gXax1Y0ZufWVyL2ThG3rJUOl0NM8=;
        b=3NcyyOHEA+FJ8IufQS55zv6Q4dypah4rZnxkQTCIc1RmcW0zJ/ydTx1jXIH8kFCX3V
         y1T32vcGSq66J+gtGwkfSr/ZK9hQIMAlJfvBqu1Z9qkuCqMT9csr//nctkhCXuuAb9lr
         2719mHo/WuUFzOrAhUBfYrtMqcgpgt+aUmkN07Y6It3rMWkoiISo2q0fE1gI9eLA4Pnb
         oFyvwxmO7L6bkraJO12U+2xPl8eJ2obGKSrU290V64D6mhtKZ3+w3SAm0BYc83RBP7p/
         IMflBV1IQtWZZyMMxrkxNxK70BqzCs1ojkc1bFm4OGN7jrVLYwKgoEENcCat+hxHYT6C
         88gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686774735; x=1689366735;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W1NltGidQAgV431gXax1Y0ZufWVyL2ThG3rJUOl0NM8=;
        b=cEtYQLOisGUh/4l161JOwQ+QdXrPoXFxdYpIz5mlK0qQ2EBy9Vsl+JfygPkPiRzhVY
         NhYqSRBaq3fuUnzkajbKMrY+Ctp6rbp3HNQ3bZgpjikTWdVNq8Rgh9VEvDMbV3NvRavW
         6tPURqQpi/7mcJaVnt2sKw10PQcRjPJTOp26zDfLGaRG2eAXA8/MzP32/xtW6nJwaQVf
         rOYhTiPeijh0fUr2Cislt3Or+V689mFEHaMGFPqd6HZQ4aS5OioAL3w7AqOqxobQDNPz
         qc7gkGauMjFYPyttPYhNq8yzjG5+FI/RdISeJxybET9l+Se1B4hiAiTwZ5ojd3xP1VPo
         u3tA==
X-Gm-Message-State: AC+VfDwgUqbMloeW4no0fOLyjjgwbj6Gm68hZMa83At4vkJ+XRve+44o
	XcuA57PvWQToXeCSKodHXiIXGVq7L2OmzBPuPIaavA==
X-Google-Smtp-Source: ACHHUZ7lsXessUap0y+clJbdL9g/schslHOUkJCjXEa0m3D5QVrIHOmbTQLSHTLUFYzzULNfWFwebg==
X-Received: by 2002:a05:620a:6413:b0:75b:23a0:deb4 with SMTP id pz19-20020a05620a641300b0075b23a0deb4mr15658187qkn.50.1686774735339;
        Wed, 14 Jun 2023 13:32:15 -0700 (PDT)
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id b10-20020a05620a118a00b0075cc5e34e48sm4543344qkk.131.2023.06.14.13.32.14
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 13:32:14 -0700 (PDT)
Message-ID: <bd173bf2-dea6-3e0e-4176-4a9256a9a056@google.com>
Date: Wed, 14 Jun 2023 16:32:12 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
To: bpf@vger.kernel.org
Content-Language: en-US
From: Barret Rhoden <brho@google.com>
Subject: Calling functions while holding a spinlock
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi -

Would it be possible to add logic to the verifier to handle calling 
functions within my program (subprograms?) while holding a bpf_spin_lock?

Some of my functions are large enough that the compiler won't inline 
them, so I'll get a BPF_CALL to PC + offset (relative call within my 
program).  Whenever this pops up, I force the compiler to inline the 
function, but that's brittle.  I'd rather just have the ability to call 
a function.

Thanks,

Barret


