Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C79660956
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 23:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbjAFWMD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 17:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjAFWMC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 17:12:02 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1CD35911;
        Fri,  6 Jan 2023 14:12:01 -0800 (PST)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pDuwJ-000AGE-3n; Fri, 06 Jan 2023 23:11:51 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pDuwI-0006S9-Kh; Fri, 06 Jan 2023 23:11:50 +0100
Subject: Re: [PATCH] bpf_doc: Fix build error with older python versions
To:     Quentin Monnet <quentin@isovalent.com>,
        Michal Suchanek <msuchanek@suse.de>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20230106114037.25036-1-msuchanek@suse.de>
 <c8020dc5-e911-e9a1-a269-5fbcb682f346@isovalent.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <521abe2f-1aa3-563f-48ec-c016450602d9@iogearbox.net>
Date:   Fri, 6 Jan 2023 23:11:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c8020dc5-e911-e9a1-a269-5fbcb682f346@isovalent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26773/Fri Jan  6 09:48:44 2023)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/6/23 1:11 PM, Quentin Monnet wrote:
> 2023-01-06 12:40 UTC+0100 ~ Michal Suchanek <msuchanek@suse.de>
>> + make -j48 -s -C /dev/shm/kbuild/linux.33946/current ARCH=powerpc HOSTCC=gcc CROSS_COMPILE=powerpc64-suse-linux- clean
>> TypeError: '_sre.SRE_Match' object is not subscriptable
>>
>> Fixes: 8a76145a2ec2 ("bpf: explicitly define BPF_FUNC_xxx integer values")
>>
>> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>> ---
>>   scripts/bpf_doc.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
>> index e8d90829f23e..38d51e05c7a2 100755
>> --- a/scripts/bpf_doc.py
>> +++ b/scripts/bpf_doc.py
>> @@ -271,7 +271,7 @@ class HeaderParser(object):
>>               if capture:
>>                   fn_defines_str += self.line
>>                   helper_name = capture.expand(r'bpf_\1')
>> -                self.helper_enum_vals[helper_name] = int(capture[2])
>> +                self.helper_enum_vals[helper_name] = int(capture.group(2))
>>                   self.helper_enum_pos[helper_name] = i
>>                   i += 1
>>               else:
> 
> Thanks, the change looks good.
> 
> Acked-by: Quentin Monnet <quentin@isovalent.com>
> 
> Would be nice to have a bit more context in the commit log: As I
> understand, Match objects have been scriptable since Python 3.6 (2016).
> 
> Reference: https://docs.python.org/3/whatsnew/3.6.html#re

Agree, Michal, could you improve the commit description as it's a bit terse
as-is and then resubmit your patch.

Thanks,
Daniel
