Return-Path: <bpf+bounces-63804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DD8B0B067
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 16:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63235560A31
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 14:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23912874FD;
	Sat, 19 Jul 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRNWL5dW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BDB1DC9A3
	for <bpf@vger.kernel.org>; Sat, 19 Jul 2025 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752934865; cv=none; b=lTJ3b1Ez1TV3tznvl5yxfcKUgxMRb1h5jCqSiIaJs9t4pL8aQHv25rlGt8ypaDT8Mi/MT/uz2syQDjavyx+eCISQbvfEp60AISOWcaoE4fBAtVLNUgJY1koOkt4Ej0opq7+tzSPu3++lBAUO+0w8X5d96naLMVNgXKtxbxW8JGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752934865; c=relaxed/simple;
	bh=Y1P9ndc2oB7yv/H2cpvO170tBw/iyPG9K7pyAVaggSk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GoEOP7bqSE3qf1R0So3gliebW0XVMcybi37FwqDIdDvfs10tAaUjQV8PR8M6fwi7vygpiFGcnFZI+hWPtHnBupaaaI2RyA+nGhIzASPLUkzmxXUNJkNFnBH7CImSWyqeC9s1XD/7RaAwCwbc6oOimv+I2aSjcKOL9cnQ4T0EtsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRNWL5dW; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b49ffbb31bso1834749f8f.3
        for <bpf@vger.kernel.org>; Sat, 19 Jul 2025 07:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752934860; x=1753539660; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fkb+NkF6raswtaySUsvExpmqzWUDsoLG5hEGDU19O1U=;
        b=FRNWL5dW5zV1zweVZnQERx5OxPgUrdZPu3s0evprDDAJG6a9ZTEJTTPkzaL74+iFi+
         /596CwMvEl0zD2muZkmga8O0FVXp40r7KKoupQ0qQhBvj8z0hnCPsYQ683jxSQONAxNy
         DKpb56PQGiKwdNdTtd0JSnbD6K9Pd6V0VHZf//RDmA8ZnEY2vd28iVwpWBbZ42TH3rqt
         m2pcSmQCX+oWKwC2YKmNyp59GjsS47AUerjwBF5PnSN/8np3Ix4I/AX+iuHnt9aj9mAp
         hL7Z2e2w2lfS04HHnko/ds1nizlrQicignjr3ve2n7voufvgCIR/oBxSY/DjIbZvJ5H3
         VvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752934860; x=1753539660;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkb+NkF6raswtaySUsvExpmqzWUDsoLG5hEGDU19O1U=;
        b=X6JT9Z7bHIaLVgA8DCUl7b7vrGadl3Erzq3/qrpN3VC7CFsEgSH5PsBRjOATp1QfZL
         PYSgRtRkYtBVyJospuvSIlPgtveeMpTeyAZSZ3Ijb5WLGg2mrweIHFYBgb97kepUASCP
         LBSNjrdZ6jnoBmcg8XsBJq6UjjQ+R8wuKHkXpyGqDFFY/NFsUqBaywQgLUWD8qVX0vSa
         wl3RMWaIGtuxlg5bJVUxRPzYBWmoCM+2eyIY7qUSsQ9iNeImhnbb4zR+DVtL3eg2BiAd
         geaAQCdMblEPUuL34AmEBIEpGRu66kriIQg6OPKpd8m/wzX3IER3hxy0q/bUmS0zlslJ
         4nzQ==
X-Gm-Message-State: AOJu0Yz3fAuBvGb4bEqEg3iaIsu27QPD0cT6+I5iEXN4TyDx1QytJAni
	ABRjVktK7lSN2Pzm9Dk5jiXFOR3AVjgTq7ZcMsWxUiRIf3WeqptxUHlVtoloqYXB
X-Gm-Gg: ASbGncvT4B6gJ5+IuP5iba/xoGknyU0Mnh3d9aKBA+nYRhOH7fkSuiek3Bfk1dfWeMh
	dW8fjEWqHoWy/Fv0NvInIDrZUto0ij6mIgIvxpit4KbFL4zy7/+9SX5nX2hXM/MBwFE52Fqp/XQ
	WqTdE/nT/ifIwI/RMHGsLPfqKEoYlpYlDef60KSF83c4ajM3WtsFck/bogvNC+hbMU1CEJ7FkV1
	ZmzmuFhatTmgq9xhI7lYZExv4f6hV7BwiLGRWodZLUB8v6G9WjqWuISdQZ8tvg8dAW+bChI/PGm
	8KaYAocQelE4IHPrLHek0wOb4JDcFj/7rxN+pk3Xl/HSBtf13QdJiwSU7S25JqWThKUL3RmTXXI
	F+Av9907B7Aos2nnKhffZwkxI7GzxVnpAQ2R0Ny6NSj1+HVmNJMX1r7F0CcVM9xhbzBpwOxDE9S
	NBUq6og7Y63A==
X-Google-Smtp-Source: AGHT+IFr4R3RHfy7ztUlugO67tR/n5bu2YBLE1QusqbVawghTVELp5/QJqdS2Md1yvOBXIRA6kuSTA==
X-Received: by 2002:a05:6000:2c01:b0:3a4:fa6a:9189 with SMTP id ffacd0b85a97d-3b613e9831cmr8182585f8f.31.1752934860108;
        Sat, 19 Jul 2025 07:21:00 -0700 (PDT)
Received: from Tunnel (2a01cb089436c000eab97b50918e1e74.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:eab9:7b50:918e:1e74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e89c87esm106608055e9.33.2025.07.19.07.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 07:20:59 -0700 (PDT)
Date: Sat, 19 Jul 2025 16:20:51 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 0/4] bpf: Improve 64bits bounds refinement
Message-ID: <cover.1752934170.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patchset improves the 64bits bounds refinement when the s64 ranges
crosses the sign boundary. The first patch explains the small addition
to __reg64_deduce_bounds. The third patch adds a selftest with a more
complete example of the impact on verification. The second and last
patches update the existing selftests to take the new refinement into
account.

This patchset should reduce the number of kernel warnings hit by
syzkaller due to invariant violations [1]. It was also tested with
Agni [2] (and Cilium's CI for good measure).

Link: https://syzkaller.appspot.com/bug?extid=c711ce17dd78e5d4fdcf [1]
Link: https://github.com/bpfverif/agni [2]

Paul Chaignon (4):
  bpf: Improve bounds when s64 crosses sign boundary
  selftests/bpf: Update reg_bound range refinement logic
  selftests/bpf: Test cross-sign 64bits range refinement
  selftests/bpf: Test invariants on JSLT crossing sign

 kernel/bpf/verifier.c                         | 44 +++++++++++++++++++
 .../selftests/bpf/prog_tests/reg_bounds.c     | 14 ++++++
 .../selftests/bpf/progs/verifier_bounds.c     | 25 ++++++++++-
 3 files changed, 82 insertions(+), 1 deletion(-)

-- 
2.43.0


