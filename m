Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E088A527B92
	for <lists+bpf@lfdr.de>; Mon, 16 May 2022 03:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239246AbiEPB4U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 15 May 2022 21:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbiEPBz4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 15 May 2022 21:55:56 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5737862C5
        for <bpf@vger.kernel.org>; Sun, 15 May 2022 18:55:54 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o13-20020a17090a9f8d00b001df3fc52ea7so2052687pjp.3
        for <bpf@vger.kernel.org>; Sun, 15 May 2022 18:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=KQnul6BomttjXRAElW8MXsYWinaGJAdMxQ34JNltdPE=;
        b=lHEnF6heGEjJ30vDGmBAz//0dsf9/RNBPwzN+OFFUpaPvjAovS+THylUPUacjSp6df
         12B4Wy+uYihi9szlnkEPWXJDvL5sd4FqIbsJ5+5K6L0zjbr5QUN7eFoVdz0Uqo2BxA9C
         AqzLXKBpDNfAG1hXLUxIajsWYpek5ukHHrY1iwVscUHinDQK+XVisRXfGex8dOOya/Vq
         rbNIwnbyZGCrS/iYhZWWm2k2qdzp22US3fvOjFOpxyFkL3psSHsu0SbMMbWyF+/OmN6q
         A9ili3tCLYcJoQZ0wb1WqHEar+/5/bGXsjDXO9jmpd5ncQ5rs3Ca6oxtEI3vq/ZD1X3i
         2z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KQnul6BomttjXRAElW8MXsYWinaGJAdMxQ34JNltdPE=;
        b=USPBkxy7ebFNEgdYsije4pH3hc+SwwxZbCGHAkOFie1vmx0vNYGzde5+ulnp0QlUnn
         Cj89GAfiUEnibOoWkGewVgKax3CXmoFB7RO8v779e8NE7UMHy8xo1OJD95DFJqRPf0e0
         Y0LoBNkiWiq/JFpidgp21tPwoyIMSqpSkfuYXDJyF1p+WBXr9OCXpmUe1zrdX1t4vXDd
         BVuMJ4zB9QetYX3GaTxzUweqUcGyD5jfRYOvOZ6vceHQJ5VxABTZZCX7PoR76PuAnDu/
         oI0heCkIe/Uax+oso6TLom1WKY1nw9KIfMPy//8trosPf65tJkQ4j5zNnHfPEZ7fwVdN
         guxw==
X-Gm-Message-State: AOAM53158pNapUwxGZ6vgN6Qx1x07ctjmS401x8dyeh2haAxzBHzxaCT
        Vd7iEM7FXfixq5OakggxUwE0MA==
X-Google-Smtp-Source: ABdhPJyidz87m6gcjue2sTWA10gYK/ag05Ahv7NiReHPxORN5OC8cn+XAhREd3c9YiJMe8mZbhq2CQ==
X-Received: by 2002:a17:90b:1251:b0:1d7:f7ae:9f1 with SMTP id gx17-20020a17090b125100b001d7f7ae09f1mr28343920pjb.65.1652666153928;
        Sun, 15 May 2022 18:55:53 -0700 (PDT)
Received: from [10.71.57.194] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id y6-20020a655a06000000b003f24a2be89asm3137216pgs.8.2022.05.15.18.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 18:55:53 -0700 (PDT)
Message-ID: <192be0a3-47dd-221d-0061-4e04e489ff89@bytedance.com>
Date:   Mon, 16 May 2022 09:55:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [External] Re: [PATCH bpf-next v3 0/2] Introduce access remote
 cpu elem support in BPF percpu map
To:     Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, jolsa@kernel.org, davemarchevsky@fb.com,
        joannekoong@fb.com, geliang.tang@suse.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com, wangdongdong.6@bytedance.com,
        cong.wang@bytedance.com, zhouchengming@bytedance.com,
        yosryahmed@google.com
References: <20220513063952.41794-1-zhoufeng.zf@bytedance.com>
 <d8447eee-31d0-f730-bc31-7e55c76135f4@iogearbox.net>
From:   Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <d8447eee-31d0-f730-bc31-7e55c76135f4@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

在 2022/5/13 下午11:01, Daniel Borkmann 写道:
> On 5/13/22 8:39 AM, Feng zhou wrote:
> [...]
>> Changelog:
>> ----------
>> v2->v3: Addressed comments from Andrii Nakryiko.
>> - use /* */ instead of //
>> - use libbpf_num_possible_cpus() instead of 
>> sysconf(_SC_NPROCESSORS_ONLN)
>> - use 8 bytes for value size
>> - fix memory leak
>> - use ASSERT_EQ instead of ASSERT_OK
>> - add bpf_loop to fetch values on each possible CPU
>> some details in here:
>> https://lore.kernel.org/lkml/20220511093854.411-1-zhoufeng.zf@bytedance.com/T/ 
>>
>
> The v2 of your series is already in bpf-next tree, please just send a 
> relative diff for
> the selftest patch.
>
> https://lore.kernel.org/lkml/165231901346.29050.11394051230756915389.git-patchwork-notify@kernel.org/ 
>
>
> Thanks,
> Daniel

Ok, will do. Thanks.


