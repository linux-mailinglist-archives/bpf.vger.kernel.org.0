Return-Path: <bpf+bounces-457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD32701218
	for <lists+bpf@lfdr.de>; Sat, 13 May 2023 00:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E181C212D4
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 22:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2760363C0;
	Fri, 12 May 2023 22:16:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABCE261E8
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 22:16:16 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5595F1985
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 15:16:15 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so93556252a12.0
        for <bpf@vger.kernel.org>; Fri, 12 May 2023 15:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683929774; x=1686521774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gboKqT7DKoC+0s9mP+hZB7TU0Gq5bAtx5NydTVc50kg=;
        b=L2HoSWCgW0z/yww2MLSo4Zdiuhbcno5YSv5xnbzGabyVTu2Y93FIqcexXmgEn414KW
         LVts+5IypaEXgj/NkJX6iKiGogvNtOm7i8Hc58HB0TTzJuBQAqXki/yDQctIzCQv5X5v
         gYgNubdmcfrJai4yP0smaGXeZ/T1qwcNOVoTA+zEJ+gB+IMc/EJsFGcgr0V8OWfbPun7
         8g25fzYOCd34sZviyk5Qvr+A4oo0AFKY561arorVPArMyEQ7pMYQ7QjPR9vaMNA2UKrv
         NhkY4t4XZx2LyyY3BS1QpC9tFy1xNpeQ1zn1lgucbo9jbcVo3Ftj5wY0HBRoEDVy/tc4
         ccJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683929774; x=1686521774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gboKqT7DKoC+0s9mP+hZB7TU0Gq5bAtx5NydTVc50kg=;
        b=ICJZ8JGF8Vb4Gdzn1QE2vdNYwseu/UyMOyZflbTDZqNL3mBj2gU8ugda/B7ZPRe8R2
         KUN2V9FXmYWJRPQykrerqsl9eFAqOq347KzTCdnb9pHDtvaVNMif/sFkZSmiM6kZPD99
         W/ELHoSDIS2Sbx2IwfUvjobjfjnrmv9cjYeYQj71aT+A/sN6+K6qy0SZwdVwL7tUwmSy
         qNerExibF8OC7RLGQvJb4ErRqFRo8HvH/wLLfM2mT9An52luin1JLL0y4AAP7xKm06q8
         KSQADtRWxTdoV3E37i+LB/CqZQRkyJcKBA5epb8Ec62iwIjIz+/7OpqPPDrPoBD5BU9m
         Snqg==
X-Gm-Message-State: AC+VfDwxrBdMfJBJT/Zt/w5LDMJuMRSmNk/rqYMZcKQQHLkZ1Hy0rxg+
	wDbyWQLJHIyLqhkU41NnNrT+hl1Huk98ojknuSd1hH+YiFE=
X-Google-Smtp-Source: ACHHUZ7oyh7HeX7XD6vPLvn0jdqFC1Cd3t1lz42Jw22fBaCMv3jXS8IXM8G6oUWBXMckCLM2TE4kw7SUE2YCCrntAyM=
X-Received: by 2002:a17:907:160a:b0:96a:1348:94fb with SMTP id
 hb10-20020a170907160a00b0096a134894fbmr11028677ejc.28.1683929773531; Fri, 12
 May 2023 15:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQKs-0C_VLBZi9F68WgoNeDy_UOJ2QY5O+xcPr1u3sX8+w@mail.gmail.com>
In-Reply-To: <CAADnVQKs-0C_VLBZi9F68WgoNeDy_UOJ2QY5O+xcPr1u3sX8+w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 12 May 2023 15:16:01 -0700
Message-ID: <CAEf4BzY9gD5Pb2yQZn1pfg8T3r6izp3LnoBpisArdfu=X-8O2g@mail.gmail.com>
Subject: Re: verifier backtracking bug
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 12, 2023 at 11:55=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Andrii,
>
> Here is what I see on the latest bpf-next:
>
>  ./test_progs -t global_funcs
> [    7.969549] bpf_testmod: loading out-of-tree module taints kernel.
> [    7.979444] ------------[ cut here ]------------
> [    7.979812] verifier backtracking bug
> [    7.979828] WARNING: CPU: 1 PID: 2026 at kernel/bpf/verifier.c:3500
> __mark_chain_precision+0xd8d/0xda0
> [    7.980818] Modules linked in: bpf_testmod(O)
> [    7.981161] CPU: 1 PID: 2026 Comm: test_progs Tainted: G
> O       6.3.0-07968-g7b99f75942da #4614
> [    7.981876] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> [    7.982732] RIP: 0010:__mark_chain_precision+0xd8d/0xda0
> [    7.983140] Code: ff e9 fb f4 ff ff 80 3d e2 c5 50 02 00 0f 85 15
> fd ff ff 48 c7 c7 fe 5b 5c 82 4c 89 0c 24 c6 05 ca c5 50 02 01 e8 b3
> ed e8 ff <0f> 0b 4c 8b 0c 24 e9 f3 fc ff ff 0f4
> [    7.984523] RSP: 0018:ffffc90002bb78f0 EFLAGS: 00010282
> [    7.984918] RAX: 0000000000000019 RBX: ffff88810137c000 RCX: 000000000=
0000002
> [    7.985467] RDX: 0000000080000002 RSI: ffffffff825bda2c RDI: 00000000f=
fffffff
> [    7.986011] RBP: 00000000ffffffff R08: 0000000000000000 R09: c0000000f=
ffeffff
> [    7.986553] R10: 0000000000000001 R11: ffffc90002bb77a8 R12: 000000000=
000001b
> [    7.987093] R13: 0000000000000002 R14: 0000000000000010 R15: 000000000=
000001c
> [    7.987641] FS:  00007f7bd27d7400(0000) GS:ffff888237a40000(0000)
> knlGS:0000000000000000
> [    7.988254] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    7.988687] CR2: 000000000511e078 CR3: 000000010512f005 CR4: 000000000=
03706e0
> [    7.989228] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [    7.989765] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [    7.990306] Call Trace:
> [    7.990500]  <TASK>
> [    7.990668]  ? check_helper_mem_access+0xf9/0x2a0
> [    7.991035]  ? btf_type_name+0x20/0x20
> [    7.991329]  ? find_kfunc_desc_btf.part.106+0x210/0x210
> [    7.991723]  check_stack_write_fixed_off+0x437/0x610
> [    7.992113]  ? lock_acquire+0x15c/0x290
> [    7.992416]  ? adjust_reg_min_max_vals+0xdf/0x1070
> [    7.992778]  ? __kmem_cache_alloc_node+0x41/0x530
> [    7.993140]  ? check_ptr_alignment+0x7d/0x210
> [    7.993479]  ? lock_release+0x1b7/0x250
> [    7.993774]  check_mem_access+0x8fc/0x1750
>
> Looks like my earlier suggestion to do:
> WARN_ONCE(idx + 1 !=3D subseq_idx, "verifier backtracking bug");
>
> is tripping on something.

Interesting... I did check dmesg after adding this check, strange.
I'll try to repro later today and see what's up, thanks for heads up!

