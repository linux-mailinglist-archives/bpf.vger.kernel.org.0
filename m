Return-Path: <bpf+bounces-62241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C27AF6E14
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 11:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098D41C289CE
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 09:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2050C2D4B55;
	Thu,  3 Jul 2025 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CzGptYIp"
X-Original-To: bpf@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861DA298CB7;
	Thu,  3 Jul 2025 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533375; cv=none; b=PhfZ9Bj/5VygXLagJroRPCPTUxBDNmO3tTZU8QDKYYHQvDxZqxXc+YcWy/XkdMdzcSD9BcUmBatxMIPI+QiS0ZYjVFT41Qjl63yyZQJjlLwzsqO7IsCqCn3XpnPshrMa/P/HR7cgcUoz0YRiGtvJxUC8Thkr/4QVi2ZL2OkCXRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533375; c=relaxed/simple;
	bh=vTHmDS1rjELUMLUvH7eoac1LJsDA1E1EDrYsb0hi0R4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EUPN6osI9BYwlNjNHzc0RUd9Gy5RF3RLTrkl/28Dd0LiSTe9qPIk+VuhRt31Gum5bvxn0ZtnAe6J+apXoSbbllePJGet7Pz9OOQKNmxk/yciYOMDCFLa+donE64JdrwIdDr4RC+ZWcnTB2D95/NfgFhzd9GFCjxxZrtQ+vhQA+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CzGptYIp; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6091F42EF5;
	Thu,  3 Jul 2025 09:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751533365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vDdF21T+JyuQiThsjON7jPlPTtcEDVqYwI3LxrJE2oA=;
	b=CzGptYIpzzlD/uJNnzxAeFTkWPZPYhqkmHn2oE63D1W2PpIiweVj9yltZj0Mh76W66mUn4
	PEYaO9fhUNH43uvR7pAFQ+Poa282/6XUKcHI29rVBbfXgfQ2nW25q+2lUTPi08odDVdtSF
	406rguc0pwlH/NeXFil59dT8XmDzxSfwa7Aq2RRlvwEdgqKULw/PVdk0Q1S3iY7lpbGmqf
	k6g8XAxJv3zT2/oeyPG/y9CBhNgMPyLrn+d0i0aTBLwNQDDJfI15zfExPWZzcIyTYQguqB
	zVKmJns9GNy+DXiVMNye/WyTXVYOAAy+tRR4dsuKkBqBZPHknq9uFh4CaGSiGA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH v2 0/3] btf_encoder: do not encode functions consuming
 packed structs on stack
Date: Thu, 03 Jul 2025 11:02:31 +0200
Message-Id: <20250703-btf_skip_structs_on_stack-v2-0-4767e3ba10c9@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACdHZmgC/32NwQ6CMBBEf4Xs2Zq2WFBP/ochBMoiG7Ql3Uo0h
 H+3knj1Nm+SebMAYyBkOGcLBJyJybsEepeBHRp3Q0FdYtBSG1moUrSxr3mkqeYYnjZy7V2KjR2
 FlEXT9QdTdkZC2k8Be3pt7muVeCCOPry3q1l925/1+Mc6K6EElrLFIj9Za/JL6328k9tb/4BqX
 dcPzXD3ncQAAAA=
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrroculdgvuefrhfcuhfhouhhnuggrthhiohhnmdcuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheeuuefggeeiuedutdeghffhtefguefffeelledttdfgjeejueeggeeugfdugfevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddvudgnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepvggsphhfsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegufigrrhhvvghssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhto
 heprggtmhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehfsgdrtghomhdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghlrghnrdhmrghguhhirhgvsehorhgrtghlvgdrtghomh
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,
this series is a follow-up to the RFC sent in [1], which aimed to make
sure that functions consuming struct by value on stack were not encoded
in BTF.

This new series comes with a less "aggressive" strategy, and only skips
function encoding if:
- the function consumes a struct by value
- the struct is passed on the stack
- it is detected as packed (see class__infer_packed_attributes)

The detection is not done anymore in parameter__new, as it may be done
too early to have all the relevant info to properly infer the
attributes; it is now done in btf_encoder__encode_cu. The series also
comes with a simple test, but as the kernel don't have such case
exposed, this new test comes with a small out-of-tree module. The logic
is kept simple and the test is by default skipped (it needs to be
provided with a path to some kernel sources), as I am not sure how it
should integrate with the current CI effort done by Alan.

[1] https://lore.kernel.org/dwarves/20250618-btf_skip_structs_on_stack-v1-1-e70be639cc53@bootlin.com/

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
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
 btf_encoder.c          | 50 ++++++++++++++++++++++++-
 dwarves.h              |  1 +
 tests/btf_functions.sh | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/kmod/Makefile    |  1 +
 tests/kmod/kmod.c      | 69 +++++++++++++++++++++++++++++++++++
 6 files changed, 221 insertions(+), 2 deletions(-)
---
base-commit: 042d73962d35fdd1466e056f1ea14590b1cdbb9b
change-id: 20250617-btf_skip_structs_on_stack-006adf457d50

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


