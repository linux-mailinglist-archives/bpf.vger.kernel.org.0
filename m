Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674CB444094
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 12:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhKCL2v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Nov 2021 07:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbhKCL2t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Nov 2021 07:28:49 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE416C061714
        for <bpf@vger.kernel.org>; Wed,  3 Nov 2021 04:26:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b12so3046093wrh.4
        for <bpf@vger.kernel.org>; Wed, 03 Nov 2021 04:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=70FabX0ZheNRFn49OTr65H/jrEDEqwnDC4MNtvKreIs=;
        b=SV1nP4yBZR419JvownyY1Jld80REJwUrWLDYYzx/K3Jzorm4WVrmJsIyWriK2SMSN5
         5rDPV4HTvJk6hZw/b8lYq33paGnA/UVbVEuh426i2FXPX+jJXtnn4hIbpRIIgbX/l38E
         r+VzN9yAIj2lUHKDIEBkYG77ovLPKD/G7LTta5+Ec5k4XdVxnK7SJ7m0QKyYu780G5gC
         P3sNU/sdUfae2vdwLRQ+/wLoy4J6l7hqt2IqFLbYwxtM+cOHjfneFIvDMcVuk6NCHnzA
         H7za/5wzb+orzAAsfScW4Eb7JacJObIvnctH4Ns7buSlOem9dk6lKUCxzsYmGoAEf/h0
         ilqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=70FabX0ZheNRFn49OTr65H/jrEDEqwnDC4MNtvKreIs=;
        b=Cwf0WnOEwnGCsTigTtrY3n5RMVoF4xFkg43RCN1haCEpD6WZL77B1/e9IpVkaR45iq
         STNoJMzuTLz6G8V3ISjCn0ogmzwfJkFYwQ78TrBYZ8JdSzFNuasFzdXFJNldEa0Oz4CO
         CgJ2VzOmEEGyB+0gZO/lWcFm5ocGxOAhpVr7/6G4EljmrC70DW4Y4QnM3GiE9powvw2j
         n1Uz3g7O7VIGd/xcWtHar3xKM982kydSx/PBWbhJBQOvhXQjhSd/OnRa/olD4Z+1BxSZ
         KnjWDm1S1SBltVFFjP/d+r7/0Att4qSFOyocWXV2iAezOAo8tkd2k0zwF/GOCFIlaUj3
         EAvQ==
X-Gm-Message-State: AOAM532XrO9dcPOdJTJ3EnN5ym6gClDCuyXQcZBKK+zJTQGFSrlS7oc6
        IRA5Yxbj6apZh3xL7TLa9m4EdQ==
X-Google-Smtp-Source: ABdhPJzf884WwM3YcjxwxTrwGiWhSg70llb+2hUfckLm33uxhMNj/1uBmcZFd/NDEuK/sY0nF5d+xA==
X-Received: by 2002:adf:cd06:: with SMTP id w6mr39947353wrm.431.1635938771435;
        Wed, 03 Nov 2021 04:26:11 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.70.199])
        by smtp.gmail.com with ESMTPSA id u2sm1610104wrr.35.2021.11.03.04.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 04:26:11 -0700 (PDT)
Message-ID: <7c6a10fb-b1c5-4f50-8f7c-75c170e24ebb@isovalent.com>
Date:   Wed, 3 Nov 2021 11:26:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 bpf-next 0/4] libbpf: deprecate
 bpf_program__get_prog_info_linear
Content-Language: en-GB
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20211101224357.2651181-1-davemarchevsky@fb.com>
 <CAEf4BzY_OXyWdgJu=0phg0Pyb4PW6QWcKKBHLFOf=FwAmgOjqA@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAEf4BzY_OXyWdgJu=0phg0Pyb4PW6QWcKKBHLFOf=FwAmgOjqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-11-02 16:06 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Mon, Nov 1, 2021 at 3:46 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>
>> bpf_program__get_prog_info_linear is a helper which wraps the
>> bpf_obj_get_info_by_fd BPF syscall with some niceties that put
>> all dynamic-length bpf_prog_info in one buffer contiguous with struct
>> bpf_prog_info, and simplify the selection of which dynamic data to grab.
>>
>> The resultant combined struct, bpf_prog_info_linear, is persisted to
>> file by 'perf' to enable later annotation of BPF prog data. libbpf
>> includes some vaddr <-> offset conversion helpers for
>> struct bpf_prog_info_linear to simplify this.
>>
>> This functionality is heavily tailored to perf's usecase, so its use as
>> a general prog info API should be deemphasized in favor of just calling
>> bpf_obj_get_info_by_fd, which can be more easily fit to purpose. Some
>> examples from caller migrations in this series:
>>
>>   * Some callers weren't requesting or using dynamic-sized prog info and
>>     are well served by a simple get_info_by_fd call (e.g.
>>     dump_prog_id_as_func_ptr in bpftool)
>>   * Some callers were requesting all of a specific dynamic info type but
>>     only using the first record, so can avoid unnecessary malloc by
>>     only requesting 1 (e.g. profile_target_name in bpftool)
>>   * bpftool's do_dump saves some malloc/free by growing and reusing its
>>     dynamic prog_info buf as it loops over progs to grab info and dump.
>>
>> Perf does need the full functionality of
>> bpf_program__get_prog_info_linear and its accompanying structs +
>> helpers, so copy the code to its codebase, migrate all other uses in the
>> tree, and deprecate the helper in libbpf.
>>
>> Since the deprecated symbols continue to be included in perf some
>> renaming was necessary in perf's copy, otherwise functionality is
>> unchanged.
>>
>> This work was previously discussed in libbpf's issue tracker [0].
>>
>> [0]: https://github.com/libbpf/libbpf/issues/313
>>
>> v2->v3:
>>   * Remove v2's patch 1 ("libbpf: Migrate internal use of
>>     bpf_program__get_prog_info_linear"), which was applied [Andrii]
>>   * Add new patch 1 migrating error checking of libbpf calls to
>>     new scheme [Andrii, Quentin]
>>   * In patch 2, fix != -1 error check of libbpf call, improper realloc
>>     handling, and get rid of confusing macros [Andrii]
>>   * In patch 4, deprecate starting from 0.6 instead of 0.7 [Andrii]
> 
> LGTM. Quentin, can you please take a look and ack as well? Thanks!

Thanks Andrii for the Cc! I realised yesterday morning that I'd been hit
by the unsubscription incident and missed v3 of this set.

The changes look good to me, and you can add my tag to the first three
patches:

Acked-by: Quentin Monnet <quentin@isovalent.com>

Regarding patch 4, looking at the latest deprecations in libbpf, I would
have expected the functions to be deprecated starting in v0.7, and not v0.6?

Other than that, on patch 2 (apologies for not answering inline), it
would feel more natural, in do_dump()'s "for" loop in prog.c, to have
the memset() above the call to bpf_obj_get_info_by_fd() (and to skip the
zero-initialisation of "info") instead of at the end of the loop, which
means a useless memset() just before we exit the loop. But probably not
worth a respin just for that.

Thanks,
Quentin
