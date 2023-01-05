Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD9765E72F
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 10:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjAEJA0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 04:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjAEJAZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 04:00:25 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990734FD74;
        Thu,  5 Jan 2023 01:00:24 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id h7-20020a17090aa88700b00225f3e4c992so1415393pjq.1;
        Thu, 05 Jan 2023 01:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LtwxZ5lFGkL2+AyHlPnr+OvHAW29k0NmSTUNbZsM3I=;
        b=dP5eIW/qNuS7VOF2O4czV7dfBM3+6tontnnc0pOvlcQuA3xjhuMl6GCByJRE8E7MZJ
         AcIPeE3eyteBwui6Gf96HWto53BFOGZaUTr9MEchFcPsLFRYgBB7hphDweN1eR6HGAkQ
         RI1W7NcM5z1cxRZqBKKswn0JwXXCeeZHZlDaPNFL50HTtrBCyYIsvTEnPyqG9swOwcyo
         Ur+hpC6ETCg/iYpJ5KCxdBUFwbsZqJn6SC1QO/V1cEC26z/yVbDdDgc58uDHUnf+DzrQ
         WYZBVdH7yQIp1ISITHKRV4SclV9AzqQdDM1lw0l2BL5EmeYtMetr1rOnRsPHeR/Gk1gA
         QAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LtwxZ5lFGkL2+AyHlPnr+OvHAW29k0NmSTUNbZsM3I=;
        b=CFbHZwpc1uGpTJwbsoTENKimw4N0Q6KI6R94FQEQZAC7SxDtbvQDQW7XpqkK8n9pbC
         F8qfxYGbayfpMufgMIuFwdLZexz8zF3xuq/VmppNUUWDiinwBGdg9EOhkg88Hh/dxo8/
         g1GR4TrLm7eC+OAvAJvJwTxO7p+cuHl09tZSrEtuynKDOMdkWjXIHslopR/P0E7UB0o4
         D2xqDUSvZCr8ujhbHQ+KVhz+XBLBe4vJ5je+lf+MYZ8sZrAffE5KeNrk5qxG7kWuft00
         3nyNbI0GBZLhEvEQYpte/KrxpT5akBKxWgz0RdtQDpaM8Z2r0EXlCZtdkAsthhP/qp4s
         Ze7w==
X-Gm-Message-State: AFqh2kpd8gMw0vZvX+u5kxYN/ytAKcA4cXGyEYEh977M/ACbujPRCilf
        W125UisUxF1y0YI1qSa0DA==
X-Google-Smtp-Source: AMrXdXtNi05wlR7s4j+yrNMa4Pw6fR22+wWRrCWNQKJhOkIqtFB9TR518GUOqu6vQoUJ5PD1p4ssCA==
X-Received: by 2002:a17:90a:d151:b0:225:ec6a:2d02 with SMTP id t17-20020a17090ad15100b00225ec6a2d02mr37445103pjw.0.1672909223813;
        Thu, 05 Jan 2023 01:00:23 -0800 (PST)
Received: from smtpclient.apple ([124.217.189.83])
        by smtp.gmail.com with ESMTPSA id x4-20020a17090a6c0400b00226c9c577f6sm899661pjj.21.2023.01.05.01.00.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jan 2023 01:00:23 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: kernel panic: Attempted to kill init!
From:   Hao Sun <sunhao.th@gmail.com>
In-Reply-To: <CAADnVQKzRS6HcbOPuJRJ=8SOXDDDdy2EBN-LP6vSgB9tLb27Ug@mail.gmail.com>
Date:   Thu, 5 Jan 2023 17:00:07 +0800
Cc:     Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F6713293-7B1E-4C2B-8B6F-683A1B3E002D@gmail.com>
References: <20221222043507.33037-1-sunhao.th@gmail.com>
 <ef46c1f6-0939-c2ed-3efb-c3c5f28d1931@meta.com>
 <73E3CA9E-F67E-429F-A2DB-C77649E32D7A@gmail.com>
 <CAADnVQ+EMzAmeKvivFKvqCNj6H9X-1rBtBBnjRzDiNvkocsc6A@mail.gmail.com>
 <2EC740FA-A10B-4208-8080-9A268BD8E675@gmail.com>
 <CAADnVQKzRS6HcbOPuJRJ=8SOXDDDdy2EBN-LP6vSgB9tLb27Ug@mail.gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On 4 Jan 2023, at 2:33 AM, Alexei Starovoitov =
<alexei.starovoitov@gmail.com> wrote:
>=20
> On Tue, Jan 3, 2023 at 4:46 AM Hao Sun <sunhao.th@gmail.com> wrote:
>>=20
>>=20
>>=20
>>> On 31 Dec 2022, at 12:55 AM, Alexei Starovoitov =
<alexei.starovoitov@gmail.com> wrote:
>>>=20
>>> On Fri, Dec 30, 2022 at 1:54 AM Hao Sun <sunhao.th@gmail.com> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On 28 Dec 2022, at 2:35 PM, Yonghong Song <yhs@meta.com> wrote:
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> On 12/21/22 8:35 PM, Hao Sun wrote:
>>>>>> Hi,
>>>>>> This crash can be triggered by executing the C reproducer for
>>>>>> multiple times, which just keep loading the following prog as
>>>>>> raw tracepoint into kmem_cache_free().
>>>>>> The prog send SIGSEGV to current via bpf_send_signal_thread(),
>>>>>> after load this, whoever tries to free mem would trigger this,
>>>>>> kernel crashed when this happens to init.
>>>>>> Seems we should filter init out in bpf_send_signal_common() by
>>>>>> is_global_init(current), or maybe we should check this in the
>>>>>> verifier?
>>>>>=20
>>>>> The helper is just to send a particular signal to *current*
>>>>> thread. In typical use case, it is never a good idea to send
>>>>> the signal to a *random* thread. In certain cases, maybe user
>>>>> indeed wants to send the signal to init thread to observe
>>>>> something. Note that such destructive side effect already
>>>>> exists in the bpf land. For example, for a xdp program,
>>>>> it could drop all packets to make machine not responsive
>>>>> to ssh etc. Therefore, I recommend to keep the existing
>>>>> bpf_send_signal_common() helper behavior.
>>>>=20
>>>> Sound the two are different cases. Not responsive in XDP seems like
>>>> an intended behaviour, panic caused by killing init is buggy. If =
the
>>>> last thread of global init was killed, kernel panic immediately.
>>>=20
>>> I don't get it. How was it possible that this prog was
>>> executed with current =3D=3D pid 1 ?
>>=20
>> The prog is raw trace point and is attached to =E2=80=98kmem_cache_free=
=E2=80=99 event.
>> When init triggered the event, the prog would be executed with pid 1.
>> But, the reason of this crash is not very clear to me, because it=E2=80=
=99s
>> really hard to debug with original C reproducer.
>>=20
>> The following is the corresponding Syz prog:
>>=20
>> # {Threaded:true Repeat:true RepeatTimes:0 Procs:1 Slowdown:1 =
Sandbox:none SandboxArg:0 Leak:false NetInjection:true NetDevices:true =
NetReset:true Cgroups:true BinfmtMisc:true CloseFDs:true KCSAN:false =
DevlinkPCI:false NicVF:false USB:false VhciInjection:false Wifi:false =
IEEE802154:true Sysctl:true UseTmpDir:true HandleSegv:true Repro:false =
Trace:false LegacyOptions:{Collide:false Fault:false FaultCall:0 =
FaultNth:0}}
>> r0 =3D bpf$BPF_PROG_RAW_TRACEPOINT_LOAD(0x5, &(0x7f0000000000)=3D{0x11,=
 0xe, =
&(0x7f0000000400)=3DANY=3D[@ANYBLOB=3D"18000000000000000000000000000000180=
60000000000000000000000000000180700000000000000000000000000001808000000000=
0000000000000000000180900000000000000000000000000002d00020000000000b701000=
00b000000850000007500000095"], &(0x7f00000000c0)}, 0x80)
>> bpf$BPF_RAW_TRACEPOINT_OPEN(0x11, =
&(0x7f0000000100)=3D{&(0x7f0000000080)=3D'kmem_cache_free\x00', r0}, =
0x10)
>=20
> Does syzbot running without any user space?
> Is syzbot itself a pid=3D1 ? and the only process ?
> If so, the error would makes sense.

Yes, after read the C reproducer again, noticed that after a
bunch of sandbox setup, the pid of the reproducer process at
runtime is 1. =20

> I guess we can add a safety check to bpf_send_signal_common
> to prevent syzbot from killing itself.

Maybe something like this? This can avoid the panic, but won=E2=80=99t
allow task with pid=3D1 to send signal with prog.

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 23ce498bca97..94d2af2ce433 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -844,6 +844,8 @@ static int bpf_send_signal_common(u32 sig, enum =
pid_type type)
 	 */
 	if (unlikely(current->flags & (PF_KTHREAD | PF_EXITING)))
 		return -EPERM;
+	if (unlikely(is_global_init(current)))
+		return -EPERM;
 	if (unlikely(!nmi_uaccess_okay()))
 		return -EPERM;

