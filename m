Return-Path: <bpf+bounces-41816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3712199B6FB
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 22:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D06B21633
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 20:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A361199936;
	Sat, 12 Oct 2024 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HjCXNvdY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC8F1946B
	for <bpf@vger.kernel.org>; Sat, 12 Oct 2024 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728765472; cv=none; b=eW1fQWQM0U5iG7aCdybgBU/7dD81se90h4w+ZX4iwfywjSTJ/0rMio7+lgXWMLGE/aQtA0D/+n5xwPkZx8lKmxq2hGc6sIMpMbhE9w7BW1oFAuwO1W2WEx8/xx+HfTdMKiwvlef1iK9RE7uLuPBErIxYEmxAJGsfHgUv1pWMFS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728765472; c=relaxed/simple;
	bh=OJDp/ElrNd5TUco4e6r3U67rfQ4f4yoey7hT0mMEFF0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QvkhgqFUiOAZYwKRTiXQba1jGnsQjSS+PhcbYZ+9nylIIUJNGgk9hcTHX4MVc0WBtk2ZcOWgFN7K/4zZ12yJJyQUNjMEM5IVRlb5pYJthSVNnIMF+F+ztUgVCawaVCfLMmeJXIwqUFKOwxF21Tq/3oinewBtNcwSdBm1y8+vm0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HjCXNvdY; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4603d3e4552so34369531cf.1
        for <bpf@vger.kernel.org>; Sat, 12 Oct 2024 13:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728765469; x=1729370269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ntaEw7Yozyg4T8OmZFfodtpgSQ8y96VMsKVsEBE/u3E=;
        b=HjCXNvdY9kHwGCiC9kqFBqrf4+bDdkdFz1JimkXCcnoNgptPQspyzyoPHL3xBtCMwh
         LrShZlxWGmgZtXjEedQ3nTsOpi2btGz0RnVsmLZlNPPj/VU7ELb+tbunXyuYmyrXqQHn
         6mPTCKKOEgRsiY2mExwpJxuMUXJpwqlrYf6AkOfGrxINnhexvcZqUlJDdYh4xuuGsoGl
         uA/4oHQYi934ji45OCrB9p2I/bVfJlFVaxk3Oakk+tuYESnm+KBM8YxkaoijRAwQmc+Q
         lSMXMj9Ft57fa3daCD3kUuEPjZIE87ifA16UD8kWRwldUjXx9MrSG0eUPhpC87TMxJW4
         7bnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728765469; x=1729370269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntaEw7Yozyg4T8OmZFfodtpgSQ8y96VMsKVsEBE/u3E=;
        b=T6uO0bmcbPlhyWgOOE3Gd2Finiqk0XlFVhL9KfJ3fKzP5ZsGfdeNnyuBrc81+klMhF
         AWP6G+UBJ4IDGeYr8jczKIwjw2Ky3a6vRekR6Fw185DdU/1r4kUdN/qy+zv6h4/yH1ik
         FmFrezKT51/WuBXQ4ZlbccsJXmkFJe3Pit48pltzdgxkJR8kqpFt/r25tP4Y7g5tLSOQ
         uQ6Ohn3hFo6ebESPoFCdZFCSaH8bBFR5/046invQIHc27edDapQJyeMZOzWtA8VfrqcE
         c0Sg561UnKabQFCJRs6zlldAc9d3Blhqf++C54bBIcTtWnN+es+Ye2NQuXR3HVbjyAe5
         lrEg==
X-Gm-Message-State: AOJu0YwwR2cVxRu8YZVJBkDY7L+wzfuOYhM0TUPA/cxOKI1ZiN5UXCFR
	8ADSDr+jwmXYlnhCU1plTS4N4YWVMh+9et+cXYeRJxACfUGRhutRGcfqOIQ4wnnKj8GVnszS+dD
	o
X-Google-Smtp-Source: AGHT+IGQ5vzSuV1QHgpMWJEsx7dDTzwq5OL+PwTiBNS3Y4H0iCcSA8172odnvPOFJ/0DcJXgtJzlSg==
X-Received: by 2002:a05:622a:53c5:b0:45d:aa0c:2e12 with SMTP id d75a77b69052e-460584b5010mr63614331cf.39.1728765469017;
        Sat, 12 Oct 2024 13:37:49 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460427895fdsm27803371cf.16.2024.10.12.13.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 13:37:48 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	bhole_prashant_q7@lab.ntt.co.jp,
	jakub@cloudflare.com,
	xiyou.wangcong@gmail.com,
	zijianzhang@bytedance.com
Subject: [PATCH bpf 0/2] Two fixes for test_sockmap
Date: Sat, 12 Oct 2024 20:37:29 +0000
Message-Id: <20241012203731.1248619-1-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

Function msg_verify_data should have context of bytes_cnt and k instead of
assuming they are zero. Otherwise, test_sockmap with data integrity test
will report some errors. I also fix the logic related to size and index j

1/ 6  sockmap::txmsg test passthrough:FAIL
2/ 6  sockmap::txmsg test redirect:FAIL
7/12  sockmap::txmsg test apply:FAIL
10/11  sockmap::txmsg test push_data:FAIL
11/17  sockmap::txmsg test pull-data:FAIL
12/ 9  sockmap::txmsg test pop-data:FAIL
13/ 1  sockmap::txmsg test push/pop data:FAIL
...
Pass: 24 Fail: 52

After fixing msg_verify_data, some of the errors are solved, but for push
pull and pop, we may need more fixes to msg_verify_data, added a TODO

10/11  sockmap::txmsg test push_data:FAIL
11/17  sockmap::txmsg test pull-data:FAIL
12/ 9  sockmap::txmsg test pop-data:FAIL
...
Pass: 37 Fail: 15

Besides, added a custom errno EDATAINTEGRITY for msg_verify_data, we
shall not ignore the error in txmsg_cork case, and fixed the txmsg_redir
in test_txmsg_pull "Test pull + redirect" case.


Zijian Zhang (2):
  selftests/bpf: Fix msg_verify_data in test_sockmap
  selftests/bpf: Fix txmsg_redir of test_txmsg_pull in test_sockmap

 tools/testing/selftests/bpf/test_sockmap.c | 32 ++++++++++++++--------
 1 file changed, 21 insertions(+), 11 deletions(-)

-- 
2.20.1


