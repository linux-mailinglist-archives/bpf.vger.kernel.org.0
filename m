Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8DFC152517
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2020 04:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgBEDFe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Feb 2020 22:05:34 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38280 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgBEDFd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Feb 2020 22:05:33 -0500
Received: by mail-pj1-f68.google.com with SMTP id j17so322860pjz.3
        for <bpf@vger.kernel.org>; Tue, 04 Feb 2020 19:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=eH0rpR/5UsjYJvawXdVJ3pMlqI+aJHHpMICaLRSG+80=;
        b=UVdXLGZNS1bADPWaa3CvILT6/Kr8/aAilS69qBpnWfe8PVq0BBR/dJjivT7OllgqP9
         2fLwM3UPTbA3av2OkEZvP42cPpM62yYRaV3iuYFN6/twd1giYHfAzbDJVHgSeY6PIzqp
         MQ5GN8GZp6VIonJNdjMD+iddHHxueAp+m5JLROWPOVcrFr2FDkBFFa3PTU3xU0oMCpM6
         VEDLfhguHiEHmWGA/beuaBJhINjEEUNLqWYygVV/oMTUtQ5dGjQFl6ia1oc3goMZtIgA
         HGg0u2hwsu/nuVGGz4aAQDJYWzEtaumk6DE0hAyfc6nBoxoxgsym65EZPfb+kN9hexp5
         WL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=eH0rpR/5UsjYJvawXdVJ3pMlqI+aJHHpMICaLRSG+80=;
        b=F8bOhsiKwLYLK2Dto+z43RAtIVXtDXYefReb2AHufVFR5JxBXe+aP8ozaPto9T1m51
         AgWO+opLH3LH6S4yiS8Y6cDDdfRG4Yco5w55LmNn4Ir6psfaMSZhs7xswHm++dhrv+nw
         sEwWpt76x0N3Iv7DZj5UDI0oKPQ2+x2hjbiX2A5iz2kVvj5RfCipZBaDnW4Qx/+r58k5
         R+42w4ycX2Id8mc0gPtfhiPuWd6AxrxADpiObYmv/EzkqWdKP0YqJm8QvTlFvf/gWhnE
         54+h5fTDMwaM8ry8mjxbqu9O0ScA2xlaj4CbAWxaH5amIIB1kSx+HuYb56mMPnEYwF0J
         GpOQ==
X-Gm-Message-State: APjAAAUq7wTAM2rnJnyFr/xgEzSy15/TTMgaIsQ39VK+cBiCEaYOIsju
        y4zZpoyD2x2FL7NR5t9bo8k=
X-Google-Smtp-Source: APXvYqyCguwATiHik9isF8EZd5+UO31+PhyATG6aDiIgNpGHh5fK8pb7fWlY9vVfwU13uisnTJYZtw==
X-Received: by 2002:a17:902:8f8a:: with SMTP id z10mr33843356plo.169.1580871931480;
        Tue, 04 Feb 2020 19:05:31 -0800 (PST)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id m26sm4719723pgc.84.2020.02.04.19.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 19:05:30 -0800 (PST)
Date:   Tue, 04 Feb 2020 19:05:23 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Message-ID: <5e3a30f3a9221_3b4f2ab2596925b8e3@john-XPS-13-9370.notmuch>
In-Reply-To: <fe3e8178-c069-4299-10df-8c983388c48c@fb.com>
References: <158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370>
 <b26a97e0-6b02-db4b-03b3-58054bcb9b82@iogearbox.net>
 <CAADnVQ+YhgKLkVCsQeBmKWxfuT+4hiHAYte9Xnq8XpC8WedQXQ@mail.gmail.com>
 <99042fc3-0b02-73cb-56cd-fc9a4bfdf3ee@iogearbox.net>
 <5e320c9a30f64_2a332aadcd1385bc3f@john-XPS-13-9370.notmuch>
 <20200130000415.dwd7zn6wj7qlms7g@ast-mbp>
 <5e33147f55528_19152af196f745c460@john-XPS-13-9370.notmuch>
 <20200130175935.dauoijsxmbjpytjv@ast-mbp.dhcp.thefacebook.com>
 <5e336803b5773_752d2b0db487c5c06e@john-XPS-13-9370.notmuch>
 <20200131024620.2ctms6f2il6qss3q@ast-mbp>
 <5e33bfb6414eb_7c012b2399b465bcfe@john-XPS-13-9370.notmuch>
 <CAADnVQL+hBuz8AgJ-Tv8iWFoGdpXwSmdqHVzX5NgR_1Lfpx3Yw@mail.gmail.com>
 <5e3460d3a3fb1_4a9b2ab23eff45b82c@john-XPS-13-9370.notmuch>
 <CAADnVQ+m70Pzs33mAhsF0JEx+LVoXrTZyC-szhyk+cNo71GgXw@mail.gmail.com>
 <5e39cc3957bd1_63882ad0d49345c0c5@john-XPS-13-9370.notmuch>
 <fe3e8178-c069-4299-10df-8c983388c48c@fb.com>
Subject: Re: [bpf PATCH v3] bpf: verifier, do_refine_retval_range may clamp
 umin to 0 incorrectly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song wrote:
> 
> 
> On 2/4/20 11:55 AM, John Fastabend wrote:
> > Alexei Starovoitov wrote:
> >> On Fri, Jan 31, 2020 at 9:16 AM John Fastabend <john.fastabend@gmail.com> wrote:
> >>>
> >>> Also don't mind to build pseudo instruction here for signed extension
> >>> but its not clear to me why we are getting different instruction
> >>> selections? Its not clear to me why sext is being chosen in your case?

[...]

> >> zext is there both cases and it will be optimized with your llvm patch.
> >> So please send it. Don't delay :)
> > 
> > LLVM patch here, https://urldefense.proofpoint.com/v2/url?u=https-3A__reviews.llvm.org_D73985&d=DwICaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=DA8e1B5r073vIqRrFz7MRA&m=VnK0SKxGnw_yzWjaO-cZFrmlZB9p86L4me-mWE_vDto&s=jwDJuAEdJ23HVcvIILvkfxvTNSe_cgHQFn_MpXssfXc&e=
> > 
> > With updated LLVM I can pass selftests with above fix and additional patch
> > below to get tighter bounds on 32bit registers. So going forward I think
> > we need to review and assuming it looks good commit above llvm patch and
> > then go forward with this series.
> 
> Thanks. The llvm patch looks sane, but after applying the patch, I hit 
> several selftest failures. For example, strobemeta_nounroll1.o.
> 
> The following is a brief analysis of the verifier state:
> 
> 184: 
> R0=inv(id=0,smax_value=9223372032559808513,umax_value=18446744069414584321,var_off=(0x0; 
> 0xffffffff00000001))
> R7=inv0
> 
> 184: (bc) w7 = w0
> 185: 
> R0=inv(id=0,smax_value=9223372032559808513,umax_value=18446744069414584321,var_off=(0x0; 
> 0xffffffff00000001))
> R7_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0x1))
> 
> 185: (67) r7 <<= 32
> 186: 
> R0=inv(id=0,smax_value=9223372032559808513,umax_value=18446744069414584321,var_off=(0x0; 
> 0xffffffff00000001))
> R7_w=inv(id=0,umax_value=4294967296,var_off=(0x0; 0x100000000))
> 
> 186: (77) r7 >>= 32
> 187: 
> R0=inv(id=0,smax_value=9223372032559808513,umax_value=18446744069414584321,var_off=(0x0; 
> 0xffffffff00000001))
> R7_w=inv(id=0,umax_value=1,var_off=(0x0; 0x1))
> 
> You can see after left and right shift, we got a better R7 umax_value=1.
> Without the left and right shift, eventually verifier complains.
> 
> Can we make uname_value=1 at insn 'w7 = w0'?
> Currently, we cannot do this due to the logic in coerce_reg_to_size().
> It looks correct to me to ignore the top mask as we know the upper 32bit 
> will be discarded.
> 
> I have implemented in my previous patch to deal with signed compares.
> The following is the patch to fix this particular issue:

[...]

> 
> With the above patch, there is still one more issue in test_seg6_loop.o, 
> which is related to llvm code generation, w.r.t. our strange 32bit 
> packet begin and packet end.
> 
> The following patch is generated:
> 
> 2: (61) r1 = *(u32 *)(r6 +76)
> 3: R1_w=pkt(id=0,off=0,r=0,imm=0) R2_w=pkt_end(id=0,off=0,imm=0) 
> R6_w=ctx(id=0,off=0,imm=0) R10=fp0
> ; cursor = (void *)(long)skb->data;
> 3: (bc) w8 = w1
> 4: R1_w=pkt(id=0,off=0,r=0,imm=0) R2_w=pkt_end(id=0,off=0,imm=0) 
> R6_w=ctx(id=0,off=0,imm=0) 
> R8_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0
> ; if ((void *)ipver + sizeof(*ipver) > data_end)
> 4: (bf) r3 = r8
> 
> In the above r1 is packet pointer and after the assignment, it becomes a 
> scalar and will lead later verification failure.
> 
> Without the patch, we generates:
> 1: R1=ctx(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0) R10=fp0
> ; data_end = (void *)(long)skb->data_end;
> 1: (61) r1 = *(u32 *)(r6 +80)
> 2: R1_w=pkt_end(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0) R10=fp0
> ; cursor = (void *)(long)skb->data;
> 2: (61) r8 = *(u32 *)(r6 +76)
> 3: R1_w=pkt_end(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0) 
> R8_w=pkt(id=0,off=0,r=0,imm=0) R10=fp0
> ; if ((void *)ipver + sizeof(*ipver) > data_end)
> 3: (bf) r2 = r8
> 4: R1_w=pkt_end(id=0,off=0,imm=0) R2_w=pkt(id=0,off=0,r=0,imm=0) 
> R6_w=ctx(id=0,off=0,imm=0) R8_w=pkt(id=0,off=0,r=0,imm=0) R10=fp0
> 4: (07) r2 += 1
> 5: R1_w=pkt_end(id=0,off=0,imm=0) R2_w=pkt(id=0,off=1,r=0,imm=0) 
> R6_w=ctx(id=0,off=0,imm=0) R8_w=pkt(id=0,off=0,r=0,imm=0) R10=fp0
> 
> r2 keeps as a packet pointer, so we don't have issues later.
> 
> Not sure how we could fix this in llvm as llvm does not really have idea
> the above w1 in w8 = w1 is a packet pointer.
> 

OK thanks for analysis. I have this on my stack as well but need to
check its correct still,

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 320e2df..3072dba7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2804,8 +2804,11 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
                reg->umax_value = mask;
        }
        reg->smin_value = reg->umin_value;
-       if (reg->smax_value < 0 || reg->smax_value > reg->umax_value)
+       if (reg->smax_value < 0 || reg->smax_value > reg->umax_value) {
                reg->smax_value = reg->umax_value;
+       } else {
+               reg->umax_value = reg->smax_value;
+       }
 }

this helps but still hitting above issue with the packet pointer as
you pointed out. I'll sort out how we can fix this. Somewhat related
we have a similar issue we hit fairly consistently I've been meaning
to sort out where the cmp happens on a different register then is
used in the call, for example something like this pseudocode

   r8 = r2
   if r8 > blah goto +label
   r1 = dest_ptr
   r1 += r2
   r2 = size
   r3 = ptr
   call #some_call

and the verifier aborts because r8 was verified instead of r2. The
working plan was to walk back in the def-use chain and sort it out
but tbd.

.John
   
