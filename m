Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6251838C8
	for <lists+bpf@lfdr.de>; Thu, 12 Mar 2020 19:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgCLSfC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Mar 2020 14:35:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46052 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCLSfB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 14:35:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id m9so8775812wro.12
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2020 11:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vqOH/ApzhE1GsStgWa3AN9KCXAWaVnm1Zj8Pwlsg60E=;
        b=fP9KuflxrryIn+5pZozn4Q28vactWefA94r7J0yreVYrF83YmcErDDOxqbe1/6X6BG
         LfXM5L9kNfquEW+wWqhU6Qa9AT3cz65TQuUXFLQr0PVMsYO92d47NyKCwEi/mQebrVr+
         Oz06h05hkdu1jDLDwbRTKTS7tPDoxKBAwL75c7uZhtHn80c6+Ylq2/9RO7BOcLTkMty0
         cMQg/srni7Emy5NuNgqC7pxXyqBZK44LSvfoHdQpYRSAA3o8K7lYlPmyU28yuAvrRacr
         J6RTbzfCgFW/a/ccU7Sy5VKf7NomC/I2zloLhGGXE0DbfIra+jUKS5EsWIVFRVv9tHYZ
         k6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vqOH/ApzhE1GsStgWa3AN9KCXAWaVnm1Zj8Pwlsg60E=;
        b=d94UiVyF3byewHQG8Bxr4n6npAcRUmj4cs2UsI3dNiKqmva/JubFX0mOHN+5YsZqm2
         5rcvVK/wLlBiCAIFmsELwIloIRL4IjnBdLKjqMUxeyXP/U49i7MPPGRCAwbG4RkiWqb6
         eK6HOektDL6Y04MfKpeuZPDSVpAW0UBe33vFZymgYmHBj2stxF4Au9+w3V5EQHBqjA43
         P2ySaNC8xwdyHqpbvKO9eM5jA1pBv3rpc5sBXPbwqIVqeUyuTjXIvkaIP3c0q6o+kF2V
         2boIxH24HwICJTQIbXbfmD9+AaEJgxwhLpsiKuoJ1NR6dIVmtLn5VDl3yZcv+2I2gd9b
         +eLQ==
X-Gm-Message-State: ANhLgQ3IEw5a8gSDTpYkN5rM7DOO+6SzKe9hd5Wr/rEMnZXpby29AqoH
        G5r1aXbopegeqQYHE95jiPzSOg==
X-Google-Smtp-Source: ADFU+vue+qZSYgrylO5YludGLK2vjjWa1843ejQFzf2MNUsjd3lZfjOsK3ZG7u+Pmx/HFVP+ne/3oQ==
X-Received: by 2002:adf:de8b:: with SMTP id w11mr8153955wrl.258.1584038099806;
        Thu, 12 Mar 2020 11:34:59 -0700 (PDT)
Received: from [192.168.1.10] ([194.35.118.177])
        by smtp.gmail.com with ESMTPSA id k12sm16547357wrv.88.2020.03.12.11.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 11:34:59 -0700 (PDT)
Subject: Re: [PATCH bpf] libbpf: add null pointer check in
 bpf_object__init_user_btf_maps()
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Michal Rostecki <mrostecki@opensuse.org>
References: <20200312140357.20174-1-quentin@isovalent.com>
 <1fff03e7-e52b-edcc-d427-f912bf0a4af2@iogearbox.net>
 <CAEf4BzaQdv8s4cGp=ouitxczzWV1E1WeuxktDTp5JFkXXkRU=w@mail.gmail.com>
 <4a17add0-6756-a60c-7c5b-9ffe45ff4060@iogearbox.net>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <bbf55383-7f20-2a4a-52c6-ffe26c153006@isovalent.com>
Date:   Thu, 12 Mar 2020 18:34:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4a17add0-6756-a60c-7c5b-9ffe45ff4060@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-03-12 19:21 UTC+0100 ~ Daniel Borkmann <daniel@iogearbox.net>
> On 3/12/20 6:54 PM, Andrii Nakryiko wrote:
>> On Thu, Mar 12, 2020 at 8:38 AM Daniel Borkmann <daniel@iogearbox.net>
>> wrote:
>>> On 3/12/20 3:03 PM, Quentin Monnet wrote:
>>>> When compiling bpftool with clang 7, after the addition of its recent
>>>> "bpftool prog profile" feature, Michal reported a segfault. This
>>>> occurred while the build process was attempting to generate the
>>>> skeleton needed for the profiling program, with the following command:
>>>>
>>>>       ./_bpftool gen skeleton skeleton/profiler.bpf.o > profiler.skel.h
>>>>
>>>> Tracing the error showed that bpf_object__init_user_btf_maps() does no
>>>> verification on obj->btf before passing it to btf__get_nr_types(),
>>>> where
>>>> btf is dereferenced. Libbpf considers BTF information should be here
>>>> because of the presence of a ".maps" section in the object file (hence
>>>> the check on "obj->efile.btf_maps_shndx < 0" fails and we do not exit
>>>> from the function early), but it was unable to load BTF info as
>>>> there is
>>>> no .BTF section.
>>>>
>>>> Add a null pointer check and error out if the pointer is null. The
>>>> final
>>>> bpftool executable still fails to build, but at least we have a proper
>>>> error and no more segfault.
>>>>
>>>> Fixes: abd29c931459 ("libbpf: allow specifying map definitions using
>>>> BTF")
>>>> Cc: Andrii Nakryiko <andriin@fb.com>
>>>> Reported-by: Michal Rostecki <mrostecki@opensuse.org>
>>>> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
>>>
>>> Applied to bpf-next, thanks! Note ...
>>
>> I don't think this is the right fix. The problem was in my
>> 5327644614a1 ("libbpf: Relax check whether BTF is mandatory") commit.
>> I've removed "mandatory" status of BTF if .maps is present. But that's
>> not right. We have the need for BTF at two levels: for libbpf itself
>> and for kernel, those are overlapping, but not exactly the same. BTF
>> is needed for libbpf when .maps, .struct_ops and externs are present.
>> But kernel needs it only for when .struct_ops are present. Right now
>> those checks are conflated together. Proper fix would be to separate
>> them. Can we please undo this patch? I'll post a proper fix shortly.
> 
> Ok, please send a proper fix for 5327644614a1 then. Tossed off the tree.

I suspected there was something like this and was only mildly satisfied
with my solution to be honest... Thank you Andrii for taking over!

Quentin
