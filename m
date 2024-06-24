Return-Path: <bpf+bounces-32937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C4D915770
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 21:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C005285E86
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 19:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134631A01DE;
	Mon, 24 Jun 2024 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="1TLiJhaT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B92A1A01C7
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719258973; cv=none; b=JZxY5qUWRXpu2eOe9t/aoT1TChxLilXiEPsoeEK2GwYLCrxop2JSCJitBJX5xE1V9TSRanHpVNS6YMkWJCyRMPRPom5O56D5h9mS4XRLrHGDIJxwIGipNh3gVwZqtZu5LuawJ5+7XUdvr84NUN1krL1f9ePMREz+ePlF11eO5Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719258973; c=relaxed/simple;
	bh=0Ry5iW7yjh4+dkK5KfmVxe6kFHr27wLyHfv1FVt7WXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iHPI/DrQ75bLEz3bM+AKDE7xTcAUCEqigj3vyK4jjcUO+UJdb3CfHjNCxi0vU22rswbWKotIRy3i/qhwfsEC27rFGTKkE/2DNl6yqLNTGeGd8I5N1JLtQW8E8VUHrp+9hDL0k8JKLR1xnVI+0NZWt4tFFKKAv5alqhc7kSIk1Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=1TLiJhaT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fa07e4f44eso20601305ad.2
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 12:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719258972; x=1719863772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3tqQIIuDCADHgpFY8cfM0SAO57n+ccJALQge0Cj32Ko=;
        b=1TLiJhaTxEGzLEsso757SQ0WdBj5CFTFpJcLqshM0mSeDeAU80EcdNZ1pKw40IcNCb
         JITd02bZ5k3WDqwpSLkBADxPj9C269gNpUKRVnzZCLVZq8pUOpQfvMszXFfpHU0aQkkx
         +JdSQWnKgFxBnK8wrhPme5MC/rOzJQ23NOw6bvkCZUcmF1G0nfNQLrigXybIGGPozUp0
         lm/WvX6lNnyn17kSN26N5Svgjiw9W86+S11poTvJdVanMUPa9RAu6u4qWVb8rqORVniD
         DQGOAPcBdm7efpDk3mwNh+RrvNw+5nyL/oDzRvVbpa+45HrsXtomxfjbaV++i58e868G
         /e3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719258972; x=1719863772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tqQIIuDCADHgpFY8cfM0SAO57n+ccJALQge0Cj32Ko=;
        b=RjTLjyY8qKhbJ0aCeaRHYcP5LMO5XBwoH5vjFsChaYQquYtbiErQojlCxOI7+IKz5R
         oTPEpQpXynWEFRXu8hFJxwjH6EW4oHRJE1fwPr2JmRe1IIrCLTeYvzOWirLCjapgXduy
         aTyrLKZzNWWqex6em5VC5VIoRcJb52Gd2Ry9yTToFmtvXpipMzdhuVOqQVH4uGKxjwoo
         qEwqxhyXukhpSLr8RU5LslwNW9Y9J27s18jsjPbfYD95PTlPQImVoY+rAju+kGRorfnH
         6Br+oc0CEgO2aipaoe9gthyCcZ/RDr2XGl7mewgGCXSsdrFg4EkiNh4LHqBrvKXQYJCM
         ChOA==
X-Forwarded-Encrypted: i=1; AJvYcCXP6lFhMlbll4fd8OAo66pIXR/BRI/xIo1bvZlu6cBEBSD4Wa4JbaS6WAoYBKWAnd5oiP45SU7y8Hm1ltxA466avx9C
X-Gm-Message-State: AOJu0YwJJrqMXF86VHgVbv5xnwWV0bhw3P/7TU1dqk4ENAQWomA8WDZc
	IXNouCchKr5iszU7BuH9lO/rh1Ud3Ycl8QPpWIUxS/cHlAkgVeDwB8YtBr5vDD4=
X-Google-Smtp-Source: AGHT+IGKGfFARVAVotDoRb++tXbqpiUnNusCVE2oSilNa9cJ0LvB+1RBjIPtkjrPvj4Lp3gTbojpBw==
X-Received: by 2002:a17:902:6548:b0:1f7:167d:e291 with SMTP id d9443c01a7336-1fa23ef7e87mr57131195ad.47.1719258971650;
        Mon, 24 Jun 2024 12:56:11 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5e63sm66161665ad.187.2024.06.24.12.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:56:11 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] bpf, btf: Make if test explicit to fix Coccinelle error
Date: Mon, 24 Jun 2024 21:54:27 +0200
Message-ID: <20240624195426.176827-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explicitly test the iterator variable i > 0 to fix the following
Coccinelle/coccicheck error reported by itnull.cocci:

	ERROR: iterator variable bound on line 4688 cannot be NULL

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 821063660d9f..7720f8967814 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4687,7 +4687,7 @@ static void btf_datasec_show(const struct btf *btf,
 			    __btf_name_by_offset(btf, t->name_off));
 	for_each_vsi(i, t, vsi) {
 		var = btf_type_by_id(btf, vsi->type);
-		if (i)
+		if (i > 0)
 			btf_show(show, ",");
 		btf_type_ops(var)->show(btf, var, vsi->type,
 					data + vsi->offset, bits_offset, show);
-- 
2.45.2


