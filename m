Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5445DB4EFB
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2019 15:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfIQNRv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Sep 2019 09:17:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43358 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfIQNRv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Sep 2019 09:17:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8HD8uZq013222;
        Tue, 17 Sep 2019 13:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=XzNv1MZ6Of13L3ansgEAWq2Tt2vhFnfvQBf/yJ5nqLA=;
 b=iBVbQ6/2L93nLAffwpGKtKErM5dFQVHExgpwIo+CoQSIDDUAspOTJU5iybdxUSJ2CBDs
 W6bQvXnMhcYI09bdy1uqkiNu/X1BnNWvfsTZjBkbZcgThNBw+qzMmJzqzNYOr6SmpSks
 BzBWnpqpTbzF6U8wXQJoJ9vQT4REb3VgTbbIxe8as8KYeUI8MpvIdLyoijAiqRKnMrYu
 R4kphHA0hXUvtOG4tyFGBWPsXvleFPCl2fItvJzOuHhxsS0VDsu6QU7Gt3XpDte14rjZ
 CblXUmZK8cPiaM19f9834EEtNy9TLxzHfp4RVGd5XuBPqdi0Zv5ke+XFTY794XNgUktg GQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2v0ruqp94c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Sep 2019 13:17:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8HD8QbN081715;
        Tue, 17 Sep 2019 13:17:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2v2tmsqe0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Sep 2019 13:17:23 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8HDHLUE008812;
        Tue, 17 Sep 2019 13:17:21 GMT
Received: from termi.oracle.com (/10.175.7.130)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Sep 2019 06:17:21 -0700
From:   jose.marchesi@oracle.com (Jose E. Marchesi)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net
Subject: Re: [GCC,LLVM] bpf_helpers.h
References: <87lfutgvsu.fsf@oracle.com>
        <20190916161742.54yabm3plqert2af@ast-mbp>
Date:   Tue, 17 Sep 2019 15:17:10 +0200
In-Reply-To: <20190916161742.54yabm3plqert2af@ast-mbp> (Alexei Starovoitov's
        message of "Mon, 16 Sep 2019 09:18:17 -0700")
Message-ID: <87sgov2hbd.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909170130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909170130
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


    [...]
    > Would you consider implementing this attribute in llvm and adapt the
    > kernel's bpf_header accordingly?  In that respect, note that it is
    > possible to pass enum entries to the attribute (at least in GCC.)  So
    > you once you implement the attribute, you should be able to do:
    > 
    >    void *bpf_map_lookup_elem (void *map, const void *key)
    >        __attribute__ ((kernel_helper (BPF_FUNC_map_lookup_elem)));
    > 
    > instead of the current:
    > 
    >    static void *(*bpf_map_lookup_elem)(void *map, const void *key) =
    > 	(void *) BPF_FUNC_map_lookup_elem;
    
    What we've been using for long time is not exactly normal C code,
    but it's a valid C code that any compiler and any backend should
    consume and generate the code prescribed by the language.
    Here it says that it's a function pointer with fixed offset.
    x86 backends in both clang and gcc do the right thing.

    I don't understand why it's causing bpf backend for gcc to stumble.
    You mentioned "helper table in gcc bpf backend".
    That sounds like a red flag.
    The backend should not know names and numbers for helpers.
    For the following:
    static void (*foo)(void) = (void *) 123;
    int bar()
    {
            foo();
    }
    It should generate bpf instruction 'bpf_call 123', since that's
    what C language is asking compiler to do.

The C language does not prescribe compilers to generate any particular
flavor of call instruction...

... but that point is moot in this case since bpf only provides one such
kind of call instruction, and it is perfectly capable of handling the
situation above, so the compiler should use it, ideally at _any_
optimization level, and that includes -O0.

So ok.  What you say makes sense to me.  I'm convinced.

As for the table of helpers in the compiler, got the same feedback at
plumbers and I'm removing it. One less maintenance hurdle :)

    It is as you pointed out 'fragile', since it won't work with -O0,
    but that sort of the point. -O0 is too debuggy and un-optimized
    that even without this call insn quirk the verifier is not able
    to analyze even simple programs.
    Hence -O2 was a requirement for bpf development due to verifier smartness.
    One can argue that the verifier should become even smarter and analyze -O0 code,
    but I would argue otherwise. Linux kernel itself won't work with -O0.
    Same reasoning applies to bpf code. The main purpose of -O0 for user space
    development is to produce code together with -g that debugger can understand.
    The variables will stay on stack, line numbers will be intact, etc
    For bpf program development that's anti pattern.
    The 'bpf debugging' topic at plumbers showed that we still has a long way
    to go to make bpf debugging better. Single step, execution trace, nested bpf, etc
    All that will come, but -O0 support will not.

I see.  Good to know.
    
    > Please let me know what do you think.
    > 
    > SKB load built-ins
    > ------------------
    > 
    > bpf_helpers.h contains the following llvm-isms:
    > 
    >    /* llvm builtin functions that eBPF C program may use to
    >     * emit BPF_LD_ABS and BPF_LD_IND instructions
    >     */
    >    struct sk_buff;
    >    unsigned long long load_byte(void *skb,
    >                                 unsigned long long off) asm("llvm.bpf.load.byte");
    >    unsigned long long load_half(void *skb,
    > 			        unsigned long long off) asm("llvm.bpf.load.half");
    >    unsigned long long load_word(void *skb,
    > 			        unsigned long long off) asm("llvm.bpf.load.word");
    > 
    > Would you consider adopting more standard built-ins in llvm, like I
    > implemented in GCC?  These are:
    > 
    >    __builtin_bpf_load_byte (unsigned long long off)
    >    __builtin_bpf_load_half (unsigned long long off)
    >    __builtin_bpf_load_word (unsigned long long off)
    > 
    > Note that I didn't add an SKB argument to the builtins, as it is not
    > used: the pointer to the skb is implied by the instructions to be in
    > some predefined register.  I added compatibility wrappers in my
    > bpf-helpers.h:
    > 
    >   #define load_byte(SKB,OFF) __builtin_bpf_load_byte ((OFF))
    >   #define load_half(SKB,OFF) __builtin_bpf_load_half ((OFF))
    >   #define load_word(SKB,OFF) __builtin_bpf_load_word ((OFF))
    > 
    > Would you consider removing the unused SKB arguments from the built-ins
    > in llvm?  Or is there a good reason for having them, other than maybe
    > backwards compatibility?  In case backwards compatibility is a must, I
    > can add the unused argument to my builtins.
    
    llvm.bpf.load.word consumes 'skb' pointer. llvm bpf backend makes sure
    that it's in R6 before LD_ABS insn.
    __builtin_bpf_load_byte (unsigned long long off) cannot produce correct code.

So it is the 'skb' pointer that is loaded into %r6.  I misunderstood.
Will adapt the GCC built-ins accordingly.
    
    As far as doing it as __builtin_bpf_load_word(skb, off) instead of
    asm("llvm.bpf.load.word") that's fine, of course.
    Here compilers don't have to be the same.
    #ifdef clang vs gcc in bpf_helpers.h should do it.

Ok.

    Also please get rid of bpf-helpers.h from gcc tree.
    There shouldn't be such things shipped with compiler.

bpf-helpers.h is a temporal solution.  Will remove it as soon as we have
a bpf_helpers.h in the kernel that works with both compilers.

Thanks for the feedback!
