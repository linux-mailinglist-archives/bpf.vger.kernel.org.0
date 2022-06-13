Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5147554A1C0
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 23:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbiFMVtb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 17:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbiFMVta (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 17:49:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F18E186DA
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 14:49:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id o7so13634560eja.1
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 14:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mj0aCBhyQZJw1zgrpmTKHEA1dB6E9GPl8XkybTofU1c=;
        b=V5UW/DE/5eoV8pa+j+PmVx9inhXSkRCcVzzGQdmhiBp9CEhR86VI5dkvvyLpwxw3uW
         Z5RqAMMiXmmuOaYsfTVrl5QjhofMwkqXdEGwwcQS7OQR4oDZA48Utx+5UO6jS9k1MedX
         FaVriJbaiTccnt4A+ovCGm8tTlou13htuZOIb6eDgu6WQSIdsSKNAU2TW0QFn6VX/tIg
         tELGYDXbT6VOjE6or+vwmGjTU3s3XZXhue0Orn85U0GYuXItDoCFNpVRHVwyGdnbcim/
         lKw46pOrNhuHy/g7cM873Y2Vx8/lUxyTf22QmmuEEfO5yuLrQuOQMdPgZpMOvcCJqWhF
         Cp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mj0aCBhyQZJw1zgrpmTKHEA1dB6E9GPl8XkybTofU1c=;
        b=T/LoY1W8idwRw7o6TqYd+QZnp/5SP0ISRI8z6cgqi2aGXQNGo5sgYuB+4VWykxSbgX
         AAqZkzVCYL2AxiEWUjY5cllgSw4irehBNe9vgumVI/oktDR4wXmOGKJY7J/66kjaxtC8
         5Yip2n3AxLXIlNQJNivIlApuQ2Gwp0oHJgwJhMNkCA24bVXdhC9TXJctH6Q8nB8BvwaY
         OTzs+5nL4lz+kBeEPhSdLRWPnGnacoWojleKfy3YD5aICEkKTxEYF70TG8LO1K1Y5c9p
         mWwgG+4oYBobqWUVN2KmNR6paPC/boL3CHFagMw6PHFBq0qx5dQmwM2Clo4+oi8ROn1S
         3BZQ==
X-Gm-Message-State: AOAM531qjwur8M5LB3FFpVTsW0eRY3vCTCVYt5Bq3o8rSUnVlN62HyRF
        EW55WVdR/OFMfBwSvnxNj2mj7sgaIs7L2kyQpgUV81ud
X-Google-Smtp-Source: ABdhPJwbVW1tdtDSj+V9uzBbsy2iqDr9L4jZRYFqkDb6AwcrNjlTAgWpDOVI+JOBo6sra3Vy0BTWpVXmTn+YX2kmvCU=
X-Received: by 2002:a17:906:b816:b0:708:2e56:97d7 with SMTP id
 dv22-20020a170906b81600b007082e5697d7mr1554086ejb.502.1655156967744; Mon, 13
 Jun 2022 14:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220613025244.31595-1-quic_satyap@quicinc.com>
 <87r13s2a0j.fsf@toke.dk> <fc16df47-df2b-ffa2-4e66-5a3dc92cb4db@fb.com>
 <005f01d87f4d$9a075210$ce15f630$@quicinc.com> <CAADnVQJUyvhqjnn9OuB=GN=NgA3Wu59fQqLM8nzg_TWh1HnJ4Q@mail.gmail.com>
 <006701d87f6d$7fe0a060$7fa1e120$@quicinc.com>
In-Reply-To: <006701d87f6d$7fe0a060$7fa1e120$@quicinc.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 13 Jun 2022 14:49:14 -0700
Message-ID: <CAADnVQKq-e1TT1Y2uhgCaRY4CUP37dq0HuSyTdgtxkNfv8DQUg@mail.gmail.com>
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

On Mon, Jun 13, 2022 at 2:35 PM Satya Durga Srinivasu Prabhala
<quic_satyap@quicinc.com> wrote:
>
>
> On 6/13/22 2:01 PM, Alexei Starovoitov wrote:
> > is doesn't solve anything.
> > Please provide a reproducer.
>
> I'm trying to find an easy way to repro the issue, so far, unsuccessful.
>
> > iirc the task's affinity change can race even with preemption disabled
> > on this cpu. Why would s/migrate/preemption/ address the deadlock ?
>
> I don't think task's affinity change races with preemption disabled/enabled.
>
> Switching to preemption disable/enable calls helps as it's just simple
> counter increment and decrement with a barrier, but with migrate
> disable/enable when task's affinity changes, we run into recursive bug
> due to rq lock.

As Yonghong already explained, replacing migrate_disable
with preempt_disable around bpf prog invocation is not an option.
