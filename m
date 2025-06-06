Return-Path: <bpf+bounces-59933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 260A8AD0949
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39073B57C7
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAAD21E087;
	Fri,  6 Jun 2025 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IidUs6n0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6901C21FF24
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749243877; cv=none; b=Pak2CStiu8tdh2h6RkVK7wzIim8Vagavz8h2qrTSlw1HsO7kyBqFo3xhDj5FmTDYx6KCEsQYV04xqYLrYoi4JFJ59/5rAJQ9PQtVDNIUO0CsJB/fabw7vR8aOfhOqJVokbTUUiHX2FAvWgEgvq4cba3HXbS6HBvpEGesyZimVmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749243877; c=relaxed/simple;
	bh=9RDxEFeACC8CBfZNCIqnCQDPLojhGd5ZrCykiRo8NbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0AUu4oESrru+G1FCu8b9PWzksyhrBFzWMdgCXOWFlqmIqb+AEhD8E34bcVq8phAGBp2r97UajDBvPY/x1J7rxy4MFJon/FcJXoOqaoPqTFUZHUHrLK0s41c+PnpGGcV9NFfN2RuZB/3IUsXz3RhEJO5sNKhOyBJIDnir9aWLAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IidUs6n0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso2933324b3a.2
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 14:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749243875; x=1749848675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzkQVkVSz1gMCZum13XMmjKTDbcZ73sK1u3ZpgfF2yk=;
        b=IidUs6n0OwFQ/uYv5Lgic5c4ADX+JJ074FKHtH0On3L98RfZD27W4evMzviJfl2afw
         S6t9ouwOgLhkXJh+5MlMHjtcIAJNF0ybZEDBmUdFUNOFpsj6QHu5lcQCGgBoKzAurNMY
         OjrKt6c8gE+dBU7ooO6MtsJPX6Z4UgcpV0B5k0sAh2FKN5Q+/hgn2W4LlYY7J+dDWwfR
         q3OPMLuRsZea1DSf2eZtqCuvjcHJHXD0jgfHy+BQUlQywgov8nsJNon9yXuDBACgDZoC
         uq9n/HKDD3lZW9XmKMRcvIn6tvOR8emJHfL5qTgAtWRUqYVSBDzy9eV7nzBi2zxCYbZL
         E0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749243875; x=1749848675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzkQVkVSz1gMCZum13XMmjKTDbcZ73sK1u3ZpgfF2yk=;
        b=xNEQn+EyBGP5PDQBJUh9d6fUooOkxFmiFQ36u8UVdIQkjuckaPrbuSWFqjXya3xXxt
         sNgbN1f6nKe3CbOF2Zbg0rM+ShuNX+sZCyhWQUb6j31NLXQURjPVmdEc27ix0Up8sJfT
         ueGmtRw5+QSRfNAFVOkNmTrZoxhczvfr+ODr8P5f0H8itRpwlz1e0XwLkJcCrynswL5V
         uS75EIy4R+6Dt8keLCxxOvBdTbF0P5D69Nyg+XhagBsdNMMKfvXYx+QzrM7p7HfvvdY4
         JVhF8Ax95/3PTyL3xw3U8f6Xikc3mU5UjoDhWL64xQQpyupMKwdXOQ8dIGsGrYRWkMX/
         TwpA==
X-Gm-Message-State: AOJu0YzkkoeCL5wJ5KtezPCWeURBi04QoGRqBkkltRPcPjb7fuXu4yrt
	Hm9+ZPkbULcTIuTNI990KYznOuPKeCtaRac/TlHrGtZCOD3zdcu1Wg0xMUqVryRk
X-Gm-Gg: ASbGncuTh7ck2WVtdK5BGtJInIv3jKl8PpgKHuKCltyF727lmHZVKH2gsuRF9BjFaR6
	SBVaxgX+2ZjJ0RYSTRX2K9D3gKL2Kgm0sh62csk57bFIwiIwK4puBVRe+s6PRmngSMxPhP/Tne3
	esjvmL7HnGSe78OzHphgzfMlK9Qc7HmBi1nBOrs4HV/fidY50NEi/tVmMpc+7mBds3rxtyr7VPf
	DTmhfGDtX8UAfFZ9brqmVtduMC5KEUid0RsyZk+sh3gF4RIkLMj5p2fQvNxB42uue2p8tHSzQgB
	r2qwCsOAnoTZKL9lWdAaqtOmRaU9MOtBIVHbafUOAOCifKuxrz0OV/OnXw==
X-Google-Smtp-Source: AGHT+IHUL4/Tujup7IG5L6uWdNS2HaCgTZyy/q00MSvEmDg4fg2Q3hm0NlGgC9nilufRiMvqsHMk5Q==
X-Received: by 2002:a05:6a21:2d4c:b0:215:f519:e2dc with SMTP id adf61e73a8af0-21ee68a460amr7066141637.14.1749243875551;
        Fri, 06 Jun 2025 14:04:35 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5ed58beasm1352640a12.15.2025.06.06.14.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 14:04:35 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 07/11] bpf: move REG_LIVE_DONE check to clean_live_states()
Date: Fri,  6 Jun 2025 14:03:48 -0700
Message-ID: <20250606210352.1692944-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606210352.1692944-1-eddyz87@gmail.com>
References: <20250606210352.1692944-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next patch would add some relatively heavy-weight operation to
clean_live_states(), this operation can be skipped if REG_LIVE_DONE
is set. Move the check from clean_verifier_state() to
clean_verifier_state() as a small refactoring commit.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8e2062e38307..4dd95f34f7fd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18290,10 +18290,6 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
 {
 	int i;
 
-	if (st->frame[0]->regs[0].live & REG_LIVE_DONE)
-		/* all regs in this state in all frames were already marked */
-		return;
-
 	for (i = 0; i <= st->curframe; i++)
 		clean_func_state(env, st->frame[i]);
 }
@@ -18348,6 +18344,9 @@ static void clean_live_states(struct bpf_verifier_env *env, int insn,
 		if (sl->state.insn_idx != insn ||
 		    !same_callsites(&sl->state, cur))
 			continue;
+		if (sl->state.frame[0]->regs[0].live & REG_LIVE_DONE)
+			/* all regs in this state in all frames were already marked */
+			continue;
 		clean_verifier_state(env, &sl->state);
 	}
 }
-- 
2.48.1


