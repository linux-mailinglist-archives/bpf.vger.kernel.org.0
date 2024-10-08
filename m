Return-Path: <bpf+bounces-41233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EDE9944EE
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5239BB27D7C
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449691C9B77;
	Tue,  8 Oct 2024 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J20Bhgsk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1FF13B5B6;
	Tue,  8 Oct 2024 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381113; cv=none; b=groCkKNFPJPcJaMAA7O/++JKGfp+Y3hbDVXOe9HB8m9QN1+48pQqOW1Lo+Np6obGRUaDKg+pjpzvsm3xXVbDOebrDPJhgQrTTb7UPxBaGzAaU1/YDc0b6IztqHZkOZ9sKfoKe15sjRGtx++hpILDvwdyEYOhoBEP0B8Uc6V8HSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381113; c=relaxed/simple;
	bh=xFBByvFkLIu4AQ27aNKVqCxmgrN9nMCQNauZKfY+88U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qhjMc6fqHEWaAGlzAk+0LxzBq4MbXmJeNWSwJSiET/N7k04GqTIgq2Q15m6+THxB64zQRWIjpR2WE1l0uL5WXk19/Opl4gr7cIzGsMLAH0thfBeVaq3IKuY4+moGXlIAGVifKE7+0FGpbylAbcH2FufwhOEbeHRh/BEPk/zEBK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J20Bhgsk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c544d345cso3482505ad.1;
        Tue, 08 Oct 2024 02:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728381112; x=1728985912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/11O91Y2noQGtDmKmdMCq9aNUAJv1qVR10ooAo+aIXE=;
        b=J20BhgskpHD036l6J+J0g+WxZ48Cq7aKD4T636z9wkSQujWeD925SU2gZFm4aOsw8Y
         Twabo58EqydTsjs+BtM/O6wZZY4YJN9FWFhtncNDkHml4oCo1kZ+SzI/bsgw6+DEgUXm
         H9wZSJg4EdJ8wezYKbg0mW3odHykIvKIo2ueeoTus9Ioov8esrvIC+6AOPWh4+x5nP/M
         Lwm5akyiDfnZvjJPE0ZQowdv3fTTNoBsmf8vQARqa28bbFV3R2UXVCPYedaLcYHDcG0F
         OnqT2PtR59GeY2ZSWRdJOli2klJ3ak5UVGDQ/LCq4/PbXTkzPinGBvTD8jVRE+FpHkMx
         UJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728381112; x=1728985912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/11O91Y2noQGtDmKmdMCq9aNUAJv1qVR10ooAo+aIXE=;
        b=OmzvblyhahZ0QmIXrvyXyQ+CAnzH7JJK+Yx3pgvOJvLprPax7MQe/fo97N4fV6g9q9
         cZZR1IwDyXKpf+hZfycUdUo6Zh1JnWKfPd6i+I1WlDJm9cb1PXRQpzuL+theZljStqXh
         jUT8pJi9SNoI+mWXjbQRc7bHWQ/zADJIdwCPs96U9RBZLD/88yF14yNPwOD5OtfB+SJ9
         ZQ6ifPNJihM1IAbDcHXzu29GUzvUnkzCIn/ht8uFHDtkYZPkFeC/GqH+h4PJ2zGEGG8J
         wtM8zC/GQnCXOwuSQUFiArazB1JfvIIgCTOCeIU2H39Nv0qsWg/3afy2A5ZS0aE26MVa
         ReRw==
X-Forwarded-Encrypted: i=1; AJvYcCV5meUXP4njNNOIW432KDhSS+54qXRmGrm6r4duEStzRUj3yZLuR1Uw26rhnwnHkucFCkGB67U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCINmHzg5Ly2SZqQYSaXfe8bCbAZ4ZfTxqNrpL+O2DcX4CU0vC
	H7dSa2Rn7fwPnCcrvngXJ0fziNiaCMwZtM5p56d8zzG2QP3SK1MI3alvlQ==
X-Google-Smtp-Source: AGHT+IF0opgbN45nBSvuuEM8DQ9bXHWOWn6ywaXJ/mPro9T0DAwTBOueT9K5q4kq2bL7pSVRWdZz5A==
X-Received: by 2002:a17:902:ce0a:b0:205:4d27:616e with SMTP id d9443c01a7336-20c4e3164bamr45045205ad.22.1728381111818;
        Tue, 08 Oct 2024 02:51:51 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cfd25sm52527345ad.73.2024.10.08.02.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 02:51:51 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 7/9] net-timestamp: open gate for bpf_setsockopt
Date: Tue,  8 Oct 2024 17:51:07 +0800
Message-Id: <20241008095109.99918-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241008095109.99918-1-kerneljasonxing@gmail.com>
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Now we allow users to set tsflags through bpf_setsockopt. What I
want to do is passing SOF_TIMESTAMPING_RX_SOFTWARE flag, so that
we can generate rx timestamps the moment the skb traverses through
driver.

Here is an example:

case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
	sock_opt = SOF_TIMESTAMPING_RX_SOFTWARE;
	bpf_setsockopt(skops, SOL_SOCKET, SO_TIMESTAMPING,
		       &sock_opt, sizeof(sock_opt));
	break;

In this way, we can use bpf program that help us generate and report
rx timestamp.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index bd0d08bf76bb..9ce99d320571 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5225,6 +5225,9 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 		break;
 	case SO_BINDTODEVICE:
 		break;
+	case SO_TIMESTAMPING_NEW:
+	case SO_TIMESTAMPING_OLD:
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.37.3


