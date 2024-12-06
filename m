Return-Path: <bpf+bounces-46228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7008B9E63D0
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 02:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E1F164CE7
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 01:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214BA13D502;
	Fri,  6 Dec 2024 01:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="zKEoLoRx"
X-Original-To: bpf@vger.kernel.org
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902C423918D;
	Fri,  6 Dec 2024 01:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733450317; cv=none; b=OV3bbB4hkt4+PS7ydle8efY9QNU/25zgS1dVUQ0TIkElsCPtbItEgUU+LXpaVSfqowGp8aQTRDvhTHS92rd7PhQWcdlt/MrSTUyeig5mzssENTA/3eTqCDFSupj3WOging522zoGQbMt1To9PInVJlkJg/ujIVI3EM6WRQaqpjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733450317; c=relaxed/simple;
	bh=Y9AiBMnxtpUG/TK1YBNEdULHbDh2U87JHQkF8IMPzwU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=buD/Dru58NNIgbp3D0nWEHDBMQ6T04uj5BZKI2BGCAEU5mYtL4ylhArR+0hA8Uth9oG3euscfSDrelTviOWjP+2nVbxJotMUsQBOKuBHsyyzLKoGhbWW47+bO+9EbeuxbnJ2D3OnLj9T3hVya9whcoP2zzTD3e9xKY5Um3HrtEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=zKEoLoRx; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1733450310;
	bh=bB8WAB9G+piz6HTkybFdlzxxWQ5GS4zDBm/VeNYftMA=;
	h=From:To:Cc:Subject:Date;
	b=zKEoLoRxwm6ioHAuYpvddll7Cjv3zMs/CVEAeA3TU+8i66jPkkFxFZ6YSubmNvahO
	 KRLhXpwX1WW3FqvzVxj085IEZb6V+eMJGXT5hZjfmmXY9c57YJytD/o2mMh/n8U50n
	 s3NH/rjt9wLN7b56bprWbumyvyeiQFd/KxCOBTD4=
Received: from NUC11-F41.. ([39.156.73.10])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id E9B21C71; Fri, 06 Dec 2024 09:58:27 +0800
X-QQ-mid: xmsmtpt1733450307t9wnhl06z
Message-ID: <tencent_44BC4B6295D557A6D10D444A032D219CAC07@qq.com>
X-QQ-XMAILINFO: NsQAXnLInl5225mKSS2IeyEO1BfWeJ2zEKj+Zr1a5qzq76nwzOwRGVHN8reqTw
	 tFe09T2oKHGrAoTwBBL7eh+vVbUQzHsv2BXyDDgtTqOt94POLBH7v0XFeRFaudbxCNdInrbfYCdL
	 /aDNAVWq/N0daH+/fB82OunRJfddLkLkrAmxcbagE2nb69ccuezkir4MlogiBffeLU3AE6SW7dwx
	 t3Kj66FGRvFbRs0Hayqnoxbeh4cyTdXZ/scC48UeSbfCfsasLIkPEbE32WbvpOvYSszdK5LKOjxs
	 66xLICQxm3QjY2MtBJ4iFdUzWUN1TEFCzdWYYuUlOp723drOpbWcsvYLuy9hnGrOc8UWV/a0aDL+
	 2dl3PQE36kjbUwNuz+yInwDeOodd4ril3q4TfzblnmVJ+hcNv1Yd4QTtzmuRJD0gpCw6c7VNSgnx
	 qg+sh9++PBJn8DOPDS7WrUnMb18O7g2z0erumw5R/TGUO+syuutGYEAH1AfHwnkThrDNJ5Zf4gra
	 q0+TcCWP9ccdNJaRBRHOHiBYQ8V2Feo8u7k7jx1UE4/iq7S9gEM0VywOu4NhH8SSl8d20TMlEwnq
	 DJuDwD2QYdPoj4YmE6pEiIiyDNiv8FLLjk2N9HvCb/we333EG6pI5pun4MznCWkCv4FOk6Yp9bkN
	 +Xs5SrM0i29+hbNZ6NKMFi0P+VBHKVd8XNCvBIbKXaReuXQmjQWsM/0U1RhtaCPv65kQaAB8C2RD
	 zvD6gB3kWyxCcgT6kLayIC6e5O5Pn0exylzqSPsOD2o+a/g8lGhy8toDxLImQzuws4nvE3LqFnVf
	 pu5ejZQGrN5LZsLr7onvu5V6lpmcQgpawDltodCMFr0yU2X2TP5d6C0McNErWp4YzCNerWbbZNUL
	 8g+aO9G+L3giULkpWqmAe3KabdA2ixyZ07gX8iKLSuNdZBuAZCsoZELYsExQksRyrxbtUU8/1+d2
	 eQrTZ9VIOUZx05H6ixUg==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Rong Tao <rtoax@foxmail.com>
To: andrii.nakryiko@gmail.com,
	qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	rongtao@cestc.cn
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [TOOLING] (bpftool)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next v4 0/2] libbpf: Fix bpftool gen object segfault
Date: Fri,  6 Dec 2024 09:58:17 +0800
X-OQ-MSGID: <cover.1733449395.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

When the target file is used as input and output at the same time, the
input file will read a null value, resulting in a segmentation fault.

Add judgment conditions in bpftool and libbpf to prevent segmentation
error.

ChangeLog v2 -> v3:
  - argc_cpy and argv_cpy need to be initialised _after_ the call to
    GET_ARG()

ChangeLog v1 -> v2:
  - Compare each output file.

v4: This patchset, double check and fix in libbpf.
v3: https://lore.kernel.org/lkml/tencent_A7A870BF168D6A21BA193408D5645D5D920A@qq.com/
v2: https://lore.kernel.org/lkml/tencent_F62A51AFF6A38188D70664421F5934974008@qq.com/
v1: https://lore.kernel.org/lkml/tencent_410B8166C55CD2AB64BDEA8E92204619180A@qq.com/

Rong Tao (2):
  bpftool: Fix gen object segfault
  libbpf: linker: Avoid using object file as both input and output

 tools/bpf/bpftool/gen.c | 13 +++++++++++++
 tools/lib/bpf/linker.c  |  5 +++++
 2 files changed, 18 insertions(+)

-- 
2.47.1


