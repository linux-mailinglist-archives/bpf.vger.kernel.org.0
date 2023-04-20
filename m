Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9B36E9599
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 15:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjDTNO6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 09:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjDTNO4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 09:14:56 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266777EFF
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 06:14:24 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2a8a5f6771fso4964681fa.3
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 06:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681996453; x=1684588453;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0pLoDaFrZZtWrYZAMIg/HC8CZPJKUIoHfsZdRM0zGwg=;
        b=gTAID/3fixXwCs0LoOrBH2GkjHh0TtW4CMxxn8uiq0q+1OyU1ZEhYpsZoLNKVntU5b
         AvWZJCAauDSbB3qGC6sRT390csjjzkSFMq3S+wk6a9VAcrfmDFyxvvA0SMb7yuWgb1ia
         WDLJJLwReE7txmjI2zm9lFdQqoB1js0LvidCsFdKqqMiHd6VM8JIjzEfYoOK1IzWNQIZ
         7uDxRUkHc8HN4upEMnmfriW3yFAjERJzMl9nJuD2tzLYZ2/0txxngaphMrDx6bko4gzf
         eNXFDTKzUmS/8iZP0z8+jwYlnJYGryudPZXpj+RrY85PRzPm+53Zl6pGkoHywkjs4/KC
         HQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681996453; x=1684588453;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0pLoDaFrZZtWrYZAMIg/HC8CZPJKUIoHfsZdRM0zGwg=;
        b=WTeovN6qCq29xQJEYr8lOqrBD8tNnxTYLVGhD5lF8fPtGNb7bP8+y0o9jebZQ4Ha4s
         nJMNExsRqijxRIDq0xeHKMKW6KTyZIbHi126/fmTqDTmXjRzBw1ECORxbRjvQvuCUCXX
         wPxKzZu5+E/xpx639h49x0GIGCFjCLzcjYSDKBFfuWQ4lwMfGwFBIz3MvIAMAWTUT+5J
         BNR7G8mQzIazSd9aFO2kVwSEFpD9/W3DSXTXctVL76yMKghwWXLKbEEhMjDPNpRsGGqw
         8Cc5oNXGC06baGMJPz/Nz1AA1xQy6dIRcYZWQP9eJIJXplHrVbyD+XQcrOdCSjXrRJsG
         5xSA==
X-Gm-Message-State: AAQBX9fR+8IqoXZj3PW2NOru/I8L8zU7qF9YbxaMKTVsTNAi8IZCWG39
        N1MJZSqTHZXmlJRMHoAMtIQ=
X-Google-Smtp-Source: AKy350bHLkPIJl6f8uJsA+4aGfxg4DeAsrV6p6bI/6TJ51vGnKp8ewyG+meoyWaiJoBGPzZrjzjo0Q==
X-Received: by 2002:ac2:5142:0:b0:4ee:db35:36cf with SMTP id q2-20020ac25142000000b004eedb3536cfmr470359lfd.10.1681996453344;
        Thu, 20 Apr 2023 06:14:13 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id r3-20020ac252a3000000b004e90dee5469sm214316lfm.157.2023.04.20.06.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 06:14:11 -0700 (PDT)
Message-ID: <f4c4aee644425842ee6aa8edf1da68f0a8260e7c.camel@gmail.com>
Subject: Re: bpf-next hang+kasan uaf refcount acquire splat when running
 test_progs
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     bpf@vger.kernel.org, Dave Marchevsky <davemarchevsky@fb.com>
Date:   Thu, 20 Apr 2023 16:14:09 +0300
In-Reply-To: <7e38a7462b76a23b67dbf62e068f3cd1727bd7b8.camel@gmail.com>
References: <ZEEp+j22imoN6rn9@strlen.de>
         <8c669c50ac494b9618e913f2e4096d5bdd8e2ee0.camel@gmail.com>
         <20230420125252.GA12121@breakpoint.cc>
         <7e38a7462b76a23b67dbf62e068f3cd1727bd7b8.camel@gmail.com>
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

On Thu, 2023-04-20 at 16:00 +0300, Eduard Zingerman wrote:
> On Thu, 2023-04-20 at 14:52 +0200, Florian Westphal wrote:
> > Eduard Zingerman <eddyz87@gmail.com> wrote:
> > > > BUG: KASAN: slab-out-of-bounds in bpf_refcount_acquire_impl+0x63/0x=
d0
> > > > Write of size 4 at addr ffff8881072b34e8 by task new_name/12847
> > > >=20
> > > > CPU: 1 PID: 12847 Comm: new_name Not tainted 6.3.0-rc6+ #129
> > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-=
20220807_005459-localhost 04/01/2014
> > > > Call Trace:
> > > >  <TASK>
> > > >  dump_stack_lvl+0x32/0x40
> > > >  print_address_description.constprop.0+0x2b/0x3d0
> > > >  ? bpf_refcount_acquire_impl+0x63/0xd0
> > > >  print_report+0xb0/0x260
> > > >  ? bpf_refcount_acquire_impl+0x63/0xd0
> > > >  ? kasan_addr_to_slab+0x9/0x70
> > > >  ? bpf_refcount_acquire_impl+0x63/0xd0
> > > >  kasan_report+0xad/0xd0
> > > >  ? bpf_refcount_acquire_impl+0x63/0xd0
> > > >  kasan_check_range+0x13b/0x190
> > > >  bpf_refcount_acquire_impl+0x63/0xd0
> > > >  bpf_prog_affcc6c9d58016ca___insert_in_tree_and_list+0x54/0x131
> > > >  bpf_prog_795203cdef4805f4_insert_and_remove_tree_true_list_true+0x=
15/0x11b
> > > >  bpf_test_run+0x2a0/0x5f0
> > > >  ? bpf_test_timer_continue+0x430/0x430
> > > >  ? kmem_cache_alloc+0xe5/0x260
> > > >  ? kasan_set_track+0x21/0x30
> > > >  ? krealloc+0x9e/0xe0
> > > >  bpf_prog_test_run_skb+0x890/0x1270
> > > >  ? __kmem_cache_free+0x9f/0x170
> > > >  ? bpf_prog_test_run_raw_tp+0x570/0x570
> > > >  ? __fget_light+0x52/0x4d0
> > > >  ? map_update_elem+0x680/0x680
> > > >  __sys_bpf+0x75e/0xd10
> > > >  ? bpf_link_by_id+0xa0/0xa0
> > > >  ? rseq_get_rseq_cs+0x67/0x650
> > > >  ? __blkcg_punt_bio_submit+0x1b0/0x1b0
> > > >  __x64_sys_bpf+0x6f/0xb0
> > > >  do_syscall_64+0x3a/0x80
> > > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > > RIP: 0033:0x7f2f6a8b392d
> > > > Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 4=
8 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01=
 f0 ff ff 73 01 c3 48 8b 0d d3 e4 0c 00 f7 d8 64 89 01 48
> > > > RSP: 002b:00007ffe46938328 EFLAGS: 00000206 ORIG_RAX: 0000000000000=
141
> > > > RAX: ffffffffffffffda RBX: 0000000007150690 RCX: 00007f2f6a8b392d
> > > > RDX: 0000000000000050 RSI: 00007ffe46938360 RDI: 000000000000000a
> > > > RBP: 00007ffe46938340 R08: 0000000000000064 R09: 00007ffe46938360
> > > > R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
> > > > R13: 00007ffe46938b78 R14: 0000000000e09db0 R15: 00007f2f6a9ff000
> > > >  </TASK>
> > > >=20
> > > > I can also reproduce this on bpf-next/780c69830ec6b27e0224586ce26bc=
89552fcf163.
> > > > Is this a known bug?
> > >=20
> > > Hi Florian,
> > >=20
> > > Thank you for the report, that's my bug :(
> > >=20
> > > After the suggested change I can run the ./test_progs till the end
> > >  (takes a few minutes, though). One test is failing: verifier_array_a=
ccess,
> > > this is because map it uses is not populated with values (as it was w=
hen this was
> > > a part ./test_verifier).
> >=20
> > Right, I see that failure too.
> > > However, in the middle of execution I do see a trace similar to yours=
:
> >=20
> > I see this as well, to get to it quicker:
> > ./test_progs --allow=3Drefcounted_kptr
> >=20
> >=20
> > > [   82.757127] ------------[ cut here ]------------
> > > [   82.757667] refcount_t: saturated; leaking memory.
> > > [   82.758098] WARNING: CPU: 0 PID: 176 at lib/refcount.c:22 refcount=
_warn_saturate+0x61/0xe0
> >=20
> > I get this one right after the kasan splat.
> >=20
> > > Could you please share your config?
> > > I'd like to reproduce the hang.
> >=20
> > It hangs for me if I just rerun=20
> > ./test_progs --allow=3Drefcounted_kptr
> >=20
> > a couple of times (maybe once per cpu...?).
> >=20
> > I'll send the config if that doesn't hang for you.
>=20
> Ok, I got the hang after executing the following couple of times:
>=20
> for i in $(seq 1 4); do (./test_progs --allow=3Drefcounted_kptr &); done
>=20
> And here is a dead lock warning in the dmesg:
>=20
> [ 1200.463933] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 1200.464382] WARNING: possible recursive locking detected
> [ 1200.464546] 6.3.0-rc6-01631-g780c69830ec6 #474 Tainted: G        W  OE=
    =20
> [ 1200.464546] --------------------------------------------
> [ 1200.464546] test_progs/4311 is trying to acquire lock:
> [ 1200.464546] ffffffff8276f518 (btf_idr_lock){+.-.}-{2:2}, at: btf_put+0=
x36/0x80
> [ 1200.464546]=20
> [ 1200.464546] but task is already holding lock:
> [ 1200.464546] ffffffff8276f518 (btf_idr_lock){+.-.}-{2:2}, at: bpf_find_=
btf_id+0xeb/0x1b0
> [ 1200.464546]=20
> [ 1200.464546] other info that might help us debug this:
> [ 1200.464546]  Possible unsafe locking scenario:
> [ 1200.464546]=20
> [ 1200.464546]        CPU0
> [ 1200.464546]        ----
> [ 1200.464546]   lock(btf_idr_lock);
> [ 1200.464546]   lock(btf_idr_lock);
> [ 1200.464546]=20
> [ 1200.464546]  *** DEADLOCK ***
> [ 1200.464546]=20
> [ 1200.464546]  May be due to missing lock nesting notation
> [ 1200.464546]=20
> [ 1200.464546] 1 lock held by test_progs/4311:
> [ 1200.464546]  #0: ffffffff8276f518 (btf_idr_lock){+.-.}-{2:2}, at: bpf_=
find_btf_id+0xeb/0x1b0
> [ 1200.464546]=20
> [ 1200.464546] stack backtrace:
> [ 1200.464546] CPU: 2 PID: 4311 Comm: test_progs Tainted: G        W  OE =
     6.3.0-rc6-01631-g780c69830ec6 #474
> [ 1200.464546] Call Trace:
> [ 1200.464546]  <TASK>
> [ 1200.464546]  dump_stack_lvl+0x47/0x70
> [ 1200.464546]  __lock_acquire+0x88b/0x2710
> [ 1200.464546]  ? __lock_acquire+0x350/0x2710
> [ 1200.464546]  lock_acquire+0xca/0x2c0
> [ 1200.464546]  ? btf_put+0x36/0x80
> [ 1200.464546]  ? lock_acquire+0xda/0x2c0
> [ 1200.464546]  _raw_spin_lock_irqsave+0x3e/0x60
> [ 1200.464546]  ? btf_put+0x36/0x80
> [ 1200.464546]  btf_put+0x36/0x80
> [ 1200.464546]  bpf_find_btf_id+0xf3/0x1b0
> [ 1200.464546]  btf_parse_fields+0x570/0xbf0
> [ 1200.464546]  ? lock_release+0x139/0x280
> [ 1200.464546]  ? __bpf_map_area_alloc+0xaa/0xd0
> [ 1200.464546]  ? __kmem_cache_alloc_node+0x14a/0x220
> [ 1200.464546]  ? rcu_is_watching+0xd/0x40
> [ 1200.464546]  ? __kmalloc_node+0xcb/0x140
> [ 1200.464546]  map_check_btf+0x9c/0x260
> [ 1200.464546]  __sys_bpf+0x274b/0x2ca0
> [ 1200.464546]  ? lock_release+0x139/0x280
> [ 1200.464546]  __x64_sys_bpf+0x1a/0x20
> [ 1200.464546]  do_syscall_64+0x35/0x80
> [ 1200.464546]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [ 1200.464546] RIP: 0033:0x7f659b7a15a9
> [ 1200.464546] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 27 08 0d 08
> [ 1200.464546] RSP: 002b:00007ffe984a7e88 EFLAGS: 00000206 ORIG_RAX: 0000=
000000000141
> [ 1200.464546] RAX: ffffffffffffffda RBX: 000055ebdcfae150 RCX: 00007f659=
b7a15a9
> [ 1200.464546] RDX: 0000000000000048 RSI: 00007ffe984a7f10 RDI: 000000000=
0000000
> [ 1200.464546] RBP: 00007ffe984a7ea0 R08: 00007ffe984a8000 R09: 00007ffe9=
84a7f10
> [ 1200.464546] R10: 0000000000000001 R11: 0000000000000206 R12: 000000000=
0000000
> [ 1200.464546] R13: 00007ffe984a8740 R14: 000055ebd91894f0 R15: 00007f659=
b8f0020
> [ 1200.464546]  </TASK>
> [ 1224.297533] watchdog: BUG: soft lockup - CPU#3 stuck for 23s! [test_pr=
ogs:4315]
> [ 1224.297533] Modules linked in: [last unloaded: bpf_testmod(OE)]
>=20
> The refcounted_kptr does use __retval annotations.
> So, we have a testing framework issue that masks BTF parsing issue...
>=20

And when executed on a freshly start VM (before the saturation warning)
the error is different:

[   15.673749] ------------[ cut here ]------------
[   15.674384] refcount_t: addition on 0; use-after-free.
[   15.674878] WARNING: CPU: 2 PID: 119 at lib/refcount.c:25 refcount_warn_=
saturate+0x80/0xe0
[   15.675613] Modules linked in: bpf_testmod(OE)
[   15.676019] CPU: 2 PID: 119 Comm: test_progs Tainted: G           OE    =
  6.3.0-rc6-01631-g780c69830ec6 #474
[   15.676859] RIP: 0010:refcount_warn_saturate+0x80/0xe0
[   15.677315] Code: 05 68 3a 34 01 01 e8 9f 1a b5 ff 0f 0b c3 80 3d 58 3a =
34 01 00 75 b8 48 c7 c7 f8 b0 0d 82 c6 05 48 3a 34 01 01 e8 80 1a b5 ff <0f=
> 0b c3 80 3d 3b 3a 34 01 00 75 99 48 c7 c7 db
[   15.678935] RSP: 0018:ffffc9000031bc80 EFLAGS: 00010282
[   15.679411] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[   15.680047] RDX: 0000000000000202 RSI: 00000000ffffffea RDI: 00000000000=
00001
[   15.680664] RBP: ffffc9000031bcb0 R08: ffffffff82745808 R09: 00000000fff=
fdfff
[   15.681289] R10: ffffffff82665820 R11: ffffffff82715820 R12: ffff888102b=
7a428
[   15.681957] R13: ffffc90000159048 R14: ffff888102b7a428 R15: 00000000000=
00000
[   15.682592] FS:  00007fd26beeeb80(0000) GS:ffff88817bd00000(0000) knlGS:=
0000000000000000
[   15.683272] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.683764] CR2: 0000558f51f65cd3 CR3: 0000000104034000 CR4: 00000000003=
506a0
[   15.684383] Call Trace:
[   15.684611]  <TASK>
[   15.684799]  bpf_refcount_acquire_impl+0x4a/0x50
[   15.685214]  bpf_prog_b3419cf1b56e14c4___insert_in_tree_and_list+0x54/0x=
131
[   15.685808]  bpf_prog_b5014ed510a2fac6_insert_and_remove_tree_true_list_=
true+0x15/0x11b
[   15.686562]  bpf_test_run+0x17f/0x300

