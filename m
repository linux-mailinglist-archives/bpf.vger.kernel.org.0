Return-Path: <bpf+bounces-60196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6B3AD3DEA
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 17:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112781888D54
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 15:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1295423A9AA;
	Tue, 10 Jun 2025 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="YjxV+QGx"
X-Original-To: bpf@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BFE1386C9
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570701; cv=none; b=feiNdzDFE8cswd8hJARjyaUzIMCmJK4Ndn0L/0aeqIPiESl8oCYlJF1KSe3MuvllwIkfx1ZdHBFnBgLZf2RgQrHGEepQLdl/gakd3vYBLVyHcJxV3xtxLnAZWnTxZXXwFZBBpKCNUMPyrFVZR91qeOyrXlyvNb1o9vK9mf+v/+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570701; c=relaxed/simple;
	bh=N5bzsVPZ4HgGRnUY8AqgbXkIodLpbg7XJrFNxtMMTNk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mvv7984UbfiZfrnvWopTZ5WRQeeF/PPdyX+5P7wyIVjCX6K4SwV7JfTQFKtJYGDMu/c5HzdKODojDG+gWi/R/pVGEvIVsz1Cq5+zqFfvDdtlJX7CnxrhLI4GLnWw4G5HPGqW83Ub8XYFMcIkOG0vmK5zTSkagAF/ECsv2ZTMlRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=YjxV+QGx; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 889C1240027
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 17:51:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net;
	s=1984.ea087b; t=1749570696;
	bh=N5bzsVPZ4HgGRnUY8AqgbXkIodLpbg7XJrFNxtMMTNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=YjxV+QGx20H7yCqc8wC4bs8W9LF1WaMm+Ht8KPIpVASjJtxUV/kDSBJ1iQ6ijlQPV
	 UX2sF67Yuv6F6y1zHNKH+fRND0JYCtGH/a2RMtalZ0XrZlCSupH6rtQxqZF3kricSh
	 ov9ch27X1DxaHGqyQiQcO7sItMTSIxNmnjT9HnStFgn9mXQWRRlrXPB14GGhQ3oYGH
	 bBDyyDttkCCdNTNPkSm2pewwqsJs0dFNPpxuOTH+shgmjbRjYKDxB9MffJqzjyedKM
	 Uh5153C83Xk9y1XoSWLaJx8Rwtq86L/1WPefRi0N+DgALhU/UF3Nph+S6JNrMvjBg5
	 pdBjoJu50y/wU/smhD0jDOG9QpjkbHdgMPESHxmzVmOToV5kmJdmlyfOExJOGkz4Oh
	 WKgsE+Lxx3o2hy7m0y/5iZLhj4VS0JOjdBuGsHRGLp5ld343lpX6ANM7aDWD3kUw9+
	 3QpZhEa+Kn3SUAP8N4uPuG3FZrhjPJzjzH8dmu1cIwEreol02bn
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bGtZ72s8Kz6tlh;
	Tue, 10 Jun 2025 17:51:27 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,  John
 Fastabend <john.fastabend@gmail.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Feng Yang <yangfeng@kylinos.cn>,  Tejun Heo
 <tj@kernel.org>,  Network Development <netdev@vger.kernel.org>,  LKML
 <linux-kernel@vger.kernel.org>,  bpf <bpf@vger.kernel.org>,
  syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next] bpf: Fix RCU usage in
 bpf_get_cgroup_classid_curr helper
In-Reply-To: <CAADnVQ+mzrDH+8S=ddDCtyo6YUO4dUUsAS88Jza93pDQ2K3Bng@mail.gmail.com>
References: <20250608-rcu-fix-task_cls_state-v1-1-2a2025b4603b@posteo.net>
	<CAADnVQLxaxVpCaK90FfePOKMLpH=axaK3gDwVZLp0L1+fNxgtA@mail.gmail.com>
	<9eae82be-0900-44ea-b105-67fadc7d480d@iogearbox.net>
	<CAADnVQK_k4ReDwS_urGtJPQ1SXaHdrGWYxJGd-QK=tAn60p4vw@mail.gmail.com>
	<87wm9jy623.fsf@posteo.net>
	<CAADnVQ+mzrDH+8S=ddDCtyo6YUO4dUUsAS88Jza93pDQ2K3Bng@mail.gmail.com>
Date: Tue, 10 Jun 2025 15:51:05 +0000
Message-ID: <87tt4nzjbq.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Jun 10, 2025 at 8:23=E2=80=AFAM Charalampos Mitrodimas
> <charmitro@posteo.net> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> > On Tue, Jun 10, 2025 at 5:58=E2=80=AFAM Daniel Borkmann <daniel@iogear=
box.net> wrote:
>> >>
>> >> On 6/9/25 5:51 PM, Alexei Starovoitov wrote:
>> >> > On Sun, Jun 8, 2025 at 8:35=E2=80=AFAM Charalampos Mitrodimas
>> >> > <charmitro@posteo.net> wrote:
>> >> >>
>> >> >> The commit ee971630f20f ("bpf: Allow some trace helpers for all pr=
og
>> >> >> types") made bpf_get_cgroup_classid_curr helper available to all B=
PF
>> >> >> program types.  This helper used __task_get_classid() which calls
>> >> >> task_cls_state() that requires rcu_read_lock_bh_held().
>> >> >>
>> >> >> This triggers an RCU warning when called from BPF syscall programs
>> >> >> which run under rcu_read_lock_trace():
>> >> >>
>> >> >>    WARNING: suspicious RCU usage
>> >> >>    6.15.0-rc4-syzkaller-g079e5c56a5c4 #0 Not tainted
>> >> >>    -----------------------------
>> >> >>    net/core/netclassid_cgroup.c:24 suspicious rcu_dereference_chec=
k() usage!
>> >> >>
>> >> >> Fix this by replacing __task_get_classid() with task_cls_classid()
>> >> >> which handles RCU locking internally using regular rcu_read_lock()=
 and
>> >> >> is safe to call from any context.
>> >> >>
>> >> >> Reported-by: syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com
>> >> >> Closes: https://syzkaller.appspot.com/bug?extid=3Db4169a1cfb945d2e=
d0ec
>> >> >> Fixes: ee971630f20f ("bpf: Allow some trace helpers for all prog t=
ypes")
>> >> >> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
>> >> >> ---
>> >> >>   net/core/filter.c | 2 +-
>> >> >>   1 file changed, 1 insertion(+), 1 deletion(-)
>> >> >>
>> >> >> diff --git a/net/core/filter.c b/net/core/filter.c
>> >> >> index 30e7d36790883b29174654315738e93237e21dd0..3b3f81cf674dde7d2b=
d83488450edad4e129bdac 100644
>> >> >> --- a/net/core/filter.c
>> >> >> +++ b/net/core/filter.c
>> >> >> @@ -3083,7 +3083,7 @@ static const struct bpf_func_proto bpf_msg_p=
op_data_proto =3D {
>> >> >>   #ifdef CONFIG_CGROUP_NET_CLASSID
>> >> >>   BPF_CALL_0(bpf_get_cgroup_classid_curr)
>> >> >>   {
>> >> >> -       return __task_get_classid(current);
>> >> >> +       return task_cls_classid(current);
>> >> >>   }
>> >> >
>> >> > Daniel added this helper in
>> >> > commit 5a52ae4e32a6 ("bpf: Allow to retrieve cgroup v1 classid from=
 v2 hooks")
>> >> > with intention to use it from networking hooks.
>> >> >
>> >> > But task_cls_classid() has
>> >> >          if (in_interrupt())
>> >> >                  return 0;
>> >> >
>> >> > which will trigger in softirq and tc hooks.
>> >> > So this might break Daniel's use case.
>> >>
>> >> Yeap, we cannot break tc(x) BPF programs. It probably makes sense to =
have
>> >> a new helper implementation for the more generic, non-networking case=
 which
>> >> then internally uses task_cls_classid().
>> >
>> > Instead of forking the helper I think we can :
>> > rcu_read_lock_bh_held() || rcu_read_lock_held()
>> > in task_cls_state().
>>
>> I tested your suggestion with,
>>
>>   rcu_read_lock_bh_held() || rcu_read_lock_held()
>>
>> but it still triggers the RCU warning because BPF syscall programs use
>> rcu_read_lock_trace().
>>
>> Adding rcu_read_lock_trace_held() fixes it functionally but triggers a
>> checkpatch warning:
>>
>>   WARNING: use of RCU tasks trace is incorrect outside BPF or core RCU c=
ode
>
> It's safe to ignore checkpatch in this case.

If that is the case I'll move forward with this. It was my initial fix
for this[1] anyway, but checkpatch made me change it.

[1]: https://github.com/charmitro/linux/commit/e5c42d49bfb967c3c35f536971f3=
97492d2f46bf

>
>> I think the best solution here would be to add
>> local_bh_disable()/enable() protection directly in the BPF helper. This
>> keeps the fix localized to where the problem exists, and avoids
>> modifying core cgroup RCU.
>
> That works, but it will add runtime overhead.
> I doubt the helper is in a critical path, so I don't mind.

