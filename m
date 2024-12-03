Return-Path: <bpf+bounces-45967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CC89E0F74
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 01:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5366A16236B
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 00:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D966210E4;
	Tue,  3 Dec 2024 00:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgQrvE/G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DAA646
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 00:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733184163; cv=none; b=tbWL5v5IZhQNGie910SofjLz5m+AFTe0EGZNkgHsg5Xi9OqTw46S1WgcbhnnaZuZzsCXMsugfkzRfEQOXLb9E8DgfcKUJWWj7vM/n84j+RoLSgQTjkog90VBG7V3tOVpVvdyveDgKHOXyJhcGLnvs0wkqIOmYQ2zPBm9B4vCZHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733184163; c=relaxed/simple;
	bh=rHaeJyY6+wdl10R+dp7GcBGpym3Jm7aVm1wH8dE9IS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hOMT0bWKPeYT1aA1sBpY5S81tKXrTj+UhYGARMFG8yUximAh/CvxrrqOTarSmZyz8cOV1LxRNgvknFVUef+bBY1tUqxVjp/1d68foW1LX1c/IX+lArylCtg6EXKYRtJ4qb9a8axWdKrr8kRPocypkvB81/Cb4sPEHj6J9Yf75sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgQrvE/G; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-434a8640763so41497655e9.1
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 16:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733184160; x=1733788960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc9W+69p1bkiNLEfuW/VuSkD3nj4JfgIHCERSXKXXhc=;
        b=BgQrvE/GKPQUToKEYuU+RuX5v37yQoq+RW2hhps6kBD+86eWL3hCGbf56OX1GwZSPn
         tHaYGoSDEvbx+adTSBuJbuZ1jJA+Fx/84o+YWhuncYY3WQ3yLRU2qlDQOkoVm0Cj5fSF
         W1Ftckwq/v2wh3Zvq+2q8kzoiYmUPEVXRV2Ma28Xk6ArWUqEjyD/H3tfup2/p98W54Or
         QQ6TAN/lq2A/2dAqLJXhWPxYwJLoHME6Jz57a9q06BPpnjGc4rtD4KhzjtzktysxyLpX
         6/xOQdYWkmBYEV4ItJZ089uV/epz/9JuXKunfIDdjroXSXGio4TWjXBK/2b4br0jCD6a
         I0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733184160; x=1733788960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dc9W+69p1bkiNLEfuW/VuSkD3nj4JfgIHCERSXKXXhc=;
        b=HAvCfIVZT7FC3UXgm8WCSLXcIHceAInQ3N3gCNMu47g9moWDuSHCF7oDyA6KKd5nvP
         m7u74480C+3K2eZyzgZ70AaD6jSrfq60WwJHTGVAulLl1Jh6zY6OIp7WJ76hN5TUJ7nE
         0+jqYtWfxz4Gfi/WbSbCP7EG7S193AwkDAsJz09hATrkDU+SsI4th/uRViJ49nbNf/A4
         +WZojyIrJqj21QGBQa6wt+hbO1u5Fhd/LkuZvllAMPN/KUq+7/ToY4FIUXnHntni7qnV
         vpVdsiBoA0p1YlITjTIFFrtrmHp09XtMhFYLrNG3YnM7wr0DEKWfdvCJ6bsy/CYHLZiF
         HkDg==
X-Gm-Message-State: AOJu0YyuA9+ts6+6jDdseGhcLwrAJfE4fm9jnFkJD+pTs9qQvHvkrut2
	dLiy/fCd1IRR+wBZ7mFqTNZWc6YHWMO99WclBlx7s8uNpaeHafO6HI2iAusYTPk=
X-Gm-Gg: ASbGncuuMSglaKJSPIb3Pk92tMxjwEkDj9rxLLunPnRRgW5/jHQSLycl5BSzPdPZAc9
	qoMTwzLzAHEYU6LjuN4nKR/3hQ3myIv6OocFBLf68jfVGOjl0XN7U0kJgEG9TiHergxu2mTl3Pj
	sSEnOXBxkheL6ViK9Bj5z2H8bh0nPP4IAkIObkFBbS5J49GF8KnFUN7Hy/n6+hPEIlgN+cNsYA+
	DxF3TTlilNxzycrVnIGceu+sUOl1dGwhHUaR8NjUVJf/XjM47/uA/0qJk8fBTfUq+Tg/hpKhgho
	hQ==
X-Google-Smtp-Source: AGHT+IGiHOUz2scjlThutgoc2v1B+9xaoy/gI4LUs6Lp2BDIJsGBUL3M/Xs/EtvZLy7nyLVqTOK7zg==
X-Received: by 2002:a5d:584b:0:b0:385:e013:b852 with SMTP id ffacd0b85a97d-385fd3ea60cmr247302f8f.35.1733184159470;
        Mon, 02 Dec 2024 16:02:39 -0800 (PST)
Received: from localhost (fwdproxy-cln-018.fbsv.net. [2a03:2880:31ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385db37debdsm12517664f8f.2.2024.12.02.16.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 16:02:38 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>,
	kernel-team@fb.com
Subject: [PATCH bpf v2 0/2] Fix missing process_iter_arg type check
Date: Mon,  2 Dec 2024 16:02:36 -0800
Message-ID: <20241203000238.3602922-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1035; h=from:subject; bh=HghlnCJfpOCXXT/UkluTLPtlRoqTcIM0qs7ZpeXzoeo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnTkjd4dkpenG1AeAqwn382fugeAyHT0B98dkDonx1 4iWkItKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ05I3QAKCRBM4MiGSL8RynfmEA C6vwBGLOnWFf89ixcfvzLsabZYP9Wki6CoOlGBVwIUfhF1LrLSEnGeJxrWJgy4e1Og0ihqmgN+RURV gJ4iJVeDCbztHkRGAtLmNi7joImhwfu8llplbkPknp3MSyA05vUmzrJtplcBKV+vWF99Mx1xJ4Jaux yhaYDZmaM7ACjKJbzbpEKBuvd34VCuIYRkfQoieZ9W6EIO5Q80oFgQjwQvwMt0Lhy+hw0EZTgVBgkf XOeZyIGlTQvYTOfNC6pSWAJViBwk2+HfOMEKaw3W28OIIuQ2VDo5Qmq61zXCdcjCbuKTFCDHdhorMR eT9/YR1XsvCmxvCRTP7V+lLzwE+fQkgKossVfYrzTy1A3WOe2okS9Z3Vuu0eGGSlaVojh3S8Py159N iOCJ3w7B/yf4MFyrSJcrkJfU2PNjf3t8U8PBGngmnKLvGVT9v6ak/C9rj4Ln9FLwFTp2/UJipXAqz7 /xlm0a4mEAf+SS6Ga9EX3BoMQL5HlUKwo+HwBvImyJCyDVYVVEZfDkW0ebgELvwnIT7Yd5DdjDmoKf o0whSKcEkSPePNyjnAvufmzyiJ37i4iaeDrhs8cDaOLYl8QoPcaKBs/WXE6UjPBNn+gY/8+5flBbrA R0LIGLM5TeonNNt3LkHq8oM4QIO6aJiLS/9zr0L+iV3EW57Xn853inxBH9jQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

I am taking over Tao's earlier patch set that can be found at [0], after
an offline discussion. The bug reported in that thread is that
process_iter_arg missed a reg->type == PTR_TO_STACK check. Fix this by
adding it in, and also address comments from Andrii on the earlier
attempt. Include more selftests to ensure the error is caught.

  [0]: https://lore.kernel.org/bpf/20241107214736.347630-1-tao.lyu@epfl.ch

Changelog:
----------
v1 -> v2:
v1: https://lore.kernel.org/bpf/20241127230147.4158201-1-memxor@gmail.com

 * Rebase on bpf/master (Andrii)

Kumar Kartikeya Dwivedi (1):
  selftests/bpf: Add tests for iter arg check

Tao Lyu (1):
  bpf: Ensure reg is PTR_TO_STACK in process_iter_arg

 kernel/bpf/verifier.c                         |  5 ++++
 tools/testing/selftests/bpf/progs/iters.c     | 26 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_bits_iter.c  |  4 +--
 3 files changed, 33 insertions(+), 2 deletions(-)


base-commit: 537a2525eaf76ea9b0dca62b994500d8670b39d5
--
2.43.5


