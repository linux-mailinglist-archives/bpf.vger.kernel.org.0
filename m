Return-Path: <bpf+bounces-60226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8A2AD4285
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 21:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3848E3A53FD
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 19:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F4525F993;
	Tue, 10 Jun 2025 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOVBtjyf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897CB2F85B
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 19:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749582528; cv=none; b=OuU0nYr4BitnI0p4xMIbtcAaNmicDinCC/8+E0L4Wns6Gt8qpi5iOhk87i/Jgub8ZAiweNUyZbABarysSa/FSAZnS8yY1D2HMX5nDjsOn/Pe+N7SI9AQv/9GCI74WRdr1dH0zejIKIX0+PGtv8+GGT+Ut6nXOHAFmq/G2B99iMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749582528; c=relaxed/simple;
	bh=G5cmCWssvtB0g8EivYSrcHYViJvxokuxrownJYFiwcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iBIJXcHwTtVNOw/SsS6m6uLJ0+4hEsN26aodEzqXqLr9I31dO44APHXr/6pImC06/NiMe2zkJLfBD1nZQrI0GOx6d6q5h3aON0eZbpub/VLsvxuV9mNEKPrelN8do5liBqGVzV1bjzcIdd1v2u6xNaRm+jLW1EbuaGSZhpzq4sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOVBtjyf; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-607b59b447bso6003412a12.1
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 12:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749582525; x=1750187325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ClWMufmokWJEVEIWeLFwUB2RAV8n9pkqj0wZxwdFlCc=;
        b=GOVBtjyfx2GQUw7J12eKPpGDvGFo/+IRFvHOrLge9oyjyvBZcit8Hy/36b91eDbiM5
         PpPuxEeHkqNYVdqSPIR/+g47mzFNfAbNdfvKTf75o1SqY2KAnLzbecf8lcl4MwfEWXVX
         6rwXhz8a5Z/KNGIAcGengIqOrrwS/+fkwDShKpULwCmNtFJLGwb1rXDWWCCKkEYScwvG
         yFuTWwbK5c197ixrsOsvDMs8/owHdWyVrjk69aTJBpTpQ0rmb2JXPD/CfEbzKGrlRAQi
         psEnTdqWwAk2I+6lZXIghuElLPhYViqtgojNB6QE7UKpMCyX3i2Covz1OXNTiVJiTgYH
         UnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749582525; x=1750187325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ClWMufmokWJEVEIWeLFwUB2RAV8n9pkqj0wZxwdFlCc=;
        b=ceVz5S0NIes41iWn4zPjjmchKrXemq4Ag2OCS/EJgU+E60p+U8YHp2B63XAs6XKZb5
         6YkodM566E2cQQXd433MwUi7BmvqzavaaGhitDdK0SGvGOgCK0viSINXWO3Dla80+ZR8
         WuwJs4b0hTmEG3YOyUyHjmXz3Xj37btYqKOHhw+JH2/H5s4ez7KPJif7DjNAPw8nvQKd
         JMhfuajsWzlFbtXfoDA6U8WwgEIh5ntqW4D5SbO2w268M6ZtdPs2dfxx8xSCVmzhKiLt
         v7DTpSr8l66/echeiiEIsHWp85YAFpJlU61zw6Q6bIk174FCzsBBvx8FBALe0PwQT8RM
         jn6g==
X-Gm-Message-State: AOJu0YxrbbwdvmNzSjB8fY26kEkry3BclR181yRaGBWSX2fXI3Lz1xtz
	SXasg8l05UwRUxlbhNL/PzAR9Hj68EkQbvM6AdIHkuyytpMbO/ZBw3VzpR8aJ5bEQ58=
X-Gm-Gg: ASbGncuBwBoENYIx3OyJpa7yRu22ud13+KxpP/j8Mt24i3UuFVucmwnFB1eakAdt+hv
	I7izS+bGpFPvFAT2uxOGRs4Kgtb+64BZCETDoMZKqnpHedMjtZF64j9weTic/2yaYjMhBxVHNCw
	Z75CnVwdkmewvlBWLqAdqCRc60S0uU35jV3ugD4g0XukB6oZD2GS3iSyMl9jOsstZJVkqTYCpLh
	La/2rRu5Qeby8hLDjfmxM24qOu/uktUDT2gr26tjXs1nmkdxHZOasQ+wXutlt+oCIngufw3v00J
	SXo+Hm84CjfO/iK/X19li0CZowKkf5uAmPdRvuJI3ZPWx/NhbfV5
X-Google-Smtp-Source: AGHT+IFfS36Bb5+mTRFTjxzkrnW3BUZoL5/pMsM4Envexd0+5ZBC3VRf8+Pbo9LE2QyPbfVhck8AlQ==
X-Received: by 2002:a17:907:748:b0:ad8:932e:77ba with SMTP id a640c23a62f3a-ade8977ca3fmr55066166b.38.1749582524544;
        Tue, 10 Jun 2025 12:08:44 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:1505])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1d7541fdsm766172266b.27.2025.06.10.12.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 12:08:44 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 0/3] Support array presets in veristat
Date: Tue, 10 Jun 2025 20:08:37 +0100
Message-ID: <20250610190840.1758122-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

This patch series implements support for array variable presets in
veristat. Currently users can set values to global variables before
loading BPF program, but not for arrays. With this change array
elements are supported as well, for example:
```
sudo ./veristat set_global_vars.bpf.o -G "arr[0] = 1"
```
v2 -> v3
 * Added more negative tests
 * Fix mem leak
 * Other small fixes

v1 -> v2
 * Support enums as indexes
 * Separating parsing logic from preset processing
 * Add more tests

Mykyta Yatsenko (3):
  selftests/bpf: separate var preset parsing in veristat
  selftests/bpf: support array presets in veristat
  selftests/bpf: test array presets in veristat

 .../selftests/bpf/prog_tests/test_veristat.c  | 136 +++++++-
 .../selftests/bpf/progs/set_global_vars.c     |  51 +--
 tools/testing/selftests/bpf/veristat.c        | 312 ++++++++++++++----
 3 files changed, 403 insertions(+), 96 deletions(-)

-- 
2.49.0


