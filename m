Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988285F3BDA
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 05:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJDDvF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Oct 2022 23:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJDDu7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Oct 2022 23:50:59 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79BD1FCE6
        for <bpf@vger.kernel.org>; Mon,  3 Oct 2022 20:50:42 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29405qMS000632
        for <bpf@vger.kernel.org>; Mon, 3 Oct 2022 20:50:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=YyT1Lf//qrKidR8OAjnsJ9Qj+9eUFrfcTHpNowoHsPI=;
 b=jGMJGyJuWmYMTOepSIGLkrL7+On/0Q+8ZwVhIXxHcSO3AowlTR4AQW94aUorEO2D5cBR
 b7yRUj+jmciYVJLmF/Sdy7ZP+ocmWYRMCSomNq51uhUrqUUcpCggmGKIkxOoQNOCt1Jb
 5lxu5E7X69f+PYj1Z1bwz3rLR7FBWmFa5eM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k094a96fn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 03 Oct 2022 20:50:42 -0700
Received: from twshared13579.04.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 20:50:40 -0700
Received: by devbig150.prn5.facebook.com (Postfix, from userid 187975)
        id 918CA110F8041; Mon,  3 Oct 2022 20:50:36 -0700 (PDT)
Date:   Mon, 3 Oct 2022 20:50:36 -0700
From:   Jie Meng <jmeng@fb.com>
To:     KP Singh <kpsingh@kernel.org>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next] bpf,x64: Remove unnecessary check on existence
 of SSE2
Message-ID: <YzutjPBbEYOPeEzG@fb.com>
References: <20221003011727.1192900-1-jmeng@fb.com>
 <CACYkzJ7_ZNKsE5b9ECqf7+U9qs8E2hbx4GXvAhrnG3iVApqLjg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACYkzJ7_ZNKsE5b9ECqf7+U9qs8E2hbx4GXvAhrnG3iVApqLjg@mail.gmail.com>
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: rub-1tvRGnFM9XcIuMaqZr3KBbMYZc3u
X-Proofpoint-GUID: rub-1tvRGnFM9XcIuMaqZr3KBbMYZc3u
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_02,2022-09-29_03,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 04, 2022 at 03:04:20AM +0200, KP Singh wrote:
> On Mon, Oct 3, 2022 at 3:17 AM Jie Meng <jmeng@fb.com> wrote:
> >
> > SSE2 and hence lfence are architectural in x86-64 and no need to check
> > whether they're supported in CPU.
> 
> Why do you say this?
> 
> The Instruction set reference does mention that:
> 
> Exceptions:
> 
> #UD If CPUID.01H:EDX.SSE2[bit 26] = 0
> 
> (undefined instruction when the CPUID.SSE2 bit is unset)
> 
> and also that the CPUID feature flag is SSE2

Many x86 extensions predate x86-64. When they designed x86-64, AMD
decided to make some mandatory (and hence architectural) and SSE2 is
one of them[1]. CMOV, NOPL, PAE, NX etc. are other examples.

These extensions' CPUID flags are still set. If code is to be shared
between x86 and x86-64 one can still check CPUID, but bpf_jit_comp.c
is compiled under x86-64 only so the check is redundant.

There's an example Within kernel code too: arch/x86/lib/copy_user_64.S
uses SSE (sfence) and SSE2 (movnti) instructions and doesn't check
CPUID for their presence.

---
[1] https://en.wikipedia.org/wiki/X86-64#Microarchitecture_levels

> >
> > Signed-off-by: Jie Meng <jmeng@fb.com>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index d09c54f3d2e0..b2124521305e 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1289,8 +1289,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
> >
> >                         /* speculation barrier */
> >                 case BPF_ST | BPF_NOSPEC:
> > -                       if (boot_cpu_has(X86_FEATURE_XMM2))
> > -                               EMIT_LFENCE();
> > +                       EMIT_LFENCE();
> >                         break;
> >
> >                         /* ST: *(u8*)(dst_reg + off) = imm */
> > --
> > 2.30.2
> >
