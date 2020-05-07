Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16D81C9751
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 19:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgEGRWH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 13:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726222AbgEGRWH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 May 2020 13:22:07 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8A5C05BD43
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 10:22:07 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h4so7180975ljg.12
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 10:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ddITQk95dka69m0nR8QKY8I+EYviX/+/79zVkW+P/H4=;
        b=eEkvuBXTAUpoCIhApMwnWwZcM20gSqFevYI5JoNN51A3tMrYmDTJdADmLL+zxJzlNJ
         IXj/eXmNUDuInnlz7AUjmv7fcax4Tfhd+7vZLABjLdaiQXdWi3/TGiXjQHCKjgOznH23
         5v9ZE6mpTPK2S+90W0NFG3eFYggWn67xZ7fu/uwytWV0mcCXfHdzRdvsIwf1uz/hpLrL
         PoBi8EzHZZYVrhH4Fgo+Mu70NEdMxejOP9JGifNW0sLzfBVi4Lc6w7V6jLohmg7QnSxw
         eWacc3pb6Ryx/xOIwtqzUI8hoXEPHuYfWkHkXwdzK5+547+NURTL9nkDOvxCBo59Vrho
         Pzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ddITQk95dka69m0nR8QKY8I+EYviX/+/79zVkW+P/H4=;
        b=oggvRQBZ+S3lHDvg+MtWdiJKmtoV1tu6wIdygj+YhTFEE85a0G0so40qFsX5Hf8mu/
         hUc81clNVsSAlSVO+oPC209UhSFDykAzOZy/TNZMgmlXbV3dcn8YbFbNItAGWZqLTfDB
         Dj8g6u1aHvRlhLE7lLOmFS+MU/mMnh6sgwY/06CJMuyOkLsgyeU2g5dp5g5KKoCNE/Xp
         QPAm2Och3QMKJa6oOy1UCqjPzpmJ10ygjxM54TT/6QQEnH2lJa31hE4v1Vp4puAt0Txv
         q52dR8vLy/IAWM4mrtEMZT3Fl6LpWtm96+hJVqivsNpMNpFmlWGrAomM+fVH7JUmDguZ
         oo8A==
X-Gm-Message-State: AGi0PubaTDaG60fXDXkW3y0xYlptRwvPMHjw5aW951PzIqLl2hr9PveA
        /9dutTHZUBziUSmTvGt3I07NcGrVq8fYrqJ4tC4=
X-Google-Smtp-Source: APiQypI9SfO/Gt4L/7sWmS7BtUNsAvcyschfQBuVnbo4D4BXPj8gIrajkrfCBqjz5Ihhh5Tx6sRw6BJH08ifpCCiqoQ=
X-Received: by 2002:a2e:9011:: with SMTP id h17mr9366143ljg.138.1588872125367;
 Thu, 07 May 2020 10:22:05 -0700 (PDT)
MIME-Version: 1.0
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 7 May 2020 10:21:53 -0700
Message-ID: <CAADnVQJAaiOFDc8-35Jm_+dA-6=z+GAYv=z30oB+vEG=2UmOCg@mail.gmail.com>
Subject: sk lookup verifier issue
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrey Ignatov <rdna@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        bpf <bpf@vger.kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi All,

Andrey found that the following diff messes up the verifier logic:
diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
b/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
index d2b38fa6a5b0..e83d0b48d80c 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
@@ -73,6 +73,7 @@ int bpf_sk_lookup_test0(struct __sk_buff *skb)

        tuple_len = ipv4 ? sizeof(tuple->ipv4) : sizeof(tuple->ipv6);
        sk = bpf_sk_lookup_tcp(skb, tuple, tuple_len, BPF_F_CURRENT_NETNS, 0);
+       bpf_printk("sk=%d\n", sk ? 1 : 0);
        if (sk)
                bpf_sk_release(sk);
        return sk ? TC_ACT_OK : TC_ACT_UNSPEC;

The generated llvm code is correct.
What is happening is that first "if(sk)" check converts "sock_or_null"
into "sock"
and second "if(sk)" no longer doing mark_ptr_or_null_regs() since
if (!is_jmp32 && BPF_SRC(insn->code) == BPF_K &&
            insn->imm == 0 && (opcode == BPF_JEQ || opcode == BPF_JNE) &&
            reg_type_may_be_null(dst_reg->type)) {
condition is no longer true.
The verifier has to follow both branches of second "if (sk)"
because is_branch_taken() doesn't prune paths with one reg being pointer.
Hence it reaches the end where the verifier thinks that sk wasn't released
and complains with:
43: (85) call bpf_sk_lookup_tcp#84
44: (bf) r6 = r0
45: (b7) r1 = 2660
46: (6b) *(u16 *)(r10 -4) = r1
47: (b7) r1 = 624782195
48: (63) *(u32 *)(r10 -8) = r1
49: (73) *(u8 *)(r10 -2) = r7
50: (b7) r3 = 1
51: (55) if r6 != 0x0 goto pc+1

from 51 to 53: R0=sock(id=0,ref_obj_id=3,off=0,imm=0) R1=inv624782195
R3=inv1 R6=sock(id=0,ref_obj_id=3,off=0,imm=0) R7=invP0 R10=fp0
fp-8=?0mmmmmm refs=3
53: (bf) r1 = r10
54: (07) r1 += -8
55: (b7) r2 = 7
56: (85) call bpf_trace_printk#6
57: (15) if r6 == 0x0 goto pc+2

from 57 to 60: R0_w=inv(id=0) R6=sock(id=0,ref_obj_id=3,off=0,imm=0)
R7=invP0 R10=fp0 fp-8=?mmmmmmm refs=3
60: (b7) r0 = -1
61: (15) if r6 == 0x0 goto pc+1
 R0_w=inv-1 R6=sock(id=0,ref_obj_id=3,off=0,imm=0) R7=invP0 R10=fp0
fp-8=?mmmmmmm refs=3
62: (b7) r0 = 0
63: (95) exit
Unreleased reference id=3 alloc_insn=43

Insn 57 is where the bug is.
The verifier needs to see that this is impossible path.
"from 57 to 60:" with R6=sock should have never happened.

I think the best way to fix this is to teach is_branch_taken() to recognize
== and != comparison of pointer with zero.
wdyt?
Anyone can craft a fix?
