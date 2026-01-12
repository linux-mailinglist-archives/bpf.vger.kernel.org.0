Return-Path: <bpf+bounces-78612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7EAD14DD3
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 20:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F09A030285DD
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 19:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F79E311C38;
	Mon, 12 Jan 2026 19:08:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.davidv.dev (mail.davidv.dev [78.46.233.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61797311951
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.233.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244927; cv=none; b=gesNhSLAF5aAVEqqTqCdqSfn4m7BGKoRHL4wzFNlYLypKi6sdyCW093yC+a+PFdwhi2OiGFjg6RmoT1o2T3kjnjUpFFyEDTAeHlfgyygHs9UpHi+sNv7pq7dsUFKCIKzxthaTbKeqLageYrVvnZgtNAs7Aal5ri5YHVDrBuFIQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244927; c=relaxed/simple;
	bh=ykMtPQ2rz3FZgGuysQEKnShJGTFv8Id4bjm/Y/4POmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=srI8IdY4BbX9xasAYVk9UAHnPPmFYZ06I1E34glO/zB/D8gmbhg4XYFMWRjHluQTdGW2MGBubVWZVfYBzlDv1q2+LM9YAoakmI43y7ET8SeCsRqbx3MNOzvbJwsJJXDNMGw5Eau53w5F4WfwhQ1PWFl+JoHLBPtjoVcgSls494I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidv.dev; spf=pass smtp.mailfrom=davidv.dev; arc=none smtp.client-ip=78.46.233.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidv.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidv.dev
X-Spam-Action: no action
X-Spam-Score: 0.01
Received: from [192.168.2.144]
	by mail.davidv.dev (chasquid) with ESMTPSA
	tls TLS_CHACHA20_POLY1305_SHA256
	(over submission+TLS, TLS-1.3, envelope from "david@davidv.dev")
	; Mon, 12 Jan 2026 20:08:43 +0100
Message-ID: <bb6a3ada-ddcf-417d-82c7-f86cde6ed4f7@davidv.dev>
Date: Mon, 12 Jan 2026 20:08:42 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Usage of kfuncs in tracepoints
To: Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org
References: <f5e6c1e4-f2f2-4982-a796-e3a49c522bbf@davidv.dev>
 <3735a372-1641-4a37-a7e2-54b7533caf83@oracle.com>
Content-Language: en-US
From: David <david@davidv.dev>
In-Reply-To: <3735a372-1641-4a37-a7e2-54b7533caf83@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/01/2026 19:03, Alan Maguire wrote:

 > Most of the examples use a bpftool-generated vmlinux.h

I am using a generated header, but not seeing bpf_strstr in the output:

```

$ bpftool btf dump file ~/git/linux-6.18.2/vmlinux.unstripped | grep strstr
[42254] FUNC 'strstr' type_id=42253 linkage=static
[51220] FUNC 'bpf_strstr' type_id=51198 linkage=static
$ bpftool btf dump file ~/git/linux-6.18.2/vmlinux.unstripped format c  
| grep -c strstr
0
```

I am generating my header with an older bpftool:

```
$ bpftool --version
bpftool v7.4.0
using libbpf v1.4
features:
```

But I'm using libbpf v1.6.2 on my custom loader.

> I think you need to add "__ksym __weak";" here i.e.

This change let me load the program, however, libbpf cannot find a 
kernel image at
/sys/kernel/btf/vmlinux, because /sys/kernel/btf is not populated on my 
system.

My kernel _is_ built with CONFIG_DEBUG_INFO_BTF=y, is there something 
else I need to do
  to get this path populated?

Because this path is missing, libbpf reports:

```
kernel BTF is missing at '/sys/kernel/btf/vmlinux', was 
CONFIG_DEBUG_INFO_BTF enabled?
```

But I see from strace that it tries a few fallback paths.
In the meantime, I copied my kernel into /boot/vmlinux-6.18.2 so libbpf 
can find it, but
now the loader says

```
calling kernel function is not supported without CONFIG_DEBUG_INFO_BTF
```

with strace showing a return value of ENOTSUPP + error 524:

```
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_TRACEPOINT, insn_cnt=6, 
insns=0x7f6ab777c230, license="GPL", log_level=0, log_size=0, 
log_buf=NULL, kern_version=KERNEL_VERSION(6, 18, 2), prog_flags=0, 
prog_name="trace_sendto
_en", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, 
prog_btf_fd=8, func_info_rec_size=8, func_info=0x7f6ab777d280, 
func_info_cnt=1, line_info_rec_size=16, line_info=0x7f6ab777ed40, 
line_info_cnt=2, attach_btf_id=0, a
ttach_prog_fd=0, core_relo_cnt=0, fd_array=NULL, core_relos=NULL, 
core_relo_rec_size=0, log_true_size=0, prog_token_fd=0, fd_array_cnt=0}, 
152) = -1 ENOTSUPP (Unknown error 524)
```

Can I not use `bpf_strstr` on a tracepoint? To validate, I tried a 
`raw_tp` but
had the same result.

David


