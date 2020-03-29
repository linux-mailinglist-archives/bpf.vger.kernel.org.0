Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE6B196A30
	for <lists+bpf@lfdr.de>; Sun, 29 Mar 2020 01:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgC2APZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Mar 2020 20:15:25 -0400
Received: from www62.your-server.de ([213.133.104.62]:58768 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgC2APZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Mar 2020 20:15:25 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jILbm-0005Oc-Ov; Sun, 29 Mar 2020 01:15:22 +0100
Received: from [178.195.186.98] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jILbm-000IV8-Bo; Sun, 29 Mar 2020 01:15:22 +0100
Subject: Re: [PATCH bpf-next v8 0/8] MAC and Audit policy using eBPF (KRSI)
To:     KP Singh <kpsingh@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200327192854.31150-1-kpsingh@chromium.org>
 <4e5a09bb-04c4-39b8-10d4-59496ffb5eee@iogearbox.net>
 <20200328195636.GA95544@google.com> <202003281449.333BDAF6@keescook>
 <CACYkzJ4v_X87-+GCE++g0_BkcJWFhbNePAMQmH8Ccgq7id-akA@mail.gmail.com>
 <20200329000738.GA230422@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bf04019c-b0d0-5aff-be72-32e46b60daea@iogearbox.net>
Date:   Sun, 29 Mar 2020 01:15:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200329000738.GA230422@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25765/Sat Mar 28 14:16:42 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/29/20 1:07 AM, KP Singh wrote:
> On 28-Mar 23:30, KP Singh wrote:
>> On Sat, Mar 28, 2020 at 10:50 PM Kees Cook <keescook@chromium.org> wrote:
>>>
>>> On Sat, Mar 28, 2020 at 08:56:36PM +0100, KP Singh wrote:
>>>> Since the attachment succeeds and the hook does not get called, it
>>>> seems like "bpf" LSM is not being initialized and the hook, although
>>>> present, does not get called.
>>>>
>>>> This indicates that "bpf" is not in CONFIG_LSM. It should, however, be
>>>> there by default as we added it to default value of CONFIG_LSM and
>>>> also for other DEFAULT_SECURITY_* options.
>>>>
>>>> Let me know if that's the case and it fixes it.
>>>
>>> Is the selftest expected to at least fail cleanly (i.e. not segfault)
>>
>> I am not sure where the crash comes from, it does not look like it's test_lsm,
>> it seems to happen in test_overhead. Both seem to run fine for me.
> 
> So I was able to reproduce the crash:
> 
> * Remove "bpf" from CONFIG_LSM
> 
> ./test_progs -n 66,67
> test_test_lsm:PASS:skel_load 0 nsec
> test_test_lsm:PASS:attach 0 nsec
> test_test_lsm:PASS:exec_cmd 0 nsec
> test_test_lsm:FAIL:bprm_count bprm_count = 0
> test_test_lsm:FAIL:heap_mprotect want errno=EPERM, got 0
> #66 test_lsm:FAIL
> Caught signal #11!
> Stack trace:
> ./test_progs(crash_handler+0x1f)[0x55b7f9867acf]
> /lib/x86_64-linux-gnu/libpthread.so.0(+0x13520)[0x7fcf1467e520]
> /lib/x86_64-linux-gnu/libc.so.6(+0x15f73d)[0x7fcf1460a73d]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_calloc+0x2ca)[0x7fcf1453286a]
> /usr/lib/x86_64-linux-gnu/libelf.so.1(+0x37
> 
> [snip]
> 
> * The crash went away when I removed the heap_mprotect call, now the BPF
>    hook attached did not allow this operation, so it had no side-effects.
>    Which lead me to believe the crash could be a side-effect of this
>    operation. So I did:
> 
> --- a/tools/testing/selftests/bpf/prog_tests/test_lsm.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
> @@ -29,7 +29,7 @@ int heap_mprotect(void)
>          if (buf == NULL)
>                  return -ENOMEM;
> 
> -       ret = mprotect(buf, sz, PROT_READ | PROT_EXEC);
> +       ret = mprotect(buf, sz, PROT_READ | PROT_WRITE | PROT_EXEC);
>          free(buf);
>          return ret;
>   }
> 
> and the crash went away. Which made me realize that the free
> operation does not like memory without PROT_WRITE, So I did this:
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_lsm.c b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
> index fcd839e88540..78f125cc09b3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_lsm.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
> @@ -30,7 +30,7 @@ int heap_mprotect(void)
>                  return -ENOMEM;
> 
>          ret = mprotect(buf, sz, PROT_READ | PROT_EXEC);
> -       free(buf);
> +       // free(buf);
>          return ret;
>   }
> 
> and the crash went away as well. So it indeed was a combination of:
> 
> * CONFIG_LSM not enabling the hook
> * mprotect marking the memory as non-writeable
> * free being called on the memory.
> 
> I will send a v9 which has the PROT_WRITE on the mprotect. Thanks
> for noticing this!

And also explains the stack trace for __libc_calloc() where it's trying to zero the
area later on.

Thanks for the quick debugging,
Daniel
