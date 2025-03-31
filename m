Return-Path: <bpf+bounces-54973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E2FA7693F
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 17:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8CE3B1583
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 14:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A5E202978;
	Mon, 31 Mar 2025 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eysIx1+j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0D5215F76
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432505; cv=none; b=LVCx6WaT4s9/bVzGc6Y2zrDHCGHlP2eSWCr0MFAlpt1ic2DIzzf28R9JxqpdZ4TEEe2VN1OVAnHublPRgW81c1AwiFDW50BQspkVPpKR83shH7niKvXAsCX0rjh5O2Z8anMNJsNd+Fc8giB1sYbv2Ve8hP0DBJLaRsQb+pH6L0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432505; c=relaxed/simple;
	bh=3eCK38ZpCeZ8/yvU0EyfKVB3ntl9oMLqLt16XMK/F/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NWQLzF2mzxJby1xCATDC93Mwu2hLIJC7vDlNlx5U6EBVU3iGFvXmMNzR8RQXpS9Ncu6mDFhIfMrUSlOFvwBII+HPM9EsQ6nJRvtpqYtFJdFy6uwtKndtLMBDdzf2Jqtl94/7loreAZl5txBPFsnmXdPD4RRyakmyeKzX5rckRQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eysIx1+j; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so27354425e9.1
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 07:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743432502; x=1744037302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mQ9e83eVRytFAWZb0lv37xRCU2ElQVZ+TOCyIOWxloE=;
        b=eysIx1+j9eHyiPT6v/6/4S45y1mNgJgExEdAAAckOLrmN/zprQKsGr5Zd0FRQvMZV6
         gN9f+2Ltm836LL2p58/u5A0OiAePIZVzqL/e14C7f85sAgPaqxy/XGuqu+Oyc9pSKHDi
         osHdh28XJ/oZ7//MPjdhXXw7paxsflV04nad+Wrw636ehsumXE5lBKjXjMPvrZdBg615
         jDWzn0XNuMIdPAYfUavTm8HJ9WJ42bo9Snn8y52Bxm2cQWk6T2KHw1FQtICpktrvpKXV
         bpLBbde8toesBns8a2D8b91RSUelyuSYPPaEi5hAADof0O4NfO4aY4lkR+N9BkOze/9i
         /rbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743432502; x=1744037302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQ9e83eVRytFAWZb0lv37xRCU2ElQVZ+TOCyIOWxloE=;
        b=L96eobUOLJW+3UUy2J9aOaD1wsxTMkWeok56cdwtBZ58bUIyv5RWEvMMSYyYoD6qvh
         FPMZ3kVgmQdsPkE8apOhuyaX4RGFJQUM0IrnCRGw4bpVwwsLR022lHMnuXDlXozGmjWZ
         K4AlTk2vONtdP72+cDwtMqBoPqgUyqoNBE0/Y+8MCi3my2GJs5tqKQ9u3awUgRIlPRWM
         A8nKa9Po24wKkJsxzqX2lvnHaU8++tybef/SwWWjEQ5/IfY74ApZvHZNbNCqooLT2tOA
         P4cT0xJ5ZCV39kfOzaE8nQXiFKGm/hxIkRRrmRVLiPji+xFe5niPNRzvcQtJTMM86abL
         kHqg==
X-Gm-Message-State: AOJu0YwaoUHIS6DYB3qJB+QlrVOqYB7UF2ZnRT8srGuY7cHzs76gOBPL
	wra1yQLOAtXgZXBUFH2NyRoB5myfqf8YpeN9zTCjaN2OOPhZps6Uyhnbww==
X-Gm-Gg: ASbGncsCHy3pjFBeIrtM/ML5RbNQATCy18qM+WO7AKgGpOir7PuaPiPQdJxSbQbrqis
	SZFAXmyDQKWZDDUQNgj9rlpTKTVHA7xChMJeDN+XtiGvU9CxwCaOYlrUDXxYHlIpAZryjTAnEM9
	ao1vPbSI8J8XsKj50fLEHVh4MLzn9d4j7w7KdFh1dr5Xw2g+eFNjCcDorBrGM9RZy6ZaZtizu74
	OuOWA5ZHwIhPANb9QVPMq1uAtsdEQhexLvE7y8ELVww30c/DL7GEkb+uVVtvsEo1iYsGY624EpQ
	tP+LdhcJIhMiVc0F9HKZ0igPRUHHrxvmr6sNyVNNB4Q+PUKVlEspTDzFXOjEoI8=
X-Google-Smtp-Source: AGHT+IEm+hDfNIWk89hu3YaXPMHhrDqDaQ+79NH235DqE9s7OcjMw06K8QuZ44d1+gJsrPK/JSSGyQ==
X-Received: by 2002:a05:600c:6dca:b0:43c:f509:2bbf with SMTP id 5b1f17b1804b1-43d911902efmr110223395e9.15.1743432501725;
        Mon, 31 Mar 2025 07:48:21 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d900009e5sm124338365e9.34.2025.03.31.07.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 07:48:21 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 0/2] libbpf: introduce line_info and func_info getters 
Date: Mon, 31 Mar 2025 15:48:15 +0100
Message-ID: <20250331144817.78443-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

This patchset introduces new libbpf API getters that enable the retrieval
of .BTF.ext line and func info.
This change enables users to load bpf_program directly using bpf_prog_load,
bypassing the higher-level bpf_object__load API. Providing line and
function info is essential for BPF program verification in some cases.

v1 -> v2
 * Move bpf_line_info_min and bpf_func_info_min from libbpf_internal.h to
 btf.h. Did not remove _min suffix, because there already are bpf_line_info
 and bpf_func_info structs in uapi/../bpf.h.

Mykyta Yatsenko (2):
  libbpf: make bpf_line/func_info_min public
  libbpf: add getters for BTF.ext func and line info

 tools/lib/bpf/btf.h             | 14 ++++++++++++++
 tools/lib/bpf/libbpf.c          | 20 ++++++++++++++++++++
 tools/lib/bpf/libbpf.h          |  6 ++++++
 tools/lib/bpf/libbpf.map        |  4 ++++
 tools/lib/bpf/libbpf_internal.h | 14 --------------
 5 files changed, 44 insertions(+), 14 deletions(-)

-- 
2.49.0


