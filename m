Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA29183697
	for <lists+bpf@lfdr.de>; Thu, 12 Mar 2020 17:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgCLQvG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Mar 2020 12:51:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44543 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCLQvD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 12:51:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id l18so8352247wru.11
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2020 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MhydNQiE/AolI5ojwjBPP77Pewh/KDq1Wx+Fw4AlEOg=;
        b=1XXRGWhMfakwGa7OjKjEXl2QbqbDYMZUFuj1wHxxGcRKD+tYvDLV/8V7fKjDeW/cSX
         9e9IhZh2uSHCSxR/CQpRycGEHk+Wvfk3KH/94+kwYHFQcrXge3qTiAg4pdqAdT+IrV1A
         fpxHZSzIbzMyfDY1K4YEOaKbmYUapfscYr7+6i+/T4Pv10DRAf095gHmvvmCEF+qdaul
         MTSsWl82VulDa2m+hUdk9+Mirdxqgp4rT9z91jY7q3/6WupOBH4KJEDAgjd1w3IGw0dk
         mxUxX9p8Yg0xUQaGxf+zWWmeb7O1c6YZzxCkZdDigMM9ooEBWkK6Hi5UeoqQghB5uvMP
         zFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MhydNQiE/AolI5ojwjBPP77Pewh/KDq1Wx+Fw4AlEOg=;
        b=DFA7VEX8MfN2sXpMX4Mw5Vok+/p6W4tC+wOOudcaryyZRVH69pm1qFYX2DiwXad5du
         +hjn245r+XkR7rVVKKE1Rziklb3oK64DVmJ5lBVVV1J51wuQMNx6xQcOiDoU3Jqgz4Xc
         ncQpcgahFG1RiFlQnH9Ph12Tg+fHLVfSeDFsxEk86Zyt76+r37veCnU8vY4yJiRcIMUw
         yfvRO4O8DEZzXb3mLGVAVmmynwEU1cLTt/svbz2C13Wtrly1vX/yBwxeMMfCqQuZ79Wf
         0Mr0kGAdaMsyDNMIOYCfeCiqaxtGPl0XfR4FmZOLRMTcvgo9K147Xe88+q4Dii49UBj1
         yebQ==
X-Gm-Message-State: ANhLgQ3zsD+PIsdxQIuIsoBG/pK88Hu/IuBbAzqpurGkpezTEwy79I3R
        eSrzfsEoSqdDmrMfnugiktIsP5b4DbU=
X-Google-Smtp-Source: ADFU+vvgRnJNSp3x/iZ+21m6GXFgn7v1+QvuITDT3mpBoMlsKdXn7/FU4I3Sqjjvpp+80rnwgtve6Q==
X-Received: by 2002:a5d:4f85:: with SMTP id d5mr11820776wru.130.1584031860879;
        Thu, 12 Mar 2020 09:51:00 -0700 (PDT)
Received: from [192.168.1.10] ([194.35.118.177])
        by smtp.gmail.com with ESMTPSA id c2sm13412161wma.39.2020.03.12.09.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 09:51:00 -0700 (PDT)
Subject: Re: [PATCH bpf] libbpf: add null pointer check in
 bpf_object__init_user_btf_maps()
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>,
        Michal Rostecki <mrostecki@opensuse.org>
References: <20200312140357.20174-1-quentin@isovalent.com>
 <1fff03e7-e52b-edcc-d427-f912bf0a4af2@iogearbox.net>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <cb65f021-35e6-a5b2-cacb-06be89aebccf@isovalent.com>
Date:   Thu, 12 Mar 2020 16:50:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1fff03e7-e52b-edcc-d427-f912bf0a4af2@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-03-12 16:37 UTC+0100 ~ Daniel Borkmann <daniel@iogearbox.net>
> On 3/12/20 3:03 PM, Quentin Monnet wrote:
>> When compiling bpftool with clang 7, after the addition of its recent
>> "bpftool prog profile" feature, Michal reported a segfault. This
>> occurred while the build process was attempting to generate the
>> skeleton needed for the profiling program, with the following command:
>>
>>      ./_bpftool gen skeleton skeleton/profiler.bpf.o > profiler.skel.h
>>
>> Tracing the error showed that bpf_object__init_user_btf_maps() does no
>> verification on obj->btf before passing it to btf__get_nr_types(), where
>> btf is dereferenced. Libbpf considers BTF information should be here
>> because of the presence of a ".maps" section in the object file (hence
>> the check on "obj->efile.btf_maps_shndx < 0" fails and we do not exit
>> from the function early), but it was unable to load BTF info as there is
>> no .BTF section.
>>
>> Add a null pointer check and error out if the pointer is null. The final
>> bpftool executable still fails to build, but at least we have a proper
>> error and no more segfault.
>>
>> Fixes: abd29c931459 ("libbpf: allow specifying map definitions using
>> BTF")
>> Cc: Andrii Nakryiko <andriin@fb.com>
>> Reported-by: Michal Rostecki <mrostecki@opensuse.org>
>> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> 
> Applied to bpf-next, thanks! Note ...
> 
>> ---
>>   tools/lib/bpf/libbpf.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 223be01dc466..19c0c40e8a80 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -2140,6 +2140,10 @@ static int
>> bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
>>           return -EINVAL;
>>       }
>>   +    if (!obj->btf) {
>> +        pr_warn("failed to retrieve BTF for map");
> 
> I've added a '\n' here

Sorry about that, thank you Daniel!
Quentin
