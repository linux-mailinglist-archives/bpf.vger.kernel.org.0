Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5C4B59008
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2019 03:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfF1B4x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jun 2019 21:56:53 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41769 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF1B4x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jun 2019 21:56:53 -0400
Received: by mail-qk1-f196.google.com with SMTP id c11so3514320qkk.8;
        Thu, 27 Jun 2019 18:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0i4kJCzdFi1eKWT/Uh5ABrL3ICyPfUoX7aaK4/fBK80=;
        b=i4SCkeIeve7atg+6hpytb+v5x6EIKiwnxQ25tNHm5IjSEhGNCU3S1skO10lySeJ0pl
         LnTrlUS6At33fAbKD1AQJs7RMLdZSFO7M7gYHJlkcsqo+NdOSAPvUwCIqiilKxA9J8Kl
         ui6HOgwU3JJWAjQaaWmw4Y96UKx/LJjqsma4IskllaSTvcX+1hbOkuW7BJ4Frtc+ZCJ1
         ASHzSYqjbL0qBPSmyl7zR9kHQsPPwjD+X2kR7b2SaOoGaKpx6Qb/oFLf4UDeqDyp0C0d
         UN8OvATvZ3I1j/gH3/EGVnj4ZOEBkA9U+BDoqk0O6fbMOREGALVYCx4wBEwSxqAe7qx6
         GvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0i4kJCzdFi1eKWT/Uh5ABrL3ICyPfUoX7aaK4/fBK80=;
        b=XmKzoI8CUrHIGlWlNYsm0uRkFzZ+HEsPQlmIRR/8Dmu0noSQ33NiQ7UNtiFB3PeEkr
         HlnznKpE7Z84dn5o5dS1IFuMPAUt1T/Twp8MQktdPBHT2zZaSXjCWx4PbuA2M9t5ZKz0
         Q1bcyzNY0dOHpYwzzt4iGm2sZTcwXW7I40eFdzgUDKVGJQsMenJe0MN0KQOFASKO5gII
         qWFJPBxfkgQw5kQOyZ/msr3Ph+xncUfyVlPCtPEDu1nqOL0pWma2piT81mw+0dNFlZGi
         t2lh2aYyBPsxiaVQelO/maYNn6zsjqDTXT5SAAHNakc7DewXPAIk3OwNrPZPs5mLfvqY
         OiXw==
X-Gm-Message-State: APjAAAUSNb12W9B9FX1onhxXIGtmyAcf68LJ6CgazzOJroY5fN5p1EtY
        Xz+dA3lGk8kBSpErrADg/5dO5ycFN6WC+Qq2j61X9foLePxb0Q==
X-Google-Smtp-Source: APXvYqzOTcm9NKv/sFbRZ4uKO9DpJr8/FOJVEOpmpSay1So1xdXCTcoyv9lWGDlleBFqYLp/WFtF0z1bH9FpytjrDXQ=
X-Received: by 2002:a37:a095:: with SMTP id j143mr6633284qke.449.1561687011590;
 Thu, 27 Jun 2019 18:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190627090446.GG7221@shao2-debian> <20190627155029.GC4866@mini-arch>
In-Reply-To: <20190627155029.GC4866@mini-arch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 Jun 2019 18:56:39 -0700
Message-ID: <CAEf4Bzb1y=rZ9yeRP7TDrvW9wiOwKHkCdHAqjNh+7xSkrBOk6A@mail.gmail.com>
Subject: Re: [bpf/tools] cd17d77705: kernel_selftests.bpf.test_sock_addr.sh.fail
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        bpf <bpf@vger.kernel.org>, lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 27, 2019 at 8:50 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
>
> On 06/27, kernel test robot wrote:
> > FYI, we noticed the following commit (built with gcc-7):
> >
> > commit: cd17d77705780e2270937fb3cbd2b985adab3edc ("bpf/tools: sync bpf.=
h")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> > in testcase: kernel_selftests
> > with following parameters:
> >
> >       group: kselftests-00
> >
> > test-description: The kernel contains a set of "self tests" under the t=
ools/testing/selftests/ directory. These are intended to be small unit test=
s to exercise individual code paths in the kernel.
> > test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> >
> >
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2=
 -m 8G
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire lo=
g/backtrace):
> >
> > # ; int connect_v6_prog(struct bpf_sock_addr *ctx)
> > # 0: (bf) r6 =3D r1
> > # 1: (18) r1 =3D 0x100000000000000
> > # ; tuple.ipv6.daddr[0] =3D bpf_htonl(DST_REWRITE_IP6_0);
> > # 3: (7b) *(u64 *)(r10 -16) =3D r1
> > # 4: (b7) r1 =3D 169476096
> > # ; memset(&tuple.ipv6.sport, 0, sizeof(tuple.ipv6.sport));
> > # 5: (63) *(u32 *)(r10 -8) =3D r1
> > # 6: (b7) r7 =3D 0
> > # ; tuple.ipv6.daddr[0] =3D bpf_htonl(DST_REWRITE_IP6_0);
> > # 7: (7b) *(u64 *)(r10 -24) =3D r7
> > # 8: (7b) *(u64 *)(r10 -32) =3D r7
> > # 9: (7b) *(u64 *)(r10 -40) =3D r7
> > # ; if (ctx->type !=3D SOCK_STREAM && ctx->type !=3D SOCK_DGRAM)
> > # 10: (61) r1 =3D *(u32 *)(r6 +32)
> > # ; if (ctx->type !=3D SOCK_STREAM && ctx->type !=3D SOCK_DGRAM)
> > # 11: (bf) r2 =3D r1
> > # 12: (07) r2 +=3D -1
> > # 13: (67) r2 <<=3D 32
> > # 14: (77) r2 >>=3D 32
> > # 15: (25) if r2 > 0x1 goto pc+33
> > #  R1=3Dinv(id=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xffffffff))=
 R2=3Dinv(id=3D0,umax_value=3D1,var_off=3D(0x0; 0x1)) R6=3Dctx(id=3D0,off=
=3D0,imm=3D0) R7=3Dinv0 R10=3Dfp0,call_-1 fp-8=3D????mmmm fp-16=3Dmmmmmmmm =
fp-24=3D00000000 fp-32=3D00000000 fp-40=3D00000000
> > # ; else if (ctx->type =3D=3D SOCK_STREAM)
> > # 16: (55) if r1 !=3D 0x1 goto pc+8
> > #  R1=3Dinv1 R2=3Dinv(id=3D0,umax_value=3D1,var_off=3D(0x0; 0x1)) R6=3D=
ctx(id=3D0,off=3D0,imm=3D0) R7=3Dinv0 R10=3Dfp0,call_-1 fp-8=3D????mmmm fp-=
16=3Dmmmmmmmm fp-24=3D00000000 fp-32=3D00000000 fp-40=3D00000000
> > # 17: (bf) r2 =3D r10
> > # ; sk =3D bpf_sk_lookup_tcp(ctx, &tuple, sizeof(tuple.ipv6),
> > # 18: (07) r2 +=3D -40
> > # 19: (bf) r1 =3D r6
> > # 20: (b7) r3 =3D 36
> > # 21: (b7) r4 =3D -1
> > # 22: (b7) r5 =3D 0
> > # 23: (85) call bpf_sk_lookup_tcp#84
> > # 24: (05) goto pc+7
> > # ; if (!sk)
> > # 32: (15) if r0 =3D=3D 0x0 goto pc+16
> > #  R0=3Dsock(id=3D0,ref_obj_id=3D2,off=3D0,imm=3D0) R6=3Dctx(id=3D0,off=
=3D0,imm=3D0) R7=3Dinv0 R10=3Dfp0,call_-1 fp-8=3D????mmmm fp-16=3Dmmmmmmmm =
fp-24=3Dmmmmmmmm fp-32=3Dmmmmmmmm fp-40=3Dmmmmmmmm refs=3D2
> > # ; if (sk->src_ip6[0] !=3D tuple.ipv6.daddr[0] ||
> > # 33: (61) r1 =3D *(u32 *)(r0 +28)
> > # ; if (sk->src_ip6[0] !=3D tuple.ipv6.daddr[0] ||
> > # 34: (61) r2 =3D *(u32 *)(r10 -24)
> > # ; if (sk->src_ip6[0] !=3D tuple.ipv6.daddr[0] ||
> > # 35: (5d) if r1 !=3D r2 goto pc+11
> > #  R0=3Dsock(id=3D0,ref_obj_id=3D2,off=3D0,imm=3D0) R1=3Dinv(id=3D0,uma=
x_value=3D4294967295,var_off=3D(0x0; 0xffffffff)) R2=3Dinv(id=3D0,umax_valu=
e=3D4294967295,var_off=3D(0x0; 0xffffffff)) R6=3Dctx(id=3D0,off=3D0,imm=3D0=
) R7=3Dinv0 R10=3Dfp0,call_-1 fp-8=3D????mmmm fp-16=3Dmmmmmmmm fp-24=3Dmmmm=
mmmm fp-32=3Dmmmmmmmm fp-40=3Dmmmmmmmm refs=3D2
> > # ; sk->src_ip6[1] !=3D tuple.ipv6.daddr[1] ||
> > # 36: (61) r1 =3D *(u32 *)(r0 +32)
> > # ; sk->src_ip6[1] !=3D tuple.ipv6.daddr[1] ||
> > # 37: (61) r2 =3D *(u32 *)(r10 -20)
> > # ; sk->src_ip6[1] !=3D tuple.ipv6.daddr[1] ||
> > # 38: (5d) if r1 !=3D r2 goto pc+8
> > #  R0=3Dsock(id=3D0,ref_obj_id=3D2,off=3D0,imm=3D0) R1=3Dinv(id=3D0,uma=
x_value=3D4294967295,var_off=3D(0x0; 0xffffffff)) R2=3Dinv(id=3D0,umax_valu=
e=3D4294967295,var_off=3D(0x0; 0xffffffff)) R6=3Dctx(id=3D0,off=3D0,imm=3D0=
) R7=3Dinv0 R10=3Dfp0,call_-1 fp-8=3D????mmmm fp-16=3Dmmmmmmmm fp-24=3Dmmmm=
mmmm fp-32=3Dmmmmmmmm fp-40=3Dmmmmmmmm refs=3D2
> > # ; sk->src_ip6[2] !=3D tuple.ipv6.daddr[2] ||
> > # 39: (61) r1 =3D *(u32 *)(r0 +36)
> > # ; sk->src_ip6[2] !=3D tuple.ipv6.daddr[2] ||
> > # 40: (61) r2 =3D *(u32 *)(r10 -16)
> > # ; sk->src_ip6[2] !=3D tuple.ipv6.daddr[2] ||
> > # 41: (5d) if r1 !=3D r2 goto pc+5
> > #  R0=3Dsock(id=3D0,ref_obj_id=3D2,off=3D0,imm=3D0) R1=3Dinv(id=3D0,uma=
x_value=3D4294967295,var_off=3D(0x0; 0xffffffff)) R2=3Dinv(id=3D0,umax_valu=
e=3D4294967295,var_off=3D(0x0; 0xffffffff)) R6=3Dctx(id=3D0,off=3D0,imm=3D0=
) R7=3Dinv0 R10=3Dfp0,call_-1 fp-8=3D????mmmm fp-16=3Dmmmmmmmm fp-24=3Dmmmm=
mmmm fp-32=3Dmmmmmmmm fp-40=3Dmmmmmmmm refs=3D2
> > # ; sk->src_ip6[3] !=3D tuple.ipv6.daddr[3] ||
> > # 42: (61) r1 =3D *(u32 *)(r0 +40)
> > # ; sk->src_ip6[3] !=3D tuple.ipv6.daddr[3] ||
> > # 43: (61) r2 =3D *(u32 *)(r10 -12)
> > # ; sk->src_ip6[3] !=3D tuple.ipv6.daddr[3] ||
> > # 44: (5d) if r1 !=3D r2 goto pc+2
> > #  R0=3Dsock(id=3D0,ref_obj_id=3D2,off=3D0,imm=3D0) R1=3Dinv(id=3D0,uma=
x_value=3D4294967295,var_off=3D(0x0; 0xffffffff)) R2=3Dinv(id=3D0,umax_valu=
e=3D4294967295,var_off=3D(0x0; 0xffffffff)) R6=3Dctx(id=3D0,off=3D0,imm=3D0=
) R7=3Dinv0 R10=3Dfp0,call_-1 fp-8=3D????mmmm fp-16=3Dmmmmmmmm fp-24=3Dmmmm=
mmmm fp-32=3Dmmmmmmmm fp-40=3Dmmmmmmmm refs=3D2
> > # ; sk->src_port !=3D DST_REWRITE_PORT6) {
> > # 45: (61) r1 =3D *(u32 *)(r0 +44)
> > # ; if (sk->src_ip6[0] !=3D tuple.ipv6.daddr[0] ||
> > # 46: (15) if r1 =3D=3D 0x1a0a goto pc+4
> > #  R0=3Dsock(id=3D0,ref_obj_id=3D2,off=3D0,imm=3D0) R1=3Dinv(id=3D0,uma=
x_value=3D4294967295,var_off=3D(0x0; 0xffffffff)) R2=3Dinv(id=3D0,umax_valu=
e=3D4294967295,var_off=3D(0x0; 0xffffffff)) R6=3Dctx(id=3D0,off=3D0,imm=3D0=
) R7=3Dinv0 R10=3Dfp0,call_-1 fp-8=3D????mmmm fp-16=3Dmmmmmmmm fp-24=3Dmmmm=
mmmm fp-32=3Dmmmmmmmm fp-40=3Dmmmmmmmm refs=3D2
> > # ; bpf_sk_release(sk);
> > # 47: (bf) r1 =3D r0
> > # 48: (85) call bpf_sk_release#86
> > # ; }
> > # 49: (bf) r0 =3D r7
> > # 50: (95) exit
> > #
> > # from 46 to 51: R0=3Dsock(id=3D0,ref_obj_id=3D2,off=3D0,imm=3D0) R1=3D=
inv6666 R2=3Dinv(id=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xffffffff)=
) R6=3Dctx(id=3D0,off=3D0,imm=3D0) R7=3Dinv0 R10=3Dfp0,call_-1 fp-8=3D????m=
mmm fp-16=3Dmmmmmmmm fp-24=3Dmmmmmmmm fp-32=3Dmmmmmmmm fp-40=3Dmmmmmmmm ref=
s=3D2
> > # ; bpf_sk_release(sk);
> > # 51: (bf) r1 =3D r0
> > # 52: (85) call bpf_sk_release#86
> > # 53: (b7) r1 =3D 2586
> > # ; ctx->user_port =3D bpf_htons(DST_REWRITE_PORT6);
> > # 54: (63) *(u32 *)(r6 +24) =3D r1
> > # 55: (18) r1 =3D 0x100000000000000
> > # ; ctx->user_ip6[2] =3D bpf_htonl(DST_REWRITE_IP6_2);
> > # 57: (7b) *(u64 *)(r6 +16) =3D r1
> > # invalid bpf_context access off=3D16 size=3D8
> This looks like clang doing single u64 write for user_ip6[2] and
> user_ip6[3] instead of two u32. I don't think we allow that.
>
> I've seen this a couple of times myself while playing with some
> progs, but not sure what's the right way to 'fix' it.

So I bisected this to the commit below. That change effectively makes
`struct bpf_sock_addr` 8-byte aligned, which apparently triggers some
optimization in clang to generate this 8-byte write for two
consecutive 4-byte array elements.


commit cd17d77705780e2270937fb3cbd2b985adab3edc (HEAD, refs/bisect/bad)
Author: Stanislav Fomichev <sdf@google.com>
Date:   Wed Jun 12 10:30:39 2019 -0700

    bpf/tools: sync bpf.h

    Add sk to struct bpf_sock_addr and struct bpf_sock_ops.

    Cc: Martin Lau <kafai@fb.com>
    Signed-off-by: Stanislav Fomichev <sdf@google.com>
    Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.=
h
index ae0907d8c03a..d0a23476f887 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3247,6 +3247,7 @@ struct bpf_sock_addr {
        __u32 msg_src_ip6[4];   /* Allows 1,2,4-byte read an 4-byte write.
                                 * Stored in network byte order.
                                 */
+       __bpf_md_ptr(struct bpf_sock *, sk);
 };

 /* User bpf_sock_ops struct to access socket values and specify request op=
s
@@ -3298,6 +3299,7 @@ struct bpf_sock_ops {
        __u32 sk_txhash;
        __u64 bytes_received;
        __u64 bytes_acked;
+       __bpf_md_ptr(struct bpf_sock *, sk);
 };

 /* Definitions for bpf_sock_ops_cb_flags */



>
> > # processed 49 insns (limit 1000000) max_states_per_insn 0 total_states=
 13 peak_states 13 mark_read 11
> > #
> > # libbpf: -- END LOG --
> > # libbpf: failed to load program 'cgroup/connect6'
> > # libbpf: failed to load object './connect6_prog.o'
> > # (test_sock_addr.c:752: errno: Bad file descriptor) >>> Loading progra=
m (./connect6_prog.o) error.
