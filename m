Return-Path: <bpf+bounces-8285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 943867848B3
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 19:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1EB31C20B5F
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 17:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7191DA36;
	Tue, 22 Aug 2023 17:51:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3761D318
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 17:51:45 +0000 (UTC)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00B110F
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 10:51:44 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-68a3b66f350so2650166b3a.3
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692726703; x=1693331503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gr02cpbwHDY9IvwrPWQAMi2zutWbQSoS7hgnLjJ7bzU=;
        b=FQuuTJ70izsUX8hyU/IZQAP07WGxVazHgZ27+tscKz00oTjUSP/P64VhV5ufiiKxtw
         6G0OeX7Y7iNL4kMiWWbtUdtSFP8TI7evyHvXh97ylkGWFfPC/Gl9zisemZdNSYxlhY//
         lyA7kHr1oVrGfv3iTcPe40ZzZQwebtLSq/5eeGoj2wlEW6S7YihL7q0aoddspycZ+u2D
         SN3xftrXdQGvUwNQwdY5NCGVVbcNDRL0HUR21xtFZ5tHz2JJ1pUUGAMxHZrimgOwPem7
         sKpMPidA16aT8hX9rGFGLdnku3Uug+lGvO2rRF7o3wHiLjY5fpzblJauJsinKNwYGqTP
         EXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692726703; x=1693331503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gr02cpbwHDY9IvwrPWQAMi2zutWbQSoS7hgnLjJ7bzU=;
        b=eVztOE+Qvft7cXGsWFvdnjY5NPgturBn6gqOLKXqbV164bsb69kdA7+8uGVZv0Kp9v
         bB/qVqwHEqrrMkTm0CFYDCNsrE7Ofy+181DpjFfOIdSxTep7/E8qLodbIJbEptgT6LIJ
         WHzql+BIFBw1mBdiU5ECFehfez1QF4Zo8mQh4eE/lTuhIikprCf+NVE9N30bJfHIxmXg
         hI44VQ9XTbQjRJGWVXrYcUj5Bw3UG5/GnXY3pf0RrMIUUvI21Vw1czJONnzvNnNftzh3
         +2d8cwFZGQwYu2da3t4oKoyUSVcEIArAxUATW2ijFOUShG2BQKH8SynvglRDjEij3CE4
         iBiQ==
X-Gm-Message-State: AOJu0YwmIopuR21F910dxt/Da4PeARsaYclX9bj46lNfRxcjfwZfHVgn
	7XUZMLkrGzYcDXUGNvuk868f1QoDLPagivDl
X-Google-Smtp-Source: AGHT+IGhKPNfIc9YuYepypOMaGqK1L1T7qarbyOPs5Hbq1SEODjmc64oYQ8V5mLQgVE9tz/NYczDAg==
X-Received: by 2002:a05:6a00:22d4:b0:686:babd:f5c1 with SMTP id f20-20020a056a0022d400b00686babdf5c1mr13619318pfj.25.1692726703477;
        Tue, 22 Aug 2023 10:51:43 -0700 (PDT)
Received: from localhost ([2405:201:6014:dae3:46af:61ea:5ce:65e2])
        by smtp.gmail.com with ESMTPSA id k3-20020aa790c3000000b00682a61fa525sm8198928pfk.91.2023.08.22.10.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 10:51:42 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next v1 0/2] Fix for check_func_arg_reg_off
Date: Tue, 22 Aug 2023 23:21:38 +0530
Message-ID: <20230822175140.1317749-1-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=552; i=memxor@gmail.com; h=from:subject; bh=Qa85pEH5XvnHegOy/mhd4+HQ5GvHK9orQ1+uuy9/dg0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBk5PV1hewTLd9rlu8NB/tDnQJjVQStkzR7xYnVX RsUY4cwGrKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZOT1dQAKCRBM4MiGSL8R ysjZEACnq5TaNSA3o4mBS3HDu4vWIHgxmB/BGlcaEvp8/rEpmh+eqqEiJ3TLYxdOYuN9r/yjy7g ocdiCI2AFcFvI6N3t0R6rA0Fg3MPflgTyfT/xGlrcKye/Naz6IWJWeVZ9yEQRNc6M5rm+GORIuN vAVgX2Qjqru/BD/S+LIPZ5ttXoPlymUL+hZAvYNXOb59xQUAz9znllrsf2A7XeOMeS2kfqaPxE4 Zexmn5kv1+1r4OonCXnb9dHOwDCQEcziQvMZ3Yu/uztUVv1JtOxOqyDqcXY3wUm9qRhBcSwVbrZ EsfGiwv+/xLwsCAyaTMKJgtgijyP7jI8HzJ5Pl/CzWoS6xLJs41lek2T+3mWl9rtJ6aJOyhbHMu z3KT0B3VZDtP891VnRZPDPXueTLIWB6EUhYSd5Tfz85Q3p0szM+mvgEsRqdKByvsXXSJkyqtppK /7HyddYsp8lJZufEgZGIbJf3SO32Bgf+NamUummIsdtAjLrBQxOqj9DFkYLXTOzfCwL2nA+ME3E GUCxijChvWiJesMDkyjv9yt3oqC5JufLAmF/ZlNiViuQ4s88DgOFOL8gw5cfCi7n/1G4zb7zOXk g3qm5T8natngsbklGabBFv1nuN8S+y7lPODL882bG9WmW7oCpcBnhDo8BoCD2r+ohrbzqUoPrFx BU3hOVah4VWtGJg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove a leftover hunk in check_func_arg_reg_off that incorrectly
bypasses reg->off == 0 requirement for release kfuncs and helpers.

Kumar Kartikeya Dwivedi (2):
  bpf: Fix check_func_arg_reg_off bug for graph root/node
  selftests/bpf: Add test for bpf_obj_drop with bad reg->off

 kernel/bpf/verifier.c                         | 11 ----------
 .../bpf/progs/local_kptr_stash_fail.c         | 20 +++++++++++++++++++
 2 files changed, 20 insertions(+), 11 deletions(-)


base-commit: fb30159426439bfe9a1435c0555f67201198988c
-- 
2.41.0


