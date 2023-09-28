Return-Path: <bpf+bounces-11051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCA57B2203
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 18:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 6233FB20CA7
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 16:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06A851229;
	Thu, 28 Sep 2023 16:17:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5557113AFB;
	Thu, 28 Sep 2023 16:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601E1C433C8;
	Thu, 28 Sep 2023 16:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695917849;
	bh=dDlJclctJebD1exFPzxNAZrB7CQjcpVHlD7ElW0MgAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fssBEPbw9W11EX4fKT2YjN4xVBR9E4vNZDA1X2y4drhUW8Bjk3Z9zAxW5o8wwBEad
	 JeDFtQ0g38ymn6Q1QguLfri9a9El0WiROYUxy/kHjgAZXvSd4+QfNXVDIR0O9otK/s
	 AVO4cha55o9JqXtpDNIn6uLQaR9A/DxPG4liRa1nHhXy9peftFZ2YMbjaewjeRRfHj
	 iaHi8wG1WfykOpc4NYCtvJmDBr9mfame119bQAB1Vn7Wi+qpPu4KD11kXPq1d668i1
	 QCydqFcEOv1E6KXpIvQGzXiYiyu+XEAxVqR7nuS94wWiZKfrVfr+jmcHW4JZJQTwM/
	 JnyvUk+qktCcA==
Date: Thu, 28 Sep 2023 18:17:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	David Ahern <dsahern@kernel.org>
Subject: Re: Persisting mounts between 'ip netns' invocations
Message-ID: <20230928-geldbeschaffung-gekehrt-81ed7fba768d@brauner>
References: <87a5t68zvw.fsf@toke.dk>
 <2aa087b5-cbcf-e736-00d4-d962a9deda75@6wind.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2aa087b5-cbcf-e736-00d4-d962a9deda75@6wind.com>

On Thu, Sep 28, 2023 at 11:54:23AM +0200, Nicolas Dichtel wrote:
> + Eric
> 
> Le 28/09/2023 à 10:29, Toke Høiland-Jørgensen a écrit :
> > Hi everyone
> > 
> > I recently ran into this problem again, and so I figured I'd ask if
> > anyone has any good idea how to solve it:
> > 
> > When running a command through 'ip netns exec', iproute2 will
> > "helpfully" create a new mount namespace and remount /sys inside it,
> > AFAICT to make sure /sys/class/net/* refers to the right devices inside
> > the namespace. This makes sense, but unfortunately it has the side
> > effect that no mount commands executed inside the ns persist. In
> > particular, this makes it difficult to work with bpffs; even when
> > mounting a bpffs inside the ns, it will disappear along with the
> > namespace as soon as the process exits.
> > 
> > To illustrate:
> > 
> > # ip netns exec <nsname> bpftool map pin id 2 /sys/fs/bpf/mymap
> > # ip netns exec <nsname> ls /sys/fs/bpf
> > <nothing>
> > 
> > This happens because namespaces are cleaned up as soon as they have no
> > processes, unless they are persisted by some other means. For the
> > network namespace itself, iproute2 will bind mount /proc/self/ns/net to
> > /var/run/netns/<nsname> (in the root mount namespace) to persist the
> > namespace. I tried implementing something similar for the mount
> > namespace, but that doesn't work; I can't manually bind mount the 'mnt'
> > ns reference either:
> > 
> > # mount -o bind /proc/104444/ns/mnt /var/run/netns/mnt/testns
> > mount: /run/netns/mnt/testns: wrong fs type, bad option, bad superblock on /proc/104444/ns/mnt, missing codepage or helper program, or other error.
> >        dmesg(1) may have more information after failed mount system call.
> > 
> > When running strace on that mount command, it seems the move_mount()
> > syscall returns EINVAL, which, AFAICT, is because the mount namespace
> > file references itself as its namespace, which means it can't be
> > bind-mounted into the containing mount namespace.
> > 
> > So, my question is, how to overcome this limitation? I know it's
> > possible to get a reference to the namespace of a running process, but
> > there is no guarantee there is any processes running inside the
> > namespace (hence the persisting bind mount for the netns). So is there
> > some other way to persist the mount namespace reference, so we can pick
> > it back up on the next 'ip netns' invocation?
> > 
> > Hoping someone has a good idea :)
> We ran into similar problems. The only solution we found was to use nsenter
> instead of 'ip netns exec'.
> 
> To be able to bind mount a mount namespace on a file, the directory of this file
> should be private. For example:
> 
> mkdir -p /run/foo
> mount --make-rshared /
> mount --bind /run/foo /run/foo
> mount --make-private /run/foo
> touch /run/foo/ns
> unshare --mount --propagation=slave -- sh -c 'yes $$ 2>/dev/null' | {
>         read -r pid &&
>         mount --bind /proc/$pid/ns/mnt /run/foo/ns
> }
> nsenter --mount=/run/foo/ns ls /
> 
> But this doesn't work under 'ip netns exec'.

Afaiu, each ip netns exec invocation allocates a new mount namespace.
If you run multiple concurrent ip netns exec command and leave them
around then they all get a separate mount namespace. Not sure what the
design behind that was. So even if you could persist the mount namespace
of one there's still no way for ip netns exec to pick that up iiuc.

So imho, the solution is to change ip netns exec to persist a mount
namespace and netns namespace pair. unshare does this easily via:

sudo mkdir /run/mntns
sudo mount --bind /run/mntns /run/mntns
sudo mount --make-slave /run/mntns

sudo mkdir /run/netns

sudo touch /run/mntns/mnt1
sudo touch /run/netns/net1

sudo unshare --mount=/run/mntns/mnt1 --net=/run/netns/net1 true

So I'd probably patch iproute2.

