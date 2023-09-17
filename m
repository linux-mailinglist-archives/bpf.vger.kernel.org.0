Return-Path: <bpf+bounces-10212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90187A3369
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 02:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF272818BE
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 00:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2D417FE;
	Sun, 17 Sep 2023 00:01:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6144F7E6
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 00:01:13 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865D4CCE;
	Sat, 16 Sep 2023 17:01:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31c6d17aec4so3089214f8f.1;
        Sat, 16 Sep 2023 17:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694908866; x=1695513666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6BHq/Fmhrzie/rbN5xOf6Z3yTY+jNo9/MvYXQ7WEtc=;
        b=Cwbt8Ii1B6My/QaDYtZdjkmPLRoBEIaXJt6Yj+tL5yGJwNMWjVuVagvfPBTziemC5Y
         2Zs8fWtag4jmfEcCSeNzoHdlhhI8fFBNReWrr6PTPxKnFnM6kGbGvE8MKs0qH2HqvLpN
         jDQz4RvLi3azh1zetJd6aFDM+7Gm1ibRv3PyodGmXj6EUVWV6avUdYQBm40Ej5Vam7jW
         3+dBBRYQWr03b5JfiMkmX70xNbS8HSkRyb4loZI82NsuqVvuOxR2ZUzSbozCfgKrn0+L
         bv/sYUvZjSWvUlFF7KPp7K054nYwcOCepU2HqbaaSbiuAyDsojd4ZJDijz1R912ho5vs
         UUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694908866; x=1695513666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6BHq/Fmhrzie/rbN5xOf6Z3yTY+jNo9/MvYXQ7WEtc=;
        b=f9Wv9zJZPgdAa4mtg9Zetjd1OSNnD+3lJnvr8ksWBhU8f0w80W29BoZQkfpPjs0eRm
         sJKhx9SPQrBMLDTlaJbywzFb96eEc1PbNwMcc4Gnu8qu5NW9qDCgo8PPuzhLULb8dQWy
         tuvFBMjfyQl+dDY5hu6LaxmRHkVWzAvoaZlYEcVNriyZaZ4xLH05PicSaj1S6CGwq+Rp
         IitBxSwTfGis8ARPSVJE8CEu0d+2yO34F5y/0jLTdKu4rHR9w7Bdr31IxiuloooTxC5B
         9OzNF4yDvdw+maLLZXK8RohBfCGrv4mslCRcjlVrVRTKXxSsCPrRF+vBT0QSp7vYptpT
         f6dQ==
X-Gm-Message-State: AOJu0Ywyq5KM0LfSPDZuOoBqYEX0u797GcX72ZCKMcBe3fPmzxXf6ob1
	R24oqxluZBUOZko2xphLs1gW4JnilRhslzNF
X-Google-Smtp-Source: AGHT+IEI5tvI6LA0kydBMw3x7dPxE77l9+GYimpXpFuZcf52LqIbmhWgOv8IALYTwDulMXDu1cH4ow==
X-Received: by 2002:adf:fb90:0:b0:317:e5dc:5cd0 with SMTP id a16-20020adffb90000000b00317e5dc5cd0mr4435414wrr.21.1694908865566;
        Sat, 16 Sep 2023 17:01:05 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id z8-20020a056000110800b0031f3ad17b2csm8290467wrw.52.2023.09.16.17.01.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Sep 2023 17:01:05 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 0/1] bpf, arm64: Support Exceptions
Date: Sun, 17 Sep 2023 00:00:44 +0000
Message-Id: <20230917000045.56377-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Changes in V1->V2:
V1: https://lore.kernel.org/all/20230912233942.6734-1-puranjay12@gmail.com/
- Remove exceptions from DENYLIST.aarch64 as they are supported now.

The base support for exceptions was merged with [1] and it was enabled for
x86-64.

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

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?h=for-next&id=ec6f1b4db95b7eedb3fe85f4f14e08fa0e9281c3

Puranjay Mohan (1):
  bpf, arm64: support exceptions

 arch/arm64/net/bpf_jit_comp.c                | 98 ++++++++++++++++----
 tools/testing/selftests/bpf/DENYLIST.aarch64 |  1 -
 2 files changed, 79 insertions(+), 20 deletions(-)

-- 
2.40.1


