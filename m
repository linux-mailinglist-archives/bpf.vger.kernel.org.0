Return-Path: <bpf+bounces-55653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ECCA8436C
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 14:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990EE8C62A6
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2362853E7;
	Thu, 10 Apr 2025 12:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8zaV3yk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F927284B5C;
	Thu, 10 Apr 2025 12:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288720; cv=none; b=RkvwKlDtswydeWFqn8ZQ2BcjDdxBm8GDMRiZt69v/zo94l3xNgkBD8ELHqIhetut1GqZ7L5ooi0NXr7JwY4WNKPkLDnwAdLs+de1gWxcOL3InsAnYG3X3Sq+b8bmOIVcg3erDqsk2Pr+RdxO+AokYfdnNjJUMppJaPZ0UcN4cNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288720; c=relaxed/simple;
	bh=FdnbocKbRHhtLFIRneUZ+/1khNFKq2SMICJ8698GBPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D31SawM42w08UIoI/wbBojdDwBMjO91VWZU4hIBPYcbToHaViA7VEUZPxyhbm1F8kKasQpnwDrc/FyvkotL0cO2EWicm+BkJrYu77SlOyfP0IBjzqVlyi3NPxcgko2I6aTJvQgYCpyA2/TeaEKKzdj8TcURAe755Gr+8MWKFVx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8zaV3yk; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-39c1ef4ae3aso466888f8f.1;
        Thu, 10 Apr 2025 05:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744288716; x=1744893516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdnbocKbRHhtLFIRneUZ+/1khNFKq2SMICJ8698GBPY=;
        b=B8zaV3ykSYKjzocBkXfMH8sg+cuA356daXrUK1qR29GIXDuVK3Vhq8QyH25VQAR8a0
         rvDp8BtSN61wy3t5pOaIOHS8Lvdexpvsi5kuIkGg3fk14CJSQmES6oWUoNtZ6SwWdcYq
         y31PnX+kx3R/940/srM9X94IE8sW8IMH3CeVwikmfB5HLXjTjwJDR5V8jdngP0f1O40W
         eydFhPbUowWK8+6s5JIbwZjyQ6AZX5U9RmLXG/7T6nv8BSv4uT2hSFTDBJYim44SgBaY
         bSOjIyLYUpoSJepU94w/SFbFmPtRHRFKxDBjodi9A4yuuiacgxMWTMCxo6MXxmS453Xw
         pGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744288716; x=1744893516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdnbocKbRHhtLFIRneUZ+/1khNFKq2SMICJ8698GBPY=;
        b=wnekpYQmu1c1p4CtWMq/qIib2UvIxc5q2f1Ak7hFIfP0lOXeck4xyfuHjvoqEHM4+c
         EYvs3MzB3+SRjNBW42Jenb4r6WreaH6gZOBOFNvk1zrSFgtOk67GSIjiaK82VRZK7RwA
         1/vSLrFi8rODlUdXara3vswPSBp7y8epdtJx/RWZmosXRJJ8yeHBmLmUWS/Jy1z+dml/
         0+k2GogmFxobLQeztkZaT3dzITtLKYKtQV6xFBr6Y1kWTu8qfjjCJLq58/0ijlwWFdAp
         aMPLsUfKWG4t1nLBRne+LG9zK/tURdzR2jGUt+jSwSwuDbQVnOOU2EKLOYru92iQBAhq
         8jWA==
X-Forwarded-Encrypted: i=1; AJvYcCUbcXTbgxa9jqP2ncbRvNaoofeu/k3FwZ9b7BgAic00y3mqd3/nSSEt9j3QOSU6R+WUQruer6rJ@vger.kernel.org, AJvYcCUyDgdfjBJmCshMLWQ0DLlyC9QTqJTUQpG6i5lqxjMWCbuIT7QpPiW73WeEg8YQEGAhQG54/WQW0GCzZvu1@vger.kernel.org, AJvYcCXKWn7wh3iwQ+EaWRi0jCxE7XogB/8l0frjnMQuIMBjqLoV2/SycdGoG9lAM3Pgw6lRlC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7vxiWwUn291e49YJJgbHDvfD4ZPMP+EftDTldre6Nm1ijdpoS
	WURP4+Lj7FHkdSixC+sEDlpAy6tM3hLxb7wn3bY7P3fvFstp+yFC
X-Gm-Gg: ASbGncv48gq6UWtCilAUIxfNydnqeN9S4UQvi3sPfRzRkkm5Y6Trjt+hAYVKnTsujrE
	qtkibioPJv1hoPrKpsL7fmkgXrLOedJte3PSoenGZsLxPjDfUtGsd9hgYx0+s24dPIW+KgS19Pq
	/YELQJyFsOUTyoWUupqA3U7tIoINKBwOsQDm7rQNM1CoCq4MdMwbSOK182s1QxG+UJv7AmvQd5q
	ZWZAjBpxcdrVHyd3PlKQJuFESSb/gQAwJMG3Coi8BOxAMXCtfB9mb9ZXCCF0Bpeq+xHD2TlI3tH
	FyF7mFvkzR+7BFFjMkHz1YQ3dMf7X40=
X-Google-Smtp-Source: AGHT+IGPYHCm9MQeMD+k3mqRPa0KcnOkInYXb1NuDo5tGwfYXGvXye4g3CVBInQyYWhnhNgabrp8Bg==
X-Received: by 2002:a05:6000:2585:b0:390:f0ff:2c10 with SMTP id ffacd0b85a97d-39d8f4c95eamr2399057f8f.19.1744288716341;
        Thu, 10 Apr 2025 05:38:36 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:42::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d069sm54724525e9.17.2025.04.10.05.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 05:38:35 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: [syzbot] [bpf?] possible deadlock in __bpf_ringbuf_reserve
Date: Thu, 10 Apr 2025 05:38:31 -0700
Message-ID: <20250410123831.1164580-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <0000000000004aa700061379547e@google.com>
References: <0000000000004aa700061379547e@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: https://github.com/kkdwivedi/linux.git res-lock-next

