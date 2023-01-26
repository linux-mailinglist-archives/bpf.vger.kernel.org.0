Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6709967D3C7
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 19:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjAZSMX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 13:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjAZSMW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 13:12:22 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B211DBA7
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 10:12:21 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d3so2559817plr.10
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 10:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BdXug9PgmqRYMVK4F/MAFsP+IpmZyN7j5ltDlgO/5gg=;
        b=Zq0tTy2ydRiPOlTh1F+7UttRY5QRt20OdTzS7U+08fxf+suI6kLgnlkGfmWGostXN2
         5Zim8YQwFjGyt/5cU5piZp9c82Wr1JbTvPCTh8bmdztRBzPYOS0EEC7p2vOWgddPxHY0
         zUxg1z0qtvUgRz14c6KWb3YofxCZPDDhicfPh9qROO/JoWUKDvGjmRvHmdw2BJkZL8E+
         2Cz5bBMdIRe7Uhw/Y5NpVKFXjyhzREV7TOLzB24znO3Q5PsBgTg1h7H6k8TJWwq7HFs8
         X3Lc8fNI9QSBSWsiZfEUV+P3Hu8G8eMMzxv0qtNBn+6Gs3kP//ZI1fZyf73oK/XXoZ5G
         Anfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdXug9PgmqRYMVK4F/MAFsP+IpmZyN7j5ltDlgO/5gg=;
        b=wkxToP+ZiJQbf/fQ+qFB4V/bYkDZ3JbE7kZngZdOBaRNtQ6v79LL4ivvh/mTFIEZUb
         zTXOhFFHJU7RnRAM5tY7j1hLWfW3unxZFnvBNn6ujOfkvyI8RWKvmNPP+hCHsDYKEsvC
         Cl64oGu0G5Lseci5ws7XJGvKzr+WAXEoCrT0uQabSYytJ9EuV9AEszaIaBajgVdKBHOq
         Ob/gunuYROqS5RZeXddDrpy2NmU+YUuJZAlPt3v5f15x7xz3zmouyt3xK63YkFMkYKA9
         1Y4jRbCPnlQ6MptDP+RkXjei4lsaz/HtiAopuazVbBJK/MRKbLbyiebeR6ejzzMVL9KS
         pC4w==
X-Gm-Message-State: AO0yUKVRHQW6r+5kObvfAwbb/0C0G9aNeTdm6Vo96BMj2KUYnPwoAq5y
        T6dUL8G7p4GtjEFnphTkgho=
X-Google-Smtp-Source: AK7set8I+Zhzb+4oJI78JxVEDtSflumb7Ja9KkxZLY+/p2Mr+mGior4yHROVjm3ZDN55YLOTQD9HzA==
X-Received: by 2002:a17:902:e415:b0:194:93ce:13eb with SMTP id m21-20020a170902e41500b0019493ce13ebmr1883898ple.32.1674756741273;
        Thu, 26 Jan 2023 10:12:21 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21e8::13de? ([2620:10d:c090:400::5:80e4])
        by smtp.gmail.com with ESMTPSA id p24-20020a170903249800b00195e6ea45a8sm1242065plw.305.2023.01.26.10.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 10:12:20 -0800 (PST)
Message-ID: <14f48f2a-918c-6545-537c-a724b19b4137@gmail.com>
Date:   Thu, 26 Jan 2023 10:12:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Calls bpf_setsockopt() on
 a ktls enabled socket.
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com
References: <20230125201608.908230-1-kuifeng@meta.com>
 <20230125201608.908230-3-kuifeng@meta.com>
 <638f080b-ee7d-2cd6-07e1-dbbc2dcded0f@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <638f080b-ee7d-2cd6-07e1-dbbc2dcded0f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 1/25/23 15:17, Martin KaFai Lau wrote:
> On 1/25/23 12:16 PM, Kui-Feng Lee wrote:
>> +    close(fd);
>> +    /* At this point, the cfd socket is at the CLOSE_WAIT state
>> +     * and still run TLS protocol.  The test for
>> +     * BPF_TCP_CLOSE_WAIT should be run at this point.
>> +     */
>> +    char buf[1];
>
> This checkpatch warning is reasonable:
>
> https://patchwork.kernel.org/project/netdevbpf/patch/20230125201608.908230-3-kuifeng@meta.com/ 
>
>
> WARNING: Missing a blank line after declarations
> #88: FILE: tools/testing/selftests/bpf/prog_tests/setget_sockopt.c:138:
> +    char buf[1];
> +    ret = read(cfd, buf, 1);
>
> I fixed it up and take this chance to move it to the beginning of the 
> function. Applied. Thanks.


Thank you for fixing that and reviewing!


>
>
>> +    ret = read(cfd, buf, 1);
>> +    ASSERT_EQ(ret, 0, "read");
>> +    close(cfd);
>
