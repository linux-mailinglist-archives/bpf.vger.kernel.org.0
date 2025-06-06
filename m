Return-Path: <bpf+bounces-59871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECCDAD0557
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 17:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F35189E410
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 15:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72EF289820;
	Fri,  6 Jun 2025 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O97hB+bs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6357613DBA0;
	Fri,  6 Jun 2025 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224278; cv=none; b=etc6pK1HJd694rfFBK6o3KhNGKugGid3XnU8p1kCs5E3Lu3e8usiOE57T9AH+LTyWY9eC8XG2MOCJmdIfEf+M0BLktd9NirbtAdCkT1CdK2Y6rDCvlMLC7H/3TNdJbxDY7d9NswNK3gnUHpSBOBVtgzGV7EkukwSILHgq7HVhJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224278; c=relaxed/simple;
	bh=PJ9atPS4bsZVal3++1yzNZRHe20wMZYu+nKTUqy5wCE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BWu/dYIPUj5CjXm5+oxdKeOFKrR/PhtAgxBhV1EXJLYpaCSHKdt3sllDKlqJ9J1Qfzu6sFtqcmNBRVwZcCffhpR4JurRe2WObc3AP30L8v4F1skAGO5qXksFcxYZefcLtEujub8gzIfMECWGNY6n9D+oi3IirTD0r4jZNbgAxxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O97hB+bs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D41C4CEEB;
	Fri,  6 Jun 2025 15:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749224277;
	bh=PJ9atPS4bsZVal3++1yzNZRHe20wMZYu+nKTUqy5wCE=;
	h=Date:From:To:Cc:Subject:From;
	b=O97hB+bs7nvpAmHSxmuM4Sm7KWAGcRTgOpArRr9v7oSDE9EBSm6KbrGrEu3fYX5be
	 ph24h22vO4GrXR7BI7+uNqxT1mSGo7Q0krrikqFZCBvJLT/TEXy4cFKtR6fpCCs7mt
	 KgLlmJ6C66BRjPu9XAnJC7FhnlLO+1BcAEPjRYw7cnPYeyMBChK6C5LEt9MHlMhxZt
	 n9CKS9TfECZhuMzDrcWK8+1pmNG67lj/eoL6eaPm0kyWyBDwK68K9ZuwnB4O/mTWhY
	 Ypwq3MvwXOOx9gKt83LMbZdSHUqTb7fqEr4rZY/5fCflEy6gUolrLcGi6cWmDZiMGL
	 RlK+oZQ/pisJQ==
Date: Fri, 6 Jun 2025 12:37:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Lorenz Bauer <lmb@isovalent.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: BTF loading failing on perf
Message-ID: <aEMLU2li1x2bAO4w@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

root@number:~# perf trace -e openat --max-events=1
libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux': -ENODEV
libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux': -ENODEV
     0.000 ( 0.016 ms): ptyxis-agent/4375 openat(dfd: CWD, filename: "/proc/6593/cmdline", flags: RDONLY|CLOEXEC) = 13
root@number:~#

openat(AT_FDCWD, "/sys/kernel/btf/vmlinux", O_RDONLY) = 258
mmap(NULL, 6519699, PROT_READ, MAP_PRIVATE, 258, 0) = -1 ENODEV (No such device)
libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux': -ENODEV

root@number:~# ls -la /sys/kernel/btf/vmlinux 
-r--r--r--. 1 root root 6519699 Jun  6 12:19 /sys/kernel/btf/vmlinux
root@number:~# uname -a
Linux number 6.14.9-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Thu May 29 14:27:53 UTC 2025 x86_64 GNU/Linux
root@number:~# head /etc/os-release 
NAME="Fedora Linux"
VERSION="42 (Workstation Edition)"
RELEASE_TYPE=stable
ID=fedora
VERSION_ID=42
VERSION_CODENAME=""
PLATFORM_ID="platform:f42"
PRETTY_NAME="Fedora Linux 42 (Workstation Edition)"
ANSI_COLOR="0;38;2;60;110;180"
LOGO=fedora-logo-icon
root@number:~# rpm -q glibc-devel
package glibc-devel is not installed
root@number:~# rpm -q glibc
glibc-2.41-5.fc42.x86_64
root@number:~# 

Reverting the patch below "cures" the problem.

⬢ [acme@toolbx perf-tools]$ git log --oneline -10 tools/lib/bpf/
370118ff875244d4 (HEAD -> perf-tools) Revert "libbpf: Use mmap to parse vmlinux BTF from sysfs"
90b83efa6701656e Merge tag 'bpf-next-6.16' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
3c0421c93ce4ff0f libbpf: Use mmap to parse vmlinux BTF from sysfs
4e29128a9acec2a6 libbpf/btf: Fix string handling to support multi-split BTF
d0445d7dd3fd9b15 libbpf: Check bpf_map_skeleton link for NULL
fd5fd538a1f4b34c libbpf: Use proper errno value in nlattr
62e23f183839c3d7 libbpf: Improve BTF dedup handling of "identical" BTF types
41d4ce6df3f49453 bpf: Fix uninitialized values in BPF_{CORE,PROBE}_READ
358b1c0f56ebb699 libbpf: Use proper errno value in linker
8e64c387c942229c libbpf: Add identical pointer detection to btf_dedup_is_equiv()
⬢ [acme@toolbx perf-tools]$

root@number:~# perf -v
perf version 6.15.g370118ff8752
root@number:~# perf trace -e connect --max-events=5
     0.000 ( 0.021 ms): DNS Res~ver #4/7932 connect(fd: 102, uservaddr: { .family: LOCAL, path: /run/systemd/r }, addrlen: 42) = 0
     0.304 ( 0.013 ms): systemd-resolv/1420 connect(fd: 25, uservaddr: { .family: INET, port: 53, addr: 186.208.78.194 }, addrlen: 16) = 0
     0.371 ( 0.002 ms): systemd-resolv/1420 connect(fd: 26, uservaddr: { .family: INET, port: 53, addr: 186.208.78.194 }, addrlen: 16) = 0
     0.591 ( 0.009 ms): DNS Res~ver #2/7523 connect(fd: 104, uservaddr: { .family: LOCAL, path: /run/systemd/r }, addrlen: 42) = 0
     0.731 ( 0.006 ms): systemd-resolv/1420 connect(fd: 28, uservaddr: { .family: INET, port: 53, addr: 186.208.78.194 }, addrlen: 16) = 0
root@number:~# 

Ideas?

- Arnaldo

⬢ [acme@toolbx perf-tools]$ git bisect good
3c0421c93ce4ff0f5f2612666122c34fc941d569 is the first bad commit
commit 3c0421c93ce4ff0f5f2612666122c34fc941d569
Author: Lorenz Bauer <lmb@isovalent.com>
Date:   Tue May 20 14:01:19 2025 +0100

    libbpf: Use mmap to parse vmlinux BTF from sysfs
    
    Teach libbpf to use mmap when parsing vmlinux BTF from /sys. We don't
    apply this to fall-back paths on the regular file system because there
    is no way to ensure that modifications underlying the MAP_PRIVATE
    mapping are not visible to the process.
    
    Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
    Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
    Tested-by: Alan Maguire <alan.maguire@oracle.com>
    Acked-by: Andrii Nakryiko <andrii@kernel.org>
    Link: https://lore.kernel.org/bpf/20250520-vmlinux-mmap-v5-3-e8c941acc414@isovalent.com

 tools/lib/bpf/btf.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 71 insertions(+), 18 deletions(-)
⬢ [acme@toolbx perf-tools]$

