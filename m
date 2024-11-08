Return-Path: <bpf+bounces-44366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22419C229A
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 18:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0050286F99
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 17:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4247D198E74;
	Fri,  8 Nov 2024 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coQkwOZX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36FA15B0F7;
	Fri,  8 Nov 2024 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731085271; cv=none; b=HLs6xQorooZWtoCzvPpSxrKmVTLDRlvCG/ENrIKzLpfoAHnpyCHp51yycwkG41mzZPyTuOs6JR89FXZnzmKzRXP0CaSDvoCDZV2kcIY6o3hZfsUWS8TKYkKFIhh2JpK4wzuxb17dyX6Ji28UaOxi2Y5qqgd56cYK2kRDzyZEdQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731085271; c=relaxed/simple;
	bh=rqbcV9wCDCcws9DQ3oQkl1D+Um1gTDRf7z4Fru5EYXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PS5J4H6dkq647Q135xyXRcytLLjLO5U8DvN6WUTSzFUp25Gi/jFyrxVdRLsKRoL9FxqNBrsNHU/Gb290MEUF/Hp55336mnVjO4H4zdu6NoHddHwwzHuyg1/Aw34T1pulr2r4ZvuN85EWKgjK5REqge9KC8MVdbaBZUnWpS+fY/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coQkwOZX; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so1375846f8f.2;
        Fri, 08 Nov 2024 09:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731085268; x=1731690068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsGRiYY6lf+0akGelRB5lCT1VoZAE3gNHv64XWiHQUE=;
        b=coQkwOZXccpdw5r2Oowt7ZMU+xGkPMNeuUYBed8QE7u8m7eOqxbrXcM7xVwriYG6Ti
         YxW8d7VrLZEEgoT6TF3b9vaY+aOd5VQQ53Gby65jVCY8ImOAW3wnErrRUEHe/IZuX0qv
         HTAB3LKtR0l/zsFZe7oGFqKVIJhC080ehEza+zRQn1xXGM1mMtp5tAA2KaLYb01O8eOX
         j0TSKdjZNmcgNKfgiILngkOxZUJmJa7mgieqO7pOacOUZfzJk+zP79Q5rYueoDK5hlHr
         31XvUhC5256FidKpbUjE4DuWzt4k1DXXi+OLBltnzJxHGBUugBA7w1Lb83duYhJuPStq
         9bEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731085268; x=1731690068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsGRiYY6lf+0akGelRB5lCT1VoZAE3gNHv64XWiHQUE=;
        b=QLiGpLUiFhJAfdqDA7yE7yCfAOtcJ9EpkLa9GT+HZK/5HzFwrmMKuIdpiJZ5PfwoHt
         8LRriFsOBBd4nAdEDYJ99YvO5tDap3QA1cb+xXjglDA3/C3CB0w4zqj8lN1+7j+cnISD
         vT1Hsj3VYOBuaePi69rhUjrr7XKM2F+Zf5u/akCqiG0LHVdl6aka0UkZp0r8Wxt1z+7i
         5YQ//ETMSkN9rg1iuTmDSuLNniz7HUJvPos2Rhzn1rQBYwQm/K5f87+chXM6vIAe1J1Z
         Hg9dJOlI65XrzKm90sa1gz54OE0nnUKqkqjb+rON5nwCFxaWrbnDk6RfZhnf/Mj7XP3A
         9gCg==
X-Forwarded-Encrypted: i=1; AJvYcCU7z74EVWpQTz/Nj79UF0fgTMKvnvv3fGqlGT2lC6gP1P6lECtSPmYB6FUgt8d+IUdgTf2O3rI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6eMG3kkn1W4AfGsDeYHuVzc2aruXY6cPeY4FtGOT+eUMD7K09
	aGjlfCt+8ORi0vO3k9EGy1W3MFyio+c2qiS07HNWNlU0wJJ31wSQfYFQTxT+Ps4OVBTwbcPBt4c
	DwubCdV2+IGEVWTO831TKgHXp7x1x/Q7f
X-Google-Smtp-Source: AGHT+IGHUaX2fBueTeLGBtTHX1B63DrnHF5zxU19itBBpOwA572tdi+kPUev2cUnetWRBxmmpU2T52USh4eHQMwxrMw=
X-Received: by 2002:a5d:59a9:0:b0:37c:d244:bdb1 with SMTP id
 ffacd0b85a97d-381f186c001mr2690059f8f.26.1731085267714; Fri, 08 Nov 2024
 09:01:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108082633.2338543-1-xukuohai@huaweicloud.com> <20241108082633.2338543-2-xukuohai@huaweicloud.com>
In-Reply-To: <20241108082633.2338543-2-xukuohai@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Nov 2024 09:00:56 -0800
Message-ID: <CAADnVQLFvTvg5nggOLMnV6BLpTp8K+b78ZyB3VNdV_T=Fhusmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix release of struct_ops map
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Kui-Feng Lee <thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:15=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> The test in the follow-up patch triggers the following kernel panic:
>
>  Oops: int3: 0000 [#1] PREEMPT SMP PTI
>  CPU: 0 UID: 0 PID: 465 Comm: test_progs Tainted: G           OE      6.1=
2.0-rc4-gd1d187515
>  Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0=
-ga6ed6b701f0a-pr4
>  RIP: 0010:0xffffffffc0015041
>  Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc =
cc cc cc cc cc ccc
>  RSP: 0018:ffffc9000187fd20 EFLAGS: 00000246
>  RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
>  RDX: 0000000000000000 RSI: ffffffff82c54639 RDI: 0000000000000000
>  RBP: ffffc9000187fd48 R08: 0000000000000001 R09: 0000000000000000
>  R10: 0000000000000001 R11: 000000004cba6383 R12: 0000000000000000
>  R13: 0000000000000002 R14: ffff88810438b7a0 R15: ffffffff8369d7a0
>  FS:  00007f05178006c0(0000) GS:ffff888236e00000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f0508c94000 CR3: 0000000100d16003 CR4: 0000000000170ef0
>  Call Trace:
>   <TASK>
>   ? show_regs+0x68/0x80
>   ? die+0x3b/0x90
>   ? exc_int3+0xca/0xe0
>   ? asm_exc_int3+0x3e/0x50
>   run_struct_ops+0x58/0xb0 [bpf_testmod]
>   param_attr_store+0xa2/0x100
>   module_attr_store+0x25/0x40
>   sysfs_kf_write+0x50/0x70
>   kernfs_fop_write_iter+0x146/0x1f0
>   vfs_write+0x27e/0x530
>   ksys_write+0x75/0x100
>   __x64_sys_write+0x1d/0x30
>   x64_sys_call+0x1d30/0x1f30
>   do_syscall_64+0x68/0x140
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  RIP: 0033:0x7f051831727f
>  Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 39 d5 f8 ff 48 8b 54 24 =
18 48 8b 74 24 108
>  RSP: 002b:00007f05177ffdf0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
>  RAX: ffffffffffffffda RBX: 00007f05178006c0 RCX: 00007f051831727f
>  RDX: 0000000000000002 RSI: 00007f05177ffe30 RDI: 0000000000000004
>  RBP: 00007f05177ffe90 R08: 0000000000000000 R09: 000000000000000b
>  R10: 0000000000000000 R11: 0000000000000293 R12: ffffffffffffff30
>  R13: 0000000000000002 R14: 00007ffd926bfd50 R15: 00007f0517000000
>   </TASK>
>
> It's because the sleepable prog is still running when the struct_ops
> map is released.
>
> To fix it, follow the approach used in bpf_tramp_image_put. First,
> before release struct_ops map, wait a rcu_tasks_trace gp for sleepable
> progs to finish. Then, wait a rcu_tasks gp for normal progs and the
> rest trampoline insns to finish.
>
> Additionally, switch to call_rcu to remove the synchronous waiting,
> as suggested by Alexei and Martin.
>
> Fixes: b671c2067a04 ("bpf: Retire the struct_ops map kvalue->refcnt.")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  kernel/bpf/bpf_struct_ops.c | 37 +++++++++++++++++++------------------
>  kernel/bpf/syscall.c        |  7 ++++++-
>  2 files changed, 25 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index fda3dd2ee984..dd5f9bf12791 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -865,24 +865,6 @@ static void bpf_struct_ops_map_free(struct bpf_map *=
map)
>          */
>         if (btf_is_module(st_map->btf))
>                 module_put(st_map->st_ops_desc->st_ops->owner);
> -
> -       /* The struct_ops's function may switch to another struct_ops.
> -        *
> -        * For example, bpf_tcp_cc_x->init() may switch to
> -        * another tcp_cc_y by calling
> -        * setsockopt(TCP_CONGESTION, "tcp_cc_y").
> -        * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
> -        * and its refcount may reach 0 which then free its
> -        * trampoline image while tcp_cc_x is still running.
> -        *
> -        * A vanilla rcu gp is to wait for all bpf-tcp-cc prog
> -        * to finish. bpf-tcp-cc prog is non sleepable.
> -        * A rcu_tasks gp is to wait for the last few insn
> -        * in the tramopline image to finish before releasing
> -        * the trampoline image.
> -        */
> -       synchronize_rcu_mult(call_rcu, call_rcu_tasks);
> -
>         __bpf_struct_ops_map_free(map);
>  }
>
> @@ -974,6 +956,25 @@ static struct bpf_map *bpf_struct_ops_map_alloc(unio=
n bpf_attr *attr)
>         mutex_init(&st_map->lock);
>         bpf_map_init_from_attr(map, attr);
>
> +       /* The struct_ops's function may switch to another struct_ops.
> +        *
> +        * For example, bpf_tcp_cc_x->init() may switch to
> +        * another tcp_cc_y by calling
> +        * setsockopt(TCP_CONGESTION, "tcp_cc_y").
> +        * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
> +        * and its refcount may reach 0 which then free its
> +        * trampoline image while tcp_cc_x is still running.
> +        *
> +        * Since struct_ops prog can be sleepable, a rcu_tasks_trace gp
> +        * is to wait for sleepable progs in the map to finish. Then a
> +        * rcu_tasks gp is to wait for the normal progs and the last few
> +        * insns in the tramopline image to finish before releasing the
> +        * trampoline image.
> +        *
> +        * Also see the comment in function bpf_tramp_image_put.
> +        */
> +       WRITE_ONCE(map->free_after_mult_rcu_gp, true);
> +
>         return map;
>
>  errout_free:
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 8254b2973157..ae927f087f04 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -886,7 +886,12 @@ static void bpf_map_free_rcu_gp(struct rcu_head *rcu=
)
>
>  static void bpf_map_free_mult_rcu_gp(struct rcu_head *rcu)
>  {
> -       if (rcu_trace_implies_rcu_gp())
> +       struct bpf_map *map =3D container_of(rcu, struct bpf_map, rcu);
> +
> +       if (map->map_type =3D=3D BPF_MAP_TYPE_STRUCT_OPS)
> +               /* See comment in the end of bpf_struct_ops_map_alloc */

The fix makes sense, but pls copy paste a sentence here instead
of the above comment. Like:
"
rcu_tasks gp is necessary to wait for struct_ops bpf trampoline to finish.
Unlike all other bpf trampolines struct_ops trampoline is not
protected by percpu_ref.
"
> +               call_rcu_tasks(rcu, bpf_map_free_rcu_gp);
> +       else if (rcu_trace_implies_rcu_gp())

pw-bot: cr

