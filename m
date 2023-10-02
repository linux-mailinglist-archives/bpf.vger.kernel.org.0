Return-Path: <bpf+bounces-11194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC18B7B5323
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 14:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A10231C20AB0
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 12:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D55199BC;
	Mon,  2 Oct 2023 12:28:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47EF1775A;
	Mon,  2 Oct 2023 12:28:16 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7414BD8;
	Mon,  2 Oct 2023 05:28:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5346b64f17aso13394792a12.2;
        Mon, 02 Oct 2023 05:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696249693; x=1696854493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mT5GWJnaTH4P1kD5M11l1lYox9NySbmlcUDconn0p3U=;
        b=Zx/9RMfIkTFIfdI3OI1hs80il+OMY8xQhPcTWcmoP1bKMb+n5ymWASD2NUYjt/ZFWh
         CKqH+cjKLLGO9BsWcYSeXJVXiyChL3IyBPSr/iWkUDbBC9MCrqU8nvJKOa5IBUfFhlXd
         BjJaYEIJE2tvzwq8+Gjr/M9KkJ+QgcOHbIlAaAr45Eu7C38pvNa5RwrF45PDFlsZQAR4
         hT+3NWx9946PWamOc4l+Wxhrr578p5J+yfCguPjgmIu427cx9k4u+PpDEygvs9kbdGBH
         bUJPYUMlz/xVl9r/LWhWjnG7Oz2oKjP6ewm/YYYa3SaXOKc8sFyTFAXQZn/wpD/VZ60T
         mElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696249693; x=1696854493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mT5GWJnaTH4P1kD5M11l1lYox9NySbmlcUDconn0p3U=;
        b=F20MoJXbfQcCj7+afq3jezLvSfwyJ37zocwZfkHl+mVGuLWutCS/APYofvVXbaihsd
         +wd0o7O0rPTuqZs7xonvFvksmNgZ8Q1/uO8FS/8DteETpzfCXFPP0ekJBWNEo0WqMWhe
         0br2Sj1b/tLb9wN1JGMicD5q4pOsYCX9CnBulCDntovtuDAMdhTRygPfu4MgsQQrFGTd
         8jhpKNIKjK/k5UGV9OnH0pJRic0TxsYy/3OtIpT93vvd4l4jM9YcQi2l0p0k9d2eLadj
         9AIliE3woazIBxz3yorGWaOtYuyOuBIQVmms77m7ovrVl5q9LlLjHNLtVDPZk+SGPQpQ
         YCYw==
X-Gm-Message-State: AOJu0YxBfYqVD+iVaE2GzZcAK0G/pEXgH9wSVEO7RwGliN8HUg+EdERc
	SB3Ii3fY2CLKzxvfM+h5w7BTF47OcMi5RyNx
X-Google-Smtp-Source: AGHT+IFXl7/lDvd4TW8jzeeRRRYmNkRSy005SPfCpLThbchCNd6luswURXWIAJwctYUc02+amjxmgQ==
X-Received: by 2002:aa7:d3ca:0:b0:534:697c:3e65 with SMTP id o10-20020aa7d3ca000000b00534697c3e65mr10384067edr.36.1696249693517;
        Mon, 02 Oct 2023 05:28:13 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com (2001-1c05-3310-3500-aa0d-0bb2-d029-8797.cable.dynamic.v6.ziggo.nl. [2001:1c05:3310:3500:aa0d:bb2:d029:8797])
        by smtp.googlemail.com with ESMTPSA id v10-20020aa7dbca000000b005330b2d1904sm15263099edt.71.2023.10.02.05.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 05:28:13 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v7 7/9] documentation/bpf: Document cgroup unix socket address hooks
Date: Mon,  2 Oct 2023 14:27:53 +0200
Message-ID: <20231002122756.323591-8-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002122756.323591-1-daan.j.demeyer@gmail.com>
References: <20231002122756.323591-1-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Update the documentation to mention the new cgroup unix sockaddr
hooks.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 Documentation/bpf/libbpf/program_types.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/bpf/libbpf/program_types.rst
index ad4d4d5eecb0..fa95479d1f6f 100644
--- a/Documentation/bpf/libbpf/program_types.rst
+++ b/Documentation/bpf/libbpf/program_types.rst
@@ -56,6 +56,16 @@ described in more detail in the footnotes.
 |                                           | ``BPF_CGROUP_UDP6_RECVMSG``            | ``cgroup/recvmsg6``              |           |
 +                                           +----------------------------------------+----------------------------------+-----------+
 |                                           | ``BPF_CGROUP_UDP6_SENDMSG``            | ``cgroup/sendmsg6``              |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_CONNECT``            | ``cgroup/connectun``             |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_SENDMSG``            | ``cgroup/sendmsgun``             |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_RECVMSG``            | ``cgroup/recvmsgun``             |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_GETPEERNAME``        | ``cgroup/getpeernameun``         |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_GETSOCKNAME``        | ``cgroup/getsocknameun``         |           |
 +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
 | ``BPF_PROG_TYPE_CGROUP_SOCK``             | ``BPF_CGROUP_INET4_POST_BIND``         | ``cgroup/post_bind4``            |           |
 +                                           +----------------------------------------+----------------------------------+-----------+
-- 
2.41.0


