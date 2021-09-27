Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B1A419684
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 16:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbhI0OlU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 10:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbhI0OlT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 10:41:19 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0108CC061575
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 07:39:42 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id f130so36957906qke.6
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 07:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EouNTx4Y3ahoEig3/1rMo30qJDoROgfIIiO+E/NYCSA=;
        b=Y+Uh2/iIG/ELFPyxJvloR/fs3DQnmRngTC+/Dotoylp/LA7P6mSG2mZ84CFUv+P6+F
         3ErjrUqBOuy4hIKgWj5TQw7Y0hUSLHx6oBK+5DVMq7bPFBAzPOQ6Qaaj50Clpqugx1A8
         oE/kuTPZRvgpWl7fllT9QZ+R4lF+AIg/A0t7QXP+xFk8gLF4z7G8YNCzBCa2SPD7xztU
         PzF5W5H+adNoG86RHbQqu8maYqFu4N3ft+/jahs/4iAeOmqxxpnyCk1UVv2kTRjYkfVF
         UqnB/7/lZvjMfvkrqk9wvTKzqHylMPa34S6sJqcvhb+I3uDxJSZyLcyQpLrNnUy6fXpB
         BKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EouNTx4Y3ahoEig3/1rMo30qJDoROgfIIiO+E/NYCSA=;
        b=ViqaV+N0QGJtVzab25LpZIP/Rq55a3r8Y51nKyOAScr9G8wMjnQ+IEW2AFoWS7XauG
         N3/jJFND8ouhyEB9zSrJyoipt61KYoENMyar3/wj1b5NcoE35ZdyMK8YNdTYpwH0dBnS
         ThrejKPmddL8F0r6dZHQWVrVMwuQrdDXjj9ere+HEOpfQHNblwC84c+epY+/1tWl/LBw
         LHUxceFKfrR4zivVv4C2vj1DNhJiSx8gymuq+6/91TkK8hGSF8BA9dD2Is2Nino6EW2/
         94OcVkExFYh7AWIDQI7ad9EzO2ZWOVSPV6tzsc+5aIsFtfhojutD0LtnjXwECMHu3QD6
         iJUA==
X-Gm-Message-State: AOAM531GCIjenXbTL4iG6EQW21qTAnpZjxQeLxzisMen2KvXT8yzdQSu
        U1z+R6mxHr23PV3QEimT/0InXE80I8lM3w==
X-Google-Smtp-Source: ABdhPJwgvYU4/dWMDCtDfHvGQCrIADYdRAfEz9lJnXp5Wxr0IlkMPdqxcy+fbskbd2Gwr5OktaOx6A==
X-Received: by 2002:a05:620a:554:: with SMTP id o20mr327627qko.30.1632753580856;
        Mon, 27 Sep 2021 07:39:40 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::1159? ([2620:10d:c091:480::1:ba44])
        by smtp.gmail.com with ESMTPSA id g13sm6192162qkk.22.2021.09.27.07.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 07:39:39 -0700 (PDT)
Subject: Re: [PATCH] samples/bpf: relicense bpf_insn.h as GPL-2.0-only OR
 BSD-2-Clause
To:     Luca Boccassi <bluca@debian.org>, bpf@vger.kernel.org
References: <20210923000540.47344-1-luca.boccassi@gmail.com>
 <57d977a0dcfae6aefafac398ded80d41980e5a36.camel@debian.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <edf22b80-b1f3-7f26-deb0-ee795969d36e@toxicpanda.com>
Date:   Mon, 27 Sep 2021 10:39:38 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <57d977a0dcfae6aefafac398ded80d41980e5a36.camel@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/27/21 10:27 AM, Luca Boccassi wrote:
> On Thu, 2021-09-23 at 01:05 +0100, luca.boccassi@gmail.com wrote:
>> From: Luca Boccassi <bluca@debian.org>
>>
>> libbpf and bpftool have been dual-licensed to facilitate inclusion in
>> software that is not compatible with GPL2-only (ie: Apache2), but the
>> samples are still GPL2-only.
>>
>> Given these files are samples, they get naturally copied around. For example
>> it is the case for samples/bpf/bpf_insn.h which was copied into the systemd
>> tree: https://github.com/systemd/systemd/blob/main/src/shared/linux/bpf_insn.h
>>
>> Dual-license this header as GPL-2.0-only OR BSD-2-Clause to follow
>> the same licensing used by libbpf and bpftool:
>>
>> 1bc38b8ff6cc ("libbpf: relicense libbpf as LGPL-2.1 OR BSD-2-Clause")
>> 907b22365115 ("tools: bpftool: dual license all files")
>>
>> Signed-off-by: Luca Boccassi <bluca@debian.org>
>> ---
>> Most of systemd is (L)GPL2-or-later, which means there is no perceived
>> incompatibility with Apache2 softwares and can thus be linked with
>> OpenSSL 3.0. But given this GPL2-only header is included this is currently
>> not possible.
>> Dual-licensing this header solves this problem for us as we are scoping
>> moving to OpenSSL 3.0, see:
>>
>> https://lists.freedesktop.org/archives/systemd-devel/2021-September/046882.html
>>
>> The authors of this file according to git log are:
>>
>> Alexei Starovoitov <ast@kernel.org>
>> Björn Töpel <bjorn.topel@intel.com>
>> Brendan Jackman <jackmanb@google.com>
>> Chenbo Feng <fengc@google.com>
>> Daniel Borkmann <daniel@iogearbox.net>
>> Daniel Mack <daniel@zonque.org>
>> Jakub Kicinski <jakub.kicinski@netronome.com>
>> Jiong Wang <jiong.wang@netronome.com>
>> Joe Stringer <joe@ovn.org>
>> Josef Bacik <jbacik@fb.com>
>>
>> (excludes a commit adding the SPDX header)
>>
>> All authors and maintainers are CC'ed. An Acked-by from everyone in the
>> above list of authors will be necessary.
>>
>> One could probably argue for relicensing all the samples/bpf/ files given both
>> libbpf and bpftool are, however the authors list would be much larger and thus
>> it would be much more difficult, so I'd really appreciate if this header could
>> be handled first by itself, as it solves a real license incompatibility issue
>> we are currently facing.
>>
>>   samples/bpf/bpf_insn.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/samples/bpf/bpf_insn.h b/samples/bpf/bpf_insn.h
>> index aee04534483a..29c3bb6ad1cd 100644
>> --- a/samples/bpf/bpf_insn.h
>> +++ b/samples/bpf/bpf_insn.h
>> @@ -1,4 +1,4 @@
>> -/* SPDX-License-Identifier: GPL-2.0 */
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>   /* eBPF instruction mini library */
>>   #ifndef __BPF_INSN_H
>>   #define __BPF_INSN_H
> 
> CC'ing Josef with a different address as requested.
> 

Thanks, my @fb email gets mangled so I don't use it anymore.  You can add

Acked-by: Josef Bacik <josef@toxicpanda.com>

Josef
