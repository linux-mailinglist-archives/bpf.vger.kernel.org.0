Return-Path: <bpf+bounces-60178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB99AD3829
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 15:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93AE07AE22C
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 13:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC732D8DD4;
	Tue, 10 Jun 2025 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdVaXtV1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C262D8DAC;
	Tue, 10 Jun 2025 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560408; cv=none; b=FYwubTxfWA2D1sqfJzk/lwLug2XcKFIxDaI7YoAYTB/SzvZzcjDW/7X5JXE2xN06/9VdS/dAmuo2UAVgNuNNW4zX1OXCW0j0t/Vh+gTpoVBK9snRQkMnh9s1hwF4DA8PflFBZ3aQdZ8zEHGpZAQlqw0dk19ChhiY7M8hs+6S8rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560408; c=relaxed/simple;
	bh=IlPcq3mFEXCcNLGdbaA7USQGMuvLdkvGnpYHgSkEQWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0m/Sk7ulV2PeDyB/vxuVlK+U2MkBsghUGI9pgCOvK8p02DotUHDJ4a1TGKd4EaY7r+cH9u1HqvPu8sBzdLHzEko2CndRRr7q1Dz6v8fJpXrQ5I4MfCgBYwN6pIrjhLszKEPkmpsRlg2OKOW5Z6RZpZbE2DaRci//cYiD22TodA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdVaXtV1; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a50fc819f2so4406348f8f.2;
        Tue, 10 Jun 2025 06:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749560404; x=1750165204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMxgXQ0jevyDJ/ND5HyBUsgL+Iy2YrdC73ZOx6fVgQc=;
        b=QdVaXtV1vwDep6KC/5LbwwutLQ7Je0HF/bIhtK58UqOxR7BgXFlRxpmKXEZxetfPyg
         GJEci7wM9Aoq90D4T8FUBDkLgPjxZUYCH1HRCfPKx6W3fCiQJecR9yXjrNfxEqxUqmzO
         yg9JVWTYDXBeChuigmaFtgqE++WlI2nasdK0GiSbdRpYODyCDF4GvVbjH7ziLX1SULC2
         4FDbh57Wsr5KCA3lbmCWWgPhA7gnMON6g07L0xL3sNiksmKmjPJdurSSfi93A2AGqNYc
         AXcdD1/GzE1+9v8KP6rQUNebLvCsvZkxkgktPZZCCyUITMtqgPPTCVT97iyjzma7RkC/
         jtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560404; x=1750165204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMxgXQ0jevyDJ/ND5HyBUsgL+Iy2YrdC73ZOx6fVgQc=;
        b=w4Yln0xGOro3dvqzOqZtQp/T/HIpaS9jXU+t/bLnfaFt/mg36kaMzSn0+qB24q3JIG
         6lOesBWfvRNDVJV2M0eBeN3ChYqqyqyVhD8S0ub7NhHAK4WJXQi9xixdH85opqXnNp8z
         oq09aT8eCoSj1xHadYygz6uNqzmsiwD+Yd6nxSq2KiDGaMqV/FdHCrz7yBLeTHBDUP9x
         cDA+kg+EFsSjpYDvURhBAf+N1nfP1F01NIaG9/8YR8dHEhIlgjuvlQQse6928RSHhl5Q
         5AWLZ++Hvm9RdD1Ce2EEkPRe/4nck/9pWqSy7f8eE/JNyzBkYypBpDwR6W/PqF3wuS8Q
         /tKA==
X-Forwarded-Encrypted: i=1; AJvYcCV5wA4+PhP466GCw40MoRuFDEBDxvquUvPv3tscAcqnafnvb6K7z6EfehMX2N2C4QxFJuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxscxo/za4s/0Iw2hmjnvIK59XBVX0vQnOinNdvU3wn4rJOUYc9
	l63N8E3dB/lOsv1KEi2w2NK4skAuEJCbhsvkpdBInO2s7AW4OZxd4TNrHqYVlg==
X-Gm-Gg: ASbGnctLcpkn75t5waKFqkA/DOJ+1dUAlyvg0vdFsQpP4PwHPqjV2Q5QmnWAU3hYT8a
	6UrYclk79K2wnFxLTsyaBpJnAYQZdUMTw5Npm2tpTAmD5NMVg9XqHA/udycTn9cYjRteb4MxK7Y
	qm7cRupu6rLfw2bKf5y+HyGvaIx/yEpd/x78UoZTE2eHb9J8Iu/S3msZbZl+5vNg1EmU/0Lsvfm
	esdqB7L+w31f0Ql3EQfXw6d3Jp8G5AjdGaklDyHT+TGlsHC1U9l2SA5/fBmaGp/z3EzOm+Hbr0R
	vlpGRXFUizlO0i2MZsOlZbXa6AYmoW+0mGqiJL2Z6nlBaT7qclru/75C/mxyhumGUp2p+BtC83u
	FVOvivtTvfN6VSm4=
X-Google-Smtp-Source: AGHT+IE/fK31Vav6E/nuroESCGrP8TVj+xyjNp3FjK6+XBphGx5l6s08v9+9QjO+BXEI9E7lHxx6ig==
X-Received: by 2002:a5d:588a:0:b0:3a4:fb33:85ce with SMTP id ffacd0b85a97d-3a5522caa5amr2342209f8f.46.1749560404186;
        Tue, 10 Jun 2025 06:00:04 -0700 (PDT)
Received: from imac.lan ([2a02:8010:60a0:0:6117:17d9:610b:9e0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452fb381abfsm130563485e9.17.2025.06.10.06.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 06:00:03 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	mptcp@lists.linux.dev,
	kernel-tls-handshake@lists.linux.dev,
	bpf@vger.kernel.org
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 7/7] netlink: specs: fix a couple of yamllint warnings
Date: Tue, 10 Jun 2025 13:59:44 +0100
Message-ID: <20250610125944.85265-8-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125944.85265-1-donald.hunter@gmail.com>
References: <20250610125944.85265-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up the remaining yamllint warnings in the netlink specs:

    [warning] comment not indented like content (comments-indentation)
    [error] too many spaces after colon (colons)

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/devlink.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index bf54eb2b639c..ad56093d6ead 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1139,7 +1139,7 @@ attribute-sets:
       -
         name: param-type
 
-      # TODO: fill in the attribute param-value-list
+        # TODO: fill in the attribute param-value-list
 
   -
     name: dl-region-snapshots
@@ -1266,7 +1266,7 @@ operations:
           attributes: &dev-id-attrs
             - bus-name
             - dev-name
-        reply:  &get-reply
+        reply: &get-reply
           value: 3
           attributes:
             - bus-name
-- 
2.49.0


