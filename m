Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEA4593268
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 17:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiHOPrF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 11:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiHOPrE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 11:47:04 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E981DF6
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 08:47:03 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n4so9487190wrp.10
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 08:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=8pm8HBa32u5FUJ3oONkaYYZ1ePFWmjpjidSl8LnJaVM=;
        b=Ppw4ZH19ymAlhebJbqBEi20UuBbghxjsx8vmHNxkTComFQU7rAg44s7WmGOyibh/uN
         0dwUVzIwMsSuILyhBVzMz6Fx2bFDKb+hKPjcjQ3U4pk/PODn8isEVHPJ7E6ewjcO4tzD
         /Htj0o8qLTxFbwtRGEjHfF8sKwmNiHpeKn/0Clg+Bi68ZdmkAuG8WbUoDG/HguKnWRec
         Oh+16jlPJjMVQFHElvi78GocpCmE6o1z/uxbZiU0y/ewaCXrWATzctnOh/JmmYIvJt0x
         HiOpYopqJFVs93lnHQZLsZawpuXwb1h6WBsJPzITWqJ/YMGcliR8iXszr98yUKX2HANM
         6bNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=8pm8HBa32u5FUJ3oONkaYYZ1ePFWmjpjidSl8LnJaVM=;
        b=etayUHqtE5ANLa5c9/O828znE/6KDX3Uf35aH3Y4ucDB7bMkyhN07v8nDDjOKCkp8R
         DgCraU0PTOo0cN7kjp358LNTugrSYrbQ7DTXYWvayKUZ/hilDaeaUzO9Qw7SDAvOOY5/
         z4lbRkOvi2+Sss4d4gH7VJAeF7aG0ioJ+/pHTY/juEAzi+hw06Wt3P+keyx9PMeYHeao
         6OohfCuL90fG4PjLuSpXb8HpZLcRLXaBEDtp4PaA4BTstRSfqmbWvXhYvy/jngVAr4P6
         SOi+UWr4fLiTI7oMRLrh73f3XDndNLxopG5v58/OUOzd+C1zzw1NMbIniOK1VNsj4eu+
         fdGQ==
X-Gm-Message-State: ACgBeo0fugHBRc/A8w+/bIVcJPgj7fPYJ+CO5/wIaWaNhh4NB4iKXyEO
        5HUqsibVBvtlFrGoGhqvapEwyQ==
X-Google-Smtp-Source: AA6agR7AsdYzZlV//W6BC1TSv3r7tuscJ//pALWGDoYgW0JED7k4AeVSte0ULCL83kkrHlafplLQIA==
X-Received: by 2002:adf:d1e2:0:b0:223:611b:3f18 with SMTP id g2-20020adfd1e2000000b00223611b3f18mr8730650wrd.236.1660578422158;
        Mon, 15 Aug 2022 08:47:02 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c2cd700b003a502c23f2asm10519573wmc.16.2022.08.15.08.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 08:47:01 -0700 (PDT)
Message-ID: <c5f757ff-30e2-4ed8-61ee-bcfa6bd90cc1@isovalent.com>
Date:   Mon, 15 Aug 2022 16:47:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH bpf-next] bpftool: Clear errno after libcap's checks
Content-Language: en-GB
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org
References: <20220812153727.224500-2-quentin@isovalent.com>
 <dfda4b3e-2935-fd19-ce62-f331c07d6921@iogearbox.net>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <dfda4b3e-2935-fd19-ce62-f331c07d6921@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 15/08/2022 16:33, Daniel Borkmann wrote:
> On 8/12/22 5:37 PM, Quentin Monnet wrote:
>> When bpftool is linked against libcap, the library runs a "constructor"
>> function to compute the number of capabilities of the running kernel
>> [0], at the beginning of the execution of the program. As part of this,
>> it performs multiple calls to prctl(). Some of these may fail, and set
>> errno to a non-zero value:
>>
>>      # strace -e prctl ./bpftool version
>>      prctl(PR_CAPBSET_READ, CAP_MAC_OVERRIDE) = 1
>>      prctl(PR_CAPBSET_READ, 0x30 /* CAP_??? */) = -1 EINVAL (Invalid
>> argument)
>>      prctl(PR_CAPBSET_READ, CAP_CHECKPOINT_RESTORE) = 1
>>      prctl(PR_CAPBSET_READ, 0x2c /* CAP_??? */) = -1 EINVAL (Invalid
>> argument)
>>      prctl(PR_CAPBSET_READ, 0x2a /* CAP_??? */) = -1 EINVAL (Invalid
>> argument)
>>      prctl(PR_CAPBSET_READ, 0x29 /* CAP_??? */) = -1 EINVAL (Invalid
>> argument)
>>      ** fprintf added at the top of main(): we have errno == 1
>>      ./bpftool v7.0.0
>>      using libbpf v1.0
>>      features: libbfd, libbpf_strict, skeletons
>>      +++ exited with 0 +++
>>
>> Let's clean errno at the beginning of the main() function, to make sure
>> that these checks do not interfere with the batch mode, where we error
>> out if errno is set after a bpftool command.
>>
>> [0]
>> https://git.kernel.org/pub/scm/libs/libcap/libcap.git/tree/libcap/cap_alloc.c?h=v1.2.65#n20
>>
>> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
>> ---
>>   tools/bpf/bpftool/main.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
>> index 451cefc2d0da..c0e2e4fedbe8 100644
>> --- a/tools/bpf/bpftool/main.c
>> +++ b/tools/bpf/bpftool/main.c
>> @@ -435,6 +435,9 @@ int main(int argc, char **argv)
>>         setlinebuf(stdout);
>>   +    /* Libcap */
> 
> Good catch! The comment is a bit too terse, could you improve it, so
> that it's
> clear from reading code (w/o digging through git log) why we need to
> reset errno
> in this location? Thx

Right, I'll work on the comment and repost, thank you for the review
Quentin
