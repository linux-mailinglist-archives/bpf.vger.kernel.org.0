Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC6B184510
	for <lists+bpf@lfdr.de>; Fri, 13 Mar 2020 11:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgCMKjp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Mar 2020 06:39:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42079 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgCMKjp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Mar 2020 06:39:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id v11so11423485wrm.9
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2020 03:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3JhHx673lqbik6TzmlNN2WpdmSFHzTUn1f9gJBGcJJs=;
        b=jPvKl0bKnRhQVmq/XKzYAw6FkDjS5W8hK1CfZSmFyzuaQKEeYl6dcW20MdyDnVPOXK
         2U+i0smq2Eu9BdBonIiaaEadFF2Kcmj6f5WwNQO3lx29LGPeFChm0lcpBH1jey4Y4Zto
         F91j17psamV7BX3aXSuWn+aySK+yNk+pctqzchpDjw03bQWRPUfuKamu46ZADwfm8/qW
         KjCzRcMJSZRbOCvHSxL131pqpZ3fckaMPyfIzum5VN/rDrwqT78+QGPKhzDWP7d6n8ql
         cZbvQz038o8o9vBGRf7sqOj64KYQbQYycuxHKIQL71n1JH4CPaRa44O5iiDUR09pRgPu
         VAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3JhHx673lqbik6TzmlNN2WpdmSFHzTUn1f9gJBGcJJs=;
        b=mSLE6xWHKjPSdWtX6k8Lk1fwPSE70kCTqfkK04+Uk7EtbsQYWtumi64H6jSa9Yk0Dq
         XelX614qm9L/L2vv4IYZRBNjijG1tx2CMvYeagj+bacsqkrcxejHKvuTm+eTbmCuXJgO
         YfSATpKIcZogClquso0O5ntBdZi7w56Hpmo30c2QfArOBPhbt2ZpybzLzQpGDLZyUBkv
         ab5dcRRjwIFrq85kjto1VgXymLzCbUUbnu9eJjl1Snwk0w88/KELwE5ZiM84sM7NhW5/
         gK/12tloLcXAwMKBmo/vSoVlLUAgwkUilkCRivoHT9epMEtvNtPCF+e0BYb2lBNMwcBp
         QLoA==
X-Gm-Message-State: ANhLgQ3ulOoo8KwbPqqUgcwzuaPWzDD/fnF8fe3SCi7JDHRUaxXGr4iE
        NwZX21Ld6xXMARGP4KeyasuvftlptRw=
X-Google-Smtp-Source: ADFU+vtTgVHbe0a9U9naC3YcuNJ7LNfl9y3XML4SPTmZCasn5j0KAOT61AKzqlWtkRkXDrWjcAPFJQ==
X-Received: by 2002:adf:f002:: with SMTP id j2mr17655937wro.296.1584095982905;
        Fri, 13 Mar 2020 03:39:42 -0700 (PDT)
Received: from [192.168.1.10] ([194.35.118.102])
        by smtp.gmail.com with ESMTPSA id m21sm15876795wmi.27.2020.03.13.03.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 03:39:42 -0700 (PDT)
Subject: Re: [PATCH v17 0/3] BPF: New helper to obtain namespace data from
 current task
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Carlos Neira <cneirabustos@gmail.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        bpf <bpf@vger.kernel.org>
References: <20200304204157.58695-1-cneirabustos@gmail.com>
 <CAADnVQL4GR2kOoiLE0aTorvYzTPWrOCV4yKMh1BasYTVHkKxcg@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <33447490-7fa2-f56d-3622-d61c9c2046e5@isovalent.com>
Date:   Fri, 13 Mar 2020 10:39:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQL4GR2kOoiLE0aTorvYzTPWrOCV4yKMh1BasYTVHkKxcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-03-12 17:45 UTC-0700 ~ Alexei Starovoitov <alexei.starovoitov@gmail.com>
> On Wed, Mar 4, 2020 at 12:42 PM Carlos Neira <cneirabustos@gmail.com> wrote:
>>
>> Currently bpf_get_current_pid_tgid(), is used to do pid filtering in bcc's
>> scripts but this helper returns the pid as seen by the root namespace which is
>> fine when a bcc script is not executed inside a container.
>> When the process of interest is inside a container, pid filtering will not work
>> if bpf_get_current_pid_tgid() is used.
>> This helper addresses this limitation returning the pid as it's seen by the current
>> namespace where the script is executing.
>>
>> In the future different pid_ns files may belong to different devices, according to the
>> discussion between Eric Biederman and Yonghong in 2017 Linux plumbers conference.
>> To address that situation the helper requires inum and dev_t from /proc/self/ns/pid.
>> This helper has the same use cases as bpf_get_current_pid_tgid() as it can be
>> used to do pid filtering even inside a container.
> 
> Applied. Thanks.
> There was one spurious trailing whitespace that I fixed in patch 3
> and missing .gitignore update for test_current_pid_tgid_new_ns.
> Could you please follow up with another patch to fold
> test_current_pid_tgid_new_ns into test_progs.
> I'd really like to consolidate all tests into single binary.
> 

Compiling bpftool (with libbpf now relying on bpf_helper_defs.h
generated from helpers documentation), I observe the following
warning:

    .output/bpf_helper_defs.h:2834:72: warning: declaration of 'struct bpf_pidns_info' will not be visible outside of this function [-Wvisibility]
    static int (*bpf_get_ns_current_pid_tgid)(__u64 dev, __u64 ino, struct bpf_pidns_info *nsdata, __u32 size) = (void *) 120;

Would it be possible to address this as part of the follow-up too,
please? I think the fix would be to add "struct bpf_pidns_info"
to type_fds (I see it was added to known_types already) in
scripts/bpf_helpers_doc.py.

Thanks,
Quentin
