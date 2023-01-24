Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2777679FD1
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 18:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjAXRLl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 12:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjAXRLl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 12:11:41 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEBC10CD
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 09:11:40 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v23so15389444plo.1
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 09:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0cMew/25Y2xZKE+JE9Wfch0cfjDBFdiCoU8TP+pO8TM=;
        b=azKMcYUAH0Y2UPP3LArhk5ME0ci+U4EUR4KFkjaoO0PtpztrRQq7EHuWw5pJJ3n1q8
         Q3SaqTt/mfz6BmVLmH1kcnBVPkHDtegIqjmgzueIZ6rF+hCvVU41d7ICNOmmah78FcCe
         ungSFx8vkvU2TwKEEHEQhQ+RXVRbSDHKCLF5u1BuY83DUNDNFQB1szXUh+Regrgh8p8V
         tbBdcOXk4Dz39avcyUVivkbALty5hRC9PzwyBRG3olsM7ff9LOBDYPhn41ujYWsz59VJ
         2RqN5nvyeKJWt4HiVP3FHrcOjT1VXRMLcrrApfTBh6Py8tCCjr77a5F0CIqoEPLkdRMB
         qvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cMew/25Y2xZKE+JE9Wfch0cfjDBFdiCoU8TP+pO8TM=;
        b=Ox24zmWhDq5nChWmNvh0X6C0vBnx2B2tH6P284/MfYYBOul1vPdJDuzndQYoKgnJSe
         NkThipycg7j+C3O2GTEVqDpv8HZDhCVDdNSPWS6LdS8OasNmzOJin25DWOQlB11mcZ23
         03CNTcpVtr0UOxeMf/0x1uRXMb6lk9+GIuvJbmOkuD8BpzWKnEp8OKDqsdwEzMNzXd1X
         oIR2g55klFzKfTW1NsQYctimw7L/DwvMqHIsLj1KDSWYCcf1ARoshTBt2QcVat0iHvRE
         93B4IODBHMy7Di/fcjfusSclvYB9BePjxjuo3XUn2etV5eYxkiTXNlJ7SmAzgSD9aGel
         ZPEg==
X-Gm-Message-State: AFqh2ko/yi1UJg7RyB2SaiLhISMiJImJlCxk5Vbz2IR1E4WWa+RDVEwL
        umPEWu9mglKiwaRMtP0FtiE=
X-Google-Smtp-Source: AMrXdXsn+NdJhpE9ItUvpVZxiuthjefm/57vFZyzrqJ+0c517vRzdp1issjEPchIxGBME0APdNzjiA==
X-Received: by 2002:a05:6a20:4f08:b0:b8:36a7:c5b0 with SMTP id gi8-20020a056a204f0800b000b836a7c5b0mr28557439pzb.13.1674580299762;
        Tue, 24 Jan 2023 09:11:39 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21c8::13fb? ([2620:10d:c090:400::5:69a5])
        by smtp.gmail.com with ESMTPSA id c6-20020a6566c6000000b0047917991e83sm1696461pgw.48.2023.01.24.09.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 09:11:39 -0800 (PST)
Message-ID: <47982993-be39-cf9d-0450-a659554cd39f@gmail.com>
Date:   Tue, 24 Jan 2023 09:11:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Calls bpf_setsockopt() on a
 ktls enabled socket.
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        song@kernel.org, kernel-team@meta.com
References: <20230121025716.3039933-1-kuifeng@meta.com>
 <20230121025716.3039933-3-kuifeng@meta.com>
 <737b9af6-4e2a-9da7-3968-fcb466e1eb8a@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <737b9af6-4e2a-9da7-3968-fcb466e1eb8a@linux.dev>
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


On 1/23/23 16:52, Martin KaFai Lau wrote:
> On 1/20/23 6:57 PM, Kui-Feng Lee wrote:
>>   void test_setget_sockopt(void)
>>   {
>>       cg_fd = test__join_cgroup(CG_NAME);
>> @@ -118,6 +188,7 @@ void test_setget_sockopt(void)
>>       test_tcp(AF_INET);
>>       test_udp(AF_INET6);
>>       test_udp(AF_INET);
>> +    test_ktls();
>
> Although not related to the IPPROTO_IPV6 code path, it seems pretty 
> cheap to test AF_INET6 also like the above tests?
>

Sure



