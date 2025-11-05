Return-Path: <bpf+bounces-73601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF86FC34AF4
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 10:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A59188549B
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 09:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCCC2FABE0;
	Wed,  5 Nov 2025 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1uXJvNXZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k+qtCPEX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1uXJvNXZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k+qtCPEX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543322F90EA
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333540; cv=none; b=L4KkAS8MhXpsQt7TcaYtRawMxiXjagm0yFiqj0Wbubf2G8tzIrVeXp0ir57JwNqJdBdM7rXY9VvILb3sBBqRt4NToikCOM+4ykf1f6bHOydUIpDSei2FtI9WUW0JN+o2GQsESL46RfdUlNPo1W2VASa4pZBqpNwE+gcVoxXBdbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333540; c=relaxed/simple;
	bh=ynsInv72KCrJOMM25HW1n8/JTg5KjET+30hEo7AnAb0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ip2/jxBkH6KmCXv2I5wEFs4EGEDrpz5INUZuamc77/6Ut7X2sRyq5MY44NCbWkNTAC0nMOLGhzD8ACcdKAOWn/S94/tGo+f9GdY4SZYuwpduQ9GJokPVjCLGrKjVPerUCuD3JeMhxVJASi3uQPUE/JWF0YoCAP9A+nKmKwJthFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1uXJvNXZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k+qtCPEX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1uXJvNXZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k+qtCPEX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 93B981F451;
	Wed,  5 Nov 2025 09:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762333530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s7exJ7wPrvcdkgXiFEjvbZXYLs/HVJlgsx8rLBAN5tA=;
	b=1uXJvNXZ0oeWJolUamZsclQYWLhgjDV2VIcl2AbOW1bAUFeGvdxMpEVBuNcw4NTnuvG3Aa
	RhKnLdmaTkC4ixvPeVjbewnh9hT25WTqG8WZ1JfvPljMRZeUoPUty2LqHMT0WHor9+R26P
	jkTNLr8+2bVcEk/tU0+/zSgC8wKF9Ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762333530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s7exJ7wPrvcdkgXiFEjvbZXYLs/HVJlgsx8rLBAN5tA=;
	b=k+qtCPEXLrLalvmr4cJJ973ilPbmBHT5tcP6DvcOr1rLdx5y8YfS3QXNGkh9OqHuzFvUCe
	zoE+w0eay0C+A+Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1uXJvNXZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=k+qtCPEX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762333530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s7exJ7wPrvcdkgXiFEjvbZXYLs/HVJlgsx8rLBAN5tA=;
	b=1uXJvNXZ0oeWJolUamZsclQYWLhgjDV2VIcl2AbOW1bAUFeGvdxMpEVBuNcw4NTnuvG3Aa
	RhKnLdmaTkC4ixvPeVjbewnh9hT25WTqG8WZ1JfvPljMRZeUoPUty2LqHMT0WHor9+R26P
	jkTNLr8+2bVcEk/tU0+/zSgC8wKF9Ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762333530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s7exJ7wPrvcdkgXiFEjvbZXYLs/HVJlgsx8rLBAN5tA=;
	b=k+qtCPEXLrLalvmr4cJJ973ilPbmBHT5tcP6DvcOr1rLdx5y8YfS3QXNGkh9OqHuzFvUCe
	zoE+w0eay0C+A+Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EBB8132DD;
	Wed,  5 Nov 2025 09:05:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tOG2GloTC2lSBAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 05 Nov 2025 09:05:30 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 0/5] slab: preparatory cleanups before adding sheaves to
 all caches
Date: Wed, 05 Nov 2025 10:05:28 +0100
Message-Id: <20251105-sheaves-cleanups-v1-0-b8218e1ac7ef@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFgTC2kC/x3MTQqAIBBA4avErBM0sr+rRAvRsQbCwiEJxLsnL
 b/FexkYIyHD0mSImIjpChWqbcAeJuwoyFVDJzutlNSCDzQJWdgTTXhuFrqfvB9GJ+fZQc3uiJ7
 ef7lupXzrHx/cYgAAAA==
X-Change-ID: 20251105-sheaves-cleanups-548ff67d099d
To: Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Suren Baghdasaryan <surenb@google.com>, Alexei Starovoitov <ast@kernel.org>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 kasan-dev@googlegroups.com, Vlastimil Babka <vbabka@suse.cz>
Cc: Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Dmitry Vyukov <dvyukov@google.com>
X-Mailer: b4 0.14.3
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 93B981F451
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

These patches are separated from the RFC [1] since that needs more work
and 6.19 would be unrelistic for the whole series at this point. This
subset should be safe to land, improve the codebase on its own and make
the followup smaller.

Patch "slab: make __slab_free() more clear" is a new one based on review
of one of the RFC patches where __slab_free() was found rather tricky.

Git branch: https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=b4/sheaves-cleanups

[1] https://patch.msgid.link/20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Vlastimil Babka (5):
      slab: make __slab_free() more clear
      slab: move kfence_alloc() out of internal bulk alloc
      slab: handle pfmemalloc slabs properly with sheaves
      slub: remove CONFIG_SLUB_TINY specific code paths
      slab: prevent recursive kmalloc() in alloc_empty_sheaf()

 include/linux/gfp_types.h |   6 -
 mm/slab.h                 |   2 -
 mm/slub.c                 | 318 ++++++++++++++++++++++++----------------------
 3 files changed, 166 insertions(+), 160 deletions(-)
---
base-commit: 136fe0cba6aca506f116f7cbd41ce1891d17fa85
change-id: 20251105-sheaves-cleanups-548ff67d099d

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


