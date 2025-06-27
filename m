Return-Path: <bpf+bounces-61724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 395FEAEADA4
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 05:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C4F4A75B6
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 03:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A59F1ACEDC;
	Fri, 27 Jun 2025 03:58:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp233.sjtu.edu.cn (smtp233.sjtu.edu.cn [202.120.2.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3473E19F420;
	Fri, 27 Jun 2025 03:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.120.2.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750996715; cv=none; b=Mkysr/raNNRrA1+sh7ONOaN2eypg9DyuHej5Fe81GpuGFk/G3s+4nPANOIKjt+j0QqME1cZa70uByJLa7OqOg/DSiSXw2m6EbLYyqHOXxUQ1gwQW73ioetNaPag/h7TymN6n+QBRS8XL90pneuKRUPkxIvNmBs33hFE14xrsXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750996715; c=relaxed/simple;
	bh=KWYG+KDmZ23DgBo9d2D5szE4ZJeBNWiYsvY7c/LCezw=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=Ks0TAyNQ1bcWQWeUOjRspvkzHnptVwK6i5IBiRRTU1UJEbCymkbEBW6MIYqDQNZJkJimZVOaytM20O1ScFbm4AIyBYw8FNezG8PdU38sCZZnzP04G8aVkCpLg+X8oKTxSznCK/RgzEsqbFmUxuETfeyGKxbus9jRic629ilsU6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sjtu.edu.cn; spf=pass smtp.mailfrom=sjtu.edu.cn; arc=none smtp.client-ip=202.120.2.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjtu.edu.cn
Received: from mta90.sjtu.edu.cn (unknown [10.118.0.90])
	by smtp233.sjtu.edu.cn (Postfix) with ESMTPS id 1D16D1009E7B2;
	Fri, 27 Jun 2025 11:52:28 +0800 (CST)
Received: from mstore132.sjtu.edu.cn (unknown [10.118.0.132])
	by mta90.sjtu.edu.cn (Postfix) with ESMTP id B834237D65C;
	Fri, 27 Jun 2025 11:52:27 +0800 (CST)
Date: Fri, 27 Jun 2025 11:52:27 +0800 (CST)
From: =?gb2312?B?s8LA1g==?= <tom2cat@sjtu.edu.cn>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1444123482.1827743.1750996347470.JavaMail.zimbra@sjtu.edu.cn>
Subject: [BUG][BPF] Kernel Bug Triggered when Ebpf Verifier Check Fails
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.0.14_GA_4767 (ZimbraWebClient - GC137 (Win)/10.0.15_GA_4781)
Thread-Index: +aKzrn/MfADNs/QCqWSK6DYv606TCw==
Thread-Topic: Kernel Bug Triggered when Ebpf Verifier Check Fails

Hi BPF maintainers,

I'm reporting a bug I encountered in the BPF subsystem on Linux kernel version <<5.19.5>>, <<6.15.0-rc2-00577-g8066e388be48-dirty>>,  <<6.15.3>>.

I wrote a BPF program that triggered a verifier rejection, but at the same time, the kernel emitted a BUG() warning at <<kernel/bpf/hashtab.c:222>>, suggesting a potential kernel-side issue rather than just verifier rejection. Later on, I discovered that constructing any ebpf Verifier rejection behavior within the specified code snippets would trigger this kernel bug.

- Miniest poc code:

#include "vmlinux.h"
#include <bpf/bpf_helpers.h>

struct mac_table_entry
{
    struct bpf_timer expiration_timer;
    __u32 ifindex;
    __u64 last_seen_timestamp_ns;
    struct in_addr border_ip;
};

struct
{
    __uint(type, BPF_MAP_TYPE_HASH);
    __type(key, struct mac_address);
    __type(value, struct mac_table_entry);
    __uint(max_entries, 4 * 1024 * 1024);
    __uint(pinning, LIBBPF_PIN_BY_NAME);
} mac_table SEC(".maps");

SEC("xdp.frags")
long mac_xdp_func(struct xdp_md *ctx)
{
    // Constructing any code segment that does not meet the requirements of BPF Validator
    // can trigger a kernel BUG: sleeping function called from invalid context at kernel/bpf/hashtab.c:222:
    while(1){
        __u32 j;
    }
    return XDP_PASS;
}

char LICENSE[] SEC("license") = "Dual BSD/GPL";

- Kernel version: <<6.15.3...>>
- Architecture: <<x86_64>>
- dmesg excerpt: <<BUG: sleeping function called from invalid context at kernel/bpf/hashtab.c:222>>

Detailed info including reproducible BPF program and kernel logs have been filed on Bugzilla:

  https://bugzilla.kernel.org/show_bug.cgi?id=220278


Please let me know if you need more information or if I can help test a patch.

Thanks,  
Le Chen;  
tom2cat@sjtu.edu.cn; 

