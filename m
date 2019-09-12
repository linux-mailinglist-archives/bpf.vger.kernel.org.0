Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CED56B14C8
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2019 21:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfILT1H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Sep 2019 15:27:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49916 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfILT1G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Sep 2019 15:27:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8CJEI4a082576
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2019 19:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=VDm8kTp6tJkH0tG43vjMNPVKkmqG8jFhyBWaYlwYfgE=;
 b=YNlHLnwib/k2Wcu8Vt2XL0OnGDQHCWb+itrlVrXR9InlOpVL/JhLb3jh+L+zHHJsjtnV
 bU+81uXHo0LjeYrrm2NK1yxJE2JajcIQtcxdxRc6JsFzLrTAnbDEKQifk313ZntdmrBL
 21LFvBek7cQ7d7ogePe73HsPMGJs2d5QXfQ5+nRzexvs8ahnm3a6eMhwBh4SBI7d6PkK
 oNxIzHB8GlAf9Js84xbmSqSoJc5PPguaHdJDHGz5ReGoLS7o29CpXY7eqDw5YUS4GUua
 RXbUdw+JnFJyATaEHbZ71F35eEBNRacCpoyGhKZMSL3exh4vRvJzEQQxUaNTwWrg4B35 JA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2uytd3gj2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2019 19:27:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8CJDci3057343
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2019 19:27:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2uytdvumf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2019 19:27:04 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8CJR3nW031218
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2019 19:27:03 GMT
Received: from termi.oracle.com (/198.168.27.218)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Sep 2019 12:27:03 -0700
From:   jose.marchesi@oracle.com (Jose E. Marchesi)
To:     bpf@vger.kernel.org
Subject: [GCC,LLVM] bpf_helpers.h
Date:   Thu, 12 Sep 2019 21:26:57 +0200
Message-ID: <87lfutgvsu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9378 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909120201
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9378 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909120201
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hi people!

First of all, many thanks for the lots of feedback I got at the LPC
conference.  It was very useful and made these days totally worth it :)

In order to advance in the direction of having a single bpf_helpers.h
header that works with both llvm and gcc, I would like to suggest a few
changes for the kernel's header.

Kernel helpers
--------------

First, there is the issue of kernel helpers.  You people made it very
clear at LPC that having a compiler built-in function per kernel helper
is way too restrictive, since it makes it impossible to use new kernel
helpers without patching the compiler.  I agree.

However, I still think that the function pointer hack currently used in
bpf_helpers.h is way too fragile, depending on the optimization level
and the particular behavior of the compiler.

Thinking about a more robust and flexible solution, today I wrote a
patch for GCC that adds a target-specific function attribute:

   __attribute__ ((kernel_helper (NUM)))

Then I changed my bpf-helpers.h to define the kernel helpers like:

   void *bpf_map_lookup_elem (void *map, const void *key)
      __attribute__ ((kernel_helper (1)));

This new mechanism allows the user to mark any function prototype as a
kernel helper, so the flexibility is total.  It also allowed me to get
rid of the table of helpers in the GCC backend proper, which is awesome
:)

Would you consider implementing this attribute in llvm and adapt the
kernel's bpf_header accordingly?  In that respect, note that it is
possible to pass enum entries to the attribute (at least in GCC.)  So
you once you implement the attribute, you should be able to do:

   void *bpf_map_lookup_elem (void *map, const void *key)
       __attribute__ ((kernel_helper (BPF_FUNC_map_lookup_elem)));

instead of the current:

   static void *(*bpf_map_lookup_elem)(void *map, const void *key) =
	(void *) BPF_FUNC_map_lookup_elem;

Please let me know what do you think.

SKB load built-ins
------------------

bpf_helpers.h contains the following llvm-isms:

   /* llvm builtin functions that eBPF C program may use to
    * emit BPF_LD_ABS and BPF_LD_IND instructions
    */
   struct sk_buff;
   unsigned long long load_byte(void *skb,
                                unsigned long long off) asm("llvm.bpf.load.byte");
   unsigned long long load_half(void *skb,
			        unsigned long long off) asm("llvm.bpf.load.half");
   unsigned long long load_word(void *skb,
			        unsigned long long off) asm("llvm.bpf.load.word");

Would you consider adopting more standard built-ins in llvm, like I
implemented in GCC?  These are:

   __builtin_bpf_load_byte (unsigned long long off)
   __builtin_bpf_load_half (unsigned long long off)
   __builtin_bpf_load_word (unsigned long long off)

Note that I didn't add an SKB argument to the builtins, as it is not
used: the pointer to the skb is implied by the instructions to be in
some predefined register.  I added compatibility wrappers in my
bpf-helpers.h:

  #define load_byte(SKB,OFF) __builtin_bpf_load_byte ((OFF))
  #define load_half(SKB,OFF) __builtin_bpf_load_half ((OFF))
  #define load_word(SKB,OFF) __builtin_bpf_load_word ((OFF))

Would you consider removing the unused SKB arguments from the built-ins
in llvm?  Or is there a good reason for having them, other than maybe
backwards compatibility?  In case backwards compatibility is a must, I
can add the unused argument to my builtins.

Thanks!
