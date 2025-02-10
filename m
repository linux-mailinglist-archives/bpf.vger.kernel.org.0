Return-Path: <bpf+bounces-50928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3CCA2E545
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 08:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8233A59BB
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 07:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E7E1AF4EA;
	Mon, 10 Feb 2025 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bOJKXR3j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EF11ADC8C
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739172165; cv=none; b=bv3vR7tJ5hdinpSMh8ltA7VQFW9857d9WCgg6VGyqOLfOE92Aogc6n9sOSB5AkTXVY5vBqYa1V69I1Qpf0X1C9gAjOoCcHe7ABK4alKFsPxI6mrTAe5/QBKjZEBifuHyC7nB/vkWAtiACXjYiqaL7Nob1gUkGNtbVvkFe/S8bTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739172165; c=relaxed/simple;
	bh=gF2eMyTOLb6cKzMVtZrMlI7thdNCfssIfqf+cnBW0jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aoyax3zWo6F/5WFkyOup0QNRLcIEYOGPcD4LeufAkuhOXaPT2TSqAPKhFyT0k+vKZ8rrg9Du5a6tqr831qDmcfzwLzC8r/chlk/qxOtflUoY7weNTKn396PvL5n636XW62GkRl1GOhU8JpfVQGkARV10qnyTMSe5Ojpk+M04rgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bOJKXR3j; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b6f95d2eafso464435185a.3
        for <bpf@vger.kernel.org>; Sun, 09 Feb 2025 23:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1739172159; x=1739776959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lp4WDTh7aU0LAokfvQ9vfZPrliNLs/vu/ZlOg7/rnDw=;
        b=bOJKXR3j2vL8/FGGG+wL/XeQybDbcPO1FdY3MPeG5uli/mZ4nMg7/qpZpEG+2ldH4G
         rjAWNxXB7BGNzwNytiqz9CtkrJL4eY/cnKUUH7/QsTb5ChAeIIhM7frPOeN3D27l6j7N
         a3/EjoqbzeyTR4UustFwgK5/ukHykK3xMBYAyMltogM6uA9DcZsVi6sisRt0ymKRth0W
         PY6M25NOArxAqrwpkoUkLEg131QUYWjPXbbiR3Hphr5AhuNI886+5DmOy9YuLW21tnwg
         NGgtVMSjNnYe8d+hAjQCNIzmTSmCO4FOYKS+F1BuDkmDBE+UImDlCqk4KSmMvgbaRl4L
         8iyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739172159; x=1739776959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lp4WDTh7aU0LAokfvQ9vfZPrliNLs/vu/ZlOg7/rnDw=;
        b=pkOHTE0TWb8txkSAHYIK6t5uMzyZfSQ7UdDG+VrNti9c2Uh5zoMkQwnAsU8QSEMi02
         l9fOf0TW+1mILANA5SyY1KQdBIWZOw7c/Amal5X0g9PN98vFWt8kdmq7dgVRIgz91YED
         na/751tyoAD+BXdInsz6aKZPzwuSeYrH+cLG9SX3YslZp6i2lf6+d1sH8xkDpwbOdlbS
         DVni4ZDbm81VhwCDoIwAwVPjuJynnK4dSqx92dOInBpDKnWgKwIQNWIM2E+F6CgJ6bZs
         PkbM4DrMdE/0+x5GJSbnnD/zJ9sOld/sUlIgqaFbcf/W5rUBBM+Vy/1RDT7j7p0/jKlU
         Iiig==
X-Gm-Message-State: AOJu0YwNs/y+8kVPG3io3ltejRN5/Y8fHjJxa6ptoiQ7oXLxykvvHKyK
	H83hHfmmTmmLDLrRk8ui/1zUUhoBkL9fxKvndAeb5zyBoiWbVH0GKgy9g964opsO8ztyjgJRli5
	x
X-Gm-Gg: ASbGncuNaSu6IcL1TgI/WjikLLJksrlXk943tX8RoDPINkC/UJt5r8wbGjv8KpUyAvH
	yIR0WWfDvKtprPhl8J0x4gyKSUzhQOUI/MrzNtsnxmHOSl9tXgyfpFlysROxUqpqw+kwPf79WbS
	n5FQcSncvE4akjdwkpZJyYYjWQUCCNHx9sLESfXll4uu/FG3H9hzPIPfjifAKCdfQWTgiKdPkbx
	e4dbgw0T4ghGzpu6mN9tDdYmXMX9IzRMIrQ8bhxLp+FPkQOM30X5/japQq4bLW7zj2CGpaYjE8o
	wJQn
X-Google-Smtp-Source: AGHT+IEjBZhZuALA3RKeEOhkSOGO8BcLbjZzT8lCDmkLwUBg4Uo9I4Bz4Xpb76/AtD+EXiCFw9kxDA==
X-Received: by 2002:a05:620a:2612:b0:7c0:61d2:4ec4 with SMTP id af79cd13be357-7c061d25019mr141452385a.57.1739172159380;
        Sun, 09 Feb 2025 23:22:39 -0800 (PST)
Received: from debian.debian ([2a09:bac5:79dd:f9b::18e:183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4719729977csm5587051cf.18.2025.02.09.23.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 23:22:38 -0800 (PST)
Date: Sun, 9 Feb 2025 23:22:35 -0800
From: Yan Zhai <yan@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Yan Zhai <yan@cloudflare.com>, Brian Vazquez <brianvv@google.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com, Hou Tao <houtao@huaweicloud.com>
Subject: [PATCH v3 bpf 1/2] bpf: skip non exist keys in
 generic_map_lookup_batch
Message-ID: <85618439eea75930630685c467ccefeac0942e2b.1739171594.git.yan@cloudflare.com>
References: <cover.1739171594.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1739171594.git.yan@cloudflare.com>

The generic_map_lookup_batch currently returns EINTR if it fails with
ENOENT and retries several times on bpf_map_copy_value. The next batch
would start from the same location, presuming it's a transient issue.
This is incorrect if a map can actually have "holes", i.e.
"get_next_key" can return a key that does not point to a valid value. At
least the array of maps type may contain such holes legitly. Right now
these holes show up, generic batch lookup cannot proceed any more. It
will always fail with EINTR errors.

Rather, do not retry in generic_map_lookup_batch. If it finds a non
existing element, skip to the next key. This simple solution comes with
a price that transient errors may not be recovered, and the iteration
might cycle back to the first key under parallel deletion. For example,
Hou Tao <houtao@huaweicloud.com> pointed out a following scenario:

For LPM trie map:
(1) ->map_get_next_key(map, prev_key, key) returns a valid key

(2) bpf_map_copy_value() return -ENOMENT
It means the key must be deleted concurrently.

(3) goto next_key
It swaps the prev_key and key

(4) ->map_get_next_key(map, prev_key, key) again
prev_key points to a non-existing key, for LPM trie it will treat just
like prev_key=NULL case, the returned key will be duplicated.

With the retry logic, the iteration can continue to the key next to the
deleted one. But if we directly skip to the next key, the iteration loop
would restart from the first key for the lpm_trie type.

However, not all races may be recovered. For example, if current key is
deleted after instead of before bpf_map_copy_value, or if the prev_key
also gets deleted, then the loop will still restart from the first key
for lpm_tire anyway. For generic lookup it might be better to stay
simple, i.e. just skip to the next key. To guarantee that the output
keys are not duplicated, it is better to implement map type specific
batch operations, which can properly lock the trie and synchronize with
concurrent mutators.

Fixes: cb4d03ab499d ("bpf: Add generic support for lookup batch op")
Closes: https://lore.kernel.org/bpf/Z6JXtA1M5jAZx8xD@debian.debian/
Signed-off-by: Yan Zhai <yan@cloudflare.com>
Acked-by: Hou Tao <houtao1@huawei.com>
---
v2->v3: deleted a used macro
v1->v2: incorporate more useful information inside commit message.
---
 kernel/bpf/syscall.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c420edbfb7c8..e5f1c7fd0ba7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1968,8 +1968,6 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 	return err;
 }
 
-#define MAP_LOOKUP_RETRIES 3
-
 int generic_map_lookup_batch(struct bpf_map *map,
 				    const union bpf_attr *attr,
 				    union bpf_attr __user *uattr)
@@ -1979,8 +1977,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	void __user *values = u64_to_user_ptr(attr->batch.values);
 	void __user *keys = u64_to_user_ptr(attr->batch.keys);
 	void *buf, *buf_prevkey, *prev_key, *key, *value;
-	int err, retry = MAP_LOOKUP_RETRIES;
 	u32 value_size, cp, max_count;
+	int err;
 
 	if (attr->batch.elem_flags & ~BPF_F_LOCK)
 		return -EINVAL;
@@ -2026,14 +2024,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
 		err = bpf_map_copy_value(map, key, value,
 					 attr->batch.elem_flags);
 
-		if (err == -ENOENT) {
-			if (retry) {
-				retry--;
-				continue;
-			}
-			err = -EINTR;
-			break;
-		}
+		if (err == -ENOENT)
+			goto next_key;
 
 		if (err)
 			goto free_buf;
@@ -2048,12 +2040,12 @@ int generic_map_lookup_batch(struct bpf_map *map,
 			goto free_buf;
 		}
 
+		cp++;
+next_key:
 		if (!prev_key)
 			prev_key = buf_prevkey;
 
 		swap(prev_key, key);
-		retry = MAP_LOOKUP_RETRIES;
-		cp++;
 		cond_resched();
 	}
 
-- 
2.39.5



