Return-Path: <bpf+bounces-9501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A6C79882C
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 15:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614301C20C58
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523E263C5;
	Fri,  8 Sep 2023 13:58:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056715398;
	Fri,  8 Sep 2023 13:57:59 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0321BF1;
	Fri,  8 Sep 2023 06:57:58 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694181477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s16VZO539sho6txxYQFjLH537yZjkITAo+TGaFsT1+0=;
	b=iznq47DGAtHvnc+RXQMCCI2owKELuSFGWprN66xvmbnAlU73imuXwhbexfSLj+rK1MCphb
	hHBJymArpyas5UYE7Xvn4q0k+9fzRiyCxJP1UQKb7+DgkByTPxIbcaK7VffkrC1KIXzMOO
	b1rJrgig6PLiNhmYRwG56ESOMP/asTUuLB8Pl+30EQ+RMBN4RfqHFTdDqQQsz9tnokXpSo
	Pd0bg4hl+q3zqG342A2LwDIhNeCROK3Yw1xZqYRGFwpI7wR22SQs8dwGABpmdqDPBa8HAt
	9DWULiUUVuhZFvmetUmhG/blDyHQZsi43q0bPKEPcrTQLF7Ea9aQGb4gC2xEcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694181477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s16VZO539sho6txxYQFjLH537yZjkITAo+TGaFsT1+0=;
	b=OBGzSt1m1ud7CSFejNDEH9Vcax+tsLGL+VbdP0mZr2geZVUXM6b3Fymmw+3SRXhfOaHSYt
	XemoGd9Wd6xSVnBg==
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
Subject: [PATCH net 0/4] Add missing xdp_do_flush() invocations.
Date: Fri,  8 Sep 2023 15:57:44 +0200
Message-Id: <20230908135748.794163-1-bigeasy@linutronix.de>
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

I've been looking at the drivers/ XDP users and noticed that some
XDP_REDIRECT user don't invoke xdp_do_flush() at the end.

Sebastian


