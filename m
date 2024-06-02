Return-Path: <bpf+bounces-31170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A735A8D7930
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 01:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6378E281BE1
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 23:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8097E579;
	Sun,  2 Jun 2024 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="nUqsEVWw"
X-Original-To: bpf@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2FE36126;
	Sun,  2 Jun 2024 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717371687; cv=none; b=oRQ5zQsb9PKZJzuuJ+Fthn/EpbFg5peRoZ4FJNG574Ka8dZvbzw6l19zVZCsZiKAr04KbY2MyinYuuGJ8XXl2VzSCnrCoW7uLh62SBakzVi5b9ns4VQ8rATbizfLILD7dIqb90bCBD4pap7eeAo0/fGV3WEWmHBV26YpGr10l7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717371687; c=relaxed/simple;
	bh=sHVPcLI04y86ns4BDF4QNqfr5kzNes7Jo0k9vvdchDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQEnTnBpEaicTwBtrkKqpqMbqbG8sxQd2Am4ELKONrN8RIW5fng92PcEqqxHa7Wvi7kmgRvUA5uZGdw+F1fX3jGaLp4Y6FB0mb0Xd+lemx0nnOWbV8m59nV/ysSlGMr1rOyaH3RcWb/wQif0chbCjZYU9iPuPchWfxkjJmwOG7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=nUqsEVWw; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=9eZyq6UmxzoVlbZz6IPepN3xEny8bEjM6umDLaY3STU=; b=nUqsEVWwLQjsScWM
	t53fzCKz4yplRJ5kxoCF7iiBp52urBMfu3E/3m61zaXfcvALf1jWJU8So812fcXa9/Pf0WXrlueJS
	hNjzKOtnikODJv9OkhxmJz4LpxM7g28qcmPl32o4Uj3BIB5BBG4qgay7E9UhKahQuKmMc88k1ttJr
	xP0SQZDlReEB/Y71J6OXoYWaL1v/rbhUm9GMcSXTNRZOW9/lMbyhyLTTVnOlagWU9y7yKx3Zqb7im
	UA9QfahrteLUUNAlpcvDJeiMiVWCqWNYXmnwAhBLlkUZuOrpC1qMc4ncv13I9O1PsSceLRpc2aGNL
	uTheCQ0SZV0ElMigXw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sDup8-003r31-0u;
	Sun, 02 Jun 2024 23:41:14 +0000
From: linux@treblig.org
To: andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	kpsingh@kernel.org,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/3] Dead structs in tools/testing/selftests/bpf
Date: Mon,  3 Jun 2024 00:41:09 +0100
Message-ID: <20240602234112.225107-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  Clean out a bunch of old structs in selftests/bpf.
I've been using a 'make test_progs' as a build test.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (3):
  selftests/bpf: remove unused struct 'scale_test_def'
  selftests/bpf: remove unused 'key_t' structs
  selftests/bpf: remove unused struct 'libcap'

 tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c    | 6 ------
 tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c  | 6 ------
 .../selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c     | 6 ------
 tools/testing/selftests/bpf/test_verifier.c                 | 5 -----
 4 files changed, 23 deletions(-)

-- 
2.45.1


