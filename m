Return-Path: <bpf+bounces-10291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9715B7A4CEA
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3381C212C7
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 15:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088341F61F;
	Mon, 18 Sep 2023 15:42:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3317F1CF94;
	Mon, 18 Sep 2023 15:42:17 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881151733;
	Mon, 18 Sep 2023 08:40:22 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1695051377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4liYtsWf5+2uLJ8P3fK1giXxSWZEaojR6CIu5f5W6zg=;
	b=upuvmqw0OTX2kuotK+ccwhjM4LqohCJQ1M5ffMjzEh7YVWcRQ1nFobDL6eISdqJLYiFDKU
	FR2VqobDagl9Q5zb1RNK9osyAS238ofdteE1X3tY8Ktf6QJ7usPn76rT82LM5Us1BgEQJd
	+3Mi8unrezfigzU3ic447ZGHGeFhnYUgbN6SDEbh4o0XfVjrtrbtdL5QYTPbjVgCXM6bBw
	kFRl+4C385wXWhFytMFK37RummSD1SBafj9VHB7NltsnYsK12QKhZiPorBCHeb+N3XdZYn
	Lz/oYeQP5rr1D62A/9+cXuBapkoHmF1Fnnxjml3XPh7MogH0Nd3H8tKqcZG20A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1695051377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4liYtsWf5+2uLJ8P3fK1giXxSWZEaojR6CIu5f5W6zg=;
	b=i3R5BbxXmI2Nji3i6B/Mm3KfAz0FEMlKhEYWZsjAANpKUkVigK8kosQnjsBHWvBZDFqaSY
	4Xl99qdH4KczBRBg==
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
Subject: [PATCH net v2 0/3] Add missing xdp_do_flush() invocations.
Date: Mon, 18 Sep 2023 17:36:08 +0200
Message-Id: <20230918153611.165722-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I've been looking at the drivers/ XDP users and noticed that some
XDP_REDIRECT user don't invoke xdp_do_flush() at the end.

v1=E2=80=A6v2: https://lore.kernel.org/all/20230908135748.794163-1-bigeasy@=
linutronix.de
  - Collected tags.
  - Dropped the #4 patch which was touching cpu_map_bpf_prog_run()
    because it is not needed.

Sebastian



