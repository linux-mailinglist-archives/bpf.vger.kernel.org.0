Return-Path: <bpf+bounces-6631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9737A76C004
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 00:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815AE1C210A5
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 22:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58577275AF;
	Tue,  1 Aug 2023 22:00:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2544C26B7A
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 22:00:12 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B51103
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 15:00:10 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso1807165e9.0
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 15:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690927209; x=1691532009;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TAbY+MwuZkdoWwSh/6LwTKT6XSUTseA9tikYHzrel2w=;
        b=ivaMjd++K/dOqd0zM/m/oELJMjcPaxNr2odyukYO0W2Vte6sJW3s0s3wvqsUlEZ1lB
         R3GCR+UiO3HwgKKIMUE8DkrhtrVCgxpMX9anmN55ylG1GmIV288+3S8jfl169QSm1JSZ
         uQQeMcptRDL4rJfF2TKcv8BGOhdtlpNVN+FcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690927209; x=1691532009;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TAbY+MwuZkdoWwSh/6LwTKT6XSUTseA9tikYHzrel2w=;
        b=XKvjCRTkrjUdqQ+paf9Y8kCDiBwZZn5vKzQZ8b3bBvl73SGvbxoNSBWvBZ24559Xsn
         lOc0VwbcUsKQ1kJYIrcqSk17/R+fk5+EiJdYcRb57lr8H8fZAHcRA4M1Kd97KqFKs3OL
         O0atQPxZpa0IFTKsrMBeTsxF9Ohze+JEggy9ArEWX2c8a1D1HHckRHE7nmg4wPg/1h19
         HvJd4hV76evMk0UIdPhQFBcgcxQKonO8ocKN369pa+e8bUJTcN/0o0k0NgN1Vsx7R/mN
         J4v0+HiSbxb8RzooTarap5ee9lzT6KxBVuHbxIrWMYp63DR25o2k5PKvuRK+6bONslmA
         g0Yw==
X-Gm-Message-State: ABy/qLbDSvWtNMPpvzbyR4HMVMhxH6WwE1hoRyXKLXqgQSBt1t+QtTb7
	oM4llZ2fcrirY3Tc/OqsRFTQAXIxu2fs40m4TnhYYkK+ExB1MFvL1cU=
X-Google-Smtp-Source: APBJJlHRPlNqyuQkyFUHik3ec7Y0pzvw4CVVnZkNHBV4ZQIQD7/kTIzkHCaROA4GRFnJb/sVubMeI0XsZDlGkxvQQmw=
X-Received: by 2002:a05:600c:3b0f:b0:3fe:18e0:2fc6 with SMTP id
 m15-20020a05600c3b0f00b003fe18e02fc6mr3250993wms.3.1690927208733; Tue, 01 Aug
 2023 15:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ivan Babrou <ivan@cloudflare.com>
Date: Tue, 1 Aug 2023 14:59:58 -0700
Message-ID: <CABWYdi1KERLa9dOK8mxxdNvT746R8adFHxuN53VMvWMS=yyq_w@mail.gmail.com>
Subject: bpf_sk_cgroup_id is not available in tracepoints
To: bpf <bpf@vger.kernel.org>
Cc: kernel-team <kernel-team@cloudflare.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Stanislav Fomichev <sdf@google.com>, Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

I noticed that bpf_sk_cgroup_id is not available in a tracepoint (it
is only available in cgroup related skb filters), even though I can
easily do what it does manually:

u64 cgroup_id = sk->sk_cgrp_data.cgroup->kn->id;

It seems to me that bpf_sk_cgroup_id and similar functions should be
added to bpf_base_func_proto (unless there's a better place).

I'm happy to send a patch if this makes sense.

