Return-Path: <bpf+bounces-74942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD72C69205
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 12:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 6B86D2A93D
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 11:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCED0344025;
	Tue, 18 Nov 2025 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmUOcx1z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7482BD030
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465535; cv=none; b=iQa+hRnrQo+QGN7YsxmYJXLAOAkfszLrTXrh/9m6jrY3kwKpDDML7r47/ig2rRkv6Fh3u/d7Q8f4xMqaaa4ocaYXAeMowTKbqkgFupT9EK+CVyQgAHhZdGHgWI8NCRjeyh+nXjb/cIgzfhiOnHB8Go6zqe/kNvv13mmBsGDApfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465535; c=relaxed/simple;
	bh=ZSYPQPCcxbyR8zWwisBrVYv9dYR/LlXu7hMPPvqRZKE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gvALM8Umr9KlDuTog5kpaECDX3Xuxb3G7WfVBIjz+fL6Gt/2zMEQ18II6N4ip4y7x1GKa7goXiVX2L5F8pHgcKrb018oUkl/ngmYmRl4zzPwlVoqPy8iAw4mgo3MMYjRT5vwSdUz2ktzuHqC9oCImN6lAZYPDzoLVEAItr5M/Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmUOcx1z; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34372216275so5838255a91.2
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 03:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763465532; x=1764070332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wj03nqtcPgmxcon+GCPvYB3CYWne1EFGms665/lYYBY=;
        b=RmUOcx1zwMaypuoh8LLXaReBq1XiGuL8EVpQzTm7kmr/WAJabMVdZhTpBcUUMTVFTu
         4x17YtRUIANplQ5hAUs7DEAAfE+EhnKDU+tr3GhPU0UB9vzBXX0EO8Hd7HGhqznoocWD
         HsYE1L+UcWs6qUasEwjTvAZyZJXlXctFtDc8LtZrBKXalJkqdMsic9QMC6iq0jAa5QhK
         61OUPA6s6C3FrBkCcq2nRsrXgKWxfe4cyVGfF0P390vNrN6x68ecAG1vNYfi6VnXsqEL
         T36KYO/l7kGvEWDuCuWAjwJIjJXCtZn3LRWCRGTRm1CVjbUm5LKvMFHVbsysAWmyDSK0
         2PRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763465532; x=1764070332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wj03nqtcPgmxcon+GCPvYB3CYWne1EFGms665/lYYBY=;
        b=SjC8xh3C/dDh+JVevSshVyAL1qv2wEg/KDlhp3gWoHob41TV3yzPeWDOAxWgXxM6xS
         Z1yXhDcPkqAyIR51w7mgwoaHv4SMlgGYjVKLzTBU4d7lt1NJFMO/YCCOZjQCwpvYZtDV
         By5WuVrdmv6XDc1P/vhT6wFWKCrTfyS9Cfrdccr8ONthEFq5DZTaISUTdm89oF1e6++L
         vZ52KEeOnbykU6GtFApuIOuPffGlFM11a1BiWOqX02mHjopOYa/BWpNxfNwUO+kiw94z
         2tS1q0tWVEq1yEtpYB5LsYGYfzsafx/3EmiC0wG0/+LD9DYfFfWciiUhacPpj4Mu5Gyk
         v89Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrGznlq6pSIucEoVbpMRJuLN5RQAcIEU/qFRxbS6tt+WFGbLIaz4Dklo+KVGX3SmoP8Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKaaIwCgW4G+hhfV9e6D6hvdA65z7ZqhRhPnIk0NMHas/kqjjW
	S1foYHh4SrfSQKsXA5FFgS0Ycrl2baAbTRJEB+H7KzutMknpc7XCuB8d
X-Gm-Gg: ASbGncvHgD0aG25ZZdD61SLdLbTii+1umYFxM+RdiCmKvxud8PDjrJ8xGvdGpx5oQr0
	zgn3eU61aHeaKBdFiK0EQj+OSnXCtq56q6gHkgeWLUgJ36/JIsxMQIFz+rhEsPyDZDFk3SDqi4x
	9X0mL2zRZXDXhPFXBGvWtaI1WvDdnvR8Dhw6A3jvnWDGc86c/hIa6TwddqPcXUvJd65KpaJ+oNT
	wdclpjuPGiAaFkdW4VMumV8Y/c06+Sfza1MKScNI4xCTC7bv4aWs7KlN+hzOcmnPh+1FiG1+uh4
	PsmiSFPmSEedlVjj3Rt/WqNFcRQTS61HwAG1DlAaTqd9bINK7PlqnDyIgqyHnGktY6OsKbA0C+6
	sgtXMC64aibXK6c4OqibzBUoXeKGuFxhbklwgfSwZgB4i45bOcM505VSmicJqx7mcgoaO0DE3AS
	B1RKplYLCWMua1qbAXp2nr32j8zFvNJcqCRa2zVhJbUERBc304ww==
X-Google-Smtp-Source: AGHT+IG5VaG6Q0GIZPMrPaqT5GuUqUFcmdC9/5IBvB6VhxiJ4DPZkDYWpqxjta4C8WIbFOkh7vfiXg==
X-Received: by 2002:a17:90b:3c90:b0:340:dd2c:a3d9 with SMTP id 98e67ed59e1d1-343f9ec8d58mr19036285a91.12.1763465531943;
        Tue, 18 Nov 2025 03:32:11 -0800 (PST)
Received: from localhost.localdomain ([103.246.102.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3456516d4a9sm12583736a91.11.2025.11.18.03.32.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Nov 2025 03:32:11 -0800 (PST)
From: Alessandro Decina <alessandro.d@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	Alessandro Decina <alessandro.d@gmail.com>
Subject: [PATCH net v4 0/1] i40e: xsk: advance next_to_clean on status descriptors
Date: Tue, 18 Nov 2025 22:31:16 +1100
Message-Id: <20251118113117.11567-1-alessandro.d@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alright, hopefully last time I spam you with this.

The status descriptor handling code is now shared in
i40e_clean_programming_status. 

Changes since v3:

* move the shared code in i40e_clean_programming_status

Alessandro Decina (1):
  i40e: xsk: advance next_to_clean on status descriptors

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 59 +++++++++++--------
 .../ethernet/intel/i40e/i40e_txrx_common.h    |  5 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 14 ++---
 3 files changed, 42 insertions(+), 36 deletions(-)


base-commit: 896f1a2493b59beb2b5ccdf990503dbb16cb2256
-- 
2.43.0


