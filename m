Return-Path: <bpf+bounces-48462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2402BA08260
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17CD188791D
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCBE20013C;
	Thu,  9 Jan 2025 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Mry4kHds"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286EA23C9
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 21:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459234; cv=none; b=fAaJ7qXcqFfrey6ZkfUZvsrH9JWJ8GKm11pj70SghxrYSWoP336u7jShhy/joKvKK5tQi5Fz1tiQ7d48HJf72Y64MRnNeEuk2sVI8697p7aA021zSUFvW0RvYmBZz6vowONaS3+X+wW0L0zZz+r18W6xt76LZ0uvJ+oom6Aa6Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459234; c=relaxed/simple;
	bh=kk3Y9a0BzSV7f/bJJzvmiXlKgR3CdXOsMI9lMewnv4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+eBXq99+J6Psx2dIZfPbgvj9p0A5fRJz/FY9pn6kbBYJLb+a4r7Dr18PJ7jq5HqbYwwpw9pHdW2usPwvANqi9QI9xxpVjSyOUxpBEbkvIAohpgEBilG5eDob4wmQYX3MavtSI5zx5I9fZVNxhmvP5a9+0YfSA6lM1EMsF75oYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Mry4kHds; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id B5E25203E39C;
	Thu,  9 Jan 2025 13:47:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B5E25203E39C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736459232;
	bh=kk3Y9a0BzSV7f/bJJzvmiXlKgR3CdXOsMI9lMewnv4A=;
	h=From:To:Cc:Subject:Date:From;
	b=Mry4kHdsVYauNhMJN6NEQwMkHpAElZTset9axw2kl8/EbHGgiI4oQFgUNpvKt091t
	 TB41YxQ/B+qieOc/LKLBEylJ0w7e3bX+9dBKJlFwcGM2mnU0aQRvajnNg8Iec2z9Qc
	 EeBywGCAdrBgcemvrt3iosouhWEjl/fefRLOHz4Q=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org
Cc: nkapron@google.com,
	teknoraver@meta.com,
	roberto.sassu@huawei.com,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	code@tyhicks.com,
	flaniel@linux.microsoft.com
Subject: [POC][RFC][PATCH] bpf: in-kernel bpf relocations on raw elf files
Date: Thu,  9 Jan 2025 13:43:42 -0800
Message-ID: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This is a proof-of-concept, based off of bpf-next-6.13. The
implementation will need additional work. The goal of this prototype was
to be able load raw elf object files directly into the kernel and have
the kernel perform all the necessary instruction rewriting and
relocation calculations. Having a file descriptor tied to a bpf program
allowed us to have tighter integration with the existing LSM
infrastructure. Additionally, it opens the door for signature and provenance
checking, along with loading programs without a functioning userspace.

The main goal of this RFC is to get some feedback on the overall
approach and feasibility of this design.

A new subcommand BPF_LOAD_FD is introduced. This subcommand takes a file
descriptor to an elf object file, along with an array of map fds, and a
sysfs entry to associate programs and metadata with. The kernel then
performs all the relocation calculations and instruction rewriting
inside the kernel. Later BPF_PROG_LOAD can reference this sysfs entry
and load/attach previously loaded programs by name. Userspace is
responsible for generating and populating maps.

CO-RE relocation support already existed in the kernel. Support for
everything else, maps, externs, etc., was added. In the same vein as
29db4bea1d10 ("bpf: Prepare relo_core.c for kernel duty.")
this prototype directly uses code from libbpf.

One of the challenges encountered was having different elf and btf
abstractions utilized in the kernel vs libpf. Missing btf functionality
was ported over to the kernel while trying to minimize the number of
changes required to the libpf code. As a result, there is some code
duplication and obvious refactoring opportunities. Additionally, being
able to directly share code between userspace and kernelspace in a
similar fashion to relo_core.c would be a TODO.

