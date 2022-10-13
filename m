Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA615FE451
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 23:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiJMVfi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 17:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJMVfh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 17:35:37 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1380F18DAB4
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 14:35:35 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id y80so2487467iof.3
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 14:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmQRvJDE7xhnPxSIdVp/+02zr5ZCI3hL63lq2WdoUMg=;
        b=D/KmRb2iOTSTyGQ88RR7CYhbYbrrax20Bg0LfYDzWBc/NNA87aRkEbs0BaraRzXJzr
         jf/YygsBDp8Gm0UEqr2PE0YP6FcbAMzJYztzWTiHmFDcLEY5GQ+JEdkt4AUV+LO6Tjy/
         +7V+i1ZcUBu/bOPZmzZuRwxR0H8pbNY/aswV5Zgz3bTV0fES1H+R0Ckd7P2rPaa6SDDD
         x2UY0TRb+kIhm9YuxLzHT0J8GO8IGeI0KccdbauPoE39gJtsv+rUigHrTwXz3nW62Oqn
         Fg8C+HGzqAEictDyikuIwJH7GJI4JErufL7lR1YsaymlZPGqunQVr9TAfYjxXUL2BZjy
         AkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmQRvJDE7xhnPxSIdVp/+02zr5ZCI3hL63lq2WdoUMg=;
        b=phg8GbUmYM6CGnXYQMWid5bEYzEbjAREFDnkNTWVKNfq9FgREz/wPlcd2/QA4BXaKA
         vc8sdC579VOQZDwVdxgMjJFB1DD47SLfdLlbZwCVmp8yvfBEPwyWHejnfby5qfE+GNYJ
         S9OYVQUdg7SRxPF7fN0kLn6Aw5KS/I4J9rHagpxaSC30expRJB+mfWsDVXY2LVTgiaXO
         ss2Mwo/YuTF6laFvZ6QQv/PfeWWuYl1HyYQh7WKmXZJw5ZGP+HeWYnginKEjhLp7Ciq+
         lBFtMs39TXblQftVWtuWAaogngmiHJzoYs87dUOmxQYcHKYurDM3Bs9KOrJea918/hJF
         IKuw==
X-Gm-Message-State: ACrzQf0prK+wrV8H663pR+fLo7XfdqBz+K46zY88s8LwJs2QRuhEBBHs
        qcg79nD1f1+8HLKgfDDksTfKA94WudXosFT6P67qxg==
X-Google-Smtp-Source: AMsMyM56UeBsY6KK9h9l+2ot+CUr2YXa/UMBcY8Vk7bJhGNgPrnGKKpL4YFTPMJCAhp0iKbVoqHmWJ+xPCHDUDCt2pA=
X-Received: by 2002:a05:6638:3c49:b0:363:c8dc:fb2f with SMTP id
 bg9-20020a0566383c4900b00363c8dcfb2fmr1110611jab.119.1665696934378; Thu, 13
 Oct 2022 14:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221012220434.3236596-1-sdf@google.com> <082959ee-5df0-93b1-58b7-c4aff8d8f784@linux.dev>
In-Reply-To: <082959ee-5df0-93b1-58b7-c4aff8d8f784@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 13 Oct 2022 14:35:23 -0700
Message-ID: <CAKH8qBuQDLva_hHxxBuZzyAcYNO4ejhovz6TQeVSk8HY-2SO6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: remove WARN_ON_ONCE from btf_type_id_size
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        syzbot+d8bd751aef7c6b39a344@syzkaller.appspotmail.com,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 13, 2022 at 2:14 PM Martin KaFai Lau <martin.lau@linux.dev> wro=
te:
>
> On 10/12/22 3:04 PM, Stanislav Fomichev wrote:
> > Syzkaller was able to hit it with the following reproducer:
> >
> > bpf$BPF_BTF_LOAD(0x12, &(0x7f0000000140)=3D{&(0x7f0000001680)=3D{{0xeb9=
f, 0x1, 0x0, 0x18, 0x0, 0x34, 0x34, 0xc, [@fwd=3D{0xa}, @var=3D{0x3, 0x0, 0=
x0, 0x11, 0x4, 0xffffffff}, @func_proto=3D{0x0, 0x0, 0x0, 0xd, 0x2}, @struc=
t]}, {0x0, [0x0, 0x0, 0x5f, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x6c]}}, &(0x7f00=
000004c0)=3D""/4096, 0x58, 0x1000, 0x1}, 0x20)
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 3609 at kernel/bpf/btf.c:1946
> > btf_type_id_size+0x2d5/0x9d0 kernel/bpf/btf.c:1946
> > Modules linked in:
> > CPU: 0 PID: 3609 Comm: syz-executor361 Not tainted
> > 6.0.0-syzkaller-02734-g0326074ff465 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 09/22/2022
> > RIP: 0010:btf_type_id_size+0x2d5/0x9d0 kernel/bpf/btf.c:1946
> > Code: ef e8 7f 8e e4 ff 41 83 ff 0b 77 28 f6 44 24 10 18 75 3f e8 6d 91
> > e4 ff 44 89 fe bf 0e 00 00 00 e8 20 8e e4 ff e8 5b 91 e4 ff <0f> 0b 45
> > 31 f6 e9 98 02 00 00 41 83 ff 12 74 18 e8 46 91 e4 ff 44
> > RSP: 0018:ffffc90003cefb40 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
> > RDX: ffff8880259c0000 RSI: ffffffff81968415 RDI: 0000000000000005
> > RBP: ffff88801270ca00 R08: 0000000000000005 R09: 000000000000000e
> > R10: 0000000000000011 R11: 0000000000000000 R12: 0000000000000000
> > R13: 0000000000000011 R14: ffff888026ee6424 R15: 0000000000000011
> > FS:  000055555641b300(0000) GS:ffff8880b9a00000(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000f2e258 CR3: 000000007110e000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   <TASK>
> >   btf_func_proto_check kernel/bpf/btf.c:4447 [inline]
> >   btf_check_all_types kernel/bpf/btf.c:4723 [inline]
> >   btf_parse_type_sec kernel/bpf/btf.c:4752 [inline]
> >   btf_parse kernel/bpf/btf.c:5026 [inline]
> >   btf_new_fd+0x1926/0x1e70 kernel/bpf/btf.c:6892
> >   bpf_btf_load kernel/bpf/syscall.c:4324 [inline]
> >   __sys_bpf+0xb7d/0x4cf0 kernel/bpf/syscall.c:5010
> >   __do_sys_bpf kernel/bpf/syscall.c:5069 [inline]
> >   __se_sys_bpf kernel/bpf/syscall.c:5067 [inline]
> >   __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:5067
> >   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7f0fbae41c69
> > Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89
> > f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> > f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffc8aeb6228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0fbae41c69
> > RDX: 0000000000000020 RSI: 0000000020000140 RDI: 0000000000000012
> > RBP: 00007f0fbae05e10 R08: 0000000000000000 R09: 0000000000000000
> > R10: 00000000ffffffff R11: 0000000000000246 R12: 00007f0fbae05ea0
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >   </TASK>
> >
> > Any reason we need that WARN_ON_ONCE in this place?
> > All callers except btf_array_check_member check the return value,
> > so it should be safe. Assuming btf_array_check_member should also be fi=
ne
> > because it hits 'btf_type_is_array()' condition.
> >
> > Reported-by: syzbot+d8bd751aef7c6b39a344@syzkaller.appspotmail.com
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >   kernel/bpf/btf.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index eba603cec2c5..999f62c697a7 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -1943,8 +1943,8 @@ const struct btf_type *btf_type_id_size(const str=
uct btf *btf,
> >       } else if (btf_type_is_ptr(size_type)) {
> >               size =3D sizeof(void *);
> >       } else {
> > -             if (WARN_ON_ONCE(!btf_type_is_modifier(size_type) &&
> > -                              !btf_type_is_var(size_type)))
> Thanks for the report.
>
> Trying to recall the reason...
> After the above "if...else if...", the modifier and var should be the onl=
y ones
> left that may be able to resolve to a type with a size.
>
> I suspect the type that failed the WARN_ON_ONCE here is the BTF_KIND_DECL=
_TAG
> which was added after this original WARN_ON_ONCE.  Could you confirm in t=
he
> above syzkaller BTF that BTF_KIND_DECL_TAG is the one triggering here? an=
d could
> you help to turn the above syzkaller BTF into a unittest in
> tools/testing/selftests/bpf/prog_tests/btf.c.

Sure, thanks for the context, will check it out and will get back to you!

> If that is the case, it seems we have missed checking BTF_KIND_DECL_TAG e=
arlier
> before doing the actual btf_resolve().  The problem is in the
> btf_func_proto_check().  I talked to Yonghong offline a little on how the
> non-func-proto type is handling the invalid decl tag.  There is a
> btf_type_is_resolve_source_only() to ensure a few types (decl_tag is one =
of
> them) can never be referred by other types.  This check is needed in
> bpf_func_proto_check() before doing the btf_resolve().
>
> Something like this (may not compile) and probably need similar check in =
the
> nr_args for loop a few lines below also:
>
> diff --git i/kernel/bpf/btf.c w/kernel/bpf/btf.c
> index eba603cec2c5..a19dbeecd2a4 100644
> --- i/kernel/bpf/btf.c
> +++ w/kernel/bpf/btf.c
> @@ -4436,6 +4436,11 @@ static int btf_func_proto_check(struct btf_verifie=
r_env *env,
>                          return -EINVAL;
>                  }
>
> +               if (btf_type_is_resolve_source_only(ret_type)) {
> +                       btf_verifier_log_type(env, t, "Invalid return typ=
e");
> +                       return -EINVAL;
> +               }
> +
>                  if (btf_type_needs_resolve(ret_type) &&
>                      !env_type_is_resolved(env, ret_type_id)) {
>                          err =3D btf_resolve(env, ret_type, ret_type_id);
>
>
