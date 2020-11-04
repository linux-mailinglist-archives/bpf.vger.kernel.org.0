Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101252A70A0
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 23:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgKDWgY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 17:36:24 -0500
Received: from www62.your-server.de ([213.133.104.62]:41912 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732336AbgKDWgY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 17:36:24 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1kaROA-0003hM-3h; Wed, 04 Nov 2020 23:36:22 +0100
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kaRO9-0003yU-Tn; Wed, 04 Nov 2020 23:36:21 +0100
Subject: Re: [PATCH bpf-next] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
To:     Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org
Cc:     kernel-team@fb.com, mhiramat@kernel.org
References: <C6UR9QUUYXKW.3PHSMQ3EXUYI3@maharaja>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7d1a34fa-2475-0958-37fe-ed416249bc4b@iogearbox.net>
Date:   Wed, 4 Nov 2020 23:36:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <C6UR9QUUYXKW.3PHSMQ3EXUYI3@maharaja>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25978/Wed Nov  4 14:18:13 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/4/20 9:18 PM, Daniel Xu wrote:
> On Wed Nov 4, 2020 at 8:24 AM PST, Daniel Borkmann wrote:
>> On 11/4/20 3:29 AM, Daniel Xu wrote:
>>> do_strncpy_from_user() may copy some extra bytes after the NUL
>>> terminator into the destination buffer. This usually does not matter for
>>> normal string operations. However, when BPF programs key BPF maps with
>>> strings, this matters a lot.
>>>
>>> A BPF program may read strings from user memory by calling the
>>> bpf_probe_read_user_str() helper which eventually calls
>>> do_strncpy_from_user(). The program can then key a map with the
>>> resulting string. BPF map keys are fixed-width and string-agnostic,
>>> meaning that map keys are treated as a set of bytes.
>>>
>>> The issue is when do_strncpy_from_user() overcopies bytes after the NUL
>>> terminator, it can result in seemingly identical strings occupying
>>> multiple slots in a BPF map. This behavior is subtle and totally
>>> unexpected by the user.
>>>
>>> This commit uses the proper word-at-a-time APIs to avoid overcopying.
>>>
>>> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
>>
>> It looks like this is a regression from the recent refactoring of the
>> mem probing
>> util functions?
> 
> I think it was like this from the beginning, at 6ae08ae3dea2 ("bpf: Add
> probe_read_{user, kernel} and probe_read_{user, kernel}_str helpers").
> The old bpf_probe_read_str() used the kernel's byte-by-byte copying
> routine. bpf_probe_read_user_str() started using strncpy_from_user()
> which has been doing the long-sized strides since ~2012 or earlier.
> 
> I tried to build and test the kernel at that commit but it seems my
> compiler is too new to build that old code. Bunch of build failures.
> 
> I assume the refactor you're referring to is 8d92db5c04d1 ("bpf: rework
> the compat kernel probe handling").

Ah I see, it was just reusing 3d7081822f7f ("uaccess: Add non-pagefault user-space
read functions"). Potentially it might be safer choice to just rework the
strncpy_from_user_nofault() to mimic strncpy_from_kernel_nofault() in that
regard?

>> Could we add a Fixes tag and then we'd also need to target the fix
>> against bpf tree instead of bpf-next, no?
> 
> Sure, will do in v2.
> 
>> Moreover, a BPF kselftest would help to make sure it doesn't regress in
>> future again.
> 
> Ditto.
> 
> [..]
> 
> Thanks,
> Daniel
> 

