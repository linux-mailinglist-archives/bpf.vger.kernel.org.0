Return-Path: <bpf+bounces-75418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FCBC830F8
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 03:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A45054E36D7
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 02:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D0A19CCF5;
	Tue, 25 Nov 2025 02:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7vxnYSQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A282AF1D
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 02:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764036477; cv=none; b=i+vlcEWy1daIdZrRpyqEJnV6qwXVlZTrQjrlXZmm8z4gjH1RgmJg0CwXqJhVqYSmohyLZogSK512ZFsIyCY8m+hnc6CBYril5p455DJU0XXeFP/xPzOL9Fwb8DIojMznaqHbttkTcqtVsp6MesoIOjTTx3sviMRT0dKkUyO4Pw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764036477; c=relaxed/simple;
	bh=qzXNCQQ32wh4Pwmht97qoN1N4QOzcA6FZe6Q7D2QVLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cb7qhiTnZJ14HhWdtcB+GzI962NAKp8xVYCgsRFw4jETWdmliS5p4flCJDykdcak/qocaRBdMjBBki6gAcBmm9xAzQo+hArLHIAy/bMjko0LUnXVeMiCHzq5t5OamK711wocle7eJBPS/h4/efp/hNdfLC/An8wEwoVdlDFlaIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7vxnYSQ; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-477563e28a3so33889165e9.1
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 18:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764036473; x=1764641273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qHvVksvpFv9ZGxC9JlTaw+lFET7jsoYLO7qw0Y/E1eQ=;
        b=W7vxnYSQ14ZiyUBXBwLYlrop/OiEV4/BQe0/yb1htQoP7S5iVAg95nI5gZ0QAeSC4e
         kT6AKtHCUJTKUowkjK1fpe0UJiwWQqXnkZmaU02aplbkZxv0VlNU7NLT+w6akMgrrgGX
         iajLrQRLhKu60IPAJpFgH/8JREPee0B38szBM2m949WReZf5UgyYuqkoFKtUxiGPYsp4
         p45OMXtbvdkmTYmV4yw8WsHUh6rIHIK1H9wF8x6xj3HZNpHolivIYnjEO+OtR31t5t3F
         CrT6GkJRYqmI5GYAcEUHN8yBN0dQ1lHcxucDM6HZjV5wkgEWEV2VwTNIZSIrB3t5TTeQ
         Zzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764036473; x=1764641273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHvVksvpFv9ZGxC9JlTaw+lFET7jsoYLO7qw0Y/E1eQ=;
        b=igTLsy5XWxh5NcAqzTarPxkKEfOur5d1UsAruWmTedIVz1yBB1gPspenRjDwUUmiYC
         oNVh6auzoHiq7ovqi+HALvo7iw0RDc4jauxszzLbAx4IaHY9F6/y9FBAvPPZ+qDaRXnr
         wF0ojrAuq1TZWloGogISCiL5KQZ8UQMTifw0Gv+5Frkt+m++d33fqMSHS93ek20JhPap
         WAb8lnxJuNtvOjwXJM4XQpiIGxb99Ei1D1U+2vQi59ODhiu7Etw6C8cjoShrxIijsYGQ
         xCi+SNy75FA8ntO2bjLG2/bl9Zrs/g9ZiUWkaUsFiok8BCV3FRWu6IG3Vgwsb9pGcLXH
         GYxw==
X-Gm-Message-State: AOJu0YwnGWctzW4oa9gy7edCTjsJRgrTfDLO+eG67knD1kdkjKXbvMvO
	4rn7ilAJyZiTgd5x8ou7JcGD3bZEVdsbkfWRaGdTHSrXd5O5Q+YWaRoztrGV9tqX
X-Gm-Gg: ASbGncsf+SO2uUanNdApsHxz8MMDoXDnp5GeoKOazJRn0O5sn3UOw0pwwWEkZSg2PiA
	gIONQMNeH/yVgnFA4uayX5csSBumt/oAoTdrmJFabZSMoX0vlveTzsJRJVuzDBKtjo2URVtDv2B
	SEl8UHwHfoBPn+ORlTC8MsZ9JYWsqkxOUk9yi/3ShhbXomh5I65qxfd5F34IgjsWAqgdz71pAVB
	Qj/2LMxfJuIeYU58f7yT6K+v3Yo/Fy7om4ZURWXHdCyeYS/+HqdHtCOWNPl6HVZxSXqRdAsyEfQ
	0kFp0N679VpMIkMUYQSPXSeSX3K+bf6JaxPYVhJ11gCudkYgL8ZHzvSJGokJHeGVsBYqC8H0Z6i
	sxD2Hqmebmlv+WVYX73OUnUXiW2t+fto2cvdK4aY9FedGQdPqZrw7+ASKxQNPbaa4UpBoGMS1lg
	BTFTCZMNMLDh+zCwN8fMARdizHGg3Q5dZixnugKCmBahvZUBvWjkiEn9nrii4hOtPj
X-Google-Smtp-Source: AGHT+IFzqLUXeo7qN7HvEXeEzKxotIwrCCAjd2lrH8HPgAkoc2kakjIp3Uv+bfkkITbh0hD3Pj6UDQ==
X-Received: by 2002:a05:600c:3b01:b0:475:d9de:952e with SMTP id 5b1f17b1804b1-477c04c357dmr121712065e9.1.1764036473310;
        Mon, 24 Nov 2025 18:07:53 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-477bf3b4eb2sm221949715e9.12.2025.11.24.18.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 18:07:53 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/3] General enhancements to rqspinlock stress test
Date: Tue, 25 Nov 2025 02:07:46 +0000
Message-ID: <20251125020749.2421610-1-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009; i=memxor@gmail.com; h=from:subject; bh=qzXNCQQ32wh4Pwmht97qoN1N4QOzcA6FZe6Q7D2QVLU=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBpJQzujjlLtuOF0BuQ6uX0X3DOyYXFT40eD8YET BV7KuRHBn6JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaSUM7gAKCRBM4MiGSL8R ygzrD/wOGt77Ee5qi5ldnn0RZQNKUWIALpB50QiXfLIAltAT0SjxXbxo30r0sUED2h7v33p2U15 PCcDPlonJYT4sX0h8+IMm81AUTePcLsgo7ADSOj+V7ZNhJ85sVi5ChQFaVXcNMxErdnOpdENxFS gln23AgDLFBYoj6yf/t3OujFAfv2v2J2o3ZF3mOe0jkKoNUiYttEA1Gh4z/Q313d1iNZKci7rxI vsAZ8AELTZKsraushBGpMFJMTD2fRckR0BYbUo41B6Oq+upU12cUTRpt6XsIWE564icTQ6B43ZX WLqvoLnt38mojTXTf5CO8dmvk8jd7fDrCvqB87xBKlvEY2H15+X2TD3lVzFNf//ZyVMTlATkJ/B m0jx49n4m6/w5sHCC41wqOJweJSiH6/9/trPJWM8SVwwT5C2fQjHE+VBkQxdxx6pPVMJ1rzBtCS eLGlOE9MIQ5HjNJWwOywX7UE2zEgqBzywHAKhQfl0/m8aaeq4m7TnkxCaTFKc82rQw+JXdegbUB sgVBdkgSSBa+XlvC4rVDLMO96husI09vTLIiz8Q1TAxV1xx3SO6jH3xTG/kFyBh8mbU5ZSa6s// +faXt7h78P4UCn4lvekAO6Hcg3WNPMltCOfPXqN2vY0vFF7FCXUWoI2cySAx9mp1MmYwY2l7D6k li3TNAlaIiXBSvg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Three enchancements, details in commit messages.

First, the CPU requirements are 2 for AA, 3 for ABBA, and 4 for ABBCCA,
hence relax the check during module initialization. Second, add a
per-CPU histogram to capture lock acquisition times to record which
buckets these acquisitions fall into for the normal task context and NMI
context.  Anything below 10ms is not printed in detail, but above that
displays the full breakdown for each context. Finally, make the delay of
the NMI and task contexts configurable, set to 10 and 20 ms respectively
by default.

Kumar Kartikeya Dwivedi (3):
  selftests/bpf: Relax CPU requirements for rqspinlock stress test
  selftests/bpf: Add lock wait time stats to rqspinlock stress test
  selftests/bpf: Make CS length configurable for rqspinlock stress test

 .../bpf/test_kmods/bpf_test_rqspinlock.c      | 120 +++++++++++++++++-
 1 file changed, 117 insertions(+), 3 deletions(-)


base-commit: 590699d85823f38b74d52a0811ef22ebb61afddc
-- 
2.51.0


