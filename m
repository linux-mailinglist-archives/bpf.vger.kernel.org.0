Return-Path: <bpf+bounces-20950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE58845828
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 13:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAEF01C24647
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 12:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90588665D;
	Thu,  1 Feb 2024 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIc4lvV/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680E8664B;
	Thu,  1 Feb 2024 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791969; cv=none; b=qGvdHXav8YrzHZiquFGD5Fn5EA94WXvVU6zlyTqkRnvF7Fha35dwNwe2uwiipTbV4Fd4OhcJNx5CUwzmV4ar15tcHHLnjfekQuvcbFo7qTKeYgN4JC8/U2gjTAJA6+5xNqDpiTCTYYtsT2mH6+FcVQFdsNPMSc7KS4/kSRAsOGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791969; c=relaxed/simple;
	bh=wfj36ey8sb/eXl8co4e6lFD1IK/5ORjdpgevXbQcobY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vAVjI3lYpkVtj9aRFUoosYe3yk5RFjtyx9EXyNMO234qs3CaRZxDV5Z8rtO1ec7vgUolXiykuN2Wl1vKBtASKKgupAj62nhJlwLM/mem7BwysYH9aZlx/aSt/VTrmDArsfYNrzhpLNB9DX1DneqSGADu5cIAOo8OHfhrF072GoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIc4lvV/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40eac352733so8044545e9.0;
        Thu, 01 Feb 2024 04:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706791965; x=1707396765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jUeXDXBjzlWBB7hV8iOt1EuTewFUf9S8O5h3LKIL2UI=;
        b=BIc4lvV/CGqKcmx6Y2hQDB3QkqHdvI0oTJcNLptMU70AQqhM9axIH0J1cYVBZnt007
         xDbSOWnpylR5J8Aef2t9MTp3m2b5PJOL2TEHLe4o6RLgoyg9xYNoBr7IkorHqW/jiCpH
         n4eg08fAEIiPv3kv9xgyHXh5xP5QJHUnLYyf0sqUahuaje+3rsUOPXTUqu5/C3O0OhHA
         piRVhQMwYBM0Zux490F372ile7YrjU1ObNKASxGOpp5Zcy0SGqx7fDUIiFFBSh1ri7T+
         iQo0MoAPEoxVnsBreWrOAFnZGFopNv9JWY6Q5WcedhEpqzn6XM1bSweB8JU5Kq5vJ/dj
         kHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706791965; x=1707396765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUeXDXBjzlWBB7hV8iOt1EuTewFUf9S8O5h3LKIL2UI=;
        b=cxVzhuMwjaMR3/mR2oCu/KNHu2FHsvlV4UxH2+gydYnk9qNGk4Mz7MAcbDvsvG1DO9
         cOXDK7xfIm4DCqpQxI5Xotd/IUNMklwUXcNq4ZxkAqR41Q8zNYOWaw4zG4X00ANyGG5C
         uYGCzBOhJ4003MPRlOcS+tisCvXI6drmODElEntQCAvJelir/3WrFyZLeduv11yVdEBK
         TS7rJIdlMIaY4EqZOO5oPVJoqmfNC6KkIPnJxbnJbJNCm5LwyIXFWka2flx/o0Y/tvFV
         p2gVVLucaBqdxNY1ISDM08rmZ2AGd9jQYyk4WPI8jKAhORuQLJpZsElle3jw9RtBXvC7
         U8Sw==
X-Gm-Message-State: AOJu0YzCNVAoX4FH3jzJ6OJAWuCGgm9Mn/rAhbhEIIUV0/qsPLoniZUX
	i3+ufG7IQxjC0z/Pl/mE1qwcwokTSLwKngCGfKARRqneC3kis9u0KDC9vNyC05k8L5mJ
X-Google-Smtp-Source: AGHT+IHDUedmH9atBsvi7Stca0/oxZ//g6mYBacWx5k46nhJj2xZmzoiYzWIK3trfs87XFhNdxKgKQ==
X-Received: by 2002:a05:600c:4288:b0:40e:fbc8:401 with SMTP id v8-20020a05600c428800b0040efbc80401mr4102711wmc.20.1706791965328;
        Thu, 01 Feb 2024 04:52:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUDZSe3Y4z5SrksehFmwG5d/+bjBID1+Qy/LLH01OlCH9WZsCRrU2BOZpUrFEOvO124VLwqbVK6xDPnygMPKyldbUBUT4A+6+uNCIZFCWGWMX5atHPrwMV+5b27Yf+DI7Ar1PXkVIlUM05RTPZ7clOHvf3sxoy54zJFBpakbEyM07pcT4tdBiq9FnH2FtpYgKfZYf8cXsYqzDYzZ591m9uJfx1qm3HzLtaZ3llN0vD43ov0nTmsz4NjVPHhEMy0dAv3nJT0jSE0tHPWM3cgYKXFqV6YY108D1INoxDRU9h0EBFAJx9hZIvPM3+6qNOPbUdOaDw93qN/xv1O4kHEDyRdw5KoyvQgC6UQ4Yg+4ZjvukRnBA+UPYh8ApiTQSoAFYhXkTsOOR6UtixgRzreP7dNEAYHoAHN8Np4TuL05OxLe9ADAjoiPk7GNDmzxtYDZ8WmnSy9UNigarNtsNllQIuomSbEsUxQ12nUgGGZi/S8Rln6J0Vm6g7n5+FrA2Wuk0Cp+MJEwAinPjaZJnGlghu1m8b7DiUxHdcNDC4BdBUlNAMKfg==
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600c4f0d00b0040efbdd2376sm4382539wmq.41.2024.02.01.04.52.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Feb 2024 04:52:44 -0800 (PST)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v3 0/2] bpf, arm64: Support Exceptions
Date: Thu,  1 Feb 2024 12:52:23 +0000
Message-Id: <20240201125225.72796-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in V2->V3:
V2: https://lore.kernel.org/all/20230917000045.56377-1-puranjay12@gmail.com/
- Use unwinder from stacktrace.c rather than open coding the unwind logic.
- Fix a bug in the prologue related to BPF_FP (Xu Kuohai)

Changes in V1->V2:
V1: https://lore.kernel.org/all/20230912233942.6734-1-puranjay12@gmail.com/
- Remove exceptions from DENYLIST.aarch64 as they are supported now.

The base support for exceptions was merged with [1] and it was enabled for
x86-64.

This patch set enables the support on ARM64, all sefltests are passing:

# ./test_progs -a exceptions
#74/1    exceptions/exception_throw_always_1:OK
#74/2    exceptions/exception_throw_always_2:OK
#74/3    exceptions/exception_throw_unwind_1:OK
#74/4    exceptions/exception_throw_unwind_2:OK
#74/5    exceptions/exception_throw_default:OK
#74/6    exceptions/exception_throw_default_value:OK
#74/7    exceptions/exception_tail_call:OK
#74/8    exceptions/exception_ext:OK
#74/9    exceptions/exception_ext_mod_cb_runtime:OK
#74/10   exceptions/exception_throw_subprog:OK
#74/11   exceptions/exception_assert_nz_gfunc:OK
#74/12   exceptions/exception_assert_zero_gfunc:OK
#74/13   exceptions/exception_assert_neg_gfunc:OK
#74/14   exceptions/exception_assert_pos_gfunc:OK
#74/15   exceptions/exception_assert_negeq_gfunc:OK
#74/16   exceptions/exception_assert_poseq_gfunc:OK
#74/17   exceptions/exception_assert_nz_gfunc_with:OK
#74/18   exceptions/exception_assert_zero_gfunc_with:OK
#74/19   exceptions/exception_assert_neg_gfunc_with:OK
#74/20   exceptions/exception_assert_pos_gfunc_with:OK
#74/21   exceptions/exception_assert_negeq_gfunc_with:OK
#74/22   exceptions/exception_assert_poseq_gfunc_with:OK
#74/23   exceptions/exception_bad_assert_nz_gfunc:OK
#74/24   exceptions/exception_bad_assert_zero_gfunc:OK
#74/25   exceptions/exception_bad_assert_neg_gfunc:OK
#74/26   exceptions/exception_bad_assert_pos_gfunc:OK
#74/27   exceptions/exception_bad_assert_negeq_gfunc:OK
#74/28   exceptions/exception_bad_assert_poseq_gfunc:OK
#74/29   exceptions/exception_bad_assert_nz_gfunc_with:OK
#74/30   exceptions/exception_bad_assert_zero_gfunc_with:OK
#74/31   exceptions/exception_bad_assert_neg_gfunc_with:OK
#74/32   exceptions/exception_bad_assert_pos_gfunc_with:OK
#74/33   exceptions/exception_bad_assert_negeq_gfunc_with:OK
#74/34   exceptions/exception_bad_assert_poseq_gfunc_with:OK
#74/35   exceptions/exception_assert_range:OK
#74/36   exceptions/exception_assert_range_with:OK
#74/37   exceptions/exception_bad_assert_range:OK
#74/38   exceptions/exception_bad_assert_range_with:OK
#74/39   exceptions/non-throwing fentry -> exception_cb:OK
#74/40   exceptions/throwing fentry -> exception_cb:OK
#74/41   exceptions/non-throwing fexit -> exception_cb:OK
#74/42   exceptions/throwing fexit -> exception_cb:OK
#74/43   exceptions/throwing extension (with custom cb) -> exception_cb:OK
#74/44   exceptions/throwing extension -> global func in exception_cb:OK
#74/45   exceptions/exception_ext_mod_cb_runtime:OK
#74/46   exceptions/throwing extension (with custom cb) -> global func in exception_cb:OK
#74/47   exceptions/exception_ext:OK
#74/48   exceptions/non-throwing fentry -> non-throwing subprog:OK
#74/49   exceptions/throwing fentry -> non-throwing subprog:OK
#74/50   exceptions/non-throwing fentry -> throwing subprog:OK
#74/51   exceptions/throwing fentry -> throwing subprog:OK
#74/52   exceptions/non-throwing fexit -> non-throwing subprog:OK
#74/53   exceptions/throwing fexit -> non-throwing subprog:OK
#74/54   exceptions/non-throwing fexit -> throwing subprog:OK
#74/55   exceptions/throwing fexit -> throwing subprog:OK
#74/56   exceptions/non-throwing fmod_ret -> non-throwing subprog:OK
#74/57   exceptions/non-throwing fmod_ret -> non-throwing global subprog:OK
#74/58   exceptions/non-throwing extension -> non-throwing subprog:OK
#74/59   exceptions/non-throwing extension -> throwing subprog:OK
#74/60   exceptions/non-throwing extension -> non-throwing subprog:OK
#74/61   exceptions/non-throwing extension -> throwing global subprog:OK
#74/62   exceptions/throwing extension -> throwing global subprog:OK
#74/63   exceptions/throwing extension -> non-throwing global subprog:OK
#74/64   exceptions/non-throwing extension -> main subprog:OK
#74/65   exceptions/throwing extension -> main subprog:OK
#74/66   exceptions/reject_exception_cb_type_1:OK
#74/67   exceptions/reject_exception_cb_type_2:OK
#74/68   exceptions/reject_exception_cb_type_3:OK
#74/69   exceptions/reject_exception_cb_type_4:OK
#74/70   exceptions/reject_async_callback_throw:OK
#74/71   exceptions/reject_with_lock:OK
#74/72   exceptions/reject_subprog_with_lock:OK
#74/73   exceptions/reject_with_rcu_read_lock:OK
#74/74   exceptions/reject_subprog_with_rcu_read_lock:OK
#74/75   exceptions/reject_with_rbtree_add_throw:OK
#74/76   exceptions/reject_with_reference:OK
#74/77   exceptions/reject_with_cb_reference:OK
#74/78   exceptions/reject_with_cb:OK
#74/79   exceptions/reject_with_subprog_reference:OK
#74/80   exceptions/reject_throwing_exception_cb:OK
#74/81   exceptions/reject_exception_cb_call_global_func:OK
#74/82   exceptions/reject_exception_cb_call_static_func:OK
#74/83   exceptions/reject_multiple_exception_cb:OK
#74/84   exceptions/reject_exception_throw_cb:OK
#74/85   exceptions/reject_exception_throw_cb_diff:OK
#74/86   exceptions/reject_set_exception_cb_bad_ret1:OK
#74/87   exceptions/reject_set_exception_cb_bad_ret2:OK
#74/88   exceptions/check_assert_eq_int_min:OK
#74/89   exceptions/check_assert_eq_int_max:OK
#74/90   exceptions/check_assert_eq_zero:OK
#74/91   exceptions/check_assert_eq_llong_min:OK
#74/92   exceptions/check_assert_eq_llong_max:OK
#74/93   exceptions/check_assert_lt_pos:OK
#74/94   exceptions/check_assert_lt_zero:OK
#74/95   exceptions/check_assert_lt_neg:OK
#74/96   exceptions/check_assert_le_pos:OK
#74/97   exceptions/check_assert_le_zero:OK
#74/98   exceptions/check_assert_le_neg:OK
#74/99   exceptions/check_assert_gt_pos:OK
#74/100  exceptions/check_assert_gt_zero:OK
#74/101  exceptions/check_assert_gt_neg:OK
#74/102  exceptions/check_assert_ge_pos:OK
#74/103  exceptions/check_assert_ge_zero:OK
#74/104  exceptions/check_assert_ge_neg:OK
#74/105  exceptions/check_assert_range_s64:OK
#74/106  exceptions/check_assert_range_u64:OK
#74/107  exceptions/check_assert_single_range_s64:OK
#74/108  exceptions/check_assert_single_range_u64:OK
#74/109  exceptions/check_assert_generic:OK
#74/110  exceptions/check_assert_with_return:OK
#74      exceptions:OK
Summary: 1/110 PASSED, 0 SKIPPED, 0 FAILED

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?h=for-next&id=ec6f1b4db95b7eedb3fe85f4f14e08fa0e9281c3

Puranjay Mohan (2):
  arm64: stacktrace: Implement arch_bpf_stack_walk() for the BPF JIT
  bpf, arm64: support exceptions

 arch/arm64/kernel/stacktrace.c               | 26 ++++++
 arch/arm64/net/bpf_jit_comp.c                | 87 +++++++++++++++-----
 tools/testing/selftests/bpf/DENYLIST.aarch64 |  1 -
 3 files changed, 94 insertions(+), 20 deletions(-)

-- 
2.40.1


