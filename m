Return-Path: <bpf+bounces-9508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21777988DC
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 16:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B942281E4F
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 14:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79174F50B;
	Fri,  8 Sep 2023 14:33:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4338EF4F5;
	Fri,  8 Sep 2023 14:33:37 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFEA1FED;
	Fri,  8 Sep 2023 07:33:04 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694183572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=URRWTsW4TtIT5wfkYL9+JVktSdhRDc5xo7+E/okpbiU=;
	b=bbM1/iSZ2ChtXqdW8EQhlC59jjHwtgYVLsfsZG2PxoVwQhSmvIMBBNxOpaa57CyQQ9bslJ
	nEZJywVDwMW/fX1LPaRghuBlZXneNu/gMGWALLRGYU+Pz+0Ho/ulA1p6mSNmylKSNYCauY
	P2G7Q36EpluZW9T3rc858xz6v+ninvH/fFUYVV9E/7lbeCSoVLFubHiRiDuheI7oqRly9N
	7Mx3fixyLMkpWhdEBV5PpHjN8gOIDDJjeJkH64MWKEfrECbWJ4nGIgNtFxaoEI0FYQ3NPH
	Gn0EbRrfDC8SezKSXqB0jspTTRMW1K21AWCwH2pI+rrIRh7lu63qDS8QbL9SXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694183572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=URRWTsW4TtIT5wfkYL9+JVktSdhRDc5xo7+E/okpbiU=;
	b=mCVX0plpgShq+D+Jr+kXiy1aXcMGtT1VoQHQer2xUBcJ9fbEWmGA2Hoz7g2GfXXnz1KHAo
	aNk8L7C1gNh5gCDA==
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH net-next 0/2] bpf: Remove xdp_do_flush_map().
Date: Fri,  8 Sep 2023 16:32:13 +0200
Message-Id: <20230908143215.869913-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

#1 is a s/xdp_do_flush_map/xdp_do_flush/ on all drivers.
#2 follows as the removal of xdp_do_flush_map from the API.

I had #1 split in several patches per vendor and then decided to merge
it. I can repost it with one patch per vendor if this preferred.

Sebastian



