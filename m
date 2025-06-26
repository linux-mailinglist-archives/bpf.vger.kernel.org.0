Return-Path: <bpf+bounces-61683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F995AEA332
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 18:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D041C45075
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE971F0E26;
	Thu, 26 Jun 2025 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lc1cVhrg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD0E8632C
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750954064; cv=none; b=axioOrmRm1QPFKtalCqQwE9iHw2yuQb1JcXyfBD030iruzhnrRnBVBFpp+YgVeZNYuDFhbbu/lP6BO+kuYT2qozT1QoS0WCopMkmPx268ToNcFY10hcaDYwfasoKcuFysPP1REcocanh620LU5C/MNV6tJzIVC61YxbqkOqviJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750954064; c=relaxed/simple;
	bh=hTsUMYbYaWIspEm5SbV/DSPAsg/4bjygT+9P2vF4OyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFW5cjUQ48/zDHob25Muvi7sHn3mzqn2Zpr5xoFpqoE0CbEdak8NvBUUvJMX/9Ltopj2Bqe8h0ycP/axVvS9gGkkQK7jawzlhV9VY6nIcs/1UnsMUDNvifeAy9eHh3VuhVD7m7sXgRVUShT9YdHFUpGk065nPwonsyQNBTi7uQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lc1cVhrg; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a365a6804eso762258f8f.3
        for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750954060; x=1751558860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/rmFhKP/Kog47IU05v1nVpPXPNRAqnkX370h+r5lyKg=;
        b=Lc1cVhrgJ/Qx1x+e8fgYyDh3v0wprd0jFhFo8ocA3ryJN0JD+e5PSUyyYFa98DA+1I
         UlRHOZlG/S1ho4OyNQRjtVwg7X5KrXK6QIJ6VPMEzaEgkfPphrzDrcCqDlKqr2NZUjjl
         dkGw66eOzZ92oEEOXCuvkEqGJyrC9iTAD5LbWSvOULutLN8X9FB6oz0TMXy9nOatM/nf
         FxmGhDxOzAeIeUFLLCKls81ZP4xeuJBs/7Ekv1rQLAYRweRiwsVVsOTgK45GVyaYxRy9
         rkVydbx5MOEQnVaqmpw7HuehfZj9tvwnbKisX0IPZKNqUwiLiWLFUtcb1PKGfqMZDDGG
         mUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750954060; x=1751558860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rmFhKP/Kog47IU05v1nVpPXPNRAqnkX370h+r5lyKg=;
        b=q8D0ulskug8vDpc7hiyCHxwqyEgczOI4EmABbSPdElfxXVSuNdYxbCuwq+Xb4wS21k
         eUjnQH/3L3CxZvtHwIUjepZ/2w0qXrUi3wP+ktEBFNlrAc9lMJOz6GwWQSqCLhYNRTFh
         P2+DuuSLpFXakYXyqJpPw+N7l0MWJiGkHaYNvnXh1V5GG7hnujFo/Kp+re1BUO3fhTIs
         CyLNcTaDIb+d6bR3sClnCg3GWcq+C66wB2LvsVIW3dx8g8OkfSe5dZRQHr4f8Yit/61c
         V8LMWwmM1+QmYq7LZe3lSHnvImwgnEgHoL93jJThlUmmjstZB1yEhsdDYWAQKQedvDvw
         0aIw==
X-Gm-Message-State: AOJu0Yz9VEjcHwOxHV/hGPyAYM0xMgqEwW1X6KY1wqMy9rKRAG2Sc8KM
	62Vu2RmaV5oMptE499boiR1fhj7KAIScHJ7Jc60eA1gmGFpqPpnKIHw0SyYzsg/o
X-Gm-Gg: ASbGncuEK2kHbvt7e48MNkahJLJuPyOsKFL5nJDTlDhA8nmQKZ5xqz5LHTKyv8ve5va
	VuGRzTE6YyMrQnxUZQIMlhX5dRTpV24T6hOpGVCDW51bUTYtvjn0WcHFKDKpewzWeApgZOuTlmd
	uFqrw8uSH8oRldsFWioewqH9TqeSGRFCUdqJ3Z9zvkts6YIMkrs6OxV4rXTZYD2GrQ4jMaXH8Jt
	Swjs7pmZ8yQT+HTW2R7EbxndD6Ij/rbdRLChbvBdCWzwxwdvHh0ZvC/YXrOLNlOchwWZtNM+p+O
	r1hptv+ad/+o/Dm7dtxUbm/gWM/NJn7PpsOSTAp39gwrnTBceYw5Q/Qc6MoFfsAaL+swb+vTmkN
	JHp2FANeNu+AE7WD2gztC74awGEGKgzRvAM8L91gVm7391C+LGEMhzlNUlmoiPQ==
X-Google-Smtp-Source: AGHT+IHxbf4HsdCG5BuklKAo9KekI3OvIYmJoSk/gRuben6CT3wlUpMJljnDp2FmBFn0nCgUbj+2Uw==
X-Received: by 2002:a05:6000:2806:b0:3a5:2d42:aa23 with SMTP id ffacd0b85a97d-3a8fe5b33e2mr54685f8f.22.1750954060321;
        Thu, 26 Jun 2025 09:07:40 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00ba828d421a4aa7ad.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:ba82:8d42:1a4a:a7ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e6f8bsm286398f8f.17.2025.06.26.09.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 09:07:38 -0700 (PDT)
Date: Thu, 26 Jun 2025 18:07:37 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Florent Revest <revest@chromium.org>
Subject: [PATCH bpf 2/2] selftests/bpf: Add negative test cases for snprintf
Message-ID: <30ed8c0add8d08c22cec95f302d85d2e4a2dd760.1750953849.git.paul.chaignon@gmail.com>
References: <9d7c0974af8ab9b99723bd3f72d4bea8972d7cb5.1750953849.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d7c0974af8ab9b99723bd3f72d4bea8972d7cb5.1750953849.git.paul.chaignon@gmail.com>

This patch adds a couple negative test cases with a trailing % at the
end of the format string.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/snprintf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
index 4be6fdb78c6a..594441acb707 100644
--- a/tools/testing/selftests/bpf/prog_tests/snprintf.c
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
@@ -116,6 +116,8 @@ static void test_snprintf_negative(void)
 	ASSERT_ERR(load_single_snprintf("%llc"), "invalid specifier 7");
 	ASSERT_ERR(load_single_snprintf("\x80"), "non ascii character");
 	ASSERT_ERR(load_single_snprintf("\x1"), "non printable character");
+	ASSERT_ERR(load_single_snprintf("%p%"), "invalid specifier 8");
+	ASSERT_ERR(load_single_snprintf("%s%"), "invalid specifier 9");
 }
 
 void test_snprintf(void)
-- 
2.43.0


