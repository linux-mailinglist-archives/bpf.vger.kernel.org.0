Return-Path: <bpf+bounces-16781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B2D805EAB
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 20:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3CE41C21147
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 19:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCCB6AB8A;
	Tue,  5 Dec 2023 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGdBfjw+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B139F1B2
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 11:33:22 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-42542163a1fso175151cf.0
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 11:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701804801; x=1702409601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fGQQlXDIFZkP9BaEk7dqXwqk2EQYmuSO+xo1uPaB4oA=;
        b=RGdBfjw+jwyAfasyDNKMdSzcQc4FNZWF5AigbsbYB53D0eYjDaLshYSYUZSMI1Xxla
         cI8OUGrhFvBSp49iyd+WG9sALfX0HmiGxlKKzCxFx/4R94BaSrcsxLNFn9Qog+pRmqW6
         nplw+vQWlGqic+jXw+wybzQtIZUukGybAp99I0mx6KfOy92isRYx4fV1r3qMq1gxa6iY
         uhMJsWdQWbEoNk/jM19V7uT0XSTUs0q1fBfOOsciTk7jzUmYR6jhu6NSTyTwu5rJPAkb
         rhiP/nPfsnyRmLqcA+0RLpauY7kFHqAaFY8DOnXkrw6MFE2RnPocO+OnQvdA+AzGMqCS
         OQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701804801; x=1702409601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGQQlXDIFZkP9BaEk7dqXwqk2EQYmuSO+xo1uPaB4oA=;
        b=uoUQgag/xCH2410MK9EdqUjqibFbh+EcyUFdySFvoJJ5E1aZ424aU6jiSMijF011bQ
         4ugUaaHdx7gOe0ovfPWiJCOSRWmPcVcF77NxjqCbGNrr9f5YqIZEjC89hf2poqFt+j+T
         /2UhfG1QhWJlVXg5cdWD2BeVefc8WhpnrE3VA6KAltE805mHFhAf0sLHOTfTFdHDpW4r
         V0jyivQZGazHnx59M+7E8H4Y0hxcP2TLRiqjMIabFFST/NUN3Jqqm9ZAvGBUWBDAV/mb
         cH1FfmXe9dwe5XByJ7sMe4yFCiwsN+AjKUIz/wznhnUodvlz4TVLkmaWaBpmoP4j2oTl
         KFLA==
X-Gm-Message-State: AOJu0YwFDU+Gd60dVeO+qKweVABTIm0daTvKsrW5un63ZGb0c2RZRYBV
	vi1N207R1Zkk7upcwWRZBHw783dwYwY=
X-Google-Smtp-Source: AGHT+IFJXnX0dnZ1uoUB55QE6s685oggwrXh0aSjkKskngG7ZPy7+tQaprpQ3l0kNPGdoE/tgH477g==
X-Received: by 2002:ac8:4e84:0:b0:423:708a:778c with SMTP id 4-20020ac84e84000000b00423708a778cmr2387070qtp.64.1701804801117;
        Tue, 05 Dec 2023 11:33:21 -0800 (PST)
Received: from andrei-desktop.taildd130.ts.net ([71.125.252.241])
        by smtp.gmail.com with ESMTPSA id kg18-20020a05622a761200b00421c272bcbasm5334588qtb.11.2023.12.05.11.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 11:33:20 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	sunhao.th@gmail.com
Cc: Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf v3 0/2] bpf: fix verification of indirect var-off stack access
Date: Tue,  5 Dec 2023 14:32:48 -0500
Message-Id: <20231205193250.260862-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V2 to V3:
  - simplify checks for max_off (don't call
    check_stack_slot_within_bounds for it)
  - append a commit to protect against overflow in the addition of the
    register and the offset

V1 to V2:
  - fix max_off calculation for access size = 0

Andrei Matei (2):
  bpf: fix verification of indirect var-off stack access
  bpf: guard stack limits against 32bit overflow

 kernel/bpf/verifier.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

-- 
2.39.2


