Return-Path: <bpf+bounces-13319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845FA7D83D0
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 15:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63DB1C20F40
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 13:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995F92E3F8;
	Thu, 26 Oct 2023 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="OZ1m1qoe"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4F42DF96
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 13:46:37 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52064CC
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 06:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YvmjIUhV4rHRg93ReoUpM6PAQbemhV7mFRJWUa48PBY=; b=OZ1m1qoeEeSjFm/N8zgW5wRDLU
	PWwCX57WneTGs8U68gIynw3lZn2QV5oOEfzhTL1DbvCtRBhiCVt9GvPXxhRLy/xiREM/iby9shgED
	P6YDziU35Y/bcQAf8kV68ebAQX+lkVsvsXmyzyx9VdkDTugvJ99jCxrkhAPLRHKBAZ2VDE/r+es8b
	cfiFHbZ3R2KfDsmce7oW2MHmIncDvpabYrkPW5WqwEljL1qcP6v5bY0NJQe1Z/JaktUKQWJUgE05p
	0hynhit6ZdBiVQkkkLuF32g/0jHpzDwAqmIt7S5Rha7V+J1HpQ6hM+3OLOowbi13lrkLI1sJp9vxx
	6PTPfA5A==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qw0gx-000BIL-IG; Thu, 26 Oct 2023 15:46:31 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qw0gw-0000Yk-R6; Thu, 26 Oct 2023 15:46:30 +0200
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: Fix selftests broken by
 mitigations=off
To: Yonghong Song <yonghong.song@linux.dev>,
 Yafang Shao <laoar.shao@gmail.com>, alexei.starovoitov@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 gerhorst@cs.fau.de, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, martin.lau@linux.dev, sdf@google.com,
 song@kernel.org
References: <CAADnVQKUBJqg+hHtbLeeC2jhoJAWqnmRAzXW3hmUCNSV9kx4sQ@mail.gmail.com>
 <20231025031144.5508-1-laoar.shao@gmail.com>
 <e6c950d7-bb81-4265-bbbe-0201694280b3@linux.dev>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3f47542a-ec0f-c33c-4300-36b54858a79c@iogearbox.net>
Date: Thu, 26 Oct 2023 15:46:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e6c950d7-bb81-4265-bbbe-0201694280b3@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27073/Thu Oct 26 09:47:53 2023)

On 10/25/23 6:56 AM, Yonghong Song wrote:
> On 10/24/23 8:11 PM, Yafang Shao wrote:
>> When we configure the kernel command line with 'mitigations=off' and set
>> the sysctl knob 'kernel.unprivileged_bpf_disabled' to 0, the commit
>> bc5bc309db45 ("bpf: Inherit system settings for CPU security mitigations")
>> causes issues in the execution of `test_progs -t verifier`. This is because
>> 'mitigations=off' bypasses Spectre v1 and Spectre v4 protections.
>>
>> Currently, when a program requests to run in unprivileged mode
>> (kernel.unprivileged_bpf_disabled = 0), the BPF verifier may prevent it
>> from running due to the following conditions not being enabled:
>>
>>    - bypass_spec_v1
>>    - bypass_spec_v4
>>    - allow_ptr_leaks
>>    - allow_uninit_stack
>>
>> While 'mitigations=off' enables the first two conditions, it does not
>> enable the latter two. As a result, some test cases in
>> 'test_progs -t verifier' that were expected to fail to run may run
>> successfully, while others still fail but with different error messages.
>> This makes it challenging to address them comprehensively.
>>
>> Moreover, in the future, we may introduce more fine-grained control over
>> CPU mitigations, such as enabling only bypass_spec_v1 or bypass_spec_v4.
>>
>> Given the complexity of the situation, rather than fixing each broken test
>> case individually, it's preferable to skip them when 'mitigations=off' is
>> in effect and introduce specific test cases for the new 'mitigations=off'
>> scenario. For instance, we can introduce new BTF declaration tags like
>> '__failure__nospec', '__failure_nospecv1' and '__failure_nospecv4'.
>>
>> In this patch, the approach is to simply skip the broken test cases when
>> 'mitigations=off' is enabled. The result of `test_progs -t verifier` as
>> follows after this commit,
>>
>> Before this commit
>> ==================
>> - without 'mitigations=off'
>>    - kernel.unprivileged_bpf_disabled = 2
>>      Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
>>    - kernel.unprivileged_bpf_disabled = 0
>>      Summary: 74/1336 PASSED, 0 SKIPPED, 0 FAILED   <<<<
>> - with 'mitigations=off'
>>    - kernel.unprivileged_bpf_disabled = 2
>>      Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
>>    - kernel.unprivileged_bpf_disabled = 0
>>      Summary: 63/1276 PASSED, 0 SKIPPED, 11 FAILED   <<<< 11 FAILED
>>
>> After this commit
>> =================
>> - without 'mitigations=off'
>>    - kernel.unprivileged_bpf_disabled = 2
>>      Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
>>    - kernel.unprivileged_bpf_disabled = 0
>>      Summary: 74/1336 PASSED, 0 SKIPPED, 0 FAILED    <<<<
>> - with this patch, with 'mitigations=off'
>>    - kernel.unprivileged_bpf_disabled = 2
>>      Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
>>    - kernel.unprivileged_bpf_disabled = 0
>>      Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED   <<<< SKIPPED
>>
>> Fixes: bc5bc309db45 ("bpf: Inherit system settings for CPU security mitigations")
>> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Closes: https://lore.kernel.org/bpf/CAADnVQKUBJqg+hHtbLeeC2jhoJAWqnmRAzXW3hmUCNSV9kx4sQ@mail.gmail.com
>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> 
> Ack with a nit below.
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> 
[...]
>>       }
>> -    return disabled;
>> +    return disabled ? true : get_mitigations_off();
> 
> Above code is correct. But you could slightly simplify it with
>      return disabled ? : get_mitigations_off();
> 
> I guess maintainer can decide whether simplification is needed
> or not.

Turns out if you omit, then compiler will complain with a warning :)

   [...]
   GEN      vmlinux.h
unpriv_helpers.c: In function ‘get_unpriv_disabled’:
unpriv_helpers.c:56:27: error: the omitted middle operand in ‘?:’ will always be ‘true’, suggest explicit middle operand [-Werror=parentheses]
    56 |         return disabled ? : get_mitigations_off();
       |                           ^
cc1: all warnings being treated as errors
make: *** [Makefile:615: /root/linux/tools/testing/selftests/bpf/unpriv_helpers.o] Error 1

So it's okay as is, applied, thanks!

