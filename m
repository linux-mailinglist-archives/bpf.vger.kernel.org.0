Return-Path: <bpf+bounces-9843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B39B079DCC9
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2CF11C209CE
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4D413ACD;
	Tue, 12 Sep 2023 23:39:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B31171C
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:39:46 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C9D10C7;
	Tue, 12 Sep 2023 16:39:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so72674915e9.3;
        Tue, 12 Sep 2023 16:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694561984; x=1695166784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qXC78UUF3ibqz3zuiL6JsDX7Oj430gQiRowMpFwstOk=;
        b=i7AsW7K3SR+tcxUHyvGF0JANrnwAEuWRJaOU9tQd4sZgZwv8+knMx4LkFXgGNcb7SC
         c2GnDofodmIBLg0uq2d7RK5xw3zqyyu11qJobQqwdPUZ0PyA6sLWG6EvB7WEsY8dMCIu
         8z1/Rwu6fUIebjB8f0dH45TEAEu8wenvugBLD8mneBAtzIyLkx3IluERZZapHJQmcNpV
         WcX0YgxYFdepwdsSA2pecWM0ygJmkQiEH131msIu7aMu2hlkhdaOuk2vNmVOEdAQjfVW
         0zDwz/n/HmY+ZSF6y79/HHK/Qwpskbq0VbiHOtYImB+CzFCREWd9MDS6VelDFZcVh3Je
         F6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561984; x=1695166784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXC78UUF3ibqz3zuiL6JsDX7Oj430gQiRowMpFwstOk=;
        b=FUYVqUwaKHpUDQVmLQnS4vhI/zCezT+GmO6zvzKaur6UJ381Iqk8Hzm+SEN79l5gZm
         3GSDBSn3ZZdwv073r09Hsm3Tph0ArAVm8SkoKiKWlLOZpExy26Uoxpxi9MKOUV0bLflE
         DBTr/QnN0CaPsnkTroaox0+uljruGMOigGqJXD9AjUuU9aJlVrFiAJKxVEQfTHiK0bDO
         /xXGg1H8uJ+dCjVvJ4AAQDtwfQsrbNoc+W1FF7t6yY21JMnd0hHqg5kbubcCTIUtIQom
         0t8JgK7UHuAw9pzVN7a4/SAHJC8gsL6P4iZzriUnDlMaBSgg6vUQZn9mZL58hmP0eHcV
         0lZg==
X-Gm-Message-State: AOJu0YyI56ppB3mNIXS7sYYXL1UAamBhpQtbkne6GRwvzlTCDn9LJj4a
	1JL4ANlCAM7PW6TTYxlNQB8=
X-Google-Smtp-Source: AGHT+IGQXd3yi2Wo/dXj3cZJ+Hfo+j+Dp3F6HRHmHIEOfrMt1pgYFhWIbcWpwhGtcD5eGAaaXLMy1g==
X-Received: by 2002:a05:600c:2318:b0:401:b1c6:97d8 with SMTP id 24-20020a05600c231800b00401b1c697d8mr643840wmo.35.1694561983527;
        Tue, 12 Sep 2023 16:39:43 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-34-242-166-189.eu-west-1.compute.amazonaws.com. [34.242.166.189])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c0b5700b00402fa98abe3sm296641wmr.46.2023.09.12.16.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 16:39:43 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 0/1] bpf, arm64: support exceptions
Date: Tue, 12 Sep 2023 23:39:41 +0000
Message-Id: <20230912233942.6734-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kumar is working on adding exceptions to BPF and enabling it on x86 [1].
I am working with him to enable it on ARM64 and will later do it for
other architectures when the basic exceptions support is upstream.

This patch enables the support on ARM64, all sefltests are passing:

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

[1] https://lore.kernel.org/bpf/20230912233214.1518551-1-memxor@gmail.com/

Puranjay Mohan (1):
  bpf, arm64: support exceptions

 arch/arm64/net/bpf_jit_comp.c | 98 ++++++++++++++++++++++++++++-------
 1 file changed, 79 insertions(+), 19 deletions(-)

-- 
2.40.1


