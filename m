Return-Path: <bpf+bounces-20254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A59AF83B188
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8A7285633
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 18:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753A4131752;
	Wed, 24 Jan 2024 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXd73lT6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17C8131732;
	Wed, 24 Jan 2024 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122448; cv=none; b=pE0Cd8aLT9vj0L3PTlK4shIy7nJ6bTgh7Y68Lsgav/9hmP/7vg2caPlNkR+VWLlUlzNob2/CMGbKgFyGOCm7y5HQvceHyMwzMvXLuhGMzb8U1PYDUmZYh3COIVFLJPa+StWiy30rTV8wJXMVUj7NRBJ5nVL63jg5QzMkE9uCsP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122448; c=relaxed/simple;
	bh=WpazG4364e+jTKgfgLtEtwyRbP+pcLjKofLLXoVBZ54=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fWbpp4q9z0p4UK5vbg+83qUni23M8EsMcKk8yJWZ0LPr7/bzj1SRe58o3sNu+tqVVotH5obaXcxLWzQqzTKhIXQ1G6gjVCyedak4IR4fq291djNcAtmEMPr2clbYb+8QChMw0s4xIdmWKvuWehzL37CrsUEHiLfqwRvhIV2f4hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXd73lT6; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ddc0c02593so451562b3a.3;
        Wed, 24 Jan 2024 10:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706122446; x=1706727246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9rua/Gk+3fzaeLN+cM8MAOyc0Oae6U7xq33t4VnURAA=;
        b=fXd73lT6K2zGs8NCnODmCeTTHsjya77fVNNpLapqovhyRXpvfOjcuw4wZm/eVyBgaN
         n3Xf4SsHasw3ZSE6TKRrJ1lnY7gIYL6mNUw6v4zGXtqzWSwaj93YidzhDNYLlrQGS976
         fD57K6a1znbCu8pD7u/2n/w+SYwrnAXo3DkFMcZv5HogRoBj7FxL33HOTvPy6VwO6uLJ
         7DA01MLSPOmx80gf+GAyAi0s8YiMp6MfBrzgPZCZlIZXu/HhJLsZa5Q/SX9HeHdmSwTO
         +YZVW3jzcd5WRUL5fTAKXQ1Wt1ichwWPFQz2Xpe7dMXVc8mWeYAjWOfjdpLYKHzaNUTj
         TgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706122446; x=1706727246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rua/Gk+3fzaeLN+cM8MAOyc0Oae6U7xq33t4VnURAA=;
        b=ImFFRwOHXlVQ5YM0qX0r+1Bv81l8xsOA3h7ovXIpY6i851bf3EUGL3pERXfla/yfYA
         vKTINQIs/jAcgt9yIDyinWPnxFytRywFEuz1y/M/xxEP9gfTrDzfsq+poB9UkwJ2GlM7
         FzCZq3C2bGYG2PDxFNS7BSjbTM86kiKBthDIjaLQcTazS/gJbY/WUDXjY1nWTLRXD32/
         MKTzqNvcmx0BFCeiSCGqa3D8Cs0nl6716XW103tb2w59UWO7KWZ6bUaRtL1KjUSQYGcA
         ad4i49fPSzLTzZUUXX/peCXxfXEkpefFeK2KllZTlPbLCzsZMxJeQMlxkXNLgtxUaMQ9
         cWOA==
X-Gm-Message-State: AOJu0YxMaRyGOX4VfBwOFYbQbCREV+ZVjflhPtBBETJoaZTDVboSQWBi
	kX5SaIYul+8/HDtb8WjJcnaN7NuLzMEOYxgK/u58y9FovnKCZCu9
X-Google-Smtp-Source: AGHT+IFH/S6L5FDZMRiotOrNd94kPpUz08mvLPDn3EchVnAFK/SgKv7a/DYYr+T1bUz6h5Ot9/biMw==
X-Received: by 2002:a05:6a20:7009:b0:19b:1eda:ab61 with SMTP id h9-20020a056a20700900b0019b1edaab61mr933722pza.54.1706122445958;
        Wed, 24 Jan 2024 10:54:05 -0800 (PST)
Received: from john.. ([98.97.116.78])
        by smtp.gmail.com with ESMTPSA id ko18-20020a056a00461200b006dab0d72cd0sm14113696pfb.214.2024.01.24.10.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:54:05 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: jakub@cloudflare.com,
	bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org
Subject: [PATCH bpf-next v2 0/4] transition sockmap testing to test_progs
Date: Wed, 24 Jan 2024 10:53:59 -0800
Message-Id: <20240124185403.1104141-1-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Its much easier to write and read tests than it was when sockmap was
originally created. At that time we created a test_sockmap prog that
did sockmap tests. But, its showing its age now. For example it reads
user vars out of maps, is hard to run targetted tests, has a different
format from the familiar test_progs and so on.

I recently thought there was an issue with pop helpers so I created
some tests to try and track it down. It turns out it was a bug in the
BPF program we had not the kernel. But, I think it makes sense to
start deprecating test_sockmap and converting these to the nicer
test_progs.

So this is a first round of test_prog tests for sockmap cork and
pop helpers. I'll add push and pull tests shortly. I think its fine,
maybe preferred to review smaller patchsets, to send these
incrementally as I get them created.

Thanks!

v2: fix unint vars in some branches from `make RELEASE=1`


John Fastabend (4):
  bpf: sockmap, add test for sk_msg prog pop msg helper
  bpf: sockmap, add a sendmsg test so we can check that path
  bpf: sockmap, add a cork to force buffering of the scatterlist
  bpf: sockmap test cork and pop combined

 .../bpf/prog_tests/sockmap_helpers.h          |  18 +
 .../bpf/prog_tests/sockmap_msg_helpers.c      | 353 ++++++++++++++++++
 .../bpf/progs/test_sockmap_msg_helpers.c      |  67 ++++
 3 files changed, 438 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c

-- 
2.33.0


