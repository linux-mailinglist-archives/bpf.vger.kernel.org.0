Return-Path: <bpf+bounces-7507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F58F778471
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 02:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F02281D75
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 00:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC3A1800D;
	Fri, 11 Aug 2023 00:01:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3A020F3
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 00:01:39 +0000 (UTC)
X-Greylist: delayed 429 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Aug 2023 17:01:37 PDT
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BBF2D52
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 17:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1691712095;
	bh=Dw7XtY4SevyEQWP/R3km8lwVfji8O5oF8nQ61Ju8lII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fPgoqTGhW84AbF8oFHVhFBR65ge9CkjUUxSCPgTQngOz1jIdCsPxVRb/bfxxNicLr
	 08qMFDqTZFVMtKrHilrO05kM76G4vjeC4vP7EM7M6088MKk5PamdJDrcuGWm7qVONn
	 AnXKwP9r0F05LjceNc3Spq3KeeMXotBDLtl4RVW0=
Received: from localhost.localdomain ([39.156.73.12])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 5C93239; Fri, 11 Aug 2023 08:01:28 +0800
X-QQ-mid: xmsmtpt1691712088tsfdmiii9
Message-ID: <tencent_9C20DA1AB80A0564315EF2A91CBF7A8C260A@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYS7ayxzI94vsOZqKVqzudryzUCgm2P/WZtV5OQZSk4thPDk4eEea
	 aOAs2ToOp0ryzFXZFmC5//FrsUCvlph1kCqtBy17GTWj5v06gIDvPYoQPUAm3eXXgwY+8YZcn7wH
	 nZ5Bv033LLS2gs6ZbFTeZOMZbGPBooqpR1kVEX8oUbEGLAQqFDyrVgCdphpUsnGtDFCjH1G9RKYd
	 JQIYkqSvxZPkF0QUpRYPQjsJTW+WESgkevpos0ZrUv1JE2pBY+LufkvpE7iDJRFLh+uslBk1H+Xc
	 vM3p+r4h/oz9x+mDl2UcnjveZnz//TyMkAx2s9tuECDg0I9xxr8htuMrnBWBvG2itJOIgU1nNx5a
	 ihlL0pc2XKwPjmHyOj8rHX3E2rNLbpYYhoceF94vtR8XaoY+At/u1fQEV3OiykDtZg7ZBTXeLbWN
	 SCHBBCDoBTct28+Eq4HrXH9o1hVl8h5MGy7NSzZcuv6q5RwdpeQ0uWHW/AIcuCw9Tto+w/lrlu+b
	 EadIcOJW7lATigJ8z7ITNUkSQeWtiuYTXmgkOXXW9+gajSAwIUdIfiavia2zLSCJQE2eadhn+tG0
	 Pbzy5+KuLpcV1MCGF1GOxkHvf0YwUUtY5caEQpeHrupbrQBPm6GQAOTzNppjpGQSBH/WaDyNopv4
	 OaFd1ALlwVZhbbuaSXRa/4/TYldXvISgNPCvc4OgWUx2e0/rR6wh7w0cOHYxNP9HdKrfTXjphFH7
	 psBmTEBCjRRMO4RxHMeZ+5CKTkwmVhO65hHeSuAutrUujDm73PERC3mmza6exk2f/z9rt4v4EKIr
	 T2K8MkaXdR1hX1ezbY8mT34Sazzt0qGeXOL7xj5DU7iRQepKbj+BahIhiHvrzItdlrqY9NYvnqkG
	 CvPQCxjmB6TOSOp09g5b7xGoNFeB3PQuQr7p+pGjdx6elLQW7QCaEwTN0B37dkjt/i+ZWex7/RdC
	 FvUpfn5YT7dHIdykWUVks76hC5OA2M4AnIJDLTxXWrMmfNYz7KOA+QtVZDcRaQ
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Rong Tao <rtoax@foxmail.com>
To: sdf@google.com
Cc: alexandre.torgue@foss.st.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	chantr4@gmail.com,
	daniel@iogearbox.net,
	deso@posteo.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	iii@linux.ibm.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	martin.lau@linux.dev,
	mcoquelin.stm32@gmail.com,
	mykolal@fb.com,
	rongtao@cestc.cn,
	rostedt@goodmis.org,
	rtoax@foxmail.com,
	shuah@kernel.org,
	song@kernel.org,
	xukuohai@huawei.com,
	yonghong.song@linux.dev,
	zwisler@google.com
Subject: Re: [PATCH bpf-next] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date: Fri, 11 Aug 2023 08:01:28 +0800
X-OQ-MSGID: <20230811000128.298569-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <ZNUnxJ26/4QfvoC+@google.com>
References: <ZNUnxJ26/4QfvoC+@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks for your advise, you are right, i just submit v2 [0].

I just found that, because of the modified patch, your email address was not
obtained through scripts/get_maintainer.pl, so the v2 [0] email was not sent
to you, sorry.

Rong Tao,
Good day.

[0] v2: https://lore.kernel.org/lkml/tencent_B655EE5E5D463110D70CD2846AB3262EED09@qq.com/


