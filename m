Return-Path: <bpf+bounces-9089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB6F78F3E0
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 22:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE0A1C20B27
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 20:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEA419BD4;
	Thu, 31 Aug 2023 20:20:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573B28F57;
	Thu, 31 Aug 2023 20:20:33 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47532E70;
	Thu, 31 Aug 2023 13:20:30 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c1e780aa95so8776595ad.3;
        Thu, 31 Aug 2023 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693513230; x=1694118030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glunifKys0KxTtEMgxXgfZxsH+c8MMI1LKeXtS0pXuc=;
        b=Zd59KQWWxsySh5NNyskMQMqG+d/pqAOd7+b3Eajd68SuN4hI5D9euffZVKtIQhWlUR
         wuq2xKiQUCB1xQeivHRhbdSlCjVuq4tmNdQQ8feZ2Nt+hLgnJYs50kjorV6469Q3xsju
         DR3l7wb/GQsXnNwbDv+3VkWLF13a2MBoOrWyY8fM057qiHhj9WQSDizxScMUOD2atNcg
         NU7i0GhNiheAL/t7YEW9lzRvFBESAj0te31MMs2yltae9bRd+2uage+etC2BxJcbPVzh
         XswDwprNaC4x4SEsAHELITdsURkU0AERMrDq137qLlx0pW0OiGLStoQnJ2nszkj7RWrZ
         Vm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693513230; x=1694118030;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=glunifKys0KxTtEMgxXgfZxsH+c8MMI1LKeXtS0pXuc=;
        b=FesBctcqxo3Y321VZUYYecoSCDfrZmKPPYDhIAduENF2Q4o2/hLkUK9WvNiyOWW5T2
         HSTtNDRQbKSU0mCT2Z6UvwPAUDdL+dqs9ytrDJ3OINez3+BC+uVNXAqOc9d5g2vvPeqL
         ldOd+bNi+RwBwOrT2+kzAW6tO4hrpKlnkKC/TAsWsZUtkgPJuVV1qunsqfcQiMcaGL7e
         RBjgYN52hG7U42uZX5QLZP9q0PP+EwmaXdRR+gg42Ot4rhDmt0FPH703PJX9jk2bhPgu
         N8ctpPryXbvvJ+f4+sr/spQRnB5U6/UB6pOz5nX7IMjW/fsih+syeZG6dpxeFjvtgeA4
         i16Q==
X-Gm-Message-State: AOJu0YwyuTe0/QlmSRFIsAI6uHZuTpKPAryPt+R4WgL5X5DB7qiA/hvm
	WvHOzYlmd+7RZy0pR76yGJ0=
X-Google-Smtp-Source: AGHT+IHFyIXpTt3iMJe/b9VHU98vj+UtLZXVcMvvcitcCCvYgBINAe0LQfJnOWcrYaIfcwogpQwJzA==
X-Received: by 2002:a17:902:ce8e:b0:1c1:fc5c:b330 with SMTP id f14-20020a170902ce8e00b001c1fc5cb330mr876200plg.12.1693513229594;
        Thu, 31 Aug 2023 13:20:29 -0700 (PDT)
Received: from localhost ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902684d00b001bda30ecaa6sm1646439pln.51.2023.08.31.13.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 13:20:28 -0700 (PDT)
Date: Thu, 31 Aug 2023 13:20:27 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Xu Kuohai <xukuohai@huawei.com>, 
 Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Martin KaFai Lau <kafai@fb.com>, 
 Song Liu <songliubraving@fb.com>, 
 Yonghong Song <yhs@fb.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@chromium.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Hou Tao <houtao1@huawei.com>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>
Message-ID: <64f0f60b1417c_d45ab2086b@john.notmuch>
In-Reply-To: <64f0e7ae869c9_d03ca20847@john.notmuch>
References: <ZO+RQwJhPhYcNGAi@krava>
 <ZO+vetPCpOOCGitL@krava>
 <23cd4ce0-0360-e3c6-6cc9-f597aefb2ab5@huawei.com>
 <1c533412-b192-3868-991a-d35587329803@huawei.com>
 <64f0e7ae869c9_d03ca20847@john.notmuch>
Subject: Re: [BUG bpf-next] bpf/net: Hitting gpf when running selftests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

John Fastabend wrote:
> Xu Kuohai wrote:
> > On 8/31/2023 5:46 PM, Xu Kuohai wrote:
> > > On 8/31/2023 5:07 AM, Jiri Olsa wrote:
> > >> On Wed, Aug 30, 2023 at 08:58:11PM +0200, Jiri Olsa wrote:
> > >>> hi,
> > >>> I'm hitting crash below on bpf-next/master when running selftests=
,
> > >>> full log and config attached
> > >>
> > >> it seems to be 'test_progs -t sockmap_listen' triggering that
> > >>
> > >> jirka
> > >>
> > >>>
> > >>> jirka
> > >>>
> > >>>
> > >>> ---
> > >>> [ 1022.710250][ T2556] general protection fault, probably for non=
-canonical address 0x6b6b6b6b6b6b6b73: 0000 [#1] PREEMPT SMP DEBUG_PAGEAL=
LOC NOPTI^M
> > >>> [ 1022.711206][ T2556] CPU: 2 PID: 2556 Comm: kworker/2:4 Tainted=
: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OE=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 6.5.0+ #693 1723c8b9805ff5a1672ab7e6f25977078a7bcce=
b^M
> > >>> [ 1022.712120][ T2556] Hardware name: QEMU Standard PC (Q35 + ICH=
9, 2009), BIOS 1.16.2-1.fc38 04/01/2014^M
> > >>> [ 1022.712830][ T2556] Workqueue: events sk_psock_backlog^M
> > >>> [ 1022.713262][ T2556] RIP: 0010:skb_dequeue+0x4c/0x80^M
> > >>> [ 1022.713653][ T2556] Code: 41 48 85 ed 74 3c 8b 43 10 4c 89 e7 =
83 e8 01 89 43 10 48 8b 45 08 48 8b 55 00 48 c7 45 08 00 00 00 00 48 c7 4=
5 00 00 00 00 00 <48> 89 42 08 48 89 10 e8 e8 6a 41 00 48 89 e8 5b 5d 41 =
5c c3 cc cc^M
> > >>> [ 1022.714963][ T2556] RSP: 0018:ffffc90003ca7dd0 EFLAGS: 0001004=
6^M
> > >>> [ 1022.715431][ T2556] RAX: 6b6b6b6b6b6b6b6b RBX: ffff88811de269d=
0 RCX: 0000000000000000^M
> > >>> [ 1022.716068][ T2556] RDX: 6b6b6b6b6b6b6b6b RSI: 000000000000028=
2 RDI: ffff88811de269e8^M
> > >>> [ 1022.716676][ T2556] RBP: ffff888141ae39c0 R08: 000000000000000=
1 R09: 0000000000000000^M
> > >>> [ 1022.717283][ T2556] R10: 0000000000000001 R11: 000000000000000=
0 R12: ffff88811de269e8^M
> > >>> [ 1022.717930][ T2556] R13: 0000000000000001 R14: ffff888141ae39c=
0 R15: ffff88810a20e640^M
> > >>> [ 1022.718549][ T2556] FS:=C2=A0 0000000000000000(0000) GS:ffff88=
846d600000(0000) knlGS:0000000000000000^M
> > >>> [ 1022.719241][ T2556] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000=
000080050033^M
> > >>> [ 1022.719761][ T2556] CR2: 00007fb5c25ca000 CR3: 000000012b90200=
4 CR4: 0000000000770ee0^M
> > >>> [ 1022.720394][ T2556] PKRU: 55555554^M
> > >>> [ 1022.720699][ T2556] Call Trace:^M
> > >>> [ 1022.720984][ T2556]=C2=A0 <TASK>^M
> > >>> [ 1022.721254][ T2556]=C2=A0 ? die_addr+0x32/0x80^M
> > >>> [ 1022.721589][ T2556]=C2=A0 ? exc_general_protection+0x25a/0x4b0=
^M
> > >>> [ 1022.722026][ T2556]=C2=A0 ? asm_exc_general_protection+0x22/0x=
30^M
> > >>> [ 1022.722489][ T2556]=C2=A0 ? skb_dequeue+0x4c/0x80^M
> > >>> [ 1022.722854][ T2556]=C2=A0 sk_psock_backlog+0x27a/0x300^M
> > >>> [ 1022.723243][ T2556]=C2=A0 process_one_work+0x2a7/0x5b0^M
> > >>> [ 1022.723633][ T2556]=C2=A0 worker_thread+0x4f/0x3a0^M
> > >>> [ 1022.723998][ T2556]=C2=A0 ? __pfx_worker_thread+0x10/0x10^M
> > >>> [ 1022.724386][ T2556]=C2=A0 kthread+0xfd/0x130^M
> > >>> [ 1022.724709][ T2556]=C2=A0 ? __pfx_kthread+0x10/0x10^M
> > >>> [ 1022.725066][ T2556]=C2=A0 ret_from_fork+0x2d/0x50^M
> > >>> [ 1022.725409][ T2556]=C2=A0 ? __pfx_kthread+0x10/0x10^M
> > >>> [ 1022.725799][ T2556]=C2=A0 ret_from_fork_asm+0x1b/0x30^M
> > >>> [ 1022.726201][ T2556]=C2=A0 </TASK>^M
> > >>
> > >>
> > >> .
> > > =

> > > My patch failed on the BPF CI, and the log shows the test also died=
 in skb_dequeue:
> > > =

> > > https://github.com/kernel-patches/bpf/actions/runs/6031993528/job/1=
6366782122
> > > =

> > > [...]
> > > =

> > >  =C2=A0 [=C2=A0=C2=A0 74.396478]=C2=A0 ? __die_body+0x1f/0x70
> > >  =C2=A0 [=C2=A0=C2=A0 74.396700]=C2=A0 ? page_fault_oops+0x15b/0x45=
0
> > >  =C2=A0 [=C2=A0=C2=A0 74.396957]=C2=A0 ? fixup_exception+0x26/0x330=

> > >  =C2=A0 [=C2=A0=C2=A0 74.397211]=C2=A0 ? exc_page_fault+0x68/0x1a0
> > >  =C2=A0 [=C2=A0=C2=A0 74.397457]=C2=A0 ? asm_exc_page_fault+0x26/0x=
30
> > >  =C2=A0 [=C2=A0=C2=A0 74.397724]=C2=A0 ? skb_dequeue+0x52/0x90
> > >  =C2=A0 [=C2=A0=C2=A0 74.397954]=C2=A0 sk_psock_destroy+0x8c/0x2b0
> > >  =C2=A0 [=C2=A0=C2=A0 74.398204]=C2=A0 process_one_work+0x28a/0x550=

> > >  =C2=A0 [=C2=A0=C2=A0 74.398458]=C2=A0 ? __pfx_worker_thread+0x10/0=
x10
> > >  =C2=A0 [=C2=A0=C2=A0 74.398730]=C2=A0 worker_thread+0x51/0x3c0
> > >  =C2=A0 [=C2=A0=C2=A0 74.398966]=C2=A0 ? __pfx_worker_thread+0x10/0=
x10
> > >  =C2=A0 [=C2=A0=C2=A0 74.399235]=C2=A0 kthread+0xf7/0x130
> > >  =C2=A0 [=C2=A0=C2=A0 74.399437]=C2=A0 ? __pfx_kthread+0x10/0x10
> > >  =C2=A0 [=C2=A0=C2=A0 74.399707]=C2=A0 ret_from_fork+0x34/0x50
> > >  =C2=A0 [=C2=A0=C2=A0 74.399967]=C2=A0 ? __pfx_kthread+0x10/0x10
> > >  =C2=A0 [=C2=A0=C2=A0 74.400234]=C2=A0 ret_from_fork_asm+0x1b/0x30
> > > =

> > > =

> > > After a few tries, I found a way to reproduce the problem.
> > > =

> > > Here is the reproduce steps:
> > > =

> > > 1. create a kprobe to delay sk_psock_backlog:
> > > =

> > > static struct kprobe kp =3D {
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .symbol_name =3D "sk_ps=
ock_backlog",
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .offset =3D 0x00,
> > > };
> > > =

> > > static int handler_pre(struct kprobe *p, struct pt_regs *regs)
> > > {
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mdelay(1000);
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > }
> > > =

> > > static int __init kprobe_init(void)
> > > {
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > =

> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kp.pre_handler =3D hand=
ler_pre;
> > > =

> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D register_kprobe=
(&kp);
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =

> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > }
> > > =

> > > 2. insert the kprobe and run the vsock sockmap test:
> > > =

> > > ./test_progs -t "sockmap_listen/sockmap VSOCK test_vsock_redir"
> > > =

> > > =

> > > =

> > > I guess the problem is in sk_psock_backlog, where skb is inserted t=
o another
> > > list before skb_dequeue is called.
> > > =

> > > So I tested it with the following changes, and found the problem di=
d go away.
> > > =

> > > --- a/net/core/skmsg.c
> > > +++ b/net/core/skmsg.c
> > > @@ -648,7 +648,7 @@ static void sk_psock_backlog(struct work_struct=
 *work)
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 off =3D state->off;
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =

> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while ((skb =3D skb_peek(&pso=
ck->ingress_skb))) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while ((skb =3D skb_dequeue(&=
psock->ingress_skb))) {
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 len =3D skb->len;
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 off =3D 0;
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (skb_bpf_strparser(skb)) {
> > > @@ -684,7 +684,6 @@ static void sk_psock_backlog(struct work_struct=
 *work)
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
len -=3D ret;
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 } while (len);
> > > =

> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 skb =3D skb_dequeue(&psock->ingress_skb);
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (!ingress) {
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
kfree_skb(skb);
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =

> > > Not clear what exactly happened, needs more debugging.
> > >
> =

> I can only reproduce this on bpf-next so specific to
> the vsock use case?
> =

> > =

> > Use the skb address obtained from skb_peek() in sk_psock_backlog() as=
 the key,
> > 4 stack traces are obtained.
> > =

> > =

> > trace 0, the skb is queued to the target socket ingress queue:
> > =

> > [  120.042016] sk_psock_skb_ingress_enqueue+0xf5/0x160
> > [  120.045052] sk_psock_backlog+0x206/0x400
> > [  120.047366] process_one_work+0x292/0x560
> > [  120.049657] worker_thread+0x53/0x3e0
> > [  120.051698] kthread+0x102/0x130
> > [  120.053497] ret_from_fork+0x34/0x50
> > [  120.055528] ret_from_fork_asm+0x1b/0x30
> > =

> > =

> > trace 1, the skb is consumed by the user:
> > =

> > [  120.061537] consume_skb+0x47/0x100
> > [  120.063394] sk_msg_recvmsg+0x268/0x3e0
> > [  120.065458] unix_bpf_recvmsg+0x16c/0x610
> > [  120.067584] unix_stream_recvmsg+0x66/0xa0
> > [  120.069946] sock_recvmsg+0xc4/0xd0
> > [  120.072063] __sys_recvfrom+0xaf/0x120
> > [  120.073933] __x64_sys_recvfrom+0x29/0x30
> > [  120.076052] do_syscall_64+0x3f/0x90
> > [  120.077986] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > =

> > trace 2, the vsock socket is closed by the user, and a new skb with
> > the same address is allocated in vsock_release:
> > =

> > [  120.084296] __alloc_skb+0xe3/0x180
> > [  120.086335] virtio_transport_alloc_skb+0x3b/0x2c0
> > [  120.089174] virtio_transport_send_pkt_info+0x118/0x230
> > [  120.092191] virtio_transport_release+0x29d/0x400
> > [  120.094845] __vsock_release+0x3c/0x1e0
> > [  120.096905] vsock_release+0x18/0x30
> > [  120.098899] __sock_release+0x3d/0xc0
> > [  120.100885] sock_close+0x18/0x20
> > [  120.102606] __fput+0x108/0x2b0
> > [  120.104636] task_work_run+0x5d/0xa0
> > [  120.106876] exit_to_user_mode_prepare+0x18c/0x190
> > [  120.109619] syscall_exit_to_user_mode+0x1d/0x50
> > [  120.112049] do_syscall_64+0x4c/0x90
> > [  120.114115] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > =

> > trace 3, sk_psock_backlog() calls skb_dequeue() to unlink the skb, si=
nce
> > this skb is now actually a new skb allocated in vsock_release, its pr=
ev
> > and next fields are both set to NULL, NULL deref occurs.
> > =

> > [  120.120619] skb_dequeue+0x92/0xa0
> > [  120.122350] sk_psock_backlog+0x305/0x400
> > [  120.124512] process_one_work+0x292/0x560
> > [  120.126771] worker_thread+0x53/0x3e0
> > [  120.128843] kthread+0x102/0x130
> > [  120.130772] ret_from_fork+0x34/0x50
> > =

> > To fix it, it seems reasonable to replace skb_peek() with skb_dequeue=
()
> > in sk_psock_backlog(), since we can't prevent the skb from being appe=
nded
> > to an ingress queue and consumed by user, as shown in trace 1 and tra=
ce 2.
> =

> The trouble with skb_dequeue is it breaks other checks that check
> the backlog queue length. It really is nice to have a single len
> check that determines if backlog is necessary or not.
> =

> If we revert something we likely need to go back to holding the
> sock lock in backlog to ensure a reader can't eat the skb while
> We still have a reference to it. It wasn't an issue for us because
> its the exception case.
> =

> Trying to come up with some nice fix now.

Something like this it fixes the splat, but need to think if it
introduces anything or some better way to do this. Basic idea
is to bump user->refcnt because we have two references to the
skb and want to ensure we really only kfree_skb() the skb
after both references are dropped.

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index a0659fc29bcc..6c31eefbd777 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -612,12 +612,18 @@ static int sk_psock_skb_ingress_self(struct sk_psoc=
k *psock, struct sk_buff *skb
 static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *s=
kb,
                               u32 off, u32 len, bool ingress)
 {
+       int err =3D 0;
+
        if (!ingress) {
                if (!sock_writeable(psock->sk))
                        return -EAGAIN;
                return skb_send_sock(psock->sk, skb, off, len);
        }
-       return sk_psock_skb_ingress(psock, skb, off, len);
+       skb_get(skb);
+       err =3D sk_psock_skb_ingress(psock, skb, off, len);
+       if (err < 0)
+               kfree_skb(skb);
+       return err;
 }
 =

 static void sk_psock_skb_state(struct sk_psock *psock,
@@ -685,9 +691,7 @@ static void sk_psock_backlog(struct work_struct *work=
)
                } while (len);
 =

                skb =3D skb_dequeue(&psock->ingress_skb);
-               if (!ingress) {
-                       kfree_skb(skb);
-               }
+               kfree_skb(skb);
        }
 end:
        mutex_unlock(&psock->work_mutex);=

