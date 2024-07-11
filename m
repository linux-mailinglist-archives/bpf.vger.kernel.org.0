Return-Path: <bpf+bounces-34581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 395AA92ECD6
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 18:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9581C21C40
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 16:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C066D16D4C5;
	Thu, 11 Jul 2024 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tRudBEpm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yuI+Sj6f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tRudBEpm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yuI+Sj6f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778F116D312;
	Thu, 11 Jul 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715751; cv=none; b=qnAYWFrxwfS7GcC1+t6jidgixpHuicbHZf4GUxlro78c+8OTu7FrAp2jKmFrYFkLJTRlJvxWm//mcL9VC4LI9hca3gHRZAhKJw6J+LtItWtbDUDFou93C0XBoZy5DVfx5UFJIMD9DEx3I/UK70eXAm9dbepVGoMNi8KVn9xb94E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715751; c=relaxed/simple;
	bh=WuuKCyDw0yQFRmVX+tagmwlSGJzk5TMRGPBwaeHhQKY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s8lbbIY63Ee2Gdfo2FsWBZmgpTaZk5MWr7K8cPF7AHbZ93QFDe2tQyAFc1IT7GLP2BPclODy9utI5IbNEaqsfRzNx3N4IMvzYsmlW+Xbt7ft2oBakgxHIlOBZ0v/l4xqtCYSlWgxwVNGOwprZnNJd+VBKy0wA+gX6fuzlSXVPb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tRudBEpm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yuI+Sj6f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tRudBEpm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yuI+Sj6f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8CD6021BD4;
	Thu, 11 Jul 2024 16:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720715747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nlW4wvqPrPuw3LFNzjQ8J1N+uWec7sUMrxbYGJfRp84=;
	b=tRudBEpm0/hJNAikX4ahQGKuwAtwM59s/n3MZy3Wu1xuH7oAvEte8M2IA9V/FPykfWbxzp
	5A7H/OoGYzIEQXwyz9GD7RuNzM/t8yrrUT5vnFTD7gVlGw5XQ6konEGYoYYSyKAIuHZfpP
	NKmweaUKNHawjrtyIainEQld+0CI0tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720715747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nlW4wvqPrPuw3LFNzjQ8J1N+uWec7sUMrxbYGJfRp84=;
	b=yuI+Sj6f7t8DstG8fIngBUEeqiE/b9S7WFrkHowZpq4/01YI3Skir2zfCNT/Z9vA2N79sX
	uTOtDxkWSDHawJCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720715747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nlW4wvqPrPuw3LFNzjQ8J1N+uWec7sUMrxbYGJfRp84=;
	b=tRudBEpm0/hJNAikX4ahQGKuwAtwM59s/n3MZy3Wu1xuH7oAvEte8M2IA9V/FPykfWbxzp
	5A7H/OoGYzIEQXwyz9GD7RuNzM/t8yrrUT5vnFTD7gVlGw5XQ6konEGYoYYSyKAIuHZfpP
	NKmweaUKNHawjrtyIainEQld+0CI0tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720715747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nlW4wvqPrPuw3LFNzjQ8J1N+uWec7sUMrxbYGJfRp84=;
	b=yuI+Sj6f7t8DstG8fIngBUEeqiE/b9S7WFrkHowZpq4/01YI3Skir2zfCNT/Z9vA2N79sX
	uTOtDxkWSDHawJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63CBB136AF;
	Thu, 11 Jul 2024 16:35:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qVbHF+MJkGa0NwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 11 Jul 2024 16:35:47 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 0/2] revert unconditional slab and page allocator fault
 injection calls
Date: Thu, 11 Jul 2024 18:35:29 +0200
Message-Id: <20240711-b4-fault-injection-reverts-v1-0-9e2651945d68@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANIJkGYC/x2MzQqDMBAGX0X27EISYou+injw50u7pURJYhHEd
 3fpcWBmTspIgkxddVLCT7KsUcHWFc3vMb7AsiiTM86bp7U8eQ7j/i0s8YO5qM7aIZXM8ItpWzy
 cCQ3pYEsIcvzn/XBdN7ldItxsAAAA
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, 
 Akinobu Mita <akinobu.mita@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Christoph Lameter <cl@linux.com>, 
 David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1987; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=WuuKCyDw0yQFRmVX+tagmwlSGJzk5TMRGPBwaeHhQKY=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBmkAnazeXPb+JooODfX5LqRxRE14MV4gsWNWzrc
 XZaraZTQ26JATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZpAJ2gAKCRC74LB10kWI
 mmC3B/9qaYKMzEKQ94Ky/6rRRigMSfXfhKTjrCG5SiXZcEn1l0dIkbTOgpSuzczRyjaPoWmUvqv
 3SHrVsqsL+Q4FCJXQdoxNShSlnFUEQ6E3OGrdh0tZ8699tFIWEIbBZDWmuwC19VhNXz9b6ZIY1v
 ab7u7CJ4IjusmXbs0Ag3ezyOuHlYFouUS1RoXnu8tUjF/zbPXq5YpmHKdo67FDy+PLeYtT0pXtm
 Y7l3NraB5T3zlq3HIib2EvSEUeFxDOUrUS69O/KpiwL4EbBhyfdruY0pzvK01mLcRrGIYTTTvmO
 Cm2F/b4/6bWuQRaa7hTu8bLrw/gQ4U4kyta7H8wLAFoNQU7x
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,fomichev.me,google.com,linux.com,vger.kernel.org,kvack.org,suse.cz];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

These two patches largely revert commits that added function call
overhead into slab and page allocation hotpaths and that cannot be
currently disabled even though related CONFIG_ options do exist.

A much more involved solution that can keep the callsites always
existing but hidden behind a static key if unused, is possible [1] and
can be pursued by anyone who believes it's necessary. Meanwhile the fact
the should_failslab() error injection is already not functional on
kernels built with current gcc without anyone noticing [2], and lukewarm
response to [1] suggests the need is not there. I believe it will be
more fair to have the state after this series as a baseline for possible
further optimisation, instead of the unconditional overhead.

For example a possible compromise for anyone who's fine with an empty
function call overhead but not the full CONFIG_FAILSLAB /
CONFIG_FAIL_PAGE_ALLOC overhead is to reuse patch 1 from [1] but insert
a static key check only inside should_failslab() and
should_fail_alloc_page() before performing the more expensive checks.

[1] https://lore.kernel.org/all/20240620-fault-injection-statickeys-v2-0-e23947d3d84b@suse.cz/#t
[2] https://github.com/bpftrace/bpftrace/issues/3258

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Vlastimil Babka (2):
      mm, slab: put should_failslab() back behind CONFIG_SHOULD_FAILSLAB
      mm, page_alloc: put should_fail_alloc_page() back behing CONFIG_FAIL_PAGE_ALLOC

 include/linux/fault-inject.h | 11 ++++-------
 kernel/bpf/verifier.c        |  4 ++++
 mm/fail_page_alloc.c         |  4 +++-
 mm/failslab.c                | 14 ++++++++------
 mm/page_alloc.c              |  6 ------
 mm/slub.c                    |  8 --------
 6 files changed, 19 insertions(+), 28 deletions(-)
---
base-commit: 256abd8e550ce977b728be79a74e1729438b4948
change-id: 20240711-b4-fault-injection-reverts-e4d099e620f5

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


