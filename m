Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328DF23C7A3
	for <lists+bpf@lfdr.de>; Wed,  5 Aug 2020 10:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgHEITm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Aug 2020 04:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgHEITi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Aug 2020 04:19:38 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1772C06174A
        for <bpf@vger.kernel.org>; Wed,  5 Aug 2020 01:19:37 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id k12so15870822otr.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2020 01:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6DM8Dn4IuudK+xPvv76hPV2PzgXZLaDxlk+ZcRQIaXE=;
        b=SnD2TahYRgH9zIHqYkRAP7J2+PQ7nASqFqnolpa6yyjf3QbKUxCz+Ofn/S6dB6SyCP
         Xtw43s63ExJwwD17mZBLtedOdWB3xGPFicZ54sUy15u2ddskeJFhmf8dOIlAVHuG4D+P
         oDhtqSW1r/YqUurxH9RvqaazhggHSqSPBtQDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6DM8Dn4IuudK+xPvv76hPV2PzgXZLaDxlk+ZcRQIaXE=;
        b=pPHpnfUc1sAgVeHevXUbuh/p42gw45OdgB2r/TtBU46C/lXL12p/I/9ZpW4nurjhMb
         YqQCmuS1PWgArQcTbvdGjCaOkaeGuNM6eVaGcyuDhcW7qVzkPvgx7ACMKn+tRMlVpBZi
         oyPuiPlta64s4OYCnNup9MLlGp56jsfCs7yYT8VlDMvcCoyPZVBcXKNbof6yr6yU7UaG
         kk6W+Ao85DGsXaL9hmLqrsquhg9T3GE4JbYFqk2dljDlBccgCyLyxrSUyq+jazWYSgQy
         eKSEBKciNHh4MnctGV1vACipExCLUgem84S1J39WgvgFJ/vuu5iseiFLa8w/rP34yRxh
         Evmg==
X-Gm-Message-State: AOAM533SKy3YQCPyoX8s8uD3A+dF3vqc8ERmaVXUa5a0e81G0QNK9cQD
        HNwsyTD56yQtNSNBgzUXHl5K7k8b/dcwyyF1sClNQI1+
X-Google-Smtp-Source: ABdhPJxSqLYhyWiQHU05c4pQcOcGHMVJwHLuU1EBPvceMVEZBMvlc/DKyDCGz92652Ibvkslozxh6oEct41sj6y6+qw=
X-Received: by 2002:a9d:148:: with SMTP id 66mr1641766otu.132.1596615577089;
 Wed, 05 Aug 2020 01:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw99CPB-9bDdvodkYWA6Wwjqov+WkZ-5TZetmfuE3Swe=EQ@mail.gmail.com>
 <20200804160508.auvw56y5ayd6xbia@kafai-mbp.dhcp.thefacebook.com>
 <CACAyw99tB_8TyGR9apOjXuWSZ5-kEeMZNSMvUbPviGq4ECAAuQ@mail.gmail.com> <20200805002020.sq4qavce7kml5irk@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200805002020.sq4qavce7kml5irk@kafai-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 5 Aug 2020 09:19:25 +0100
Message-ID: <CACAyw994KRtvPWz5hap9PERSQYU12joF4QwtucH_CknbDxRfJQ@mail.gmail.com>
Subject: Re: BUG: Invalid wait context in bpf_sk_storage_free
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 5 Aug 2020 at 01:20, Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Aug 04, 2020 at 05:45:43PM +0100, Lorenz Bauer wrote:
> > On Tue, 4 Aug 2020 at 17:05, Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Tue, Aug 04, 2020 at 12:21:01PM +0100, Lorenz Bauer wrote:
> > > > Hi list,
> > > >
> > > > I just got this warning while running test progs on commit
> > > > 21594c44083c375697d418729c4b2e4522cf9f70 in the #4/22
> > > > bpf_sk_storage_map test.
> > > >
> > > > [   38.775254] =============================
> > > > [   38.775692] [ BUG: Invalid wait context ]
> > > > [   38.776234] 5.8.0-rc6+ #35 Not tainted
> > > > [   38.776699] -----------------------------
> > > > [   38.777141] test_progs/254 is trying to lock:
> > > > [   38.777650] ffff8881197f4450 (&krcp->lock){....}-{3:3}, at:
> > > > kfree_call_rcu+0x1a6/0x5b0
> > > > [   38.778589] other info that might help us debug this:
> > > > [   38.779155] context-{5:5}
> > > > [   38.779476] 3 locks held by test_progs/254:
> > > > [   38.779944]  #0: ffff88810dc3f020
> > > > (&sb->s_type->i_mutex_key#6){+.+.}-{4:4}, at:
> > > > __sock_release+0x76/0x280
> > > > [   38.780957]  #1: ffffffff83d66840 (rcu_read_lock){....}-{1:3}, at:
> > > > bpf_sk_storage_free+0x0/0x2a0
> > > > [   38.781878]  #2: ffff88810b6940b8 (&sk_storage->lock){+...}-{2:2},
> > > > at: bpf_sk_storage_free+0xa3/0x2a0
> > > > [   38.782812] stack backtrace:
> > > > [   38.783115] CPU: 1 PID: 254 Comm: test_progs Not tainted 5.8.0-rc6+ #35
> > > > [   38.783789] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > > > BIOS 1.13.0-1ubuntu1 04/01/2014
> > > > [   38.784711] Call Trace:
> > > > [   38.784976]  dump_stack+0x9e/0xe0
> > > > [   38.785429]  __lock_acquire.cold+0x3a6/0x46c
> > > > [   38.786025]  ? register_lock_class+0x17a0/0x17a0
> > > > [   38.786588]  lock_acquire+0x1be/0x7e0
> > > > [   38.787010]  ? kfree_call_rcu+0x1a6/0x5b0
> > > > [   38.787421]  ? check_flags+0x60/0x60
> > > > [   38.787790]  ? mark_lock+0x12c/0x1470
> > > > [   38.788179]  ? check_chain_key+0x215/0x5a0
> > > > [   38.788613]  ? print_usage_bug+0x1f0/0x1f0
> > > > [   38.789036]  _raw_spin_lock+0x2c/0x70
> > > > [   38.789415]  ? kfree_call_rcu+0x1a6/0x5b0
> > > > [   38.789829]  kfree_call_rcu+0x1a6/0x5b0
> > > > [   38.790239]  __selem_unlink_sk+0x1eb/0x520
> > > > [   38.790691]  bpf_sk_storage_free+0x118/0x2a0
> > > > [   38.791138]  __sk_destruct+0xd3/0x4d0
> > > > [   38.791525]  inet_release+0xf4/0x220
> > > > [   38.791939]  __sock_release+0xc0/0x280
> > > > [   38.792328]  sock_close+0xf/0x20
> > > > [   38.792676]  __fput+0x29b/0x7b0
> > > > [   38.793004]  task_work_run+0xcc/0x170
> > > > [   38.793429]  __prepare_exit_to_usermode+0x1c6/0x1d0
> > > > [   38.793948]  do_syscall_64+0x62/0xa0
> > > > [   38.794407]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > [   38.795004] RIP: 0033:0x7f73410e33d7
> > > > [   38.795376] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00
> > > > 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00
> > > > 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 f3 fb
> > > > ff ff
> > > > [   38.797266] RSP: 002b:00007ffc86615fe8 EFLAGS: 00000246 ORIG_RAX:
> > > > 0000000000000003
> > > > [   38.798030] RAX: 0000000000000000 RBX: 00007ffc86616040 RCX: 00007f73410e33d7
> > > > [   38.798755] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000008
> > > > [   38.799488] RBP: 000055fa708beb60 R08: 0000000000000007 R09: 000000000000002c
> > > > [   38.800241] R10: 000055fa6abd508d R11: 0000000000000246 R12: 000000000000000d
> > > > [   38.801007] R13: 00007ffc86616034 R14: 000000000000000c R15: 000055fa708bcb30
> > > >
> > > > Not sure if this is useful or not, a quick search in the mailing list
> > > > didn't bring anything up.
> > > I cannot reproduce after running test_progs -t bpf_iter/bpf_sk_storage_map in
> > > a loop.  Can you share you config?
> >
> > Here you go: https://gist.github.com/lmb/0f19df936b296df34e4cb90dec6c3032
> I can reproduce now.  The splat is from the "CONFIG_PROVE_RAW_LOCK_NESTING=y"
> in the posted config above:
>
> config PROVE_RAW_LOCK_NESTING
>         bool "Enable raw_spinlock - spinlock nesting checks"
>         depends on PROVE_LOCKING
>         default n
>         help
>          Enable the raw_spinlock vs. spinlock nesting checks which ensure
>          that the lock nesting rules for PREEMPT_RT enabled kernels are
>          not violated.
>
>          NOTE: There are known nesting problems. So if you enable this
>          option expect lockdep splats until these problems have been fully
>          addressed which is work in progress. This config switch allows to
>          identify and analyze these problems. It will be removed and the
>          check permanentely enabled once the main issues have been fixed.
>
>          If unsure, select N.
>
> There are known issues in kfree_rcu() in PREEMPT_RT.  My understanding is
> some of them are being worked on, e.g.
> https://lore.kernel.org/lkml/20200624201226.21197-2-paulmck@kernel.org/
> https://lore.kernel.org/lkml/20200803163029.1997-1-urezki@gmail.com/

Thanks for taking a look, I'll disable this for now then!

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
