Return-Path: <bpf+bounces-66866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0459DB3A7D7
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 19:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF9707A76A2
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 17:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC7B3375BA;
	Thu, 28 Aug 2025 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4ynusb6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97CF176ADB
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401857; cv=none; b=RN+yCboUsDQN2JJtwv7Gme+NGpQt5xWKt9DhDXxfOS3seQMvP1jv0joQsRgf3I5CPfv5wi2el+9IZ7mh/bYuO8khgYmDYPXq/N+sTAVw7Lo3U6be79wmKczDuYfR//5uq5bnLg7Z8bCKVWW5yAEq03j0G7zivhOiE/TzLj1jmZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401857; c=relaxed/simple;
	bh=SZ1VTuE69jIefYaf0ogpU6KHGeyQYJ4Y8v6J+/oHLmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPy1XDsLKFGPeelYE60RabNZauc099KBKlWvW1UTdCIicBswoQkn7eV6n2p4hBCrzfQHK1iwxjvBPQmvm45R12z0K5O+Tcsu+0gVFFkWwM9goFhycoKWTnzuUjkcj9PMejlTKAwN9DrYHOl/PyloLJmXA3z+aXvoNt/K9+7TZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4ynusb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E41C4CEF4;
	Thu, 28 Aug 2025 17:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756401857;
	bh=SZ1VTuE69jIefYaf0ogpU6KHGeyQYJ4Y8v6J+/oHLmo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=R4ynusb6BfDXUFC9sXeZwNNF+uIgu3tH+7uWIEqpa8/cv2Zf9AyAgSkfT4E+KL2Fs
	 pM5L0laoLCU8iAZ0qHfQumROdVSzjjxpN2uKGYO7w0n7m2ZbWEoI638PwIuyhQvVNi
	 1kpBsqXtpmP89pel902JJCLoVQOKGaTA6PqVPjSluQj0y7A0Nexus9XtoLzS3e/DBy
	 JI9W658HkkoaUIf83jdSBOimD8cCdtSjDQi82G6NDGtT13I2uUsiYpZ0BeLwUMtNgQ
	 UYm1lakUARU0s+4iAcdRB3WMpShYNYwMF7uu5jf1is6MjF7BUDjJpt25ZQO/AEJoA8
	 JCfbDK9Onikwg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 20150CE0C12; Thu, 28 Aug 2025 10:24:17 -0700 (PDT)
Date: Thu, 28 Aug 2025 10:24:17 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [BUG] Deadlock triggered by bpfsnoop funcgraph feature
Message-ID: <8ab6e14b-e639-413e-91cc-56dc02d1a4fb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a08c7c19-1831-481f-9160-0583d850347a@linux.dev>
 <CAADnVQJz9ekB_LjSjRzJLmM_fvdCbeA+pFY20xviJ-qgwFtXWw@mail.gmail.com>
 <8dcc144e-3142-4e0d-a852-155781e41eb4@linux.dev>
 <CAADnVQLDG=Oavh9He=ivXm9MPwsqWHttbTYQh1-EZuHpwujaBA@mail.gmail.com>
 <b3463ffa-c2cb-43c8-a0d2-92bad49e3c23@linux.dev>
 <93e75cff-871f-4b49-868c-11fea0eec396@paulmck-laptop>
 <DCE3PPX8IFF4.FE1BC8HMP4Y7@linux.dev>
 <CAADnVQ+G73vyC77tSo3AFcBT5FiBFbojfddnpYi5yRcqOxQiDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+G73vyC77tSo3AFcBT5FiBFbojfddnpYi5yRcqOxQiDQ@mail.gmail.com>

On Thu, Aug 28, 2025 at 09:43:00AM -0700, Alexei Starovoitov wrote:
> On Thu, Aug 28, 2025 at 6:39 AM Leon Hwang <leon.hwang@linux.dev> wrote:
> >
> > On Thu Aug 28, 2025 at 7:50 PM +08, Paul E. McKenney wrote:
> > > On Thu, Aug 28, 2025 at 10:40:47AM +0800, Leon Hwang wrote:
> > >> On 28/8/25 08:42, Alexei Starovoitov wrote:
> > >> > On Tue, Aug 26, 2025 at 7:58 PM Leon Hwang <leon.hwang@linux.dev> wrote:
> >
> > [...]
> >
> > >> >
> > >> > bpf infra is trying hard not to crash it, but debug kernel is a different
> > >> > category. rcu_read_lock_held() doesn't exist in production kernels.
> > >> > You can propose adding "notrace" for it, but in general that doesn't scale.
> > >> > Same with rcu_lockdep_current_cpu_online().
> > >> > It probably deserves "notrace" too.
> > >>
> > >> Indeed, it doesn't scale.
> > >>
> > >> When I run
> > >> ./bpfsnoop -k "htab_*_elem" --output-fgraph --fgraph-debug
> > >> --fgraph-exclude
> > >> 'rcu_read_lock_*held,rcu_lockdep_current_cpu_online,*raw_spin_*lock*,kvfree,show_stack,put_task_stack',
> > >> the kernel doesn’t panic, but the OS eventually stalls and becomes
> > >> unresponsive to key presses.
> > >>
> > >> It seems preferable to avoid running BPF programs continuously in such
> > >> cases.
> > >
> > > Agreed, when adding code to the Linux kernel, whether via a patch, via
> > > a BPF program, or by whatever other means, you are taking responsibility
> > > for the speed, scalability, and latency effects of that code.
> > >
> > > Nevertheless, I am happy to add a few "notrace" modifiers
> > > if needed.  Do you guys need them for rcu_read_lock_held() and
> > > rcu_lockdep_current_cpu_online()?
> > >
> >
> > I think it would be better to add "notrace" to following functions:
> >
> > ./bpfsnoop -k 'rcu_read_*lock_*held*,rcu_lockdep_*' --show-func-proto
> > bool rcu_lockdep_current_cpu_online(); [traceable]
> > int rcu_read_lock_any_held(); [traceable]
> > int rcu_read_lock_bh_held(); [traceable]
> > int rcu_read_lock_held(); [traceable]
> > int rcu_read_lock_sched_held(); [traceable]
> 
> Agree. Seems like an easy way to remove a footgun.

Very good, and please see below.  This might or might not make the next
merge window, but if not, it should be good for the one after that.

> Independently it would be good to make noinstr/notrace to include __cpuidle
> functions. I think right now it's allowed to attach to default_idle()
> which is causing issues.

Leon, would you be interested in putting together a patch for these?

							Thanx, Paul

------------------------------------------------------------------------

commit dada60c8851f19e54524cc1bcf8ab5938eb909c9
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Aug 28 10:17:10 2025 -0700

    rcu: Mark diagnostic functions as notrace
    
    The rcu_lockdep_current_cpu_online(), rcu_read_lock_sched_held(),
    rcu_read_lock_held(), rcu_read_lock_bh_held(), rcu_read_lock_any_held()
    are used by tracing-related code paths, so putting traces on them is
    unlikely to make anyone happy.  This commit therefore marks them all
    "notrace".
    
    Reported-by: Leon Hwang <leon.hwang@linux.dev>
    Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1291e0761d70ab..2515ee9a82df4f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4021,7 +4021,7 @@ bool rcu_cpu_online(int cpu)
  * RCU on an offline processor during initial boot, hence the check for
  * rcu_scheduler_fully_active.
  */
-bool rcu_lockdep_current_cpu_online(void)
+bool notrace rcu_lockdep_current_cpu_online(void)
 {
 	struct rcu_data *rdp;
 	bool ret = false;
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c912b594ba987f..dfeba9b3539508 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -117,7 +117,7 @@ static bool rcu_read_lock_held_common(bool *ret)
 	return false;
 }
 
-int rcu_read_lock_sched_held(void)
+int notrace rcu_read_lock_sched_held(void)
 {
 	bool ret;
 
@@ -342,7 +342,7 @@ EXPORT_SYMBOL_GPL(debug_lockdep_rcu_enabled);
  * Note that rcu_read_lock() is disallowed if the CPU is either idle or
  * offline from an RCU perspective, so check for those as well.
  */
-int rcu_read_lock_held(void)
+int notrace rcu_read_lock_held(void)
 {
 	bool ret;
 
@@ -367,7 +367,7 @@ EXPORT_SYMBOL_GPL(rcu_read_lock_held);
  * Note that rcu_read_lock_bh() is disallowed if the CPU is either idle or
  * offline from an RCU perspective, so check for those as well.
  */
-int rcu_read_lock_bh_held(void)
+int notrace rcu_read_lock_bh_held(void)
 {
 	bool ret;
 
@@ -377,7 +377,7 @@ int rcu_read_lock_bh_held(void)
 }
 EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
 
-int rcu_read_lock_any_held(void)
+int notrace rcu_read_lock_any_held(void)
 {
 	bool ret;
 

