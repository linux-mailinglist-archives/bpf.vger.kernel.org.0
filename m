Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F89653121A
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 18:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbiEWPWb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 11:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237842AbiEWPV7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 11:21:59 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E70036B45
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 08:21:56 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id z6so15252272vsp.0
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 08:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m6XXQuHPwwQn+dkW9Dk35i1PpW0XB0zk5QI4ALOKEaA=;
        b=GZgtf7+aHefZNnI/GJuqgpXJgD3+8AXOljN2l9+glvu67rCAtCIdVQofTuyAy+BaYE
         U2vEgaxFjWcKVkrIlMPHL0HXC+RiurNj2LCnEo6Lmko1za+5QAuEl4rxyYsvl4Nr+fRO
         x3NZU9KkRiij1FF9R64hymjSwp7/j2mJPJ3YTylyiK291hRuWR1roSmwmCjIJeig05mj
         UqScmOirXkX36Qgfyb2LWZH47ZyDZkQRHKaI5LL8i2x/SfUxq9U+Ri78uL7u2lKYBEjM
         ir8ybJRx+yO75rij9YZ8JylQRo0v2mRQ71PaoqVR5EXgh/ApQmrDvzRI9JBM0gpvKt2j
         nvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m6XXQuHPwwQn+dkW9Dk35i1PpW0XB0zk5QI4ALOKEaA=;
        b=fJSsensVE58LS0IU8JJOdocJD+EvD+dcicTM3PI8NS63rKnGIJQ3ei40Se6Oj8KRPC
         TI+Mlh1eCIPN6M7+yNC/OXFX0rZd+04idfOaQmNCMOIWtwT2z0pjN8gETU9E19Bv25fL
         tXJif0aOS01Unydh6a3DLYAambL5Pe7oKuYuDOqolcsDs6s8AhqyizRgf1wgwziw/WXQ
         H+otxy2rWTtpEHRehZhpNovKKkhq3L7tExf17jxXl/CKzwbxW3GQvA7TkcT/35AsAX5F
         c7/qWXuRIkcS4/2ti0FTLdaMkEsvxlPO5gd2duWG++E14ApfdPVr0QJ42feYVoZXBVp8
         BcQA==
X-Gm-Message-State: AOAM531IedSRVQfbKojaggapLU/OrmVv3fI/wNzUg6KLFLUnT/BwU/yk
        Jabqar+oaL6dd/JtTkfkh+U8qEZWgcFoaP8LG/NwMrNgSS0=
X-Google-Smtp-Source: ABdhPJxrL6d6nFz6jFYMpwYkH6X4dFXoW2N6IHcjJtE3e0Bdy8CiuaPjzCLrv9xc060BdIlA/bT0M64iXr2fkf0sN8M=
X-Received: by 2002:a67:c502:0:b0:337:ac26:a1da with SMTP id
 e2-20020a67c502000000b00337ac26a1damr2482276vsk.65.1653319315610; Mon, 23 May
 2022 08:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAK3+h2xA+K-yby7m+3Hp1G6qinafZPW1OB=Uk5-AKxUfztBtEA@mail.gmail.com>
 <YotBr8cRTx8qt8Ot@syu-laptop> <YotDQtN4qhqBVi22@syu-laptop>
In-Reply-To: <YotDQtN4qhqBVi22@syu-laptop>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Mon, 23 May 2022 08:21:44 -0700
Message-ID: <CAK3+h2ynxJCX8GNWmJ=FAiqsiAOYnFQYORVDjgxL0bUTL6XrFA@mail.gmail.com>
Subject: Re: libbpf: failed to load program 'vxlan_get_tunnel_src'
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     bpf <bpf@vger.kernel.org>
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

On Mon, May 23, 2022 at 1:18 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
>
> On Mon, May 23, 2022 at 04:11:27PM +0800, Shung-Hsi Yu wrote:
> > On Thu, May 19, 2022 at 08:25:00AM -0700, Vincent Li wrote:
> > > Hi,
> > >
> > > Here is my step to run bpf selftest on Ubuntu 20.04.2 LTS
> > >
> > > git clone https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> > > cd bpf-next; cp /boot/config-5.10.0-051000-generic .config; yes "" |
> > > make oldconfig; make bzImage; make modules; cd
> > > tools/testing/selftests/bpf/; make
> >
> > [snip...]
> >
> > > ; bpf_printk("vxlan key %d local ip 0x%x remote ip 0x%x gbp 0x%x\n",
> > >
> > > 46: (7b) *(u64 *)(r10 -88) = r2
> > >
> > > 47: (7b) *(u64 *)(r10 -72) = r1
> > >
> > > 48: (61) r1 = *(u32 *)(r10 -48)
> > >
> > > 49: (7b) *(u64 *)(r10 -96) = r1
> > >
> > > 50: (61) r1 = *(u32 *)(r10 -44)
> > >
> > > 51: (7b) *(u64 *)(r10 -80) = r1
> > >
> > > 52: (bf) r3 = r10
> > >
> > > 53: (07) r3 += -96
> > >
> > > 54: (18) r1 = 0xffffabaec02c82af
> > >
> > > 56: (b4) w2 = 52
> > >
> > > 57: (b4) w4 = 32
> > >
> > > 58: (85) call unknown#177
> > >
> > > invalid func unknown#177
> >
> > This should be the reason that why vxlan_get_tunnel_src fails to load, the
> > kernel does not recognize the helper function that the program is trying to
> > call.
>
> Just realized Andrii already pointed this out in an earlier email. Consider
> this an expanded answer to his then :)
>

Thank you both for the answer, I was wondering where the number #177
came from, you
answered it :)

> > And that helper function is bpf_trace_vprintk (determined with v5.17.4
> > vmlinux).
> >
> >  $ bpftool btf dump file /sys/kernel/btf/vmlinux format c | grep -e 'BPF_FUNC_.* 177,'
> >       BPF_FUNC_trace_vprintk = 177,
> >
> > Based on your description you're using a v5.10-based kernel, which explains
> > why it doesn't have bpf_trace_vprintk(), since it was not added until commit
> > 10aceb629e19 ("bpf: Add bpf_trace_vprintk helper") in v5.16.
> >
> > The call to bpf_trace_vprintk() comes from the bpf_printk() call, which is
> > actually a macro that uses either bpf_trace_printk() or bpf_trace_vprintk()
> > depending on the number of arguments given[1].
> >
> > In general I think it'd make more sense to run bpf-next selftests on a
> > bpf-next kernel, either compile and install on the machine that you're
> > testing on or use tools/testing/selftests/bpf/vmtest.sh which spins up a VM
> > with suitable environment (though I haven't tried vmtest.sh myself).
> >
> >
> > Shung-Hsi
> >
> > 1: https://github.com/libbpf/libbpf/blob/master/src/bpf_helpers.h
> >
> > > processed 64 insns (limit 1000000) max_states_per_insn 1 total_states
> > > 5 peak_states 5 mark_read 2
> > >
> > > -- END PROG LOAD LOG --
> > >
> > > libbpf: failed to load program 'vxlan_get_tunnel_src'
> > >
> > > libbpf: failed to load object 'test_tunnel_kern'
> > >
> > > libbpf: failed to load BPF skeleton 'test_tunnel_kern': -22
> > >
> > > test_ip6vxlan_tunnel:FAIL:test_tunnel_kern__open_and_load unexpected error: -22
> > >
> > > serial_test_tunnel:PASS:pthread_join 0 nsec
> > >
> > > #198/2     tunnel/ip6vxlan_tunnel:FAIL
> > >
> > > #198       tunnel:FAIL
> > >
> > > Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
> > >
> >
> >
>
