Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2E16E9534
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 15:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjDTNAb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 09:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjDTNAa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 09:00:30 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290945B85
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 06:00:27 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2a8bca69e8bso4835031fa.3
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 06:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681995625; x=1684587625;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ujUphIIxQhspo/tpZF0+Y9CQ0mDCgH5i1nU5+4Pqbw0=;
        b=Z7lMfiXZ+nNE5xgR653k2RY1qHJpq92HeXTXXB+By0qb+pzcWb3kdVxujnNtt0gCt+
         Gel8oqjWL2lNE5J5Spp+A1rB5y6EgtukkEddFTEdMhVr7ryBPGzc0+JQ2Hh0VRhuvLgb
         NhM8d1QOfTY1+KnlxeJaTmRNBp5R3PPzmnmBVAP6aReajuLb+nYDzyRMPCqynrybjZB0
         sxlyDyCL7DD/dZFY7LFgp0TihhJmjGH5i/t5Nr1oNRj2G2EU5E6YGJpmtwdjiJBkC6Dl
         lk1fUmKfU8Sk0jwLYMiAViZbhBAM/Z25immGxwGVdAv1Thw/kVXLBsH5mRHKaW2eSeJn
         scLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681995625; x=1684587625;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ujUphIIxQhspo/tpZF0+Y9CQ0mDCgH5i1nU5+4Pqbw0=;
        b=MIXhhK/DTUS/kv5n0DQGb+U9O3uFAt6fvR9rckjFQOh0x4V84dl5DtzirmuDgeSPuA
         QpQNRzG5n5QL62e7rDVh1ZYEfWHdNow8QmWBOrhRa2VvIfHJ9JCLfWzoHCdJqXM7lgFD
         tgTOjM9ZwH9P8yUdc2dRFebNINIFRj9lq/J5G2/ZYtSsHNhTb1Aaa7Qi76iAvYe6oNf7
         QeEqOimKatnV4NnK0O3fJdvQTTTvgF0DVx73fqLcOBQu+KityCA0O20FYMZFIUGSL9Si
         PFWcxN1O+8V6MZI4z/AOQpOd3cClimYd+w7TyAiYd+NOs4Cs4YJrTZbPfjsqC5WFggLU
         3BVA==
X-Gm-Message-State: AAQBX9dWYhKnZoqIxJ7cQfTUbo3+L/Q1oLsYoDtH2jvyZ5GDHblVgdU5
        eYmCKbZZ2arufOkMwra+FmA=
X-Google-Smtp-Source: AKy350aXSqzGYFqJrjpWyhw7ghHwmIdCeoD6/1apvT0X3gFOAU7QXe/Yo8vieN/B1d5HUshj6zeJRQ==
X-Received: by 2002:ac2:4563:0:b0:4ec:8b57:b018 with SMTP id k3-20020ac24563000000b004ec8b57b018mr410746lfm.33.1681995625160;
        Thu, 20 Apr 2023 06:00:25 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c19-20020ac244b3000000b004eed68a68efsm208146lfm.280.2023.04.20.06.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 06:00:24 -0700 (PDT)
Message-ID: <7e38a7462b76a23b67dbf62e068f3cd1727bd7b8.camel@gmail.com>
Subject: Re: bpf-next hang+kasan uaf refcount acquire splat when running
 test_progs
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     bpf@vger.kernel.org, Dave Marchevsky <davemarchevsky@fb.com>
Date:   Thu, 20 Apr 2023 16:00:23 +0300
In-Reply-To: <20230420125252.GA12121@breakpoint.cc>
References: <ZEEp+j22imoN6rn9@strlen.de>
         <8c669c50ac494b9618e913f2e4096d5bdd8e2ee0.camel@gmail.com>
         <20230420125252.GA12121@breakpoint.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-04-20 at 14:52 +0200, Florian Westphal wrote:
> Eduard Zingerman <eddyz87@gmail.com> wrote:
> > > BUG: KASAN: slab-out-of-bounds in bpf_refcount_acquire_impl+0x63/0xd0
> > > Write of size 4 at addr ffff8881072b34e8 by task new_name/12847
> > >=20
> > > CPU: 1 PID: 12847 Comm: new_name Not tainted 6.3.0-rc6+ #129
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-20=
220807_005459-localhost 04/01/2014
> > > Call Trace:
> > >  <TASK>
> > >  dump_stack_lvl+0x32/0x40
> > >  print_address_description.constprop.0+0x2b/0x3d0
> > >  ? bpf_refcount_acquire_impl+0x63/0xd0
> > >  print_report+0xb0/0x260
> > >  ? bpf_refcount_acquire_impl+0x63/0xd0
> > >  ? kasan_addr_to_slab+0x9/0x70
> > >  ? bpf_refcount_acquire_impl+0x63/0xd0
> > >  kasan_report+0xad/0xd0
> > >  ? bpf_refcount_acquire_impl+0x63/0xd0
> > >  kasan_check_range+0x13b/0x190
> > >  bpf_refcount_acquire_impl+0x63/0xd0
> > >  bpf_prog_affcc6c9d58016ca___insert_in_tree_and_list+0x54/0x131
> > >  bpf_prog_795203cdef4805f4_insert_and_remove_tree_true_list_true+0x15=
/0x11b
> > >  bpf_test_run+0x2a0/0x5f0
> > >  ? bpf_test_timer_continue+0x430/0x430
> > >  ? kmem_cache_alloc+0xe5/0x260
> > >  ? kasan_set_track+0x21/0x30
> > >  ? krealloc+0x9e/0xe0
> > >  bpf_prog_test_run_skb+0x890/0x1270
> > >  ? __kmem_cache_free+0x9f/0x170
> > >  ? bpf_prog_test_run_raw_tp+0x570/0x570
> > >  ? __fget_light+0x52/0x4d0
> > >  ? map_update_elem+0x680/0x680
> > >  __sys_bpf+0x75e/0xd10
> > >  ? bpf_link_by_id+0xa0/0xa0
> > >  ? rseq_get_rseq_cs+0x67/0x650
> > >  ? __blkcg_punt_bio_submit+0x1b0/0x1b0
> > >  __x64_sys_bpf+0x6f/0xb0
> > >  do_syscall_64+0x3a/0x80
> > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > RIP: 0033:0x7f2f6a8b392d
> > > Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 =
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f=
0 ff ff 73 01 c3 48 8b 0d d3 e4 0c 00 f7 d8 64 89 01 48
> > > RSP: 002b:00007ffe46938328 EFLAGS: 00000206 ORIG_RAX: 000000000000014=
1
> > > RAX: ffffffffffffffda RBX: 0000000007150690 RCX: 00007f2f6a8b392d
> > > RDX: 0000000000000050 RSI: 00007ffe46938360 RDI: 000000000000000a
> > > RBP: 00007ffe46938340 R08: 0000000000000064 R09: 00007ffe46938360
> > > R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
> > > R13: 00007ffe46938b78 R14: 0000000000e09db0 R15: 00007f2f6a9ff000
> > >  </TASK>
> > >=20
> > > I can also reproduce this on bpf-next/780c69830ec6b27e0224586ce26bc89=
552fcf163.
> > > Is this a known bug?
> >=20
> > Hi Florian,
> >=20
> > Thank you for the report, that's my bug :(
> >=20
> > After the suggested change I can run the ./test_progs till the end
> >  (takes a few minutes, though). One test is failing: verifier_array_acc=
ess,
> > this is because map it uses is not populated with values (as it was whe=
n this was
> > a part ./test_verifier).
>=20
> Right, I see that failure too.
> > However, in the middle of execution I do see a trace similar to yours:
>=20
> I see this as well, to get to it quicker:
> ./test_progs --allow=3Drefcounted_kptr
>=20
>=20
> > [   82.757127] ------------[ cut here ]------------
> > [   82.757667] refcount_t: saturated; leaking memory.
> > [   82.758098] WARNING: CPU: 0 PID: 176 at lib/refcount.c:22 refcount_w=
arn_saturate+0x61/0xe0
>=20
> I get this one right after the kasan splat.
>=20
> > Could you please share your config?
> > I'd like to reproduce the hang.
>=20
> It hangs for me if I just rerun=20
> ./test_progs --allow=3Drefcounted_kptr
>=20
> a couple of times (maybe once per cpu...?).
>=20
> I'll send the config if that doesn't hang for you.

Ok, I got the hang after executing the following couple of times:

for i in $(seq 1 4); do (./test_progs --allow=3Drefcounted_kptr &); done

And here is a dead lock warning in the dmesg:

[ 1200.463933] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 1200.464382] WARNING: possible recursive locking detected
[ 1200.464546] 6.3.0-rc6-01631-g780c69830ec6 #474 Tainted: G        W  OE  =
  =20
[ 1200.464546] --------------------------------------------
[ 1200.464546] test_progs/4311 is trying to acquire lock:
[ 1200.464546] ffffffff8276f518 (btf_idr_lock){+.-.}-{2:2}, at: btf_put+0x3=
6/0x80
[ 1200.464546]=20
[ 1200.464546] but task is already holding lock:
[ 1200.464546] ffffffff8276f518 (btf_idr_lock){+.-.}-{2:2}, at: bpf_find_bt=
f_id+0xeb/0x1b0
[ 1200.464546]=20
[ 1200.464546] other info that might help us debug this:
[ 1200.464546]  Possible unsafe locking scenario:
[ 1200.464546]=20
[ 1200.464546]        CPU0
[ 1200.464546]        ----
[ 1200.464546]   lock(btf_idr_lock);
[ 1200.464546]   lock(btf_idr_lock);
[ 1200.464546]=20
[ 1200.464546]  *** DEADLOCK ***
[ 1200.464546]=20
[ 1200.464546]  May be due to missing lock nesting notation
[ 1200.464546]=20
[ 1200.464546] 1 lock held by test_progs/4311:
[ 1200.464546]  #0: ffffffff8276f518 (btf_idr_lock){+.-.}-{2:2}, at: bpf_fi=
nd_btf_id+0xeb/0x1b0
[ 1200.464546]=20
[ 1200.464546] stack backtrace:
[ 1200.464546] CPU: 2 PID: 4311 Comm: test_progs Tainted: G        W  OE   =
   6.3.0-rc6-01631-g780c69830ec6 #474
[ 1200.464546] Call Trace:
[ 1200.464546]  <TASK>
[ 1200.464546]  dump_stack_lvl+0x47/0x70
[ 1200.464546]  __lock_acquire+0x88b/0x2710
[ 1200.464546]  ? __lock_acquire+0x350/0x2710
[ 1200.464546]  lock_acquire+0xca/0x2c0
[ 1200.464546]  ? btf_put+0x36/0x80
[ 1200.464546]  ? lock_acquire+0xda/0x2c0
[ 1200.464546]  _raw_spin_lock_irqsave+0x3e/0x60
[ 1200.464546]  ? btf_put+0x36/0x80
[ 1200.464546]  btf_put+0x36/0x80
[ 1200.464546]  bpf_find_btf_id+0xf3/0x1b0
[ 1200.464546]  btf_parse_fields+0x570/0xbf0
[ 1200.464546]  ? lock_release+0x139/0x280
[ 1200.464546]  ? __bpf_map_area_alloc+0xaa/0xd0
[ 1200.464546]  ? __kmem_cache_alloc_node+0x14a/0x220
[ 1200.464546]  ? rcu_is_watching+0xd/0x40
[ 1200.464546]  ? __kmalloc_node+0xcb/0x140
[ 1200.464546]  map_check_btf+0x9c/0x260
[ 1200.464546]  __sys_bpf+0x274b/0x2ca0
[ 1200.464546]  ? lock_release+0x139/0x280
[ 1200.464546]  __x64_sys_bpf+0x1a/0x20
[ 1200.464546]  do_syscall_64+0x35/0x80
[ 1200.464546]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[ 1200.464546] RIP: 0033:0x7f659b7a15a9
[ 1200.464546] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 27 08 0d 08
[ 1200.464546] RSP: 002b:00007ffe984a7e88 EFLAGS: 00000206 ORIG_RAX: 000000=
0000000141
[ 1200.464546] RAX: ffffffffffffffda RBX: 000055ebdcfae150 RCX: 00007f659b7=
a15a9
[ 1200.464546] RDX: 0000000000000048 RSI: 00007ffe984a7f10 RDI: 00000000000=
00000
[ 1200.464546] RBP: 00007ffe984a7ea0 R08: 00007ffe984a8000 R09: 00007ffe984=
a7f10
[ 1200.464546] R10: 0000000000000001 R11: 0000000000000206 R12: 00000000000=
00000
[ 1200.464546] R13: 00007ffe984a8740 R14: 000055ebd91894f0 R15: 00007f659b8=
f0020
[ 1200.464546]  </TASK>
[ 1224.297533] watchdog: BUG: soft lockup - CPU#3 stuck for 23s! [test_prog=
s:4315]
[ 1224.297533] Modules linked in: [last unloaded: bpf_testmod(OE)]

The refcounted_kptr does use __retval annotations.
So, we have a testing framework issue that masks BTF parsing issue...

