Return-Path: <bpf+bounces-16896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDE28075E5
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 17:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A3F1C20EF9
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 16:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261BE49F68;
	Wed,  6 Dec 2023 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PP06sh+l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FF5FA
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 08:58:32 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-db632fef2dcso5357723276.1
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 08:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701881910; x=1702486710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EIC0cIX/Jrdzxv/TNacso5Xh35dJeqA3h0i9eLygd+g=;
        b=PP06sh+lab9gouDQEhhmfvVYwGnHqgCHgh3vj6YQUHNLwU70RhaG7d4fXAx8T0K1fB
         rDj1WSIPcpQceiN8u0+7mbIZxVtWlaXEo/R8qNbAaRmyg68HoCq9eeO7ligoaswIzPOR
         g1bQz1wc24DTONgih/tipbmmbIZ0kkhzDz3f1j0ytGMkAj4gL0q8ZqEZKX1qTW2hQCR+
         1IFIFDsW54aoqCcorLGdyjuwy9pyQ4cI9qKlaNmKJO9TOx8rZrr5ji/RWcKP9lJ07o5q
         bf532OEgLhV2ONWNjbQGMNlV0JYR26FBYYQKkMcgxhGSVY22kTEvmPEjJbsY+qEVJ/iG
         ci1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881910; x=1702486710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIC0cIX/Jrdzxv/TNacso5Xh35dJeqA3h0i9eLygd+g=;
        b=A4meZ98Za8LFqWQLE4hdP+dvDmVB9PJBC7wi/eCRz+r9lXc2JnMmnF2uEag4261OfC
         f7kTsxBumTlVD8LiRCnFDd0EYyaMEouqYhPTSAofLcvwWom17wAxmwlbV1esfh75nxIW
         EEKfj3rBTs9Q1CbJOBdiQeo/ssJ2jqF0bfOa2twNA3Xck3pPezoKrVwXgbnJ4BBkMLcD
         DaV7/LyJO8ehVsvKgv0g6f/KYFrbVjMoctCQ85DQgCGWaBQHv3tRJ/pIRfTOP9Qhi7M8
         BT5vtk+4LO2qryALXb+yIDwuA8Un8+51nsopGCrfUIzRDXcLKepW3VY8ffF/WPKDdrPf
         MFHA==
X-Gm-Message-State: AOJu0YzUiHaA9QQot/HzcLC7PwOnkciBljq3TieY2pKAFPhtC3Hr/qRM
	DpzpgzQB/Zu/sp2MJLo6jzEcTVofy9k=
X-Google-Smtp-Source: AGHT+IHRhoK3MQsRYyVNAJ3gJzLVbDRcpSwzmkhMUqqbhehd2cDStI79atQ35X3ACenWKDgoxFYuSw==
X-Received: by 2002:a25:aac2:0:b0:db7:dacf:59df with SMTP id t60-20020a25aac2000000b00db7dacf59dfmr868067ybi.83.1701881910220;
        Wed, 06 Dec 2023 08:58:30 -0800 (PST)
Received: from andrei-desktop.taildd130.ts.net ([71.125.252.241])
        by smtp.gmail.com with ESMTPSA id h17-20020a0cf8d1000000b0067a3991d002sm118372qvo.30.2023.12.06.08.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:58:29 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	sunhao.th@gmail.com,
	eddyz87@gmail.com
Cc: Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v4 0/2] bpf: fix verification of indirect var-off stack access
Date: Wed,  6 Dec 2023 11:58:00 -0500
Message-Id: <20231206165802.380626-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V3 to V4:
  - include a test per Eduard's request
  - target bpf-next per Alexei's request (patches didn't change)

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


