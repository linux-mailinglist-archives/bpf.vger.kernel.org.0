Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F30A259FA0
	for <lists+bpf@lfdr.de>; Tue,  1 Sep 2020 22:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgIAUHY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Sep 2020 16:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgIAUHV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Sep 2020 16:07:21 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EE5C061244
        for <bpf@vger.kernel.org>; Tue,  1 Sep 2020 13:07:20 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id u6so1539562ybf.1
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2020 13:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2u1Msmtiy/jDPbskDHF0qYbHEhM/I+Vt/WeJc5V0FTk=;
        b=vMLkSAgF9twXucbaTj80gp9n4NTZpTYXqqhaTkQirAoOAUDUNZeLGI5GKehmxSeViM
         P1g4C3p57TrH/7OyEcmfSjP0zEl+b2dFT7WZEdLiIgNnrhUuz0d8ybICxAueN7gBcvJH
         UC77UnWiTZHtKAsf7q5TXCtAWg+MXLfF0YsbEPTr0TbHoNPliwQCy6Pk9FzRxhVNiWNp
         TLzp2zdaBNADjtG608L8SMastXxnoHMOp6nR+fdFLwwbv8MJy1FxxMzNhmjka4Q+c76o
         ySR1pQMqoUdD2RVsjozISNEvKz4VJ3o2TxHm/iwkdbrSdUJNxUBbN9+8xzDMlAM0UBSa
         pxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2u1Msmtiy/jDPbskDHF0qYbHEhM/I+Vt/WeJc5V0FTk=;
        b=rF2khx3BRYPgd4Y7dUTpbphnH1FtNkMPHYP4acDYzyC+k7fwpvaRb1J0DPIuFHNDOL
         gZ6T31wp8Bkx+VnDofKjUZdqwbt8PYPuAPceDjZA9dF38twR657H43i/h9FesIkhSUts
         Sv7QStaLo8CPm6fLeVjQb1tEC5VFymNqUZvJ5MeUxnatBM1AxrRAWW4JhqghVBH2pqhX
         IFR58jUVOLJAGnye25Yla+T5GCgv2Cze+iSA3zSPLYH9vBK+hRwG8RwUyZ7m+ZDX9X5P
         ACzsNfBXPSn6TixELV5KS/r6vpS+b9rTWnE2CRxNiH6d/wJJvxZZy/9QWb/lLWq6id5N
         CPxg==
X-Gm-Message-State: AOAM533gIY9stmVz6V+BMVCOKueyUqGWArEnFrqaBSId0JZn3OkiNX/G
        gwMgERIptki7XJw8hzewN3aSgPP39t9+7QqTF9Q=
X-Google-Smtp-Source: ABdhPJw/jUs2Xyl4/aSTqWXEVkomcNvjvq1tR9jzQ2kNKevu60FXFRoAcmZmydWwL3TbNJNTXtoGOv34lvjJOREFGxU=
X-Received: by 2002:a25:c4c2:: with SMTP id u185mr5476357ybf.347.1598990840059;
 Tue, 01 Sep 2020 13:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200825064608.2017878-1-yhs@fb.com> <20200825064608.2017937-1-yhs@fb.com>
In-Reply-To: <20200825064608.2017937-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Sep 2020 13:07:09 -0700
Message-ID: <CAEf4Bzb89dz_Sjy14LjQSDWrQ=TpSHAfgf=_Sa=bWUKGqJHCgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: fix a verifier failure with xor
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 24, 2020 at 11:47 PM Yonghong Song <yhs@fb.com> wrote:
>
> bpf selftest test_progs/test_sk_assign failed with llvm 11 and llvm 12.
> Compared to llvm 10, llvm 11 and 12 generates xor instruction which

Does this mean that some perfectly working BPF programs will now fail
to verify on older kernels, if compiled with llvm 11 or llvm 12? If
yes, is there something that one can do to prevent Clang from using
xor in such situations?

> is not handled properly in verifier. The following illustrates the
> problem:
>
>   16: (b4) w5 = 0
>   17: ... R5_w=inv0 ...
>   ...
>   132: (a4) w5 ^= 1
>   133: ... R5_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) ...
>   ...
>   37: (bc) w8 = w5
>   38: ... R5=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
>           R8_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) ...
>   ...
>   41: (bc) w3 = w8
>   42: ... R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) ...
>   45: (56) if w3 != 0x0 goto pc+1
>    ... R3_w=inv0 ...
>   46: (b7) r1 = 34
>   47: R1_w=inv34 R7=pkt(id=0,off=26,r=38,imm=0)
>   47: (0f) r7 += r1
>   48: R1_w=invP34 R3_w=inv0 R7_w=pkt(id=0,off=60,r=38,imm=0)
>   48: (b4) w9 = 0
>   49: R1_w=invP34 R3_w=inv0 R7_w=pkt(id=0,off=60,r=38,imm=0)
>   49: (69) r1 = *(u16 *)(r7 +0)
>   invalid access to packet, off=60 size=2, R7(id=0,off=60,r=38)
>   R7 offset is outside of the packet
>
> At above insn 132, w5 = 0, but after w5 ^= 1, we give a really conservative
> value of w5. At insn 45, in reality the condition should be always false.
> But due to conservative value for w3, the verifier evaluates it could be
> true and this later leads to verifier failure complaining potential
> packet out-of-bound access.
>
> This patch implemented proper XOR support in verifier.
> In the above example, we have:
>   132: R5=invP0
>   132: (a4) w5 ^= 1
>   133: R5_w=invP1
>   ...
>   37: (bc) w8 = w5
>   ...
>   41: (bc) w3 = w8
>   42: R3_w=invP1
>   ...
>   45: (56) if w3 != 0x0 goto pc+1
>   47: R3_w=invP1
>   ...
>   processed 353 insns ...
> and the verifier can verify the program successfully.
>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/verifier.c | 66 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>

[...]
