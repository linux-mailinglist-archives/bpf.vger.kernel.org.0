Return-Path: <bpf+bounces-45917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1019DFC0B
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 09:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81589B20E56
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 08:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4E31F9F49;
	Mon,  2 Dec 2024 08:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GADBugVi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCB81F9A92
	for <bpf@vger.kernel.org>; Mon,  2 Dec 2024 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128701; cv=none; b=IcBF2GVPKOsNKubPrzUbsruLTh03Bp7frMx/HZGLwKtyn43eFVTs7ytzpYDMZcsfn1IGYSUcxXPPNMFA+cOPxd5pGB8V/rKYoVANVe+tAK0kye/rU8LnBQHfNVxzfiV2fRT5HmLDez11369+/vkq5DTgFBNcSrLl7gMmy50wkQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128701; c=relaxed/simple;
	bh=sB44DCTgb5gmlhUu3ScZybua8CSPIBJJu7aUY16jRfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tq0BOL6FK8aWgxe5Nd5PysOXTkAHzYc73jQhpgEVwWwI55qrfVXhFCbSsP18n6zppmgn0QIeKlLL17vykxD00y83xPARRfLgzPRcj6zNmQE0dLL5WKAd0sNybEGEa8KIYtvElJxk5H/coCg7DGANudsmBS1VkNgno4bK6xvc3fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GADBugVi; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-53de8ecafeeso4159694e87.1
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 00:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733128697; x=1733733497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oq8E3qN0gtID92mrTfB2zo7JVUwiqhsddWdHKwhF9lM=;
        b=GADBugViPp2OVaqWhx8REots62m28XmULWISasREF8ixedEomf7j25UJKLT5S9ymWN
         XVeD9tHpedWH8UsaBdKPvncSfKw1RY17SgYoggTVvjel60Ixe2ISGPAupa183Ls8t4S1
         s5ay0yIqBzRfEDUc2Uc/oeBGlLvvfQx38vnPulUtKp8He85Z3IiOdh5GcE57M/P7NZt7
         VJZdbgl59snJ6DSGVsUG2uxW4t4uxMa/yIWYjEHWshYz/wNKK2LfiKoqzTaG+ODLl4Xm
         7tmajVxJcAmpMJyQ/yVx76+mXzPY1ngz03Pwn6cPhz1yBo1CjjMN66pAi69Wpqda2G6S
         pQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733128697; x=1733733497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oq8E3qN0gtID92mrTfB2zo7JVUwiqhsddWdHKwhF9lM=;
        b=Cok6p5e0VLU1VrkUQMQI+lDDIarN5sCrOiD3Zve3x4U/lhheM1ArKL8MqnLVEHjZWx
         16Rl1vbcApiNhIg+wfWcicW2pmb5KI/mII4+3uWkvar9Pb8z2LUbafyWlp9RknvvRCMS
         mf7Ih2k/+W3N0jTl0P/jYYhdIEKscA0RVh7OlC64z7Qbus8WyUKuPaOAlBs8DltUl18N
         +cegbOW0F7VU5a31dDlYtzBZKAY7dF9sTJ2DtNd3OUn30NoI6fTM39KTQvinkL8N8UG6
         7BbdJX/np+7g7qqfoEVzNcENV1nzaF6jlVbWcNOq8AO3jUXfl8bwTliKJ9cjYw+vdxyD
         OmrQ==
X-Gm-Message-State: AOJu0Yz9dy8OW6g3gkDfj/h4+GCSjRIQ9hsgSPSA9DyCQOKuiNXV6S3/
	bQ1Gx1whCcBfCFYcxyzN1aXRfZI5i7LPkgsJQ6laJkngdaWzobpMq03mky4+73U=
X-Gm-Gg: ASbGnct1FdO3FHpgdJgK4zgi2Bs1mZNd/33OKf2WX+pval/FHHMplp+qjrn7Igqe6gs
	F1U3IQXW278ZUsvifg5meYtrAlWEEPFoJDySH5dcNBoGH/ZGV1PBLf+cuI6BG+7sI4DdwGbTOpu
	9KHlHKpLT2/qhXwOXPBoLqFLZQVBh4nw75M3M8ctpyGjTuWZVRsROZBQuptLWlFZOs+UXIMBvPb
	B+emB28eYGabj3++dOyBMMX7OuSKJ4uvGTtOAPvh9UVlffV67TfvJRrq2Q7NiWjNCuIJrBwcE5f
X-Google-Smtp-Source: AGHT+IEdmDtobGvpJ515IJefewNlZGzFWLJKUYvdOsOpbQkz2INVyk3TPHnN/3j0QLG1znRNU8jK3Q==
X-Received: by 2002:ac2:4e0b:0:b0:53d:e5c0:b9cf with SMTP id 2adb3069b0e04-53df010e441mr12403794e87.52.1733128695881;
        Mon, 02 Dec 2024 00:38:15 -0800 (PST)
Received: from localhost (fwdproxy-cln-004.fbsv.net. [2a03:2880:31ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bed7sm146202125e9.8.2024.12.02.00.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 00:38:15 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [PATCH bpf-next v3 0/5] Fixes for stack with allow_ptr_leaks
Date: Mon,  2 Dec 2024 00:38:09 -0800
Message-ID: <20241202083814.1888784-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790; h=from:subject; bh=sB44DCTgb5gmlhUu3ScZybua8CSPIBJJu7aUY16jRfI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnTXG09tHhhSGa69R00qT5tMLPZkvTp5HIHhlj8Pq8 dAklx92JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ01xtAAKCRBM4MiGSL8Ryk+sD/ 9+Y48Pwb1Guwszb7cdzIC1A+1MM3N5h1YDWYld6S0NPaDJXXeiq452ddvp0EfH3SJl3S2rGPOEi4ee Z7BJXktHOS43GztKFgmAd3aPAFogH5aiCq3DQ5Y4VAhoKLtYLnJoCARLD5xzXup9WmZGcKbv6Wxnk3 jplRVSL900K1zm037MQSMGE1s7B2n/9jgvmxN9Mh0RF3l5/GlZaMmTCocY1FlrDFXiTHWcUJ67+hIH HNM95yM/MlBpD1Jcl4EKrn4dteGxMl2T8yfSdvrqdgP/2mNSt/GBT+1P57EwkX8/1/qia60Jp2EIL5 VtjqVPr9lE/BDDcjhbLQYe57VGuyF8uXXlRQsGbGaakkcWOHkqLATWYh8FJOGyuvAP1Olwn5Z/0d+o O/SKtYaZY6RwfwB3PcyBukCO+Kl1WCMz3w0UVgxVAq8bP8/YM9hHFuCsONyR4+4Bwq3f491+aFrDER 9j+kbiIk7BteAsN0mN0verMIB1SMKI1ZfTRv9d7+kB1YUwHfTvREvY98KC6mpbzEIDy1pXMO/IreGh f1lQrPQ6JmdXqmD1xc8FCjEUd+HIxqj7jCWfZ4fL6DRm/UyutAAr58VzvPTrY0jFDdev5VKCgMBZn0 GUIX38eDmVKLk+3EnmzFRM4uwzo4pjk4yBbrlYNOLZ01luflo9aCI9kC+Row==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Two fixes for usability/correctness gaps when interacting with the stack
without CAP_PERFMON (i.e. with allow_ptr_leaks = false). See the commits
for details. I've verified that the tests fail when run without the fixes.

Changelog:
----------
v2 -> v3
v2: https://lore.kernel.org/bpf/20241127212026.3580542-1-memxor@gmail.com

 * Address comments from Eduard
   * Fix comment for mark_stack_slot_misc
   * We can simply always return early when stype == STACK_INVALID
   * Drop allow_ptr_leaks conditionals
   * Add Eduard's __caps_unpriv patch into the series
   * Convert test_verifier_mtu to use it
   * Move existing tests to __caps_unpriv annotation and verifier_spill_fill.c
   * Add Acked-by from Eduard

v1 -> v2
v1: https://lore.kernel.org/bpf/20241127185135.2753982-1-memxor@gmail.com

 * Fix CI errors in selftest by removing dependence on BPF_ST

Eduard Zingerman (1):
  selftests/bpf: Introduce __caps_unpriv annotation for tests

Kumar Kartikeya Dwivedi (3):
  bpf: Don't mark STACK_INVALID as STACK_MISC in mark_stack_slot_misc
  selftests/bpf: Add test for reading from STACK_INVALID slots
  selftests/bpf: Add test for narrow spill into 64-bit spilled scalar

Tao Lyu (1):
  bpf: Fix narrow scalar spill onto 64-bit spilled scalar slots

 kernel/bpf/verifier.c                         | 10 +++--
 .../selftests/bpf/prog_tests/verifier.c       | 19 +--------
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  2 +
 .../selftests/bpf/progs/verifier_mtu.c        |  3 +-
 .../selftests/bpf/progs/verifier_spill_fill.c | 33 +++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     | 41 +++++++++++++++++++
 6 files changed, 86 insertions(+), 22 deletions(-)


base-commit: 45e04eb4d9d85603539984bc9ca930c380c93b15
-- 
2.43.5


