Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FB54AFDC0
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 20:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiBITw5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 14:52:57 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiBITw5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 14:52:57 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C5DE053800
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 11:52:58 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id w20so3124510plq.12
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 11:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bPUWYWVVdHt6mK4wfAiUbyKDK3zLnDRZPYVMvtXfO60=;
        b=AI9vS/PO0u7mwlATsnq/eK4/KNxFMgg++v4728+Z9DW1EJlPkSuuwo92w0EYNJAoPk
         Fmdg8F8s1UjPQX7F1ABOhdjHHMjf4mbgPPUQ+y/S8X3nOirMIMl3K5h8/1vEEckF4aaF
         Ey32DziB2vmlnFmkFxSXaUmoN6jqkPABHjmRrqBOIl7Z09Ii/xL0klnoxksCbw5q668T
         G5h2MnN0zMr9WROzuhVT/alQhIQX+8IIGZbkj/k9WPqNYNd6C1NzoGKKp5UzI/76Of3x
         BnQp129JO9kuEsC+XkgsEJUNYo3qmcumpEBJId7swUwnzGlht7QotVXs7w0m3/GWwdgi
         AbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bPUWYWVVdHt6mK4wfAiUbyKDK3zLnDRZPYVMvtXfO60=;
        b=FBH+UpTi+z5HnLiuYzdvxuZI+QGcg/UULpJde7eVL4Ea3iNDBZztiJvLlS9eBPflQD
         6voNVt3vBmSrs1naNT9yPbFII/jDB/+D+Cu70uJms1Fxk79SFKqsap0gNzlriwVUPECg
         52hr+DSWfj9gu1fkEugsX0cED+zfPXOm77cYelgOi2dFB6qZxI2xJJLbWwUPDKz3DYm4
         SxzMQHfvWmEpn1DB4G5zdW92Tze+o9g2jjycZAYy3JXe7MQkRG4zVrE6YaRcm3FCu0Bd
         r9TLfxeTp/dEwcQAeXeh+Xma87rQW3Dhn9psyQnz4R38bhqOHFOoIjhe2HxAx9DvVpUk
         uyvg==
X-Gm-Message-State: AOAM5314IHlpKfvBNah465NSL34YiLwDSITrb5abddGGEzFxtLJ1HSfm
        bID+y8rbu2kkFS6kfxNDHGE=
X-Google-Smtp-Source: ABdhPJx+ObDM3e0IvLK8wOGQZ8rfWbJijXvG+mWzfnQsDhxEQLxsp+LdzuQYlF935SAL4rjz6lew3g==
X-Received: by 2002:a17:902:f707:: with SMTP id h7mr3781698plo.96.1644436377471;
        Wed, 09 Feb 2022 11:52:57 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id y13sm20488406pfi.2.2022.02.09.11.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 11:52:57 -0800 (PST)
Date:   Thu, 10 Feb 2022 01:22:54 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix crash due to incorrect copy_map_value
Message-ID: <20220209195254.mmugfdxarlrry7ok@apollo.legion>
References: <20220209070324.1093182-1-memxor@gmail.com>
 <20220209070324.1093182-2-memxor@gmail.com>
 <57359c7b-7c6b-cfc9-22e8-5288a6ce0517@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57359c7b-7c6b-cfc9-22e8-5288a6ce0517@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 10, 2022 at 12:36:08AM IST, Yonghong Song wrote:
>
>
> On 2/8/22 11:03 PM, Kumar Kartikeya Dwivedi wrote:
> > When both bpf_spin_lock and bpf_timer are present in a BPF map value,
> > copy_map_value needs to skirt both objects when copying a value into and
> > out of the map. However, the current code does not set both s_off and
> > t_off in copy_map_value, which leads to a crash when e.g. bpf_spin_lock
> > is placed in map value with bpf_timer, as bpf_map_update_elem call will
> > be able to overwrite the other timer object.
> >
> > When the issue is not fixed, an overwriting can produce the following
> > splat:
> >
> > [root@(none) bpf]# ./test_progs -t timer_crash
> > [   15.930339] bpf_testmod: loading out-of-tree module taints kernel.
> > [   16.037849] ==================================================================
> > [   16.038458] BUG: KASAN: user-memory-access in __pv_queued_spin_lock_slowpath+0x32b/0x520
> > [   16.038944] Write of size 8 at addr 0000000000043ec0 by task test_progs/325
> > [   16.039399]
> > [   16.039514] CPU: 0 PID: 325 Comm: test_progs Tainted: G           OE     5.16.0+ #278
> > [   16.039983] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ArchLinux 1.15.0-1 04/01/2014
> > [   16.040485] Call Trace:
> > [   16.040645]  <TASK>
> > [   16.040805]  dump_stack_lvl+0x59/0x73
> > [   16.041069]  ? __pv_queued_spin_lock_slowpath+0x32b/0x520
> > [   16.041427]  kasan_report.cold+0x116/0x11b
> > [   16.041673]  ? __pv_queued_spin_lock_slowpath+0x32b/0x520
> > [   16.042040]  __pv_queued_spin_lock_slowpath+0x32b/0x520
> > [   16.042328]  ? memcpy+0x39/0x60
> > [   16.042552]  ? pv_hash+0xd0/0xd0
> > [   16.042785]  ? lockdep_hardirqs_off+0x95/0xd0
> > [   16.043079]  __bpf_spin_lock_irqsave+0xdf/0xf0
> > [   16.043366]  ? bpf_get_current_comm+0x50/0x50
> > [   16.043608]  ? jhash+0x11a/0x270
> > [   16.043848]  bpf_timer_cancel+0x34/0xe0
> > [   16.044119]  bpf_prog_c4ea1c0f7449940d_sys_enter+0x7c/0x81
> > [   16.044500]  bpf_trampoline_6442477838_0+0x36/0x1000
> > [   16.044836]  __x64_sys_nanosleep+0x5/0x140
> > [   16.045119]  do_syscall_64+0x59/0x80
> > [   16.045377]  ? lock_is_held_type+0xe4/0x140
> > [   16.045670]  ? irqentry_exit_to_user_mode+0xa/0x40
> > [   16.046001]  ? mark_held_locks+0x24/0x90
> > [   16.046287]  ? asm_exc_page_fault+0x1e/0x30
> > [   16.046569]  ? asm_exc_page_fault+0x8/0x30
> > [   16.046851]  ? lockdep_hardirqs_on+0x7e/0x100
> > [   16.047137]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [   16.047405] RIP: 0033:0x7f9e4831718d
> > [   16.047602] Code: b4 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b3 6c 0c 00 f7 d8 64 89 01 48
> > [   16.048764] RSP: 002b:00007fff488086b8 EFLAGS: 00000206 ORIG_RAX: 0000000000000023
> > [   16.049275] RAX: ffffffffffffffda RBX: 00007f9e48683740 RCX: 00007f9e4831718d
> > [   16.049747] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fff488086d0
> > [   16.050225] RBP: 00007fff488086f0 R08: 00007fff488085d7 R09: 00007f9e4cb594a0
> > [   16.050648] R10: 0000000000000000 R11: 0000000000000206 R12: 00007f9e484cde30
> > [   16.051124] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > [   16.051608]  </TASK>
> > [   16.051762] ==================================================================
> >
> > Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >   include/linux/bpf.h | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index fa517ae604ad..31a83449808b 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -224,7 +224,8 @@ static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)
> >   	if (unlikely(map_value_has_spin_lock(map))) {
> >   		s_off = map->spin_lock_off;
> >   		s_sz = sizeof(struct bpf_spin_lock);
> > -	} else if (unlikely(map_value_has_timer(map))) {
> > +	}
> > +	if (unlikely(map_value_has_timer(map))) {
> >   		t_off = map->timer_off;
> >   		t_sz = sizeof(struct bpf_timer);
> >   	}
>
> Thanks for the patch. I think we have a bigger problem here with the patch.
> It actually exposed a few kernel bugs. If you run current selftests, esp.
> ./test_progs -j which is what I tried, you will observe
> various testing failures. The reason is due to we preserved the timer or
> spin lock information incorrectly for a map value.
>
> For example, the selftest #179 (timer) will fail with this patch and
> the following change can fix it.
>

I actually only saw the same failures (on bpf/master) as in CI, and it seems
they are there even when I do a run without my patch (related to uprobes). The
bpftool patch PR in GitHub also has the same error, so I'm guessing it is
unrelated to this. I also didn't see any difference when running on bpf-next.

As far as others are concerned, I didn't see the failure for timer test, or any
other ones, for me all timer tests pass properly after applying it. It could be
that my test VM is not triggering it, because it may depend on the runtime
system/memory values, etc.

Can you share what error you see? Does it crash or does it just fail?

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index d29af9988f37..3336d76cc5a6 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -961,10 +961,11 @@ static struct htab_elem *alloc_htab_elem(struct
> bpf_htab *htab, void *key,
>                         l_new = ERR_PTR(-ENOMEM);
>                         goto dec_count;
>                 }
> -               check_and_init_map_value(&htab->map,
> -                                        l_new->key + round_up(key_size,
> 8));
>         }
>
> +       check_and_init_map_value(&htab->map,
> +                                l_new->key + round_up(key_size, 8));
> +

Makes sense, but trying to understand why it would fail:
So this is needed because the reused element from per-CPU region might have
garbage in the bpf_spin_lock/bpf_timer fields? But I think atleast for timer
case, we reset timer->timer to NULL in bpf_timer_cancel_and_free.

Earlier copy_map_value further below in this code would also overwrite the timer
part (which usually may be zero), but that would also not happen anymore.

>         memcpy(l_new->key, key, key_size);
>         if (percpu) {
>                 size = round_up(size, 8);
>
> Basically, the above clears new map value timer/spin_lock fields for *all*
> new items.
>
> There are still some selftest failures due to this patch.
> Could you run selftest, with necessary additional fixes, to ensure
> all selftests passed?

Assuming that uprobe ones are unrelated, should I add this diff and respin? Or
are you seeing other errors as well apart from the timer (#179) test?

--
Kartikeya
