Return-Path: <bpf+bounces-9041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CC778EB1F
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 12:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B222814C2
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 10:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3468F60;
	Thu, 31 Aug 2023 10:53:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788F379F8;
	Thu, 31 Aug 2023 10:53:02 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54451CFA;
	Thu, 31 Aug 2023 03:53:00 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-500913779f5so1343152e87.2;
        Thu, 31 Aug 2023 03:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693479178; x=1694083978; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H4rOM8YI6bZoN3/wKWjcyWGm1DrX/tISbIPGz/bIbCg=;
        b=m5CWUyPS+cW08mb0CUOD/Lg996k2rNI0UFA7R4MAgyN+s84ZTYWo93NRxCOIQRhAbR
         kGntbYDP6mitBh4ivGxfNNvS1DUM5lTJJnQV4aoCTjbCAV62g+wJaA6gsCzp/4oMxW9v
         IcsOMiAEPB9bLe1DfIWY7VCIcqZHs9eW48mHr98e37AZ8uy/QdVnuqkxCCNXeVrL7kfh
         ot/Q0/+uPQnlOdIK6Hx69gvhr700F9FpuVyCK0sYPl57NeKbySBM4dfydvbs/gqzMIpm
         gJIFWIvkYTfOfXPNobzYJG2eVZT0IYOhhBq/DWGmjm6NR1bZh0K/kwLUlhg+wGyyzT57
         bLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693479178; x=1694083978;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4rOM8YI6bZoN3/wKWjcyWGm1DrX/tISbIPGz/bIbCg=;
        b=gJFaJ6+snartYAFEktg1ht4RNvjaNbRTV7CDda/VS6WNyzwMA+7gsynZ9S4Vbv+1xv
         EW0iAhruACz1/woDeRenBOaFTuSeirgfxhnBWKeowoL2a49PzEzrxvqgip5BAn36lLQH
         hD0pse/lis7ATDedJ64dIgc//94ckj4n15JKlbj3mHkZujmurO2JQv43t7gxBsQ73Xm2
         6hWUChRl7ETvMIrZ2kvTd6wB58RGIxzehkn2jpWaUOksX8YZ9Qcqsf08t2oYCyFz80q0
         b9D6RrEEe5LT7jOs7N4pBSqxMivkF9fxMTAA6t2xnK1siJn8MW2uj7j2SscFsHn8F4vP
         Sg7Q==
X-Gm-Message-State: AOJu0YxRcL0K/mzGShUW1GHOe21PogrXva9Ur5zm4HajYh2N2PzNcrGK
	CGQvbzd0dgZFUJpo7uqjVfo=
X-Google-Smtp-Source: AGHT+IG3ZXCFJVqc6b7ffYVcDbLeIq0KBTkkOZaWtsAf2rMzdQbzh2ZNDpe6Iw6n5nwlluYXaLDCKQ==
X-Received: by 2002:a19:6504:0:b0:500:9a15:9054 with SMTP id z4-20020a196504000000b005009a159054mr1945177lfb.20.1693479177988;
        Thu, 31 Aug 2023 03:52:57 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id j26-20020a1709064b5a00b00988be3c1d87sm625085ejv.116.2023.08.31.03.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 03:52:57 -0700 (PDT)
Message-ID: <de816b89073544deb2ce34c4b242d583a6d4660f.camel@gmail.com>
Subject: Re: [BUG bpf-next] bpf/net: Hitting gpf when running selftests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Martin KaFai Lau
 <kafai@fb.com>,  Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Hou Tao <houtao1@huawei.com>
Date: Thu, 31 Aug 2023 13:52:55 +0300
In-Reply-To: <ZO+vetPCpOOCGitL@krava>
References: <ZO+RQwJhPhYcNGAi@krava> <ZO+vetPCpOOCGitL@krava>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-08-30 at 23:07 +0200, Jiri Olsa wrote:
> On Wed, Aug 30, 2023 at 08:58:11PM +0200, Jiri Olsa wrote:
> > hi,
> > I'm hitting crash below on bpf-next/master when running selftests,
> > full log and config attached
>=20
> it seems to be 'test_progs -t sockmap_listen' triggering that

Hi,

I hit it as well, use the following command to reproduce:

  for i in $(seq 1 100); do \
    ./test_progs -a 'sockmap_listen/sockmap VSOCK test_vsock_redir' \
    | grep Summary; \
  done

However, my backtrace is slightly different:

[   30.615412] BUG: kernel NULL pointer dereference, address: 0000000000000=
008
[   30.616114] #PF: supervisor write access in kernel mode
[   30.616114] #PF: error_code(0x0002) - not-present page
[   30.616114] PGD 0 P4D 0=20
[   30.616114] Oops: 0002 [#1] PREEMPT SMP NOPTI
[   30.616114] CPU: 2 PID: 48 Comm: kworker/2:1 Tainted: G           OE    =
  6.5.0-03968-g2e29df8dbb0c #90
[   30.616114] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.1=
5.0-1 04/01/2014
[   30.616114] Workqueue: events sk_psock_destroy
[   30.616114] RIP: 0010:skb_dequeue+0x54/0x80
[   30.616114] Code: 74 45 4c 39 e3 74 40 8b 43 10 83 e8 01 89 43 10 49 8b =
14 24 49 8b 44 24 08 49 c7 04 24 00 00 00 00 49 c7 44 24 08 00 00 00 00 <48=
> 89 42 08 48 89 10 4c 89 ef e8 7d 6f 35 00 41
[   30.616114] RSP: 0018:ffffc900001afdd0 EFLAGS: 00010097
[   30.616114] RAX: 0000000000000000 RBX: ffff8881040d39b8 RCX: 3f495367eac=
50c98
[   30.616114] RDX: 0000000000000000 RSI: 0000000000000286 RDI: ffff8881040=
d39d0
[   30.616114] RBP: ffffc900001afde8 R08: 0000000000000001 R09: 00000000000=
00001
[   30.616114] R10: 0000000000000000 R11: 0000000000000091 R12: ffff8881037=
9d000
[   30.616114] R13: ffff8881040d39d0 R14: ffff88817bd2e6c0 R15: ffff88817bd=
33905
[   30.616114] FS:  0000000000000000(0000) GS:ffff88817bd00000(0000) knlGS:=
0000000000000000
[   30.616114] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.616114] CR2: 0000000000000008 CR3: 000000010548a000 CR4: 00000000007=
50ee0
[   30.616114] PKRU: 55555554
[   30.616114] Call Trace:
[   30.616114]  <TASK>
[   30.616114]  ? show_regs+0x6e/0x80
[   30.616114]  ? __die+0x29/0x70
[   30.616114]  ? page_fault_oops+0x160/0x460
[   30.616114]  ? lock_release+0x137/0x280
[   30.616114]  ? srso_alias_return_thunk+0x5/0x7f
[   30.616114]  ? do_user_addr_fault+0x347/0x840
[   30.616114]  ? __this_cpu_preempt_check+0x17/0x20
[   30.616114]  ? srso_alias_return_thunk+0x5/0x7f
[   30.616114]  ? exc_page_fault+0x72/0x1d0
[   30.616114]  ? asm_exc_page_fault+0x2b/0x30
[   30.616114]  ? skb_dequeue+0x54/0x80
[   30.616114]  sk_psock_destroy+0x91/0x2c0
[   30.616114]  process_one_work+0x287/0x560
[   30.616114]  worker_thread+0x59/0x400
[   30.616114]  ? __pfx_worker_thread+0x10/0x10
[   30.616114]  kthread+0x118/0x150
[   30.616114]  ? __pfx_kthread+0x10/0x10
[   30.616114]  ret_from_fork+0x40/0x60
[   30.616114]  ? __pfx_kthread+0x10/0x10
[   30.616114]  ret_from_fork_asm+0x1b/0x30
[   30.616114]  </TASK>
[   30.616114] Modules linked in: [last unloaded: bpf_testmod(OE)]
[   30.616114] CR2: 0000000000000008
[   30.616114] ---[ end trace 0000000000000000 ]---
[   30.616114] RIP: 0010:skb_dequeue+0x54/0x80
[   30.616114] Code: 74 45 4c 39 e3 74 40 8b 43 10 83 e8 01 89 43 10 49 8b =
14 24 49 8b 44 24 08 49 c7 04 24 00 00 00 00 49 c7 44 24 08 00 00 00 00 <48=
> 89 42 08 48 89 10 4c 89 ef e8 7d 6f 35 00 41
[   30.616114] RSP: 0018:ffffc900001afdd0 EFLAGS: 00010097
[   30.616114] RAX: 0000000000000000 RBX: ffff8881040d39b8 RCX: 3f495367eac=
50c98
[   30.616114] RDX: 0000000000000000 RSI: 0000000000000286 RDI: ffff8881040=
d39d0
[   30.616114] RBP: ffffc900001afde8 R08: 0000000000000001 R09: 00000000000=
00001
[   30.616114] R10: 0000000000000000 R11: 0000000000000091 R12: ffff8881037=
9d000
[   30.616114] R13: ffff8881040d39d0 R14: ffff88817bd2e6c0 R15: ffff88817bd=
33905
[   30.616114] FS:  0000000000000000(0000) GS:ffff88817bd00000(0000) knlGS:=
0000000000000000
[   30.616114] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.616114] CR2: 0000000000000008 CR3: 000000010548a000 CR4: 00000000007=
50ee0
[   30.616114] PKRU: 55555554
[   30.616114] Kernel panic - not syncing: Fatal exception
[   30.616114] Kernel Offset: disabled
[   30.616114] ---[ end Kernel panic - not syncing: Fatal exception ]---


>=20
> jirka
>=20
> >=20
> > jirka
> >=20
> >=20
> > ---
> > [ 1022.710250][ T2556] general protection fault, probably for non-canon=
ical address 0x6b6b6b6b6b6b6b73: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC NOPT=
I^M
> > [ 1022.711206][ T2556] CPU: 2 PID: 2556 Comm: kworker/2:4 Tainted: G   =
        OE      6.5.0+ #693 1723c8b9805ff5a1672ab7e6f25977078a7bcceb^M
> > [ 1022.712120][ T2556] Hardware name: QEMU Standard PC (Q35 + ICH9, 200=
9), BIOS 1.16.2-1.fc38 04/01/2014^M
> > [ 1022.712830][ T2556] Workqueue: events sk_psock_backlog^M
> > [ 1022.713262][ T2556] RIP: 0010:skb_dequeue+0x4c/0x80^M
> > [ 1022.713653][ T2556] Code: 41 48 85 ed 74 3c 8b 43 10 4c 89 e7 83 e8 =
01 89 43 10 48 8b 45 08 48 8b 55 00 48 c7 45 08 00 00 00 00 48 c7 45 00 00 =
00 00 00 <48> 89 42 08 48 89 10 e8 e8 6a 41 00 48 89 e8 5b 5d 41 5c c3 cc c=
c^M
> > [ 1022.714963][ T2556] RSP: 0018:ffffc90003ca7dd0 EFLAGS: 00010046^M
> > [ 1022.715431][ T2556] RAX: 6b6b6b6b6b6b6b6b RBX: ffff88811de269d0 RCX:=
 0000000000000000^M
> > [ 1022.716068][ T2556] RDX: 6b6b6b6b6b6b6b6b RSI: 0000000000000282 RDI:=
 ffff88811de269e8^M
> > [ 1022.716676][ T2556] RBP: ffff888141ae39c0 R08: 0000000000000001 R09:=
 0000000000000000^M
> > [ 1022.717283][ T2556] R10: 0000000000000001 R11: 0000000000000000 R12:=
 ffff88811de269e8^M
> > [ 1022.717930][ T2556] R13: 0000000000000001 R14: ffff888141ae39c0 R15:=
 ffff88810a20e640^M
> > [ 1022.718549][ T2556] FS:  0000000000000000(0000) GS:ffff88846d600000(=
0000) knlGS:0000000000000000^M
> > [ 1022.719241][ T2556] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3^M
> > [ 1022.719761][ T2556] CR2: 00007fb5c25ca000 CR3: 000000012b902004 CR4:=
 0000000000770ee0^M
> > [ 1022.720394][ T2556] PKRU: 55555554^M
> > [ 1022.720699][ T2556] Call Trace:^M
> > [ 1022.720984][ T2556]  <TASK>^M
> > [ 1022.721254][ T2556]  ? die_addr+0x32/0x80^M
> > [ 1022.721589][ T2556]  ? exc_general_protection+0x25a/0x4b0^M
> > [ 1022.722026][ T2556]  ? asm_exc_general_protection+0x22/0x30^M
> > [ 1022.722489][ T2556]  ? skb_dequeue+0x4c/0x80^M
> > [ 1022.722854][ T2556]  sk_psock_backlog+0x27a/0x300^M
> > [ 1022.723243][ T2556]  process_one_work+0x2a7/0x5b0^M
> > [ 1022.723633][ T2556]  worker_thread+0x4f/0x3a0^M
> > [ 1022.723998][ T2556]  ? __pfx_worker_thread+0x10/0x10^M
> > [ 1022.724386][ T2556]  kthread+0xfd/0x130^M
> > [ 1022.724709][ T2556]  ? __pfx_kthread+0x10/0x10^M
> > [ 1022.725066][ T2556]  ret_from_fork+0x2d/0x50^M
> > [ 1022.725409][ T2556]  ? __pfx_kthread+0x10/0x10^M
> > [ 1022.725799][ T2556]  ret_from_fork_asm+0x1b/0x30^M
> > [ 1022.726201][ T2556]  </TASK>^M
>=20


