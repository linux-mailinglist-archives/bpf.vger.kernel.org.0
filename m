Return-Path: <bpf+bounces-62776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369F8AFE3C1
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 11:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F6D583E26
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 09:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FF1283FFF;
	Wed,  9 Jul 2025 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dVwsXNe5"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A4A21FF48;
	Wed,  9 Jul 2025 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052359; cv=none; b=B9QRDf73jL+Hsu96azXVkOReJ3cHv3PEs/y9pdQ1wZU2/9QyH6Upsw2pheWJrAjQPV66N10n6q2AkRTzPhhTgA/3/jpPAz6KynNM77cuNN8Khb72ieoj+NNVBbTmhVuVBxi+0DUrPbhGX/tWJjuWiW2FXOl9n0J3tz0C6Ia5pL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052359; c=relaxed/simple;
	bh=O+BLsHpgnFUtvEtPC/XBdVip6wm1ro7CzzM4jXQG/v0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZkM8GEy2w1cYjGN+aG+a7mjiXrNPsB57chpf+CLHMDJ0oqLd1tIdcQSamoHyIDAyvKhzDvlVwawDyNE+Gp42vGrJ05j9SpRsRrxubIiTpUWxqRYVrSbZqj9qdeOiYHOPvbL6ZPzmb4g0klifDSRMILg8nrSCTOpjj60cvTFNuoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dVwsXNe5; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lh
	Cp80mQdElxK6fidVFF2nq8SJyzqnVgad3pG4eNrmg=; b=dVwsXNe59pn5KL4R6M
	2ATHt8KHEywcLi4tt8VpVUXFtBnYZY0rqQi9M+DFC4QJBywYqBqthy/UkJt1A9IQ
	brr3+LTYZUgfnRxzKTLjcYzudrTf8ut/AQ75dk1fmX/sMefMtVyVvDTjB2HVTyBA
	97TRxyMyULb/qW+6LonfxwhlA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXR3BFMm5oWupSBg--.30597S2;
	Wed, 09 Jul 2025 17:11:34 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: olsajiri@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mattbobrowski@google.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	sdf@fomichev.me,
	song@kernel.org,
	yangfeng59949@163.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next] bpf: Clean up individual BTF_ID code
Date: Wed,  9 Jul 2025 17:11:33 +0800
Message-Id: <20250709091133.127961-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aG4vNLiusia14f4Z@krava>
References: <aG4vNLiusia14f4Z@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDXR3BFMm5oWupSBg--.30597S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUYvtADUUUU
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbipQWFeGhuLVMwQAACsX

Date: Wed, 9 Jul 2025 10:58:28 +0200 Jiri Olsa <olsajiri@gmail.com> wrote:

> On Wed, Jul 09, 2025 at 04:20:38PM +0800, Feng Yang wrote:
> > From: Feng Yang <yangfeng@kylinos.cn>
> > 
> > Use BTF_ID_LIST_SINGLE(a, b, c) instead of
> > BTF_ID_LIST(a)
> > BTF_ID(b, c)
> 
> there's couple more in:
> 
> net/ipv6/route.c
> net/netlink/af_netlink.c
> net/sched/bpf_qdisc.c
> 
> jirka
> 

I see. Can all of these be included in one patch? 
There's also one in kernel/kallsyms.c.

Thanks.


