Return-Path: <bpf+bounces-78598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E68A1D14366
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 17:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37B9F30056CC
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 16:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037F536998E;
	Mon, 12 Jan 2026 16:58:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.davidv.dev (mail.davidv.dev [78.46.233.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19EE32ED20
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.233.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237136; cv=none; b=Nk4Bcwk4Vw11qgMXnMTJfQk5T5YsRTKkTocGQeqhfOXPERiPh5sCPTXCvx+ai94KPUNdtx+iJKqtPIb4qE2d7u+Fs5zMVGm1kL/iqJN1qjm2GA78XpoXVG/VKfEB+aDvk/JxfEUb48NXQac1sEUkCHUYkiMQGP3ZhxiErbVmwH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237136; c=relaxed/simple;
	bh=9y2eLNFm/tNxzNShpdva8xVmph0zkDTFw8BKcjU6IWI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=IzEc+HKHW1kV2fjJqhsyv3K/2RnLBIed+NUWXLrM58aSUi6QQhAXyst4D3SpNX/oBoVzkPXdFkIOdE2XbDw6zzLalu0d92ja0NdhmKrOgresVuIpa3+EVWlS2OwsgmXSVFdYs/kt50Bh746p+ozPAH/vbLg9aPyQW4AU+E3q4pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidv.dev; spf=pass smtp.mailfrom=davidv.dev; arc=none smtp.client-ip=78.46.233.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidv.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidv.dev
X-Spam-Action: no action
X-Spam-Score: 0.01
Received: from [192.168.2.144]
	by mail.davidv.dev (chasquid) with ESMTPSA
	tls TLS_CHACHA20_POLY1305_SHA256
	(over submission+TLS, TLS-1.3, envelope from "david@davidv.dev")
	; Mon, 12 Jan 2026 17:57:44 +0100
Message-ID: <f5e6c1e4-f2f2-4982-a796-e3a49c522bbf@davidv.dev>
Date: Mon, 12 Jan 2026 17:57:44 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: bpf@vger.kernel.org
From: David <david@davidv.dev>
Subject: Usage of kfuncs in tracepoints
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi

I'm trying to use `bpf_strstr` in a program that's running on kernel 6.18.2,
but I'm getting the following error on load:

 > failed to find BTF for extern 'bpf_strstr' [53] section: -2

A minimal reproducer for this is:

```
extern int bpf_strstr(const char *s1__ign, const char *s2__ign);
SEC("tracepoint/syscalls/sys_enter_sendto")
int trace_sendto_entry(struct trace_event_raw_sys_enter *ctx)
{
       char buf[128];
       int pos = bpf_strstr(buf, "A");
}
```

My kernel was initially built with CONFIG_DEBUG_INFO_BTF=n, rebuilding with
CONFIG_DEBUG_INFO_BTF=y did not change the error.

I've only tried this with a stripped kernel image, which is 4MiB larger than
the image with no BTF info.

Running `bpftool btf dump` on the stripped iamge does show the kfunc:

```
$ bpftool btf dump file ~/git/linux-6.18.2/vmlinux | grep strstr
[26877] FUNC 'bpf_strstr' type_id=26855 linkage=static
[60337] FUNC 'strstr' type_id=60336 linkage=static
```

I'm running this program in a virtual machine with a custom init; running
through strace shows a failed load of `/proc/version_signature`, but I 
assume a
fallback to `uname`.

```
faccessat2(AT_FDCWD, "/proc/version_signature", R_OK, AT_EACCESS) = -1 
ENOENT (No such file or directory)
uname({sysname="Linux", nodename="(none)", ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x7f3fe6630000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x7f3fe662f000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x7f3fe662e000
munmap(0x7f3fe662e000, 4096) = 0
munmap(0x7f3fe6630000, 8192 <unfinished ...>
nanosleep({tv_sec=0, tv_nsec=10000000} <unfinished ...>
futex(0x7f3fe6a44858, FUTEX_WAKE_PRIVATE, 1) = 1
munmap(0x7f3fe6839000, 16384 <unfinished ...>
sendto(3, "\1", 1, MSG_NOSIGNAL, NULL, 0 <unfinished ...>
futex(0x7f3fe6a43b70, FUTEX_WAIT_PRIVATE, 2, NULL <unfinished ...>
sendto(3, "@", 1, MSG_NOSIGNAL, NULL, 0) = 1
sendto(3, "libbpf: failed to find BTF for e"..., 64, MSG_NOSIGNAL, NULL, 
0) = 64
close(3)
```

Maybe there's another dependency I'm not aware of for kfuncs?

I'm not sure what I'm doing wrong, can you point me in the right direction?


David


