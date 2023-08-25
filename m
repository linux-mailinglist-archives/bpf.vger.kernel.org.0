Return-Path: <bpf+bounces-8561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A869D78852D
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 12:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FFC1C20F9B
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 10:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C60CA46;
	Fri, 25 Aug 2023 10:46:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A13AC2EB
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 10:46:20 +0000 (UTC)
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4606BE54;
	Fri, 25 Aug 2023 03:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1692960375;
	bh=O9VbDsjRgMANqFTThKdY7QAEcZNVKzTA4JvoFBBWP1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gHZaaYa5GLhnGYv9QzSeLBCqj94JsQrdoUW5G8diCo1+JnH5FSN4eJK+VtOh8Dje1
	 DSv2phOd87m4pC0cefJuNTgtzaZz+ByeXou7fw68gVzH1HNxL0Nk09i6PxQ8CD/I4k
	 ygPxq/281FVK6SN487J6m8+o8txXgCiDRevVywvI=
Received: from localhost.localdomain ([39.156.73.12])
	by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
	id A05B86B3; Fri, 25 Aug 2023 18:40:05 +0800
X-QQ-mid: xmsmtpt1692960005tpqavecy8
Message-ID: <tencent_FD258319A1DF2CCECB7095A3D7A65102C407@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjkQVDc0WwmzqTIzVTk/scWCjrbKeXJ1AV9BrNOG8a6qEUx5tUjx
	 FFbptZExJKxkgtxwDBKvW1frZb9+5kFZCttqSkhnJd7/HFbYcst5HPeKtnstNVhCgEo0uA9r7sUC
	 ygpepn9z5fUcDs3yJPp7tv3934JQRvU46c0Gaq09P1TR2w3X4/bOvajh5eqQD+ZdLfRA2+BId7FQ
	 Zm4roydqdSqgmLq6W76OQ6mNp/MABWCZn64vNGxpckRQwc66mOLSfOf2nz2oqc7E3BjzEfvEH1fJ
	 rqzKZKtK1R3KnGaDQSQnoGJGiT/q2vjjcNRlbq9xa+/iJex6ObUt9o4Z7L1X1wr5s+H71dWOGzwY
	 9+lttY7g6hVkMgf02OLeMhPbifZZCx75IxtxIwQ9e5nkKzZ3rpqwXgCIyK03fZxcmk42omzQo/zG
	 g6/CNGIO8cTytsG3Pk4nEUMq/DoHzs8Z+VXQXbQch4A5/VGoNcbwRW77vnbJyvF5XrVHQGbVk+fX
	 Gtm83XV7s3dzPhuUos/QbHqmDFEsojRprLVczuAM/hg68yV01qnUmigjHDgOkppAcPq6MjD5Q39b
	 81DASjz3Fr3IlbVna8RIKr2Wrldw7iW8ZHNlP7QwyqQ5yiHA9jU8ZpNOXR2Q4X6SrLn/nfpHuKiF
	 lcfUgq9eBx+8Y4rZ2jDk/seI1QzLKtpwi8uoA48V+mFHL+Vg15EWesDm6v+UBm6lJRLUXC2R7wCj
	 2Gn1+XUY2g5Rebt733F/A6Z4ltHxiQ4SkJjjeuICpMFfMIE4A7/seAeWPJE19uDunLI4yHqS9wXe
	 SD3QnqnHIf0yP8aSrPo4QJu3zSTlZ7MsZx24CTamQqNKjuW/3zV8KD3rAW6QbrXOu8iM+0SSZIA0
	 yREpg3pp2CivzvIsKqQxFjUHAkRnGXoBzYFpJtIMgLgYNv0J2TPpkuuO1Xqt/xp+P21zk+Iox9ni
	 6ChRcxp9VSba5FcQRHIe6MfPKvyQIXGljDGEurbiA26dY9yqBgs4gRzOHeZQu9Qh0nmo9q6wgpn0
	 vj0uRaxj4O+0+NcjiM
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Rong Tao <rtoax@foxmail.com>
To: olsajiri@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	haoluo@google.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	mykolal@fb.com,
	rongtao@cestc.cn,
	rtoax@foxmail.com,
	sdf@google.com,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v6] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date: Fri, 25 Aug 2023 18:40:04 +0800
X-OQ-MSGID: <20230825104004.34674-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <ZOhvhnUTxtD6YYzl@krava>
References: <ZOhvhnUTxtD6YYzl@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks a lot, jirka. I just submit v7 [0], please review.

Rong Tao.

[0] https://lore.kernel.org/lkml/tencent_BD6E19C00BF565CD5C36A9A0BD828CFA210A@qq.com/


