Return-Path: <bpf+bounces-64410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DEEB12498
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 21:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE9B3AF57C
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 19:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B207F257453;
	Fri, 25 Jul 2025 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxTVVUZt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED31253925
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753470447; cv=none; b=C7lazLauqU5ozriVD83Ew34RZ5tT66Jm+oVGtvbvuqy8890MNoFsMntfbiFLS8kNxysDrjwrG1eLUx9+zqOUp/+87xwRqRjjGcDvuKrvujvuuesicNPGa45stABda4GDb06YNwO2x+kToBEc98/gs618eSzAagqqkeQUEXgxxy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753470447; c=relaxed/simple;
	bh=dRKTDUVG7/xiIl5HiW1yY1/sAfNNaIOpAG4v3Opb9jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9+XNEbhdBpskMosefD8gWRtDwgG3XYuOdH0c46cMeJ76QJiDXiJCKg+7IfwT+sEl2ohqsfUpKKzcyLcpQ/D5m5YNEYiN6ZqwbLla2cRBq1FcUdoTRzmsZ5OuG1wwTbyKVloMGtGQ9OfAk/JDFS7oWMWo3Mm8/kiVj95DqXXFwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxTVVUZt; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4560d176f97so28750605e9.0
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 12:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753470444; x=1754075244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X5Fw78ow4x5Fx5TApRahrmGDNzn/qx8zIne4a94WQLk=;
        b=BxTVVUZtNCro0yxkVm3m0s+oPWcTTzyLhzRdMCyVNBreTB7TMkgDz/F4jbag69Jf+2
         17wmQ400RaHiVzCY3VDau6y4b2PI7NBBDiBLojbKReM7Cnsa78JC+otHyjfPy9IkCkuj
         cEtjPtLX3SyHQKLgG8sIn9VM3TqNlCUstIaj3uqmGbARcwM7Ll2dBRFUJGk3kKKtNZB1
         nTCLX52MTLwLLsW06XY6oLfQb8+FCpsznkRHQO/9vYgWqzWvq/za4ZWkv8507CIwVCd8
         lRU06YsTwHudQkHwgdHViOcmpi2zFMND+m4PIsLCZfOKYbY13R/bn01y3+dcJsr2GvwA
         /6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753470444; x=1754075244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5Fw78ow4x5Fx5TApRahrmGDNzn/qx8zIne4a94WQLk=;
        b=TlNo5smCrKJTo+WxcxgKTocTMTA8BzKP7Tyv0xbfbTsotdRovCLkLXMB+GjuHHUGPr
         B4TVh2fTV4CMAOlycq36xFmsSv2o3JrIktNpgjVxH4EOgMAQPpV6/T5TnFbSwToLiwmf
         Cc5FDfMLoJQiT/bRPfyzeqLHw/wcCHOgE2IvDDYkfmRQwCH9DEyrAo1V0zKLEAKb5+jJ
         buAS8OiEar5ynWqu2IXfK++u94x0NhDDOF5SGalg9peQDp7cyowFCDbuSMpJLDbfVg98
         xgDheQ0LLz+pSfErUYW6kfD3GsRA6pnbDG9nK/Fa9hIHMFoinCRngDp6VT9hXpmywnzH
         92VQ==
X-Gm-Message-State: AOJu0YxAgH5WR7vL9FGs7Du8vQSW6BK0x5Rd7hqmsI9IpOcqIwXSqNww
	qN5o+zjoOxMTNDQjU1y+1XRG6niv/WxNcBbrMSxjGD3aVrUz6KX5rJMtcLJbtFh4
X-Gm-Gg: ASbGnct1fYCm8NQCtyGSpQTF9kJmUEczPJ7/QBsohJ8UVZIU+u6tcpZKewGp7Fk+XPn
	MlbKC7wW8sJW7YoM2BCYqRiNZ475tl1cT5UAdJ5N3XgWAi9IpxTZcq+UflF55GvusTxj0RTvsRH
	LVZbtE+VLmZ8/6FdOMbPPtKZDeDa5wPZRUkKp7Ab74VxwTJpKyHrHM8jBJxqwZzPA43eAOu85lF
	MdlC7BexS9NRHrTVPCAYfr36qgFIEczh6AZYYZw3A1wnyuuqlLb3GiPHkRM/drZSci55P9yZ44c
	h/9CI2EL+kY+BTtanOdNVHBvExf8si8+eqtqheIZDzIfuv/518wDeNFo9PnNmIFexm1gnzboeTs
	6UCRwzs3A05ZigTth+PvoK6Ey9Kbq97YWy+IH1Gdfyayn47QSUjX4KgzGRsWS27CjiAu5BWVUit
	qQN2oqTuYe3DH8jaxCs8fE
X-Google-Smtp-Source: AGHT+IFXP62QehYI92hJPtvSZ2CBP7sP6z/w96JuXSRKv69xoINYEe05qQom4gvDgktlfhP5cuOIgA==
X-Received: by 2002:a05:6000:3107:b0:3b6:13a0:bb20 with SMTP id ffacd0b85a97d-3b77675daf5mr2881853f8f.35.1753470444062;
        Fri, 25 Jul 2025 12:07:24 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e008dd2b4234fb07c80.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:8dd2:b423:4fb0:7c80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778eb9bbcsm637759f8f.18.2025.07.25.12.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 12:07:23 -0700 (PDT)
Date: Fri, 25 Jul 2025 21:07:22 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 2/5] selftests/bpf: Update reg_bound range
 refinement logic
Message-ID: <48b3d152c9a8c4ebe590b308fbcf09077919322f.1753468667.git.paul.chaignon@gmail.com>
References: <cover.1753468667.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753468667.git.paul.chaignon@gmail.com>

This patch updates the range refinement logic in the reg_bound test to
match the new logic from the previous commit. Without this change, tests
would fail because we end with more precise ranges than the tests
expect.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 39d42271cc46..e261b0e872db 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -465,6 +465,20 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
 		return range_improve(x_t, x, x_swap);
 	}
 
+	if (!t_is_32(x_t) && !t_is_32(y_t) && x_t != y_t) {
+		if (x_t == S64 && x.a > x.b) {
+			if (x.b < y.a && x.a <= y.b)
+				return range(x_t, x.a, y.b);
+			if (x.a > y.b && x.b >= y.a)
+				return range(x_t, y.a, x.b);
+		} else if (x_t == U64 && y.a > y.b) {
+			if (y.b < x.a && y.a <= x.b)
+				return range(x_t, y.a, x.b);
+			if (y.a > x.b && y.b >= x.a)
+				return range(x_t, x.a, y.b);
+		}
+	}
+
 	/* otherwise, plain range cast and intersection works */
 	return range_improve(x_t, x, y_cast);
 }
-- 
2.43.0


