Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2451F105B48
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2019 21:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKUUnD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Nov 2019 15:43:03 -0500
Received: from www62.your-server.de ([213.133.104.62]:56904 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUUnD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Nov 2019 15:43:03 -0500
Received: from sslproxy01.your-server.de ([88.198.220.130])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iXtI1-0007A4-3f; Thu, 21 Nov 2019 21:42:57 +0100
Received: from [178.197.248.30] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1iXtI0-0000SJ-KO; Thu, 21 Nov 2019 21:42:56 +0100
Subject: Re: Fw: [Bug 205469] New: x86_32: bpf: multiple test_bpf failures
 using eBPF JIT
To:     Greg KH <greg@kroah.com>
Cc:     Wang YanQing <udknight@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
References: <20191108075711.115a5f94@hermes.lan>
 <08b98fbd-f295-3a94-8b3e-70790179290c@iogearbox.net>
 <20191109183602.GA1033@udknight>
 <69c1fa5e-7385-fe8d-ac17-42d22db84cf4@iogearbox.net>
 <20191121203706.GD813260@kroah.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b5f589e6-d105-fa98-efce-0b088ff4da6a@iogearbox.net>
Date:   Thu, 21 Nov 2019 21:42:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191121203706.GD813260@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25640/Thu Nov 21 11:08:44 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/21/19 9:37 PM, Greg KH wrote:
> On Mon, Nov 11, 2019 at 01:56:31PM +0100, Daniel Borkmann wrote:
>> On 11/9/19 7:36 PM, Wang YanQing wrote:
>>> On Sat, Nov 09, 2019 at 12:37:49AM +0100, Daniel Borkmann wrote:
>>>> [ Cc Wang (x86_32 BPF JIT maintainer) ]
>>>>
>>>> On 11/8/19 4:57 PM, Stephen Hemminger wrote:
>>>>>
>>>>> Begin forwarded message:
>>>>>
>>>>> Date: Fri, 08 Nov 2019 07:35:59 +0000
>>>>> From: bugzilla-daemon@bugzilla.kernel.org
>>>>> To: stephen@networkplumber.org
>>>>> Subject: [Bug 205469] New: x86_32: bpf: multiple test_bpf failures using eBPF JIT
>>>>>
>>>>>
>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=205469
>>>>>
>>>>>                Bug ID: 205469
>>>>>               Summary: x86_32: bpf: multiple test_bpf failures using eBPF JIT
>>>>>               Product: Networking
>>>>>               Version: 2.5
>>>>>        Kernel Version: 4.19.81 LTS
>>>>>              Hardware: i386
>>>>>                    OS: Linux
>>>>>                  Tree: Mainline
>>>>>                Status: NEW
>>>>>              Severity: normal
>>>>>              Priority: P1
>>>>>             Component: Other
>>>>>              Assignee: stephen@networkplumber.org
>>>>>              Reporter: itugrok@yahoo.com
>>>>>                    CC: itugrok@yahoo.com
>>>>>            Regression: No
>>>>>
>>>>> Created attachment 285829
>>>>>      --> https://bugzilla.kernel.org/attachment.cgi?id=285829&action=edit
>>>>> test_bpf failures: kernel 4.19.81/x86_32 (OpenWrt)
>>>>>
>>>>> Summary:
>>>>> ========
>>>>>
>>>>> Running the 4.19.81 LTS kernel on QEMU/x86_32, the standard test_bpf.ko
>>>>> testsuite generates multiple errors with the eBPF JIT enabled:
>>>>>
>>>>>      ...
>>>>>      test_bpf: #32 JSET jited:1 40 ret 0 != 20 46 FAIL
>>>>>      test_bpf: #321 LD_IND word positive offset jited:1 ret 0 != -291897430 FAIL
>>>>>      test_bpf: #322 LD_IND word negative offset jited:1 ret 0 != -1437222042 FAIL
>>>>>      test_bpf: #323 LD_IND word unaligned (addr & 3 == 2) jited:1 ret 0 !=
>>>>> -1150890889 FAIL
>>>>>      test_bpf: #326 LD_IND word positive offset, all ff jited:1 ret 0 != -1 FAIL
>>>>>      ...
>>>>>      test_bpf: Summary: 373 PASSED, 5 FAILED, [344/366 JIT'ed]
>>>>>
>>>>> However, with eBPF JIT disabled (net.core.bpf_jit_enable=0) all tests pass.
>>>>>
>>>>>
>>>>> Steps to Reproduce:
>>>>> ===================
>>>>>
>>>>>      # sysctl net.core.bpf_jit_enable=1
>>>>>      # modprobe test_bpf
>>>>>      <Kernel log with failures and test summary>
>>>>>
>>>>>
>>>>> Affected Systems Tested:
>>>>> ========================
>>>>>
>>>>>      OpenWrt master on QEMU/pc-q35(x86_32) [LTS kernel 4.19.81]
>>>>>
>>>>>
>>>>> Kernel Logs:
>>>>> ============
>>>>>
>>>>> Boot log with test results is attached.
>>>>>
>>>
>>> Hi Daniel Borkmann!
>>>
>>> I have tested and verified that the report bug has been fixed by commit
>>> 711aef1bbf88 ("bpf, x32: Fix bug for BPF_JMP | {BPF_JSGT, BPF_JSLE, BPF_JSLT, BPF_JSGE}")
>>>
>>> But that fix hasn't been backport to stable trees, so maybe we should do it:)
>>
>> Yes, given you have access to a x32 setup and are also able to runtime test the backported
>> JIT changes, please submit it to stable with us in Cc. Thanks Wang!
> 
> Backporting this would be nice if someone could do it :)

It landed on the stable list today:

https://lore.kernel.org/stable/20191121074336.GA15326@udknight/
https://lore.kernel.org/stable/20191121074725.GA15476@udknight/
https://lore.kernel.org/stable/20191121074511.GC15326@udknight/
https://lore.kernel.org/stable/20191121074452.GB15326@udknight/

Thanks,
Daniel
