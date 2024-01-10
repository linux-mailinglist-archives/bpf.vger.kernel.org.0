Return-Path: <bpf+bounces-19298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852E5829167
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 01:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35092288FE8
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 00:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2F8A52;
	Wed, 10 Jan 2024 00:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vexj7BgI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DEC7FD;
	Wed, 10 Jan 2024 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a28b1095064so382282966b.2;
        Tue, 09 Jan 2024 16:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704846548; x=1705451348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0oSZtdv3/xL2ew9fmcXvUgCl/ZohDyyfAjdAXcE7GM=;
        b=Vexj7BgI8BN1VH8Wv+KDjsA8LVf1fHYovq3PbvQ9UNiNrZiYnikMLttoZF3dXVRswe
         T7mq8GGuBMd96C+RonqBfVGrgKWZoLLdnT529jCFbGuFZOH61y6yhcH1mw/qVJsd6Epy
         IPKUKMk4x7ONcpbnjc+RNDlM4bbDOn3ZvsxNws0XfrIbN84iZXFagXvDJCbDiJibU5lC
         xXz/9pzXr9bnTwhEBS8ed6eI5HGQnff7TNykw8zllbYnmmBP0TQGtegx6WZimtbplpec
         4L7d0Ax/quOLRKFp5f2Pu+KdmU36CH7QBKi7AgKLa4Uin37p0NS+/+MLalFrEu0wgKT9
         5TbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704846548; x=1705451348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0oSZtdv3/xL2ew9fmcXvUgCl/ZohDyyfAjdAXcE7GM=;
        b=o3fh05jK7I8xOcsRZ93wDnchj/T2XSB6PfRzgMJDdVsiXdeiwSSY5X9noqvO4fR1XS
         JaOsBPim9NqNFlUdQx2Aa0K78W7pxraMVPZ8gU76xPTdoxOmWAQUADjI3Brv3HObliMp
         dQHNJRoLVdI8xlWsMrKCk9puZehOYeSPAdVqvjElUWxLhnP30T1zKK8JfSTHXLIZpCab
         Xhx0CIqQ8s+uUFDkRGMdKbVvIUzqlYhbvx6heRyQ80d/6oUGe9scEyMbOn9GNZrWXQ3W
         n9KJbHDSwf2Ok1JLa/IBrF2VTorcl299HE5Bnkg9WaaFg7K9qGpucN8HN78mGJLBcjJ0
         G0SQ==
X-Gm-Message-State: AOJu0YziBqD+lbuIjkMEb/e7xMW3l7NJvvTfsLkIDyiKKOkpLuub2E9i
	5IjfEPP0pJ+CffVmsscJK0xOnd4H1keAcwphkLE=
X-Google-Smtp-Source: AGHT+IGicAiwSauU3RfpkmKBhP6d3Otdi0DwGiGbAreVOOGhlc1cmUXJsXbf49wST2YOIVXUwq4krO42/M+z6F2Ivls=
X-Received: by 2002:a17:906:a988:b0:a28:24ac:e5f1 with SMTP id
 jr8-20020a170906a98800b00a2824ace5f1mr55831ejb.271.1704846547775; Tue, 09 Jan
 2024 16:29:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000a36811060e875e14@google.com>
In-Reply-To: <000000000000a36811060e875e14@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jan 2024 16:28:54 -0800
Message-ID: <CAEf4BzZei+PJmkuxpyhhmWt-ZP1NVB4jJwXtCkPxDmwjhmnkhQ@mail.gmail.com>
Subject: Re: [syzbot] Monthly bpf report (Jan 2024)
To: syzbot <syzbot+listfa7dbe69051a666b7429@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 10:20=E2=80=AFAM syzbot
<syzbot+listfa7dbe69051a666b7429@syzkaller.appspotmail.com> wrote:
>
> Hello bpf maintainers/developers,
>
> This is a 31-day syzbot report for the bpf subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/bpf
>
> During the period, 2 new issues were detected and 0 were fixed.
> In total, 15 issues are still open and 200 have been fixed so far.
>
> Some of the still happening issues:
>
> Ref Crashes Repro Title
> <1> 8166    Yes   possible deadlock in task_fork_fair
>                   https://syzkaller.appspot.com/bug?extid=3D1a93ee5d329e9=
7cfbaff
> <2> 21      Yes   BUG: unable to handle kernel NULL pointer dereference i=
n sk_msg_recvmsg
>                   https://syzkaller.appspot.com/bug?extid=3D84f695756ed0c=
4bb3aba
> <3> 19      Yes   WARNING in __mark_chain_precision (3)
>                   https://syzkaller.appspot.com/bug?extid=3D4d6330e144077=
21955eb

this was fixed a while ago in 482d548d ("bpf: handle fake register
spill to stack with BPF_ST_MEM instruction")

> <4> 3       Yes   INFO: rcu detected stall in sys_newfstatat (4)
>                   https://syzkaller.appspot.com/bug?extid=3D1c02a56102605=
204445c
> <5> 2       Yes   UBSAN: shift-out-of-bounds in adjust_reg_min_max_vals
>                   https://syzkaller.appspot.com/bug?extid=3D46700eea57ecc=
7f84776
> <6> 1       Yes   INFO: rcu detected stall in sys_unshare (9)
>                   https://syzkaller.appspot.com/bug?extid=3D872bccd9a68c6=
ba47718
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> To disable reminders for individual bugs, reply with the following comman=
d:
> #syz set <Ref> no-reminders
>
> To change bug's subsystems, reply with:
> #syz set <Ref> subsystems: new-subsystem
>
> You may send multiple commands in a single email message.

