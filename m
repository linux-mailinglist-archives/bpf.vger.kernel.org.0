Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FB565C651
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 19:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjACSeF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 13:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjACSeE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 13:34:04 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4460DF5D;
        Tue,  3 Jan 2023 10:34:03 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qk9so76008913ejc.3;
        Tue, 03 Jan 2023 10:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9v/ufy34ZVB6nwfDjrI5oZeLWMB3WaNB3swR5de9fg=;
        b=K6phPrOFRBMXjKkfBIW7liiPV4QoUHA8309m6Zj+WeZdXwPeBYa2sq5WbTBY7z03Wr
         moKFP4cWbxELbj5K28+l1yyaegcyplEFz2O1JN3mq2DtCKz4js5E92nBYGYXigUn/V6V
         Lwry5Hb0R9kpwOXYnR9h4WjSlrzZWWTi7S8oqkQIL0gRKPR/lmcsfM9gCAfWltjugR0f
         5sMZLgQSvI0cFmKCbp8O0NX9lzl4FKQC57mrux60e5epceFe6w1AKtX0roJIbkuAUzmL
         C3ViLSL5/7gu+F9g37iW2fbYkRoxehroYM4v2ECECeb0ghGTxvX53XAA75g92kyCums2
         /a8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9v/ufy34ZVB6nwfDjrI5oZeLWMB3WaNB3swR5de9fg=;
        b=xLtwDYxWuFIf0B6St+Cor1fwKX/A/pgxNRGVUY3bDzSjDjX/ItXs1cfTWRf1rB9ylh
         lPFWZrCDq8VZ+olvUS54MS6/XbauwfWWNw2MOdaTLIn/GcasVVekT192T7OHC63Tj0/T
         n+MZci/1i1Jn01lQ/pwOo6QnAWQhliYxWN/PVgZmM6Lo3Ey8OX9u7QQASVtO5h7e4EMP
         6M0jRHT1BG9K4M6aE8zLe9AY7dn3tEWC/cIvZIvD3ISXJinhb2IXXCxakL/OYkQ1n+xs
         roYorRG4DcHcCDgIJG80Sv2codJvq2DWLy1Om3h/+w9OwskD5l48PpYERlrbojtepd12
         dXQw==
X-Gm-Message-State: AFqh2kqvYTzQ9oxaKx4JLCAEKXg9an5IJA55M4YjrgVFZaRQf/JSN9Xd
        H5lQouOlsaBFuHoWYv8Q2TH6Pc+djqx6D9yq50w=
X-Google-Smtp-Source: AMrXdXszpqTcKv3zjqBHWx0HIDMsGRcGB2lej/CKF7clkJP/fZweqMTpCRpxTsbZE0FhbnLaIy5eZDFCTREuND8JrCA=
X-Received: by 2002:a17:906:a18c:b0:7c0:f2cf:3515 with SMTP id
 s12-20020a170906a18c00b007c0f2cf3515mr2956112ejy.327.1672770841681; Tue, 03
 Jan 2023 10:34:01 -0800 (PST)
MIME-Version: 1.0
References: <20221222043507.33037-1-sunhao.th@gmail.com> <ef46c1f6-0939-c2ed-3efb-c3c5f28d1931@meta.com>
 <73E3CA9E-F67E-429F-A2DB-C77649E32D7A@gmail.com> <CAADnVQ+EMzAmeKvivFKvqCNj6H9X-1rBtBBnjRzDiNvkocsc6A@mail.gmail.com>
 <2EC740FA-A10B-4208-8080-9A268BD8E675@gmail.com>
In-Reply-To: <2EC740FA-A10B-4208-8080-9A268BD8E675@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 3 Jan 2023 10:33:50 -0800
Message-ID: <CAADnVQKzRS6HcbOPuJRJ=8SOXDDDdy2EBN-LP6vSgB9tLb27Ug@mail.gmail.com>
Subject: Re: kernel panic: Attempted to kill init!
To:     Hao Sun <sunhao.th@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 3, 2023 at 4:46 AM Hao Sun <sunhao.th@gmail.com> wrote:
>
>
>
> > On 31 Dec 2022, at 12:55 AM, Alexei Starovoitov <alexei.starovoitov@gma=
il.com> wrote:
> >
> > On Fri, Dec 30, 2022 at 1:54 AM Hao Sun <sunhao.th@gmail.com> wrote:
> >>
> >>
> >>
> >>> On 28 Dec 2022, at 2:35 PM, Yonghong Song <yhs@meta.com> wrote:
> >>>
> >>>
> >>>
> >>> On 12/21/22 8:35 PM, Hao Sun wrote:
> >>>> Hi,
> >>>> This crash can be triggered by executing the C reproducer for
> >>>> multiple times, which just keep loading the following prog as
> >>>> raw tracepoint into kmem_cache_free().
> >>>> The prog send SIGSEGV to current via bpf_send_signal_thread(),
> >>>> after load this, whoever tries to free mem would trigger this,
> >>>> kernel crashed when this happens to init.
> >>>> Seems we should filter init out in bpf_send_signal_common() by
> >>>> is_global_init(current), or maybe we should check this in the
> >>>> verifier?
> >>>
> >>> The helper is just to send a particular signal to *current*
> >>> thread. In typical use case, it is never a good idea to send
> >>> the signal to a *random* thread. In certain cases, maybe user
> >>> indeed wants to send the signal to init thread to observe
> >>> something. Note that such destructive side effect already
> >>> exists in the bpf land. For example, for a xdp program,
> >>> it could drop all packets to make machine not responsive
> >>> to ssh etc. Therefore, I recommend to keep the existing
> >>> bpf_send_signal_common() helper behavior.
> >>
> >> Sound the two are different cases. Not responsive in XDP seems like
> >> an intended behaviour, panic caused by killing init is buggy. If the
> >> last thread of global init was killed, kernel panic immediately.
> >
> > I don't get it. How was it possible that this prog was
> > executed with current =3D=3D pid 1 ?
>
> The prog is raw trace point and is attached to =E2=80=98kmem_cache_free=
=E2=80=99 event.
> When init triggered the event, the prog would be executed with pid 1.
> But, the reason of this crash is not very clear to me, because it=E2=80=
=99s
> really hard to debug with original C reproducer.
>
> The following is the corresponding Syz prog:
>
> # {Threaded:true Repeat:true RepeatTimes:0 Procs:1 Slowdown:1 Sandbox:non=
e SandboxArg:0 Leak:false NetInjection:true NetDevices:true NetReset:true C=
groups:true BinfmtMisc:true CloseFDs:true KCSAN:false DevlinkPCI:false NicV=
F:false USB:false VhciInjection:false Wifi:false IEEE802154:true Sysctl:tru=
e UseTmpDir:true HandleSegv:true Repro:false Trace:false LegacyOptions:{Col=
lide:false Fault:false FaultCall:0 FaultNth:0}}
> r0 =3D bpf$BPF_PROG_RAW_TRACEPOINT_LOAD(0x5, &(0x7f0000000000)=3D{0x11, 0=
xe, &(0x7f0000000400)=3DANY=3D[@ANYBLOB=3D"18000000000000000000000000000000=
180600000000000000000000000000001807000000000000000000000000000018080000000=
000000000000000000000180900000000000000000000000000002d00020000000000b70100=
000b000000850000007500000095"], &(0x7f00000000c0)}, 0x80)
> bpf$BPF_RAW_TRACEPOINT_OPEN(0x11, &(0x7f0000000100)=3D{&(0x7f0000000080)=
=3D'kmem_cache_free\x00', r0}, 0x10)

Does syzbot running without any user space?
Is syzbot itself a pid=3D1 ? and the only process ?
If so, the error would makes sense.
I guess we can add a safety check to bpf_send_signal_common
to prevent syzbot from killing itself.
