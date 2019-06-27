Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B898458858
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2019 19:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfF0R3g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jun 2019 13:29:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34851 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfF0R3f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jun 2019 13:29:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id d126so1575926pfd.2
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2019 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pZclZUlp3DbNohQiiDxHEf4kCXR/EK6gn1QBjN9QMZ8=;
        b=JwRibGPz7O+pDjNXa7BMcxx/Kr3ql+eqlkOSJJ9yN+JVVlfslMKjj0GYt5lq582STA
         iLFJrjAddbG5LshT4mn96A6Y+vCDBT/ytAGNr62UMl9/TWuuA/FJgYN+Tf4F9OPhzPMA
         nvDlc4HP1R+toWqyvewnLi+XjmKgjHThWJ6W+vn/AmAJrGPgE1GKnblS6hC5JGCqavmB
         EUNh+UZfAYdWrnQARTwJbSuZ2RRCAuHc8nTmeEwz2Q2QUcnUzLzSYuaesicDvOpqOo+k
         OpXGVZEvDu4WFvjsFIVQrZ55e8NGL+McdlFlDDX3qHUnnmD8yCyFWTIzjYGpGSlpkSJQ
         YILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pZclZUlp3DbNohQiiDxHEf4kCXR/EK6gn1QBjN9QMZ8=;
        b=Msne19zOjuFowBonII/t3r2n2Y99tn8zM2Y1s73bWq9hm/bYUYgzMbodFcxHyfV1sa
         kjrJNL9VYbBwNzStII6QSOEzwVjKYRANOwmWFQxNYIiF8ENjyB/nBAl9AVgv+oyKVIyd
         iwOovnfEdYUqNta6WE0wJz1rswz0aZIXSgjhkJESSP6svSLDmUma54IQPQuwhGLt/Lt/
         KrrOyLfeHZoVluLXfLnM4dVTA7Rqu2yZ6CKHLQItjawTYH36+J0REzcfU8VVQBczZxf3
         6rVlAXFpZgdhVYWKicbKn35QqL1WTNyH68dJ0xxzdvKu627CGH9Leurd22dyi/DoNaQe
         UfTw==
X-Gm-Message-State: APjAAAUGP7HF8zAhIdPqXJ5aCTt22GAN/I0adhO3swun1HjnP/BvTGbI
        j6C+g1w+IyPcozf6dxOf4KLPbw==
X-Google-Smtp-Source: APXvYqzlpYP5i2Nvb1QlbzWVeaa+gtB7Nl2q80f71Sk95FrZNAXdWSoIvp/fjmApAOJy39OA+xFApA==
X-Received: by 2002:a63:b1d:: with SMTP id 29mr4815693pgl.103.1561656573821;
        Thu, 27 Jun 2019 10:29:33 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id m13sm2562762pgv.89.2019.06.27.10.29.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 10:29:33 -0700 (PDT)
Date:   Thu, 27 Jun 2019 10:29:32 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, bpf@vger.kernel.org,
        lkp@01.org
Subject: Re: [bpf/tools] cd17d77705:
 kernel_selftests.bpf.test_sock_addr.sh.fail
Message-ID: <20190627172932.GD4866@mini-arch>
References: <20190627090446.GG7221@shao2-debian>
 <20190627155029.GC4866@mini-arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627155029.GC4866@mini-arch>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/27, Stanislav Fomichev wrote:
> On 06/27, kernel test robot wrote:
> > FYI, we noticed the following commit (built with gcc-7):
> > 
> > commit: cd17d77705780e2270937fb3cbd2b985adab3edc ("bpf/tools: sync bpf.h")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > in testcase: kernel_selftests
> > with following parameters:
> > 
> > 	group: kselftests-00
> > 
> > test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> > test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> > 
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > # ; int connect_v6_prog(struct bpf_sock_addr *ctx)
> > # 0: (bf) r6 = r1
> > # 1: (18) r1 = 0x100000000000000
> > # ; tuple.ipv6.daddr[0] = bpf_htonl(DST_REWRITE_IP6_0);
> > # 3: (7b) *(u64 *)(r10 -16) = r1
> > # 4: (b7) r1 = 169476096
> > # ; memset(&tuple.ipv6.sport, 0, sizeof(tuple.ipv6.sport));
> > # 5: (63) *(u32 *)(r10 -8) = r1
> > # 6: (b7) r7 = 0
> > # ; tuple.ipv6.daddr[0] = bpf_htonl(DST_REWRITE_IP6_0);
> > # 7: (7b) *(u64 *)(r10 -24) = r7
> > # 8: (7b) *(u64 *)(r10 -32) = r7
> > # 9: (7b) *(u64 *)(r10 -40) = r7
> > # ; if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
> > # 10: (61) r1 = *(u32 *)(r6 +32)
> > # ; if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
> > # 11: (bf) r2 = r1
> > # 12: (07) r2 += -1
> > # 13: (67) r2 <<= 32
> > # 14: (77) r2 >>= 32
> > # 15: (25) if r2 > 0x1 goto pc+33
> > #  R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=1,var_off=(0x0; 0x1)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=00000000 fp-32=00000000 fp-40=00000000
> > # ; else if (ctx->type == SOCK_STREAM)
> > # 16: (55) if r1 != 0x1 goto pc+8
> > #  R1=inv1 R2=inv(id=0,umax_value=1,var_off=(0x0; 0x1)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=00000000 fp-32=00000000 fp-40=00000000
> > # 17: (bf) r2 = r10
> > # ; sk = bpf_sk_lookup_tcp(ctx, &tuple, sizeof(tuple.ipv6),
> > # 18: (07) r2 += -40
> > # 19: (bf) r1 = r6
> > # 20: (b7) r3 = 36
> > # 21: (b7) r4 = -1
> > # 22: (b7) r5 = 0
> > # 23: (85) call bpf_sk_lookup_tcp#84
> > # 24: (05) goto pc+7
> > # ; if (!sk)
> > # 32: (15) if r0 == 0x0 goto pc+16
> > #  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
> > # ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
> > # 33: (61) r1 = *(u32 *)(r0 +28)
> > # ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
> > # 34: (61) r2 = *(u32 *)(r10 -24)
> > # ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
> > # 35: (5d) if r1 != r2 goto pc+11
> > #  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
> > # ; sk->src_ip6[1] != tuple.ipv6.daddr[1] ||
> > # 36: (61) r1 = *(u32 *)(r0 +32)
> > # ; sk->src_ip6[1] != tuple.ipv6.daddr[1] ||
> > # 37: (61) r2 = *(u32 *)(r10 -20)
> > # ; sk->src_ip6[1] != tuple.ipv6.daddr[1] ||
> > # 38: (5d) if r1 != r2 goto pc+8
> > #  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
> > # ; sk->src_ip6[2] != tuple.ipv6.daddr[2] ||
> > # 39: (61) r1 = *(u32 *)(r0 +36)
> > # ; sk->src_ip6[2] != tuple.ipv6.daddr[2] ||
> > # 40: (61) r2 = *(u32 *)(r10 -16)
> > # ; sk->src_ip6[2] != tuple.ipv6.daddr[2] ||
> > # 41: (5d) if r1 != r2 goto pc+5
> > #  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
> > # ; sk->src_ip6[3] != tuple.ipv6.daddr[3] ||
> > # 42: (61) r1 = *(u32 *)(r0 +40)
> > # ; sk->src_ip6[3] != tuple.ipv6.daddr[3] ||
> > # 43: (61) r2 = *(u32 *)(r10 -12)
> > # ; sk->src_ip6[3] != tuple.ipv6.daddr[3] ||
> > # 44: (5d) if r1 != r2 goto pc+2
> > #  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
> > # ; sk->src_port != DST_REWRITE_PORT6) {
> > # 45: (61) r1 = *(u32 *)(r0 +44)
> > # ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
> > # 46: (15) if r1 == 0x1a0a goto pc+4
> > #  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
> > # ; bpf_sk_release(sk);
> > # 47: (bf) r1 = r0
> > # 48: (85) call bpf_sk_release#86
> > # ; }
> > # 49: (bf) r0 = r7
> > # 50: (95) exit
> > # 
> > # from 46 to 51: R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv6666 R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
> > # ; bpf_sk_release(sk);
> > # 51: (bf) r1 = r0
> > # 52: (85) call bpf_sk_release#86
> > # 53: (b7) r1 = 2586
> > # ; ctx->user_port = bpf_htons(DST_REWRITE_PORT6);
> > # 54: (63) *(u32 *)(r6 +24) = r1
> > # 55: (18) r1 = 0x100000000000000
> > # ; ctx->user_ip6[2] = bpf_htonl(DST_REWRITE_IP6_2);
> > # 57: (7b) *(u64 *)(r6 +16) = r1
> > # invalid bpf_context access off=16 size=8
> This looks like clang doing single u64 write for user_ip6[2] and
> user_ip6[3] instead of two u32. I don't think we allow that.
> 
> I've seen this a couple of times myself while playing with some
> progs, but not sure what's the right way to 'fix' it.
> 
Any thoughts about the patch below? Another way to "fix" it
would be to mark context accesses 'volatile' in bpf progs, but that sounds
a bit gross.

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 43b45d6db36d..34a14c950e60 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -746,6 +746,20 @@ bpf_ctx_narrow_access_ok(u32 off, u32 size, u32 size_default)
 	return size <= size_default && (size & (size - 1)) == 0;
 }
 
+static inline bool __bpf_ctx_wide_store_ok(u32 off, u32 size)
+{
+	/* u64 access is aligned and fits into the field size */
+	return off % sizeof(__u64) == 0 && off + sizeof(__u64) <= size;
+}
+
+#define bpf_ctx_wide_store_ok(off, size, type, field) \
+	(size == sizeof(__u64) && \
+	 off >= offsetof(type, field) && \
+	 off < offsetofend(type, field) ? \
+	__bpf_ctx_wide_store_ok(off - offsetof(type, field), \
+				 FIELD_SIZEOF(type, field)) : 0)
+
+
 #define bpf_classic_proglen(fprog) (fprog->len * sizeof(fprog->filter[0]))
 
 static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
diff --git a/net/core/filter.c b/net/core/filter.c
index 2014d76e0d2a..2d3787a439ae 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6849,6 +6849,16 @@ static bool sock_addr_is_valid_access(int off, int size,
 			if (!bpf_ctx_narrow_access_ok(off, size, size_default))
 				return false;
 		} else {
+			if (bpf_ctx_wide_store_ok(off, size,
+						  struct bpf_sock_addr,
+						  user_ip6))
+				return true;
+
+			if (bpf_ctx_wide_store_ok(off, size,
+						  struct bpf_sock_addr,
+						  msg_src_ip6))
+				return true;
+
 			if (size != size_default)
 				return false;
 		}
@@ -7689,9 +7699,6 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
 /* SOCK_ADDR_STORE_NESTED_FIELD_OFF() has semantic similar to
  * SOCK_ADDR_LOAD_NESTED_FIELD_SIZE_OFF() but for store operation.
  *
- * It doesn't support SIZE argument though since narrow stores are not
- * supported for now.
- *
  * In addition it uses Temporary Field TF (member of struct S) as the 3rd
  * "register" since two registers available in convert_ctx_access are not
  * enough: we can't override neither SRC, since it contains value to store, nor
@@ -7699,7 +7706,7 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
  * instructions. But we need a temporary place to save pointer to nested
  * structure whose field we want to store to.
  */
-#define SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, OFF, TF)		       \
+#define SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, SIZE, OFF, TF)	       \
 	do {								       \
 		int tmp_reg = BPF_REG_9;				       \
 		if (si->src_reg == tmp_reg || si->dst_reg == tmp_reg)	       \
@@ -7710,8 +7717,7 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
 				      offsetof(S, TF));			       \
 		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(S, F), tmp_reg,	       \
 				      si->dst_reg, offsetof(S, F));	       \
-		*insn++ = BPF_STX_MEM(					       \
-			BPF_FIELD_SIZEOF(NS, NF), tmp_reg, si->src_reg,	       \
+		*insn++ = BPF_STX_MEM(SIZE, tmp_reg, si->src_reg,	       \
 			bpf_target_off(NS, NF, FIELD_SIZEOF(NS, NF),	       \
 				       target_size)			       \
 				+ OFF);					       \
@@ -7723,8 +7729,8 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
 						      TF)		       \
 	do {								       \
 		if (type == BPF_WRITE) {				       \
-			SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, OFF,    \
-							 TF);		       \
+			SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, SIZE,   \
+							 OFF, TF);	       \
 		} else {						       \
 			SOCK_ADDR_LOAD_NESTED_FIELD_SIZE_OFF(		       \
 				S, NS, F, NF, SIZE, OFF);  \
