Return-Path: <bpf+bounces-34420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D3D92D849
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C608D1C20C1F
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD221953AD;
	Wed, 10 Jul 2024 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlIsTFPf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D17257D
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636335; cv=none; b=GQ4liMFQ24sTBuJ7lBQPB2yoPdLCVKYn0EnjOsnxm4I+aL6eg/sNYleJA+dXld6ySDkj44NU/+r2/2GlKh0onaWiP6hrj8ECKn7HpIbQdmwCYQJ4lCaWCDHSOohcDzbQzpkp+kS4E9rqd9g6InYpQOM1+LzkuxP+mmOpZ8Xu17c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636335; c=relaxed/simple;
	bh=ukrorUG0AdDgPBcFEiZ4A8IF+S84OpPCoFxEvw0RXCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFwF25bX7QjnVxAhuH63w/M4NZP4nG6J4uZ7WaYs4XkZ6HBMIS6w538yPm0dPHg52Rx3VpUPS1OuiSMrLC5fnnp7ex6Hp5jCP+PvbKdqZMSUCUIzGU9ailI+Ov+Y4WhRqURk44JSxLDu+ACy0SNGLmaiWsiqRi3rD5FHo2gZ9Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlIsTFPf; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ea2b6a9f5so111793e87.0
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 11:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720636332; x=1721241132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REAoqYyZ+GbwlX/kWSIbDdIfd9m9ddOefMYT9mL6PqM=;
        b=IlIsTFPf1a8XsgzM12XaKfxVkDrkaBnkiIKf+E+qRJsKyFdvRxC+IVvvxBeIyLSJ5g
         ZuXTIGSV+3oxGv7zmTIPP2jUMy79lYj1EBPBDVxoFUVnpmW1DYRYVhpR2LfZRxQQJ24G
         OylFIPUV6AVMhgC/h+wHtHE9GjYtLlcc2SfmtT9lkli5saV9NcARfq09JGsVnhlGE955
         YZ5/DYwAhlxGNxg1lFq2waMFLWPapsT1qGgOkG6csqbQX3vfIbu21Sbzw/wq5Zqylxr8
         w+3Ymb5Nooj1BN54B6EhjjlcDT2Q+aXR9ejvHxqxhIzH95cydYyaSvpqb5WhWdXxn7Ow
         mBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720636332; x=1721241132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REAoqYyZ+GbwlX/kWSIbDdIfd9m9ddOefMYT9mL6PqM=;
        b=JDpkpxA7TQdmtuz/rt+RN7P0WMAfsKNfdayQa2L0Fb1S901WRjtCdOKugOBVWHDTPe
         NkbfRAEEfUxxDTQmN2Xtol3Q++cYtwZf4tPrUPavrjBwTBk91Ij8HjRO7hR+zaxBBYUt
         9zy7kexNofWyP0+zn8aIuxoGOdwnlDM0xKq4OFX8GN9F584TncWkdvQoB0WqJA4wU/ug
         ubo/lIlQzduzNrvyrxIVihmzD5DNG54GCYyyLWah3m49y2TsrvNpGfeMfqaBfWKS5e6Y
         cDPamAgWbuhsNaCyIVkkYd2coYkIyqoVnaJCoVZc+/vZ2wK+O7bIjL4O0rKUV9FXzmdf
         njkQ==
X-Gm-Message-State: AOJu0YzBOlLpk8r7zd3ojDDh1bKQCNpAA8VGvapQlphKwzRSvt2KX17J
	7KIKSTUx7aM69txgwSlAJ/Ilr09WKludtZFT6/bPAyDlbv3yzwQrU042dt9rlhs1zBpY2U/Y157
	YXSEt509aG6T8ZU7cVpr8xJtmxPY=
X-Google-Smtp-Source: AGHT+IGOPt5vxfNDBvnKDjRn6fsiBWZzXq0kwUMgoRJBOmjUrdOMb5dIpcYe5/H8ov8GSI7V2qlufvE5i//GV7N4+40=
X-Received: by 2002:a05:6512:b11:b0:52c:8591:1f7b with SMTP id
 2adb3069b0e04-52eb9997315mr4485208e87.24.1720636331968; Wed, 10 Jul 2024
 11:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710092904.3438141-1-wutengda@huaweicloud.com> <20240710092904.3438141-2-wutengda@huaweicloud.com>
In-Reply-To: <20240710092904.3438141-2-wutengda@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Jul 2024 11:32:00 -0700
Message-ID: <CAADnVQLSEwCsiJndH-Zpio2E1M29UQFwV53OCiqyx5S9n-+-Vw@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/3] bpf: Fix null pointer dereference in
 resolve_prog_type() for BPF_PROG_TYPE_EXT
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Leon Hwang <hffilwlqm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 2:29=E2=80=AFAM Tengda Wu <wutengda@huaweicloud.com=
> wrote:
>
> When loading a EXT program without specifying `attr->attach_prog_fd`,
> the `prog->aux->dst_prog` will be null. At this time, calling
> resolve_prog_type() anywhere will result in a null pointer dereference.
>
> Example stack trace:
>
> [    8.107863] Unable to handle kernel NULL pointer dereference at virtua=
l address 0000000000000004
> [    8.108262] Mem abort info:
> [    8.108384]   ESR =3D 0x0000000096000004
> [    8.108547]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [    8.108722]   SET =3D 0, FnV =3D 0
> [    8.108827]   EA =3D 0, S1PTW =3D 0
> [    8.108939]   FSC =3D 0x04: level 0 translation fault
> [    8.109102] Data abort info:
> [    8.109203]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
> [    8.109399]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> [    8.109614]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> [    8.109836] user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000010135400=
0
> [    8.110011] [0000000000000004] pgd=3D0000000000000000, p4d=3D000000000=
0000000
> [    8.112624] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [    8.112783] Modules linked in:
> [    8.113120] CPU: 0 PID: 99 Comm: may_access_dire Not tainted 6.10.0-rc=
3-next-20240613-dirty #1
> [    8.113230] Hardware name: linux,dummy-virt (DT)
> [    8.113390] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [    8.113429] pc : may_access_direct_pkt_data+0x24/0xa0
> [    8.113746] lr : add_subprog_and_kfunc+0x634/0x8e8
> [    8.113798] sp : ffff80008283b9f0
> [    8.113813] x29: ffff80008283b9f0 x28: ffff800082795048 x27: 000000000=
0000001
> [    8.113881] x26: ffff0000c0bb2600 x25: 0000000000000000 x24: 000000000=
0000000
> [    8.113897] x23: ffff0000c1134000 x22: 000000000001864f x21: ffff0000c=
1138000
> [    8.113912] x20: 0000000000000001 x19: ffff0000c12b8000 x18: fffffffff=
fffffff
> [    8.113929] x17: 0000000000000000 x16: 0000000000000000 x15: 072007200=
7200720
> [    8.113944] x14: 0720072007200720 x13: 0720072007200720 x12: 072007200=
7200720
> [    8.113958] x11: 0720072007200720 x10: 0000000000f9fca4 x9 : ffff80008=
021f4e4
> [    8.113991] x8 : 0101010101010101 x7 : 746f72705f6d656d x6 : 000000001=
e0e0f5f
> [    8.114006] x5 : 000000000001864f x4 : ffff0000c12b8000 x3 : 000000000=
000001c
> [    8.114020] x2 : 0000000000000002 x1 : 0000000000000000 x0 : 000000000=
0000000
> [    8.114126] Call trace:
> [    8.114159]  may_access_direct_pkt_data+0x24/0xa0
> [    8.114202]  bpf_check+0x3bc/0x28c0
> [    8.114214]  bpf_prog_load+0x658/0xa58
> [    8.114227]  __sys_bpf+0xc50/0x2250
> [    8.114240]  __arm64_sys_bpf+0x28/0x40
> [    8.114254]  invoke_syscall.constprop.0+0x54/0xf0
> [    8.114273]  do_el0_svc+0x4c/0xd8
> [    8.114289]  el0_svc+0x3c/0x140
> [    8.114305]  el0t_64_sync_handler+0x134/0x150
> [    8.114331]  el0t_64_sync+0x168/0x170
> [    8.114477] Code: 7100707f 54000081 f9401c00 f9403800 (b9400403)
> [    8.118672] ---[ end trace 0000000000000000 ]---
>
> Fix this by adding dst_prog non-empty check in BPF_PROG_TYPE_EXT case
> when bpf_prog_load().
>
> Fixes: 4a9c7bbe2ed4 ("bpf: Resolve to prog->aux->dst_prog->type only for =
BPF_PROG_TYPE_EXT")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> Cc: stable@vger.kernel.org # v5.18+
> Acked-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>  kernel/bpf/syscall.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index f45ed6adc092..4490f8ccf006 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2632,9 +2632,12 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog=
_type,
>                         return 0;
>                 return -EINVAL;
>         case BPF_PROG_TYPE_SYSCALL:
> -       case BPF_PROG_TYPE_EXT:
>                 if (expected_attach_type)
>                         return -EINVAL;
> +               return 0;
> +       case BPF_PROG_TYPE_EXT:
> +               if (expected_attach_type || !dst_prog)
> +                       return -EINVAL;

Hold on.
This is api breaking without corresponding libbpf patch 2, right?

We cannot do this. Find a different way to fix it.
pw-bot: cr

