Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C0C28428B
	for <lists+bpf@lfdr.de>; Tue,  6 Oct 2020 00:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgJEWdj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Oct 2020 18:33:39 -0400
Received: from www62.your-server.de ([213.133.104.62]:37680 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgJEWde (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Oct 2020 18:33:34 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1kPZ2x-0003ZM-Pp; Tue, 06 Oct 2020 00:33:31 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kPZ2x-000FEc-K7; Tue, 06 Oct 2020 00:33:31 +0200
Subject: Re: [PATCH v2] use valid btf in bpf_program__set_attach_target(prog,
 0, ...);
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Luigi Rizzo <lrizzo@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Eelco Chaudron <echaudro@redhat.com>,
        Petar Penkov <ppenkov@google.com>
References: <20201005163934.331875-1-lrizzo@google.com>
 <CAEf4BzZq8t0XZy5Z6SBHAURJBxuDBPdU9amsJ0z0os7TE-cjoQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e7f55966-41ab-2953-d78d-630463b896c2@iogearbox.net>
Date:   Tue, 6 Oct 2020 00:33:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZq8t0XZy5Z6SBHAURJBxuDBPdU9amsJ0z0os7TE-cjoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25948/Mon Oct  5 16:02:22 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/5/20 9:21 PM, Andrii Nakryiko wrote:
> On Mon, Oct 5, 2020 at 9:40 AM Luigi Rizzo <lrizzo@google.com> wrote:
>>
>> bpf_program__set_attach_target() will always fail with fd=0 (attach to a
>> kernel symbol) because obj->btf_vmlinux is NULL and there is no way to
>> set it.
>>
>> Fix this by using libbpf_find_vmlinux_btf_id()
>>
>> (on a side note: it is unclear whether btf_vmlinux is meant to be
>> just temporary storage for use in bpf_object__load_xattr(), or
>> a property of bpf_object, in which case it could be initialuzed
>> opportunistically, and properly released in bpf_object__close() ).
> 
> It's more of a former. vmlinux BTF shouldn't be needed past
> bpf_object's load phase, so there is no need to keep a few megabytes
> of memory laying around needlessly.

Could you send a v3 with updated commit message wrt side note and prepend
e.g. 'bpf, libbpf: ' into subject prefix?

Please also carry Andrii's ACK forward.

>> Signed-off-by: Luigi Rizzo <lrizzo@google.com>
>> ---
>>   tools/lib/bpf/libbpf.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index a4f55f8a460d..33bf102259dd 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -10353,9 +10353,8 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
>>                  btf_id = libbpf_find_prog_btf_id(attach_func_name,
>>                                                   attach_prog_fd);
>>          else
>> -               btf_id = __find_vmlinux_btf_id(prog->obj->btf_vmlinux,
>> -                                              attach_func_name,
>> -                                              prog->expected_attach_type);
>> +               btf_id = libbpf_find_vmlinux_btf_id(attach_func_name,
>> +                                                   prog->expected_attach_type);
> 
> It's a bit inefficient, if you need to do this for a few programs, but
> it's ok as a fix. We'll need to unify this internal vmlinux BTF
> caching at some point.
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
> 
>>
>>          if (btf_id < 0)
>>                  return btf_id;
>> --
>> 2.28.0.806.g8561365e88-goog
>>

