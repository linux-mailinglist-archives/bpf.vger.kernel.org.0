Return-Path: <bpf+bounces-7961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 279DC77F002
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 07:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4331C2110D
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 05:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4551803;
	Thu, 17 Aug 2023 05:07:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EA0395
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 05:07:29 +0000 (UTC)
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A14F1BF8;
	Wed, 16 Aug 2023 22:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1692248840;
	bh=qL19K6EJ7u+hGNF667ktlTV7VvwidaQUhPnALBxEre0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hRICxlxOIzFYsCxYsIGwRuPfOlsu9Wr15FCV/Udz7Hh+9ZQVlTrDgj39SIacEf8za
	 ewTmKifgWKgs1gP87qLsyyLRyxumLoOPknhC/WT4SGt0TnHnUzDA5gU2FCrp7PYCdL
	 PjVz0Ub8PrVy0gBDjhD19C6JsMQjHSZC9J2XoEH0=
Received: from localhost.localdomain ([39.156.73.12])
	by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
	id 1CFA1469; Thu, 17 Aug 2023 13:07:15 +0800
X-QQ-mid: xmsmtpt1692248835tz3oa29eo
Message-ID: <tencent_0ACEA803629581931054D6E3659F8AD3AB06@qq.com>
X-QQ-XMAILINFO: NSObNE1Kae7Zzzod1N7QKTYNY+acjUKzl/06K2ncS8K9y33OXGlwGpesmfitya
	 fSTt9mo0rUhxYbz/Au9OXBfkXe/xfLZb5GPpgldINm5LO1iuVOPsKKht+xH5c0rQUChUb1mAecKB
	 DjBTNiqPt9G9FYWCIaZF4YGNRmOn1h76R6YseHJaKyaeFdCqobb3yTZB3yyzqAsX/bmqARmu+7cI
	 HQEO31REvPx3vMb4QlegZ9yOlqBk7pBoPp/h9te572no/iZX8ukUPb1xyc1gAaXRfhjMBvxjhpgh
	 GJuer6P3FMMi5aEp1dJObM1cfOwaJM2Rs+3jHqaVP7gUc4inQ5mcqEJnoUGa6lO1eUQQxpkHMmCT
	 OTR3JIjMnU3SNLVAUuHHNQ3zyHWUUSNPQXi7m1IDPe6cDlNutR3dl8tz66FC9WfJ0i0vptDGCGeA
	 oK+vvn+3y9mDweZWYsR/zpnaQ6Kz1DRKczjOe1yNXELPgtFe4ZsgL2abUnKw3C3ZQxMUE+9XOpWQ
	 p4O55rQ8lj3GY+VSUXstAEZlPCEPRtQ3JQ5OE3Mlz8bgkUmQhmJVNHqj0e9fHTUnUhllLZ3frepD
	 okhOaNboqq9tGpocygLN1uqkN2KJzrasSG59s+lczfFStr6UxSA3I+jruCuzD/uXj67bndAnA8/H
	 +6IcnMsyzS/df6/B5XRtg+XZxd0Qj5FtYqCAEr8+RytEc02ETSiZVzcO3c+jt6XAxn6R0z1B4Ahh
	 0ByNOsjDxojPJKrkXfnyUUlr1kLEKa2xph27i+p+0S+4QiT3eGc1XDb6hxM+v0cdW75/O9z2edVJ
	 5GIre+3bCXhXzENe3kIUi+KgvvBOJdCW+aU6WN0QaxoP3kfog9hdolo2Qz3ZW7euh15Cp9FulrmZ
	 D+C2gOOvTmHilNkCCTvtgeJ97xNRA6cO5AduL2LjC4nNym9NB204vblQ46CyJHyvvjNMcAqv3ZP6
	 ikglpHVSum+Aj7vLxO0byuTlWndBiFlx5TuQaoQdHb6Dw+x/tHZDIcbSxYVCSQPFcAinfk6SA=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Rong Tao <rtoax@foxmail.com>
To: daniel@iogearbox.net
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
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
Subject: Re: [PATCH bpf-next v4] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date: Thu, 17 Aug 2023 13:07:15 +0800
X-OQ-MSGID: <20230817050715.20226-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <60da4749-3009-0e40-90bd-90cd03395e45@iogearbox.net>
References: <60da4749-3009-0e40-90bd-90cd03395e45@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks, Daniel

I just add ksyms__free() function, it is called when ksyms__add_symbol() fails.

Good Day,
Rong Tao


