Return-Path: <bpf+bounces-58718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16593AC073D
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 10:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30A617900B
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 08:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDCB267F76;
	Thu, 22 May 2025 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9YMIm/N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C18F24E4BD;
	Thu, 22 May 2025 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747902989; cv=none; b=cz5aOv9kNxqi/r3nY4cBBUeMcoB0XPVcMhdkcoVE+xJZH2TJVZmko7Hs1DqTTlttb1tGJZQuI8IzX9tBiU/dqqDKEKb4ZkI7gSsZtJ6Y2skRliU8uTYbqby4zK7+4wM7EwzYdLhtZpl8vmWJd5pPifNDijPhTpxoOammeG5hCfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747902989; c=relaxed/simple;
	bh=O8W5PiEObPU4cXlb9gI2xInJCmQdxp9v0whICdW6n3Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1MQTTlVay/BbL5g3CmC3IUgMybYWUHcwvLKkX/R15SeMvAOhaiLiFJX9R5KHRbUFMzp/WV4l0TdupiEBEhoJcj4hBp1rrKG8ON1DSvyce62JDhDWModSUWkdFS4vzC4TyOlznKhi0SHvGvBEnvxTaeWJkL2Ym5Ff1USY8iY8NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9YMIm/N; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30dfd9e7fa8so9227910a91.2;
        Thu, 22 May 2025 01:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747902987; x=1748507787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uCQFFz4KEs/NusF6FyECtfx2xRIE1tKY5qQzp61H/c4=;
        b=m9YMIm/NECwhDbUZLi9W1NAWJffWQ3Y0SjvVDPHRyjMZgv7aHrIsx7lWqaclVeFcqb
         lRh7wtaxR2OYC3/jZWXum1TA7sd90roqPTrClvgWM8ZIuW2Ydee5UbyoJ2Z42MIoNO35
         N/Vh1gV+Cr1FuMhM43bhXDOYByq7S8WslINoEvfG0Enxp2zG5IKv79jqhFkm8IRQjOsf
         tFX6X+lCApnOKlF5XIBlKjZLdqnqulPJAW9PERLT3w2ksnpjyzAckRHlefGo7LNTV9hm
         Fs5kDd0Yfy4ViR9G+V9n49vCyGPJSodC6l8KzvrzwnHqWkDsSWrh6Fy59gGIl7xjPzDE
         H/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747902987; x=1748507787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCQFFz4KEs/NusF6FyECtfx2xRIE1tKY5qQzp61H/c4=;
        b=wMYeuABaxG4gzCMKFyDal606LHcSbWLqbrz6BrXdjNixsh5PBJUmKcGs5Vtq7cBDd0
         aAOI9BPJXHeTR1vXP/RBxHgdfxgc/TJJd3Us4hAQfv9OSoXVSPfekrvz6izDhJE18zWg
         eHIPgTUjTCVsDd6vp69xZsJxV1xO5RriSInZVro29VD2gBkS+jZSK7R1MYLd3Ck2N1Te
         EQ6Rr9mLAGbu8whPgf4CcYWWHg2Gjy1BV9bU98YF8TBISuy/ifthOX5Hm3JZVRMqwc1X
         u58toSjOKeGaSu2yKdbA9THk6YfalzjhKLxfFhC7kPk3NRxBY4xxj3csDckb4z3+5B4f
         fOsw==
X-Forwarded-Encrypted: i=1; AJvYcCUXJ0pufvQKduSOQmJwJ4nrbIDU0+leX6wZYJ0ZF5m4iBZHVm7vCD/bxbqEvmFJ2Mdupph5Dks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0CwId9HQXXAV7aLGDhKP9SyCeZkFyLjQalIyIxxdb2PO7DKDE
	PiN3GyOPCtqQm53R13otbaOzjIg8e5D9sh0qc4TB+Rlo42d/OVqSO1dDnXk/Uw==
X-Gm-Gg: ASbGncsOsOU581GTTA+2BYKcX/Dkcp7AXVqK1K1UbZIcVl8B9hNiMQyfuhynZMpKicl
	YJhyu2n3EJzOaeU77uSzLbq2F3yLWThbxq2lQZ8T7qa8rx0p88njW5/91VYU9elJrt9uTy1ri7f
	pgYSUqgvSfQgWCCPc+B6DHxDWaJNW96GBPb8c5TJwE8E0eOCBuiWls+xTCCfI7zDeXdurTthNrx
	66NNbnhXz+FApi5H3RA9q7WmzO1e8pgiIAQL+ZaSQfAkjp7zH/xjtOcZgeXkAYy2P+nvaIiwRkJ
	It73MK2pGKSKCJyvT+RMiuO5f+58JiD0lDOtb2MINCtRVqr1mn/seL0Q3lCPWM37Fkaesy9gouh
	PCVzJYiEu/hLUwEnLGA==
X-Google-Smtp-Source: AGHT+IHfzIf8v8M9xf9g3tWP6LDgBAsJckdJMOcOqOUxnz/+Wl3GzkvKp3rheTSu/9Z7tbPdgR8GeA==
X-Received: by 2002:a17:90b:3b8f:b0:2ff:6608:78cd with SMTP id 98e67ed59e1d1-30e830fbe31mr38215579a91.9.1747902987150;
        Thu, 22 May 2025 01:36:27 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365b2d8fsm5023582a91.7.2025.05.22.01.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 01:36:26 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Thu, 22 May 2025 01:36:24 -0700
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com, andrii@kernel.org,
	daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v4 1/3] selftests/bpf: Introduce task local data
Message-ID: <aC7iCGNsG7YuF297@kodidev-ubuntu>
References: <20250515211606.2697271-1-ameryhung@gmail.com>
 <20250515211606.2697271-2-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515211606.2697271-2-ameryhung@gmail.com>

Hi Amery,

I'm trying out your series in an arm32 JIT testing env I'm working on.


On Thu, May 15, 2025 at 02:16:00PM -0700, Amery Hung wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> new file mode 100644
> index 000000000000..5f48e408a5e5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> @@ -0,0 +1,220 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __TASK_LOCAL_DATA_BPF_H
> +#define __TASK_LOCAL_DATA_BPF_H
> +
> +/*
> + * Task local data is a library that facilitates sharing per-task data
> + * between user space and bpf programs.
> + *
> + *
> + * PREREQUISITE
> + *
> + * A TLD, an entry of data in task local data, first needs to be created by the
> + * user space. This is done by calling user space API, tld_create_key(), with
> + * the name of the TLD and the size.
> + *
> + *     tld_key_t prio, in_cs;
> + *
> + *     prio = tld_create_key("priority", sizeof(int));
> + *     in_cs = tld_create_key("in_critical_section", sizeof(bool));
> + *
> + * A key associated with the TLD, which has an opaque type tld_key_t, will be
> + * returned. It can be used to get a pointer to the TLD in the user space by
> + * calling tld_get_data().
> + *
> + *
> + * USAGE
> + *
> + * Similar to user space, bpf programs locate a TLD using the same key.
> + * tld_fetch_key() allows bpf programs to retrieve a key created in the user
> + * space by name, which is specified in the second argument of tld_create_key().
> + * tld_fetch_key() additionally will cache the key in a task local storage map,
> + * tld_key_map, to avoid performing costly string comparisons every time when
> + * accessing a TLD. This requires the developer to define the map value type of
> + * tld_key_map, struct tld_keys. It only needs to contain keys used by bpf
> + * programs in the compilation unit.
> + *
> + * struct tld_keys {
> + *     tld_key_t prio;
> + *     tld_key_t in_cs;
> + * };
> + *
> + * Then, for every new task, a bpf program will fetch and cache keys once and
> + * for all. This should be done ideally in a non-critical path (e.g., in
> + * sched_ext_ops::init_task).
> + *
> + *     struct tld_object tld_obj;
> + *
> + *     err = tld_object_init(task, &tld);
> + *     if (err)
> + *         return 0;
> + *
> + *     tld_fetch_key(&tld_obj, "priority", prio);
> + *     tld_fetch_key(&tld_obj, "in_critical_section", in_cs);
> + *
> + * Note that, the first argument of tld_fetch_key() is a pointer to tld_object.
> + * It should be declared as a stack variable and initialized via tld_object_init().
> + *
> + * Finally, just like user space programs, bpf programs can get a pointer to a
> + * TLD by calling tld_get_data(), with cached keys.
> + *
> + *     int *p;
> + *
> + *     p = tld_get_data(&tld_obj, prio, sizeof(int));
> + *     if (p)
> + *         // do something depending on *p
> + */
> +#include <errno.h>
> +#include <bpf/bpf_helpers.h>
> +
> +#define TLD_DATA_SIZE __PAGE_SIZE
> +#define TLD_DATA_CNT 63
> +#define TLD_NAME_LEN 62
> +
> +typedef struct {
> +	__s16 off;
> +} tld_key_t;
> +
> +struct u_tld_data *dummy_data;
> +struct u_tld_metadata *dummy_metadata;

I suspect I've overlooked something, but what are these 2 "dummy" globals
used for? The code builds OK without them, although I do see test errors
as noted below.

I'll also mention the only reason I noticed these is that "bpftool gen
skeleton" automatically maps these to user space, but results in an
ASSERT() failure during build on 32-bit targets due to lack of support,
so dropping them avoids that.


root@qemu-armhf:/usr/libexec/kselftests-bpf# ./test_progs -w 0 -a task_local_data
test_task_local_data_basic:PASS:pthread_mutex_init 0 nsec
libbpf: prog 'task_init': BPF program load failed: -EACCES
libbpf: prog 'task_init': -- BEGIN PROG LOAD LOG --
arg#0 reference type('UNKNOWN ') size cannot be determined: -22
0: R1=ctx() R10=fp0
; task = bpf_get_current_task_btf(); @ test_task_local_data.c:31
0: (85) call bpf_get_current_task_btf#158     ; R0_w=trusted_ptr_task_struct()
1: (bf) r6 = r0                       ; R0_w=trusted_ptr_task_struct() R6_w=trusted_ptr_task_struct()
; tld_obj->data_map = bpf_task_storage_get(&tld_data_map, task, 0, 0); @ task_local_data.bpf.h:135
2: (18) r1 = 0xc25ddc00               ; R1_w=map_ptr(map=tld_data_map,ks=4,vs=16)
4: (bf) r2 = r6                       ; R2_w=trusted_ptr_task_struct() R6_w=trusted_ptr_task_struct()
5: (b7) r3 = 0                        ; R3_w=0
6: (b7) r4 = 0                        ; R4_w=0
7: (85) call bpf_task_storage_get#156         ; R0=map_value_or_null(id=1,map=tld_data_map,ks=4,vs=16)
8: (b4) w7 = 1                        ; R7_w=1
9: (7b) *(u64 *)(r10 -16) = r0        ; R0=map_value_or_null(id=1,map=tld_data_map,ks=4,vs=16) R10=fp0 fp-16_w=map_value_or_null(id=1,map=tld_data_map,ks=4,vs=16)
; if (!tld_obj->data_map) @ task_local_data.bpf.h:136
10: (15) if r0 == 0x0 goto pc+37      ; R0=map_value(map=tld_data_map,ks=4,vs=16)
; tld_obj->key_map = bpf_task_storage_get(&tld_key_map, task, 0, @ task_local_data.bpf.h:139
11: (18) r1 = 0xc3ade000              ; R1_w=map_ptr(map=tld_key_map,ks=4,vs=6)
13: (bf) r2 = r6                      ; R2_w=trusted_ptr_task_struct() R6=trusted_ptr_task_struct()
14: (b7) r3 = 0                       ; R3_w=0
15: (b7) r4 = 1                       ; R4_w=1
16: (85) call bpf_task_storage_get#156        ; R0=map_value_or_null(id=2,map=tld_key_map,ks=4,vs=6)
17: (bf) r6 = r0                      ; R0=map_value_or_null(id=2,map=tld_key_map,ks=4,vs=6) R6_w=map_value_or_null(id=2,map=tld_key_map,ks=4,vs=6)
18: (7b) *(u64 *)(r10 -8) = r6        ; R6_w=map_value_or_null(id=2,map=tld_key_map,ks=4,vs=6) R10=fp0 fp-8_w=map_value_or_null(id=2,map=tld_key_map,ks=4,vs=6)
;  @ task_local_data.bpf.h:0
19: (15) if r6 == 0x0 goto pc+28      ; R6_w=map_value(map=tld_key_map,ks=4,vs=6)
20: (bf) r1 = r10                     ; R1_w=fp0 R10=fp0
;  @ test_task_local_data.c:0
21: (07) r1 += -16                    ; R1_w=fp-16
; if (!tld_fetch_key(&tld_obj, "value1", value1)) @ test_task_local_data.c:36
22: (18) r2 = 0xc2ddddd0              ; R2_w=map_value(map=.rodata.str1.1,ks=4,vs=30)
24: (85) call pc+25
caller:
 R6_w=map_value(map=tld_key_map,ks=4,vs=6) R7=1 R10=fp0 fp-8_w=map_value(map=tld_key_map,ks=4,vs=6) fp-16=map_value(map=tld_data_map,ks=4,vs=16)
callee:
 frame1: R1_w=fp[0]-16 R2_w=map_value(map=.rodata.str1.1,ks=4,vs=30) R10=fp0
50: frame1: R1_w=fp[0]-16 R2_w=map_value(map=.rodata.str1.1,ks=4,vs=30) R10=fp0
; static u16 __tld_fetch_key(struct tld_object *tld_obj, const char *name) @ task_local_data.bpf.h:163
50: (7b) *(u64 *)(r10 -16) = r2       ; frame1: R2_w=map_value(map=.rodata.str1.1,ks=4,vs=30) R10=fp0 fp-16_w=map_value(map=.rodata.str1.1,ks=4,vs=30)
51: (b4) w7 = 0                       ; frame1: R7_w=0
; if (!tld_obj->data_map || !tld_obj->data_map->metadata) @ task_local_data.bpf.h:169
52: (79) r1 = *(u64 *)(r1 +0)         ; frame1: R1=map_value(map=tld_data_map,ks=4,vs=16) fp-16=map_value(map=.rodata.str1.1,ks=4,vs=30)
53: (15) if r1 == 0x0 goto pc+36      ; frame1: R1=map_value(map=tld_data_map,ks=4,vs=16)
54: (79) r6 = *(u64 *)(r1 +8)         ; frame1: R1=map_value(map=tld_data_map,ks=4,vs=16) R6_w=scalar()
55: (15) if r6 == 0x0 goto pc+34      ; frame1: R6_w=scalar(umin=1)
; cnt = tld_obj->data_map->metadata->cnt; @ task_local_data.bpf.h:172
56: (71) r8 = *(u8 *)(r6 +0)
R6 invalid mem access 'scalar'
processed 29 insns (limit 1000000) max_states_per_insn 0 total_states 3 peak_states 3 mark_read 1
-- END PROG LOAD LOG --
libbpf: prog 'task_init': failed to load: -EACCES
libbpf: failed to load object 'test_task_local_data'
libbpf: failed to load BPF skeleton 'test_task_local_data': -EACCES
test_task_local_data_basic:FAIL:skel_open_and_load unexpected error: -13
#409/1   task_local_data/task_local_data_basic:FAIL


I'm unsure if this verifier error is related to the dummy pointers, but
it does seem there's a pointer issue...

Further thoughts or suggestions (from anyone) would be most welcome.

Thanks,
Tony

> +
> +struct tld_metadata {
> +	char name[TLD_NAME_LEN];
> +	__u16 size;
> +};
> +
> +struct u_tld_metadata {
> +	__u8 cnt;
> +	__u8 padding[63];
> +	struct tld_metadata metadata[TLD_DATA_CNT];
> +};
> +
> +struct u_tld_data {
> +	char data[TLD_DATA_SIZE];
> +};
> +
> +struct tld_map_value {
> +	struct u_tld_data __uptr *data;
> +	struct u_tld_metadata __uptr *metadata;
> +};
> +
> +struct tld_object {
> +	struct tld_map_value *data_map;
> +	struct tld_keys *key_map;
> +};
> +

[...]

