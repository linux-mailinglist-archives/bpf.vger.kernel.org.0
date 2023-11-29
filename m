Return-Path: <bpf+bounces-16142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB837FD6A3
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 13:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2CEC28305B
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 12:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D8F1DDC7;
	Wed, 29 Nov 2023 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bdOxlM7R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6292210CE
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 04:21:47 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cfd76c5f03so186795ad.0
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 04:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701260507; x=1701865307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o56Www3Q+AtcE90gXDvz5NG1arQEXkGu3aDX+2U5OVg=;
        b=bdOxlM7RAmZg1OpHSkxKL864stOnjSKxyFqjmE/WlnPxNyFC7g42HGDP4cMHYkLffb
         0k4QxcxvxbTlEzyGKHtnI+7gZJ5wLKDoXq8yp0ULCcvGL47hz56N3MfVhE8eB3xGeKJD
         qYy2dYDFb5y3Eusd1ekO/5foZ6rK0zLcJ0I+7K7beTdw66aCpcHpLMYXZq3eOAg1Oh7C
         fhzemgMWrOYv/k+80Zd4SciI6Rm+zPCRjNFhTbkNRJqbigzsBta1OE8JsV4pyZhXimEa
         sOUpFpflN/YTWIj7K0w35aD3lYXPlVvSjFKPuy+l2NnHOIX40CJ1OEut/F+ImBS0aqjl
         n7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701260507; x=1701865307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o56Www3Q+AtcE90gXDvz5NG1arQEXkGu3aDX+2U5OVg=;
        b=pY4xal0qjEtPWagLk+0hpB9Llro8ijPZ3gz+AUeNJvthSEBHpDwbZg34Vl0SDWKmyy
         vjngzCMfOZkvVokPbiDExeDVSXcmd7mAdyKE5sG5zTO3wkD4y6L4cYoYVp3glWnBF9PT
         0NkdNgfxzmAWgSMBUso4H8QA2M5ukhBFgh9BdWdugmpy+4L9adQfltAaIzMkxU4aTpk4
         5sXoCAsnSNah+EodEeeZiF7hrU/ejVoRQ9gX9n0wML6Wr+oAbFot1ATWm6JDMEbGknMm
         t0PSvOrL4J7n0t5lCoiiM6GqSJ1F0hlSFB8zjqP/qR1df4BV8Lfgazk8Vi8zc85GnxbB
         m4uQ==
X-Gm-Message-State: AOJu0Yw2BtFaZGSzqukwDjdgpexJOt9j4azfFfj/sXyftiykYNw8tKSL
	lqhK8Y+ZoJ3x958unq6Y54HuywDuQyK6SMPU+ta0Lw==
X-Google-Smtp-Source: AGHT+IGijv2oaXJrsz4eOoB3TmX4ovkG0ibEUz+P5TLts7xACNH5qB3XKWndGchQRopwNv8LdczoZIB5sx6elgIxlsM=
X-Received: by 2002:a17:902:fc44:b0:1d0:220b:f254 with SMTP id
 me4-20020a170902fc4400b001d0220bf254mr21736plb.14.1701260506633; Wed, 29 Nov
 2023 04:21:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000d9483d060901f460@google.com> <0000000000006547d3060b498385@google.com>
In-Reply-To: <0000000000006547d3060b498385@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 29 Nov 2023 13:21:35 +0100
Message-ID: <CANp29Y4NLk4jd8zhN-VjXWtrDSWbS=Y-ADGxrmboKU+KH2hMPw@mail.gmail.com>
Subject: Re: [syzbot] [perf?] general protection fault in inherit_task_group
To: syzbot <syzbot+756fe9affda890e892ae@syzkaller.appspotmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, bpf@vger.kernel.org, irogers@google.com, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, netdev@vger.kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 1:17=E2=80=AFPM syzbot
<syzbot+756fe9affda890e892ae@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit a71ef31485bb51b846e8db8b3a35e432cc15afb5
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Tue Oct 24 09:42:21 2023 +0000
>
>     perf/core: Fix potential NULL deref
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D17172162e8=
0000
> start commit:   6808918343a8 net: bridge: fill in MODULE_DESCRIPTION()
> git tree:       bpf-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D429fa76d04cf3=
93c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D756fe9affda890e=
892ae
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12db572b680=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10839a1b68000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: perf/core: Fix potential NULL deref

#syz fix: perf/core: Fix potential NULL deref

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> --

