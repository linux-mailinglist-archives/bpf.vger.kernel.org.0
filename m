Return-Path: <bpf+bounces-67084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3662EB3DDCC
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 11:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542891891322
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 09:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179B4305E09;
	Mon,  1 Sep 2025 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhDOF4PL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E056F305057
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718103; cv=none; b=U4T+NKp3sO2eTP2dD6UGmWy6FXNcwrM+S8lE+L6y+SVMzzdni85muBlB22IFsfBvjm58CjXZYJ7jefaGg3ZwXoEYIZq0VIgm9yNcymjK1CTzK2PvF8P/6P4r8UGpk/3cr/DqCl9PSkXjpLPWAPIEAu/x+XDOhE05+mld15VOFRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718103; c=relaxed/simple;
	bh=+ktYQCXZmrsA9HjKrAk8hPle1SNrNg7Cb/YZPludOWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2wwhvf0QMqKbrS65ZvRkCdqYG1ZguWxtCh2nKKKR4ECN3o5H/hnzs0FgN41gdYGg6csvw3+oR5e6478HcDA7jeRHQKKl+x7wwTZwcKjeEdf2XJTf4uKICh8O7MHyjQrdl//FQYVfkHXKNW0NgZ7b7gfXxHoOkIqAJoaIsO3Q/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhDOF4PL; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-61e526608f3so348027eaf.1
        for <bpf@vger.kernel.org>; Mon, 01 Sep 2025 02:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756718101; x=1757322901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUVwlAVdo7sEexKoJLPmKvExxcWycUCr3o8WXuEmtho=;
        b=fhDOF4PLi8jKuTImjcVqx9+GHejuu5WM8wQh/ACSaFlVatep3neJ1WSVYViE5ubmgJ
         EbuKmnLfa89sN+3eHj2+Cjig9HZGX7XrA1WdEnlEHrU6berEFoRqgNu+Iy+nMmBWKSL1
         EQW2bD+oQSFmEmklzxP93Z0VlYl9YqucjGDiDqKaSUN7U/hF35rUQV/5XcO2D+qVQi9O
         /U5ZGsSwDXFZWvojXHwFctXv/5YixghcCrNawKgtRgildXVNJDby9y2zUmmUbqfyT4ap
         aB9IPkIujT33fsCydTwfuY46etcX6xIT4lidN8t+oG0e3TNZFFkGCquaetW9w3nJUQq7
         hcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718101; x=1757322901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUVwlAVdo7sEexKoJLPmKvExxcWycUCr3o8WXuEmtho=;
        b=tETtJwkb6deEnQdKuLm3m88UZ2MPdDRDJ0Wq+QBfygjUKMKVE6cIpDApKtuiM3v0/p
         jRoQTIM7r+J/D2Qtwsk+96ejjIhcVOjdB2kysfO4dbtEaixo1oF4qj+lUvDqm3h9ju4F
         ar7BqPPav5Hm1izaY+I+W6pUOABCM/rJNSzlci3MksvsIeMXA5bsSEys+0gte/7U//5Y
         VoPFyyowRB9NfDXC8P9/Jix9tmh2YSMU6ySsImwARu+/zznQ9XrQEvwviH8pi9FAkOol
         kWQtqFHSZ/G7f0jDOPZVzYRYMHByRROhdS2lyQZ8uIVYIrJeTBbmiDU7hCIVON9Tgj0F
         jUnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7WVyJ0enulQY91L6zn5ogIu+Mg9xRFAPqvvJ5bYuMmWDsjckQEpnPtjyNjNUBdlcWyYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuENZIr6oMOhoTQPLqG0dYc3+qODxTqCvujnvE6Jd8VSU5oRpq
	GYhLQ4KiF7pYPzP+C4wAwRNoyPR48j0XdAmzEVGsJisP4XcWStuGr0IaQYfPlwAwvnD4D07H1S1
	w3rjdS0mKsP32FLwfJLXJJpwf+rYrHlw=
X-Gm-Gg: ASbGncuFczrXuDwUwq8/Lp9LFqvlhMswYJCtMeyOK2Y1Xr7PKYdH7Qx0OJrYteyr0tH
	+pO+iKDh7bOJvtPQF0ikLFBrNEPD1O3AanRUuWM4WfqTWDw9Q3k7Y/YY5jv29oXLPRCPAjGCQSh
	fuSmQYCaxkinFiYt56eLYrSSwtbb3ZrY/qC4AH79iOzaXsyMqqksHXHU7PMaDQJM6k1JJEGSXMy
	BfmD84BvSANM/IJYmbzNHXyR3Go
X-Google-Smtp-Source: AGHT+IEOtpHHsTeklHOMP8PoPB0+EGT60ww1FNmVbHqMNREqJUoUsi7ZTs9b4uTIYkeiyViTwr2iLAItTiQxuifzUak=
X-Received: by 2002:a05:6820:1c83:b0:61e:1d9d:fd87 with SMTP id
 006d021491bc7-61e337c35dbmr3790491eaf.6.1756718100851; Mon, 01 Sep 2025
 02:15:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827120344.6796-1-hengqi.chen@gmail.com> <d90361c5-75c6-4337-a590-0d81c61adfb9@huawei.com>
 <1be38ff5-ea37-4d5d-9f33-16799d2fe2c5@huawei.com>
In-Reply-To: <1be38ff5-ea37-4d5d-9f33-16799d2fe2c5@huawei.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Mon, 1 Sep 2025 17:14:49 +0800
X-Gm-Features: Ac12FXw38rz2E102CQEyx8kjHIyTM_vHCobgiMcYAVTzQPlbyiXET58tNfm2FuY
Message-ID: <CAEyhmHTz-ZXSg63AQhU4_Pk9CnTs2CQgGdH=LjWbFOqHOva9=Q@mail.gmail.com>
Subject: Re: [PATCH] riscv, bpf: Sign extend struct ops return values properly
To: Pu Lehui <pulehui@huawei.com>
Cc: bjorn@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, puranjay@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 4:06=E2=80=AFPM Pu Lehui <pulehui@huawei.com> wrote:
>
>
>
> On 2025/8/28 9:53, Pu Lehui wrote:
> >
> > On 2025/8/27 20:03, Hengqi Chen wrote:
> >> The ns_bpf_qdisc selftest triggers a kernel panic:
> >>
> >>      Unable to handle kernel paging request at virtual address
> >> ffffffffa38dbf58
> >>      Current test_progs pgtable: 4K pagesize, 57-bit VAs,
> >> pgdp=3D0x00000001109cc000
> >>      [ffffffffa38dbf58] pgd=3D000000011fffd801, p4d=3D000000011fffd401=
,
> >> pud=3D000000011fffd001, pmd=3D0000000000000000
> >>      Oops [#1]
> >>      Modules linked in: bpf_testmod(OE) xt_conntrack nls_iso8859_1
> >> dm_mod drm drm_panel_orientation_quirks configfs backlight btrfs
> >> blake2b_generic xor lzo_compress zlib_deflate raid6_pq efivarfs [last
> >> unloaded: bpf_testmod(OE)]
> >>      CPU: 1 UID: 0 PID: 23584 Comm: test_progs Tainted: G        W
> >> OE       6.17.0-rc1-g2465bb83e0b4 #1 NONE
> >>      Tainted: [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> >>      Hardware name: Unknown Unknown Product/Unknown Product, BIOS
> >> 2024.01+dfsg-1ubuntu5.1 01/01/2024
> >>      epc : __qdisc_run+0x82/0x6f0
> >>       ra : __qdisc_run+0x6e/0x6f0
> >>      epc : ffffffff80bd5c7a ra : ffffffff80bd5c66 sp : ff2000000eecb55=
0
> >>       gp : ffffffff82472098 tp : ff60000096895940 t0 : ffffffff8001f18=
0
> >>       t1 : ffffffff801e1664 t2 : 0000000000000000 s0 : ff2000000eecb5d=
0
> >>       s1 : ff60000093a6a600 a0 : ffffffffa38dbee8 a1 : 000000000000000=
1
> >>       a2 : ff2000000eecb510 a3 : 0000000000000001 a4 : 000000000000000=
0
> >>       a5 : 0000000000000010 a6 : 0000000000000000 a7 : 000000000073504=
9
> >>       s2 : ffffffffa38dbee8 s3 : 0000000000000040 s4 : ff6000008bcda00=
0
> >>       s5 : 0000000000000008 s6 : ff60000093a6a680 s7 : ff60000093a6a6f=
0
> >>       s8 : ff60000093a6a6ac s9 : ff60000093140000 s10: 000000000000000=
0
> >>       s11: ff2000000eecb9d0 t3 : 0000000000000000 t4 : 0000000000ff000=
0
> >>       t5 : 0000000000000000 t6 : ff60000093a6a8b6
> >>      status: 0000000200000120 badaddr: ffffffffa38dbf58 cause:
> >> 000000000000000d
> >>      [<ffffffff80bd5c7a>] __qdisc_run+0x82/0x6f0
> >>      [<ffffffff80b6fe58>] __dev_queue_xmit+0x4c0/0x1128
> >>      [<ffffffff80b80ae0>] neigh_resolve_output+0xd0/0x170
> >>      [<ffffffff80d2daf6>] ip6_finish_output2+0x226/0x6c8
> >>      [<ffffffff80d31254>] ip6_finish_output+0x10c/0x2a0
> >>      [<ffffffff80d31446>] ip6_output+0x5e/0x178
> >>      [<ffffffff80d2e232>] ip6_xmit+0x29a/0x608
> >>      [<ffffffff80d6f4c6>] inet6_csk_xmit+0xe6/0x140
> >>      [<ffffffff80c985e4>] __tcp_transmit_skb+0x45c/0xaa8
> >>      [<ffffffff80c995fe>] tcp_connect+0x9ce/0xd10
> >>      [<ffffffff80d66524>] tcp_v6_connect+0x4ac/0x5e8
> >>      [<ffffffff80cc19b8>] __inet_stream_connect+0xd8/0x318
> >>      [<ffffffff80cc1c36>] inet_stream_connect+0x3e/0x68
> >>      [<ffffffff80b42b20>] __sys_connect_file+0x50/0x88
> >>      [<ffffffff80b42bee>] __sys_connect+0x96/0xc8
> >>      [<ffffffff80b42c40>] __riscv_sys_connect+0x20/0x30
> >>      [<ffffffff80e5bcae>] do_trap_ecall_u+0x256/0x378
> >>      [<ffffffff80e69af2>] handle_exception+0x14a/0x156
> >>      Code: 892a 0363 1205 489c 8bc1 c7e5 2d03 084a 2703 080a (2783) 07=
09
> >>      ---[ end trace 0000000000000000 ]---
> >>
> >> The bpf_fifo_dequeue prog returns a skb which is a pointer.
> >> The pointer is treated as a 32bit value and sign extend to
> >> 64bit in epilogue. This behavior is right for most bpf prog
> >> types but wrong for struct ops which requires RISC-V ABI.
> >
> > Hi Hengqi,
> >
> > Nice catch!
> >
> > Actually, I think commit 7112cd26e606c7ba51f9cc5c1905f06039f6f379 looks
> > a little bit wired and related to this issue. I guess I need some time
> > to recall this commit.
>
> Hi Hengqi,
>
> Sorry for late due to busy work. After some backtracking, I dismissed my
> doubts about commit 7112cd26e606.
>
> >
> > Thanks.
> >
> >>
> >> So let's sign extend struct ops return values according to
> >> the return value spec in function model.
> >>
> >> Fixes: 25ad10658dc1 ("riscv, bpf: Adapt bpf trampoline to optimized
> >> riscv ftrace framework")
> >> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> >> ---
> >>   arch/riscv/net/bpf_jit_comp64.c | 33 +++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 33 insertions(+)
> >>
> >> diff --git a/arch/riscv/net/bpf_jit_comp64.c
> >> b/arch/riscv/net/bpf_jit_comp64.c
> >> index 549c3063c7f1..11ca56320a3f 100644
> >> --- a/arch/riscv/net/bpf_jit_comp64.c
> >> +++ b/arch/riscv/net/bpf_jit_comp64.c
> >> @@ -954,6 +954,33 @@ static int invoke_bpf_prog(struct bpf_tramp_link
> >> *l, int args_off, int retval_of
> >>       return ret;
> >>   }
> >> +/*
> >> + * Sign-extend the register if necessary
> >> + */
> >> +static int sign_extend(struct rv_jit_context *ctx, int r, u8 size)
> >> +{
> >> +    switch (size) {
> >> +    case 1:
> >> +        emit_slli(r, r, 56, ctx);
> >> +        emit_srai(r, r, 56, ctx);
> >> +        break;
> >> +    case 2:
> >> +        emit_slli(r, r, 48, ctx);
> >> +        emit_srai(r, r, 48, ctx);
> >> +        break;
> >> +    case 4:
> >> +        emit_addiw(r, r, 0, ctx);
> >> +        break;
> >> +    case 8:
> >> +        break;
> >> +    default:
> >> +        pr_err("bpf-jit: invalid size %d for sign_extend\n", size);
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    return 0;
> >> +}
>
> We don't need to sign-ext when return value is 1 or 2 bytes. As for 4

Could you please elaborate more on this ?
IIUC, addiw on 1 byte / 2 byte values is equivalent to zext them.

> bytes, we have already do that in __build_epilogue. So we only need to
> take care of 8 bytes return value. And the real fix would be:
>
> diff --git a/arch/riscv/net/bpf_jit_comp64.c
> b/arch/riscv/net/bpf_jit_comp64.c
> index 2f7188e0340a..08cc641f8b7c 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1177,6 +1177,9 @@ static int __arch_prepare_bpf_trampoline(struct
> bpf_tramp_image *im,
>          if (save_ret) {
>                  emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
>                  emit_ld(regmap[BPF_REG_0], -(retval_off - 8),
> RV_REG_FP, ctx);
> +               /* Do not truncate return value when it's 8 bytes */
> +               if (is_struct_ops && m->ret_size =3D=3D 8)
> +                       emit_mv(RV_REG_A0, regmap[BPF_REG_0], ctx);
>          }
>
>          emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
>
> >> +
> >>   static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
> >>                        const struct btf_func_model *m,
> >>                        struct bpf_tramp_links *tlinks,
> >> @@ -1177,6 +1204,12 @@ static int __arch_prepare_bpf_trampoline(struct
> >> bpf_tramp_image *im,
> >>       if (save_ret) {
> >>           emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
> >>           emit_ld(regmap[BPF_REG_0], -(retval_off - 8), RV_REG_FP, ctx=
);
> >> +        if (is_struct_ops) {
> >> +            emit_mv(RV_REG_A0, regmap[BPF_REG_0], ctx);
> >> +            ret =3D sign_extend(ctx, RV_REG_A0, m->ret_size);
> >> +            if (ret)
> >> +                goto out;
> >> +        }
> >>       }
> >>       emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);

