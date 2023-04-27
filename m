Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE83E6F05E6
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 14:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243388AbjD0MgX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 08:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjD0MgW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 08:36:22 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D989B3AAA;
        Thu, 27 Apr 2023 05:36:21 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-74de7635180so809485185a.3;
        Thu, 27 Apr 2023 05:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682598981; x=1685190981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uamYaAPiGbEuD/CCuWzrQEEft21M2zokyUeiq+isD7s=;
        b=BTlbPFOcy9ohq/rnIcEzr3ktsmGoIkLS5TIak2p0WjRjIS7tVD1nIqK8H28Io6XqVb
         9aLFzRITd38OHn++1iixe4l+zH9eVbZwDAfhDkBPWusPk/VSHTt3diuofZ1nXTms4rWa
         JJDnLuoNxKzEPHBsTTAesrqHvIflWeuCV+ypelKfuvD4O+TPSpqMCXAzeoegikWjB/Xn
         oB//Q9Oj0JVMjfEMXdE+932BDwJurikQ3prEJSDaerswpy8Wg2pAA2X1sKEPI4tHB6Go
         ZHMRvXK14JUWYrPAmxUScss3xazUqYC7wB2ZNdtCocebfo9MWUezS6nhOC52uXfScmbO
         Xkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682598981; x=1685190981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uamYaAPiGbEuD/CCuWzrQEEft21M2zokyUeiq+isD7s=;
        b=kbVIus5Zlt1nLD/D602IavKg+fKqXa8euUDk5wNeoKeKslEGCRlnf/+FguDfLS7nNr
         J6OS79tYntZJI5mU8S0NEMJtcagDbH23QkSrOQTJWkoaC/7KZbmAFJ9+aJ/EqObjj/Y3
         VIpIh7k+9564H7g/f607IQDM+muou5KLm35tSuqVBKwA3ZWSyDUCZf6NWXsF9ztJEqZN
         XR+OHdg9S99O2R8wQuWrQdVUn9uXvDjenVOGaTr1ah+kcyRFgCTsbBT6N7BbxoHDkBMl
         U3PAvPdg5UG624P4gmPagdoy7DtOAxfHxAF2cW6HB6nTfR+GG2xwJ9N0XXgOPCTS1vNJ
         IiWg==
X-Gm-Message-State: AC+VfDxH0DdzGYSmcdfON4HaNzKOiGX6g63VQOGlZ8rfJB4Iu66akujw
        aDTw+E6YwojY5QuMYT4n6TkG8IA+UJ1Met7kKKQ=
X-Google-Smtp-Source: ACHHUZ6z1cQlttoN0k2H76P2WsRE9QHnUy28HBxx03rn8CVmetWUfgyzpbwJvo84hWza6TQwkxJK0ed6dgn0FdEClcE=
X-Received: by 2002:ad4:5fca:0:b0:615:29ab:e4c6 with SMTP id
 jq10-20020ad45fca000000b0061529abe4c6mr2008193qvb.45.1682598981060; Thu, 27
 Apr 2023 05:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230417154737.12740-1-laoar.shao@gmail.com> <20230417154737.12740-6-laoar.shao@gmail.com>
 <20230417201457.c43xfcukjzm4u6vx@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbC4Bz_VX52zmv=sScBf0hzscMAC4+EwMCpnd1BcaSVJSw@mail.gmail.com>
 <CAADnVQJw9BCK2itE5bZWdQYz7D-8KdcH96E885zUakEDAOrC+Q@mail.gmail.com>
 <CALOAHbCtPR26it_Wdk7T_TETMTh2se6rgEbL_KC5XKtzvObjiA@mail.gmail.com>
 <CAADnVQ+FO-+1OALTtgVkcpH3Adc6xS9qjzORyq2vwVtwY2UoxQ@mail.gmail.com>
 <20230424174049.1c9e54dd@rorschach.local.home> <CALOAHbAx+W3-iBS6=FsPPShbEuSSZeyQWvLque+uF9Suwe3-HA@mail.gmail.com>
 <CALOAHbAqsSq+gVg9xTYGAkrdZaFXc=PVoOYqej33dCEjWtHfFw@mail.gmail.com>
In-Reply-To: <CALOAHbAqsSq+gVg9xTYGAkrdZaFXc=PVoOYqej33dCEjWtHfFw@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 27 Apr 2023 20:35:45 +0800
Message-ID: <CALOAHbCXRwp9--MV2k8z3aJyAL6vzQLimtHgkeza7g0C=Edb8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: Improve tracing recursion prevention mechanism
To:     Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 27, 2023 at 8:15=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Thu, Apr 27, 2023 at 5:57=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Tue, Apr 25, 2023 at 5:40=E2=80=AFAM Steven Rostedt <rostedt@goodmis=
.org> wrote:
> > >
> > > On Wed, 19 Apr 2023 15:46:34 -0700
> > > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > >
> > > > No. Just one prog at entry into any of the kernel functions
> > > > and another prog at entry of funcs that 1st bpf prog called indirec=
tly.
> > > > Like one prog is tracing networking events while another
> > > > is focusing on mm. They should not conflict.
> > >
> > > You mean that you have:
> > >
> > > function start:
> > >   __bpf_prog_enter_recur()
> > >     bpf_program1()
> > >       __bpf_prog_enter_recur()
> > >         bpf_program2();
> > >       __bpf_prog_exit_recur()
> > >   __bpf_prog_exit_recur()
> > >
> > >   rest of function
> > >
> > > That is, a bpf program can be called within another bpf pogram betwee=
n
> > > the prog_enter and prog_exit(), that is in the same context (normal,
> > > softirq, irq, etc)?
> > >
> >
> > Right, that can happen per my verification. Below is a simple bpf
> > program to verify it.
> >
> > struct {
> >     __uint(type, BPF_MAP_TYPE_LPM_TRIE);
> >     __type(key, __u64);
> >     __type(value, __u64);
> >     __uint(max_entries, 1024);
> >     __uint(map_flags, BPF_F_NO_PREALLOC);
> > } write_map SEC(".maps");
> >
> > __u64 key;
> >
> > SEC("fentry/kernel_clone")
> > int program1()
> > {
> >     __u64 value =3D 1;
> >
> >     bpf_printk("before update");
> >     // It will call trie_update_elem and thus trigger program2.
> >     bpf_map_update_elem(&write_map, &key, &value, BPF_ANY);
> >     __sync_fetch_and_add(&key, 1);
> >     bpf_printk("after update");
> >     return 0;
> > }
> >
> > SEC("fentry/trie_update_elem")
> > int program2()
> > {
> >     bpf_printk("trie_update_elem");
> >     return 0;
> > }
> >
> > The result as follows,
> >
> >          kubelet-203203  [018] ....1  9579.862862:
> > __bpf_prog_enter_recur: __bpf_prog_enter_recur
> >          kubelet-203203  [018] ...11  9579.862869: bpf_trace_printk:
> > before update
> >          kubelet-203203  [018] ....2  9579.862869:
> > __bpf_prog_enter_recur: __bpf_prog_enter_recur
> >          kubelet-203203  [018] ...12  9579.862870: bpf_trace_printk:
> > trie_update_elem
> >          kubelet-203203  [018] ....2  9579.862870:
> > __bpf_prog_exit_recur: __bpf_prog_exit_recur
> >          kubelet-203203  [018] ...11  9579.862870: bpf_trace_printk:
> > after update
> >          kubelet-203203  [018] ....1  9579.862871:
> > __bpf_prog_exit_recur: __bpf_prog_exit_recur
> >
> > Note that we can't trace __bpf_prog_enter_recur and
> > __bpf_prog_exit_recur, so we have to modify the kernel to print them.
> >
>
> ... However, surprisingly it still works even after this patchset is
> applied, because the hardirq/softirq flag is set when the program2 is
> running, see also the flags in the above trace_pipe output. Is that
> expected ?!
> I need  some time to figure it out, but maybe you have a quick answer...

Answer it by myself, that is because of the
allowing-one-single-recursion rule. I misread the trace flags before.
Sorry about the noise.


--=20
Regards
Yafang
