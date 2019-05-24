Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B036D2A076
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 23:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404239AbfEXVhd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 17:37:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44098 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391752AbfEXVhd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 17:37:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id w13so2945000wru.11
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 14:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZXNdTN7Epuk1DIy8cjJ0aPMtyJGk9nG9BDG7l3BZVUQ=;
        b=mphjgm5xN+726FbtVDMNdza7A+ACFXBSF64qohOjSTNLxj369494mOSWdBBHgQLYoo
         t/0kI4mq1AVVmuWsrDuXD1o84IZrffq6aqBfk551Qagm+hb7M+c0Jn3dYd65oMg5Riue
         YB+5CC71oALLA6eRGnU8N4vzGgNgPAK3bL2QGt8niz6sr6CzInFcBK/2DfGcZkn81wb6
         rmaMT1Fl/2iavrNpFonuwEFv/Gsanmi70pSTHDK+Hn9xefv72g41/wM2QHrMCpn/poja
         gZTEhVqJxAlT0n/LQpeihxghkjxoIm6TQ8pg1zqLapBaT+ouSYhOlojVzvrL5vGdm11h
         t7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZXNdTN7Epuk1DIy8cjJ0aPMtyJGk9nG9BDG7l3BZVUQ=;
        b=OAwy9ULY87CNBoFrZjAXGXHnY4/j5p6npSUkd7Ah3iQWiaCONT3O9vxRoGfO1/Ebvx
         KNHofnvdCBIc+fBenUf0KltCKQE1fSLJ1Tg446lqDGRhOHOmKfwF1b8s+DDL+ODMj/eC
         /bFmmQR4bFjvf7ucnA61AQy9HLBV1154u11mk7u1bkvNFLjGlE2mgJD1KArmZXvFuBZ7
         xLysgaudS7yxQMApofqFNR9czDWcPR4fxz8ehIFwS1Dji90wS0HlcMZJ8rQtN57mf6wQ
         z3F+ylNf/VLxoRcnKGMEIKmlgwiDCkYpP4rpq4aCkYTOsO+gRk9dEkSzt9gu5lRnTA56
         LQDA==
X-Gm-Message-State: APjAAAWW8+IB4ynCR5nskkUItxzk6m5m0WVCK+DZTG1ctHOw653YMl9m
        LW70xayho3NjmMsnMKgXjZPFSQ==
X-Google-Smtp-Source: APXvYqy/EsvfxYVoM90veGGidZEmTZMf7qM+NsJT/MyU66H1T+RP9Zn0Ay1aSjgmXoPUny8l5La7ew==
X-Received: by 2002:a5d:4692:: with SMTP id u18mr53328452wrq.285.1558733851297;
        Fri, 24 May 2019 14:37:31 -0700 (PDT)
Received: from [192.168.0.10] (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id f10sm5531315wrg.24.2019.05.24.14.37.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 14:37:30 -0700 (PDT)
Subject: Re: [PATCH v8 bpf-next 05/16] bpf: introduce new bpf prog load flags
 "BPF_F_TEST_RND_HI32"
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, davem@davemloft.net,
        paul.burton@mips.com, udknight@gmail.com, zlim.lnx@gmail.com,
        illusionist.neo@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, jakub.kicinski@netronome.com,
        andriin@fb.com
References: <1558697726-4058-1-git-send-email-jiong.wang@netronome.com>
 <1558697726-4058-6-git-send-email-jiong.wang@netronome.com>
 <20190524204343.kprqtget3pwireak@ast-mbp.dhcp.thefacebook.com>
From:   Jiong Wang <jiong.wang@netronome.com>
Message-ID: <61518035-08a6-fa7d-75a9-7d5fc9a01df3@netronome.com>
Date:   Fri, 24 May 2019 22:37:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524204343.kprqtget3pwireak@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 24/05/2019 21:43, Alexei Starovoitov wrote:
> On Fri, May 24, 2019 at 12:35:15PM +0100, Jiong Wang wrote:
>> x86_64 and AArch64 perhaps are two arches that running bpf testsuite
>> frequently, however the zero extension insertion pass is not enabled for
>> them because of their hardware support.
>>
>> It is critical to guarantee the pass correction as it is supposed to be
>> enabled at default for a couple of other arches, for example PowerPC,
>> SPARC, arm, NFP etc. Therefore, it would be very useful if there is a way
>> to test this pass on for example x86_64.
>>
>> The test methodology employed by this set is "poisoning" useless bits. High
>> 32-bit of a definition is randomized if it is identified as not used by any
>> later insn. Such randomization is only enabled under testing mode which is
>> gated by the new bpf prog load flags "BPF_F_TEST_RND_HI32".
>>
>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
>> ---
>>   include/uapi/linux/bpf.h       | 18 ++++++++++++++++++
>>   kernel/bpf/syscall.c           |  4 +++-
>>   tools/include/uapi/linux/bpf.h | 18 ++++++++++++++++++
>>   3 files changed, 39 insertions(+), 1 deletion(-)
> one more nit:
> could you please split this patch into two?
> Our mostly automatic sync of kernel/libbpf into github/libbpf will fail
> when tools/../bpf.h is not a separate commit.

OK, will do shortly.

Regards,
Jiong

