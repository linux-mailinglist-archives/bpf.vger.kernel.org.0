Return-Path: <bpf+bounces-29507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B414B8C2A4B
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15C18B25ECE
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF52345BE4;
	Fri, 10 May 2024 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQ1X7Dpr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FCC446A1
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367794; cv=none; b=BJU3C47mBwIuw3T2aoSv+raGjPxeVNoVRo6qz+4LsVb4UyA0kNy97kA+gy1KPmgUTmgNWUEGCz354YhKbupkjU7nUofdNBAz2KcXtHozgfO0kFJ7BY0s6/adqr7/YHy3EuOay04TJ5hWJZLHlZrF3ld0RfW2VyaEo3tJU/5EJBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367794; c=relaxed/simple;
	bh=tl7uYqB6OKFZzukEsSW1YKfc/oU1gj82SWaMnEhbGe8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bHFQYdOIpaRF0jkCW/IeLkPq99bpKhpYl1Ghpi4xr2uB2Uc0oUyIAgcG/KIFSHfK+tZwcoOuMu9utxsD2MmjoBeiFOQjVN3w/OLDtpIuVVIc5RUsOz+fexDdEcm9ItPEFaVAI/PpLZEJc2O1l5iAl9JkaJlVutkOPl5zE4G2Vk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fQ1X7Dpr; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de60cd96bf3so5060855276.0
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 12:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715367792; x=1715972592; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=muJVZn0eqnPzZVokEnAWChvrCgWqrca9sExKTVTOn34=;
        b=fQ1X7Dprg+goCox+FDeL4HiNjXfThic1TISgnD86QZnfKIgdHGa4QgNG2RewyTehUj
         oFO8hLIqAADGy01BiPD+4Nj5kscW/ClgtZIo7hhWElR94abB8CuAIGdlPnXz0b64Mxua
         McVRYACz2gCdDZV13e485HiNgf2CGRXV2Ku5ogLqQ8uPahHlmBawtU5SeANFvt7F5H7q
         atrKpe9j+sFqIq/idIHOeFQcgY99kxxzQxZ52meDgh8lpgVGB1qaZW0BgL04k0Cgkn1O
         4tVeh9wWtworVWbrNKCpPVFe/fdA0SGwGNcr1ZxI0R+stcapfbzOXu0Ee36vaaUFNA4E
         CoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715367792; x=1715972592;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=muJVZn0eqnPzZVokEnAWChvrCgWqrca9sExKTVTOn34=;
        b=L7paveBCIxK7xMCSTFNVWUoK+z0UbTTT6JLbQdd0/95CndeumlBqa3aV9xj78KFiZ3
         zXxxfN/0kJdpHGH1coXlBRd8K6fZyDRVISNN9EmecNaeDJjDKhp7dbxw57O7Y60FtU6u
         R3eLigkzouVT7nhU/zr1c7ugDR8+s0RnFDzuCFHV0OoO3mxuf9X7vnFOvzetmQTnXKNo
         Y4rHvbCnURWh74JQ1M0iFf0j2mpUvuKIqr8P/TZYhU8do+aJD1SurLvO8CcqybScMHMx
         Uto0lRBEWFS0aAyhC80tKlPjdYnAiJHyfYVBlt+3SyJV7ZejdAx5GikCpCzi49B4HvjG
         JHFg==
X-Gm-Message-State: AOJu0YyjMI3mWrucwO9UhRn7mc+JwzPWxem7LNoRhM8GctqVivgNtq4w
	eZJRkFL/stpmmO517RlpJOpvqksl7mswCrp9WfgLp/4vWjyFzWILuACOFKv5y0BvgS3lEJf+Gja
	cHcTkEZTEfJwdDw5EX4oOVRjqGNcZHydPq+SVXE8UfZOqU6CTcBeD6RmshqWiHgCIA89w1iZo4Z
	5Nbhit+Q63KXOLF7FbtRHkG20=
X-Google-Smtp-Source: AGHT+IEtzdk5stWm8/oEmcYfSAoQtnbegZorgWM0U+9BcIk8LlAcKaluoAnFYHzMngso7apm6TwbSQLGKA==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6902:1004:b0:dbe:d0a9:2be3 with SMTP id
 3f1490d57ef6-dee4e558e2dmr1022404276.3.1715367791474; Fri, 10 May 2024
 12:03:11 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:31 -0500
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-15-jrife@google.com>
Subject: [PATCH v1 bpf-next 14/17] selftests/bpf: Expand sockaddr program
 return value tests
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <tanggeliang@kylinos.cn>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch expands verifier coverage for program return values to cover
bind, connect, sendmsg, getsockname, and getpeername hooks. It also
rounds out the recvmsg coverage by adding test cases for recvmsg_unix
hooks.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/progs/verifier_sock_addr.c  | 294 ++++++++++++++++++
 1 file changed, 294 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sock_addr.c b/tools/testing/selftests/bpf/progs/verifier_sock_addr.c
index 5081fa723d3a7..9c31448a0f520 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock_addr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock_addr.c
@@ -34,4 +34,298 @@ int recvmsg6_bad_return_code(struct bpf_sock_addr *ctx)
 	return 0;
 }
 
+SEC("cgroup/recvmsg_unix")
+__success
+int recvmsg_unix_good_return_code(struct bpf_sock_addr *ctx)
+{
+	return 1;
+}
+
+SEC("cgroup/recvmsg_unix")
+__failure __msg("At program exit the register R0 has smin=0 smax=0 should have been in [1, 1]")
+int recvmsg_unix_bad_return_code(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
+SEC("cgroup/sendmsg4")
+__success
+int sendmsg4_good_return_code_0(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
+SEC("cgroup/sendmsg4")
+__success
+int sendmsg4_good_return_code_1(struct bpf_sock_addr *ctx)
+{
+	return 1;
+}
+
+SEC("cgroup/sendmsg4")
+__failure __msg("At program exit the register R0 has smin=2 smax=2 should have been in [0, 1]")
+int sendmsg4_bad_return_code(struct bpf_sock_addr *ctx)
+{
+	return 2;
+}
+
+SEC("cgroup/sendmsg6")
+__success
+int sendmsg6_good_return_code_0(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
+SEC("cgroup/sendmsg6")
+__success
+int sendmsg6_good_return_code_1(struct bpf_sock_addr *ctx)
+{
+	return 1;
+}
+
+SEC("cgroup/sendmsg6")
+__failure __msg("At program exit the register R0 has smin=2 smax=2 should have been in [0, 1]")
+int sendmsg6_bad_return_code(struct bpf_sock_addr *ctx)
+{
+	return 2;
+}
+
+SEC("cgroup/sendmsg_unix")
+__success
+int sendmsg_unix_good_return_code_0(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
+SEC("cgroup/sendmsg_unix")
+__success
+int sendmsg_unix_good_return_code_1(struct bpf_sock_addr *ctx)
+{
+	return 1;
+}
+
+SEC("cgroup/sendmsg_unix")
+__failure __msg("At program exit the register R0 has smin=2 smax=2 should have been in [0, 1]")
+int sendmsg_unix_bad_return_code(struct bpf_sock_addr *ctx)
+{
+	return 2;
+}
+
+SEC("cgroup/getpeername4")
+__success
+int getpeername4_good_return_code(struct bpf_sock_addr *ctx)
+{
+	return 1;
+}
+
+SEC("cgroup/getpeername4")
+__failure __msg("At program exit the register R0 has smin=0 smax=0 should have been in [1, 1]")
+int getpeername4_bad_return_code(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
+SEC("cgroup/getpeername6")
+__success
+int getpeername6_good_return_code(struct bpf_sock_addr *ctx)
+{
+	return 1;
+}
+
+SEC("cgroup/getpeername6")
+__failure __msg("At program exit the register R0 has smin=0 smax=0 should have been in [1, 1]")
+int getpeername6_bad_return_code(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
+SEC("cgroup/getpeername_unix")
+__success
+int getpeername_unix_good_return_code(struct bpf_sock_addr *ctx)
+{
+	return 1;
+}
+
+SEC("cgroup/getpeername_unix")
+__failure __msg("At program exit the register R0 has smin=0 smax=0 should have been in [1, 1]")
+int getpeername_unix_bad_return_code(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
+SEC("cgroup/getsockname4")
+__success
+int getsockname4_good_return_code(struct bpf_sock_addr *ctx)
+{
+	return 1;
+}
+
+SEC("cgroup/getsockname4")
+__failure __msg("At program exit the register R0 has smin=0 smax=0 should have been in [1, 1]")
+int getsockname4_bad_return_code(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
+SEC("cgroup/getsockname6")
+__success
+int getsockname6_good_return_code(struct bpf_sock_addr *ctx)
+{
+	return 1;
+}
+
+SEC("cgroup/getsockname6")
+__failure __msg("At program exit the register R0 has smin=0 smax=0 should have been in [1, 1]")
+int getsockname6_bad_return_code(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
+SEC("cgroup/getsockname_unix")
+__success
+int getsockname_unix_good_return_code(struct bpf_sock_addr *ctx)
+{
+	return 1;
+}
+
+SEC("cgroup/getsockname_unix")
+__failure __msg("At program exit the register R0 has smin=0 smax=0 should have been in [1, 1]")
+int getsockname_unix_unix_bad_return_code(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
+SEC("cgroup/bind4")
+__success
+int bind4_good_return_code_0(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
+SEC("cgroup/bind4")
+__success
+int bind4_good_return_code_1(struct bpf_sock_addr *ctx)
+{
+	return 1;
+}
+
+SEC("cgroup/bind4")
+__success
+int bind4_good_return_code_2(struct bpf_sock_addr *ctx)
+{
+	return 2;
+}
+
+SEC("cgroup/bind4")
+__success
+int bind4_good_return_code_3(struct bpf_sock_addr *ctx)
+{
+	return 3;
+}
+
+SEC("cgroup/bind4")
+__failure __msg("At program exit the register R0 has smin=4 smax=4 should have been in [0, 3]")
+int bind4_bad_return_code(struct bpf_sock_addr *ctx)
+{
+	return 4;
+}
+
+SEC("cgroup/bind6")
+__success
+int bind6_good_return_code_0(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
+SEC("cgroup/bind6")
+__success
+int bind6_good_return_code_1(struct bpf_sock_addr *ctx)
+{
+	return 1;
+}
+
+SEC("cgroup/bind6")
+__success
+int bind6_good_return_code_2(struct bpf_sock_addr *ctx)
+{
+	return 2;
+}
+
+SEC("cgroup/bind6")
+__success
+int bind6_good_return_code_3(struct bpf_sock_addr *ctx)
+{
+	return 3;
+}
+
+SEC("cgroup/bind6")
+__failure __msg("At program exit the register R0 has smin=4 smax=4 should have been in [0, 3]")
+int bind6_bad_return_code(struct bpf_sock_addr *ctx)
+{
+	return 4;
+}
+
+SEC("cgroup/connect4")
+__success
+int connect4_good_return_code_0(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
+SEC("cgroup/connect4")
+__success
+int connect4_good_return_code_1(struct bpf_sock_addr *ctx)
+{
+	return 1;
+}
+
+SEC("cgroup/connect4")
+__failure __msg("At program exit the register R0 has smin=2 smax=2 should have been in [0, 1]")
+int connect4_bad_return_code(struct bpf_sock_addr *ctx)
+{
+	return 2;
+}
+
+SEC("cgroup/connect6")
+__success
+int connect6_good_return_code_0(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
+SEC("cgroup/connect6")
+__success
+int connect6_good_return_code_1(struct bpf_sock_addr *ctx)
+{
+	return 1;
+}
+
+SEC("cgroup/connect6")
+__failure __msg("At program exit the register R0 has smin=2 smax=2 should have been in [0, 1]")
+int connect6_bad_return_code(struct bpf_sock_addr *ctx)
+{
+	return 2;
+}
+
+SEC("cgroup/connect_unix")
+__success
+int connect_unix_good_return_code_0(struct bpf_sock_addr *ctx)
+{
+	return 0;
+}
+
+SEC("cgroup/connect_unix")
+__success
+int connect_unix_good_return_code_1(struct bpf_sock_addr *ctx)
+{
+	return 1;
+}
+
+SEC("cgroup/connect_unix")
+__failure __msg("At program exit the register R0 has smin=2 smax=2 should have been in [0, 1]")
+int connect_unix_bad_return_code(struct bpf_sock_addr *ctx)
+{
+	return 2;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.45.0.118.g7fe29c98d7-goog


