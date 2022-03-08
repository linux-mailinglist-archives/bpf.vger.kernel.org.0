Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DB24D1C60
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 16:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348023AbiCHPzw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 10:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348031AbiCHPzv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 10:55:51 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5FC4F9C5
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 07:54:53 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id z26so17440380lji.8
        for <bpf@vger.kernel.org>; Tue, 08 Mar 2022 07:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=3CkbM5IgF+3VsBWsQZ/PnBVfDF9LD+iXdHQtzsNI6d0=;
        b=nTAU2/gVBTx7gXPBshTQ8Ox4mgVuY4OG3VmehMeWAbsJk9PzqF1NJN8CP7LnTCLVDc
         FXXpBZUjV09dLAvskptuZzivucvk+WP4Xo57Ts5vLGD6SZG8de67TFMBqO2gbwCzJkvj
         e1EawDzYw98RjhFW/XkWYsD8NziPKlou6Fr2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=3CkbM5IgF+3VsBWsQZ/PnBVfDF9LD+iXdHQtzsNI6d0=;
        b=04yn+kegrRRf3ieTyswpdsEgvllJl4tjQIU670bjdJTYWNgG/AWA4qU/jMndhA/J2/
         hbzTVcEyZ7lWsmNzlq5zWGVR8DK3UKy+FB85+0QJvX/yr1YE4QLozKxvVE/kREeyAiaP
         wq15zsDj8Yn/u3OhgGrvZAio5Kc9klfBE0FAVF3gVtdlPeFPis5Eak67WqWauz2kJUx3
         +37Hl8Jo6LO8toOxt5AG6FX/SBCimAeilVDbzzXweeZNEXDz5A19sabSrOprV+IVf677
         XmocnPVPqEJH2Qmt/+wAbWE5QrQtS8u0INq4VhV4Bg0cMR7mAyb20npnZsZw5hYOfZJX
         tDew==
X-Gm-Message-State: AOAM532dTHIe+8TzPOfyHJhV8FN8ER2NYcthf9pBA9SNy+2FrHpB6o0O
        5aJKKbuYiksmCSxmI7UreQGv2Q==
X-Google-Smtp-Source: ABdhPJyQPcNlOht5k4KPmYIyKQIWWBrJiPtL2fwrjj2DHGfLJzyXsQtQ03+lqr9+xyoRff5zVKnKDw==
X-Received: by 2002:a2e:a78f:0:b0:246:8848:178 with SMTP id c15-20020a2ea78f000000b0024688480178mr11485699ljf.432.1646754891563;
        Tue, 08 Mar 2022 07:54:51 -0800 (PST)
Received: from cloudflare.com (2a01-110f-4809-d800-0000-0000-0000-0f9c.aa.ipv6.supernova.orange.pl. [2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id c27-20020a2ebf1b000000b00247eba13667sm837856ljr.16.2022.03.08.07.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 07:54:51 -0800 (PST)
References: <20220222182559.2865596-1-iii@linux.ibm.com>
 <20220222182559.2865596-2-iii@linux.ibm.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next 1/3] bpf: Fix certain narrow loads with
 offsets
Date:   Tue, 08 Mar 2022 16:01:05 +0100
In-reply-to: <20220222182559.2865596-2-iii@linux.ibm.com>
Message-ID: <87bkygzbg5.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 22, 2022 at 07:25 PM +01, Ilya Leoshkevich wrote:
> Verifier treats bpf_sk_lookup.remote_port as a 32-bit field for
> backward compatibility, regardless of what the uapi headers say.
> This field is mapped onto the 16-bit bpf_sk_lookup_kern.sport field.
> Therefore, accessing the most significant 16 bits of
> bpf_sk_lookup.remote_port must produce 0, which is currently not
> the case.
>
> The problem is that narrow loads with offset - commit 46f53a65d2de
> ("bpf: Allow narrow loads with offset > 0"), don't play nicely with
> the masking optimization - commit 239946314e57 ("bpf: possibly avoid
> extra masking for narrower load in verifier"). In particular, when we
> suppress extra masking, we suppress shifting as well, which is not
> correct.
>
> Fix by moving the masking suppression check to BPF_AND generation.
>
> Fixes: 46f53a65d2de ("bpf: Allow narrow loads with offset > 0")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  kernel/bpf/verifier.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d7473fee247c..195f2e9b5a47 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12848,7 +12848,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>  			return -EINVAL;
>  		}
>  
> -		if (is_narrower_load && size < target_size) {
> +		if (is_narrower_load) {
>  			u8 shift = bpf_ctx_narrow_access_offset(
>  				off, size, size_default) * 8;
>  			if (shift && cnt + 1 >= ARRAY_SIZE(insn_buf)) {
> @@ -12860,15 +12860,19 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>  					insn_buf[cnt++] = BPF_ALU32_IMM(BPF_RSH,
>  									insn->dst_reg,
>  									shift);
> -				insn_buf[cnt++] = BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
> -								(1 << size * 8) - 1);
> +				if (size < target_size)
> +					insn_buf[cnt++] = BPF_ALU32_IMM(
> +						BPF_AND, insn->dst_reg,
> +						(1 << size * 8) - 1);
>  			} else {
>  				if (shift)
>  					insn_buf[cnt++] = BPF_ALU64_IMM(BPF_RSH,
>  									insn->dst_reg,
>  									shift);
> -				insn_buf[cnt++] = BPF_ALU64_IMM(BPF_AND, insn->dst_reg,
> -								(1ULL << size * 8) - 1);
> +				if (size < target_size)
> +					insn_buf[cnt++] = BPF_ALU64_IMM(
> +						BPF_AND, insn->dst_reg,
> +						(1ULL << size * 8) - 1);
>  			}
>  		}

Thanks for patience. I'm coming back to this.

This fix affects the 2-byte load from bpf_sk_lookup.remote_port.
Dumping the xlated BPF code confirms it.

On LE (x86-64) things look well.

Before this patch:

* size=2, offset=0, 0: (69) r2 = *(u16 *)(r1 +36)
   0: (69) r2 = *(u16 *)(r1 +4)
   1: (b7) r0 = 0
   2: (95) exit

* size=2, offset=2, 0: (69) r2 = *(u16 *)(r1 +38)
   0: (69) r2 = *(u16 *)(r1 +4)
   1: (b7) r0 = 0
   2: (95) exit

After this patch:

* size=2, offset=0, 0: (69) r2 = *(u16 *)(r1 +36)
   0: (69) r2 = *(u16 *)(r1 +4)
   1: (b7) r0 = 0
   2: (95) exit

* size=2, offset=2, 0: (69) r2 = *(u16 *)(r1 +38)
   0: (69) r2 = *(u16 *)(r1 +4)
   1: (74) w2 >>= 16
   2: (b7) r0 = 0
   3: (95) exit

Which works great because the JIT generates a zero-extended load movzwq:

* size=2, offset=0, 0: (69) r2 = *(u16 *)(r1 +36)
bpf_prog_5e4fe3dbdcb18fd3:
   0:   nopl   0x0(%rax,%rax,1)
   5:   xchg   %ax,%ax
   7:   push   %rbp
   8:   mov    %rsp,%rbp
   b:   movzwq 0x4(%rdi),%rsi
  10:   xor    %eax,%eax
  12:   leave
  13:   ret


* size=2, offset=2, 0: (69) r2 = *(u16 *)(r1 +38)
bpf_prog_4a6336c64a340b96:
   0:   nopl   0x0(%rax,%rax,1)
   5:   xchg   %ax,%ax
   7:   push   %rbp
   8:   mov    %rsp,%rbp
   b:   movzwq 0x4(%rdi),%rsi
  10:   shr    $0x10,%esi
  13:   xor    %eax,%eax
  15:   leave
  16:   ret

Runtime checks for bpf_sk_lookup.remote_port load and the 2-bytes of
zero padding following it, like below, pass with flying colors:

	ok = ctx->remote_port == bpf_htons(8008);
	if (!ok)
		return SK_DROP;
	ok = *((__u16 *)&ctx->remote_port + 1) == 0;
	if (!ok)
		return SK_DROP;

(The above checks compile to half-word (2-byte) loads.)


On BE (s390x) things look different:

Before the patch:

* size=2, offset=0, 0: (69) r2 = *(u16 *)(r1 +36)
   0: (69) r2 = *(u16 *)(r1 +4)
   1: (bc) w2 = w2
   2: (b7) r0 = 0
   3: (95) exit

* size=2, offset=2, 0: (69) r2 = *(u16 *)(r1 +38)
   0: (69) r2 = *(u16 *)(r1 +4)
   1: (bc) w2 = w2
   2: (b7) r0 = 0
   3: (95) exit

After the patch:

* size=2, offset=0, 0: (69) r2 = *(u16 *)(r1 +36)
   0: (69) r2 = *(u16 *)(r1 +4)
   1: (bc) w2 = w2
   2: (74) w2 >>= 16
   3: (bc) w2 = w2
   4: (b7) r0 = 0
   5: (95) exit

* size=2, offset=2, 0: (69) r2 = *(u16 *)(r1 +38)
   0: (69) r2 = *(u16 *)(r1 +4)
   1: (bc) w2 = w2
   2: (b7) r0 = 0
   3: (95) exit

These compile to:

* size=2, offset=0, 0: (69) r2 = *(u16 *)(r1 +36)
bpf_prog_fdd58b8caca29f00:
   0:   j       0x0000000000000006
   4:   nopr
   6:   stmg    %r11,%r15,112(%r15)
   c:   la      %r13,64(%r15)
  10:   aghi    %r15,-96
  14:   llgh    %r3,4(%r2,%r0)
  1a:   srl     %r3,16
  1e:   llgfr   %r3,%r3
  22:   lgfi    %r14,0
  28:   lgr     %r2,%r14
  2c:   lmg     %r11,%r15,208(%r15)
  32:   br      %r14


* size=2, offset=2, 0: (69) r2 = *(u16 *)(r1 +38)
bpf_prog_5e3d8e92223c6841:
   0:   j       0x0000000000000006
   4:   nopr
   6:   stmg    %r11,%r15,112(%r15)
   c:   la      %r13,64(%r15)
  10:   aghi    %r15,-96
  14:   llgh    %r3,4(%r2,%r0)
  1a:   lgfi    %r14,0
  20:   lgr     %r2,%r14
  24:   lmg     %r11,%r15,208(%r15)
  2a:   br      %r14

Now, we right shift the value when loading

  *(u16 *)(r1 +36)

which in C BPF is equivalent to

  *((__u16 *)&ctx->remote_port + 0)

due to how the shift is calculated by bpf_ctx_narrow_access_offset().

This makes the expected typical use-case

  ctx->remote_port == bpf_htons(8008)

fail on s390x because llgh (Load Logical Halfword (64<-16)) seems to lay
out the data in the destination register so that it holds
0x0000_0000_0000_1f48.

I don't know that was the intention here, as it makes the BPF C code
non-portable.

WDYT?


BTW. Out of curiosity, how does a Logical Load Halfword (llgh) differ
differ from a non-logical Load Halfword (lgh) on s390x? Compiler
Explorer generates a non-logical load for similar C code.
