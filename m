Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C892629CD
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 10:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbgIIIMq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 04:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728970AbgIIIMm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 04:12:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9175FC061573
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 01:12:42 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c19so1261698wmd.1
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 01:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y4mg3/crLg7i+YSHd//57w46nzas9VKoqhALJzI4hmw=;
        b=SPmrGq+R+6IS8rQk1qz+5m4gmYD+ClPV9BHLLx9ll+4Qu0kFKIglG2p5uaBEbRji9u
         KB10BXSOrdfMTPM70OdFWtQRNQDZbvsmjTTu8zbXcYgV309kTe9QHjipe3BNSZ3sLUdA
         ZxGXPzmNb+wqzaYA/v0CRjDgHXvfcC0zH5w5Tx1ar3HqUA4pk8Si6pY2bKUttsUWo/xc
         TAy/61JaQBBQHcg5T0o8z+GKVpZ3xvxBXIO8v7UBSKse/UGcoioTLPsrpcqpNy1bAcc4
         HugTt9l3L8ugFNLvd0jMRNzLq1ruSfrdphuyhcL31anVGszzX6KpImjYcbZHPmBmWsZG
         +YvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y4mg3/crLg7i+YSHd//57w46nzas9VKoqhALJzI4hmw=;
        b=UU82LpP4f7eiTKRp7NjOKMrM77ZrygiU0z+bZOZ74X9+yoodAzaPlJyWON+RwqOUI0
         rHzfZ4p/ak3vHNbz6PT2NQ5Spn1ug7ep+JNfC3O5E+Wt9LMtqIRYmWdfTd9zcOZt2Oxk
         s09NHCGvf88j2vZHR6vAjiB3kdZ+zYjNtS798L7SQYQx3Q2OLxQmCUXzoTwCr2QLV7I5
         o74a/jY2bhDD7XmoL0Ysut9ooKzu5ffEoSlP63CpsMCSKjmmahO1rU1XIp3apGa0N07z
         027w1QRXJOTlR89NepNJBI5Q2EUgvwzsdBDCbwU0xJ2coQf56HbVjNW9AaIn1l1JEGzP
         0ugw==
X-Gm-Message-State: AOAM532bDNK/6ja+sAnWRJNm7OQ2bPXyb2v4KKtihxAY07/hFthsjwU1
        mCvTSR11iZlciagdN3UF9ISPyYZtr/3giTpEI7Y=
X-Google-Smtp-Source: ABdhPJz386Vt9TTjl6o/8TnQOz9XYMOrLHbFAV1hHyyuId1dPk7YaVLl2eu9NlgcKWeci4v4Ohg0wQ==
X-Received: by 2002:a1c:1902:: with SMTP id 2mr2493727wmz.26.1599639161042;
        Wed, 09 Sep 2020 01:12:41 -0700 (PDT)
Received: from [192.168.1.12] ([194.35.119.237])
        by smtp.gmail.com with ESMTPSA id z19sm2679016wmi.3.2020.09.09.01.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 01:12:40 -0700 (PDT)
Subject: Re: [PATCH bpf-next 0/2] bpf: detect build errors for man pages for
 bpftool and eBPF helpers
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
References: <20200907164017.30644-1-quentin@isovalent.com>
 <CAEf4BzZNfsSyeJv7VXv-Z0p8EKV=pdDjfQVzNY3X8Y1=oWMwaQ@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <fb5efa4d-5f3d-adcb-a18c-14899c1651b0@isovalent.com>
Date:   Wed, 9 Sep 2020 09:12:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZNfsSyeJv7VXv-Z0p8EKV=pdDjfQVzNY3X8Y1=oWMwaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 09/09/2020 04:48, Andrii Nakryiko wrote:
> On Mon, Sep 7, 2020 at 9:40 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> This set aims at improving the checks for building bpftool's documentation
>> (including the man page for eBPF helper functions). The first patch lowers
>> the log-level from rst2man and fix the reported informational messages. The
>> second one extends the script used to build bpftool in the eBPF selftests,
>> so that we also check a documentation build.
>>
>> This is after a suggestion from Andrii Nakryiko.
>>
>> Quentin Monnet (2):
>>   tools: bpftool: log info-level messages when building bpftool man
>>     pages
>>   selftests, bpftool: add bpftool (and eBPF helpers) documentation build
>>
>>  tools/bpf/bpftool/Documentation/Makefile      |  2 +-
>>  .../bpf/bpftool/Documentation/bpftool-btf.rst |  3 +++
>>  .../bpf/bpftool/Documentation/bpftool-gen.rst |  4 ++++
>>  .../bpf/bpftool/Documentation/bpftool-map.rst |  3 +++
>>  .../selftests/bpf/test_bpftool_build.sh       | 23 +++++++++++++++++++
>>  5 files changed, 34 insertions(+), 1 deletion(-)
>>
>> --
>> 2.25.1
>>
> 
> LGTM.
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
> But this still won't be run every time someone makes selftests. We do
> build bpftool during selftests build, so it would be good to run doc
> build there as well to ensure everyone is executing this. But this is
> a good first step for sure.
> 

I see, indeed with this patch we would only build the doc on "make
run_tests", not when building the selftests. I'll send another version
that builds the doc at the same time as we build bpftool then.

I also had another look at rst2man's options, and there's probably
cleaner a way to get rid of the stderr redirection/line counting that
I'm doing in this version. I'll fix that too.

Thanks for the feedback.
Quentin
