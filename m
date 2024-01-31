Return-Path: <bpf+bounces-20831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A084384437D
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 16:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B0C1C25881
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 15:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524B212A154;
	Wed, 31 Jan 2024 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktoj0sqQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A59312A143
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716582; cv=none; b=A2H7QH9aJSMrK22LnWv/8jsv1e3mAJ/gllQ+j4g4WjKcpGrGlvZ3IO8rMupORRz/PmX9nVtQyre3LePb6VCu+B8wMv1Y1sfUGr6BlRx78hLvvuHYC2uIuvm0s4Z+hkUP6zfq7QXUPtRfbzobGPx4j3Lko3iOH6Sn2wcY6o/6IFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716582; c=relaxed/simple;
	bh=0gD/5N1wgh+Buk7oeAFKq3S1ttCnUWmD+lvPEwa42J4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSUu09lHB6ZtZFLGYT2V61rvd9UbdBTYuZJeJbnF5xS0i6s54EzaoPnzdx9QjKMuGya7p8kvya+ZfL5eBBQ3qCNqn8YhbicxO/x7oan0IYOGzZtt1QNxq3BRcUVTIvhxUV/t8O7FDZ1A8PDIHk7fJvx4N7EasnNSz88adpOKBpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktoj0sqQ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ddc1b30458so4515122b3a.1
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 07:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706716579; x=1707321379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHlt8ETwKF14kn2Dn8/GyWjMlD/y+PJPal9uXfL08sk=;
        b=ktoj0sqQKAJQHE7ivlZ54jHcul6JXI9YS1u5YwpQnn7wZT033U4eqGfUPkqVRgK10i
         IuRyfD3aS/4pCcNpt/WPzqhrffyaTINvY2ZAYf9rMk5qmqK8tXRIs/0XQz0gZ0Hcvjei
         vz+azyqm02aYODIMrnSueT+dUmQzxv9XYXS8v+HTf03Idf2P59yrHT5HixhOAtdSPPOe
         SplPQ7m3+UBhtsk1h5bRhcE8eDCidslPhFrRM++ayIt9gWBJ4G1OWqx4vl61Gymo8QjN
         2ILPd58yT5NA1jUTfHpFduAJkh7ua9Yigg4qlK3D/uStNokSZqHin550QoqNZsden8w/
         WYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706716579; x=1707321379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHlt8ETwKF14kn2Dn8/GyWjMlD/y+PJPal9uXfL08sk=;
        b=NJ8KMSBVA9F+QrrHAU8etgXSS5kU1dkfLRVphgnYM7evb0zkn2p62W59Gn8tehewHB
         YSMEhpXVHxNe1KszTqS5E51Qhod4KcUIxv1L68qceS7hCVxgJHlQNW/sNPORB6Ht21Dt
         Ssnju3dAmAELE9xd7AHb7x/VRS2KbjDzXhJsno+XKhM0JDe7subNUXI3bt1kNCg7FfJU
         NEii2EFO2IIwwNJI6WMkORHkQ96Q+aGEDgksdjj+X1LuD86dYr8GOpdKuulzHblTm3gu
         Hr+yGU0YhEm194/13+/gO9ImPcC6J++9NgRlSGn4o27M5DXoo7wLR2bR2nFXzqgACeOq
         GgFQ==
X-Gm-Message-State: AOJu0YzhMNy/35E34Yq/xvUays5hKF43AI3ndfRvnmImlgUB84fFDD2H
	XrBPHNsxnpcZJKRE8coGIkn79RuZ39Wj+MuMUWqYMQBMC4auSfuhEzjdGSLw
X-Google-Smtp-Source: AGHT+IHe+ko2nq6SkQxv3iUahrtcm/U2zvVf6QnPOIZi08oYfGmVutaYXT4BF9eCmco/abI0ynzDDQ==
X-Received: by 2002:a05:6a00:4e4c:b0:6d9:aaef:89a7 with SMTP id gu12-20020a056a004e4c00b006d9aaef89a7mr1906627pfb.10.1706716579414;
        Wed, 31 Jan 2024 07:56:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWyYZ16h8cDbK41ouNAq8F4Vm8jiH7cwDw8bUBb4DkTelbHRvfk/uqtpd10Jp+buW8Y3BpIeLR05e2vMvfRMqV9FMyem7rwDhkw9Q8GIPxo6KtwtVBqbN4UdLSTXpRwUshZuIFLQLlbXeaHt2o=
Received: from localhost.localdomain (bb219-74-10-34.singnet.com.sg. [219.74.10.34])
        by smtp.gmail.com with ESMTPSA id v11-20020a056a00148b00b006ddc2cf3662sm10073450pfu.184.2024.01.31.07.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 07:56:18 -0800 (PST)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	Leon Hwang <hffilwlqm@gmail.com>
Subject: [RFC PATCH bpf-next 1/2] bpf: Add generic kfunc bpf_ffs64()
Date: Wed, 31 Jan 2024 23:56:06 +0800
Message-ID: <20240131155607.51157-2-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240131155607.51157-1-hffilwlqm@gmail.com>
References: <20240131155607.51157-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On XDP-based virtual network gateway, ffs (aka find first set) algorithm
is used to find the index of the very first 1-value bit in a bitmap,
which is an array of u64, in the gateway's ACL module.

The ACL module was designed from these two papers:

* "eBPF / XDP based firewall and packet filtering"[1]
* "Securing Linux with a Faster and Scalable Iptables"[2]

In the ACL module, the key details are:

1. Match source address to get a bitmap.
2. Match destination address to get a bitmap.
3. Match l4 protocol to get a bitmap.
4. Match source port to get a bitmap.
5. Match destination port to get a bitmap.

Finally, by traversing these 5 bitmaps and doing bitwise-and on 5 u64s
meanwhile, for every bitwise-and result, an u64, if it's not zero, do
ffs to find the index of the very first 1-value bit in the result. When
the index is found, convert it to a rule index of a rule policy bpf map,
whose type is BPF_MAP_TYPE_ARRAY or BPF_MAP_TYPE_PERCPU_ARRAY.

If __ffs64() kernel function can be reused in bpf, it can save some time in
finding the index of the very first 1-value bit in an u64.

Like AVX2, __ffs64() will be compiled to one instruction, "rep bsf", on
x86.

Then, I do compare bpf-implemented __ffs64() with this kfunc bpf_ffs64()
with following bpf code snippet:

#include "vmlinux.h"

#include "bpf/bpf_helpers.h"

unsigned long bpf_ffs64(u64 word) __ksym;

static __noinline __u64
__ffs64(__u64 word)
{
	__u64 shift = 0;
	if ((word & 0xffffffff) == 0) {
		word >>= 32;
		shift += 32;
	}
	if ((word & 0xffff) == 0) {
		word >>= 16;
		shift += 16;
	}
	if ((word & 0xff) == 0) {
		word >>= 8;
		shift += 8;
	}
	if ((word & 0xf) == 0) {
		word >>= 4;
		shift += 4;
	}
	if ((word & 0x3) == 0) {
		word >>= 2;
		shift += 2;
	}
	if ((word & 0x1) == 0) {
		shift += 1;
	}

	return shift;
}

SEC("tc")
int tc_ffs1(struct __sk_buff *skb)
{
	void *data_end = (void *)(long) skb->data_end;
	u64 *data = (u64 *)(long) skb->data;

	if ((void *)(u64) (data + 1) > data_end)
		return 0;

	return __ffs64(*data);
}

SEC("tc")
int tc_ffs2(struct __sk_buff *skb)
{
	void *data_end = (void *)(long) skb->data_end;
	u64 *data = (u64 *)(long) skb->data;

	if ((void *)(u64) (data + 1) > data_end)
		return 0;

	return bpf_ffs64(*data);
}

char _license[] SEC("license") = "GPL";

Then, I run them on a KVM-based VM, which runs on a 48 cores and "Intel(R)
Xeon(R) Silver 4116 CPU @ 2.10GHz" CPU server.

As for the 1-value bit offset is 0, and for every time the bpf progs run
for 10000000 times, the average time cost data of bpf progs running is:

+----------+---------------+-------------------+
| Nth time | bpf __ffs64() | kfunc bpf_ffs64() |
+----------+---------------+-------------------+
|        1 | 164ns         | 154ns             |
|        2 | 166ns         | 155ns             |
|        3 | 160ns         | 154ns             |
|        4 | 161ns         | 157ns             |
|        5 | 161ns         | 155ns             |
|        6 | 163ns         | 155ns             |
|        7 | 164ns         | 155ns             |
|        8 | 159ns         | 159ns             |
|        9 | 171ns         | 154ns             |
|       10 | 164ns         | 156ns             |
|       11 | 161ns         | 155ns             |
|       12 | 160ns         | 155ns             |
|       13 | 161ns         | 154ns             |
|       14 | 165ns         | 154ns             |
|       15 | 161ns         | 162ns             |
|       16 | 161ns         | 157ns             |
|       17 | 164ns         | 154ns             |
|       18 | 162ns         | 154ns             |
|       19 | 159ns         | 156ns             |
|       20 | 160ns         | 154ns             |
+----------+---------------+-------------------+

As for the 1-value bit offset is 63, and for every time the bpf progs run
for 10000000 times, the average time cost data of bpf progs running is:

+----------+---------------+-------------------+
| Nth time | bpf __ffs64() | kfunc bpf_ffs64() |
+----------+---------------+-------------------+
|        1 | 163ns         | 157ns             |
|        2 | 163ns         | 154ns             |
|        3 | 165ns         | 155ns             |
|        4 | 167ns         | 155ns             |
|        5 | 165ns         | 155ns             |
|        6 | 163ns         | 155ns             |
|        7 | 162ns         | 155ns             |
|        8 | 162ns         | 156ns             |
|        9 | 174ns         | 155ns             |
|       10 | 162ns         | 156ns             |
|       11 | 168ns         | 155ns             |
|       12 | 169ns         | 156ns             |
|       13 | 162ns         | 155ns             |
|       14 | 169ns         | 155ns             |
|       15 | 162ns         | 154ns             |
|       16 | 163ns         | 155ns             |
|       17 | 162ns         | 154ns             |
|       18 | 166ns         | 154ns             |
|       19 | 165ns         | 154ns             |
|       20 | 165ns         | 154ns             |
+----------+---------------+-------------------+

As we can see, for every time, bpf __ffs64() costs around 165ns, and
kfunc bpf_ffs64() costs around 155ns. It seems that kfunc bpf_ffs64()
saves 10ns for every time.

If there is 1m PPS on the gateway, kfunc bpf_ffs64() will save much CPU
resource.

Links:

[1] http://vger.kernel.org/lpc_net2018_talks/ebpf-firewall-paper-LPC.pdf
[2] https://mbertrone.github.io/documents/21-Securing_Linux_with_a_Faster_and_Scalable_Iptables.pdf

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 kernel/bpf/helpers.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bcb951a2ecf4b..4db48a6a04a90 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -23,6 +23,7 @@
 #include <linux/btf_ids.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/kasan.h>
+#include <linux/bitops.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -2542,6 +2543,11 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
 
+__bpf_kfunc unsigned long bpf_ffs64(u64 word)
+{
+	return __ffs64(word);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_SET8_START(generic_btf_ids)
@@ -2573,6 +2579,7 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
+BTF_ID_FLAGS(func, bpf_ffs64)
 BTF_SET8_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
-- 
2.42.1


