Return-Path: <bpf+bounces-57461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E17E8AAB853
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697981892C20
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C9D2DF55F;
	Tue,  6 May 2025 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dMMzqUNW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A841241C49E;
	Tue,  6 May 2025 00:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746491315; cv=none; b=rgih/tXm/SAXPGi1+0/Bp497FpL4MGCqPpBV9xg7x2oXDsBvWT5GAbWQbrzmwt/AzPRCKPCD/BZMVUC0OoZENeoZutZxozOb1Mc+0MNn42sTTxi871fPo/uBgJfZLvZK8mg3UBxkJNWIQ6J9RuRTsIY+nQ0a2Mlgko3hzeS8QZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746491315; c=relaxed/simple;
	bh=eF+gNBjOxLKhwFhrMZg53t7zwD/CWXXQi/+cXTRSx+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E105q9O8iEf6PB5RCRX6gR/xCMQMFzgCMi75X11glyXALYfc6Pbca3tEByaLo+yieW3blhyuwWd5uEjkRhLP22TzX+ssjCkKjqInED4X4R2us8oiHFYQlsISfMMK/En6VG6YAbvp3EmGydXWoVHS84I6kyUjkeT1ap5DVd7z/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dMMzqUNW; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746491314; x=1778027314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E0aenAy0eD64Xs5FaiMQor/yEM13BIeMpBetrAePIGU=;
  b=dMMzqUNWUYi80yhDS2pl83l61sCiKXZQiDbXpZ0Sn+GhKluItuLomEvH
   MKnBFzfmYH4+fa8pL4u6NmKhNq20bSSRPMIgovKj/kaRNVekeusNRtgEs
   ZsrOtC+p0e3DJYyPH0lBPwPyHOo9A8/1hb6N7FfLpKtjiNPqXCTimZ5vT
   s=;
X-IronPort-AV: E=Sophos;i="6.15,264,1739836800"; 
   d="scan'208";a="741839383"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 00:28:28 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:41035]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.32:2525] with esmtp (Farcaster)
 id 6243d7f0-d118-4e51-afcb-f54cd88bd55f; Tue, 6 May 2025 00:28:27 +0000 (UTC)
X-Farcaster-Flow-ID: 6243d7f0-d118-4e51-afcb-f54cd88bd55f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 6 May 2025 00:28:26 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 6 May 2025 00:28:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<brauner@kernel.org>, <casey@schaufler-ca.com>, <daniel@iogearbox.net>,
	<eddyz87@gmail.com>, <gnoack@google.com>, <haoluo@google.com>,
	<jmorris@namei.org>, <john.fastabend@gmail.com>, <jolsa@kernel.org>,
	<kpsingh@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<linux-security-module@vger.kernel.org>, <martin.lau@linux.dev>,
	<mic@digikod.net>, <netdev@vger.kernel.org>, <omosnace@redhat.com>,
	<paul@paul-moore.com>, <sdf@fomichev.me>, <selinux@vger.kernel.org>,
	<serge@hallyn.com>, <song@kernel.org>, <stephen.smalley.work@gmail.com>,
	<yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 0/5] af_unix: Allow BPF LSM to scrub SCM_RIGHTS at sendmsg().
Date: Mon, 5 May 2025 17:21:27 -0700
Message-ID: <20250506002813.65225-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAP01T77STmncrPt=BsFfEY6SX1+oYNXhPeZ1HC9J=S2jhOwQoQ@mail.gmail.com>
References: <CAP01T77STmncrPt=BsFfEY6SX1+oYNXhPeZ1HC9J=S2jhOwQoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 6 May 2025 00:49:11 +0200
> On Mon, 5 May 2025 at 23:58, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > As long as recvmsg() or recvmmsg() is used with cmsg, it is not
> > possible to avoid receiving file descriptors via SCM_RIGHTS.
> >
> > This behaviour has occasionally been flagged as problematic.
> >
> > For instance, as noted on the uAPI Group page [0], an untrusted peer
> > could send a file descriptor pointing to a hung NFS mount and then
> > close it.  Once the receiver calls recvmsg() with msg_control, the
> > descriptor is automatically installed, and then the responsibility
> > for the final close() now falls on the receiver, which may result
> > in blocking the process for a long time.
> >
> > systemd calls cmsg_close_all() [1] after each recvmsg() to close()
> > unwanted file descriptors sent via SCM_RIGHTS.
> >
> > However, this cannot work around the issue because the last fput()
> > could occur on the receiver side once sendmsg() with SCM_RIGHTS
> > succeeds.  Also, even filtering by LSM at recvmsg() does not work
> > for the same reason.
> >
> > Thus, we need a better way to filter SCM_RIGHTS on the sender side.
> >
> > This series allows BPF LSM to inspect skb at sendmsg() and scrub
> > SCM_RIGHTS fds by kfunc.
> >
> > Link: https://uapi-group.org/kernel-features/#disabling-reception-of-scm_rights-for-af_unix-sockets #[0]
> > Link: https://github.com/systemd/systemd/blob/v257.5/src/basic/fd-util.c#L612-L628 #[1]
> >
> 
> This sounds pretty useful!
> 
> I think you should mention the cases of possible DoS on close() or
> flooding, e.g. with FUSE controlled fd/NFS hangs in the commit log
> itself.
> I think it's been an open problem for a while now with no good solution.
> Currently systemd's FDSTORE=1 for PID 1 is susceptible to the same
> problem, even if the underlying service isn't root.

Good point, will add the description in v2.


> 
> I think it is also useful for restricting what individual file
> descriptors can be passed around by a process.
> Say restricting usage of an fd to a process and its children, but not
> allowing it to be shared with others.
> Send side hook is the right point to enforce it.

Agreed.

Actually, I tried per-fd filtering first and failed somehow so
wanted some advice from BPF folks :)

For example, I implemented kfunc like:

__bpf_kfunc int bpf_unix_scrub_file(struct sk_buff *skb, struct file *filp)
{
	/* scrub fd matching file if exists */
}

and tried filp == NULL -> scrub all so that I can gradually extend
the functionality, but verifier didn't allow passing NULL.

Also, once a fd is scrubbed, I do not want to leave the array entry
empty to avoid adding unnecessary "if (fpl->fp[i] == -1)" test in
other places.

       struct scm_fp_list *fpl = UNIXCB(skb).fp;

       /* scrubbed fpl->fp[i] here. */

       fpl->fp[i] = fpl->fp[fpl->count - 1];
       fpl->count--;

But this could confuse BPF prog if it was iterating fpl->fp[] in for
loop and I was wondering how the interface should be like.

  * Keep the empty index and ignore at core code ?
  * Provide a fd iterator ?
  * Scrub based on index ? matching fd ? or struct file ?
    * -1 works as ALL_INDEX or ALL_FDS but NULL doesn't
  * Invoke BPF LSM per-fd ?
    * Maybe no as sender/receiver pair is always same for the same skb

I guess keeping the empty index as is and index based scrubbing
would be simpler and cleaner ?


> 
> Therefore exercising scm_fp_list would be a good idea.
> We should provide some more examples of the filtering policy in the selftests.
> Maybe a simple example, e.g. only memfd or a pipe fd can be passed,
> and nothing else.
> It would require checking file->f_ops.

Yes, and I thought we need fd-to-file kfunc or BPF helper, but I was
not sure which would be better as both functionality should be stable.
But given the user needs to inspect the raw scm_fp_list, kfunc is better ?

* bpf_fd_to_file()
or
* bpf_unix_get_scm_rights() -> return struct file ?

plus

* bpf_unix_scrub_scm_rights() -> scrub based on fd or file ?


> 
> I don't think "scrub all file descriptors" is the only possible usage scenario.
> In the case of FDSTORE=1, it might be "everything except fuse or NFS fds" etc.
> 
> Eventually if file local storage happens, more interesting policies
> may be possible.
> 

