Return-Path: <bpf+bounces-62499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6642EAFB584
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 16:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990943AF3E7
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 14:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13772BE038;
	Mon,  7 Jul 2025 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h7EWFYBd"
X-Original-To: bpf@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397351A238C;
	Mon,  7 Jul 2025 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896934; cv=none; b=h60i18exWuHAjQSSgqheWkTyJf0Pu58GW1+JmAL7n1rHkIFOeGyVXZBMeFut7hH+WmUVX3ZwtDSq43txvXnE+/JEGlc76Wk/H36YqYuNVye2iNyx1nbAdXdUrnkaVMTIQg9sDaESaTn74cnsYKf961DXPwiMdfrHXoz+p1RC6WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896934; c=relaxed/simple;
	bh=OQNSGpZ/8gNQR8HuNviMGN1sOcIobuqjLu4W8Mqdud8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L417HiD/Cc3L6jwrd42xtdJvcvEzU/qxamNjCyVWjKwwikFzJ9mY3g08IoQ6jHU/NYFguDqX8JbdwWRowy84ja7qfKsYmN+KGh75C8I7VwOX9CB59w1Jwv5hwMAMsZDQ+wzr0fYuwpljjC2N/Ock0jpcQvgdYoMkOAh9fhRVx8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h7EWFYBd; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B472443BF;
	Mon,  7 Jul 2025 14:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751896929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xtk7PzG/SAyN1Y/HLlaKN1mbwfrc74jbsm7GaMkjCEA=;
	b=h7EWFYBdH/i138FEzqPQSXm1uXwkswEZITdJwM52WnBoZjLooTjlyubMejTAdBRXsdSn8i
	xW1arhqu7a0arhVSGPJvVAlXldRyhDb9Qb7DIgB9JNfDVyxjvnfL/vELf5l+Nmg9qdLkD9
	eE6muhitE8EhE1n3uUb50suMApd+czxI294p7gsP1q2+4Pd/VOJwKmeJtgCxZ/PQpwn2JS
	ANgSN3ce28iie+ugoVnAZq1eQ+4Tv7j/pf+4ZgNwUmbT30C70NKCO7epyvzWmD+WOZlawY
	8w485IYH8wQr/cKZfs9YPyZsOzsmUm5ntZsxjSgz0ZVX+p51TnUatoxQwbcvyA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH v3 0/3] btf_encoder: do not encode functions consuming
 packed structs on stack
Date: Mon, 07 Jul 2025 16:02:02 +0200
Message-Id: <20250707-btf_skip_structs_on_stack-v3-0-29569e086c12@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFrTa2gC/33N0QrCIBSA4VcZXmcc59TqqveIGOpck5UOtVGMv
 XtuENHN7s5/4HxnQtEEayI6FRMKZrTRepeD7gqkO+luBtsmNyqhZMCJwCq1deztUMcUnjrF2rs
 8St1jAC6btmKiYYDy/RBMa1+rfbnm7mxMPrzXVyNZtl/1sKGOBBNsBCjD6VFrRs/K+3S3bq/9A
 y3uWP4sAXTLKjHgSnBhqJIE9PHfmuf5A05oN5cQAQAA
X-Change-ID: 20250617-btf_skip_structs_on_stack-006adf457d50
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@fb.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, ebpf@linuxfoundation.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefudellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrroculdgvuefrhfcuhfhouhhnuggrthhiohhnmdcuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheeuuefggeeiuedutdeghffhtefguefffeelledttdfgjeejueeggeeugfdugfevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehpdhhvghloheplgduledvrdduieekrddurdduleejngdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrlhgrnhdrmhgrghhuihhrvgesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepthhho
 hhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprggtmhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvsghpfheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegufigrrhhvvghssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrshhtsehfsgdrtghomh
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,
this is the v3 of the packed-struct-passed-on-stack series. This
revision follows on Ihor's comments on v2.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- add uncertain param loc logic to saved_functions_combine to
  deduplicate functions
- remove unneeded call to class__infer_holes
- bring a userspace binary instead of a OoT kernel module for testing
- consolidate paths used in the new test
- Link to v2: https://lore.kernel.org/r/20250703-btf_skip_structs_on_stack-v2-0-4767e3ba10c9@bootlin.com

Changes in v2:
- infer structs attributes
- skip function encoded if some consumed struct (passed on stack) is
  marked as packed
- add some tests in btf_functions.sh
- drop RFC prefix
- Link to v1: https://lore.kernel.org/r/20250618-btf_skip_structs_on_stack-v1-1-e70be639cc53@bootlin.com

---
Alexis Lothoré (eBPF Foundation) (3):
      btf_encoder: skip functions consuming packed structs passed by value on stack
      tests: add some tests validating skipped functions due to uncertain arg location
      gitignore: ignore all the test kmod build-related files

 .gitignore             |  3 ++
 btf_encoder.c          | 53 +++++++++++++++++++++++++++--
 dwarves.h              |  1 +
 tests/bin/Makefile     | 10 ++++++
 tests/bin/test_bin.c   | 66 ++++++++++++++++++++++++++++++++++++
 tests/btf_functions.sh | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 221 insertions(+), 3 deletions(-)
---
base-commit: 042d73962d35fdd1466e056f1ea14590b1cdbb9b
change-id: 20250617-btf_skip_structs_on_stack-006adf457d50

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


