Return-Path: <bpf+bounces-29386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D08678C1B30
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E41D1C20C5A
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136964400;
	Fri, 10 May 2024 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PCJYiUWS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E711013B28F
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299881; cv=none; b=Pm5TYNhBrBLcl/H21wg4xJiQEy0M1ZcdlhxZR60CoYqvUZXPUjtQgdBkRBgfsPPrtghrxsSH4luSMRbQn0H7oGfQNNP/S6YURLXLBZGUPr2gTfUMLFQpWRUsMUL+TMaxoPEU68hw6k5B9fvIcIHX13O4EaQe6YEvY3MfHma9ENw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299881; c=relaxed/simple;
	bh=9SdZLXa8bOO8qqRm4M0qIy9O0gsnXY10oXqx9sqJBYg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZzO1/OCSXhm406eB7ABYCQJ00MSLMNm8F7vkaXEwQCdS5RWPjDxTDOoOxotW/32BLEQdUUq8ioK5UkTLnC1N5pH8PYbwwIu3gvFvha/MQ2w+HYfk+Ll8OaAyo4Hga/uWGwgWXIZBrgrBsFzle60jqplcJgicjAyxdIHiuXSPOa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PCJYiUWS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so2310115276.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299879; x=1715904679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsiI/uc5MiF5hVrzWysDwKaH6OKN5b01GtVR6T+4Ou8=;
        b=PCJYiUWSDKcZ7b5ZTRYxoRuPu/wGXUWBBoDIoAQEhfLfpWGNfAL5JmkKv+ETj7xx7F
         eLkIMY/AKbqCiSngQU8h4CHQZFFaJx9dcTVvoMN6zWTmX6VjHYsTHGpG3hIgVgJv2Y3H
         Z815kk50HeJORYz0zX64evgkNwNF8iMunDDC+H5zdlONOj3vnKVEL+nkj5BCIsTtnEZU
         W5DRXsgZAiIP6iXmYV4z9dcwRHvlnvnXHq570loyl2/ydNnX4w5UpyrnHhKGbVl1PwLP
         vacZMjN+tRWZ6ddnm/hO92Yn5oja6EixJtkE4xbFL0G9xn3RNqgMYrbUo1KI7g4kTZPf
         UpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299879; x=1715904679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsiI/uc5MiF5hVrzWysDwKaH6OKN5b01GtVR6T+4Ou8=;
        b=q/+6NDdLX11YoFr1cXU49zYcQmZv1WKG39vlw10o9VkzJ3OiRAfIYtc0s9jQJJ+SWS
         sy5MyVYk2e8zUk67RaGGMpkm+qvKIGOWwZf0UthrEtcHcf4hfeSUCqk8S+fepJOMm+DY
         2INClnPXBRIuq0foC3drgW60zIkAOUpMz6XwdqmcZqhwFHFJkYRjcQd7IKQM69RfA/1O
         e/XvMeQTYufIT9Zgx/WgpKlHg4r0rWjT2C5caQ6Bshce20ZHNO3upQ5iEGkPD6ieKRpv
         2ftAZ16rpby8AyPj0q17MSPFYPLyKNYjHcPPJWyYUV9BOv+I0yZV+I2cfkKGP23gXxCV
         oK1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUA08T2i/sTP2z/eJHrR65Em6oQ4N2PPPLO2Xqlmf+CLuEUxETv1AER1AK+GYW6rmwwKhKTvOG0C/GZmLKpm+5Mcg7O
X-Gm-Message-State: AOJu0YyPeicmL2KupVaq9CkM3x4/ApyWT8Rc7vMrk93w+HW4RXtHIe6g
	WybXmOu+QU3EoEPOaHEOiSmUPvlGUZLIBDTauRpIj6Zb2eJyrqAMG6S2Z9s7G4x+R6ykCHKwOTe
	/QQ==
X-Google-Smtp-Source: AGHT+IE5lK4O5tKmIABh+/0fZfzUGpesvK3r0yQsigzHVYkbLRrBgnWaOZUctD25gmyF5UaK8CUOK4LhdqQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:a1e3:0:b0:dda:d7cf:5c2c with SMTP id
 3f1490d57ef6-dee4f365eb8mr105581276.13.1715299878998; Thu, 09 May 2024
 17:11:18 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:02 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-46-edliaw@google.com>
Subject: [PATCH v4 45/66] selftests/proc: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/proc/proc-empty-vm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index 56198d4ca2bf..f92a8dce58cf 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -23,9 +23,6 @@
  *	/proc/${pid}/smaps
  *	/proc/${pid}/smaps_rollup
  */
-#undef _GNU_SOURCE
-#define _GNU_SOURCE
-
 #undef NDEBUG
 #include <assert.h>
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog


