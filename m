Return-Path: <bpf+bounces-67434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7200FB43B0C
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 14:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31FE31C27CCE
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 12:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24F827A469;
	Thu,  4 Sep 2025 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjFINaOF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D977082A
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987668; cv=none; b=GmZQQOQ9cL3ydZGY7eKMOWp5kgFGmz7tjPfhzctrLgyYdr5sUSr0bc8gfbrsW/BAgzHezgGYK8qyPihvloFwcCiW4Xl9bJoDiXIAuuu5agFwcrL6qrBVsnplJnlrYlkFDTkmnYkfUppeEdgHHy5pn5VFQ+yinfC/XT54JwmN608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987668; c=relaxed/simple;
	bh=NCyukS0yawS5fcqWrWHqr0V8no0ZGS/SuMVuPm29Bkw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hIJT1SRB9NRlRqXeNZl11aVWZm7CAXBXjViskZS2lXvTMDjJGRrbWLJkLVk6jXRadyelW9UdtdywE2S9bkmJaQ1lre2v6nCLHb3ER/qnMLAMoNg33wMCKdjQQzKix5z7Vw5gLNS+bOxxHN5lblyZvn+wTKTb22Kr9J1ivIaUriQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjFINaOF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3da9ad0c1f4so641443f8f.3
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 05:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756987665; x=1757592465; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5BA6EwWvzP82PzdVlXyAazlf3bT/yARXx1C4+IzC+qw=;
        b=QjFINaOFiqPwnOwVyKYRhnLVERjLrOp5OBs/N8WoGElWmNYMTdrnAWzTiCxfmk8OMw
         kwfPom67T6O/Z6k76fEoZMPRW8D8rVpzw9dkaqK6Q7/igydDV2NY4XukOIndBMQdyPzO
         Ch41Gyzl1UxvZUkIYb4WouZIScyQXQ61OnHybYEsiTwFEIYOa64gyWG8e4H1JsyjFiPp
         dHH1JSmmIrVbv8Kl+ffGkGnZ/FnnohstR9N7hROurMp6Jf13Alf+6r6Aa9aygND93BLi
         8REmNK+RGL15afmLUp8dVIiH0u/v0LEcAu73YKLYfQNEXicIJoDvohLUSm59eGW82csf
         /nUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756987665; x=1757592465;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BA6EwWvzP82PzdVlXyAazlf3bT/yARXx1C4+IzC+qw=;
        b=gkYFRN5kjb5nv4SU3QlSn8HxRq4fAkxS3Ox2kovgJzH2axcdqzWUElf0fP5SUFko/M
         /bmFEPDLrvECiN9lNUkpr7vzTWBN8sfk9OoMBFuU650qowEAKMJ130fsqwOBC9lenU2D
         c3QvxKFt5KCNBw76GQaVDb5qhS3O2aRJCggcNtZqKUmdGy13R6BSoNgJ1ZmDeHw5XpzD
         vB9/YkVs3D46bwPSoeYHDTr6/bPIVgTUcNyvND3eq9/MwsJjkHpkpyQz2+dpgPhds3MG
         XH/zyjG6BV+fMpf5YzfAv4CdC2AzZwLliAPAKB/TkmBmDd8LbH/+Ou1/Oty3htWFyziI
         hyqA==
X-Gm-Message-State: AOJu0YwywwS1I2/TpshkIutfpHIb86cY2kK8OhKD3mMoLqowrRAMgV+1
	+gqdvmqGN7iAxHpkmmjjjRmMWdWYjgJRMCcPTLM6pGm8FValNdg+IfJ03RIeh8N+600=
X-Gm-Gg: ASbGnctqh01CsJSDQK/MizroJ9MJR+tu3dcalOYx3GNaWp+rttiQjbDuawLBProKsQT
	WlPy2NZ3h26uCIuhBKi03gZiQ7qHJknC3IgcgSp+oOiprL6Z4qxLiRgJOflTlNcTYinAcUWh8j6
	I+w6ieYI0zBBL5yPsztLZIFN2W2oiGoD9Viguo1T7BdmfG4uyJFCnPigoP+1TNID65rkGgj15OL
	wt0V7YGGFtpT1CU2Xr3Nyowciq8ehM+h6NZw/owVQXJD97cuhe9xA7fNXHhznI+UL+q/w2pVF8A
	oefpk5dlDPns8L2X4GjABt6w8qcrUMuqKZassBundmMTo8ctjbuhRhBNCy59rnRTlqLIeFMm30S
	M+/Z/3QFlPN7aYmiWURH4SCsYGxQY3G3jQ8FUQD5wYX8Eh7ZuYs3FTmhXHUstOcf7a+nCvcx8dA
	4qUCVKrkdOTYDjH4n45WFAkUdrOPkEx/cj84np3MN3HQ==
X-Google-Smtp-Source: AGHT+IE/fLZ43BbzPq7DKRCYXT2pNArIXMcAX9LxdPrBXaGkySgbkYR6Up2ae7DOhcTxAhwjnrLkag==
X-Received: by 2002:a05:6000:1a8c:b0:3cf:74e0:55ac with SMTP id ffacd0b85a97d-3d1dfb108b2mr16300678f8f.38.1756987664657;
        Thu, 04 Sep 2025 05:07:44 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0084ffa21ee1457b9b.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:84ff:a21e:e145:7b9b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9db4sm27523754f8f.47.2025.09.04.05.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 05:07:43 -0700 (PDT)
Date: Thu, 4 Sep 2025 14:07:42 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/4] bpf: Support non-linear skbs for
 BPF_PROG_TEST_RUN
Message-ID: <cover.1756983951.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patchset adds support for non-linear skbs when running tc programs
with BPF_PROG_TEST_RUN.

We've had multiple bugs in the past few years in Cilium caused by
missing calls to bpf_skb_pull_data(). Daniel suggested this new
BPF_PROG_TEST_RUN flag as a way to uncover these bugs in our BPF tests.

Paul Chaignon (4):
  bpf: Refactor cleanup of bpf_prog_test_run_skb
  bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN
  selftests/bpf: Support non-linear flag in test loader
  selftests/bpf: Test direct packet access on non-linear skbs

 include/uapi/linux/bpf.h                      |   2 +
 net/bpf/test_run.c                            | 103 ++++++++++++------
 tools/include/uapi/linux/bpf.h                |   2 +
 .../bpf/progs/verifier_direct_packet_access.c |  48 ++++++++
 tools/testing/selftests/bpf/test_loader.c     |   9 +-
 5 files changed, 129 insertions(+), 35 deletions(-)

-- 
2.43.0


