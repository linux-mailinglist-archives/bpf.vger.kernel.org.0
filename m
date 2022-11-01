Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF99614BFE
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 14:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiKANrK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 09:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKANrJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 09:47:09 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E68DF9A;
        Tue,  1 Nov 2022 06:47:08 -0700 (PDT)
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oprbT-000Bjd-Nz; Tue, 01 Nov 2022 14:46:55 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oprbT-000CPs-6k; Tue, 01 Nov 2022 14:46:55 +0100
Subject: Re: [PATCH bpf-next v2 1/3] bpf/verifier: Fix potential memory leak
 in array reallocation
To:     Bill Wendling <morbo@google.com>, Kees Cook <keescook@chromium.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Lorenz Bauer <oss@lmb.io>
References: <20221029024444.gonna.633-kees@kernel.org>
 <20221029025433.2533810-1-keescook@chromium.org>
 <CAGG=3QXYVwQ5pwARdGTenm-mDQn4Tcz6U-=EZ8BDcwBkM5bFfg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2c6203ac-de2a-607e-0589-0a69f91e0479@iogearbox.net>
Date:   Tue, 1 Nov 2022 14:46:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAGG=3QXYVwQ5pwARdGTenm-mDQn4Tcz6U-=EZ8BDcwBkM5bFfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26706/Tue Nov  1 08:52:34 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[ +Lorenz ]

On 10/31/22 9:16 PM, Bill Wendling wrote:
> On Fri, Oct 28, 2022 at 7:55 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> If an error (NULL) is returned by krealloc(), callers of realloc_array()
>> were setting their allocation pointers to NULL, but on error krealloc()
>> does not touch the original allocation. This would result in a memory
>> resource leak. Instead, free the old allocation on the error handling
>> path.
>>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: John Fastabend <john.fastabend@gmail.com>
>> Cc: Andrii Nakryiko <andrii@kernel.org>
>> Cc: Martin KaFai Lau <martin.lau@linux.dev>
>> Cc: Song Liu <song@kernel.org>
>> Cc: Yonghong Song <yhs@fb.com>
>> Cc: KP Singh <kpsingh@kernel.org>
>> Cc: Stanislav Fomichev <sdf@google.com>
>> Cc: Hao Luo <haoluo@google.com>
>> Cc: Jiri Olsa <jolsa@kernel.org>
>> Cc: bpf@vger.kernel.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Reviewed-by: Bill Wendling <morbo@google.com>
> 
>> ---
>>   kernel/bpf/verifier.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 014ee0953dbd..eb8c34db74c7 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -1027,12 +1027,17 @@ static void *copy_array(void *dst, const void *src, size_t n, size_t size, gfp_t
>>    */
>>   static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
>>   {
>> +       void *new_arr;
>> +
>>          if (!new_n || old_n == new_n)
>>                  goto out;
>>
>> -       arr = krealloc_array(arr, new_n, size, GFP_KERNEL);
>> -       if (!arr)
>> +       new_arr = krealloc_array(arr, new_n, size, GFP_KERNEL);
>> +       if (!new_arr) {
>> +               kfree(arr);
>>                  return NULL;
>> +       }
>> +       arr = new_arr;

Fyi, I took this fix into bpf tree and improved commit log a bit with the
one from Zhengchao [0] given yours came in first. Fixes tag would have been
nice, I added the c69431aab67a to the commit message while applying.

   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20221031070812.339883-1-shaozhengchao@huawei.com/

>>          if (new_n > old_n)
>>                  memset(arr + old_n * size, 0, (new_n - old_n) * size);
>> --
>> 2.34.1
>>

