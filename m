Return-Path: <bpf+bounces-29395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C548C1B62
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36379B21BF7
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2512C13D61A;
	Fri, 10 May 2024 00:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2O/3TEDZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5383013D61E
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299902; cv=none; b=a8rczd34d2aV9KWv5nGo9eioFxCPWdlxXPFFWfMiZp4VXCVEHp8hNDIt2lRlUAMy53qPz/2gglZXf4Wfb7drKlWI0DldbLg1gxIRTwPdsNj2QK5vsWlPNmew6ilNXjRTJio076+8wJfcB/ua4S1LeYxP4vJuldUPF5D2QmW0NwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299902; c=relaxed/simple;
	bh=o1RhdjMiUDI1d5/m2/oPrCmWUS9LNz8Vqul/ZnNfbV8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lvOv7FP8HkNSMVXl3jRYeXs7HF/wFuWd/decYwPRM2Vu/7i0R8VREIqfLAqG331ftk+01zxWHtmsgBQRbeix7IJHhbDNqxYLMeiowwlemEQVO9tevFCt0Mnea5K6wXNqo682YFdwFJWc7OItgwU0Gs89LaiWsJ51PRXKVD2dUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2O/3TEDZ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b4330e57b6so1347922a91.2
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299901; x=1715904701; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GEXQmokrWI+eGSugaFt5D0Texu6UPbeRbKfQ1EoEEI0=;
        b=2O/3TEDZ9DYWlZbwvbsdj+3zg0fxR4wwSLvSsmbiKBsdTnH+B0KQb78wlyDa7xfeQz
         92B3WyvYou+wprDpPy2tvn3OMG9+9LUQH1K0RAvGS0suXuHtJTE2O4ExJD5YUfQ9u/Wk
         YnQFq9y97pplpzlAJmop8vH7lYhYQz/Z+rOkhNL7hkzrCxQKmcxxLoeuCJALfc/U4afR
         fNZ6AYX3MZc3zCBxQtyb2fwMq1a5VKsNDhPcLHB1GvigQ2rGKMlzmHUi2F947Mcdl6w/
         kx+OqJbiZPXChDZmKuuVe75henekjvWnHK30LXY1BUra6+OywRhz6VgG3sz0wx2hdd/k
         j3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299901; x=1715904701;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GEXQmokrWI+eGSugaFt5D0Texu6UPbeRbKfQ1EoEEI0=;
        b=xJ15EJirQtdTMo6mEhqQmpZW5fomucK7p4piMvzxULuoU4DXYfIonnu8XrQPNutBo8
         W3XJsEML+w7nBxtvFewHfr1dYcjPrTV8yH9O6Qx5RL+E0rOcodSifJOr4Vn+BhIQyywP
         Ttr/SndxMARxDrtnUaSyc22MGC93NFGoG9RDaxkUBeYjTbxmfVhyvPr84aQOwmQHhyUV
         8kzVJ5XHF2Qd+2/pHSdGmvinnViPVLlth6LbD3LWi9VhKchPMeQm3LeR4A3MXe+o3IF0
         4Gn3rQ52iW87V/eUIw0ebpfVm7yv8f8IAVscZgo2p9vbJiSshY5wtPeDQpXtMREjXSnw
         vAYw==
X-Forwarded-Encrypted: i=1; AJvYcCVERu2T4PUZMTfuDI/xJrh48p5qLF6wcJ63fZ66g3VeKiATanNU+4W43X7rIm1w6y4YbcAKMJ+H8sbEVGHnRqvsYSQ1
X-Gm-Message-State: AOJu0YzadnZwAWO//7xgnpAVlg2kEoMz3pyvgcEe7+klAqVJSw40+6t3
	XjyospnJE3J5RPzEmctkw6hywN/8Tzui1SOeImACnDc8r1sJGK+PLMwxyC5ZHTjnLefgqNTJhs9
	JzA==
X-Google-Smtp-Source: AGHT+IGihj7M2pUQip2rg4KZarz+rgG5Vi5HqpEnSpOrKP8ghunMKLfzsoaIXqf3xJNXm0bE3pdliozrz4I=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90b:3597:b0:29b:f937:cc00 with SMTP id
 98e67ed59e1d1-2b6ccc73d48mr2761a91.7.1715299900699; Thu, 09 May 2024 17:11:40
 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:11 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-55-edliaw@google.com>
Subject: [PATCH v4 54/66] selftests/sched: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/sched/cs_prctl_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 62fba7356af2..abf907f243b6 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -18,8 +18,6 @@
  * You should have received a copy of the GNU Lesser General Public License
  * along with this library; if not, see <http://www.gnu.org/licenses>.
  */
-
-#define _GNU_SOURCE
 #include <sys/eventfd.h>
 #include <sys/wait.h>
 #include <sys/types.h>
-- 
2.45.0.118.g7fe29c98d7-goog


