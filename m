Return-Path: <bpf+bounces-65570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E4FB2564F
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 00:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9609E883784
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2742F39DF;
	Wed, 13 Aug 2025 22:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+LCJT7O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB6E1373;
	Wed, 13 Aug 2025 22:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755123210; cv=none; b=ateDRULXWH1l5I1p5SQJ06kaWBkRsmzICZ8u8gAb0Z18WwbTTFvdE2P6RUdgDGBFrfChLug3ODB+1/IFJ/TrEukVwVb6Mnu2sbGoWqscwtfjdKI1YBV4DSPzwbruh1/SaFb6eHlT4e16j6csxwbUvX/5aX8Szr+tpPpsX0iiqB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755123210; c=relaxed/simple;
	bh=wsgTYWz+q5jarASqIiz5BIS2G/GGIrV62OlpbkLocaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TRMOFQJ6uKAgL/EQlq1RyjUNYsiZdExdY7YMATm5/p0aNOFV0PuX6/SFxo+uBLKBKUM6AqV4Zk1dfWpXYwidhRSHpD83es05g9BCQ77Hd3e0VTxG7EuIO4j6acRbk3KAmrsEKLMsP4J8Sku0k8vMjFmQiByF61lklAYp7EDTeHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+LCJT7O; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b0bd237so1976755e9.2;
        Wed, 13 Aug 2025 15:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755123207; x=1755728007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dDFPVS137ylDlXC8OWHO8bXFe2oiIQi6ZcxoEUrV+VY=;
        b=N+LCJT7OoSn3pyGXTIFnWlVUfLqrSreWsFnAPal5eWh9DmY3fwWDdSjVubkQtDNqiq
         sTSIXzmF4blWLWjHxtpdK6FBlgcq/iCoBp3lq+JBhsWz6clfYjIVhE+tSMx8f9UJxNf1
         PkNpqFuxFiYFaqdN//+nHXwkgbxoTnV+meH2dXyJS+rA2vZJl+mhRLkGtODdl4ekANKR
         pbgEAYYmvi0y7r6sPuvmcphcKPDNzazIbPqI1jqNHbfInBbEAMltJY1lYL4eHHtNe7t4
         +jPsAwYC0pJIkJLvX7pilPkJqKso+bN/Gn1eBSiLxF3CjIUUBUGhefle67ygbWiS4iHM
         9rmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755123207; x=1755728007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dDFPVS137ylDlXC8OWHO8bXFe2oiIQi6ZcxoEUrV+VY=;
        b=RNYmqgGW7iKtP3J2HuqxpGceMpIxhMcjS3mgMplBySFKhHSUdhvYgo8kp3l5XTXfXm
         EplMOl1y1aEwMRNu3l4XIhr4jBhvsxYm+Sb4N+JkF4gUO+cdCsPk8Nc0DpomU5hddbUG
         52mI0wAZB8ZGMch81/wpqfhemo00H7VpHIi9vqhdpBl0MdzJbl6BkNLexe9WtsUS39qO
         nCuqtT7Q/gRnMp6OWd0B3cEi2n9/6aIewCcSR7y7ifmVagvZIxxtJ/VXMoGVN+SlJdk2
         D33ecmTD+Oa9s5U3ss/gJz17A6dDvvmclbExgHR50K4kvLXulhcWyhIPMr4UlDjpi7d1
         sQ6g==
X-Forwarded-Encrypted: i=1; AJvYcCU7o8r/6bqA4L0ToH+dXDfKX/XmeyYqV7GUlqib/gDVPzXy35rcpUWA3TE35Rm2r24gVuQwtYMrL36p@vger.kernel.org, AJvYcCWLYpHM5uwmX+VpOY6SjoqT6lHnpuZLwdI4APk8H/KpCIz+4G3uqWNTeeE/4MPxScoR34s=@vger.kernel.org, AJvYcCWMtVS29jGJArmJW/j+3dzLmvCP7lNVFeGULhlJkOK99mR/00hb1IUfSZ2gvzdnfQLwfC65mwAM9yqkckY0@vger.kernel.org
X-Gm-Message-State: AOJu0YyKCeytlpgkROVHMogqa2SL46N93dbZwlIvQEwQLMAMsWF4h4ci
	pWpQ7jCSskUA7CPwva+7o9f6K4WklR28Z0A9LxXrecVLITUf9H2rXP4R5n3NnNrT
X-Gm-Gg: ASbGncsZN4r9oxVZcTq2RJVTXFWF08ZVAeZr817PjWAVECdhjdinrWBRe7C1ePhjRAX
	AcmRWurw02p6ELmjqL8HAA5Ne6b9WFGQskN/NroPcD7TmzIJttQMaECnDZvDKuECb76rIUPZvC6
	OI+O5XST0Mb8CuXOd1oxQovkwLXwjTrUb70mIEMUKpodB5IE4/AqB9iur1xW/WOqcWRrFFq9DuH
	kKeykZPg/lqAoxO06bb0l1jc3HHW001JaxE7utJ9lloYlPNzOBr4tuRIqJFf7JakW8EtSpy0XLA
	rNiJXmo+V9mNcELRAVtyXS2fDttU+nqxllufIqcr6w+6JOsYEbUPU8AyUC/OnmwdZgYwuSorsO1
	+Zt7N7hK+Lo0g3Z0f
X-Google-Smtp-Source: AGHT+IECbO9+5qI7uaiWbS5VWSXHf5AGxchCFUBpHcwjiq8LorAwKXhQGgIrDpK4ib5mNrXuEDWaeA==
X-Received: by 2002:a05:600c:4f89:b0:456:1ac8:cace with SMTP id 5b1f17b1804b1-45a1b60f933mr3496885e9.12.1755123206799;
        Wed, 13 Aug 2025 15:13:26 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a50b90dsm15998425e9.1.2025.08.13.15.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 15:13:24 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: aleksander.lobakin@intel.com,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	bpf@vger.kernel.org,
	corbet@lwn.net,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	hawk@kernel.org,
	horms@kernel.org,
	john.fastabend@gmail.com,
	kernel-team@meta.com,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next V4 0/9] eth: fbnic: Add XDP support for fbnic
Date: Wed, 13 Aug 2025 15:13:10 -0700
Message-ID: <20250813221319.3367670-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces basic XDP support for fbnic. To enable this,
it also includes preparatory changes such as making the HDS threshold
configurable via ethtool, updating headroom for fbnic, tracking
frag state in shinfo, and prefetching the first cacheline of data.

---
Changelog:
V4: Update P7 and P8 to address cocci complains about PTR_ERR

V3: https://lore.kernel.org/netdev/20250812220150.161848-1-mohsin.bashr@gmail.com/
V2: https://lore.kernel.org/netdev/20250811211338.857992-1-mohsin.bashr@gmail.com/
V1: https://lore.kernel.org/netdev/20250723145926.4120434-1-mohsin.bashr@gmail.com/

Mohsin Bashir (9):
  eth: fbnic: Add support for HDS configuration
  eth: fbnic: Update Headroom
  eth: fbnic: Use shinfo to track frags state on Rx
  eth: fbnic: Prefetch packet headers on Rx
  eth: fbnic: Add XDP pass, drop, abort support
  eth: fbnic: Add support for XDP queues
  eth: fbnic: Add support for XDP_TX action
  eth: fbnic: Collect packet statistics for XDP
  eth: fbnic: Report XDP stats via ethtool

 .../device_drivers/ethernet/meta/fbnic.rst    |  11 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  82 +++-
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  75 ++-
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   9 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 458 +++++++++++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  23 +-
 6 files changed, 576 insertions(+), 82 deletions(-)

-- 
2.47.3


