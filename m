Return-Path: <bpf+bounces-6345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E8F768525
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 13:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B711C209BF
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 11:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCB61FAC;
	Sun, 30 Jul 2023 11:50:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5EF15BD;
	Sun, 30 Jul 2023 11:50:09 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F4AE56;
	Sun, 30 Jul 2023 04:50:08 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686f94328a4so1912395b3a.0;
        Sun, 30 Jul 2023 04:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690717807; x=1691322607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QXMNG5KhGrsbUgPfHcOBiTZt0wLBsT6SAu3Br3/v/W0=;
        b=BCvSEboVSk+AknIepB4Ps+glROPh/oy3j1jp2b89RO5VyzSmWRvafPyC/NNQ7vJEHZ
         mON+yn02TNOPCVUhCYVSG2ySw2eJbgljefRftzgR1NAR70X3WECyEOnY/qt6CUTaPCHt
         H9oYxJey6S55kILjYEVJ75AsgPK9RmBcz/mJO2w9KGvUNRnxeER1ZcRM1tOZG+TTJZ/V
         OQMFm9858NnNjyWqOVsfT6qKwGD9ljNYVkNKoI54Fve13MwtJZ2I0GCjAQ7sGGTXdm9x
         ECH3nm7n4708KetFRXX2WFsTn+zCr75MKmxTsw/B3BOz/M0TQZYHty02eCWvU/RYyiOa
         R2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690717807; x=1691322607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXMNG5KhGrsbUgPfHcOBiTZt0wLBsT6SAu3Br3/v/W0=;
        b=hjTibidZfEQNM30lN6/hGq5ju+887gg02XDchjelpipyOAI4jTIlgLg4Wqej3S7O+g
         FjuYH9CtvuKAUwcbAXAjo4k69UwP6WSUsiUewvFSre3wpsTec4GFxy+GludkH8Ry1L6A
         xMOCPySp5fXj9WmO2ai5iKvOARmcGbDNTefnGLkItfHUJW8AEbZ8DyaFm14GRYT4M8eF
         dcl1QnDiFrCr2Bi1fx31ik2K5yUVyQ7TchUiTQQ0hP2/mxC6OfbdpaAFOiuHFHgTn8Uw
         QGfrOM9ykQCYqewxqVDHI7ZrLTF/Xt6wpSoHKlnb2M4lM6FsXD6lsKjdSNzLdAEY9F/W
         uLQw==
X-Gm-Message-State: ABy/qLY+yiTpfFsDRsonzAb44dIdnDgZME6xy+U8x8hKadakskbqMEZ6
	ufZ9DxnTVcKURMuI4kuWErkEj75uTAo/IoQ+
X-Google-Smtp-Source: APBJJlGY1O/ykplV1Y1HoNzXM24EQES/iWQKlcnCzovsku32YZdV3AMYYDHM7jTsWr6PvX/t0jmn/g==
X-Received: by 2002:a05:6a00:4193:b0:678:11d6:2ad6 with SMTP id ca19-20020a056a00419300b0067811d62ad6mr7003694pfb.9.1690717806912;
        Sun, 30 Jul 2023 04:50:06 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id z9-20020aa791c9000000b00640dbbd7830sm6044479pfa.18.2023.07.30.04.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 04:50:06 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hawk@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	hffilwlqm@gmail.com,
	tangyeechou@gmail.com,
	kernel-patches-bot@fb.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 0/2] bpf, xdp: Add tracepoint to xdp attaching failure
Date: Sun, 30 Jul 2023 19:49:49 +0800
Message-ID: <20230730114951.74067-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series introduces a new tracepoint in bpf_xdp_link_attach(). By
this tracepoint, error message will be captured when error happens in
dev_xdp_attach(), e.g. invalid attaching flags.

v3 -> v4:
* Fix selftest-crashed issue.

Leon Hwang (2):
  bpf, xdp: Add tracepoint to xdp attaching failure
  selftests/bpf: Add testcase for xdp attaching failure tracepoint

 include/trace/events/xdp.h                    | 17 +++++
 net/core/dev.c                                |  5 +-
 .../selftests/bpf/prog_tests/xdp_attach.c     | 65 +++++++++++++++++++
 .../bpf/progs/test_xdp_attach_fail.c          | 54 +++++++++++++++
 4 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c


base-commit: a33d978500acd8fb67efac9773ba0a8502c1ff06
-- 
2.41.0


