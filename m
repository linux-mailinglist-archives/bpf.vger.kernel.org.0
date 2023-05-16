Return-Path: <bpf+bounces-663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8EB705510
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 19:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE8C281427
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 17:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35A0107A5;
	Tue, 16 May 2023 17:32:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5281E34CD4
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 17:32:57 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC53C9
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 10:32:55 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc0ced1d9so21195148a12.0
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 10:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684258374; x=1686850374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/4SMoaHB38sv6RibzVbrdilz9r9GG0k66KVZEibnX4=;
        b=Shf3wgl8uMU7ebHFxtf7GSjGyhzB122A/X+MpE0o00/EfWrt0uAEZs+jxsKhEPRB4E
         YISSa57PobNKrMGWxHYHx7taFfvJk7DAVW2jVdOX4Qk1u5iH6JyHmrQZuWGSM2Kov8xs
         daHKgBHlkDeFDkq06LVol/TrVvg1PVG4eOcsxjT4RQMM6KP49U7rU9CAn231gqqHiiKf
         Xpw2QC5UfTrtC5PHSpxmXuPoaxIqOmfPkOg/GqS/cdF0IGtDCIVWmxw7OawmOfxdK7Jh
         Ge6qzlu+H5LY4TcIDpJt0fZoP/PWSArkvTuSdCvBXhEOB1CyC3jadsraQFrjIq4u8jjj
         DOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684258374; x=1686850374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/4SMoaHB38sv6RibzVbrdilz9r9GG0k66KVZEibnX4=;
        b=l5naMRxlehUQGMkTtkIrISO4+JuoCUbZZ1XbY66m97GJgJd75OtUq0k8NMDwpgwqrk
         w3mstKG0Xek1icsxnsp63KLTeOsTIQDfSEyRHAQ1A01d95jRSIaT1uACLJRh55NEjbDD
         ZHLsRzHp7oGYfwPwZE+PcEPAKC0ol/jDq5YVR4F49zoshvOXDUaQwI/tMQ2Ihn0bcH21
         bIlUxSAc1Mzr5DMnSNfvFRtLATAgqDkE+y0GpvUCevkq8kU8iiHCbvr7TpbvY8P+47wG
         txXt/2Da8jndEsZx1uNas1dt3eOpceCPlCQcUIcbZRPsxrh5K1NGffY8aiLnewK/xXY+
         ZPtA==
X-Gm-Message-State: AC+VfDxJlTLsjGaSGD0Nr4+pwyQXRqJ+EdKV4+4BxBQCk01XtNR0fTdB
	P9/GVGYMnN/Hy6XBgebfDd30va/ugqCaFITqh8U=
X-Google-Smtp-Source: ACHHUZ7XYdeRDxRKsnOTs0u6q6GpyD3REanx3dJTUFh0GFTXW7RC1snMZVqduJ9iKjB2CcIaTkSrZ0FEHC9+QHOLQtk=
X-Received: by 2002:a17:906:478b:b0:96b:1608:3563 with SMTP id
 cw11-20020a170906478b00b0096b16083563mr8532190ejc.58.1684258374060; Tue, 16
 May 2023 10:32:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQKs-0C_VLBZi9F68WgoNeDy_UOJ2QY5O+xcPr1u3sX8+w@mail.gmail.com>
 <CAEf4BzY9gD5Pb2yQZn1pfg8T3r6izp3LnoBpisArdfu=X-8O2g@mail.gmail.com>
In-Reply-To: <CAEf4BzY9gD5Pb2yQZn1pfg8T3r6izp3LnoBpisArdfu=X-8O2g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 May 2023 10:32:42 -0700
Message-ID: <CAEf4BzbgqWO_ie6x+r8RFi5f1i7Ut+umYOq_MCawqB_2ErTf2w@mail.gmail.com>
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

On Fri, May 12, 2023 at 3:16=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, May 12, 2023 at 11:55=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Andrii,
> >
> > Here is what I see on the latest bpf-next:
> >
> >  ./test_progs -t global_funcs
> > [    7.969549] bpf_testmod: loading out-of-tree module taints kernel.
> > [    7.979444] ------------[ cut here ]------------
> > [    7.979812] verifier backtracking bug
> > [    7.979828] WARNING: CPU: 1 PID: 2026 at kernel/bpf/verifier.c:3500
> > __mark_chain_precision+0xd8d/0xda0
> > [    7.980818] Modules linked in: bpf_testmod(O)
> > [    7.981161] CPU: 1 PID: 2026 Comm: test_progs Tainted: G
> > O       6.3.0-07968-g7b99f75942da #4614
> > [    7.981876] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > [    7.982732] RIP: 0010:__mark_chain_precision+0xd8d/0xda0
> > [    7.983140] Code: ff e9 fb f4 ff ff 80 3d e2 c5 50 02 00 0f 85 15
> > fd ff ff 48 c7 c7 fe 5b 5c 82 4c 89 0c 24 c6 05 ca c5 50 02 01 e8 b3
> > ed e8 ff <0f> 0b 4c 8b 0c 24 e9 f3 fc ff ff 0f4
> > [    7.984523] RSP: 0018:ffffc90002bb78f0 EFLAGS: 00010282
> > [    7.984918] RAX: 0000000000000019 RBX: ffff88810137c000 RCX: 0000000=
000000002
> > [    7.985467] RDX: 0000000080000002 RSI: ffffffff825bda2c RDI: 0000000=
0ffffffff
> > [    7.986011] RBP: 00000000ffffffff R08: 0000000000000000 R09: c000000=
0fffeffff
> > [    7.986553] R10: 0000000000000001 R11: ffffc90002bb77a8 R12: 0000000=
00000001b
> > [    7.987093] R13: 0000000000000002 R14: 0000000000000010 R15: 0000000=
00000001c
> > [    7.987641] FS:  00007f7bd27d7400(0000) GS:ffff888237a40000(0000)
> > knlGS:0000000000000000
> > [    7.988254] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    7.988687] CR2: 000000000511e078 CR3: 000000010512f005 CR4: 0000000=
0003706e0
> > [    7.989228] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [    7.989765] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [    7.990306] Call Trace:
> > [    7.990500]  <TASK>
> > [    7.990668]  ? check_helper_mem_access+0xf9/0x2a0
> > [    7.991035]  ? btf_type_name+0x20/0x20
> > [    7.991329]  ? find_kfunc_desc_btf.part.106+0x210/0x210
> > [    7.991723]  check_stack_write_fixed_off+0x437/0x610
> > [    7.992113]  ? lock_acquire+0x15c/0x290
> > [    7.992416]  ? adjust_reg_min_max_vals+0xdf/0x1070
> > [    7.992778]  ? __kmem_cache_alloc_node+0x41/0x530
> > [    7.993140]  ? check_ptr_alignment+0x7d/0x210
> > [    7.993479]  ? lock_release+0x1b7/0x250
> > [    7.993774]  check_mem_access+0x8fc/0x1750
> >
> > Looks like my earlier suggestion to do:
> > WARN_ONCE(idx + 1 !=3D subseq_idx, "verifier backtracking bug");
> >
> > is tripping on something.
>
> Interesting... I did check dmesg after adding this check, strange.
> I'll try to repro later today and see what's up, thanks for heads up!

To close the loop, this was fixed in [0]. The problem was that
subseq_idx is not always preserved correctly when traversing between
states.

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20230515180710.1=
535018-1-andrii@kernel.org/

