Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D9B32C1EF
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449689AbhCCWxi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387041AbhCCTPS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 14:15:18 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07BAC061756
        for <bpf@vger.kernel.org>; Wed,  3 Mar 2021 11:14:38 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id e9so4986065pjj.0
        for <bpf@vger.kernel.org>; Wed, 03 Mar 2021 11:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=k4jBZrFbV5z5C+8VpzHIjWbEzvPUkgb89xssp4fGpJY=;
        b=r9/TcZaLLPtkrbWxQm5ZqCCvdnLL138WIXcHAkp4uJ44kSq892Nde99fe0Z9wuh6Fq
         QHDhi2UmvACYcjTgvWzBojSyGD8q9nJeeRGBRN4gQehgj/Cmhwvf3iAheplKRy22l3Au
         KpMFDOCeTxHej/CuwOS4kPtTif/ztYOORF/jb+5VptwODSNQUn59I6jduHXX4yPxZhVP
         2ulz4KcYSFe0Wjolb9sIX30psLeoprlxFBs9lFp+ElysN3/0QIkln+jRWVZYAWtTBUXK
         7UL7KhqWdiFx//r4rG6Ip75S5C6KQzMBYWFm6Z8nufWvT63zH1MoSTdIujV2+idqb7Es
         MEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=k4jBZrFbV5z5C+8VpzHIjWbEzvPUkgb89xssp4fGpJY=;
        b=fF+o/fFDDs6iLqpUTOx25vz/Sqj7WV3Sw1YwY+QFGCqRTe873cBaohm2IIu/+3zNEs
         yMBORCO84tOSTvS20hEsBX8oCMspHKctCzzspbqIpBfV23ILRgE27SA7NwJNYoWiBSqh
         HXYLWgzgWN2ZkdnYV18m3dWlKoSeobFAPS/IE7gTepP2W006WDvhskZR51ySxlLrhetZ
         /VgeEv6H4PouEmebx9ns9c92QkZfF3eQTJ4FNDiym2OcbjUEgDjc6U+qf3bUI4qA1YLR
         huykClnt9U2dx+auwLJhn1AJYCI4NougQ5CvsT8563bMsHMuuRaqAq/OGz0e75QmdA2+
         EMyQ==
X-Gm-Message-State: AOAM532h38gqGzCViYQOn9CP7fVB9dQQjwyiLgh1KqOMxJWnYYXCYnzP
        MPAnHjoR9Y8RLMUMvL7tFt8ZG5OM1koKnA==
X-Google-Smtp-Source: ABdhPJwcIrb5IbtzbgJ0PzMEfiISby6O5NvZxZfvV/2oRTzXzdv64m6kabldrocwVcHKTKFcSI3GEg==
X-Received: by 2002:a17:902:b089:b029:e3:28:b8ee with SMTP id p9-20020a170902b089b02900e30028b8eemr615480plr.84.1614798878128;
        Wed, 03 Mar 2021 11:14:38 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:d817:cd13:9030:8391? ([2601:646:c200:1ef2:d817:cd13:9030:8391])
        by smtp.gmail.com with ESMTPSA id k5sm7076673pjl.50.2021.03.03.11.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 11:14:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: Why do kprobes and uprobes singlestep?
Date:   Wed, 3 Mar 2021 11:14:36 -0800
Message-Id: <39348848-C213-4739-B002-5BFACDA981C1@amacapital.net>
References: <20210303181111.th5ukrfzrmyuvk5x@maharaja.localdomain>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andy Lutomirski <luto@kernel.org>, bpf <bpf@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <20210303181111.th5ukrfzrmyuvk5x@maharaja.localdomain>
To:     Daniel Xu <dxu@dxuuu.xyz>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Mar 3, 2021, at 10:11 AM, Daniel Xu <dxu@dxuuu.xyz> wrote:
>=20
> =EF=BB=BFOn Tue, Mar 02, 2021 at 06:18:23PM -0800, Alexei Starovoitov wrot=
e:
>>> On Tue, Mar 2, 2021 at 5:46 PM Andy Lutomirski <luto@amacapital.net> wro=
te:
>>>=20
>>>=20
>>>> On Mar 2, 2021, at 5:22 PM, Alexei Starovoitov <alexei.starovoitov@gmai=
l.com> wrote:
>>>>=20
>>>> =EF=BB=BFOn Tue, Mar 2, 2021 at 1:02 PM Andy Lutomirski <luto@amacapita=
l.net> wrote:
>>>>>=20
>>>>>=20
>>>>>>> On Mar 2, 2021, at 12:24 PM, Alexei Starovoitov <alexei.starovoitov@=
gmail.com> wrote:
>>>>>>=20
>>>>>> =EF=BB=BFOn Tue, Mar 2, 2021 at 10:38 AM Andy Lutomirski <luto@kernel=
.org> wrote:
>>>>>>>=20
>>>>>>> Is there something like a uprobe test suite?  How maintained /
>>>>>>> actively used is uprobe?
>>>>>>=20
>>>>>> uprobe+bpf is heavily used in production.
>>>>>> selftests/bpf has only one test for it though.
>>>>>>=20
>>>>>> Why are you asking?
>>>>>=20
>>>>> Because the integration with the x86 entry code is a mess, and I want t=
o know whether to mark it BROKEN or how to make sure the any cleanups actual=
ly work.
>>>>=20
>>>> Any test case to repro the issue you found?
>>>> Is it a bug or just messy code?
>>>=20
>>> Just messy code.
>>>=20
>>>> Nowadays a good chunk of popular applications (python, mysql, etc) has
>>>> USDTs in them.
>>>> Issues reported with bcc:
>>>> https://github.com/iovisor/bcc/issues?q=3Dis%3Aissue+USDT
>>>> Similar thing with bpftrace.
>>>> Both standard USDT and semaphore based are used in the wild.
>>>> uprobe for containers has been a long standing feature request.
>>>> If you can improve uprobe performance that would be awesome.
>>>> That's another thing that people report often. We optimized it a bit.
>>>> More can be done.
>>>=20
>>>=20
>>> Wait... USDT is much easier to implement well.  Are we talking just USDT=
 or are we talking about general uprobes in which almost any instruction can=
 get probed?  If the only users that care about uprobes are doing USDT, we c=
ould vastly simplify the implementation and probably make it faster, too.
>>=20
>> USDTs are driving the majority of uprobe usage.
>=20
> I'd say 50/50 in my experience. Larger userspace applications using bpf
> for production monitoring tend to use USDT for stability and ABI reasons
> (hard for bpf to read C++ classes). Bare uprobes (ie not USDT) are used
> quite often for ad-hoc production debugging.
>=20
>> If they can get faster it will increase their adoption even more.
>> There are certainly cases of normal uprobes.
>> They are at the start of the function 99% of the time.
>> Like the following:
>> "uprobe:/lib64/libc.so:malloc(u64 size):size:size,_ret",
>> "uprobe:/lib64/libc.so:free(void *ptr)::ptr",
>> is common despite its overhead.
>>=20
>> Here is the most interesting and practical usage of uprobes:
>> https://github.com/iovisor/bcc/blob/master/tools/sslsniff.py
>> and the manpage for the tool:
>> https://github.com/iovisor/bcc/blob/master/tools/sslsniff_example.txt
>>=20
>> uprobe in the middle of the function is very rare.
>> If the kernel starts rejecting uprobes on some weird instructions
>> I suspect no one will complain.
>=20
> I think it would be great if the kernel could reject mid-instruction
> uprobes. Unlike with kprobes, you can place uprobes on immediate
> operands which can cause silent data corruption. See
> https://github.com/iovisor/bpftrace/pull/803#issuecomment-507693933
> for a funny example.

This can=E2=80=99t be done in general on x86. One cannot look at code and fi=
nd the instruction boundaries.

>=20
> To prevent accidental (and silent) data corruption, bpftrace uses a
> disassembler to ensure uprobes are placed on instruction boundaries.
>=20
> <...>
>=20
> Daniel
