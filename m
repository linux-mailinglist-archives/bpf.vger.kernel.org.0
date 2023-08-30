Return-Path: <bpf+bounces-8976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4743178D3D7
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 10:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6C9280F2D
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 08:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF1F1FB5;
	Wed, 30 Aug 2023 08:04:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE6A1C11
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 08:04:19 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF2DF4
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 01:04:17 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1693382655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lYuAnkaxmLR+UFbPG2N5LPxXntCwqdkQzjK3MHfo3SA=;
	b=lhIoeTJI7AzOVUlDhuHDsz/DMf3W12VQE0iU0SZ4itKdt8yWVaQ0+z/VZ9jb/Ynkq6sHu6
	YAR3t56qo9rT0ZYn/Gk3H2CT1RbYk2EQsFW+PJXwjEAqZJvWn0CQwQdsI+cQUG0ZPiSsWc
	vg9naC3BItwFNkuCaWPvGnML8kBgvyASwFhbhznIz154r9Uesohr2TkpOhdd7aEjU6KjJl
	nmCn1ueqg8fOkYcnLtuLzoirQQPtVgLrSiVsaLrtkxZRCCZvVVKixIbO2URyS+RFbUAk1b
	msl671eZYGxXFt8T1te1HGaRCw94vR4/AOzGasMzbsS0zsvskMwOx6qGeoc8mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1693382655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lYuAnkaxmLR+UFbPG2N5LPxXntCwqdkQzjK3MHfo3SA=;
	b=zAA6fgZ+XNWiE7VnOJQPQRIClbrKkQ30YrFuK5aoZWVP7YVF55tC5gUGO77BfICcWnbdIW
	vBMwavj1fmnbsgBw==
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kui-Feng Lee <kuifeng@fb.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/2] bpf: Recursion detection related fixes.
Date: Wed, 30 Aug 2023 10:04:03 +0200
Message-Id: <20230830080405.251926-1-bigeasy@linutronix.de>
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

the two things popped up during review. Compile tested only.

Sebastian


