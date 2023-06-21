Return-Path: <bpf+bounces-3017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8176A73846E
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 15:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D472D2814E5
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 13:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2D6171B0;
	Wed, 21 Jun 2023 13:07:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8598B11CA1
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 13:07:39 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5079E57
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 06:07:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-25695bb6461so4767314a91.1
        for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 06:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687352856; x=1689944856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AN9rHqAMb+s9JldJn9/oqOzjlHcCzpCU13r5zGj/2KQ=;
        b=cK7F3u9YWXKESMkYMrq4CLbiYhmqAwgCfOHFwEMrXZBDvEfantgIL+FukZP7lJa0HE
         ea+9QoGvYwMLYvpCEbugNNosto1uR6rlY5mkWJTITzJG2HsAWzwIj4R3IGti2g+h74VS
         9+4U+k4MGAY/K5+AO5LbCu4ijCkdwFXd/Flus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687352856; x=1689944856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AN9rHqAMb+s9JldJn9/oqOzjlHcCzpCU13r5zGj/2KQ=;
        b=bFwoZAGCoB+VFPRhkHWOQxPz+Y82pNgt8q0UqDoSiH4z/4EyAJh1cRhuDoxAzzH5Rl
         Nwqs7A5SHzsBawPSnJeVACBgAUhhcea+anIzU4Ux/GhWwr/d25RZsO4WvyvpNYYTVJZh
         qn4Q0p+zhTfHqPCyMQouhCMWapxHAlzS0WE0K7oY0UqivhlvZOVovTM+UsLbVs7o3uYl
         giqjFjAHX7lfxijtYRU3eFVAjw4aGGWmlavISCiFra84expZRIcJrAHp3QS0zDQ7oLTI
         a5POSfxRcf6Es21+vIZI0wOIsLTskFWydObhYP8K7m1UBwQVR2rXM2U2gTPt/YOQM9b6
         o6UQ==
X-Gm-Message-State: AC+VfDwxSgD01vjM0QxP4U4UA0yfcX4thuDN6lCs0PQFCyIv/iSHomCJ
	nmXzIcerKeO3q09YuK/pLtbZeD9tIFL7ZBItOMWwGw==
X-Google-Smtp-Source: ACHHUZ58CXQQpAnHz3lkggiqe1EL/HQv8J6Ipct9oA7wdxqNiCgJ8ePDZU2c7RUje6+6AvX2hFO4F8Z0/irOHhzxVjI=
X-Received: by 2002:a17:90a:e385:b0:25e:e70f:423f with SMTP id
 b5-20020a17090ae38500b0025ee70f423fmr14962926pjz.19.1687352855923; Wed, 21
 Jun 2023 06:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230615152918.3484699-1-revest@chromium.org> <ZJFIy+oJS+vTGJer@calendula>
 <CABRcYmJjv-JoadtzZwU5A+SZwbmbgnzWb27UNZ-UC+9r+JnVxg@mail.gmail.com> <20230621111454.GB24035@breakpoint.cc>
In-Reply-To: <20230621111454.GB24035@breakpoint.cc>
From: Florent Revest <revest@chromium.org>
Date: Wed, 21 Jun 2023 15:07:24 +0200
Message-ID: <CABRcYmKeo6A+3dmZd9bRp8W3tO9M5cHDpQ13b8aeMkhYr4L64Q@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: conntrack: Avoid nf_ct_helper_hash uses
 after free
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, kadlec@netfilter.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, lirongqing@baidu.com, 
	daniel@iogearbox.net, ast@kernel.org, kpsingh@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 1:14=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Florent Revest <revest@chromium.org> wrote:
> > On Tue, Jun 20, 2023 at 8:35=E2=80=AFAM Pablo Neira Ayuso <pablo@netfil=
ter.org> wrote:
> > >
> > > On Thu, Jun 15, 2023 at 05:29:18PM +0200, Florent Revest wrote:
> > > > If register_nf_conntrack_bpf() fails (for example, if the .BTF sect=
ion
> > > > contains an invalid entry), nf_conntrack_init_start() calls
> > > > nf_conntrack_helper_fini() as part of its cleanup path and
> > > > nf_ct_helper_hash gets freed.
> > > >
> > > > Further netfilter modules like netfilter_conntrack_ftp don't check
> > > > whether nf_conntrack initialized correctly and call
> > > > nf_conntrack_helpers_register() which accesses the freed
> > > > nf_ct_helper_hash and causes a uaf.
> > > >
> > > > This patch guards nf_conntrack_helper_register() from accessing
> > > > freed/uninitialized nf_ct_helper_hash maps and fixes a boot-time
> > > > use-after-free.
> > >
> > > How could this possibly happen?
> >
> > Here is one way to reproduce this bug:
> >
> >   # Use nf/main
> >   git clone git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.=
git
> >   cd nf
> >
> >   # Start from a minimal config
> >   make LLVM=3D1 LLVM_IAS=3D0 defconfig
> >
> >   # Enable KASAN, BTF and nf_conntrack_ftp
> >   scripts/config -e KASAN -e BPF_SYSCALL -e DEBUG_INFO -e
> > DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT -e DEBUG_INFO_BTF -e
> > NF_CONNTRACK_FTP
> >   make LLVM=3D1 LLVM_IAS=3D0 olddefconfig
> >
> >   # Build without the LLVM integrated assembler
> >   make LLVM=3D1 LLVM_IAS=3D0 -j `nproc`
> >
> > (Note that the use of LLVM_IAS=3D0, KASAN and BTF is just to trigger a
> > bug in BTF that will be fixed by
> > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=
=3D9724160b3942b0a967b91a59f81da5593f28b8ba
> > Independently of that specific BTF bug, it shows how an error in
> > nf_conntrack_bpf can cause a boot-time uaf in netfilter)
> >
> > Then, booting gives me:
> >
> > [    4.624666] BPF: [13893] FUNC asan.module_ctor
> > [    4.625611] BPF: type_id=3D1
> > [    4.626176] BPF:
> > [    4.626601] BPF: Invalid name
> > [    4.627208] BPF:
> > [    4.627723] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [    4.628610] BUG: KASAN: slab-use-after-free in
> > nf_conntrack_helper_register+0x129/0x2f0
> > [    4.628610] Read of size 8 at addr ffff888102d24000 by task swapper/=
0/1
> > [    4.628610]
>
> Isn't that better than limping along?

Note that this only panics because KASAN instrumentation notices the
use-after-free and makes a lot of noise about it. In a non-debug boot,
this would just silently corrupt random memory instead.

> in this case an initcall is failing and I think panic is preferrable
> to a kernel that behaves like NF_CONNTRACK_FTP=3Dn.

In that case, it seems like what you'd want is
nf_conntrack_standalone_init() to BUG() instead of returning an error
then ? (so you'd never get to NF_CONNTRACK_FTP or any other if
nf_conntrack failed to initialize) If this is the prefered behavior,
then sure, why not.

> AFAICS this problem is specific to NF_CONNTRACK_FTP=3Dy
> (or any other helper module, for that matter).

Even with NF_CONNTRACK_FTP=3Dm, the initialization failure in
nf_conntrack_standalone_init() still happens. Therefore, the helper
hashtable gets freed and when the nf_conntrack_ftp.ko module gets
insmod-ed, it calls nf_conntrack_helpers_register() and this still
causes a use-after-free.

> If you disagree please resend with a commit message that
> makes it clear that this is only relevant for the 'builtin' case.

