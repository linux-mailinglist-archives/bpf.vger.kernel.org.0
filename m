Return-Path: <bpf+bounces-75419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBFBC830FE
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 03:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0423ADBEB
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 02:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60A91A0BD0;
	Tue, 25 Nov 2025 02:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdqZWHFN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8418117A305
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 02:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764036478; cv=none; b=TDCUFvooHxMEhLSFz0GD/Xfyr61ORFTetljhhUM6zkyNse3tP4Zietow2KEglUUO950su+LExxTPwJuOGxnhSlv3RqQbM/5r1ehC//0UuqPDqbcbZVjqmKPtJGdtjOrnQvs4sUWKktAjLvzdWd4/Ynkd4GsWL2GY1hA7BYwaSl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764036478; c=relaxed/simple;
	bh=J/+xEX5jLZO1hct3Rz1t5C9Y+qpabzJAc4Lbs2LQUIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fO0xGEdeWdpaRTHMxlh5d0EQh8owzcFMLYeCrBV3ZVZhaa5yue/HJJ5OyqsCcnLmvzNQatwED2I/CGMnFZU8ltC+S6BsUnbleABBx40r18GT41T5sEZHAaCK+qrrO1oVl9OpTB6ovQff2KTntD9ykZQjAD+Q2bAkLTlUvGryN14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdqZWHFN; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47774d3536dso38276405e9.0
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 18:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764036474; x=1764641274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+XRC13f/VnJUEqcXbO+DUkApiQwoDzDXpjGZdkCbuA=;
        b=hdqZWHFNXzNYnvdrlu4Kq0hAZbU9hsrI/As/DX3Wo15ft5+uRJoMN7sY9aMYIMf7Ww
         Rt7VtewVz8wLUpnr6xtP9HidGtRK5mI2OulX2dL4LsqDljlLqVBTXs8zZBsZ9DJvf8dx
         hDBohbI1k4rqoO43/QM2qxFpGHCbHHjPmjisQCkSRAjqWBKnMBwo5Gd0XCH/K9AhkGvc
         gfHmoMYU/BUXEjsnhTWnV1I1MqChdqZ7GpmTdmpVY/L3trW6VQfn/VS8xbd8JR88qMff
         8VILTJE4zE9KHHpnruubHZNX5oNLNSBcLAw9tGkmk3p80ytDWXqJId4naT5uoD9pByOu
         CprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764036474; x=1764641274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+XRC13f/VnJUEqcXbO+DUkApiQwoDzDXpjGZdkCbuA=;
        b=Q/BtvDP6AReZWGLE8xmIiYjYW01rO5U+mcX3SGL2ESTBUEIwBSOQbup3e/9qAvj6GI
         apGMbthrZM8w24UsY8EVssSkkkOTG4ngMCT2FjKSORk7b51ZpQo7MiYl90W0goKj6wqi
         r77wOyxV73iPxE3zUZYZDXEXg++nP4vk42AZ2wPUkgwTS/2sUHgxH9YvA5g6Srh6aywb
         qn/1VrCQJ8j6+beBF8AG5DKM6LoL6UmmlroK0WKMSuEvDp6ovN9r0VbYOeFHnDycQxN3
         NSYaeav+8FIeGWoEObM1HJoUFd0hjqaxeUTGhTm4iFJksqTFFhAJNMJwN3YI6SMKxmFs
         9Vsw==
X-Gm-Message-State: AOJu0YzMYahj5ctUdjETdL726wTsMHbTYPop47W1gTvllVQwH/IT1KhE
	vb42Jay+WZmi+QJhpGI+tvot0WhANnayUWK/HzIva8sAv2Ky0cXEnai2+7LF4eZI
X-Gm-Gg: ASbGncvu0jwG4tShdLlwiQrRQjeG5q5uC+5YB8wQc/IL3y1GpydbQ8ypk18lCXlkQsB
	xcL2QaGD6QP6Rq5UBCBOZOFwp3vYPDNcAk4GRyFKYggVHE7/Cf/FsyDElAkZk7TKLFfNk4ibGD1
	nQn8WF1tj6Cs5CBYnKQXLIKU5X6iGH2MWOCoIbAi3T6DA92wdOhm/O2AAdv6lYrXjU6+AZoNS9x
	iJ+hwt2xIowEInhb3qARHDV08orzAEPwu/EDREZPehS2+yMync78H7fwXb11KZeVa0DCcP2y8dI
	nQgogwsxI0pmdSINvAYJDlttjy5nelGBJXv/idZ0YcDpyd7g1y+CVExRo3zodz00CithGEFW7jQ
	ipfBQrFcEJy9JXBBJChj2jQm80Fx6IxIOwLewzXrvSQCE51yHFrndf4wd6005JdmIcInvmrLBRR
	nwBQV2Qwi7hW1pShnRJwvgS23aHSTiggbvAeKJw2A/frIPU62f9rJmG+GwjgMviILU
X-Google-Smtp-Source: AGHT+IHvbpyuiCKEk//oBfGlGp31r6S5sJqEGN/EJvyOtlw8wKffQ/XPk/pY0NW8WZCK31DDnJhvzg==
X-Received: by 2002:a05:600c:2e4c:b0:477:9890:4528 with SMTP id 5b1f17b1804b1-477b9ea31e9mr109661465e9.2.1764036474368;
        Mon, 24 Nov 2025 18:07:54 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-477bf3607b3sm226683445e9.6.2025.11.24.18.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 18:07:54 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/3] selftests/bpf: Relax CPU requirements for rqspinlock stress test
Date: Tue, 25 Nov 2025 02:07:47 +0000
Message-ID: <20251125020749.2421610-2-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125020749.2421610-1-memxor@gmail.com>
References: <20251125020749.2421610-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=895; i=memxor@gmail.com; h=from:subject; bh=J/+xEX5jLZO1hct3Rz1t5C9Y+qpabzJAc4Lbs2LQUIY=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBpJQzuRkftB8/xcp5kPTzAfvsJK8wRjM2mA6ssS mqG8QIQm5CJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaSUM7gAKCRBM4MiGSL8R ytFfEACWP65NVjL7cIsmXldnZFA1GLW/mQSLENZjdxOAoVwmpYFHSeB0uQpYWpZTXp7GiUha2YP x2B+sJUlAoDpHl6gVjBflntcM+TDiVszjScF9heGxYjHWtrehMe9pXd8Ttqkg07zSfBvgE+mHcO lJcEmZKFKe30wcWZThQep2qGx59MVnnpdzMox+8bcGxSl36oU4wRSCPuVq5rVfz5tT0PJOXnS81 IIRhXriI7bRV5UgRgHQsG5HvkK0bKvHZvI9Ee5a+ALkskLvX+yi/l1D4CQEjAIB80nqZePlp3P8 WFvxxFrdt8GwdBMA2KZDTi9dOusZBLJn0b5ngvTgqYezNHj1oQm6fFW72khjigu5fZJqBlFxEZc xl8FXq+VKHx1LUJyU8k1bERztMR59ja2W3g0GdPjuSnGmZj2tz8lJVvQqnI8ZNhuwURmJz4S+XF c9DoWPbUSZWYowOKshzvSCIbxTlPn4InNUgDpcQl4qWEKfVCScjLy2muENPKZa2VQDq1jbRF1jG SSzb2JWcjmO/UsHPMCXVZdx6TJEqlNljAk0mwCjZVSbOMJ83zKi2aocYt+PfEWmcsyZcf5ebXDw CZOjIiFNtcez97Fpd2mQOpb4SmEyQuaVp3sMe6Y8wToWN+NxMRNzcIeSrz0SD1uosfu3yIuvv04 e7nOM6P+dlC9Cww==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Only require 2 CPUs for AA, 3 for ABBA, 4 for ABBCCA, which is
calculated nicely by adding to the mode enum. Enables running single CPU
AA tests.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c b/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c
index 4cced4bb8af1..8096624cf9c1 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c
@@ -182,7 +182,7 @@ static int bpf_test_rqspinlock_init(void)
 
 	pr_err("Mode = %s\n", rqsl_mode_names[test_mode]);
 
-	if (ncpus < 3)
+	if (ncpus < test_mode + 2)
 		return -ENOTSUPP;
 
 	raw_res_spin_lock_init(&lock_a);
-- 
2.51.0


