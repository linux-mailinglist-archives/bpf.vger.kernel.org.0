Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFCA3AA645
	for <lists+bpf@lfdr.de>; Wed, 16 Jun 2021 23:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhFPVqu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 17:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbhFPVqu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Jun 2021 17:46:50 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9F5C061574
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 14:44:43 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id e3so3179350qte.0
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 14:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZvOz1NtCvMw8IzBJKkHTZTXdQZG7DPZBs1I8TFnq7hA=;
        b=jzQoXBUi54JluNsVMuMYXbcS5hXUtXyMqzkdD2YhD0MZc2nMMAYsgyRm487znjsqcI
         k8F0fE/jEDcL6WGgRMRXl1APdTnsaICBYH5Q539sZ48qbqywyIT5GMnf8a4hRN+VWE6U
         rMY3gYq47+QaYbNBPt7EYBAmh6zeSP3JAWxEeatBWHbdbCn/4eb5ar5qlPdxgoc+hVpO
         Pg3TDwZpWeoqLDVyLsXXJiMmojVghG4CY5kwct0+7spv/px7fEIoHJ2e0IrwCsU1gvmP
         sweWVV+26LBBCCp2yg9Zwb4g6idxKOSIZ/opUO37e9vCM/FgwokexMvd5UTj9VPFhbbn
         NP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZvOz1NtCvMw8IzBJKkHTZTXdQZG7DPZBs1I8TFnq7hA=;
        b=ah7P1N5kcRkcOYakOHC/gEh1I85+S4eQBoY7GqYISuwU2WVDCC1BC+vgpbx4mR98Rj
         xcU+xLwEzzKD5lpUYOSb9yIfN8ZBSzp7gh2tlpLq6AIfnYIQMGbYqncVVwIox82jmvcY
         fInSJjpaGiXRphmBc0Ga7u/zoPddiKQ46oRAb/atpEnR24/C23qmCIU0Q9VCRaMtc9WV
         8jMRdMbBQKqBCZScohI/h/4D+ik0969GEOZwGwsc3kkMv0Y5kL/M7qixGU09bAaSEI8n
         /zpwW992GRnPamW3Gt6Sr7Zog06Dn8xdyke/FBVPMa4yBThFJVD5dlGUewPtwOlM8ZAf
         YFkA==
X-Gm-Message-State: AOAM531n32ev/wL6U1dXvtBcDEKnu1N3KSfv5CyuZUEURcCU26lihS9Z
        JoIMDfMYx4AD19zyaP3ZV3I=
X-Google-Smtp-Source: ABdhPJwA9/XdOeNFW8vllIWWP2KgicCPAL6JbycMvaIGzmLiq7UgkvC7Jj2emyQL7POFqTICCkb3Mw==
X-Received: by 2002:ac8:65d7:: with SMTP id t23mr1856518qto.311.1623879882991;
        Wed, 16 Jun 2021 14:44:42 -0700 (PDT)
Received: from [192.168.1.109] (pc-145-79-45-190.cm.vtr.net. [190.45.79.145])
        by smtp.gmail.com with ESMTPSA id k7sm411851qke.65.2021.06.16.14.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 14:44:42 -0700 (PDT)
Subject: Re: Extending bpf_get_ns_current_pid_tgid()
To:     Yonghong Song <yhs@fb.com>
Cc:     Blaise Sanouillet <blez@fb.com>, Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>
References: <C71Q73J0Y8S5.3PXMV3YTPDCL7@maharaja>
 <13b5b2dd-bec0-cef2-7304-7e5a09bafb6c@fb.com>
 <MN2PR15MB2991E847DE47A265E71F1BC8A0E60@MN2PR15MB2991.namprd15.prod.outlook.com>
 <CACiB22i6d2skkJJa7uwVRrYy7dtYOxmLgFwzjtieW4BFn2tzLw@mail.gmail.com>
 <9067600b-f340-ec3e-2ce8-d299793c123a@fb.com>
 <CACiB22iU3zk4Row=wAween=rSvHJ7j7M5T2KbyFk38arzEwQpQ@mail.gmail.com>
 <c176cb4f-26d9-28b3-3f6e-628c1a5fa800@fb.com>
From:   Carlos Neira <cneirabustos@gmail.com>
Message-ID: <8b656897-8241-daed-861d-d33beff7934f@gmail.com>
Date:   Wed, 16 Jun 2021 17:44:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <c176cb4f-26d9-28b3-3f6e-628c1a5fa800@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/16/21 1:02 PM, Yonghong Song wrote:
> 
> 
> On 6/15/21 6:08 PM, carlos antonio neira bustos wrote:
>> I'm resuming work on this and would like to know your opinion and 
>> concerns about the following proposal:
>>
>> - Add  s_dev from  nsfs to ns_common, so now ns_common will have inode 
>> and device to identify the namespace, as in the future namespaces will 
>> need to match against ino and device.
>>
>> - That will allow us to remove the call to ns_match on because the 
>> values checked are now present in ns_common (ino and dev_t).
> 
> I understand its benefit but I am not 100% sure whether adding s_dev to 
> ns_common will be accepted or not by upstream just because of this.
> 
> Note that if adding s_dev to ns_common, you then need to ensure s_dev
> contains valid value for all usages of ns_common, practically all
> namespaces, not just nsfs, otherwise people may argument against this
> as existing mechanism works and the change brings little value.
> If you go this route, please ensure other namespaces can also
> take advantage of this field.

This route seems like a long one, but is the easier solution that I can 
think at this moment.I'll read more of the code to have a better 
understanding of the consequences.


>>
>> - Add a new helper named  bpf_get_current_pid_tgid_from_ns that will 
>> return pid/tgid from the current task if pid ns matches ino and dev 
>> supplied by the user as now both values are in ns_common.
> 
> I think current helper get_ns_current_pid_tgid() can already do this.
> Did I miss anything?
> 

The problem with get_ns_current_pid_tgid is that device and ino provided 
by the user are compared against the current task pid namespace ino but 
dev_t as is not part of ns_common is compared with against the current 
nsfs dev_t. So the helper will only return pid/tgid from the current 
namespace but not will be able to do it for a target ns due to this 
limitation.


>>
>>
>>
>>
>>
>> On Fri, Nov 13, 2020 at 1:59 PM Yonghong Song <yhs@fb.com 
>> <mailto:yhs@fb.com>> wrote:
>>
>>
>>
>>     On 11/13/20 6:34 AM, carlos antonio neira bustos wrote:
>>      > Hi Blaise and Daniel,
>>      >
>>      >
>>      > I was following a couple of months ago how bpftrace was going to
>>     handle
>>      > this situation. I thought this PR
>>      > https://github.com/iovisor/bpftrace/pull/1602
>>     <https://github.com/iovisor/bpftrace/pull/1602>
>>      > <https://github.com/iovisor/bpftrace/pull/1602
>>     <https://github.com/iovisor/bpftrace/pull/1602>> was going to be 
>> merged
>>      > but just found today that is not working.
>>      >
>>      > I agree with Yonghong Song on the approach of using the two 
>> helpers
>>      > (bpf_get_pid_tgid() and bpf_get_ns_current_pid_tgid()) to move
>>     forward
>>      > on the short term, bpf_get_ns_current_pid_tgid works as a
>>     replacement
>>      > to bpf_get_pid_tgid when you are instrumenting inside a container.
>>      >
>>      > But the use case described by Blaise is one I would like to use
>>     bpftrace,
>>      >
>>      > If nobody is against it, I could start working on a new helper to
>>      > address that situation as I need to have bpftrace working in that
>>     scenario.
>>
>>     Yes, please. Thanks!
>>
>>      >
>>      > For my understanding of the problem the new helper should be 
>> able to
>>      > return pid/tgid from a target namespace, is that correct?.
>>
>>     Yes. This way, the stack trace can correlate to target namespace for
>>     symbolization purpose.
>>
>>      >
>>      >
>>      > Bests
>>      >
>>      >
>>     [...]
>>

