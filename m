Return-Path: <bpf+bounces-60192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD28BAD3D37
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 17:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4AA173710
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 15:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F3F248F40;
	Tue, 10 Jun 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="XRjbG5YJ"
X-Original-To: bpf@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4935A23E346
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749569015; cv=none; b=OyMZkEYMmf1iWL+mp1Zt/9zjed4FvNqrD9vY+CCjHUwBiperahbnD7NpKdOXOVtR2B/zzYyXHd8EB+i8pEDbaQ+YTMxyBhJ7HgL92SJSU9DtNzf3FYWhEYKhDpkNkq3IX5R3BNWxU/LoPw4k1UF/ymgCXmSIHBjQiGB4KbYphJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749569015; c=relaxed/simple;
	bh=SmTNhAOGAIip/lVL+aZeJrx7rLBvuTmZXxhKmCJfKN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eYSi8fFhIjcgWK8+1pv8eq5eVBDjLrUwJw1U8bBFIjUrWf7oahAyk1bromo9yVr+wNj016DnWPk6Rv7OmWNIq3WxCw440o0YeM5xnP9MFH2aQCrEizLnPF86QxtK1Nwcco3WtchLDqnHXMmoRg0LsLlgx1bYHV92vjUhoi9S0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=XRjbG5YJ; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 9E32B240101
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 17:23:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net;
	s=1984.ea087b; t=1749569004;
	bh=SmTNhAOGAIip/lVL+aZeJrx7rLBvuTmZXxhKmCJfKN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=XRjbG5YJSFBhe9cN3yB5/CnawZNTtXh/BSkgyk1JJFkPUMmSPey/IArAFYpVepx6a
	 feohYEhUb5f2QRh0gfx6wPoxODSGKDafGf8JvSo3s52P44hnsUcQFpSWLAI6oJWM/D
	 2McjbpEYG/5V9tfz5HNo0hOqsuqk3sf7NizwDStDHOqmGvfdestdm7ZQPyudU48j9s
	 Q+fqpkT9AUIgTCgZYXGLzubZbid6OEZ69fGKRP5+XtxN80j20biP1gwftVOyptS+xg
	 IsxLkh8PHnnsAYp7+fxMJ1aqGQlxofozO/9WrhHS4nlC3kKXamq4Tyk4PxYU+pVTiq
	 4J1zMbmDbnFuSQyVodKzyBPBC54nt4lnACdbK1MRiVhkmEGuAyo2dx3iD00hHZ6GcZ
	 8T68j476UQMTeeFNOAbvrXuHlIhQFaTByqqztdeVilnf/CX409RtmOTOkhnRujg2wD
	 IKDncBsSgmnacs6ExcHVY1eI0maegdDeuCRTLQcmagsKFEisxw6
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bGsxh35bsz6v1N;
	Tue, 10 Jun 2025 17:23:20 +0200 (CEST)
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
In-Reply-To: <CAADnVQK_k4ReDwS_urGtJPQ1SXaHdrGWYxJGd-QK=tAn60p4vw@mail.gmail.com>
References: <20250608-rcu-fix-task_cls_state-v1-1-2a2025b4603b@posteo.net>
	<CAADnVQLxaxVpCaK90FfePOKMLpH=axaK3gDwVZLp0L1+fNxgtA@mail.gmail.com>
	<9eae82be-0900-44ea-b105-67fadc7d480d@iogearbox.net>
	<CAADnVQK_k4ReDwS_urGtJPQ1SXaHdrGWYxJGd-QK=tAn60p4vw@mail.gmail.com>
Date: Tue, 10 Jun 2025 15:23:00 +0000
Message-ID: <87wm9jy623.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Jun 10, 2025 at 5:58=E2=80=AFAM Daniel Borkmann <daniel@iogearbox=
.net> wrote:
>>
>> On 6/9/25 5:51 PM, Alexei Starovoitov wrote:
>> > On Sun, Jun 8, 2025 at 8:35=E2=80=AFAM Charalampos Mitrodimas
>> > <charmitro@posteo.net> wrote:
>> >>
>> >> The commit ee971630f20f ("bpf: Allow some trace helpers for all prog
>> >> types") made bpf_get_cgroup_classid_curr helper available to all BPF
>> >> program types.  This helper used __task_get_classid() which calls
>> >> task_cls_state() that requires rcu_read_lock_bh_held().
>> >>
>> >> This triggers an RCU warning when called from BPF syscall programs
>> >> which run under rcu_read_lock_trace():
>> >>
>> >>    WARNING: suspicious RCU usage
>> >>    6.15.0-rc4-syzkaller-g079e5c56a5c4 #0 Not tainted
>> >>    -----------------------------
>> >>    net/core/netclassid_cgroup.c:24 suspicious rcu_dereference_check()=
 usage!
>> >>
>> >> Fix this by replacing __task_get_classid() with task_cls_classid()
>> >> which handles RCU locking internally using regular rcu_read_lock() and
>> >> is safe to call from any context.
>> >>
>> >> Reported-by: syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com
>> >> Closes: https://syzkaller.appspot.com/bug?extid=3Db4169a1cfb945d2ed0ec
>> >> Fixes: ee971630f20f ("bpf: Allow some trace helpers for all prog type=
s")
>> >> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
>> >> ---
>> >>   net/core/filter.c | 2 +-
>> >>   1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/net/core/filter.c b/net/core/filter.c
>> >> index 30e7d36790883b29174654315738e93237e21dd0..3b3f81cf674dde7d2bd83=
488450edad4e129bdac 100644
>> >> --- a/net/core/filter.c
>> >> +++ b/net/core/filter.c
>> >> @@ -3083,7 +3083,7 @@ static const struct bpf_func_proto bpf_msg_pop_=
data_proto =3D {
>> >>   #ifdef CONFIG_CGROUP_NET_CLASSID
>> >>   BPF_CALL_0(bpf_get_cgroup_classid_curr)
>> >>   {
>> >> -       return __task_get_classid(current);
>> >> +       return task_cls_classid(current);
>> >>   }
>> >
>> > Daniel added this helper in
>> > commit 5a52ae4e32a6 ("bpf: Allow to retrieve cgroup v1 classid from v2=
 hooks")
>> > with intention to use it from networking hooks.
>> >
>> > But task_cls_classid() has
>> >          if (in_interrupt())
>> >                  return 0;
>> >
>> > which will trigger in softirq and tc hooks.
>> > So this might break Daniel's use case.
>>
>> Yeap, we cannot break tc(x) BPF programs. It probably makes sense to have
>> a new helper implementation for the more generic, non-networking case wh=
ich
>> then internally uses task_cls_classid().
>
> Instead of forking the helper I think we can :
> rcu_read_lock_bh_held() || rcu_read_lock_held()
> in task_cls_state().

I tested your suggestion with,

  rcu_read_lock_bh_held() || rcu_read_lock_held()

but it still triggers the RCU warning because BPF syscall programs use
rcu_read_lock_trace().

Adding rcu_read_lock_trace_held() fixes it functionally but triggers a
checkpatch warning:

  WARNING: use of RCU tasks trace is incorrect outside BPF or core RCU code

I think the best solution here would be to add
local_bh_disable()/enable() protection directly in the BPF helper. This
keeps the fix localized to where the problem exists, and avoids
modifying core cgroup RCU.

> And that will do it.

