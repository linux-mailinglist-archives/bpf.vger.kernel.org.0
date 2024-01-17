Return-Path: <bpf+bounces-19717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01778830290
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 10:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28BA21C20B76
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 09:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E1B14017;
	Wed, 17 Jan 2024 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGxWK8ZG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D4814003;
	Wed, 17 Jan 2024 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484669; cv=none; b=CVwfnDNYhnxisLnLw6mYWvU0fgKI32Y6Kdg5Tnk9CM+YvX1ybUxKq0QoFkBn4D7ohYlntOvu6LOnqh0vRa13GUTmfUt6qiyqkv8goQwAQ/aCPLJDQgBv5YJFUh9cxmL/0SSr7Nmczi4LuasUg5DsvR2LpjY3gqR5SuHXEKhx3Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484669; c=relaxed/simple;
	bh=koLUw5PeugBWM5vujimBWXbc9EkNHNfpYO9OrJuNLbk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=SmVDKApeBoSIxuJGWyGk9Cwr+NHcS4e80GBiQ6F17dhHi79tN6ixB6jc8RfrUx9a9gvSUt6HHmc3MSplh9aNTU4Ldpmh/axao9N6J1pQQqnrRpMRVX7yDulSxOP/aAQt8mVJwqUsyFLKXmUsNjpzezlb5Ua4ChiBI8ClQX8rbzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGxWK8ZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC58DC433C7;
	Wed, 17 Jan 2024 09:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705484669;
	bh=koLUw5PeugBWM5vujimBWXbc9EkNHNfpYO9OrJuNLbk=;
	h=From:To:Cc:Subject:Date:From;
	b=oGxWK8ZGO0jlw1vW7zxxTSaUQ5FHV3M7zF96KAjY4a09ddQM85W9ivTzWaRqAtrCS
	 7dZ+kxhhaN08xaOzG2tA2n4cn96GSzIhPLJZ7UF3yNdeRNWWMDKUG46UX1E2U8713+
	 t1ik9t8evFA7oXYiTI6xlL7gaeSLWWhW1c2OC+V1ZC9WEJkkZkw0HpmNLUQrKX3p2k
	 7ppnGrQXQMpo5lCqtihqTWSVTSeRkm3tajNpwDcbyS0Mg/YwobL83nV/RtusaOLNvm
	 84DryXjaef3LhWR3/BlQzVcam3qZHOOPcC27ymGQGrPl3YHQPVVUA3aB3HmEYTPE4k
	 25nQHhyOk0+kA==
From: Jiri Olsa <jolsa@kernel.org>
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH stable 6.1 0/2] btf, scripts: Update pahole options
Date: Wed, 17 Jan 2024 10:44:22 +0100
Message-ID: <20240117094424.487462-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
we need to be able to use latest pahole options for 6.1 kernels,
updating the scripts/pahole-flags.sh with that (clean backports).

thanks,
jirka


---
Alan Maguire (1):
      bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25

Martin Rodriguez Reboredo (1):
      btf, scripts: Exclude Rust CUs with pahole

 init/Kconfig            | 2 +-
 lib/Kconfig.debug       | 9 +++++++++
 scripts/pahole-flags.sh | 7 +++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

