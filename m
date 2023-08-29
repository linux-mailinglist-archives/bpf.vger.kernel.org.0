Return-Path: <bpf+bounces-8913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B7F78C4A2
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 14:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432F228112E
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 12:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8642F156EF;
	Tue, 29 Aug 2023 12:58:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B476156DB;
	Tue, 29 Aug 2023 12:58:58 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF2EE48;
	Tue, 29 Aug 2023 05:58:54 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-637aaaf27f1so8712706d6.0;
        Tue, 29 Aug 2023 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693313933; x=1693918733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FsMYZfhMVSuGAFIMLOJfSHf3ktSPlMv9xHN6XV521us=;
        b=BEUEVMWzmZWpT4y5RVtsG90kLmOHn2oPex8NfiB77i5mkbaSAEQsSaOx94b5dOVpJu
         TsqpYCBfU500cR29In+NqdF66CyD56y4Xo+2xS72bWbVw1Nx0iUYjkfO+UvxHqhkq2AH
         8+l4zKhKR6SL2QMXE1vTd9Z52O6AirlJIBrrVQvsfUMp+ModLDigeNqFkuA5CJ0f29CK
         0kbAdhb+QEhnG2Y0DJkPC5Z8AXAJPP27fIOpeZ9bjtnwtYFo2Oko6hf0tAL0SRmT0RQ0
         qSx2NgWVKMbomoeX7IDu0/ERwANubkd0YhuKCVI6SHf9ulgZorq/kYlZQAdFqQQRjJSm
         zXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693313933; x=1693918733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsMYZfhMVSuGAFIMLOJfSHf3ktSPlMv9xHN6XV521us=;
        b=Ja93MXlqVCwZ1G4+kdTdtwKSLR2CjCnUtX8Y37oWJ57pHTPTkWDdu2VWMz3HpfVrpz
         /k9kbccc1/NF7GagXwhwLRNOQ7QmkArUnXg24yp3MNrHLuhtjUZT2at2ppDSi50tjFfy
         0vNg9eUVgfhEcpmk++wrHcbjEvVY2eZC5N+YZfUiOBrOEcm+ZriiksjQpVAd7kxaQTgw
         XliDgwdEX1h+ZSeDklHUG56EIt7MsszDsgcHJXxcnJa3SMIRRYB47t4u2wqQXTJAQ38c
         Jnel3TR+QjtZTa3MisKfRpx5nVP8wqHn30bVtQYsD0b/jHXkJwg20vcprOTzoT6ob1mt
         uljw==
X-Gm-Message-State: AOJu0YwMvzkI+ix2mHMxjXa5p9JjUA8youFyq0pceQAK9NzSriicrLiN
	2OrMgdd8+pPU082dW5eVYPkZEFvBs1RZ0vvkfB8=
X-Google-Smtp-Source: AGHT+IHkhbo821efYzPP9wI2YYcX+RpD8SIZlQiLhMm/RssrhTmHuN8whjAyAyNiQ/UzwFOfKNA6dPn+T042qF8b/no=
X-Received: by 2002:a05:6214:27eb:b0:625:8684:33f3 with SMTP id
 jt11-20020a05621427eb00b00625868433f3mr32333054qvb.0.1693313933335; Tue, 29
 Aug 2023 05:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000af3ba506040b7d0c@google.com> <3d8fa470-8ca9-561c-8381-0687f9e69d10@iogearbox.net>
In-Reply-To: <3d8fa470-8ca9-561c-8381-0687f9e69d10@iogearbox.net>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 29 Aug 2023 14:58:42 +0200
Message-ID: <CAJ8uoz2rCtznp6yq8YxNNcmZXxkkBFfAudv=3KbLKdho9_0z9Q@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in xsk_diag_dump
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: syzbot <syzbot+822d1359297e2694f873@syzkaller.appspotmail.com>, 
	andrii@kernel.org, ast@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, jonathan.lemon@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, maciej.fijalkowski@intel.com, 
	magnus.karlsson@intel.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 29 Aug 2023 at 14:56, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Hi Magnus,
>
> On 8/29/23 10:20 AM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    5c905279a1b7 Merge branch 'pds_core-error-handling-fixes'
> > git tree:       net
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=16080070680000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=1e4a882f77ed77bd
> > dashboard link: https://syzkaller.appspot.com/bug?extid=822d1359297e2694f873
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ec63a7a80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109926eba80000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/98add120b6e5/disk-5c905279.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/c9e9009eadbd/vmlinux-5c905279.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/b840142cc0c1/bzImage-5c905279.xz
> >
> > The issue was bisected to:
> >
> > commit 18b1ab7aa76bde181bdb1ab19a87fa9523c32f21
> > Author: Magnus Karlsson <magnus.karlsson@intel.com>
> > Date:   Mon Feb 28 09:45:52 2022 +0000
> >
> >      xsk: Fix race at socket teardown
>
> please take a look when you get a chance.
>
> Thanks a lot,
> Daniel

Already looking at it :-).

/Magnus

