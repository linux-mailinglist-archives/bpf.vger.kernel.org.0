Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE5E65C025
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 13:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjACMq4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 07:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbjACMqx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 07:46:53 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3547B6B;
        Tue,  3 Jan 2023 04:46:51 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id g20so12222299pfb.3;
        Tue, 03 Jan 2023 04:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUjNNWOKD+ottU/UILwC+uJbUalxL5iu3rVNkyz1zWA=;
        b=iND6xuYDopujt+jwzoUI9RSkd+qnVzRwCZlYSKfax0GyxdTzoaqHYu4JRThLd5dyB4
         mCm/nVqtloVxWI7nqaRRiIqbzZ4pxv7giaoPv5QEVyCJXCQxacg+/Kdgu+1bMJ0ToMNB
         kpLb6zZUvgF0Kdlpz25G8/FbjnQAmoFyzYA3CYKPI142DJxi+Zb639CiQ20xF03LEKUM
         ntephGDKRfavXhTMSkIWOdD8Z4xjNdx9ddvSszNn8bpqI3FrrP284MdR5HUtBghYXHvX
         ahDYFS4rph9cNf9gTs3oeFhvnYCf7EoBggFxnVChigGBrA8GJ1it84rwTWeRywiivsF3
         n2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUjNNWOKD+ottU/UILwC+uJbUalxL5iu3rVNkyz1zWA=;
        b=wG6wGfMK674+9qBBKSrAkvR5aDJb5MsSLSNyNDLaPNagsZuEhZMfd7B9W/c/n0q93v
         daYFhGBQm0Tw3VhJGrUBU8BAPcRXdjlC691kZD0LaL3wQ1jE8w+0qBW3jFXALp31KLBx
         eEftAEk6IGsVeepgndkcuLP9nfSRjIdsVog3cvJMdgkvnM0m5IHYdTbog/hKrOeqTTUl
         tVMHKaJA7VYe2ZlKM4EzVbliSPqazEfTuYBwKUpQm1wcRTafYYLozhfBFunkQLzbDLi0
         eJ0oYn9leyd7T9AGhiaGgHLWM59D8ODhtNP/NIi395nhAnR/rxUmff+wBPKI871KHInm
         gyOA==
X-Gm-Message-State: AFqh2kpRDw4he8tpnQs3n1abivoZMRnR3YoGibHC/TD6uIT8s6SFk73C
        60lvZrrdxL2gnSW+wZsagbj9vh1fySoj
X-Google-Smtp-Source: AMrXdXs4f7lqWrjp/+rRMhN8l1qe3lMtKnScmHvX3mK5FTyClpw/WzKlrZimaxMcM/DwvMFKdPnJug==
X-Received: by 2002:aa7:943b:0:b0:582:49d9:688d with SMTP id y27-20020aa7943b000000b0058249d9688dmr9920477pfo.3.1672750011003;
        Tue, 03 Jan 2023 04:46:51 -0800 (PST)
Received: from smtpclient.apple (n119236129232.netvigator.com. [119.236.129.232])
        by smtp.gmail.com with ESMTPSA id 68-20020a620647000000b005756a67e227sm20989364pfg.90.2023.01.03.04.46.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jan 2023 04:46:50 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: kernel panic: Attempted to kill init!
From:   Hao Sun <sunhao.th@gmail.com>
In-Reply-To: <CAADnVQ+EMzAmeKvivFKvqCNj6H9X-1rBtBBnjRzDiNvkocsc6A@mail.gmail.com>
Date:   Tue, 3 Jan 2023 20:46:36 +0800
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
Message-Id: <2EC740FA-A10B-4208-8080-9A268BD8E675@gmail.com>
References: <20221222043507.33037-1-sunhao.th@gmail.com>
 <ef46c1f6-0939-c2ed-3efb-c3c5f28d1931@meta.com>
 <73E3CA9E-F67E-429F-A2DB-C77649E32D7A@gmail.com>
 <CAADnVQ+EMzAmeKvivFKvqCNj6H9X-1rBtBBnjRzDiNvkocsc6A@mail.gmail.com>
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



> On 31 Dec 2022, at 12:55 AM, Alexei Starovoitov =
<alexei.starovoitov@gmail.com> wrote:
>=20
> On Fri, Dec 30, 2022 at 1:54 AM Hao Sun <sunhao.th@gmail.com> wrote:
>>=20
>>=20
>>=20
>>> On 28 Dec 2022, at 2:35 PM, Yonghong Song <yhs@meta.com> wrote:
>>>=20
>>>=20
>>>=20
>>> On 12/21/22 8:35 PM, Hao Sun wrote:
>>>> Hi,
>>>> This crash can be triggered by executing the C reproducer for
>>>> multiple times, which just keep loading the following prog as
>>>> raw tracepoint into kmem_cache_free().
>>>> The prog send SIGSEGV to current via bpf_send_signal_thread(),
>>>> after load this, whoever tries to free mem would trigger this,
>>>> kernel crashed when this happens to init.
>>>> Seems we should filter init out in bpf_send_signal_common() by
>>>> is_global_init(current), or maybe we should check this in the
>>>> verifier?
>>>=20
>>> The helper is just to send a particular signal to *current*
>>> thread. In typical use case, it is never a good idea to send
>>> the signal to a *random* thread. In certain cases, maybe user
>>> indeed wants to send the signal to init thread to observe
>>> something. Note that such destructive side effect already
>>> exists in the bpf land. For example, for a xdp program,
>>> it could drop all packets to make machine not responsive
>>> to ssh etc. Therefore, I recommend to keep the existing
>>> bpf_send_signal_common() helper behavior.
>>=20
>> Sound the two are different cases. Not responsive in XDP seems like
>> an intended behaviour, panic caused by killing init is buggy. If the
>> last thread of global init was killed, kernel panic immediately.
>=20
> I don't get it. How was it possible that this prog was
> executed with current =3D=3D pid 1 ?

The prog is raw trace point and is attached to =E2=80=98kmem_cache_free=E2=
=80=99 event.
When init triggered the event, the prog would be executed with pid 1.
But, the reason of this crash is not very clear to me, because it=E2=80=99=
s
really hard to debug with original C reproducer.

The following is the corresponding Syz prog:

# {Threaded:true Repeat:true RepeatTimes:0 Procs:1 Slowdown:1 =
Sandbox:none SandboxArg:0 Leak:false NetInjection:true NetDevices:true =
NetReset:true Cgroups:true BinfmtMisc:true CloseFDs:true KCSAN:false =
DevlinkPCI:false NicVF:false USB:false VhciInjection:false Wifi:false =
IEEE802154:true Sysctl:true UseTmpDir:true HandleSegv:true Repro:false =
Trace:false LegacyOptions:{Collide:false Fault:false FaultCall:0 =
FaultNth:0}}
r0 =3D bpf$BPF_PROG_RAW_TRACEPOINT_LOAD(0x5, &(0x7f0000000000)=3D{0x11, =
0xe, =
&(0x7f0000000400)=3DANY=3D[@ANYBLOB=3D"18000000000000000000000000000000180=
60000000000000000000000000000180700000000000000000000000000001808000000000=
0000000000000000000180900000000000000000000000000002d00020000000000b701000=
00b000000850000007500000095"], &(0x7f00000000c0)}, 0x80)
bpf$BPF_RAW_TRACEPOINT_OPEN(0x11, =
&(0x7f0000000100)=3D{&(0x7f0000000080)=3D'kmem_cache_free\x00', r0}, =
0x10)

