Return-Path: <bpf+bounces-64264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B72B10BC5
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 15:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101ED3B645E
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 13:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C832D94B2;
	Thu, 24 Jul 2025 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFliZ3/3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AE42D8DBA
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364593; cv=none; b=SKc5qWwZzcFiXUw5fvii9wa6pw6KnJlC00kcOuO7mfIUcLsAZwDTHw1KI3HiME9NmSX5862mRYeqdjPAgf+ATHMqY58er9OagB2yMYVGDW7x7RR1LCc+q8i26Z4GsXj7dIgi377NDw7ryIE+oakWzSR9m/0qt2V7R+DjeiXvgj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364593; c=relaxed/simple;
	bh=dRKTDUVG7/xiIl5HiW1yY1/sAfNNaIOpAG4v3Opb9jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9yZAijZ4k+6lfR31JSUQXSewKR0IzTMkpNmlogpDCFcMLDKoJAudaK/EE3O/sNhxhIHzLvBJzeg3uyJHowwJjgd5TBwvWXAF+5ij8S1Sc8hTKBIwn8fTQtKk+1pAzh67wG4ApEUJ9eMOz4L/j2CQn8wUsyLSpWgCvYGCKRuvRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFliZ3/3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4560d176f97so11209975e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 06:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753364590; x=1753969390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X5Fw78ow4x5Fx5TApRahrmGDNzn/qx8zIne4a94WQLk=;
        b=VFliZ3/3GLIgmebLlFD2r+7wmu7iawkLLhoS+Kef6KVd3sB7noSv30aRFoO5NWcmPC
         5GlHnKz3ueZvj38oBeZgnhJO5uLzNgHf0ZQnqgpC7gqsgEMpVLbddK5seWIpOBWixmmq
         1uPgrLZYWkZaQnmM4OTD0/1W89kNARWumu26aC/XlDrbl+Bn4LMsiEIGRaMSCKMkyVVA
         2quV80a2CtQH5VM4SYpnFW+W71zlTgVaevk9KBJSvu19W1NO38duO3mgW4lHaQ0fFT7J
         3dmPWsbU5EPq0CyDNiNux+yrlcNs4Hc6Wi4hfqo9m8CfRr6cMhualE/DG8xvMQdZRSiy
         eZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753364590; x=1753969390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5Fw78ow4x5Fx5TApRahrmGDNzn/qx8zIne4a94WQLk=;
        b=G+QIsT3swBD6nNOi+SdYY6T/97+gjbBEknZ2I5b96YdtEPjh8GwD+TKLl97RK4GMR6
         mXs6nxCg/YsReGG0m52VfNYWpE+CZzeJ2FWOt2zN4j2P6nLKz4xhGGq7ASpCcZeDVJrC
         3CBQlWF5ghYFL7Qng58WORklD6zErmrGK0p8Qsr9mi7Zi5MlCDWlutGQ7DC5qgSbCntu
         IcY6n4D7Bk9eWCMjRCX6SfeHnV+zEKLwtVzSZ0DJerjOOjXDjdiqHmSeIgspN2IuoE0y
         PGtgjuGpZXlHHMY2hr/1tm/453K8CBs+z0oIie3M06zECxfLxI4am7/Nr/t03q8ah433
         9a/g==
X-Gm-Message-State: AOJu0YzQIFj2p1iT4Wb1etaqbSOgsGS+kqheTZXXoTkhh7D2Oi5Sx3u0
	vAE3k9Pw80Gf9zOuit7SYqftGK+7yb5ygp4A3DEJ2qbGD6dp1fS89SVqgNdy4fcI
X-Gm-Gg: ASbGncvKOBKAVOmdINHgHVmrrj9Zn82wWL/QDd1ZPvQwSF/WhW5+dCS5T+o2Kw7WUqK
	ib+K9UlrOlvVyzLRqO6hhypUr8pzJRw6DxJ4JBhIfltA7bTvMPKn77IL25AlaIgJaNSAJwej9Vw
	/bj4HiZCX6JqFqAMz1sR4Xe2O8+Jwu5aBGSqfALCH8BqioJmqMN0NypRGmv2NPjq4IBoMYxMop9
	ozcmxFyANrCyuXQY/jJHVa9LCsFE5kyl62LA3wHWJFXXOrz8ozEcfz6kyOCZqoKAEeNvkrp6nKu
	7vmefNuvKrc9j46007zfgTQuWZ6e5b4UgqBG8U4Y7rveLJE0dwQMuseHevscXJfnQcTzlB8MqBC
	Ogp8wDSq5RIiQE8C6DcoGvjN0wTEa6bIi6muvxfm/Pkh3we8A6l0gRwQ+7RbgLtXEqisCxHqrbA
	3SfRSEcadAZK0MXL83Nqdx
X-Google-Smtp-Source: AGHT+IFqVI+Ncovml9UFlFfpbE2zn/7OB0B5QiRAVij6mhcQN23rSzGwHlO16aceBW+BD0fxd7UEnA==
X-Received: by 2002:a05:600c:6209:b0:456:1dd2:4e3a with SMTP id 5b1f17b1804b1-45868c75be7mr72122665e9.3.1753364589799;
        Thu, 24 Jul 2025 06:43:09 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00667e58c39c19dc02.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:667e:58c3:9c19:dc02])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705ce781sm20661875e9.31.2025.07.24.06.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:43:09 -0700 (PDT)
Date: Thu, 24 Jul 2025 15:43:07 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: Update reg_bound range
 refinement logic
Message-ID: <2ade525e76d67cc209b358100b66506fc7197dd9.1753364265.git.paul.chaignon@gmail.com>
References: <cover.1753364265.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753364265.git.paul.chaignon@gmail.com>

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


