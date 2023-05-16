Return-Path: <bpf+bounces-661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB25E7054EA
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 19:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997441C20E71
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 17:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1194F1079B;
	Tue, 16 May 2023 17:23:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8A034CD4
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 17:23:43 +0000 (UTC)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FAAFC
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 10:23:42 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-335a61eb904so13525ab.0
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 10:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684257821; x=1686849821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtLDMIe167B85U/+GfK+jGRGZasQjZejfPs58zT2nPo=;
        b=wTc2x7001d8gBrfDrm+5jQkRDAjYgsBFeRgu1lN7P4Sox5fk/y11Wdh/ge45c1aAXt
         DpGFODbpp3VrBb64VCHyh5e2EKkjsBEDGuqkseD+j5BZhmyOlsPNb7JEy1vi0bKX8ByO
         twedDomMdgmcHRS0hoF49Zq3ZHAvcs0JW7Ga07dt/rF2VsoFkR0fJPFssK68PBERL5jJ
         nTdJov1eSvobo3/f2b24SqBV+NZz+KyPsuJyF1PuU+g5XP/ZzSAp2jPUIZJ6RFHZXQtH
         jOi6n7ZBsRSuJqY0cMwdHRSZXCokCiGVvWYcf0G2XTB24EpE38gWg8OU4vdzc4yeijhd
         Ae8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684257821; x=1686849821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtLDMIe167B85U/+GfK+jGRGZasQjZejfPs58zT2nPo=;
        b=LmQvFF3DsrUuoCTu73qJ35QERN13gTFNpnUwwHzBPdZVJQxZ7s7Uy0zz7usE1HU+X1
         x2ZKeuG3xLAHvPR1wLb0UmMRi62bNKjwbMikBfmF/k+OxECR8WgZ/TnggaHPvhtOto6U
         KpW1kegB/44Qv9mSrJk6nVTUvesuTqB6B23XE0MCplXoRnA2YsGOaHsvMRCwMaOU6S/H
         MgYW0yDUV+HSIZ87c/fqyYMg4/fNBqFd5P3SDnVr2i5+G3FH/uW51o4FErdSKdtnZ/k1
         UNbipveNsfgq+rICl9Ve6xfWJtw7OeRg7InzEtzO7L2V0iUCku6KcUmihdrUiGPBIzRC
         UIig==
X-Gm-Message-State: AC+VfDw/jrTnS6KW141qzY2sqxN0ERCk6FzFWYXHckl39YkqwdAeDhB4
	IKqq0UXC2hIZ7jYD3GPMtll3MhzYPj7jODrF9FHEBg==
X-Google-Smtp-Source: ACHHUZ7+MXQY9FJvb+Jjv5Z5fAz6w/bKyOgU/LvgEVB1XBAqnx5OkYRYC0MW/bS6u9VrrsaWcBpvYyxo7Ernz9EYzmU=
X-Received: by 2002:a05:6e02:1bc3:b0:335:5c4b:2f8a with SMTP id
 x3-20020a056e021bc300b003355c4b2f8amr246921ilv.5.1684257821269; Tue, 16 May
 2023 10:23:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000bff72505fbcd1f74@google.com> <000000000000bc152005fbcd1fa2@google.com>
 <20230516-saftig-einbog-ef2981f0dec2@brauner>
In-Reply-To: <20230516-saftig-einbog-ef2981f0dec2@brauner>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 16 May 2023 19:23:30 +0200
Message-ID: <CANp29Y7ktmz=W5F+uavDa1KzSnUnBHtrH2abHRqAjuWZkJdgxw@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] Internal error in should_fail_ex
To: Christian Brauner <brauner@kernel.org>
Cc: syzbot <syzbot+c84b326736ee471158dc@syzkaller.appspotmail.com>, 
	syzbot <syzbot+729f1325904c82acd601@syzkaller.appspotmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 16, 2023 at 2:32=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, May 16, 2023 at 03:35:03AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    457391b03803 Linux 6.3
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15671fa2280=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D385e197a58c=
a4afe
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc84b326736ee4=
71158dc
> > compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110=
, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: arm
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/c35b5b2731d2/non_bootable_disk-457391b0.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/2a1bf3bafeb6/vmli=
nux-457391b0.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/21f1e3b4a5a9=
/zImage-457391b0.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+c84b326736ee471158dc@syzkaller.appspotmail.com
>
> On Tue, May 16, 2023 at 03:35:02AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    457391b03803 Linux 6.3
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D134e0b01280=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D385e197a58c=
a4afe
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D729f1325904c8=
2acd601
> > compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110=
, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: arm
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D118f964e2=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16f6e776280=
000
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/c35b5b2731d2/non_bootable_disk-457391b0.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/2a1bf3bafeb6/vmli=
nux-457391b0.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/21f1e3b4a5a9=
/zImage-457391b0.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+729f1325904c82acd601@syzkaller.appspotmail.com
>
> Not complaining but why am I blessed with an explicit Cc on this?
>

You were Cc'd because syzbot incorrectly identified the guilty file
for the bug, I've sent a fix [1].
Sorry for the noise.

[1] https://github.com/google/syzkaller/pull/3905

--=20
Aleksandr

