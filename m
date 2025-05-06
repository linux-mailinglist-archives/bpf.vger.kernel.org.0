Return-Path: <bpf+bounces-57511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F69AAC426
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 14:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6218D168CBB
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 12:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283032820BC;
	Tue,  6 May 2025 12:27:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF1627FD5F;
	Tue,  6 May 2025 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746534445; cv=none; b=otfILYGVeFoffVvrLywbXBSeRtj8pCovM2JZbrQh1ViU2phPKnfjUW5Ehu1bIzuv+ypuFWxoxDQoyz0lOtfqiYaMOYq8eSs2bIWhALOE82kWoH1xPFkr9+WWJVQUjD4brkayo3e4A1SS1LjjxNvZm8i+MmZkDRXCCqyuLN4hQCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746534445; c=relaxed/simple;
	bh=m7SBsfQfLVW4xNj3QrIhN2V3ELt1ceEG+cP+bc5hvNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nh5Wo4Zb7U0gSlVNWxuGiR/qV1HW1wRYwcm0OBUo3v2wC8smutP2WJ38N5VPWr0rb6k475ow3FtNk34kvcUfk2GDUwMT4zJ7t48c2aWfgzL0GOGmocgCa2/yvJGDJwjOLIBu3GcIP/qtYKsEyaIMKiJu3VdIE4onFO0mXyQgpno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net; spf=pass smtp.mailfrom=poettering.net; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poettering.net
Received: from zeta (p200300ea6f02a700ee7fde6810ab8036.dip0.t-ipconnect.de [IPv6:2003:ea:6f02:a700:ee7f:de68:10ab:8036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by gardel.0pointer.net (Postfix) with ESMTPSA id 89EC9E802CC;
	Tue,  6 May 2025 14:17:24 +0200 (CEST)
Date: Tue, 6 May 2025 14:17:22 +0200
From: Lennart Poettering <lennart@poettering.net>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 0/5] af_unix: Allow BPF LSM to scrub
 SCM_RIGHTS at sendmsg().
Message-ID: <aBn90vJ49ymBT3LW@zeta>
References: <20250505215802.48449-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505215802.48449-1-kuniyu@amazon.com>

On Mo, 05.05.25 14:56, Kuniyuki Iwashima (kuniyu@amazon.com) wrote:

> As long as recvmsg() or recvmmsg() is used with cmsg, it is not
> possible to avoid receiving file descriptors via SCM_RIGHTS.
>
> This behaviour has occasionally been flagged as problematic.
>
> For instance, as noted on the uAPI Group page [0], an untrusted peer
> could send a file descriptor pointing to a hung NFS mount and then
> close it.  Once the receiver calls recvmsg() with msg_control, the
> descriptor is automatically installed, and then the responsibility
> for the final close() now falls on the receiver, which may result
> in blocking the process for a long time.
>
> systemd calls cmsg_close_all() [1] after each recvmsg() to close()
> unwanted file descriptors sent via SCM_RIGHTS.
>
> However, this cannot work around the issue because the last fput()
> could occur on the receiver side once sendmsg() with SCM_RIGHTS
> succeeds.  Also, even filtering by LSM at recvmsg() does not work
> for the same reason.
>
> Thus, we need a better way to filter SCM_RIGHTS on the sender side.
>
> This series allows BPF LSM to inspect skb at sendmsg() and scrub
> SCM_RIGHTS fds by kfunc.

Frankly, this sounds like a bad idea to me. The number and order of
the fds passed matters, and if you magically make some fds disappear
everything becomes a complete mess for most protocols. Hence, making
fds disappear from a messasge mid-flight is really not a realistic
option, already for compat. Not for systemd, and not for other tools
either I am sure.

I also think it's pointless to enforce this on the receiving side,
because the deed is done by then. i.e. it doesn't matter if we have to
close the fd via bpf or in userspace, we still have to wait for it to
be closed on the receiving side, hence we have to pay. i.e. focus must
be to refuse the fds on the sender side, instead of allowing this to
go to the receiver side.

From my perspective this must be enforced on sender side. And more
importantly, for systemd's usecase it would be a lot more relevant to
have a simple, dumb boolean per socket instead of the full bpf
machinery. I mean, as much as I like the lsm-bpf concept it's not
clear to me that this is the right place to make use of it. I
personally would really like to see a SO_PASSRIGHTS sockopt, that is
modelled after SO_PASSCREDS and SO_PASSSEC.

Lennart

--
Lennart Poettering, Berlin

