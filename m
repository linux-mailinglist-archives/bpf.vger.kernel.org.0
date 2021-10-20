Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F956434C46
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 15:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJTNnf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 09:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhJTNne (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 09:43:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C39C06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 06:41:20 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id oa4so2531113pjb.2
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 06:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=na37mrH/k3GOa/xsN8asTQJ0RtdV9y2olI7OOUIjxpQ=;
        b=AszGhO8P5XMNV46e9YFW6LD6reXBudI1jhdiDssmmOjVMixbQUexnX8hS3329cU/tu
         y2XZ/qobtRgcr8C0OryxTPWMKiCCMlAPfF7jkH7J6eWSwFNI1nzZ5p/wNQSfDgBm8n4/
         O/Pj+lMXYjH7rTwi33J0MumjLGaeS3bgQn6dO1eyybPSJYozUyk3evUcHbez4G8IOE43
         wrOqi4Tr4I/F76Y/L1/mw8Io0Au4sELhrhkbVl0md7xPl8i6Cl2LyHdBM+6tv5fFf3YG
         3xsHt9JTJgxv8r4FOoUargEG64NSp2ukJAtIu+iaP7202WfP0krs6FbLZj1TrMrAg3or
         KHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=na37mrH/k3GOa/xsN8asTQJ0RtdV9y2olI7OOUIjxpQ=;
        b=G4rfRXK1OLLNhacKFl3c0bpc7+A1svs24T44Uy0xWJJUhXX2Q0pDYTWw6J0xgFUG9x
         RSi/MviG12RFvFDTgExHDf5UEJ2Zj7ygjbwoFf7v506AM21oHjQ0hL6xj0JMklGxy/TH
         alaUxF248pXXDNGxFZtB4MDyFUHTKDTraUYQpv3NkO0tdSSpYHk8X6SWNhe/ew/BM6uN
         4uCIy/lQuiKC3snPg69exrctqMNkBasxMBWb6hk19WyZe93KV4DMTiMNejP/o5k6RmUJ
         mZ4xI0rzR4mP2KW32aBCuptJNh3q2vaXJKZuxgSOUPCy0DBH6E9u6LGRdQFD5nWrDACQ
         OPZA==
X-Gm-Message-State: AOAM530CktjnEJ163ui4fLoaObeP+k+kBJy4jpbc++EoeyA8tO/Pu0Ak
        PHbx5FjXw0dFgyRagLQcmZ0=
X-Google-Smtp-Source: ABdhPJz63n7FKzdnS+kQDfTNHZ55BKe5Mu34tk6dR4+iuFiynT9VT7QJ0Ep1FAuaf1vxQgMCLpvz9g==
X-Received: by 2002:a17:902:6bc8:b0:13f:8a54:1188 with SMTP id m8-20020a1709026bc800b0013f8a541188mr34521668plt.49.1634737279548;
        Wed, 20 Oct 2021 06:41:19 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.116])
        by smtp.gmail.com with ESMTPSA id b134sm2357894pga.3.2021.10.20.06.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 06:41:19 -0700 (PDT)
Subject: Re: [PATCH bpf-next 2/2 v2] selftests/bpf: Test
 bpf_skc_to_unix_sock() helper
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
References: <20211007141331.723149-1-hengqi.chen@gmail.com>
 <20211007141331.723149-3-hengqi.chen@gmail.com>
 <CAADnVQLGfg=iMUi4oQtMzY9Y+j_pZtAAHQ_b8zO6wPaL6C0ooA@mail.gmail.com>
 <10abc62b-a263-b157-912f-363ae1f80a4c@gmail.com>
 <CAEf4BzaiCMSnzXntfbcmSDO4u7TM-f0OO0NZThvbYA9GR6A7dw@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <4fdcdd5e-a741-dcf1-67b0-ec5a8b4f288a@gmail.com>
Date:   Wed, 20 Oct 2021 21:41:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzaiCMSnzXntfbcmSDO4u7TM-f0OO0NZThvbYA9GR6A7dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2021/10/20 1:02 AM, Andrii Nakryiko wrote:
> On Tue, Oct 19, 2021 at 8:23 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> Thanks for the review.
>>
>> On 10/19/21 9:46 AM, Alexei Starovoitov wrote:
>>> On Thu, Oct 7, 2021 at 7:14 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>>> +
>>>> +       sockaddr.sun_family = AF_UNIX;
>>>> +       strcpy(sockaddr.sun_path, sock_path);
>>>
>>> please use strncpy.
>>
>> Will do.
> 
> please also run checkpatch.pl and confirm you haven't introduced new
> styling issues. As one example (and please fix this up in the next
> revision), you are using C++-style comments.
> 

Thanks, Andrii.

Forgot to run checkpatch scripts before sending the email.
Will do that in future patches.

>>
>>>
>>>> +       len = sizeof(sockaddr);
>>>> +       unlink(sock_path);
>>>
>>> please use abstract socket to avoid unlink and potential race.
>>>
>>
>> Will switch to abstract socket and update the BPF program.
