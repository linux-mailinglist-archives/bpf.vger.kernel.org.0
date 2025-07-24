Return-Path: <bpf+bounces-64262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41427B10BB9
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 15:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A13E7A50D8
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 13:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5D32D8781;
	Thu, 24 Jul 2025 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYarplwo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF913BC0C
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364476; cv=none; b=UmROtG7qHMCtg0spTBYkiKyzM9VIQ57Mo38/ZPSTk4qQ0vUafiScXq20HDnoknvnLnRxkUjQDaTPHY+jNBBtArRHmvZzvN8IIA7UH0yxjh38dih54DgclD5P6ujK3vIpab8XL2gT9kH9v8mSSZZUdmj9rJbj1Wl5ert4eag3WtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364476; c=relaxed/simple;
	bh=W60YEWsbcd2TABLkHwrNO/hp4S+8YvGahP+7z+tkojQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TA6e01QPLZAbvbseqDr5WUfySPLa/9KphEtsPsMazS4eqbW5I75bK5Sa58362xy95IzBTJAKbCfsHHKMY4XzCcWsHVGvsiaMWUFwvR7L5Dcpadrkh810zERUMgTYjthLwxdqtSc1g7Kbc+8M8gS1hjE5a1SLSVCPbTvYTOQzHXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYarplwo; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b45edf2303so824449f8f.2
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 06:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753364473; x=1753969273; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FXOFA+ythRh4r29K6i6wPiWjc+0bO+rmiL16LBC8fAw=;
        b=eYarplwoRsHYOks4i3Y6WAy4A9sX01uTKYTFoPEM3GV4Pl4Wbz3w85uBWDCf/UnPo5
         7yI1GVerF0cwetkpRwxjpkPrfKuPdZW04MTRX4jK55frKHSrpoI1Ej6gs0dN/E2tvZcE
         A9M4zaihNW1LjtZXXhglVtOru1Suty2YVtEBQhKsM6hq07Cjc5rS0YS3rJgZqXagojZE
         kJTmuR+39icQPI9MaE8Px/m1N43+gvRX3xP7KkJVL9Lud1TY+bi/1GrZpUlUJIZUv/sk
         CGSsdz1rIL5FHVtc6VAZWlUzQsBwmpEG67PEuOrI4gpQFlLWN24BeWKVH9Wls6O3WRuB
         VZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753364473; x=1753969273;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXOFA+ythRh4r29K6i6wPiWjc+0bO+rmiL16LBC8fAw=;
        b=FQGY3l1k7In64fA1Z3f7C4mGu2JoO+Rx9GtgAkG81co9IZW2e6mPyJnndgA00lRpAk
         GgHbO8X0O98AsRXEjhqs4i0fOXduPQ+fRnjsOs8ADahH3uBmcjU/TcxhdB3P9FXZWnNA
         DsMLHTQj+gZx4o57mfuaRuAnPlKorlcZSOUsIs+tgRW9nI8tbPFqEv5TckldeyHop6bQ
         RMcfWXcTO5Ob395pXiT3fB+DWFPBVOpOcXLMyomuLyeRpBSiZOrXyyyWSGgNGZNf3EWo
         ChP5lHu86ianA1mGfkeDGAmbYQaBrhRuy04lya2/rYNPXLW4VypHnbBQgWkhgpbA77+Q
         eAaA==
X-Gm-Message-State: AOJu0Yw6wh2OMZAR9GGL5wenrjLpxiHvcWzmj1HZ4+PdUnilqqptaKo+
	SV2OZg+v8gVBUak9Cqgm+AZa6Y7f7HJJ6pRQjK7vBFIz0j5YUq0wrhpAjCDP/tM3
X-Gm-Gg: ASbGncvPCqLozzvfJdX7KhbW7EIz8MP84q2OaNFqHteu+xLo5jwZeRbbGUj27LACslz
	XmGDda9qgPa0gB+5YMo8AB45P6yK6StjFSwtClEWsWlPreg2PheMWtLfU8Z1+B81mTe+KQCR2Sr
	zHFSFRBurfnYKJY/FQOEQBHn+21VlaiNEXLmluokhbu+D1sWxPslRxQtezD8H9hn/sC4tISGoP1
	I1skSYFPm3HNd4bzIA+oeWvDQvc1cF3Z5A2VQ+8zahf6xKu51LmAISl0ir2pLrz1SCHw36BOJwk
	9zkhQsaqFATU8hbmSvAMOzSmC7KLyhi0gxHy1AL/q3G8OpqFDxTg1a5tjk6PL85yCWf5KtHffdc
	CEUZgEEtso2UAyz0d1NvVTjiVoAO7ZVrLb1rj0TM6N0TuIbhnqogYSh57EDsJhvBcyoiO+iHpfL
	8OVgleEzytYA7qawkhjky4
X-Google-Smtp-Source: AGHT+IHx8hP3G+BeFj1/+lOwhO0I0ZG+INkTEJJADfyGLLQF7NEt9N7AEHgVhrhXvDW7iJWvEjyabA==
X-Received: by 2002:a05:6000:1a86:b0:3b7:6020:f4b4 with SMTP id ffacd0b85a97d-3b768ea02f3mr5430371f8f.19.1753364473342;
        Thu, 24 Jul 2025 06:41:13 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00667e58c39c19dc02.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:667e:58c3:9c19:dc02])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fc605a4sm2209012f8f.14.2025.07.24.06.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:41:12 -0700 (PDT)
Date: Thu, 24 Jul 2025 15:41:11 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v2 0/4] bpf: Improve 64bits bounds refinement
Message-ID: <cover.1753364265.git.paul.chaignon@gmail.com>
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

Changes in v2 (all on Eduard's suggestions):
  - Added two tests to ensure we cover all cases of u64/s64 overlap.
  - Improved tests to check deduced ranges with __msg.
  - Improved code comments.

Paul Chaignon (4):
  bpf: Improve bounds when s64 crosses sign boundary
  selftests/bpf: Update reg_bound range refinement logic
  selftests/bpf: Test cross-sign 64bits range refinement
  selftests/bpf: Test invariants on JSLT crossing sign

 kernel/bpf/verifier.c                         |  52 ++++++++
 .../selftests/bpf/prog_tests/reg_bounds.c     |  14 ++
 .../selftests/bpf/progs/verifier_bounds.c     | 120 +++++++++++++++++-
 3 files changed, 185 insertions(+), 1 deletion(-)

-- 
2.43.0


