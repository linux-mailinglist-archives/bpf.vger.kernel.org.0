Return-Path: <bpf+bounces-33356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9431E91BCA1
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 12:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A091C2361B
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 10:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFF7155359;
	Fri, 28 Jun 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u6JhuoLo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N0AIRFQY"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7673E249F9;
	Fri, 28 Jun 2024 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719570627; cv=none; b=O43tpR3vjV1CeHoFHGcdyt+Br2Yti4zBpqSpozUINqZYqXkTMBng2cJIA2OTllOjoN8RSTQpP8DJ22p8aVAhSI+ORo5aqyOeuRbubkWMebCMgehmbghEAaN8EWE9uRY1OLNPW999UGjisbvdulJu1sEsH1FDACuFHR2GF8mzNAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719570627; c=relaxed/simple;
	bh=+LThvw9kmCZ0WLbPzQyTBHe76FuZ/L7de52o0MqDNa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mzUUM5mmT+blVy6hl/ZoKW0oC+qKUaRKXn/aNI6dPxSjsrDZRgMqIRyk00LlFAECTQrbZkWPouJxbErtQfzbcqF7W/1UHT9XLV1xyRk3VMJPi21Nnu5epO8AYHsnK4us/VHouEyym32SSsiv8HwGY1TGhPE3x6xBx76MXEtL1L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u6JhuoLo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N0AIRFQY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719570624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+LThvw9kmCZ0WLbPzQyTBHe76FuZ/L7de52o0MqDNa4=;
	b=u6JhuoLoycYwumPrq70stFGD/2rZO687z64j12R4w1BZcRzWxEMGbZGmuRunFX0i2UxhZ+
	ru5lXhJOYSdhvrZinAoIEbf1ey0bQLYlYZpZp8+Zs/l3KMJrF0kxrXILqghK6Yon+6R8+b
	xp3/PF+gfLS9NFg71uyT5fjwURaZVGsGSvrm/hteXx2RYTFLbHKOpqTSxrCDHTlJFFBQMl
	MkMJf5FgEkj/h57fAOiUS9C00VG5wXz292WGk+RF+4EPBMQMpJNFAvB2c/etnIKdQW4gEQ
	5CB/ACbi1cwarsCSFuoOJNc8oRthpDLg/q43KqQ9RPfyeP25EKl83Oh0JaF45Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719570624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+LThvw9kmCZ0WLbPzQyTBHe76FuZ/L7de52o0MqDNa4=;
	b=N0AIRFQYy822R1oFFlF8XDQa5BIbKjfqG0bf5ZrNaZ6a8YXuxz+unJQQn1xuq/ls0zjVr2
	2Q3RmlwSGhMJ9TBg==
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Hao Luo <haoluo@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH net-next 0/3] net: bpf_net_context cleanups.
Date: Fri, 28 Jun 2024 12:18:53 +0200
Message-ID: <20240628103020.1766241-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

a small series with bpf_net_context cleanups/ improvements.
Jakub asked for #1 and #2 and while looking around I made #3.

Sebastian


