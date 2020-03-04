Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1DD1793F9
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 16:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388098AbgCDPsR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 10:48:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54852 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388094AbgCDPsB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 10:48:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id i9so2645516wml.4
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 07:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LRL6J9WKtvx/RPJ0atWk9n/5aR6bK+oJrTzd62kZy8U=;
        b=Ie8ZqTulx72jXcIilsU1d/WAVSGRYBCLfmfJux0wONI0NlvrKQ9Enw2cSDDGVsHmSU
         lVYjEsE+LZfyyPRfmG6NsHrFnMRoLf45pDyr8xuxkLLuVPPWwBFDc/7quKSaQnxJb1tH
         pPdtLx8zLfLFzNwYXT8e6srppXRhLdtZmK/Fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LRL6J9WKtvx/RPJ0atWk9n/5aR6bK+oJrTzd62kZy8U=;
        b=n7LHaDH5LbyQORuArGCNvpd1MRYMmxKLk9PfJBZs5Y90Dqz7H5jgVhJLgofFHiXzs2
         WnEemSMiHnVRGL7b6vo5ss3Xcts9jmYEAyIwAJQD6WEp+/p64Z68HNfjrYNQ83NINOCz
         rgPAnpCicVrV5AdKXmSTqnS7SB01kJFnFTTfAVpOVSwnE3dQyqLFUQNBmxzp5f9NGAff
         lot59zUx/4dY97iiKunEIUAaD7/AqbMU2RDGBeVYYjU/IfibYdY+StQKynbeU8pPK5Za
         nDw3smZPshazuT2II1LN1YPgbIlZKAUPuAUolwQXuslUbaYM8LDJGFyCLACMInZ95f9C
         eXxQ==
X-Gm-Message-State: ANhLgQ2lCznQexEWkhilT8DKgPgQIPGQFaToEfwNcApRzcqsL1jQmuhV
        BfTuxYXzR61mZmvnCKeQh9xR3Q==
X-Google-Smtp-Source: ADFU+vtGAQk6b9qNhtaeyie9qoPkeL44V/Y93fExB9w/SWb+vlwG17d+/ILecdmYCU41C5LszJwThw==
X-Received: by 2002:a1c:a5c2:: with SMTP id o185mr4094248wme.173.1583336879927;
        Wed, 04 Mar 2020 07:47:59 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:8ca0:6f80:af01:b24])
        by smtp.gmail.com with ESMTPSA id u25sm4816091wml.17.2020.03.04.07.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:47:59 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v3 5/7] tools/libbpf: Add support for BPF_MODIFY_RETURN
Date:   Wed,  4 Mar 2020 16:47:45 +0100
Message-Id: <20200304154747.23506-6-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304154747.23506-1-kpsingh@chromium.org>
References: <20200304154747.23506-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f8c4042e5855..223be01dc466 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6288,6 +6288,10 @@ static const struct bpf_sec_def section_defs[] = {
 		.expected_attach_type = BPF_TRACE_FENTRY,
 		.is_attach_btf = true,
 		.attach_fn = attach_trace),
+	SEC_DEF("fmod_ret/", TRACING,
+		.expected_attach_type = BPF_MODIFY_RETURN,
+		.is_attach_btf = true,
+		.attach_fn = attach_trace),
 	SEC_DEF("fexit/", TRACING,
 		.expected_attach_type = BPF_TRACE_FEXIT,
 		.is_attach_btf = true,
-- 
2.20.1

