Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371CC22B359
	for <lists+bpf@lfdr.de>; Thu, 23 Jul 2020 18:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgGWQVI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 12:21:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26253 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726632AbgGWQVI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 12:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595521267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xm8Gwy5ngihHCS6QCYYSXxX1Hk7bq+Zu3h9/fGUbCOg=;
        b=JERamPr9J7MxR/CYcVtboJPMQ8TqQU70CgWyDOpfotM2N+dT7osaJJPmLmsmGzW/pSPObv
        uVSHxf7/ZZlkAQOUDK0sQ+GGYtUSXtYgjpDmW89lwa1pwIHsM5yHcIj//h1hM/lPRDAPp0
        8d6dVvC5NMLjCufB684frHO58VTmkq4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-rmqvQ9s8P2qy6Rx23lsj0w-1; Thu, 23 Jul 2020 12:21:05 -0400
X-MC-Unique: rmqvQ9s8P2qy6Rx23lsj0w-1
Received: by mail-qt1-f200.google.com with SMTP id d2so571203qtn.8
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 09:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Xm8Gwy5ngihHCS6QCYYSXxX1Hk7bq+Zu3h9/fGUbCOg=;
        b=COXxjLnVAkqZqu1weidaOaRn7HwVjHCiYj7PHnq1P+2BBkV4Q8wBbG+6Cb4bWamT2E
         pCoSYScgiGk8d06RZElKW2CRk5ZjQw6EpkocB0YfkIKjQomWqvBylnVEdZtrMatFF2bT
         NnlDjEQtvS65Oe7iLYxHV2wntewhGEsWaIncrPd/OvIJNBmfiSMFW+zbbLGvxcAmIJPD
         aP3ODdL26X6663gxMTYyTYyr7JnkjQmYQE2BMy85ac+uFmxCIzkweFhj1yEszrJ2yX+M
         emOVkNjsxzWSjJX2ySrP5Wowh2SDm1sRR2WV7LEXBpOIokKadBThEYAWtVauJUvjelGF
         OQDQ==
X-Gm-Message-State: AOAM531CGNn2+F8FZftbL/Xs4LExUiyG8Sfe3AwKypxi/ibcr81YEPs6
        3Ykwe8o52evmD71ECPfduAOfRP1DFzmeu7a/Xd96xfaAiQI9aRYYsEKFW/mfMafjxOFPryXLs9k
        KkBhCLaOHc71E
X-Received: by 2002:a37:6d47:: with SMTP id i68mr6113287qkc.74.1595521263846;
        Thu, 23 Jul 2020 09:21:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaX6ObApGhH0vkIFqvVT8seNfWZRsfMGlpKQFK3E141apDdMNGSGfgch9WELF3Pab7cuqbqA==
X-Received: by 2002:a37:6d47:: with SMTP id i68mr6113249qkc.74.1595521263624;
        Thu, 23 Jul 2020 09:21:03 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j31sm2785738qtb.63.2020.07.23.09.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 09:21:03 -0700 (PDT)
Subject: Re: [PATCH] bpf: BPF_SYSCALL depends INET
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, krzk@kernel.org,
        patrick.bellasi@arm.com, David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <20200723141914.20722-1-trix@redhat.com>
 <CAADnVQJYsqosZ804geM1Urrz73+z1fMZu1w76KN-847S3CL+nQ@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <85785371-f0e9-5c85-959f-b9830b4eb06a@redhat.com>
Date:   Thu, 23 Jul 2020 09:20:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQJYsqosZ804geM1Urrz73+z1fMZu1w76KN-847S3CL+nQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 7/23/20 8:27 AM, Alexei Starovoitov wrote:
> On Thu, Jul 23, 2020 at 7:19 AM <trix@redhat.com> wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> A link error
>>
>> kernel/bpf/net_namespace.o: In function `bpf_netns_link_release':
>> net_namespace.c: undefined reference to `bpf_sk_lookup_enabled'
>>
>> bpf_sk_lookup_enabled is defined with INET
>> net_namespace is controlled by BPF_SYSCALL
> pls rebase. it was fixed already.
>
I guess it hasn't shown up in linux-next yet.

As i rebase every day, i'll get it evently.

Sorry for noise.

Tom

