Return-Path: <bpf+bounces-7240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E0E773D61
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 18:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCE5280F6F
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 16:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEA814F6E;
	Tue,  8 Aug 2023 16:06:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD743C37
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 16:06:57 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3F21D449
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 09:06:44 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so88145e9.0
        for <bpf@vger.kernel.org>; Tue, 08 Aug 2023 09:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691510792; x=1692115592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=en4BANwXReNJdtVv23CMrzP6JO/+20SEX8H3hOTpv5o=;
        b=myWSq4lPvBKhbe4+zSbtARG2ka8adzgpdxrGR/PkL7IS+S1OubWLaJ3PjZLNvhJy5F
         Xxx8J5Do9SX4jKy9jMtYoXQrT2tMTOGGb6tx6htlzAflRvPrEIFTF/Rmk7QkwR5YHGVz
         JdV8msNkCSWWUevTqzOhoHQTZQ8lZPprWLFxllO+tDH/UFYWNkyGoBNXkX3fHO4R3QoI
         UPXOREvlo7HlTAfGM9pYpPVCmPupS5fK7rQia78bAJZZd9jL9iiHNDB6uwYHKN2q2Ybo
         9cJPjGl9yg5d/Rgfc2HxZcto8aGFRA7PmIARN2MFk+wkNjx0zxZ4fN/yRC31aiKkjhas
         6gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510792; x=1692115592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=en4BANwXReNJdtVv23CMrzP6JO/+20SEX8H3hOTpv5o=;
        b=hqK/5c0yb3PEdugNs3TiLVMhBUHsPO61hWSYHGyLs0qbGEyUCHjfFSh7RczwNFsQR5
         QDTcNluW9H8LjIe7nBUNQL0ZV7bV2saw6LbsJEAscOkAlzh7D6wMwyW+uSzVFhDJO6tm
         i8EobTBnDnZXqUdW5gPJ48z4Al33c+Bejr2w1kHntXJarEpgdTkjJnwo6PNtn0+K8sPL
         SsDyIdb11vBXA8J39WjcXdZAazmyOuf9eEykZzrJ2kBNaT/xg02KKjI+TpCwOz1wX50m
         lGC2qUXOLyBekxAqvqop58Bgo5HQMIRtDNhC+rU+s+4cIMaqPJm3TKTA60JSRhYAucCo
         NIzw==
X-Gm-Message-State: AOJu0YwWICziH0V0G5D6SDmqgQqvhk1sDdO4Y6EEQZ3AqNqB62QHQAKJ
	5Jkb4Mf+2b6Carz17nDcreD5wYcNDrcAPXU67hb+dHvtPuXSi+yDgPSIgZt0
X-Google-Smtp-Source: AGHT+IEyE8ErD7uTJxSl5pOL1gNwgH/rpoc3NrRUJbIX+CCqivojjSoogbdUBi8R44J+rqzNlPOm0e/5+oOFVS4Mew4=
X-Received: by 2002:a05:600c:6023:b0:3f1:70d1:21a6 with SMTP id
 az35-20020a05600c602300b003f170d121a6mr311208wmb.0.1691510792379; Tue, 08 Aug
 2023 09:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000000e4cc105ff68937b@google.com> <000000000000166f9e06025c8139@google.com>
In-Reply-To: <000000000000166f9e06025c8139@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 8 Aug 2023 18:06:20 +0200
Message-ID: <CANp29Y7q49HBoV+_xD1wpztUGDu4ykEFb-2H-d71rZAkY=M67A@mail.gmail.com>
Subject: Re: [syzbot] [modules?] KASAN: invalid-access Read in init_module_from_file
To: syzbot <syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com>
Cc: bpf@vger.kernel.org, chris@chrisdown.name, linan122@huawei.com, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	llvm@lists.linux.dev, mcgrof@kernel.org, nathan@kernel.org, 
	ndesaulniers@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 8, 2023 at 12:09=E2=80=AFAM syzbot
<syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 125bfc7cd750e68c99f1d446e2c22abea08c237f
> Author: Li Nan <linan122@huawei.com>
> Date:   Fri Jun 9 09:43:20 2023 +0000
>
>     md/raid10: fix the condition to call bio_end_io_acct()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D15c26ba9a8=
0000
> start commit:   a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.k=
e..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df5e1158c5b2f8=
3bb
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De3705186451a87f=
d93b8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12518548a80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D124ccf70a8000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: md/raid10: fix the condition to call bio_end_io_acct()

No, that's unrelated.

Most likely it's due to https://github.com/google/syzkaller/issues/4117
TL;DR: for bugs that only existed for a very short time syzbot is
having problems differentiating between revisions where the bug is not
yet introduced and where it's already fixed.

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>

