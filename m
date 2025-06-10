Return-Path: <bpf+bounces-60189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34181AD3BE1
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 16:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36230167A9B
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 14:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2F2230D2B;
	Tue, 10 Jun 2025 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCxfZ8qX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B2A230BDB;
	Tue, 10 Jun 2025 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567423; cv=none; b=hNqn9ihRWBco7VAadHOMD6R0syedMpK73lymZoG79WWziozPGZICK2boPEPTb8qCi+YS30OdnxkgjiSDL54d9928gGRC/5w2kwmFf3BLymTJRZi7osbCNQfUkay/KIoG1JKk+2s3dBXhXKE5/Bdn02hVogrgfEScFardTCBBzy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567423; c=relaxed/simple;
	bh=zByWlDBNKckKw0jWBhDuGmYgOSZHHJq4mRZX1o/hghY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xwjq7OksFpplkIcDmZ1MylXRTvv8xd5PNwQS+m3Y8pVf+l9KPgB7j7HyodgPLsT60jb7eSQe1gwI4Rd9iXi10fTChIfp5Xf49P6fg9osNBzfSBmOVCUOkv525iggi29ppNZf4xhb/WfOswUaIg+j6ISWKsydi3ngAAYfNLWAzYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCxfZ8qX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-442ea341570so36699095e9.1;
        Tue, 10 Jun 2025 07:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749567420; x=1750172220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wwnqZvTHNK2o37LI8XbA5MfrvkJxRpCPBLeHJP3M5Y=;
        b=bCxfZ8qXuICcUT8U+T8Wg58zqJl1NXXsgEnTJQXEpXg5EkAnhpdmpqMAmrzkg1jttC
         wrpepb+jyGxds6pbh7RmkftrnPy3StZ2J4vNBWyts4hSPncugKjmj2+YGXlz9QDv/b84
         p1pmiphEr3bOHiHiZMLl5f6xz7x3xDIU9TtZbdjb0EJ+NEP1qr0VK09Ll3taKbkgZZMu
         ajnKXdBdXMp6dHwpZYQ0tWYmNHsggvOI+T0jVqvNr7k4O69YlO46eIlAOtok4r4X6tpI
         UytjpnT8bKyz2pY6scp62U/7+tQ0fx1fTY1syMz8xnukuwL9lvVacHK21g9SfvWyf32w
         9uYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749567420; x=1750172220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wwnqZvTHNK2o37LI8XbA5MfrvkJxRpCPBLeHJP3M5Y=;
        b=xIt50AoehI7zo7tLckwLPk27jkN4tqD1ax+fM1rB/CS3+bIge+d/Zwi/hdJnYff7WK
         HjXfKCZ0N3uJnSJaGMIy76lwVDRuwbCeLmbMT5vpStR0QjonZiwDsNWuCchEEMU5LlFy
         Dpq1GTCsex8MkIGH8aHTLSGXwWxn0Ash/djAyiwF7JKK+uwbvO64iCFWR5nhHhNDTT+z
         g58ETArtEBMQygh2DNRXv9MqPeXbkKjlppp+JH9v+69vb1Vh0BYXVkUFxRGPxY/CkPEm
         0bKhHF455bIBbBYHnQyfFSmpVX0POP13O6gPWgZAP3I1UafcYVxK0tzuCtfhjCVItKFP
         Uxjg==
X-Forwarded-Encrypted: i=1; AJvYcCUzmXIF5APXP4QobpUYhpH3FhQ5vESmU5ZIjKH6APaundQcW8wRjr5LEL+wyqspoj02wtJFcXsD2MLoM/yI@vger.kernel.org, AJvYcCV7n+zr+V3EfkzP/QyiVoOtNl8QKUWz6OIpXwJeoqQrxqwdFj1iaVP7ogufGpo8B3ZD/E0CmvPS@vger.kernel.org, AJvYcCWUi7voOl0KHiwyfUcDb0THnHUu6R2Dlgnf29EDr5O6kb4J3h4HPgqTGlJZeh0l9hEe838=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3MUDEvIHAn0Oyxvuxi3v4c6ka/02ufpUr36tEmSwM7i6FSTLG
	VYLWznZH3PLeokGDNDy7wrTLctXol/p6j5y9NjHElelwz8ZnNBWFY0IjSBse4H8eeh4Jad+qv6q
	LCsxx5z4WdfFdtqU3/DhP57yLkmuSW28=
X-Gm-Gg: ASbGncu08zpuA0F8+Src8slkArQZZfgq9m1krw/vPwGgThrl0msypAGppYp2Mt3M/5Z
	2yxPYNA8Jyy/Jkfsk8fkSmJGl8Lb5e3YQbduRjhGHsSZTpcatQggCtD6gBc6303XPjb9yCKxHjV
	p9wFMkfk5RYauK0cF3GmVL6UmNanKCbkd5FOAdZ3mUDFhwYdpx1LPL79Uqx0U=
X-Google-Smtp-Source: AGHT+IGOc8bUJBDv99rCLy4M3C4rvYfoE2Z69jTNxoUGSp2dO9WBSZpZAI254X0QkV4e6nHos1ZmTZ1zDtdeYelCd1c=
X-Received: by 2002:a5d:64e7:0:b0:3a4:f902:3872 with SMTP id
 ffacd0b85a97d-3a531cab757mr13040330f8f.19.1749567419564; Tue, 10 Jun 2025
 07:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608-rcu-fix-task_cls_state-v1-1-2a2025b4603b@posteo.net>
 <CAADnVQLxaxVpCaK90FfePOKMLpH=axaK3gDwVZLp0L1+fNxgtA@mail.gmail.com> <9eae82be-0900-44ea-b105-67fadc7d480d@iogearbox.net>
In-Reply-To: <9eae82be-0900-44ea-b105-67fadc7d480d@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Jun 2025 07:56:48 -0700
X-Gm-Features: AX0GCFtnTqZig7dyW3PR0EKJRhUeFNWIpmwblpieZgztBjaVceUVGWpXU4TuBnI
Message-ID: <CAADnVQK_k4ReDwS_urGtJPQ1SXaHdrGWYxJGd-QK=tAn60p4vw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix RCU usage in bpf_get_cgroup_classid_curr
 helper
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Charalampos Mitrodimas <charmitro@posteo.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Feng Yang <yangfeng@kylinos.cn>, Tejun Heo <tj@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 5:58=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 6/9/25 5:51 PM, Alexei Starovoitov wrote:
> > On Sun, Jun 8, 2025 at 8:35=E2=80=AFAM Charalampos Mitrodimas
> > <charmitro@posteo.net> wrote:
> >>
> >> The commit ee971630f20f ("bpf: Allow some trace helpers for all prog
> >> types") made bpf_get_cgroup_classid_curr helper available to all BPF
> >> program types.  This helper used __task_get_classid() which calls
> >> task_cls_state() that requires rcu_read_lock_bh_held().
> >>
> >> This triggers an RCU warning when called from BPF syscall programs
> >> which run under rcu_read_lock_trace():
> >>
> >>    WARNING: suspicious RCU usage
> >>    6.15.0-rc4-syzkaller-g079e5c56a5c4 #0 Not tainted
> >>    -----------------------------
> >>    net/core/netclassid_cgroup.c:24 suspicious rcu_dereference_check() =
usage!
> >>
> >> Fix this by replacing __task_get_classid() with task_cls_classid()
> >> which handles RCU locking internally using regular rcu_read_lock() and
> >> is safe to call from any context.
> >>
> >> Reported-by: syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com
> >> Closes: https://syzkaller.appspot.com/bug?extid=3Db4169a1cfb945d2ed0ec
> >> Fixes: ee971630f20f ("bpf: Allow some trace helpers for all prog types=
")
> >> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
> >> ---
> >>   net/core/filter.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/net/core/filter.c b/net/core/filter.c
> >> index 30e7d36790883b29174654315738e93237e21dd0..3b3f81cf674dde7d2bd834=
88450edad4e129bdac 100644
> >> --- a/net/core/filter.c
> >> +++ b/net/core/filter.c
> >> @@ -3083,7 +3083,7 @@ static const struct bpf_func_proto bpf_msg_pop_d=
ata_proto =3D {
> >>   #ifdef CONFIG_CGROUP_NET_CLASSID
> >>   BPF_CALL_0(bpf_get_cgroup_classid_curr)
> >>   {
> >> -       return __task_get_classid(current);
> >> +       return task_cls_classid(current);
> >>   }
> >
> > Daniel added this helper in
> > commit 5a52ae4e32a6 ("bpf: Allow to retrieve cgroup v1 classid from v2 =
hooks")
> > with intention to use it from networking hooks.
> >
> > But task_cls_classid() has
> >          if (in_interrupt())
> >                  return 0;
> >
> > which will trigger in softirq and tc hooks.
> > So this might break Daniel's use case.
>
> Yeap, we cannot break tc(x) BPF programs. It probably makes sense to have
> a new helper implementation for the more generic, non-networking case whi=
ch
> then internally uses task_cls_classid().

Instead of forking the helper I think we can :
rcu_read_lock_bh_held() || rcu_read_lock_held()
in task_cls_state().
And that will do it.

