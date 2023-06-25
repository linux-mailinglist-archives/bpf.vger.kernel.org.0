Return-Path: <bpf+bounces-3411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4BE73D319
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 20:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB991C20826
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 18:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B9A8468;
	Sun, 25 Jun 2023 18:57:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA29079C5
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 18:57:57 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446A21B3
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 11:57:55 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f865f0e16cso3056595e87.3
        for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 11:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687719473; x=1690311473;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ro+V3hqxHks/CVH4PUbaC23otrWaS8XiRZtoXZWXk8g=;
        b=ZUTkuu1RfK3PC2ri4xVwjESQHaswk8/I+EW3G865PwLaUbrebztCaOqW/hMiuoVMRo
         svady+vx1ODW3J/So+f5IwiiEObzHhKvbdFyUDOTulWKe0yyphS/Q6fXKiksa8dEDCFy
         sYAsc7aO/LZqRuZyYiKt7DfK7bBkICiWrOV0/RdnOmrQnl05pKrRvrylbHsk0cYqWS6w
         5xfL+v3KTZPKaDABKtz7bdzKjNQj+a8S6ewUxh+lG9CN853L2iMiGf+yuUr4fY7wAjvw
         OZNj3//XAJyoLfqs1gsZuYzia89Jm5La3nOO7V8NHeYl0aUIwzgrVkcmElXWbv2CV9+A
         tmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687719473; x=1690311473;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ro+V3hqxHks/CVH4PUbaC23otrWaS8XiRZtoXZWXk8g=;
        b=ASeN0z8MR0DfA5VlLuS7E672F2+s/CcX82jYCD6TMb6HTdQUpae3BMkgeMcDipuKXY
         vucVq2Ig7ZCXWvgMDHmFFjqBvPZD5dxC5/kngb9JxDl7f7FegWP7clQq/IyvrRTvC7mu
         gVRW9GArx5HFE2y7jhj+EyLHTmmncDdhkKdOKGFL8ow1CZjM4/WjD9XVKTgU8GRN/oe2
         ovm/EU4o06aeGV/VKTJz0CVUN/8VCxencZbJPMqWwLVRoHHdKKy0uLNqrdYXpDLiD+cW
         +XSUaWXOqXWg4y1t29Xvyp0e8Ne41UaTbEtD/vl1ebejgWhxz+jPlYkvfjyCLgVmcg7m
         wqfg==
X-Gm-Message-State: AC+VfDypZMhz2HKLmf4MIWzudEnGRAkUpjGihnPaPeBPF97vxsJ8KQfD
	UYwjnviBK+OKXFPZNxaT87a0hTlLLYhVmnBK6UFZQjviy9k=
X-Google-Smtp-Source: ACHHUZ4SLGHaNw1NAndlpQyphTIr58XULBVRlZscK0tcV1KZ5ZcPoDW69Xt+QxXCjV256wrjY/sT2hHpOgs87TvxE6k=
X-Received: by 2002:ac2:5b9a:0:b0:4f8:582f:414e with SMTP id
 o26-20020ac25b9a000000b004f8582f414emr15295765lfn.15.1687719473121; Sun, 25
 Jun 2023 11:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 25 Jun 2023 11:57:41 -0700
Message-ID: <CAADnVQ+0dnDq_v_vH1EfkacbfGnHANaon7zsw10pMb-D9FS0Pw@mail.gmail.com>
Subject: selftests/bpf bpf_nf is failing
To: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

after fast forwarding bpf-next today bpf_nf test started to fail
when run twice:

$ ./test_progs -t bpf_nf
#17      bpf_nf:OK
Summary: 1/10 PASSED, 0 SKIPPED, 0 FAILED


$ ./test_progs -t bpf_nf
ll error logs:
test_bpf_nf_ct:PASS:test_bpf_nf__open_and_load 0 nsec
test_bpf_nf_ct:PASS:iptables-legacy -t raw -A PREROUTING -j CONNMARK
--set-mark 42/0 0 nsec
(network_helpers.c:102: errno: Address already in use) Failed to bind socket
test_bpf_nf_ct:FAIL:start_server unexpected start_server: actual -1 < expected 0
#17/1    bpf_nf/xdp-ct:FAIL
test_bpf_nf_ct:PASS:test_bpf_nf__open_and_load 0 nsec
test_bpf_nf_ct:PASS:iptables-legacy -t raw -A PREROUTING -j CONNMARK
--set-mark 42/0 0 nsec
(network_helpers.c:102: errno: Address already in use) Failed to bind socket
test_bpf_nf_ct:FAIL:start_server unexpected start_server: actual -1 < expected 0
#17/2    bpf_nf/tc-bpf-ct:FAIL
#17      bpf_nf:FAIL
Summary: 0/8 PASSED, 0 SKIPPED, 1 FAILED

Some kind of clean up issue.
Don't see anything obvious that might have caused it.
Ideas?

