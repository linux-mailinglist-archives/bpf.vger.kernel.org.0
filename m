Return-Path: <bpf+bounces-43756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EE69B974C
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBEBF1F21158
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 18:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5940A1CDFD5;
	Fri,  1 Nov 2024 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQezWCyj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B778314F132;
	Fri,  1 Nov 2024 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485188; cv=none; b=DQOP59zLURJ1V6N8D5Q1BbbTokdHFol/f/KAMjeX9n8U0QMGMPmB80J6QG6Lsj0wgMHBPfi6dU82Z3DzgWgvQQvPHRBuhQE+uacEu/T2xB0sUDccwcvbQV6JnaTcNETLab4enE7gW+prCaXYXOpHfuvRLc04C2YSti0EIKOb9HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485188; c=relaxed/simple;
	bh=Xlx80OHM/nFQ0Zlp0buXfWmMb/dekTNqB0d7w3gzRDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjVbc4HP/W0Rr7SQw930ViIxyLMm64zAt3gbsSA+msjnundy70PboM3qUNeBZmqbwKxCdUzpiAs9cTYll8DAr+uySzEQhm64wDvPml6jRUXC1gRrstxgHMc9/fzirNbpLtn27qJB3QiNcTvVojf0iCHJS65dXg2sRXy0alKFe3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQezWCyj; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d5aedd177so1440555f8f.1;
        Fri, 01 Nov 2024 11:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730485185; x=1731089985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGIPIgsp0YCzm1xKxhBFsZpsfwk7oYFguOfrieP3fhc=;
        b=XQezWCyjqfMs9jsApF0PdOqYAmMxIBymXjAfcHf2sGQqvNyZx1bdIjxqrGLd0fpYTm
         bKshJaE3rglCRuBjO1at1EHDF9AdIj/mAYC+2s/RG+ld2jE8sctVlZz0yNzA/RgueyRt
         bLmpRZMI/0BeBQTAL2ODrn2pbx8fnYA7NYAWJWBjtyBASu78bAdDN3JJGtnNblS7dF/n
         EYNJcGcWvTkXrR+IhAAoPtxUgRwBRgS3QQzCLz+Sb50pKRH1bWWNFBDIukKSXEy7C1jJ
         xfoypP9vG1HIMlunVwnHQiIIRHqC7BzeLnWcjle4Wg0ZbYWrljThce4wQmXPqFv6dPi7
         d8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730485185; x=1731089985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGIPIgsp0YCzm1xKxhBFsZpsfwk7oYFguOfrieP3fhc=;
        b=HxYUBodDWdVYVrYhSIFknKzVEsGp/lPAFA+lvMoWzrcxLbpuAEGPZ+UGmlEDntDX3u
         kI2LmnNMRTUxE6RDBDYVhA65SuPQzSMmzVJfNXrs/K+2ycZRNr89Qj0x+wN8JR+UlE/4
         tplHnvXBN8d91glJF/Rz7/vVo74jZDWE8YldmqqjIxWdHtQiYmImXnMtwTYvdx+jsuqO
         ReWBP8pQZA7ZNrq3FHCffxgchmOQp5a5+QYpTAVL14JfWztHktjyynSMM6OSpf98BLIR
         ZhAI6FM8kderI84QizZ3RIXHEmZHDYjX84V5aeE+MM7Urj6SEgCJbbYrSdu5i0OZI4fn
         pO4w==
X-Forwarded-Encrypted: i=1; AJvYcCXu8zGj9kQ4bGACxM++f5sHE4U1k443coJD4BwiKG4qbYwiBJwkjS/nj6vH/J79eMm/Ry87ho0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDB8pZhEb6ZzR7hhtjL31vaR+kX18AwP/g2VBUv6pRzwxoabP7
	35MsYEemW3vMBPNkc93SW7FZor+H9Qj/0YVX0g/W8L9axrmHsDPiYzosobIixBfHo3I8sCxBG4m
	xVQ9YazpKLdZBt1Mzmwt68oVj+KU=
X-Google-Smtp-Source: AGHT+IHo/zLODZW2bz1i8LemWLuXOkL9F/OlVQvvyuzPUjAmsW052VPNuuWKHmZsHCewUjmP80u+TELykBeuhl+1qGg=
X-Received: by 2002:a05:6000:188f:b0:37d:4e74:67c with SMTP id
 ffacd0b85a97d-381be906ceemr6241408f8f.39.1730485184738; Fri, 01 Nov 2024
 11:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101111948.1570547-1-xukuohai@huaweicloud.com>
In-Reply-To: <20241101111948.1570547-1-xukuohai@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Nov 2024 11:19:32 -0700
Message-ID: <CAADnVQKnJkJpWkuxC32UPc4cvTnT2+YEnm8TktrEnDNO7ZbCdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Add kernel symbol for struct_ops trampoline
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Kui-Feng Lee <thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 4:08=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com>=
 wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> Without kernel symbols for struct_ops trampoline, the unwinder may
> produce unexpected stacktraces.
>
> For example, the x86 ORC and FP unwinders check if an IP is in kernel
> text by verifying the presence of the IP's kernel symbol. When a
> struct_ops trampoline address is encountered, the unwinder stops due
> to the absence of symbol, resulting in an incomplete stacktrace that
> consists only of direct and indirect child functions called from the
> trampoline.
>
> The arm64 unwinder is another example. While the arm64 unwinder can
> proceed across a struct_ops trampoline address, the corresponding
> symbol name is displayed as "unknown", which is confusing.
>
> Thus, add kernel symbol for struct_ops trampoline. The name is
> bpf_trampoline_<PROG_NAME>, where PROG_NAME is the name of the
> struct_ops prog linked to the trampoline.
>
> Below is a comparison of stacktraces captured on x86 by perf record,
> before and after this patch.
>
> Before:
>
> ... FP chain: nr:4
> .....  0: ffffffffffffff80 # PERF_CONTEXT_KERNEL mark
> .....  1: ffffffff8116545d
> .....  2: ffffffff81167fcc
> .....  3: ffffffff813088f4
>  ... thread: iperf:595
>  ...... dso: /proc/kcore
> iperf     595 [002]  9015.616291:     824245  cycles:
>         ffffffff8116545d __lock_acquire+0xad ([kernel.kallsyms])
>         ffffffff81167fcc lock_acquire+0xcc ([kernel.kallsyms])
>         ffffffff813088f4 __bpf_prog_enter+0x34 ([kernel.kallsyms])
>
> After:
>
> ... FP chain: nr:44
> .....  0: ffffffffffffff80 # PERF_CONTEXT_KERNEL mark
> .....  1: ffffffff81165930
> .....  2: ffffffff81167fcc
> .....  3: ffffffff813088f4
> .....  4: ffffffffc000da5e
> .....  5: ffffffff81f243df
> .....  6: ffffffff81f27326
> .....  7: ffffffff81f3a3c3
> .....  8: ffffffff81f3c99b
> .....  9: ffffffff81ef9870
> ..... 10: ffffffff81ef9b13
> ..... 11: ffffffff81ef9c69
> ..... 12: ffffffff81ef9f47
> ..... 13: ffffffff81efa15d
> ..... 14: ffffffff81efa9c0
> ..... 15: ffffffff81d979eb
> ..... 16: ffffffff81d987e8
> ..... 17: ffffffff81ddce16
> ..... 18: ffffffff81bc7b90
> ..... 19: ffffffff81bcf677
> ..... 20: ffffffff81bd1b4f
> ..... 21: ffffffff81d99693
> ..... 22: ffffffff81d99a52
> ..... 23: ffffffff810c9eb2
> ..... 24: ffffffff810ca631
> ..... 25: ffffffff822367db
> ..... 26: ffffffff824015ef
> ..... 27: ffffffff811678e6
> ..... 28: ffffffff814f7d85
> ..... 29: ffffffff814f8119
> ..... 30: ffffffff81492fb9
> ..... 31: ffffffff81355c53
> ..... 32: ffffffff813d79d7
> ..... 33: ffffffff813d88fc
> ..... 34: ffffffff8139a52e
> ..... 35: ffffffff8139a661
> ..... 36: ffffffff8152c193
> ..... 37: ffffffff8152cbc5
> ..... 38: ffffffff814a5908
> ..... 39: ffffffff814a72d3
> ..... 40: ffffffff814a758b
> ..... 41: ffffffff81008869
> ..... 42: ffffffff822323e8
> ..... 43: ffffffff8240012f

The above is a visual noise.
Pls remove such addr dumps from the commit log.
The below part is enough.

>  ... thread: sleep:493
>  ...... dso: /proc/kcore
> sleep     493 [000]    55.483168:     410428  cycles:
>         ffffffff81165930 __lock_acquire+0x580 ([kernel.kallsyms])
>         ffffffff81167fcc lock_acquire+0xcc ([kernel.kallsyms])
>         ffffffff813088f4 __bpf_prog_enter+0x34 ([kernel.kallsyms])
>         ffffffffc000da5e bpf_trampoline_bpf_prog_075f577900bac1d2_bpf_cub=
ic_acked+0x3a ([kernel.kallsyms])
>         ffffffff81f243df tcp_ack+0xd4f ([kernel.kallsyms])
>         ffffffff81f27326 tcp_rcv_established+0x3b6 ([kernel.kallsyms])
>         ffffffff81f3a3c3 tcp_v4_do_rcv+0x193 ([kernel.kallsyms])
>         ffffffff81f3c99b tcp_v4_rcv+0x11fb ([kernel.kallsyms])
>         ffffffff81ef9870 ip_protocol_deliver_rcu+0x50 ([kernel.kallsyms])
>         ffffffff81ef9b13 ip_local_deliver_finish+0xb3 ([kernel.kallsyms])
>         ffffffff81ef9c69 ip_local_deliver+0x79 ([kernel.kallsyms])
>         ffffffff81ef9f47 ip_sublist_rcv_finish+0xb7 ([kernel.kallsyms])
>         ffffffff81efa15d ip_sublist_rcv+0x18d ([kernel.kallsyms])
>         ffffffff81efa9c0 ip_list_rcv+0x110 ([kernel.kallsyms])
>         ffffffff81d979eb __netif_receive_skb_list_core+0x21b ([kernel.kal=
lsyms])
>         ffffffff81d987e8 netif_receive_skb_list_internal+0x208 ([kernel.k=
allsyms])
>         ffffffff81ddce16 napi_gro_receive+0xf6 ([kernel.kallsyms])
>         ffffffff81bc7b90 virtnet_receive_done+0x340 ([kernel.kallsyms])
>         ffffffff81bcf677 receive_buf+0xd7 ([kernel.kallsyms])
>         ffffffff81bd1b4f virtnet_poll+0xcbf ([kernel.kallsyms])
>         ffffffff81d99693 __napi_poll.constprop.0+0x33 ([kernel.kallsyms])
>         ffffffff81d99a52 net_rx_action+0x1c2 ([kernel.kallsyms])
>         ffffffff810c9eb2 handle_softirqs+0xe2 ([kernel.kallsyms])
>         ffffffff810ca631 irq_exit_rcu+0x91 ([kernel.kallsyms])
>         ffffffff822367db sysvec_apic_timer_interrupt+0x9b ([kernel.kallsy=
ms])
>         ffffffff824015ef asm_sysvec_apic_timer_interrupt+0x1f ([kernel.ka=
llsyms])
>         ffffffff811678e6 lock_release+0x186 ([kernel.kallsyms])
>         ffffffff814f7d85 prepend_path+0x395 ([kernel.kallsyms])
>         ffffffff814f8119 d_path+0x159 ([kernel.kallsyms])
>         ffffffff81492fb9 file_path+0x19 ([kernel.kallsyms])
>         ffffffff81355c53 perf_event_mmap+0x1e3 ([kernel.kallsyms])
>         ffffffff813d79d7 mmap_region+0x2e7 ([kernel.kallsyms])
>         ffffffff813d88fc do_mmap+0x4ec ([kernel.kallsyms])
>         ffffffff8139a52e vm_mmap_pgoff+0xde ([kernel.kallsyms])
>         ffffffff8139a661 vm_mmap+0x31 ([kernel.kallsyms])
>         ffffffff8152c193 elf_load+0xa3 ([kernel.kallsyms])
>         ffffffff8152cbc5 load_elf_binary+0x655 ([kernel.kallsyms])
>         ffffffff814a5908 bprm_execve+0x2a8 ([kernel.kallsyms])
>         ffffffff814a72d3 do_execveat_common.isra.0+0x193 ([kernel.kallsym=
s])
>         ffffffff814a758b __x64_sys_execve+0x3b ([kernel.kallsyms])
>         ffffffff81008869 x64_sys_call+0x1399 ([kernel.kallsyms])
>         ffffffff822323e8 do_syscall_64+0x68 ([kernel.kallsyms])
>         ffffffff8240012f entry_SYSCALL_64_after_hwframe+0x76 ([kernel.kal=
lsyms])
>
> Fixes: 85d33df357b6 ("bpf: Introduce BPF_MAP_TYPE_STRUCT_OPS")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> ---
> v2:
> Refine the commit message for clarity and fix a test bot warning
>
> v1:
> https://lore.kernel.org/bpf/20241030111533.907289-1-xukuohai@huaweicloud.=
com/
> ---
>  include/linux/bpf.h         |  3 +-
>  kernel/bpf/bpf_struct_ops.c | 67 +++++++++++++++++++++++++++++++++++++
>  kernel/bpf/dispatcher.c     |  3 +-
>  kernel/bpf/trampoline.c     |  9 +++--
>  4 files changed, 78 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index c3ba4d475174..46f8d6c1a55c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1402,7 +1402,8 @@ int arch_prepare_bpf_dispatcher(void *image, void *=
buf, s64 *funcs, int num_func
>  void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_pro=
g *from,
>                                 struct bpf_prog *to);
>  /* Called only from JIT-enabled code, so there's no need for stubs. */
> -void bpf_image_ksym_add(void *data, unsigned int size, struct bpf_ksym *=
ksym);
> +void bpf_image_ksym_init(void *data, unsigned int size, struct bpf_ksym =
*ksym);
> +void bpf_image_ksym_add(struct bpf_ksym *ksym);
>  void bpf_image_ksym_del(struct bpf_ksym *ksym);
>  void bpf_ksym_add(struct bpf_ksym *ksym);
>  void bpf_ksym_del(struct bpf_ksym *ksym);
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index fda3dd2ee984..172a081ed1c3 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -38,6 +38,9 @@ struct bpf_struct_ops_map {
>          * that stores the func args before calling the bpf_prog.
>          */
>         void *image_pages[MAX_TRAMP_IMAGE_PAGES];
> +       u32 ksyms_cnt;
> +       /* ksyms for bpf trampolines */
> +       struct bpf_ksym *ksyms;
>         /* The owner moduler's btf. */
>         struct btf *btf;
>         /* uvalue->data stores the kernel struct
> @@ -586,6 +589,35 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tra=
mp_links *tlinks,
>         return 0;
>  }
>
> +static void bpf_struct_ops_ksym_init(struct bpf_prog *prog, void *image,
> +                                    unsigned int size, struct bpf_ksym *=
ksym)
> +{
> +       int n;
> +
> +       n =3D strscpy(ksym->name, "bpf_trampoline_", KSYM_NAME_LEN);
> +       strncat(ksym->name + n, prog->aux->ksym.name, KSYM_NAME_LEN - 1 -=
 n);
> +       INIT_LIST_HEAD_RCU(&ksym->lnode);
> +       bpf_image_ksym_init(image, size, ksym);
> +}
> +
> +static void bpf_struct_ops_map_ksyms_add(struct bpf_struct_ops_map *st_m=
ap)
> +{
> +       struct bpf_ksym *ksym =3D st_map->ksyms;
> +       struct bpf_ksym *end =3D ksym + st_map->ksyms_cnt;
> +
> +       while (ksym !=3D end && ksym->start)
> +               bpf_image_ksym_add(ksym++);
> +}
> +
> +static void bpf_struct_ops_map_ksyms_del(struct bpf_struct_ops_map *st_m=
ap)
> +{
> +       struct bpf_ksym *ksym =3D st_map->ksyms;
> +       struct bpf_ksym *end =3D ksym + st_map->ksyms_cnt;
> +
> +       while (ksym !=3D end && ksym->start)
> +               bpf_image_ksym_del(ksym++);
> +}
> +
>  static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *ke=
y,
>                                            void *value, u64 flags)
>  {
> @@ -601,6 +633,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf=
_map *map, void *key,
>         int prog_fd, err;
>         u32 i, trampoline_start, image_off =3D 0;
>         void *cur_image =3D NULL, *image =3D NULL;
> +       struct bpf_ksym *ksym;
>
>         if (flags)
>                 return -EINVAL;
> @@ -640,6 +673,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf=
_map *map, void *key,
>         kdata =3D &kvalue->data;
>
>         module_type =3D btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE=
_ID]);
> +       ksym =3D st_map->ksyms;
>         for_each_member(i, t, member) {
>                 const struct btf_type *mtype, *ptype;
>                 struct bpf_prog *prog;
> @@ -735,6 +769,11 @@ static long bpf_struct_ops_map_update_elem(struct bp=
f_map *map, void *key,
>
>                 /* put prog_id to udata */
>                 *(unsigned long *)(udata + moff) =3D prog->aux->id;
> +
> +               /* init ksym for this trampoline */
> +               bpf_struct_ops_ksym_init(prog, image + trampoline_start,
> +                                        image_off - trampoline_start,
> +                                        ksym++);

Thanks for the patch.
I think it's overkill to add ksym for each callsite within a single
trampoline.
1. The prog name will be next in the stack. No need to duplicate it.
2. ksym-ing callsites this way is quite unusual.
3. consider irq on other insns within a trampline.
   The unwinder won't find anything in such a case.

So I suggest to add only one ksym that covers the whole trampoline.
The name could be "bpf_trampoline_structopsname"
that is probably st_ops_desc->type.

>         }
>
>         if (st_ops->validate) {
> @@ -790,6 +829,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf=
_map *map, void *key,
>  unlock:
>         kfree(tlinks);
>         mutex_unlock(&st_map->lock);
> +       if (!err)
> +               bpf_struct_ops_map_ksyms_add(st_map);
>         return err;
>  }
>
> @@ -883,6 +924,10 @@ static void bpf_struct_ops_map_free(struct bpf_map *=
map)
>          */
>         synchronize_rcu_mult(call_rcu, call_rcu_tasks);
>
> +       /* no trampoline in the map is running anymore, delete symbols */
> +       bpf_struct_ops_map_ksyms_del(st_map);
> +       synchronize_rcu();
> +

This is substantial overhead and why ?
synchronize_rcu_mult() is right above.

pw-bot: cr

