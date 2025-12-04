Return-Path: <bpf+bounces-76042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 22450CA3A1B
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 13:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D6E83010604
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 12:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753AF33EAFF;
	Thu,  4 Dec 2025 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsrNw45S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1D533EAE5
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764851949; cv=none; b=sQDHUrBKccmcHR6QTFIQzUx0+nFev74/XmGIeOuVdHYnea5tv+nf9HGYWGFPiw0oicuObFW4Hl3uoIJ4J6zk5FvH+hJxOe8LHwh4oMzz87+oOepnKxl09EGpUZRe7beNiXigYhEdKtdhESbIh6pcJ5jRdg76tRTs9Nt+zvYPU7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764851949; c=relaxed/simple;
	bh=ij8EL0R6UwB8ZDBVRFMV/z/L2JKiW7wDSAk4ODpKtjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I05jW25TfcXLKinc7RB7OETOKJWo4FsR1e6LSuJdtZzuLZu4XS6b7D52UPParpW5Q0ga24eNSa7MLXkr5feowf8+JtMGand+tu+5jKH26MkkqfQiZF9nNUi8G7Kud+t6qN5dW7Z3+142LGw2zwP309lIsBHwtErjFupKgcOU5+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsrNw45S; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-642fcb38f35so685581d50.1
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 04:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764851946; x=1765456746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ij8EL0R6UwB8ZDBVRFMV/z/L2JKiW7wDSAk4ODpKtjs=;
        b=HsrNw45Sw0qZhJpdlG/WgjH3nlhIEkm4EdpLNBUykie9ug5/9q1aG+EeLU1bc02nPm
         UUnXoFh601CHrbCpbStdpXOf05pyoBCWDH6ZTSXL8c2GpO7HhfpSfARkqY4JIp9biDRT
         vXJIOWL+UiwXR1H30L26SUeflgcBWUIrq7O7yyp4aATGa4XRwgnrgPDkqHs0ZpreNd5V
         lrjyjh5Etk6qNfx6sKk35SWiaTe3rMa12Is0CUBafm+EVb67M/LRBMFg+z17zwK1ucUk
         WXuTyC03Lvidk+CMPHud+2ANe7LjLj8rYyagl3TFQ+4wi5oQaMF/tDPKSm5EbweUzY9w
         BRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764851946; x=1765456746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ij8EL0R6UwB8ZDBVRFMV/z/L2JKiW7wDSAk4ODpKtjs=;
        b=pIRi2ej8VmH3Yvd8rc1UM+4Y7b7YeTDxlKFSnwTCaOZA2HF+m5hicDfBlJWsKJsV6y
         JnWBnrw7na1tDg/4qTCTiMlJviSOwto1yf1s1mw/eAUkGd5NYTbPlr7T7TiPjvof+WKT
         E75L8eBO3FpceVh9C2nG6m0clV7L/+3dqDUmm13AiyUBnGJr19FFzU7/dVugUqkgb4FD
         0hz63vLfjwjYPTOK4UJfMu4ZdBXEwSrW6R4e1DmEw7UE5Yay5hzwyKcF2sM97Gz0d+/H
         m+plpkCjWeDCMAU0on2tk370q6c9lTv1xv/7D+2gSo1XN88fwz/vlwbABILu3/nzp0wz
         i0xg==
X-Forwarded-Encrypted: i=1; AJvYcCUgH5PZd8MWNUkA/hy5DkA2kJa8UIDqETzzn/UxFpIffOoh8rAyRUziYuadHA5ZfvWg6+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsYd1LwmbhKFjtkdIiR0zBF1u4m+c24JlI+ICZV98AAuJeWIAo
	LBNFCHC2cdrcMJAW1PrkER1KF+3ugM1STWnX3ieRVpShk3l8Di+F6ZSv
X-Gm-Gg: ASbGncuwPrs1Acfgr0KB0Ex+jf+tfnZw25gmXZg8VbHQrCvaVARWLb7TXFIMS3YrO99
	f/1xu34I8CYtmFtIrA4vqq/Kmt5bDVDvreeDb6GlZYad+GbfgPCFHDdYy3YyMSxhUOUK/LUWYnC
	2eLwNMzBwC8Qu2dmNf50ZBk+VygzMFQG0WoJ6H4uYJBFRocGYvzQ3TWulzreHK04YZ4LVW3lf2J
	05TdbO/whpTMYurFLiHmGBJhl0Wi/JsHot4CdyV3pqMmUKGzJK1oZEB3kORV4bI+rhhnrt3uj6h
	YXx/Jn17u6R5paYOPWICfkvQ54ebUCewe91sVKffogTD3yudkQQ0j1lN9Mi2DUtJosjHZCnC7fK
	YaviNPJZ8kvVEpkqucoaP/noiEvrNbV95Tyv7UwK5g5MGL1bstcNYZtL1n3QNxrXTTaOMcU8xdQ
	lZ5ixHP7z5c6Ot7rHB2Yg6kdoSQsx83+NnazKV1hr1yhPjomjFFsY=
X-Google-Smtp-Source: AGHT+IGxKuUtlyaX8PN+PqMbMQ7N09I5gYeGDl8pe/k/jby/JuQK+UYr3WKkNen2o5yTwoJekvFxYg==
X-Received: by 2002:a05:690e:1908:b0:63f:b0ca:dc9e with SMTP id 956f58d0204a3-64436f6bea5mr4880835d50.10.1764851946376;
        Thu, 04 Dec 2025 04:39:06 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b78e892sm4766667b3.44.2025.12.04.04.39.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Dec 2025 04:39:06 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org,
	mattbobrowski@google.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	dxu@dxuuu.xyz,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	electronlsr@gmail.com
Subject: Re: [PATCH bpf v4 2/2] selftests/bpf: add regression test for bpf_d_path()
Date: Thu,  4 Dec 2025 20:38:52 +0800
Message-ID: <20251204123853.1235-1-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251204074632.8562-3-electronlsr@gmail.com>
References: <20251204074632.8562-3-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I looked into the CI failure and it’s caused by the test assuming
/tmp is on tmpfs, which is not true in the CI environment, so
fallocate() fails there. Since /dev/shm is mounted as tmpfs on that
setup, would it be acceptable to change the test to use a file under
/dev/shm instead of /tmp?

