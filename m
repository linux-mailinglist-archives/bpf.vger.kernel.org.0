Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6024661F3
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 12:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346203AbhLBLHJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Dec 2021 06:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241414AbhLBLHI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Dec 2021 06:07:08 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46206C06174A
        for <bpf@vger.kernel.org>; Thu,  2 Dec 2021 03:03:46 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id q74so72163112ybq.11
        for <bpf@vger.kernel.org>; Thu, 02 Dec 2021 03:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+fsDHd3p6tdXKWQfy12hcC12r1b8Y+iGAhNvj5nZUI=;
        b=48p3A7jdmd25Z6JZESEosQBlcXCuU/FZK4GqiPFbvqWSvzxr1zdzZaNA/50lT9+DcY
         1fibQyTuvm+1NiLBYaCKq2QqwBV98nMBXgZlLEP5w/r2GYx0UhSla9IRPh/kjH48nQVf
         T65rnzMjuq26Ki5dPgYvAD+oW30C/wuluZFGadCWhIBYgl8wo+lL9LWUSomb9nP6FD8V
         0uBjheAyf4U3webqPGBJlIc+afRsS148Nv6aDx0H3NpOnQ0VQ0chfIW84EVFOjp66M1F
         yyEpBRxEgX5Fl1VBdhvQ4BBPGFT77yh4N76wAo+iHyVx/3SbSioRVlN7Rtem2dh3sOFx
         A/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+fsDHd3p6tdXKWQfy12hcC12r1b8Y+iGAhNvj5nZUI=;
        b=D7ZRI52A/4jOw7rOSh3HAR5v9FfKIFBYsmfutWYHw4fG0S+/ua4U2B5xGlIohq9deW
         8m4xDzrHARFMoNaWkLNJEH/FRzkpBL8rdxqv2lRzQPAr0ByiFCSVgJmAY7C5vTt8FYi5
         UCoG6UhZhltCc6ubfhJMvnLEudUjyDmV+Z8APfcD03dv5Q1G5+DJxVygqC7t7T7HdrEj
         c+BlBpDN3mK8McZ1Mz0SHKb8YJeJBj2pjDLbOwislSc3iPuVFjIOEpaR/ZQvZ6A93JOc
         SX/rRYT5sbFZJUepW0/YI94QvldmpTPVN3v9On5lasS68LZ0R94ATuyvoltEu6l0kfSt
         rjYA==
X-Gm-Message-State: AOAM533jbGv/TYR38HftdShM5rvyQrJe6wSL1Se6UDqesoyclRJNwkFo
        CiA1t60NRcLOo3y1MLIipgaUDQAZ+VD1sIIdZCznRg==
X-Google-Smtp-Source: ABdhPJx4Dmdwrv7uw0uqRS1xvl2WNZx33MluR/nFRTZQeVs3eTgpXYTwYqryN6HaQHOfXvWYCv9+F9wnVveQM+mv68g=
X-Received: by 2002:a25:45c4:: with SMTP id s187mr13945259yba.440.1638443025444;
 Thu, 02 Dec 2021 03:03:45 -0800 (PST)
MIME-Version: 1.0
References: <PH0PR11MB479271060FA116D87B95E12DC5669@PH0PR11MB4792.namprd11.prod.outlook.com>
 <PH0PR11MB4792C2AC6C5185FBC95B9C21C5689@PH0PR11MB4792.namprd11.prod.outlook.com>
 <48bd2b51-485b-6b7a-3374-7239447f1efd@iogearbox.net>
In-Reply-To: <48bd2b51-485b-6b7a-3374-7239447f1efd@iogearbox.net>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Thu, 2 Dec 2021 12:03:34 +0100
Message-ID: <CAM1=_QSJFgjDTAZ9+LRL81GQy0FuHyOig23btm1d+E2t6dv1Qw@mail.gmail.com>
Subject: Re: kernel-selftests: make run_tests -C bpf cost 5 hours
To:     Daniel Borkmann <daniel@iogearbox.net>,
        "Zhou, Jie2X" <jie2x.zhou@intel.com>
Cc:     "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "kafai@fb.com" <kafai@fb.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "yhs@fb.com" <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, ZhijianX" <zhijianx.li@intel.com>,
        "Ma, XinjianX" <xinjianx.ma@intel.com>, lkp <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 2, 2021 at 10:26 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 12/1/21 7:54 AM, Zhou, Jie2X wrote:
> > ping
> >
> > ________________________________________
> > From: Zhou, Jie2X
> > Sent: Monday, November 29, 2021 3:36 PM
> > To: ast@kernel.org; daniel@iogearbox.net; andrii@kernel.org; kafai@fb.com; songliubraving@fb.com; yhs@fb.com; john.fastabend@gmail.com; kpsingh@kernel.org
> > Cc: netdev@vger.kernel.org; bpf@vger.kernel.org; linux-kernel@vger.kernel.org; Li, ZhijianX; Ma, XinjianX
> > Subject: kernel-selftests: make run_tests -C bpf cost 5 hours
> >
> > hi,
> >
> >     I have tested v5.16-rc1 kernel bpf function by make run_tests -C tools/testing/selftests/bpf.
> >     And found it cost above 5 hours.
> >
> >     Check dmesg and found that lib/test_bpf.ko cost so much time.
> >     In tools/testing/selftests/bpf/test_kmod.sh insmod test_bpf.ko four times.
> >     It took 40 seconds for the first three times.
> >
> >     When do 4th test among 1009 test cases from #812 ALU64_AND_K to  #936 JMP_JSET_K every test case cost above 1 min.
> >     Is it currently to cost so much time?
> >
> > kern :info : [ 1127.985791] test_bpf: #811 ALU64_MOV_K: all immediate value magnitudes
> > kern :info : [ 1237.158485] test_bpf: #812 ALU64_AND_K: all immediate value magnitudes jited:1 127955 PASS
> > kern :info : [ 1341.638557] test_bpf: #813 ALU64_OR_K: all immediate value magnitudes jited:1 155039 PASS
> > kern :info : [ 1447.725483] test_bpf: #814 ALU64_XOR_K: all immediate value magnitudes jited:1 129621 PASS
> > kern :info : [ 1551.808683] test_bpf: #815 ALU64_ADD_K: all immediate value magnitudes jited:1 120428 PASS
> > kern :info : [ 1655.550594] test_bpf: #816 ALU64_SUB_K: all immediate value magnitudes jited:1 175712 PASS
> > ......
> > kern :info : [16725.824950] test_bpf: #931 JMP32_JLE_X: all register value magnitudes jited:1 216508 PASS
> > kern :info : [16911.555675] test_bpf: #932 JMP32_JSGT_X: all register value magnitudes jited:1 178367 PASS
> > kern :info : [17101.466163] test_bpf: #933 JMP32_JSGE_X: all register value magnitudes jited:1 191436 PASS
> > kern :info : [17288.359154] test_bpf: #934 JMP32_JSLT_X: all register value magnitudes jited:1 165714 PASS
> > kern :info : [17480.615048] test_bpf: #935 JMP32_JSLE_X: all register value magnitudes jited:1 172846 PASS
> > kern :info : [17667.472140] test_bpf: #936 JMP_JSET_K: imm = 0 -> never taken jited:1 14 PASS
> >
> >     test_bpf.ko dmesg output is attached.
>
> On my side, I'm seeing:
>
> # time ./test_kmod.sh
> [ JIT enabled:0 hardened:0 ]
> [  107.182567] test_bpf: Summary: 1009 PASSED, 0 FAILED, [0/997 JIT'ed]
> [  107.200319] test_bpf: test_tail_calls: Summary: 8 PASSED, 0 FAILED, [0/8 JIT'ed]
> [  107.200379] test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED
> [ JIT enabled:1 hardened:0 ]
> [  108.130568] test_bpf: Summary: 1009 PASSED, 0 FAILED, [997/997 JIT'ed]
> [  108.143447] test_bpf: test_tail_calls: Summary: 8 PASSED, 0 FAILED, [8/8 JIT'ed]
> [  108.143510] test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED
> [ JIT enabled:1 hardened:1 ]
> [  109.116727] test_bpf: Summary: 1009 PASSED, 0 FAILED, [997/997 JIT'ed]
> [  109.129915] test_bpf: test_tail_calls: Summary: 8 PASSED, 0 FAILED, [8/8 JIT'ed]
> [  109.129979] test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED
> [ JIT enabled:1 hardened:2 ]
> [ 6617.952848] test_bpf: Summary: 1009 PASSED, 0 FAILED, [948/997 JIT'ed]
> [ 6617.965936] test_bpf: test_tail_calls: Summary: 8 PASSED, 0 FAILED, [8/8 JIT'ed]
> [ 6617.966004] test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED
>
> real    108m32.833s
> user    0m0.031s
> sys     108m17.939s
>
> The hardened:2 run takes significantly longer due to excessive patching for the
> jit constant blinding code.

I can confirm this too.

The slow tests are designed to check the result of all ALU and JMP
operations for as many different operand values as possible. It is not
feasible to test every combination of the two operand values, so the
space needs to be narrowed down. To exercise JIT code paths that
depend on the operand magnitude, values are chosen with different high
bit set (power-of-two magnitude) and some added small perturbations.
There is a quadratic pattern where both operands vary independently,
and a linear pattern were the MSBs are equal.

> Maybe the test cases can be reduced for the latter,
> otoh, it's good to know that they all pass as well.

The patterns described above can be tuned by changing the constants
PATTERN_BLOCK{1,2} in lib/test_bpf.c. According to my tests it seems
that the quadratic pattern takes most of the time, but the linear part
is not insignificant either. If I disable the quadratic pattern
completely and reduce the perturbation size for the linear pattern, I
get down to a more reasonable few seconds for each test case instead
of minutes.

The default test patterns may be a bit excessive, but they have also
found real bugs in some JITs. I would like to keep the settings as-is
for the non-hardened runs. I also think it is valuable to be able to
run the full tests during development. One solution could be to add a
module parameter for using a reduced pattern instead. Then the
test_kmod.sh script could set that parameter when running the 4:th
test, while still making it possible to run the full patterns with
hardening manually.

Thanks,
Johan
