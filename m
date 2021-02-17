Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474BA31D375
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 01:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhBQAi2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Feb 2021 19:38:28 -0500
Received: from www62.your-server.de ([213.133.104.62]:55278 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhBQAi2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Feb 2021 19:38:28 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lCAqZ-00029N-B4; Wed, 17 Feb 2021 01:37:39 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lCAqZ-00099q-38; Wed, 17 Feb 2021 01:37:39 +0100
Subject: Re: [PATCH] bpf: fix a warning message in mark_ptr_not_null_reg()
To:     KP Singh <kpsingh@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Dmitrii Banshchikov <me@ubique.spb.ru>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <YCwewjRBJIBm0sew@mwanda>
 <CACYkzJ55Ze+aA+qKA8bf=iqNY01H=MuDCKVmn44fLVW1670RxA@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <04c60ed2-1a96-2835-9ae1-0ba84f482362@iogearbox.net>
Date:   Wed, 17 Feb 2021 01:37:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACYkzJ55Ze+aA+qKA8bf=iqNY01H=MuDCKVmn44fLVW1670RxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26082/Tue Feb 16 13:17:58 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/16/21 10:10 PM, KP Singh wrote:
> On Tue, Feb 16, 2021 at 8:37 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>
>> The WARN_ON() argument is a condition, and it generates a stack trace
>> but it doesn't print the warning.
>>
>> Fixes: 4ddb74165ae5 ("bpf: Extract nullable reg type conversion into a helper function")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>>   kernel/bpf/verifier.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 056df6be3e30..bd4d1dfca73c 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -1120,7 +1120,7 @@ static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
>>                  reg->type = PTR_TO_RDWR_BUF;
>>                  break;
>>          default:
>> -               WARN_ON("unknown nullable register type");
>> +               WARN(1, "unknown nullable register type");
> 
> Should we use WARN_ONCE here? Also, I think the fix should be targeted
> for bpf-next as
> the patch that introduced this hasn't made it to bpf yet.
> 
> [...]

Usually we have something like `verbose(env, "kernel subsystem misconfigured verifier\n")`,
but in this case we'd need to drag env all the way to here. :/ I agree with WARN_ONCE().
