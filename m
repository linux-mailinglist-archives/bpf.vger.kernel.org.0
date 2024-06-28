Return-Path: <bpf+bounces-33336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C64EE91BA5D
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 10:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7006A1F230FF
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 08:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C00A14E2C9;
	Fri, 28 Jun 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ub3hzLor";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c9bzN4zC"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1F814BF89
	for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719564546; cv=none; b=qexn+Z/h6Xd5dFNi48HzRaeb6JI6C+ebbjOR+r/NPkvUnWvv8sb5/soyP5+fTafmn9nHaFMfYGxYEFfqs6PHkYV9cXN1MskazJlkNLTMlEH8RLcYD29OzISodwCam9C+mbMb9YR3lKBpJIxicDUPkHZC8xUrpk5ZEhBoT3bIDWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719564546; c=relaxed/simple;
	bh=j1vRcQ6CyMaU/7RTXcFDQgXh+T4AhwqYx8QM5ZG2YBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cY7BZjLxsXAVCc9pyzTn+SKl61fwb7x66axq+Ui81L7aIuFfbum4sV40y/tZ0/PQVaXZtJGYQ+CCPGqn1DdKNQTWObq9Mgp0/ZClOsXvehHdkGXsQfoxqEgm6XOrX5Zmu3V6c72/HnpKYZ9/88tDGvgmIyS83Z3ssVR7AvPpi+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ub3hzLor; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c9bzN4zC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719564541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j1vRcQ6CyMaU/7RTXcFDQgXh+T4AhwqYx8QM5ZG2YBQ=;
	b=Ub3hzLoreRk4MS5IzGsg1T4GvRq5cbS+8+kmC3E173PKEpRyO+JwXOJbpQ5npo0wKqESRX
	YEWiy1WnVyIFf9wuTL1DcODOm7kNxThGZhCMXiTGETF4vYE35DluG61rWZhkUTarGUobZo
	FfN6zo498WfDnHZrL8NRn1pQGDA+OlaD6uPLK5eIkSzyVRsbcy1I/9Y43bz4YZfiyJqzjl
	fEnZ6/vfvubAG1vxt1kmaiu9sKZzCsmQYTJ56k8UvuS051Lt11rD0NqBEbl07xmej16j3U
	W0oGyKu6mv1Tc8Evi2hZOEp+1CKsxWHA2gCvY8qJbk8/Qa/95nC0vHbyjk1NcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719564541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j1vRcQ6CyMaU/7RTXcFDQgXh+T4AhwqYx8QM5ZG2YBQ=;
	b=c9bzN4zCXb6/UF4OCE2f1+cVVVfX4HXY48YgtJMlpLKLiEhQX4ig9U1GtJRgSXd0a28V5F
	E3wdMiX8asNm5fDg==
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 0/3] bpf: sparse cleanup.
Date: Fri, 28 Jun 2024 10:40:58 +0200
Message-ID: <20240628084857.1719108-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

after my last bpf series was merged I received a robot mail because I
added yet another sparse related warning.
I tried to address most of them, a few are left in the category "missing
prototype" but the whole block is marked as "ignore-warnings-for-gcc" so
left it as is.

Sebastian


