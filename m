Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA99E6EBE24
	for <lists+bpf@lfdr.de>; Sun, 23 Apr 2023 11:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjDWJFd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Apr 2023 05:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWJFc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Apr 2023 05:05:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAAF171B
        for <bpf@vger.kernel.org>; Sun, 23 Apr 2023 02:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682240684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3TXGg3hQ04PmG79s7294A+LB9+PdXN6D+hDAMvjCPsE=;
        b=FMBe3UBee1b25ypV8eqK19nFMw+27ZC2GgJHPxBUBL5uxzD+k+dGIVfKAMYnoXkzp7iRM4
        iOQV6pC2AVVfPXyaB0FX82q87Y6kRBmYbQLK6+S/P2yF6ZdXZ5xA7mazQ4uq58jHoKoBND
        CEavM/82zPSnDQ5obxIl+LmlXUOcnw8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-_dkSWrPKNsCmCjakLL4B7g-1; Sun, 23 Apr 2023 05:04:43 -0400
X-MC-Unique: _dkSWrPKNsCmCjakLL4B7g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0B501C05AB7;
        Sun, 23 Apr 2023 09:04:42 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.192.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7C2D1121318;
        Sun, 23 Apr 2023 09:04:41 +0000 (UTC)
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Artem Savkov <asavkov@redhat.com>,
        Viktor Malik <vmalik@redhat.com>,
        Jerome Marchand <jmarchan@redhat.com>
Subject: Re: sys_enter tracepoint ctx structure
References: <xunyjzy64q9b.fsf@redhat.com>
        <CAADnVQ+JdPGV95Y30PskgdOomU2K0UXsoCydgqaJfJ5j4S8BtQ@mail.gmail.com>
        <xunyjzy6z3vu.fsf@redhat.com>
        <CAADnVQK-Dig-5DB6tM_sgggyvqHUXSbBud0R=rAPWT2VRtQ-ZQ@mail.gmail.com>
        <xunyfs8uz0z1.fsf@redhat.com>
        <CAADnVQ+ZSTpUvV7fQ-UxCoRBCc8NYfcYHY0K9mKka=vhT6LO=Q@mail.gmail.com>
        <xunybkjhzdpe.fsf@redhat.com>
        <CAADnVQKGrSvJHXbsqzEF=QSuePF5KzGUKeC_HWsY56bTTSRWMw@mail.gmail.com>
Date:   Sun, 23 Apr 2023 12:04:40 +0300
In-Reply-To: <CAADnVQKGrSvJHXbsqzEF=QSuePF5KzGUKeC_HWsY56bTTSRWMw@mail.gmail.com>
        (Alexei Starovoitov's message of "Fri, 21 Apr 2023 09:02:34 -0700")
Message-ID: <xunybkjfyno7.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Alexei!

>>>>> On Fri, 21 Apr 2023 09:02:34 -0700, Alexei Starovoitov  wrote:
 > On Fri, Apr 21, 2023 at 4:17=E2=80=AFAM Yauheni Kaliuta <ykaliuta@redhat=
.com> wrote:
 >> >>>>> On Thu, 20 Apr 2023 16:12:49 -0700, Alexei Starovoitov  wrote:
 >> > On Thu, Apr 20, 2023 at 2:40=E2=80=AFPM Yauheni Kaliuta <ykaliuta@red=
hat.com> wrote:
 >> >> >>>>> On Thu, 20 Apr 2023 13:54:26 -0700, Alexei Starovoitov  wrote:
 >> >> > On Thu, Apr 20, 2023 at 1:37=E2=80=AFPM Yauheni Kaliuta <ykaliuta@=
redhat.com> wrote:
 >> >> >> >>>>> On Thu, 20 Apr 2023 08:59:09 -0700, Alexei Starovoitov  wro=
te:

[...]

 >> > Let's fix the kernel side too. Something like this should do it:
 >>=20
 >> > diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_sysca=
lls.c
 >> > index 942ddbdace4a..7aa1f4299486 100644
 >> > --- a/kernel/trace/trace_syscalls.c
 >> > +++ b/kernel/trace/trace_syscalls.c
 >> > @@ -555,7 +555,7 @@ static int perf_call_bpf_enter(struct
 >> > trace_event_call *call, struct pt_regs *re
 >> >                                struct syscall_trace_enter *rec)
 >> >  {
 >> >         struct syscall_tp_t {
 >> > -               unsigned long long regs;
 >> > +               struct trace_entry ent;
 >> >                 unsigned long syscall_nr;
 >> >                 unsigned long args[SYSCALL_DEFINE_MAXARGS];
 >> >         } param;
 >> > @@ -657,7 +657,7 @@ static int perf_call_bpf_exit(struct
 >> > trace_event_call *call, struct pt_regs *reg
 >> >                               struct syscall_trace_exit *rec)
 >> >  {
 >> >         struct syscall_tp_t {
 >> > -               unsigned long long regs;
 >> > +               struct trace_entry ent;
 >>=20
 >>=20
 >> > pls add build_bug_on that sizeof(ent) >=3D sizeof(void*).
 >>=20
 >> Ok. Should the line *(struct pt_regs **)&param =3D regs; be commented s=
omehow?

 > commented out?

No, no :)

 > No. It's mandatory.
 > And the reason for build_bug_on existence... to make sure that there
 > is enough space there.

Yes, it's clear for sure.

It can be not obvious why basically 'ent' is inited with
'regs'. Before it was called 'regs' at least.

--=20
WBR,
Yauheni Kaliuta

