Return-Path: <bpf+bounces-43912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EBD9BBC6A
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 18:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8581F23220
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 17:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EBA1CACDD;
	Mon,  4 Nov 2024 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbcIMMaU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42001C9B87;
	Mon,  4 Nov 2024 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742780; cv=none; b=OgZsxXwcP4/b7QMD+pwjI+rHMpQIg3sbTHkMDq/nr9OOcYBrKFUjrtO2POp6hmnKQUUfoJED9SCosfCkphiXJtGSOC0WJUnyB2LUzK14VXUC1MVwCqjpHHSRA5SCASUpJYwdlW/HvkNK+9rGKVozY/HKxK6GZa6Z+X69XB0w2G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742780; c=relaxed/simple;
	bh=xEt4zSH+QXL2Jh8IfBhEq5qCDd2c4PbR3WS+cvwrEZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gNGpwmrYAC54chyk5+sfOY7bZfXqKXvDcNvmqobBbpHegvVjunKPVYDAOcQChKHTplj4wh8uuQMhsxPyKN8rCe0K1g72kBhVWCJRMq8H+0zEAvBy4FNkY4XgOenaxux2Zp9v0jbPz+QmB5Z/4KUg18dhMCYwTfTSPZz4Qp7Hqh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbcIMMaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0418FC4CECE;
	Mon,  4 Nov 2024 17:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730742780;
	bh=xEt4zSH+QXL2Jh8IfBhEq5qCDd2c4PbR3WS+cvwrEZs=;
	h=From:To:Cc:Subject:Date:From;
	b=CbcIMMaUirLQ9a6jguLBy4IIKTusZoAwLRzU/hX9hlBLiWu4qRFThiVvy4Seubv9r
	 cq5ek6n8+6R+9s6osGecH2BXT0LRA5VCGX5mYdspf/e61bbBLySsMUb0OZniqZmRZ+
	 3oD3h2r7h6gvQ+6kIyFXFRanqPjKCaQWNrCDwDBq4YRCBcAAqFIs03me65Kxb+Hlxq
	 f//CQ+cTWauTie+D/yexRFEKFSKxaI9azp4VBTMQmlz0p3lj244a/bdkRF6ae1Fxjv
	 lD9z1klDYILX+f2Sz7n8OSlD5iH3ttjKQ4EsoLmXgMw11yYQSS7xJHqEvGKSI65fEN
	 eeyO+V70JLlaQ==
From: Jiri Olsa <jolsa@kernel.org>
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Fix build ID parsing logic in stable trees
Date: Mon,  4 Nov 2024 18:52:52 +0100
Message-ID: <20241104175256.2327164-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
sending fix for buildid parsing that affects only stable trees
after merging upstream fix [1].

Upstream then factored out the whole buildid parsing code, so it
does not have the problem.

I'm sending the fix for affected longterm trees 5.15 6.1 6.6 6.11.

thanks,
jirka


[1] 905415ff3ffb ("lib/buildid: harden build ID parsing logic")

