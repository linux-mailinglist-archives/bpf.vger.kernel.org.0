Return-Path: <bpf+bounces-77265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF046CD3DF6
	for <lists+bpf@lfdr.de>; Sun, 21 Dec 2025 10:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74EBF3007C89
	for <lists+bpf@lfdr.de>; Sun, 21 Dec 2025 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B836B27FD52;
	Sun, 21 Dec 2025 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="BLnYnPyn"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47436223702
	for <bpf@vger.kernel.org>; Sun, 21 Dec 2025 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766310020; cv=none; b=a2f8XS2I5437C84mtmPzA07Gy6qbHGBFXP7P2VJ5Mo3seRD1t3GeMcS38YZ4PitzTaYqrUv9LjisQwsBecDu3M1COkbnF1DnM/kQfwKafbBxkYhjo74OAPWG80gnDUkAZA1q7D1XvFt7Dusbbwv6u1469K48gAQnCelCS13f7Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766310020; c=relaxed/simple;
	bh=Vfu5URPxYK9JhFpmlBG9GmhQ7cInZVahecKvHGjWgB4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=fbHLrWPXkNSiKjcrKhZJOxxedK3llHi0w+JAXekLWiOsH7gBBMyAGdYFoSs5QfflGvROZGszHKS4Lych3N6E1NqoyO2bnByXs9vBlUmXkWUajC2e8NVYYo704t8bsgUuX1Z+IFVReODTTmku4gE6Vb5BzckHumxnKD1uzq7bZ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=BLnYnPyn; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1766310007;
	bh=y0hpb6WksFSVo8IZ4nMENdrJ4St5Y8/QVpK0JZ+6zho=;
	h=From:To:Cc:Subject:Date;
	b=BLnYnPyniA1A85olp1697jjAYiyC5rXyWDE404tQlNsXToYG4ugIwbV6f57F2nHrL
	 4wS/cHmGM5c4my3deNLmOphLl9I+NRyCDuFKTey+DjzY10MgbYdyT44XtWpYI9JsEI
	 plvnu+aKVDbywFjuXxSrYDk0vdqNBWeDnGy7zVtU=
Received: from wolframium.tail477849.ts.net ([122.224.66.116])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id A04BA01B; Sun, 21 Dec 2025 17:40:04 +0800
X-QQ-mid: xmsmtpt1766310004t6cgze4sc
Message-ID: <tencent_717092CD734D050CCD93401CA624BB3C8307@qq.com>
X-QQ-XMAILINFO: NMSHCeFjyxDuljEPYznn3p2rprH8VI0A3XYxG3Eycyp/ItCFLs14bsJXuliNuf
	 XzQHWYRBg+FpUrJLozTDh3mlzIRFShKLtM/xAl//B5dDLUxq95fqK0gUTPrAWvMtv79VBdEdRzBD
	 Ga4H5tsC2sAbNuncCBkMKCDHfyyhUQ3Q1l/0kimayutZW76gQah0HmcBiONYHKCTok6948b2oiCN
	 +Q1F7nIGqIgamdjP4cp1x4tnIijL8YS6GAqsKOd/I37DHbQPtaHkOFcqPn6KzOWHLPSWmwf/ieC+
	 KggR8AW0A7A4eyV1yVYGvCxZKken8Rc3CkXVsaWGrG+eFYuBZqfH1EJ3Zo3qSRIeBWWc3JimtFCo
	 k8ewoXLHHpFdtbZ0NCKcp+BkxU6PnbZG0dNNBLb5HaIKuSSuSih1dnjgEtSClurfs1G8W/OvuTMQ
	 LxQfra8NmoF9gh+qnZvkoGwQ+7uZP+nt8n4v9AgDB8Urom91RvtSb5Qg3LE/I6vBbjI3DCPiaLnU
	 EITiLAZpJS3DsJEWlMTmnsxNMG51hi6TpeEzI1oO1CpX8BBfazz06izW5hN9Y4oTY3AcnXCA7dFj
	 btm6PpA2Ov7tjoMmi+HnS7AcPCf+B9LWuhOlLh9F/Oq17QRw7amMpkW9eITOqyP+a78lq7ftwEyb
	 zXV4/ihTRdw7M235EPgLMP6KcvqK/RaKhXzKEyTHSZ78mJHJ4w0z8DZspzyuAup9tmmeExbnJdfW
	 YTGz9h452eyrB1sQwqJ9I7w3YxXpKb/tSomAkTTmRYVc55r5GYFguQZwad1kDd4FzDCfkw3VTfOs
	 Pnl7MO4CtnrKvIPqPBl5q2j8eV9QTBvB1CsLlJ8J6JB6wCjrfmMmwiakNg3MyFFHT6+8KU/m9ULi
	 kueSF0sCt5QhfjyYU2aEEH01IDWeOqDP9VVmVfL+zWwdbGl96CZlkBRSSv+NDd+x9CZ8MFA6cZbw
	 Iv2TuJC96XvKHK21MSQIIHPaKPecR/Eivl9h20G7u95x6FMUDBG1VWCKfy26FtpLd1Rbw3e6Vket
	 ZWq1qAcskfNLrfygbKqmqKreWfFdaKjCyJ34VpzK396Q4MR/UuF7GNUF0tiGOUgUaiKmaUqlt/xU
	 4h4fbFhx3MCxDDgYGsJWGcjJ8fxcGbQByTvpeRpdqekrlJMU5+CprFbW6a8w==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Yazhou Tang <yazhoutang@foxmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn
Subject: [PATCH bpf-next 0/2] bpf: Add value tracking for BPF_DIV
Date: Sun, 21 Dec 2025 17:39:52 +0800
X-OQ-MSGID: <20251221093955.109312-1-yazhoutang@foxmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yazhou Tang <tangyazhou518@outlook.com>

Add value tracking (range and bitwise tracking) for BPF_DIV. Please
see commit log of 1/2 for more details.

Yazhou Tang (2):
  bpf: Add interval and tnum analysis for signed and unsigned BPF_DIV
  selftests/bpf: Add tests for BPF_DIV analysis

 include/linux/tnum.h                          |   4 +
 kernel/bpf/tnum.c                             | 159 ++++++-
 kernel/bpf/verifier.c                         | 225 ++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_div_bounds.c | 404 ++++++++++++++++++
 .../bpf/progs/verifier_value_illegal_alu.c    |   7 +-
 6 files changed, 797 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_div_bounds.c

-- 
2.52.0


