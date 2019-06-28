Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7BF59117
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2019 04:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfF1CWS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jun 2019 22:22:18 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43367 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfF1CWR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jun 2019 22:22:17 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so3543719qka.10;
        Thu, 27 Jun 2019 19:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vjNWGiccp2JQ2DtMTO4a0fFhfzg0q9Bf38aKAWXJbiw=;
        b=K4PVPG1VFRXu47fpUE79VtOOTyoPypgrnf/6/MbDMjqA2moLRbgVJfPyvc0nZocmx+
         04xPR5Suy6hkf8fgN3sF9aKjzR/Xr8t0ZQYzse0yFz2+pcjj/Wo6een36zQdsdgvOWOC
         Q9u5J3WDgEEg4HmrjGwrZiTwKQIKR6DB5ZDWFByiH0FUvaUnsr6zpduffmDalNLfPP6S
         6WBGY141WdzhKPW8T/bRqpE6FZfhVaIX9rFhvE+ORGAtuUyQNjSyXsrZWlhbT0SsLeVT
         pRQ/Q2PfG2repiCamFi5O1xK3M0KwWNjIf34c3ixLGWb/oW3ZL8Cv9hvrPQAWddi+/91
         Ml2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vjNWGiccp2JQ2DtMTO4a0fFhfzg0q9Bf38aKAWXJbiw=;
        b=Nr9zAYx/RStfpBU2op8D+lJ4KJM/140+gprqGaS/aRoqr0OOnOdPGia/ie4Lrqgjq+
         89G7kZOVqdXVEAAorSYEEcFMLJGokQ+1XQsUuis438AY5U4IiJuNQkXYpCat8lPfbigu
         Uu2NXcyDg/lRL9uEXgjdBYOZ/U+PAj/eoFg5xF4HMnyJh45hT/3dj+BoXOVu7kbB3L9N
         l6rs4yfREzc9TkYVtK2IpG71MqcHfAJ4SBhKoYg+ylxjKG/P6XEGp8WH70RhFVfUhyJx
         mVmQpAwsAAyTtLqUOnCoiHi4X2MRCrIZoYuf9AhhRxR37i2/4c7ttOCQ0wOIK9HUJ5vC
         Xbaw==
X-Gm-Message-State: APjAAAX/ATUbyAi9N4JcQZfVHy89xsPXtEVydHZ+iVUHKhxESn1aKnlm
        npeGxEDxo6eqEqzHfxFHwE6RpLjBfWoxaeO7eCjcbIq/a22p/Q==
X-Google-Smtp-Source: APXvYqxmv+/yQNpyvbazEjP/MXPf949MYaS9chXluWkU8/Zw4em0CHNuUriQj2781bEw8TUV6ctzrn/K4qtbTQ5/BE0=
X-Received: by 2002:ae9:d803:: with SMTP id u3mr6639812qkf.437.1561688535946;
 Thu, 27 Jun 2019 19:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190627090446.GG7221@shao2-debian> <20190627155029.GC4866@mini-arch>
 <20190627172932.GD4866@mini-arch>
In-Reply-To: <20190627172932.GD4866@mini-arch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 Jun 2019 19:22:04 -0700
Message-ID: <CAEf4Bzbf8OE9TUV2Pq7HZp3PYhoUgMzH-Gs+GMafTPwPc_jYxA@mail.gmail.com>
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

On Thu, Jun 27, 2019 at 10:29 AM Stanislav Fomichev <sdf@fomichev.me> wrote=
:
>
> On 06/27, Stanislav Fomichev wrote:
> > On 06/27, kernel test robot wrote:
> > > FYI, we noticed the following commit (built with gcc-7):
> > >
> > > commit: cd17d77705780e2270937fb3cbd2b985adab3edc ("bpf/tools: sync bp=
f.h")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git mast=
er
> > >
> > > in testcase: kernel_selftests
> > > with following parameters:
> > >
> > >     group: kselftests-00
> > >
> > > test-description: The kernel contains a set of "self tests" under the=
 tools/testing/selftests/ directory. These are intended to be small unit te=
sts to exercise individual code paths in the kernel.
> > > test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> > >
> > >
> > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp=
 2 -m 8G
> > >
> > > caused below changes (please refer to attached dmesg/kmsg for entire =
log/backtrace):
> > >
> > > # ; int connect_v6_prog(struct bpf_sock_addr *ctx)
> > > # 0: (bf) r6 =3D r1
> > > # 1: (18) r1 =3D 0x100000000000000
> > > # ; tuple.ipv6.daddr[0] =3D bpf_htonl(DST_REWRITE_IP6_0);
> > > # 3: (7b) *(u64 *)(r10 -16) =3D r1
> > > # 4: (b7) r1 =3D 169476096
> > > # ; memset(&tuple.ipv6.sport, 0, sizeof(tuple.ipv6.sport));
> > > # 5: (63) *(u32 *)(r10 -8) =3D r1
> > > # 6: (b7) r7 =3D 0
> > > # ; tuple.ipv6.daddr[0] =3D bpf_htonl(DST_REWRITE_IP6_0);
> > > # 7: (7b) *(u64 *)(r10 -24) =3D r7
> > > # 8: (7b) *(u64 *)(r10 -32) =3D r7
> > > # 9: (7b) *(u64 *)(r10 -40) =3D r7
> > > # ; if (ctx->type !=3D SOCK_STREAM && ctx->type !=3D SOCK_DGRAM)
> > > # 10: (61) r1 =3D *(u32 *)(r6 +32)
> > > # ; if (ctx->type !=3D SOCK_STREAM && ctx->type !=3D SOCK_DGRAM)
> > > # 11: (bf) r2 =3D r1
> > > # 12: (07) r2 +=3D -1
> > > # 13: (67) r2 <<=3D 32
> > > # 14: (77) r2 >>=3D 32
> > > # 15: (25) if r2 > 0x1 goto pc+33
> > > #  R1=3Dinv(id=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xffffffff=
)) R2=3Dinv(id=3D0,umax_value=3D1,var_off=3D(0x0; 0x1)) R6=3Dctx(id=3D0,off=
=3D0,imm=3D0) R7=3Dinv0 R10=3Dfp0,call_-1 fp-8=3D????mmmm fp-16=3Dmmmmmmmm =
fp-24=3D00000000 fp-32=3D00000000 fp-40=3D00000000
> > > # ; else if (ctx->type =3D=3D SOCK_STREAM)
> > > # 16: (55) if r1 !=3D 0x1 goto pc+8
> > > #  R1=3Dinv1 R2=3Dinv(id=3D0,umax_value=3D1,var_off=3D(0x0; 0x1)) R6=
=3Dctx(id=3D0,off=3D0,imm=3D0) R7=3Dinv0 R10=3Dfp0,call_-1 fp-8=3D????mmmm =
fp-16=3Dmmmmmmmm fp-24=3D00000000 fp-32=3D00000000 fp-40=3D00000000
> > > # 17: (bf) r2 =3D r10
> > > # ; sk =3D bpf_sk_lookup_tcp(ctx, &tuple, sizeof(tuple.ipv6),
> > > # 18: (07) r2 +=3D -40
> > > # 19: (bf) r1 =3D r6
> > > # 20: (b7) r3 =3D 36
> > > # 21: (b7) r4 =3D -1
> > > # 22: (b7) r5 =3D 0
> > > # 23: (85) call bpf_sk_lookup_tcp#84
> > > # 24: (05) goto pc+7
> > > # ; if (!sk)
> > > # 32: (15) if r0 =3D=3D 0x0 goto pc+16
> > > #  R0=3Dsock(id=3D0,ref_obj_id=3D2,off=3D0,imm=3D0) R6=3Dctx(id=3D0,o=
ff=3D0,imm=3D0) R7=3Dinv0 R10=3Dfp0,call_-1 fp-8=3D????mmmm fp-16=3Dmmmmmmm=
m fp-24=3Dmmmmmmmm fp-32=3Dmmmmmmmm fp-40=3Dmmmmmmmm refs=3D2
> > > # ; if (sk->src_ip6[0] !=3D tuple.ipv6.daddr[0] ||
> > > # 33: (61) r1 =3D *(u32 *)(r0 +28)
> > > # ; if (sk->src_ip6[0] !=3D tuple.ipv6.daddr[0] ||
> > > # 34: (61) r2 =3D *(u32 *)(r10 -24)
> > > # ; if (sk->src_ip6[0] !=3D tuple.ipv6.daddr[0] ||
> > > # 35: (5d) if r1 !=3D r2 goto pc+11
> > > #  R0=3Dsock(id=3D0,ref_obj_id=3D2,off=3D0,imm=3D0) R1=3Dinv(id=3D0,u=
max_value=3D4294967295,var_off=3D(0x0; 0xffffffff)) R2=3Dinv(id=3D0,umax_va=
lue=3D4294967295,var_off=3D(0x0; 0xffffffff)) R6=3Dctx(id=3D0,off=3D0,imm=
=3D0) R7=3Dinv0 R10=3Dfp0,call_-1 fp-8=3D????mmmm fp-16=3Dmmmmmmmm fp-24=3D=
mmmmmmmm fp-32=3Dmmmmmmmm fp-40=3Dmmmmmmmm refs=3D2
> > > # ; sk->src_ip6[1] !=3D tuple.ipv6.daddr[1] ||
> > > # 36: (61) r1 =3D *(u32 *)(r0 +32)
> > > # ; sk->src_ip6[1] !=3D tuple.ipv6.daddr[1] ||
> > > # 37: (61) r2 =3D *(u32 *)(r10 -20)
> > > # ; sk->src_ip6[1] !=3D tuple.ipv6.daddr[1] ||
> > > # 38: (5d) if r1 !=3D r2 goto pc+8
> > > #  R0=3Dsock(id=3D0,ref_obj_id=3D2,off=3D0,imm=3D0) R1=3Dinv(id=3D0,u=
max_value=3D4294967295,var_off=3D(0x0; 0xffffffff)) R2=3Dinv(id=3D0,umax_va=
lue=3D4294967295,var_off=3D(0x0; 0xffffffff)) R6=3Dctx(id=3D0,off=3D0,imm=
=3D0) R7=3Dinv0 R10=3Dfp0,call_-1 fp-8=3D????mmmm fp-16=3Dmmmmmmmm fp-24=3D=
mmmmmmmm fp-32=3Dmmmmmmmm fp-40=3Dmmmmmmmm refs=3D2
> > > # ; sk->src_ip6[2] !=3D tuple.ipv6.daddr[2] ||
> > > # 39: (61) r1 =3D *(u32 *)(r0 +36)
> > > # ; sk->src_ip6[2] !=3D tuple.ipv6.daddr[2] ||
> > > # 40: (61) r2 =3D *(u32 *)(r10 -16)
> > > # ; sk->src_ip6[2] !=3D tuple.ipv6.daddr[2] ||
> > > # 41: (5d) if r1 !=3D r2 goto pc+5
> > > #  R0=3Dsock(id=3D0,ref_obj_id=3D2,off=3D0,imm=3D0) R1=3Dinv(id=3D0,u=
max_value=3D4294967295,var_off=3D(0x0; 0xffffffff)) R2=3Dinv(id=3D0,umax_va=
lue=3D4294967295,var_off=3D(0x0; 0xffffffff)) R6=3Dctx(id=3D0,off=3D0,imm=
=3D0) R7=3Dinv0 R10=3Dfp0,call_-1 fp-8=3D????mmmm fp-16=3Dmmmmmmmm fp-24=3D=
mmmmmmmm fp-32=3Dmmmmmmmm fp-40=3Dmmmmmmmm refs=3D2
> > > # ; sk->src_ip6[3] !=3D tuple.ipv6.daddr[3] ||
> > > # 42: (61) r1 =3D *(u32 *)(r0 +40)
> > > # ; sk->src_ip6[3] !=3D tuple.ipv6.daddr[3] ||
> > > # 43: (61) r2 =3D *(u32 *)(r10 -12)
> > > # ; sk->src_ip6[3] !=3D tuple.ipv6.daddr[3] ||
> > > # 44: (5d) if r1 !=3D r2 goto pc+2
> > > #  R0=3Dsock(id=3D0,ref_obj_id=3D2,off=3D0,imm=3D0) R1=3Dinv(id=3D0,u=
max_value=3D4294967295,var_off=3D(0x0; 0xffffffff)) R2=3Dinv(id=3D0,umax_va=
lue=3D4294967295,var_off=3D(0x0; 0xffffffff)) R6=3Dctx(id=3D0,off=3D0,imm=
=3D0) R7=3Dinv0 R10=3Dfp0,call_-1 fp-8=3D????mmmm fp-16=3Dmmmmmmmm fp-24=3D=
mmmmmmmm fp-32=3Dmmmmmmmm fp-40=3Dmmmmmmmm refs=3D2
> > > # ; sk->src_port !=3D DST_REWRITE_PORT6) {
> > > # 45: (61) r1 =3D *(u32 *)(r0 +44)
> > > # ; if (sk->src_ip6[0] !=3D tuple.ipv6.daddr[0] ||
> > > # 46: (15) if r1 =3D=3D 0x1a0a goto pc+4
> > > #  R0=3Dsock(id=3D0,ref_obj_id=3D2,off=3D0,imm=3D0) R1=3Dinv(id=3D0,u=
max_value=3D4294967295,var_off=3D(0x0; 0xffffffff)) R2=3Dinv(id=3D0,umax_va=
lue=3D4294967295,var_off=3D(0x0; 0xffffffff)) R6=3Dctx(id=3D0,off=3D0,imm=
=3D0) R7=3Dinv0 R10=3Dfp0,call_-1 fp-8=3D????mmmm fp-16=3Dmmmmmmmm fp-24=3D=
mmmmmmmm fp-32=3Dmmmmmmmm fp-40=3Dmmmmmmmm refs=3D2
> > > # ; bpf_sk_release(sk);
> > > # 47: (bf) r1 =3D r0
> > > # 48: (85) call bpf_sk_release#86
> > > # ; }
> > > # 49: (bf) r0 =3D r7
> > > # 50: (95) exit
> > > #
> > > # from 46 to 51: R0=3Dsock(id=3D0,ref_obj_id=3D2,off=3D0,imm=3D0) R1=
=3Dinv6666 R2=3Dinv(id=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xffffff=
ff)) R6=3Dctx(id=3D0,off=3D0,imm=3D0) R7=3Dinv0 R10=3Dfp0,call_-1 fp-8=3D??=
??mmmm fp-16=3Dmmmmmmmm fp-24=3Dmmmmmmmm fp-32=3Dmmmmmmmm fp-40=3Dmmmmmmmm =
refs=3D2
> > > # ; bpf_sk_release(sk);
> > > # 51: (bf) r1 =3D r0
> > > # 52: (85) call bpf_sk_release#86
> > > # 53: (b7) r1 =3D 2586
> > > # ; ctx->user_port =3D bpf_htons(DST_REWRITE_PORT6);
> > > # 54: (63) *(u32 *)(r6 +24) =3D r1
> > > # 55: (18) r1 =3D 0x100000000000000
> > > # ; ctx->user_ip6[2] =3D bpf_htonl(DST_REWRITE_IP6_2);
> > > # 57: (7b) *(u64 *)(r6 +16) =3D r1
> > > # invalid bpf_context access off=3D16 size=3D8
> > This looks like clang doing single u64 write for user_ip6[2] and
> > user_ip6[3] instead of two u32. I don't think we allow that.
> >
> > I've seen this a couple of times myself while playing with some
> > progs, but not sure what's the right way to 'fix' it.
> >
> Any thoughts about the patch below? Another way to "fix" it

I'll give it a more thorough look a bit later, but see my comments below.

> would be to mark context accesses 'volatile' in bpf progs, but that sound=
s
> a bit gross.
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 43b45d6db36d..34a14c950e60 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -746,6 +746,20 @@ bpf_ctx_narrow_access_ok(u32 off, u32 size, u32 size=
_default)
>         return size <=3D size_default && (size & (size - 1)) =3D=3D 0;
>  }
>
> +static inline bool __bpf_ctx_wide_store_ok(u32 off, u32 size)

It seems like bpf_ctx_wide_store_ok and __bpf_ctx_wide_store_ok are
used only inside net/core/filter.c, why declaring them in header file?

> +{
> +       /* u64 access is aligned and fits into the field size */
> +       return off % sizeof(__u64) =3D=3D 0 && off + sizeof(__u64) <=3D s=
ize;
> +}
> +
> +#define bpf_ctx_wide_store_ok(off, size, type, field) \
> +       (size =3D=3D sizeof(__u64) && \
> +        off >=3D offsetof(type, field) && \
> +        off < offsetofend(type, field) ? \
> +       __bpf_ctx_wide_store_ok(off - offsetof(type, field), \
> +                                FIELD_SIZEOF(type, field)) : 0)

Why do you need ternary operator instead of just a chain of &&s?

It also seems like you can avoid macro and use plain function if
instead of providing (type, field) you provide values of offsetof and
offsetofend (offsetofend - offsetof should equal FIELD_SIZEOF(type,
field), shouldn't it?).

> +
> +


>  #define bpf_classic_proglen(fprog) (fprog->len * sizeof(fprog->filter[0]=
))
>
>  static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2014d76e0d2a..2d3787a439ae 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6849,6 +6849,16 @@ static bool sock_addr_is_valid_access(int off, int=
 size,
>                         if (!bpf_ctx_narrow_access_ok(off, size, size_def=
ault))
>                                 return false;
>                 } else {
> +                       if (bpf_ctx_wide_store_ok(off, size,
> +                                                 struct bpf_sock_addr,
> +                                                 user_ip6))
> +                               return true;
> +
> +                       if (bpf_ctx_wide_store_ok(off, size,
> +                                                 struct bpf_sock_addr,
> +                                                 msg_src_ip6))
> +                               return true;
> +
>                         if (size !=3D size_default)
>                                 return false;
>                 }
> @@ -7689,9 +7699,6 @@ static u32 xdp_convert_ctx_access(enum bpf_access_t=
ype type,
>  /* SOCK_ADDR_STORE_NESTED_FIELD_OFF() has semantic similar to
>   * SOCK_ADDR_LOAD_NESTED_FIELD_SIZE_OFF() but for store operation.
>   *
> - * It doesn't support SIZE argument though since narrow stores are not
> - * supported for now.
> - *
>   * In addition it uses Temporary Field TF (member of struct S) as the 3r=
d
>   * "register" since two registers available in convert_ctx_access are no=
t
>   * enough: we can't override neither SRC, since it contains value to sto=
re, nor
> @@ -7699,7 +7706,7 @@ static u32 xdp_convert_ctx_access(enum bpf_access_t=
ype type,
>   * instructions. But we need a temporary place to save pointer to nested
>   * structure whose field we want to store to.
>   */
> -#define SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, OFF, TF)         =
              \
> +#define SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, SIZE, OFF, TF)   =
      \
>         do {                                                             =
      \
>                 int tmp_reg =3D BPF_REG_9;                               =
        \
>                 if (si->src_reg =3D=3D tmp_reg || si->dst_reg =3D=3D tmp_=
reg)          \
> @@ -7710,8 +7717,7 @@ static u32 xdp_convert_ctx_access(enum bpf_access_t=
ype type,
>                                       offsetof(S, TF));                  =
      \
>                 *insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(S, F), tmp_reg, =
        \
>                                       si->dst_reg, offsetof(S, F));      =
      \
> -               *insn++ =3D BPF_STX_MEM(                                 =
        \
> -                       BPF_FIELD_SIZEOF(NS, NF), tmp_reg, si->src_reg,  =
      \
> +               *insn++ =3D BPF_STX_MEM(SIZE, tmp_reg, si->src_reg,      =
        \
>                         bpf_target_off(NS, NF, FIELD_SIZEOF(NS, NF),     =
      \
>                                        target_size)                      =
      \
>                                 + OFF);                                  =
      \
> @@ -7723,8 +7729,8 @@ static u32 xdp_convert_ctx_access(enum bpf_access_t=
ype type,
>                                                       TF)                =
      \
>         do {                                                             =
      \
>                 if (type =3D=3D BPF_WRITE) {                             =
          \
> -                       SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, OF=
F,    \
> -                                                        TF);            =
      \
> +                       SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, SI=
ZE,   \
> +                                                        OFF, TF);       =
      \
>                 } else {                                                 =
      \
>                         SOCK_ADDR_LOAD_NESTED_FIELD_SIZE_OFF(            =
      \
>                                 S, NS, F, NF, SIZE, OFF);  \
