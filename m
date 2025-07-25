Return-Path: <bpf+bounces-64392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C56B12472
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 20:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EB187B393B
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 18:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CAE256C9B;
	Fri, 25 Jul 2025 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOz3Fljf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C02253B73;
	Fri, 25 Jul 2025 18:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469752; cv=none; b=NvX4eQOAKKelJ99sBahpHkLViwyTxzRY/7okto40k/k68k5haPF2mc4CGA85LvYCpMyLDP7wNy1NydNON/uXA8t5dOtEEitdvKcASvtmlRzDrPdcapT9j9q2xwxJwqgZIf69QW5TOozqHzlx5vbKM9Ta7fBvD5MUXhIsW3BuR0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469752; c=relaxed/simple;
	bh=5HnD127U0RmA5g8wzB91LQ8/iHNULtd2J9wpjP1AADM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cMlPf7jfbXtswsGmk1uX5tknQiAtjDR5zb5Qu0tjIVNBAJUtjs74OP5iHOcW83AGaaaXO8/AIJ02DmcQFzjle7lBP6yndo/B2U6YEmUBJIe46LsxfRnXH+OOKkNDFibZ41WAVThhINym2Fg870l3+CKbhfNgwGuJrg/7Os4FbyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOz3Fljf; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so1206845f8f.3;
        Fri, 25 Jul 2025 11:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753469749; x=1754074549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QN8SNAy5oXUGH45bNgGGBgKxJGcEdXKsduzRGIoDvck=;
        b=gOz3FljfU0542IaPbtnf536mwiUU88aSwgpm86upLdTEcRu4XTeG8nSyndFKPtz3Gh
         4EqlP4fPGfhb+8trgmXnqm+6VB30Y8XUqO/vfYcejuMplEr74F7cW+S3URT2+QVQkxE2
         HsBwFMUc0wEZ+46eC2S/DfOpdW/jLF/XjP+4JYI6EjBTziIlUI+S4qUDtG64EXcyGe0q
         M25JV3UQQnRSrQV8il7Rmthxlys9w9PgWTbfcVdR1gz8YSOB5Ig7AbkE5XPtntzPp8Qu
         UnNncB1VjaqOradJ/+5b1KAmAh7tsrG/pXOCPb6xm0z0V5zSgv1MULfyfx8YxYFl6Wid
         uC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469749; x=1754074549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QN8SNAy5oXUGH45bNgGGBgKxJGcEdXKsduzRGIoDvck=;
        b=FBCtnmBtNVWFVsHgqT3Ahop1W3q3dCYsRyFRCGO2vbs6zITUC/eQpVGvoYlhZB35Oz
         OGmLVIZ++IS/SFdUdLY5tGEaiu7FP4ISikO4z+P5MVZF/k+U+BZqzRYuUApKD/tO0EgJ
         RVhmTrd+bNQnxkl3SpKtoU1/yEqNngrlsSnq1sH4AHsHDDj8aae/mDMJJVz2uq9CeZTy
         Zd+VvI73ogA97ThjKbZwVqFE/cQ27nG5kHVKp3gAbYsS98Aygzc8dOn28LH8xtPZv+/d
         3HNvgrJf5bB/k2CoE9gMBT0WEhUE+o1gxy+z0YfYAHmcATxTm4A/9wXWNtejlgu9Ih6f
         D93w==
X-Forwarded-Encrypted: i=1; AJvYcCULw3oYVvU6fYwtZdpo81Q4Aa32sIB4x+cp7g6VQGD62rRf1iiLk9jPIe6ntDUSNW5xqps=@vger.kernel.org, AJvYcCUWtUA+VsoH6je57jHn7mOEtQlxOQOr8sjK84v2PtqO+FNEZBl/ZoqkGu/K7dXCZ6KX6qPjgcDN@vger.kernel.org, AJvYcCUiitufd7B5CG7nmBzj6v1a1/yO/nqHtnLAVS12jtQe1GNcKLeP9iCjElDbSIV+/ON71iyNhNl3iFptLNeq5JnS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8C5s3lPeu8+14mo6VyjhrhrVOBLBJ1qshmBf1F84oYGzP4/0t
	vg0P7TYWKRDpNppsKn/qGghiEoUtz0MrkLvHhNokAeiZzm+nrk2fQ5r/
X-Gm-Gg: ASbGncsi7RtzKE7ZiMzhCvqwe7obFg1mQAy8CovQvpffzIj/ZNIeP7pW4BwUTYEaO6a
	bXySH/1Jt2cyHSbqvCAyatWhdBthWJAWNpE2Aip/ql9R5Jn6sswfDRyda1oZRfDBuFGwAT6d8Fc
	mfHSyvTxaULWO/TpIE09XW4BXLTWp4B4NOaVs58wkb+3cqV2PmqI9TDCr1bR0F4xfnO/271Hjlx
	o2dN9lvGpfMvK4/m9ys5tmLnraso4ZIrRH6FBX8pq12g8s7Gy95sMynWsM75gIlGKIKYelDghcC
	PbPFWTO273k7Jl3/2fRAMt2eFqZisw4bMRMeR52eEZBZduQamBRJNqP17pMDE04Y51h8l6N5YNF
	0hlDbDobSyE+zAbaFxu6UjkylvOtJ1q9JjnFlCPD/ue3BfyU9
X-Google-Smtp-Source: AGHT+IH7JrVyK74x0ht78/X//xpkjNUu0tiNgYO+/jnaE1TcftRn8Hn0ZS0fmaAksMvWAZVrshvyNA==
X-Received: by 2002:a05:6000:2889:b0:3a8:6262:e78 with SMTP id ffacd0b85a97d-3b77663e8f5mr2305234f8f.37.1753469748390;
        Fri, 25 Jul 2025 11:55:48 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b778eb276esm607743f8f.6.2025.07.25.11.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:55:47 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: alexei.starovoitov@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	mahe.tardy@gmail.com,
	martin.lau@linux.dev,
	fw@strlen.de,
	netfilter-devel@vger.kernel.org,
	pablo@netfilter.org,
	netdev@vger.kernel.org,
	coreteam@netfilter.org
Subject: [PATCH bpf-next v1 0/4] bpf: add icmp_send_unreach kfunc
Date: Fri, 25 Jul 2025 18:53:38 +0000
Message-Id: <20250725185342.262067-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAADnVQKq_-=N7eJoup6AqFngoocT+D02NF0md_3mi2Vcrw09nQ@mail.gmail.com>
References: <CAADnVQKq_-=N7eJoup6AqFngoocT+D02NF0md_3mi2Vcrw09nQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is v2 of adding the icmp_send_unreach kfunc, as suggested during
LSF/MM/BPF 2025[^1]. The goal is to allow cgroup_skb programs to
actively reject east-west traffic, similarly to what is possible to do
with netfilter reject target.

The first step to implement this is using ICMP control messages, with
the ICMP_DEST_UNREACH type with various code ICMP_NET_UNREACH,
ICMP_HOST_UNREACH, ICMP_PROT_UNREACH, etc. This is easier to implement
than a TCP RST reply and will already hint the client TCP stack to abort
the connection and not retry extensively.

Note that this is different than the sock_destroy kfunc, that along
calls tcp_abort and thus sends a reset, destroying the underlying
socket.

Caveats of this kfunc design are that a cgroup_skb program can call this
function N times, thus send N ICMP unreach control messages and that the
program can return from the BPF filter with SK_PASS leading to a
potential confusing situation where the TCP connection was established
while the client received ICMP_DEST_UNREACH messages.

Another more sophisticated design idea would be for the kfunc to set the
kernel to send an ICMP_HOST_UNREACH control message with the appropriate
code when the cgroup_skb program terminates with SK_DROP. Creating a new
'SK_REJECT' return code for cgroup_skb program was generally rejected
and would be too limited for other program types support.

We should bear in mind that we want to add a TCP reset kfunc next and
also could extend this kfunc to other program types if wanted.

v2 updates:
- fix a build error from a missing function call rename;
- avoid changing return line in bpf_kfunc_init;
- return SK_DROP from the kfunc (similarly to bpf_redirect);
- check the return value in the selftest.

[^1]: https://lwn.net/Articles/1022034/

Mahe Tardy (4):
  net: move netfilter nf_reject_fill_skb_dst to core ipv4
  net: move netfilter nf_reject6_fill_skb_dst to core ipv6
  bpf: add bpf_icmp_send_unreach cgroup_skb kfunc
  selftests/bpf: add icmp_send_unreach kfunc tests

 include/net/ip6_route.h                       |  2 +
 include/net/route.h                           |  1 +
 net/core/filter.c                             | 59 +++++++++++
 net/ipv4/netfilter/nf_reject_ipv4.c           | 19 +---
 net/ipv4/route.c                              | 15 +++
 net/ipv6/netfilter/nf_reject_ipv6.c           | 17 +---
 net/ipv6/route.c                              | 18 ++++
 .../bpf/prog_tests/icmp_send_unreach_kfunc.c  | 99 +++++++++++++++++++
 .../selftests/bpf/progs/icmp_send_unreach.c   | 36 +++++++
 9 files changed, 233 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/icmp_send_unreach.c

--
2.34.1


