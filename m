Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD851C9922
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 20:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgEGSTN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 14:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726467AbgEGSTN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 May 2020 14:19:13 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092A4C05BD43
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 11:19:13 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d7so3136751ioq.5
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 11:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=VE8sz15oL8XUBxSyvp392s296iIS/Xfc6ces5gl0IQI=;
        b=YI1adO/Yy7zK4bujSnCVu1BXqD8tFvc/TXxY4aTWej1A8kZ2/6TyuBSBs0zhdWBOWL
         PGWqrJ5xbKBsBDYpAwgLxUlcihU/hbZ3aKTjkLcMyvQLvL17KADGUz7qDaYLSESLSLP/
         bGA6Yd1gJ819Or03rGjq6vsHkLT4u3ap1mnuPrUku5BTZB7/KKhxRo/+JTfmfNagQIcj
         5I/dgf4Q902ScvQ2GWJymmJtu8mpBvdjI+JILW/0X7wuE1XUqPNV23dWxt19Mf4rMSfk
         PVxP0Esbr7AZBu0vwmjO3S5cVyBpaxqWP73z6lcX8AAyKQMS1UpD5/n0rOC6hUXhg+Zu
         wgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=VE8sz15oL8XUBxSyvp392s296iIS/Xfc6ces5gl0IQI=;
        b=qSngRJEo8NC90pN53G6NmoaP+iEGHoXfTqf0Ja9GrZntU/alR71L0SZEohXNqOyV8x
         NO/NWL7PXNiLWVv5Ng2iqd7UKSkOfqODCw2q35QgnMF/gZBX/la4da+y6E82sBmlzmzH
         3TXfKZftfxho/xDc1NBIcdCHm5ZQGlsaOTJSh94DF5j+u2NNzJtbPbhJ4P9waaj79i/u
         s+lVmDQwsnN1x2bRzGm+XQmTOiPYIlXP6pkvh/9mDu+BVoCBKaudtlm56zUOBuyLtWog
         cxjoitrJWGg1Dengnmew2YXcxRRYsTbn2tuI6oWxJyj/UvhU8Nk8qcWoWi0MI0VFX4jy
         GdUA==
X-Gm-Message-State: AGi0PuY/XMlAEOwDwvz9sqlBCTvcrRusk5RmPji5/63AFJz+2l19y/rM
        NFisVzfVFJzVjxjA3gUlEqA=
X-Google-Smtp-Source: APiQypJi6tpqePHeUNgaXgXbKWSM8mm/Ofja9gqxDFSH9ZvjaLHcqHZrRCQDBXFMAEXjZ6fXLs3TQQ==
X-Received: by 2002:a02:a68e:: with SMTP id j14mr15273148jam.86.1588875552117;
        Thu, 07 May 2020 11:19:12 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id w16sm3042971ilc.43.2020.05.07.11.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 11:19:11 -0700 (PDT)
Date:   Thu, 07 May 2020 11:19:03 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrey Ignatov <rdna@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        bpf <bpf@vger.kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Message-ID: <5eb45117eead3_22a22b23544285b892@john-XPS-13-9370.notmuch>
In-Reply-To: <CAADnVQJAaiOFDc8-35Jm_+dA-6=z+GAYv=z30oB+vEG=2UmOCg@mail.gmail.com>
References: <CAADnVQJAaiOFDc8-35Jm_+dA-6=z+GAYv=z30oB+vEG=2UmOCg@mail.gmail.com>
Subject: RE: sk lookup verifier issue
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov wrote:
> Hi All,
> 
> Andrey found that the following diff messes up the verifier logic:
> diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
> b/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
> index d2b38fa6a5b0..e83d0b48d80c 100644
> --- a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
> @@ -73,6 +73,7 @@ int bpf_sk_lookup_test0(struct __sk_buff *skb)
> 
>         tuple_len = ipv4 ? sizeof(tuple->ipv4) : sizeof(tuple->ipv6);
>         sk = bpf_sk_lookup_tcp(skb, tuple, tuple_len, BPF_F_CURRENT_NETNS, 0);
> +       bpf_printk("sk=%d\n", sk ? 1 : 0);
>         if (sk)
>                 bpf_sk_release(sk);
>         return sk ? TC_ACT_OK : TC_ACT_UNSPEC;
> 
> The generated llvm code is correct.
> What is happening is that first "if(sk)" check converts "sock_or_null"
> into "sock"
> and second "if(sk)" no longer doing mark_ptr_or_null_regs() since
> if (!is_jmp32 && BPF_SRC(insn->code) == BPF_K &&
>             insn->imm == 0 && (opcode == BPF_JEQ || opcode == BPF_JNE) &&
>             reg_type_may_be_null(dst_reg->type)) {
> condition is no longer true.
> The verifier has to follow both branches of second "if (sk)"
> because is_branch_taken() doesn't prune paths with one reg being pointer.
> Hence it reaches the end where the verifier thinks that sk wasn't released
> and complains with:
> 43: (85) call bpf_sk_lookup_tcp#84
> 44: (bf) r6 = r0
> 45: (b7) r1 = 2660
> 46: (6b) *(u16 *)(r10 -4) = r1
> 47: (b7) r1 = 624782195
> 48: (63) *(u32 *)(r10 -8) = r1
> 49: (73) *(u8 *)(r10 -2) = r7
> 50: (b7) r3 = 1
> 51: (55) if r6 != 0x0 goto pc+1
> 
> from 51 to 53: R0=sock(id=0,ref_obj_id=3,off=0,imm=0) R1=inv624782195
> R3=inv1 R6=sock(id=0,ref_obj_id=3,off=0,imm=0) R7=invP0 R10=fp0
> fp-8=?0mmmmmm refs=3
> 53: (bf) r1 = r10
> 54: (07) r1 += -8
> 55: (b7) r2 = 7
> 56: (85) call bpf_trace_printk#6
> 57: (15) if r6 == 0x0 goto pc+2
> 
> from 57 to 60: R0_w=inv(id=0) R6=sock(id=0,ref_obj_id=3,off=0,imm=0)
> R7=invP0 R10=fp0 fp-8=?mmmmmmm refs=3
> 60: (b7) r0 = -1
> 61: (15) if r6 == 0x0 goto pc+1
>  R0_w=inv-1 R6=sock(id=0,ref_obj_id=3,off=0,imm=0) R7=invP0 R10=fp0
> fp-8=?mmmmmmm refs=3
> 62: (b7) r0 = 0
> 63: (95) exit
> Unreleased reference id=3 alloc_insn=43
> 
> Insn 57 is where the bug is.
> The verifier needs to see that this is impossible path.
> "from 57 to 60:" with R6=sock should have never happened.
> 
> I think the best way to fix this is to teach is_branch_taken() to recognize
> == and != comparison of pointer with zero.
> wdyt?

Seems reasonable to me. I've also hit this recently fwiw.

> Anyone can craft a fix?

If no one beats me to it I can probably craft something tomorrow.
