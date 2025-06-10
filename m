Return-Path: <bpf+bounces-60217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8340AD4142
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 19:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A3C3A74BE
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 17:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB70524679B;
	Tue, 10 Jun 2025 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJ+E0Ndi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03112367CC;
	Tue, 10 Jun 2025 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749578086; cv=none; b=Py2ZXm3XIuh15GJy9rfofnNcXEizLDAqRW8B2+sIMLNbEERfx9YrCzTAx4gprOxAgEJjk9ZUXlPwYZKJnzfjjyf/1sS1v8Hdk6Hr8NswvwcFaEc2Bo4UDxHqoyjosgx41ZuS4NNseJtx3zrAG/PXgJQ6rYr6ojmYDs8bq0hGli4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749578086; c=relaxed/simple;
	bh=tQJJVVL0eqt772KtNAuNcEbkrh0mO/guKZpsGTY4qMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mK1FeCCgts9HntuA9KnM8HHMv/P5C2vuSQ1kRtWdbIm4KHzvJWfVPZOy+6Nh+0WzE3MSMApvPKJ22TZU4fdVyQt+r7cF/KOakOOYTCroF3lj+sGfBUSIFRAbyUc3akUV9SmpusNcBujJ6jC0i5pHv3XJu9BDJBuksUITs09DwVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJ+E0Ndi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-236377f00a1so11522395ad.3;
        Tue, 10 Jun 2025 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749578084; x=1750182884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e5JsbzcuPMRv3BROQqL987dI+PHmhbXk76yQ+kmKPwE=;
        b=TJ+E0Ndiz90qRjwfRNP9rlZ5VnFbR9VkgcoZ/xeLNLUE1AMqVolx5NB7Hr5fsZChF6
         +u3fDr5c6G5Dhi2rsezpCDgM9AsjXXfEb6xGOvgBERkyI7G7u/7nbaX9yQRh0JBDM706
         l0Z2eYVl5cf0scGNlxQzXQb8+DW/YXmdbNuBC4ypcytrX5E3efvRPPWJWXbRNp98Hpb7
         ypa6O6ZcfNxR9JOc7IDR1PVuhxwavWwV1s1kZ8HqW4Ocq1H3s754R9X/k6ueOfsKPGvV
         BcSa15GvVfcNrPMx8X+ywVEouAcTLOQjF+Uu8Mqbr/N0kHqmBftcwrNpCQcTbw2bpaZA
         RzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749578084; x=1750182884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5JsbzcuPMRv3BROQqL987dI+PHmhbXk76yQ+kmKPwE=;
        b=qd523oR/sJSfMzlFje715BTjWy+rh2On8TKpsu72FXyPQRggepKjeAEVHQn1yj+exp
         BdjeDiY3dGRjebAR6CPNfobE3QAPhjvusnbOB8+75Ooh7G3JsciRew92TIetRMF88zsC
         vDSa4vIwqdofJPC2cDKMUn2AJfye28Hd36RXWCKxgyRwoe1XSLmGob7+2qcQQgl9Yyo4
         YMwI6s8pDGZ+KzsdXpEhBJcWnWxf5NdIIha9LLoAt1+2bnIzHeHQymg3p1SA5TLevIFI
         5JLLpXec45L2MVuuHaWxRJidds3rYkMmaB/VH+6uQXD/1ZQ3t6gwrU4YQVlY8ni4BWLd
         bLBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcHGDg8Re66GRfJcPvJBjT0065E9L9wqM05tYPtsK2bmqUSYhzUWDcVY410wZxdwJgsu+B1Ie5Q4VewCU=@vger.kernel.org, AJvYcCXyDoRLXlfFJUgvRAY2pc022B4Axog+c0CsjKbViNZm5UAp5XzHh567EudH3ZJ/HtvlDe1IAlFz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7DpnbklhKawOJUw9mJfKO4VljKTHUXEL/l5Z0lHPbNnr4frPI
	Q+EpxRr0vXyniCxuTtdEoJ2L6tjhaUR6QhP+j9bDox6HDGbqySPGvwAx1jfX
X-Gm-Gg: ASbGncsIFbMXw9bs7lYceehyEGFfEzw8rf8qlL3eBB4TLtQSxYWm4jgwY2wwxklKd/v
	w1trehKjDu2VkQU86dFaB80jSg0rVAfDA1GLpAKRzytsbdYoaioIxm6w8toVUKJgAvUeGoh6Ahf
	i9yCbYUGEnamSonDUW3NO7Mc0II/h9b38pDs461Mn8lXYbBIJOM5fEE3SdeNy1K7Tnf65SCC09s
	l8iuDpVX87EoPaoCLIshRJyL2rL02AX8Dhk8Q2s5HOx3BFaIaFu1P/pRtWgxP18Utr3RWoTcFlb
	JioAk0bmaOpceHAlvn2b2zQi870nF6w2BAQl1AAwATbvZiMLh3PgG1blA93nOLln5ogHHEFC6GC
	EzzTtWMTEIh5Sp4nfvNPeqzs=
X-Google-Smtp-Source: AGHT+IGVcqG1LowNwUuMehBhqun6fUhP34xVFnmk2EXdHllUdHXUpiYS9CVKQCt4hVUx8kUTyTRQRA==
X-Received: by 2002:a17:902:f611:b0:235:f45f:ed49 with SMTP id d9443c01a7336-23641b1a711mr2483835ad.33.1749578083762;
        Tue, 10 Jun 2025 10:54:43 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23603077ffasm73819425ad.30.2025.06.10.10.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:54:43 -0700 (PDT)
From: Stanislav Fomichev <stfomichev@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	akpm@linux-foundation.org,
	lumag@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] MAINTAINERS: add myself as bpf networking reviewer
Date: Tue, 10 Jun 2025 10:54:37 -0700
Message-ID: <20250610175442.2138504-1-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I've been focusing on networking BPF bits lately, add myself as a
reviewer.

Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/.mailmap b/.mailmap
index 77bb62564ef7..7641338b8d3f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -712,6 +712,7 @@ Srinivas Ramana <quic_sramana@quicinc.com> <sramana@codeaurora.org>
 Sriram R <quic_srirrama@quicinc.com> <srirrama@codeaurora.org>
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> <sriram.yagnaraman@est.tech>
 Stanislav Fomichev <sdf@fomichev.me> <sdf@google.com>
+Stanislav Fomichev <sdf@fomichev.me> <stfomichev@gmail.com>
 Stefan Wahren <wahrenst@gmx.net> <stefan.wahren@i2se.com>
 Stéphane Witzmann <stephane.witzmann@ubpmes.univ-bpclermont.fr>
 Stephen Hemminger <stephen@networkplumber.org> <shemminger@linux-foundation.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 8d314e169486..8e109f4436eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4555,6 +4555,7 @@ BPF [NETWORKING] (tcx & tc BPF, sock_addr)
 M:	Martin KaFai Lau <martin.lau@linux.dev>
 M:	Daniel Borkmann <daniel@iogearbox.net>
 R:	John Fastabend <john.fastabend@gmail.com>
+R:	Stanislav Fomichev <sdf@fomichev.me>
 L:	bpf@vger.kernel.org
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -26948,6 +26949,7 @@ M:	David S. Miller <davem@davemloft.net>
 M:	Jakub Kicinski <kuba@kernel.org>
 M:	Jesper Dangaard Brouer <hawk@kernel.org>
 M:	John Fastabend <john.fastabend@gmail.com>
+R:	Stanislav Fomichev <sdf@fomichev.me>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Supported
@@ -26969,6 +26971,7 @@ M:	Björn Töpel <bjorn@kernel.org>
 M:	Magnus Karlsson <magnus.karlsson@intel.com>
 M:	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
 R:	Jonathan Lemon <jonathan.lemon@gmail.com>
+R:	Stanislav Fomichev <sdf@fomichev.me>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Maintained
-- 
2.49.0


