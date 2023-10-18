Return-Path: <bpf+bounces-12615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848367CEB8A
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 01:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E291C20E12
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 23:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CF939874;
	Wed, 18 Oct 2023 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBruhfDt"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BAC39861
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:02:03 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D45E113
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 16:02:02 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1e10507a4d6so5100240fac.1
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 16:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697670121; x=1698274921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2vQo0WQoy9PO0y8R0CQ2r+OoeVCAARTkPWdJpNRSf+Y=;
        b=OBruhfDthanAJu3Lac7OBxxtcrG6OuWHQK9oRQYhHs6KQKED9J70rYisLabRjK8jlY
         oVwu/8U88rrJGwr4oMgDPYiy8RgIdtYxLBDlSUsTAcedDuradYE1HuvVtFd8INvvvfmB
         ZJBpPMY1UuZGanjTzYv9ZY2MTgTiwTzmUYcFeC0U6ibmha42OZNqk9N+1piiDqoV13cg
         pI1KauX1m2Wxbem4fOF2jJ11ca/8P/WtY7zqrsDF56bTFswbCmuahoPzjGU2s7UZkpLK
         fqezv8IsmQa1AkOIqo7GHwLcoBpgOxuThiupLQfvvki6jiDEruvUioVPrT0UQZcWMlaF
         yfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697670121; x=1698274921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vQo0WQoy9PO0y8R0CQ2r+OoeVCAARTkPWdJpNRSf+Y=;
        b=ETPHBfGh+0KjLS+twMqb3AbTnZ5jeCEHFqVl74I/THrDbbS3bDEFMMw5jQEdrqekKf
         6IKpO7A38V2YIjy3/mqUvNZmrxEXJybsjg/omaejUB8vP3OZO2SNS4di0kfG+qBUiMh3
         q9oTWhOm66Ba5QRm4GTP2JzwvZh/Kn7tA8D8A0hUusGsuRO6HkJbdadIIoDKGwZD4Z2R
         GmdiVjguuBsWYpvc43ae/3M4r+HT8iCU6ugcwR0K9rRUAPcW4i4ubj4eB4UqGN04M/2w
         6/fyfCjftYFzrC/9gx2/za3K83U6G5W3b7NMGyPkhL3+KF4qrYIy9TL7YL1uSMi9jLU1
         E10g==
X-Gm-Message-State: AOJu0YxZbuPbaaWssVhvGMDd/RK0VQP7NYOpmX2M1fX69PR2RjMx49Cv
	KmE6tMQ6KC4gfviyd7D478yH5rtx31qGIQ==
X-Google-Smtp-Source: AGHT+IEqbUjwPmGybXsa999haGLWxp+dX2cZha031FxKWLaZX2ZEAVmbSyUOFf4me9R0uRhh7DEZUg==
X-Received: by 2002:a05:6870:4991:b0:1bb:509a:824f with SMTP id ho17-20020a056870499100b001bb509a824fmr858297oab.55.1697670120987;
        Wed, 18 Oct 2023 16:02:00 -0700 (PDT)
Received: from localhost (fwdproxy-vll-118.fbsv.net. [2a03:2880:12ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id s36-20020a05687050e400b001e17094dcc4sm900009oaf.20.2023.10.18.16.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:02:00 -0700 (PDT)
From: Manu Bretelle <chantr4@gmail.com>
To: bpf@vger.kernel.org,
	quentin@isovalent.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Subject: [PATCH bpf-next 0/2] bpftool: Fix some json formatting for struct_ops
Date: Wed, 18 Oct 2023 16:01:31 -0700
Message-Id: <20231018230133.1593152-1-chantr4@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When dumping struct_ops with bpftool, the json produced was invalid.
1) pointer values where not printed with surrounding quotes, causing an
invalid json integer to be emitted
2) when bpftool struct_ops dump id <id>, the 2 dictionaries were not
wrapped in a array, here also causing an invalid json payload to be
emitted. 

Manu Bretelle (2):
  bpftool: fix printing of pointer value
  bpftool: wrap struct_ops dump in an array

 tools/bpf/bpftool/btf_dumper.c | 2 +-
 tools/bpf/bpftool/struct_ops.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.39.3


