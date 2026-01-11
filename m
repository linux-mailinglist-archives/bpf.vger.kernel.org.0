Return-Path: <bpf+bounces-78494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07967D0F476
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 16:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A64473049C43
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 15:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D923491CF;
	Sun, 11 Jan 2026 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+wo9ZVG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3288F50094C
	for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768144990; cv=none; b=dk71Wddc2Til7ndfW43vRL1j1VZlHJL71eMgz/A5nb5C44zr6JY8VtttYd0u+yFw54GCRhQyUpINrLsIARWzrp3L+iQ7Bi1Kcuzu90Uun+eNtT6JgNkvM3oLRZTyhbKV3WtTdIrR4HfDcegroMKKFX4uWtjChULxwgbLetFPSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768144990; c=relaxed/simple;
	bh=L5vhxeR9+OfD4nMQ+gIrb+JiYuBzGqmKi++aumfplmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d1czlkZTcQ6ropJhJklvPqOO3CVN1o9JH5WD3I3vJxrO5Uux30V7s15wHNPMwntKtDWfVmF795WpPs4KMQPNXEK2m93YeScFagEy88Hfl5SWd2vUxW495JxueJtGMm4hcHFAjlucLZvKB1P5yhQH7Wdj6z352mnc3Ab+wj0EkRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+wo9ZVG; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so8120552a12.2
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 07:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768144987; x=1768749787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mgf2Iu6sQZ1j1trRsFBi7WBd0HiHat72ZsIvRxBc21k=;
        b=V+wo9ZVG0VdNFIcTMUTmPa7Qok1yvB//61ws8jT/qhe3xGnOlno9CnzYKON5Oh+Fsz
         +muccAHcz1StPzZhb7bEFtlg2EsHNL+hf/s+0gVzYdxCwRvssawnemS/v8kPg2cVX+vf
         1HjVEBwEdPm4WVv2kKG3XP1zYn+gim01FYPAhKVi23QITqIpmELqLJIcxA20m+ffVPwb
         OedSQf/C/NMNonzd+urQV28ynPXW/lSVemV2oOI0V+csnlGycgr7tOf2xdKCau8QvN2V
         LDKUqufPwSqU3ySx4iObCrsPtl9Dde4CHZxcV+klPTviYc1NOPaDs76tVlW4IjmrZygx
         z7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768144987; x=1768749787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgf2Iu6sQZ1j1trRsFBi7WBd0HiHat72ZsIvRxBc21k=;
        b=n5qvVypod6JxZvFUh44dp6RNvCpLcGHldawGRlk23xqgxL3Z7+5MR9jrq7n3svTUAn
         z5IaXftDKeyZgUkhD4hEY3GNmeMVSlJi+81ohDWu41nhMiMqmSSkgH1A3JqqIXMN3aLT
         AL9raktdieWNOpZls0Py/yJTsndP4a3vQNclxlubreNyXIBJjMh5KX4Spw3En1wCZTpZ
         T7oXMCzXOvLfQcoRHnsBwyUp4U+TTuFiTAG35TE9IeTO5wHEkKhxV/fZIdPrM8EMV2rY
         OmuNRJARLx8h8578snFlAkCzrN8RyfBFJ+cvRXc1t9bdZRRFiWw8GYlzNb0UDJVcqbIi
         BbSQ==
X-Gm-Message-State: AOJu0YxNe5Or7e1XTmL7d2ui+P4RsHE4mrH1qzDJPD18z852vvS2dfmc
	x/gvtSF+x/WQDk53kuiULH6efWGIHrI/+rWoMmt6hSS8nEtOVBo6Ny1KZ5dfVw==
X-Gm-Gg: AY/fxX6Im1oOPA1mMMCBVJhFXnSUPgcEoUZ7NFzB6/w23+34lGsQDCUaSugFyJjNoX/
	M1xgK14f2Gj+5dP6bAUWuasu7m6vagBdy5Cy9wL21S/wAL14gm2R6s3VcOR4SzjLANMYl60eq+m
	Wd3Z3n68vCbaAA7iv/LZrZ9HGeNkc3urdJUgSyNMwRF3yTz6/XufwvbSjecCOiT+xXWF+turGd6
	zDgEwgxXLgRrPAyv9HD0Nb17MQGQxNfAiaGwo/Zfb+E/ZNgkx02LZEgdmzTwq05dVR2XkQHK2TC
	PTd0AIvhq12zdhpLseb6z1z45aMXzwHy8JIBfqDxT7ptXuWve3Al+A3VWPJKyBUBg5gCBqcIKmh
	I9VdyTHkyqjgS3LeyGMavYEpzAfsQLl6y2XJlh738aktXlq4am0bEvCD3XnO0+BPvjdiCq+YbeG
	d7Q6BF+QZzy4PGtBzTTJ3gr4Z3rfJdSQ==
X-Google-Smtp-Source: AGHT+IH5cRXvb9iDKd2nYVU1JkJ02emQRxifSmJstyImhWhwkh+GyKp1bNbem4tkFSdvgMThsTMnDg==
X-Received: by 2002:a17:907:b59c:b0:b86:ecb2:f4da with SMTP id a640c23a62f3a-b86ecb312a3mr364819066b.21.1768144986901;
        Sun, 11 Jan 2026 07:23:06 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86ebfd08b2sm508698866b.25.2026.01.11.07.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 07:23:06 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 0/3] properly load insn array values with offsets
Date: Sun, 11 Jan 2026 15:30:44 +0000
Message-Id: <20260111153047.8388-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As was reported by the BPF CI bot in [1] the direct address
of an instruction array returned by map_direct_value_addr()
is incorrect if the offset is non-zero. Fix this bug and
add selftests.

Also (commit 2), return EACCES instead of EINVAL when offsets
aren't correct.

  [1] https://lore.kernel.org/bpf/0447c47ac58306546a5dbdbad2601f3e77fa8eb24f3a4254dda3a39f6133e68f@mail.kernel.org/

Anton Protopopov (3):
  bpf: insn array: return proper address for non-zero offsets
  bpf: insn array: return EACCES for incorrect map access
  selftests/bpf: add tests for loading map values with offsets

 kernel/bpf/bpf_insn_array.c                   |   4 +-
 .../selftests/bpf/prog_tests/bpf_gotox.c      | 208 ++++++++++++++++++
 2 files changed, 210 insertions(+), 2 deletions(-)

-- 
2.34.1


