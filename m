Return-Path: <bpf+bounces-62465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8056BAF9E62
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 07:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCC84A6C90
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 05:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7741E253F11;
	Sat,  5 Jul 2025 05:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bdu3uxe+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6338679F2
	for <bpf@vger.kernel.org>; Sat,  5 Jul 2025 05:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751693444; cv=none; b=NBlf6MZjhYCMQkV3gXehsLjwKDMpCuwvN1gEd50jwc1IoJ957/X/tr+BU3AiId09mQYe4+6YsxRKwYf8mqDj3O8nKEUvqvnmApNiSJFhx9+/TUm/+2lrKnWI+1Nu8Nq9yFCcK8Tx/mTe8poabmBiNR84sDKzCoi67elXN2M4vcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751693444; c=relaxed/simple;
	bh=h88qRMf7NN1I4WVh8VgguEPLTdbHZabpgvnKIOPdM0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tu/purxx2dZclbDpjqi4BJkr5BBA23kDfrZv9QZ79T5FfR7byV3fOAyxgxTCXJkS7/2LvDcJKhWKj4zdr0sXN8ipyyX7Hof5coHMEHFdAxvMwaTgYMmUFTP6pmVYEfNTT/s/wJ107AQD7n42YxhnKMk0Y2TMffhbzF+bzyU65k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bdu3uxe+; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ae0b6532345so460395666b.1
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 22:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751693440; x=1752298240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJuhtqt6LucyEiIMsv0Rs05BCjh8pGyCeJTf66yhIG8=;
        b=Bdu3uxe+sUvh5/2+Y0XnDOkSD0e8f6T8PhDRW7qEFpFfLNHjJ/gUMeve1jTbK564Az
         zQLiHBLsGf3i/zkSBnZYnrj9dEnVjzaCzMr6SqMGn2r83uaoHpI5+seQHn14euq4KPny
         fLsa9eqhdTV4bhKbjzwGXlG6Rx/2xBfAWR8s+iruvlAeiwmJ2QoVQbVSEohQCwpmvFQB
         PRMuGmxJ9CWGiO84es31kFMcbsfz05EgJyTYsYLQGnVgiA3gxr11U2/Sber3vQFosEIb
         zQB1iARs1p7SEwDdqxxmX0NGpWN9Ke6LnGR0zj0N6b97Pm37wk17PsZ90IkGbWk8XuyL
         ee3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751693440; x=1752298240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJuhtqt6LucyEiIMsv0Rs05BCjh8pGyCeJTf66yhIG8=;
        b=cWR7gIRORecuHld0dN/bzGifhTbfe2FOKouPbrrkfkktyL2pmN6RrJcOdehjkxWy+y
         +pKBd1ZGTd5OOrP9z2BqFjRw4+LqUcIWW/137PP8SIJvx1yN3Xmj5QbA9Vx3bw+lOL48
         1aIUn2HPLoEopS+4M9Aw2+GR9+isH4+WOn59dFfeXtK1iSzpbkRhPaWF0MnSJkT9yiqq
         pj3d1QSSLP3eoLXUkBuYWnJdNGO1Z4TARqkvTXDnu6ukhPHy/qgkK5X1Zd28p6ZY5vBC
         v2Pn1ARva/gAxPpwx/rb655wZ2YsF5XZgSfG+SDyyQLkbTyGJYWNWtYXXUQvdLUSrWWf
         mWHg==
X-Gm-Message-State: AOJu0YzYVBybmrpvh66AczfL9GofIhYHKcRmjOQTmCZlFDIzQug/fBjU
	U97eG8Dn8MFM1PZ1hvNkZBlYBLymVlc+4HxuwcJMhF9CZYDER/4CP/aKjOqm25k5yXw=
X-Gm-Gg: ASbGncu99iyN794dIEurty2eYmhXjJFjRMqBgsFwJZDl6TwsmRtjcIXb6BlL/6QIwWu
	ru1UsnlpVV8Dij/l669nEh4vuMmgRG4KK1jyDE5HZKm9kVrnvDeq9nCBSyntG5f+lHoFJNUdUhx
	Pr1wMkqOYVX8vkxnIb8eKqdoHzVEgxHtj2JGRs8Su9QhKm1lxHWW59XeSUvWF6vjrXlvdpRVja6
	PJLlER3cb/CYi8p6Hg/t9RljIZ/h0z3ZcORb6Z7fxrcc5rE0tq5MazJWF7fDzbBlHMWhj9Bn63e
	8/I9iZfWIozNPliWqMVtrQSdfoW372fGR1XZneUlS6MLc0QyVK9N
X-Google-Smtp-Source: AGHT+IHSwFH16adg8vB9vrsbtKc3K1KpQ/DCsevtlAVUVQ0jliJk3yh2jVs4WVQojM5ZcqY7RiCXiQ==
X-Received: by 2002:a17:907:e90:b0:ae3:eab4:21ed with SMTP id a640c23a62f3a-ae3f80acbf7mr613527566b.11.1751693440227;
        Fri, 04 Jul 2025 22:30:40 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6bb1edfsm284827066b.180.2025.07.04.22.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 22:30:39 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/2] BPF Streams - Fixes
Date: Fri,  4 Jul 2025 22:30:33 -0700
Message-ID: <20250705053035.3020320-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=452; h=from:subject; bh=h88qRMf7NN1I4WVh8VgguEPLTdbHZabpgvnKIOPdM0k=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoaLO6M3YzdsyLneGhO4B798QILUkN0oAzVkFX770j eW44u+qJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGizugAKCRBM4MiGSL8Ryhr5D/ 43Fhkf8si5Acu70PpB6bP7H4wYmDMhwDnJCNZ8pB0mh8yjfT56kjK9UVVGE5Af9cafMvNCuCSzykFm t7Dn0deUVGq2IJp2DrbgYOHhpxYUj1FmL0KT3dysEgRDwM+7gBahPD7fNqVdmNBDajTTctnTaRZ+sz EEi5dFIMBRdoFhiVtMNe8Vgx6hRapRgiWZZWP6ugCg5WhsnFIVW/ANBHHBQ4zT7S9SMVi+3F73WnrT U9s4iCGkSHG/H/Y7c08N54pA2TjxV4hfNyo1DwGlr6cHGS2HT5UHEnYYUe9f8HvFcIVap+H9U4+NHh TNgi6pUNZvrKbwr0Hp4Rfki7/MBBUxy69sXtvE3JoSlP5UrViMHYukyFAKjnKtncCEQKJVVom2ukWb iUGdHozMyQHgitrQWVwgFwWUbcZr8WpOZt2zaTxIa02Ghb/PX3v5Wx323SMFfSg7EUH5UDMpbMVywc Auz/SxwvqZC4mnNTsmuBy9d9N/UdDuELQtXFxFaREOezJodch3xowWs9ycA64rpW6sGu9DhRZVGLk6 UCEjiCQZGaIRWpjmztUrCSWWL4JY4kBu/FIX3m4UB6JctDPslRgwi1T/9t6b88KBDOkC/T6fSlE9zf CeXUGoNCF9CLwLHR0t5QOnZZXWry7XE4DZT58os3epy+lnPpnP0cbfJdn9hQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This set contains some fixes for recently reported issues for BPF
streams. Please check individual patches for details.

Kumar Kartikeya Dwivedi (2):
  bpf: Fix bounds for bpf_prog_get_file_line linfo loop
  bpf: Fix improper int-to-ptr cast in dump_stack_cb

 kernel/bpf/core.c   | 4 +++-
 kernel/bpf/stream.c | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)


base-commit: 03fe01ddd1d8be7799419ea5e5f228a0186ae8c2
-- 
2.47.1


