Return-Path: <bpf+bounces-34377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C99892CED2
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 12:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309CB287E9B
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 10:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088B218FA35;
	Wed, 10 Jul 2024 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bL0BN0sR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bA4KwbV5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p0wzvfRu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HrqZ3W00"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5801B86F3;
	Wed, 10 Jul 2024 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720605929; cv=none; b=nfLGrQeAlxyt+QcD+5AS32Kp9U22CebL0zX9qpc1AE0dCCFe5BoaLhvk4rw+F+SCBeq+jQPbdqXhTe7ekASlSXuwANncnNkSfg9CGa+kyaDHvFpCZfawf9VaEoQK6HiVCzXiA9NyTsZ25q0ZQM6dSk43MM1vYhxG53ZfXF2M19g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720605929; c=relaxed/simple;
	bh=uZxAF7XgQqF1Sg+dYcymPO7TahFggn/RlM3shTrDiWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xyw4H+NvvvmIMz8UUrG7202NVA4oYGlJtvQXwspvorQNhu6mmtwosURHQu3XX2p4SQU1u8UqBJ+LU42j14LiS2Q6YurxA/1OcYby5a6SikfcCXMqLVx1dEfa5GutBl+oxHZ4/o9kAUkn6dqaqZyq708LoefOWr54bCjxtgv0ZRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bL0BN0sR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bA4KwbV5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p0wzvfRu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HrqZ3W00; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D03E11F822;
	Wed, 10 Jul 2024 10:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720605925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AtL6vijXehWhaAedbqt4n8Gq7UnfDWoxWKhwbH6Yqwk=;
	b=bL0BN0sRuIlV9IS0L05LSKrwq7oDelOmcW3+PTt+x9+MRo4rygeHpWwHZLULxE3+wNlPd6
	UBShK9bOcw7VoWU7qwTZmR1SzlipQjhmzHfM+ekciaXn+qP7zBauUsFQ3jBgW4Mtt45AN3
	NbNMfInkzzauz5WPBCorHfeuOkvARYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720605925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AtL6vijXehWhaAedbqt4n8Gq7UnfDWoxWKhwbH6Yqwk=;
	b=bA4KwbV5ZiSzKslzk8pXyDa/OnlZqcX/OQDNyJ4h4Hu8U+ra3pv/ij3vNg4fRkxzIrOeGq
	+FVl3yp+2QlQlmBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720605924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AtL6vijXehWhaAedbqt4n8Gq7UnfDWoxWKhwbH6Yqwk=;
	b=p0wzvfRuApLW/RWhWIId8cY0wJplKR83JTiPxLO9BAtB3uP5S54lEP/hzXFtXq4LBgVmLh
	CzwNgdmUGPyyYImxBu5dAcT81G3x0EneND412bYz76S6Yx9Axt1GVMxHLEAVnjOdCbIPNo
	qT/N056Jfw0INIeNMd1aI3bJAjWHt+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720605924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AtL6vijXehWhaAedbqt4n8Gq7UnfDWoxWKhwbH6Yqwk=;
	b=HrqZ3W00whQfH41bHoBlBwE0UbrpHyNdLYN4ECI4PHeUEHs+cAB4d2kk5wZuQ/Cu5Adamb
	AWApoCNm5VEG5kCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B478137D2;
	Wed, 10 Jul 2024 10:05:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A1iNJeRcjmbyZAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 10 Jul 2024 10:05:24 +0000
From: Vlastimil Babka <vbabka@suse.cz>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	javier.carrasco.cruz@gmail.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kent.overstreet@linux.dev,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	lists@nerdbynature.de,
	lstoakes@gmail.com,
	martin.lau@linux.dev,
	peter.ujfalusi@intel.com,
	regressions@lists.linux.dev,
	sdf@google.com,
	sheharyaar48@gmail.com,
	song@kernel.org,
	surenb@google.com,
	vbabka@suse.cz,
	yonghong.song@linux.dev
Subject: [PATCH for 6.10] bpf: fix order of args in call to bpf_map_kvcalloc
Date: Wed, 10 Jul 2024 12:05:22 +0200
Message-ID: <20240710100521.15061-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CAADnVQK_ftwe5Dxtc0bopeDg2ku=GrFYrMOUWHLnXaK1bqoXXA@mail.gmail.com>
References: <CAADnVQK_ftwe5Dxtc0bopeDg2ku=GrFYrMOUWHLnXaK1bqoXXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,gmail.com,google.com,linux.dev,nerdbynature.de,intel.com,lists.linux.dev,suse.cz];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 

From: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>

The original function call passed size of smap->bucket before the number of
buckets which raises the error 'calloc-transposed-args' on compilation.

Vlastimil Babka added:

The order of parameters can be traced back all the way to 6ac99e8f23d4
("bpf: Introduce bpf sk local storage") accross several refactorings,
and that's why the commit is used as a Fixes: tag.

In v6.10-rc1, a different commit 2c321f3f70bc ("mm: change inlined
allocation helpers to account at the call site") however exposed the
order of args in a way that gcc-14 has enough visibility to start
warning about it, because (in !CONFIG_MEMCG case) bpf_map_kvcalloc is
then a macro alias for kvcalloc instead of a static inline wrapper.

To sum up the warning happens when the following conditions are all met:

- gcc-14 is used (didn't see it with gcc-13)
- commit 2c321f3f70bc is present
- CONFIG_MEMCG is not enabled in .config
- CONFIG_WERROR turns this from a compiler warning to error

Fixes: 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage")
Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/bpf/bpf_local_storage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 976cb258a0ed..c938dea5ddbf 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -782,8 +782,8 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 	nbuckets = max_t(u32, 2, nbuckets);
 	smap->bucket_log = ilog2(nbuckets);
 
-	smap->buckets = bpf_map_kvcalloc(&smap->map, sizeof(*smap->buckets),
-					 nbuckets, GFP_USER | __GFP_NOWARN);
+	smap->buckets = bpf_map_kvcalloc(&smap->map, nbuckets,
+					 sizeof(*smap->buckets), GFP_USER | __GFP_NOWARN);
 	if (!smap->buckets) {
 		err = -ENOMEM;
 		goto free_smap;
-- 
2.45.2


