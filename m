Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18068559EDC
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 18:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiFXQrA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 12:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiFXQq7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 12:46:59 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D6C53A75
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 09:46:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id t5so5906225eje.1
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pXV8+aET3FoQ5HjxLu1r8THoF+tZs5D/Xr7EgaJQfwo=;
        b=q13ZA5DuMXyJOMlisabTdnLZHCTrK/yzpdh/xx9ZhO/Bz00F+h05YYnCbVbiSLDO+O
         rnWCXSczQ4RtmPL/vPUAE57Qu0HGQ5liolX+z0chRn2Df682NGXqMl3v0jkEaPBlHe+Z
         C5GMnDr6/6llecL06+wscQF/mUnT16uiSZa+Sm3CAIQKlgE7Fb68ufmhjusXIEBPzneo
         Q1lj9nv6XxNmk7ZOQrJQKLnOO7UN65CoAEh9+ZHNeU2LJKNC5Tpw6SZhU+RKeCJ8HDMY
         Ygswo5GQB9r3bgKM2LI4YmQjYEN6ZXVTAzezTs+eAW4OKRhWgHrprQd4nUJfw592d8gU
         KdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pXV8+aET3FoQ5HjxLu1r8THoF+tZs5D/Xr7EgaJQfwo=;
        b=R7jGADfZvSA08syzlB+wJr/fTi3kXmRTNU2dt62t51Wx4+UNZaDLvdj9e40LWcr8+u
         G1M09O/X+/2XR7ZjxcT0x0Q4BD7IIoVZYEKa8WO/gHw/vnMM68KYUWWDQfGr3dzspJ1O
         7HERUbyfCPRkVTZOI7dxWFd2a8qlEaY/ec/DoyzfJy4NaJUnM9L8x7szA9fkVgilp2VC
         sW0CjynLi9YFH8R29yv2y3zhp2E9znQ0uDIU5o8Q2Axr26JDA6Lw1zrQUzFvxQMzRoy0
         dTEffBZVkIlntiTUEFRBs2rNcnjjd31GygtadPT68RXamWdrfwSShBMrJmcuyjvfN1xG
         MJJw==
X-Gm-Message-State: AJIora/vCBgB/cV50p5w5dgXvoHU3BWxmAcdW4kKQLJcbr8Wx9XWq9N5
        QGWXZkxEWM/Cefbio1q2wX8hi2bR/ts8Sh+Nazw=
X-Google-Smtp-Source: AGRyM1sCz0j5dubfi1jO9rTrv1wj2VaTyJTbqmOkKm4qTdXRAJwRJwhAgYuuRLw85r5JXwD77msUcdI963ZumdInzG4=
X-Received: by 2002:a17:907:608d:b0:722:ebcc:b108 with SMTP id
 ht13-20020a170907608d00b00722ebccb108mr14180319ejc.94.1656089217388; Fri, 24
 Jun 2022 09:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220613025244.31595-1-quic_satyap@quicinc.com>
 <87r13s2a0j.fsf@toke.dk> <fc16df47-df2b-ffa2-4e66-5a3dc92cb4db@fb.com>
 <005f01d87f4d$9a075210$ce15f630$@quicinc.com> <CAADnVQJUyvhqjnn9OuB=GN=NgA3Wu59fQqLM8nzg_TWh1HnJ4Q@mail.gmail.com>
 <006701d87f6d$7fe0a060$7fa1e120$@quicinc.com> <CAADnVQKq-e1TT1Y2uhgCaRY4CUP37dq0HuSyTdgtxkNfv8DQUg@mail.gmail.com>
 <009d01d87f8b$79f83140$6de893c0$@quicinc.com> <621b35ac-5c93-9a6d-eaf0-62cceb52cf34@fb.com>
 <002601d88797$8699d6b0$93cd8410$@quicinc.com>
In-Reply-To: <002601d88797$8699d6b0$93cd8410$@quicinc.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 24 Jun 2022 09:46:45 -0700
Message-ID: <CAADnVQJV2kJwZeynV_2FeZ8vKXGk=Ht+R5dj8OEtKHOpNeWa7w@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix rq lock recursion issue
To:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Cc:     Yonghong Song <yhs@fb.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 23, 2022 at 11:56 PM Satya Durga Srinivasu Prabhala
<quic_satyap@quicinc.com> wrote:
>
>
> On 6/13/22 11:09 PM, Yonghong Song wrote:
> >
> >
> > On 6/13/22 6:10 PM, Satya Durga Srinivasu Prabhala wrote:
> >>
> >> On 6/13/22 2:49 PM, Alexei Starovoitov wrote:
> >>> On Mon, Jun 13, 2022 at 2:35 PM Satya Durga Srinivasu Prabhala
> >>> <quic_satyap@quicinc.com> wrote:
> >>>>
> >>>> On 6/13/22 2:01 PM, Alexei Starovoitov wrote:
> >>>>> is doesn't solve anything.
> >>>>> Please provide a reproducer.
> >>>> I'm trying to find an easy way to repro the issue, so far,
> >>>> unsuccessful.
> >>>>
> >>>>> iirc the task's affinity change can race even with preemption
> >>>>> disabled
> >>>>> on this cpu. Why would s/migrate/preemption/ address the deadlock ?
> >>>> I don't think task's affinity change races with preemption
> >>>> disabled/enabled.
> >>>>
> >>>> Switching to preemption disable/enable calls helps as it's just simple
> >>>> counter increment and decrement with a barrier, but with migrate
> >>>> disable/enable when task's affinity changes, we run into recursive bug
> >>>> due to rq lock.
> >>> As Yonghong already explained, replacing migrate_disable
> >>> with preempt_disable around bpf prog invocation is not an option.
> >>
> >> If I understand correctly, Yonghong mentioned that replacing migrate_
> >> with preempt_ won't work for RT Kernels and migrate_ APIs were
> >> introduced
> >> for RT Kernels is what he was pointing to. I went back and cross checked
> >> on 5.10 LTS Kernel, I see that the migrate_ calls end up just calling
> >> into
> >> preemt_ calls [1]. So far non-RT kernels, sticking to preemt_ calls
> >> should
> >> still work. Please let me know if I missed anything.
> >
> > Yes, old kernel migrate_disable/enable() implementation with
> > simply preempt_disable/enable() are transitional. You can check
> > 5.12 kernel migrate_disable/enable() implementation. Note that
> > your patch, if accepted, will apply to the latest kernel. So we
> > cannot simply replace migrate_disable() with prempt_disable(),
> > which won't work for RT kernel.
>
> Thanks for getting back and apologies for the delay. I understand that
> we may break RT kernels with this patch. So, I was proposing to stick to
> migrate_disable/enable() calls on RT Kernels and use preempt_disable/enable()
> in case of non-RT Kernel. Which warrants change in scheduler, will push
> patch and try get feedback from Scheduler experts.

We will stay with migrate_disable/enable on all types of kernel.
This is not negotiable.

> While I'm here I would like to cross check with you xperts on ideas to
> reproduce the issue easily and consistently. Your inputs will immensely help to
> debug issue further.

Please do. No patches will be applied until there is a clear reproducer.
