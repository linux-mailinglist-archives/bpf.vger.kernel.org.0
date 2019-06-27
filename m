Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8734558649
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2019 17:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfF0Puc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jun 2019 11:50:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32870 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfF0Puc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jun 2019 11:50:32 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so1536463plo.0
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2019 08:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tMDVUbLTOCls0VIHnjsoh7DWeqSSrubUVJ0usmY9Ymg=;
        b=WMEfiSZ3TlXa+mXfYTEgWVlwNbrgesrqc3XR79vxkvHrCzhuWJgIuAIempAYwIwEza
         +JbFajU0wgwOxn61DReXpfWvf/9nm8EdoB+v2KwaYdQBWCk5VZCJGSRPJX3qYpVlXp+Y
         Mp8e7iPlgGpVEzsvWFScb8jg5Trk/+H7sHpMVd1zbEjPTWn4wEYuK6bV3J6PW5W392o2
         WDqBlav0fct1ZocreCrRkhtbWnjmt1uXYnO30s0S7bKhPoxoKJ7PgDElmIwb9xxMMow9
         vU8GdgiwMsawoOHQ1SBCVFiiNQNfc/1bqnNY5UkQ62MSgdwVLVS5jDzkzC3AfUkCZBom
         lanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tMDVUbLTOCls0VIHnjsoh7DWeqSSrubUVJ0usmY9Ymg=;
        b=URomBvNkQ5+OXNrtwo79n6YKn0Mlt8BsMEGMJVro+bvCc7uGAY4Pcr904jbp7adBbo
         TVh4xkS4meynwFktTG4Gcxp9NPNYVWgNHGQg0jH8nEbN+SmMaeQuH782apaVgOGgp7bR
         CuIkqLBOaIafSjCvHFirP0vwm60tpnbbe5++GQXUZ2bopohK3pAezo14R45cTgGi8dou
         0WulDOnYMV+mj8lbk9tNtT2sMPJcT2u5SuK1HaEkboz4iFIIN3RRFXxNRi/jXCparHeS
         W3hsEQ53YFJhfadVPAZxPxYXZf25CjGAQNnymcm54sDlZCsf1ZHlFE3ubwNgU5ragBk5
         syLQ==
X-Gm-Message-State: APjAAAWxFiVCSsP743BALChN/Oh3WN6ozsNMEYVRk7o9ZsLKCKJDie8b
        noWTNSsdT04OO96f9pYI9WtHRg==
X-Google-Smtp-Source: APXvYqw3r0cYpfY5r6R1izaOj1roYmsKppsSAS7/NBo2PdrS4F8EMasOOzJOZ1QVfuDiJDKOcGoLIQ==
X-Received: by 2002:a17:902:848c:: with SMTP id c12mr5348356plo.17.1561650631033;
        Thu, 27 Jun 2019 08:50:31 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id p6sm2693091pgs.77.2019.06.27.08.50.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 08:50:30 -0700 (PDT)
Date:   Thu, 27 Jun 2019 08:50:29 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, bpf@vger.kernel.org,
        lkp@01.org
Subject: Re: [bpf/tools] cd17d77705:
 kernel_selftests.bpf.test_sock_addr.sh.fail
Message-ID: <20190627155029.GC4866@mini-arch>
References: <20190627090446.GG7221@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627090446.GG7221@shao2-debian>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/27, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: cd17d77705780e2270937fb3cbd2b985adab3edc ("bpf/tools: sync bpf.h")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: kernel_selftests
> with following parameters:
> 
> 	group: kselftests-00
> 
> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> # ; int connect_v6_prog(struct bpf_sock_addr *ctx)
> # 0: (bf) r6 = r1
> # 1: (18) r1 = 0x100000000000000
> # ; tuple.ipv6.daddr[0] = bpf_htonl(DST_REWRITE_IP6_0);
> # 3: (7b) *(u64 *)(r10 -16) = r1
> # 4: (b7) r1 = 169476096
> # ; memset(&tuple.ipv6.sport, 0, sizeof(tuple.ipv6.sport));
> # 5: (63) *(u32 *)(r10 -8) = r1
> # 6: (b7) r7 = 0
> # ; tuple.ipv6.daddr[0] = bpf_htonl(DST_REWRITE_IP6_0);
> # 7: (7b) *(u64 *)(r10 -24) = r7
> # 8: (7b) *(u64 *)(r10 -32) = r7
> # 9: (7b) *(u64 *)(r10 -40) = r7
> # ; if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
> # 10: (61) r1 = *(u32 *)(r6 +32)
> # ; if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
> # 11: (bf) r2 = r1
> # 12: (07) r2 += -1
> # 13: (67) r2 <<= 32
> # 14: (77) r2 >>= 32
> # 15: (25) if r2 > 0x1 goto pc+33
> #  R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=1,var_off=(0x0; 0x1)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=00000000 fp-32=00000000 fp-40=00000000
> # ; else if (ctx->type == SOCK_STREAM)
> # 16: (55) if r1 != 0x1 goto pc+8
> #  R1=inv1 R2=inv(id=0,umax_value=1,var_off=(0x0; 0x1)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=00000000 fp-32=00000000 fp-40=00000000
> # 17: (bf) r2 = r10
> # ; sk = bpf_sk_lookup_tcp(ctx, &tuple, sizeof(tuple.ipv6),
> # 18: (07) r2 += -40
> # 19: (bf) r1 = r6
> # 20: (b7) r3 = 36
> # 21: (b7) r4 = -1
> # 22: (b7) r5 = 0
> # 23: (85) call bpf_sk_lookup_tcp#84
> # 24: (05) goto pc+7
> # ; if (!sk)
> # 32: (15) if r0 == 0x0 goto pc+16
> #  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
> # ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
> # 33: (61) r1 = *(u32 *)(r0 +28)
> # ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
> # 34: (61) r2 = *(u32 *)(r10 -24)
> # ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
> # 35: (5d) if r1 != r2 goto pc+11
> #  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
> # ; sk->src_ip6[1] != tuple.ipv6.daddr[1] ||
> # 36: (61) r1 = *(u32 *)(r0 +32)
> # ; sk->src_ip6[1] != tuple.ipv6.daddr[1] ||
> # 37: (61) r2 = *(u32 *)(r10 -20)
> # ; sk->src_ip6[1] != tuple.ipv6.daddr[1] ||
> # 38: (5d) if r1 != r2 goto pc+8
> #  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
> # ; sk->src_ip6[2] != tuple.ipv6.daddr[2] ||
> # 39: (61) r1 = *(u32 *)(r0 +36)
> # ; sk->src_ip6[2] != tuple.ipv6.daddr[2] ||
> # 40: (61) r2 = *(u32 *)(r10 -16)
> # ; sk->src_ip6[2] != tuple.ipv6.daddr[2] ||
> # 41: (5d) if r1 != r2 goto pc+5
> #  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
> # ; sk->src_ip6[3] != tuple.ipv6.daddr[3] ||
> # 42: (61) r1 = *(u32 *)(r0 +40)
> # ; sk->src_ip6[3] != tuple.ipv6.daddr[3] ||
> # 43: (61) r2 = *(u32 *)(r10 -12)
> # ; sk->src_ip6[3] != tuple.ipv6.daddr[3] ||
> # 44: (5d) if r1 != r2 goto pc+2
> #  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
> # ; sk->src_port != DST_REWRITE_PORT6) {
> # 45: (61) r1 = *(u32 *)(r0 +44)
> # ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
> # 46: (15) if r1 == 0x1a0a goto pc+4
> #  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
> # ; bpf_sk_release(sk);
> # 47: (bf) r1 = r0
> # 48: (85) call bpf_sk_release#86
> # ; }
> # 49: (bf) r0 = r7
> # 50: (95) exit
> # 
> # from 46 to 51: R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv6666 R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
> # ; bpf_sk_release(sk);
> # 51: (bf) r1 = r0
> # 52: (85) call bpf_sk_release#86
> # 53: (b7) r1 = 2586
> # ; ctx->user_port = bpf_htons(DST_REWRITE_PORT6);
> # 54: (63) *(u32 *)(r6 +24) = r1
> # 55: (18) r1 = 0x100000000000000
> # ; ctx->user_ip6[2] = bpf_htonl(DST_REWRITE_IP6_2);
> # 57: (7b) *(u64 *)(r6 +16) = r1
> # invalid bpf_context access off=16 size=8
This looks like clang doing single u64 write for user_ip6[2] and
user_ip6[3] instead of two u32. I don't think we allow that.

I've seen this a couple of times myself while playing with some
progs, but not sure what's the right way to 'fix' it.

> # processed 49 insns (limit 1000000) max_states_per_insn 0 total_states 13 peak_states 13 mark_read 11
> # 
> # libbpf: -- END LOG --
> # libbpf: failed to load program 'cgroup/connect6'
> # libbpf: failed to load object './connect6_prog.o'
> # (test_sock_addr.c:752: errno: Bad file descriptor) >>> Loading program (./connect6_prog.o) error.
