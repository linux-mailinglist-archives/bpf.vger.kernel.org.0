Return-Path: <bpf+bounces-27300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D13B8ABAD6
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 11:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02720281C8A
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 09:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE23175AD;
	Sat, 20 Apr 2024 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVJmlWH5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436E3199AD
	for <bpf@vger.kernel.org>; Sat, 20 Apr 2024 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713606330; cv=none; b=uknMe+6/vTWk6sqzLuPmLzx7PqaWK1nDm28Rhv2IKG0dlBEK4RbwA6CyO/fiPD5peSdWPnPKPK7C95kcdf0CarBYPVORsWaPi9w8yNpi4su/VyoxwnPXF80rMZ5xeC3zqVehgKtv6r8PUMAEIaYZaK5VAKrCh5tAWIT87drnQ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713606330; c=relaxed/simple;
	bh=Nv6So8Z2DRmu0ela8Elt/0ineBrJ5jcHCmBRltPsZBA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=a3xzLqt6PME9agq6x1YZ/mw1h+CiCG2UDdyeEuc0bDxXzjiIX+U1P1neXbZ3WXhvFmhgI5BgdB/48j3z8iOT4x+x7lA/VchJhO0shG0rRQo0R6ItEDxiRIzM+YWuan42WIA3TQvd3SjADdDxoY6b/GPagAFr9W+GJ61oUXmekp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVJmlWH5; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4daa5d0afb5so843306e0c.0
        for <bpf@vger.kernel.org>; Sat, 20 Apr 2024 02:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713606328; x=1714211128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9zY9ICDhILMi1pti1vWp1Ug1pocrL7WDlqIClHJg+0w=;
        b=iVJmlWH5yIWk4GcZUCLHl7u9Ni6mld7GE4WP2eQqzjwbQoB4NV4Or7AwnKOveypdps
         7BiwhdGRFoAmzXoXsUHKHwVJYTgNMt/DZ8drpWPe5Jx9mTQ8HpHuc/10cAQA9TR3cm2R
         /fMgOt7okTlanMIkXp1o93NjanpgOC9RwP4+ZzsQ4XOOmo7KN81kdG8rzhc1oKC3q89U
         f7f6KArrGhkehCNEBVOfjV93hgzg2ogZ19CryaKU+LEJLD/Z3+epR5qrTD9/AZonRsiN
         QZudWIYroOLpYBGNOqrE23h4nQN2rASk/mvp9DPeNQB/5t90uIK3jJ4euKd7LMvSWJq+
         Iu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713606328; x=1714211128;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9zY9ICDhILMi1pti1vWp1Ug1pocrL7WDlqIClHJg+0w=;
        b=UMTCZ06/pwz8cuJewNnzzrfhjHADsXAwnEP29U34s4uE3dmGNy8xBQ0OCOGhgPGw1q
         /HeotKoTvHpvMgNQIRrDutGtPlWaANs56GQB0MjEIR68wZyp5sbwS+YxOsdqBZGFZjxx
         idBbQnztOWIuVit5rZvEPlzfX2uNo4MUOMd9LZj2CeAWt3w333rWfuvG09/ZHKD/+fnP
         7JbYUY8QNJckIhgKlhc22ORAMgRns8XnJi4G6AChrnoBynWrYHVd0WrmIs1g94KeN/Vm
         TiL5LR1JlykOHiUxfGtjnCVgzyB8IjWWYfwd4HU9NdVWAse5HwZpugSgJ6jQAa1vZAuF
         NBXw==
X-Gm-Message-State: AOJu0YyYqfCF5yLVad3bZ5tUckcCbN7SWH2SbAN444odYwDxgfkI3o69
	IeEgDu4nwzhRyXWBcMMtEazdOv6NZM0bBYmTC0CB1mb6abXX7Jkul7MVmxWzOIhIrAK6r3qi4qv
	EMR+Sz1a+ZZcOwofTQnLYNYTnvdjx8k6cyfc=
X-Google-Smtp-Source: AGHT+IFUIfbw7v3UZh92/niaaUHVgxHjzxtlcnguqA9YNaBjSsAgSYwRezmCrrG8+7kyoQhAe9XEIpMm17G6/YnTl/I=
X-Received: by 2002:a05:6122:3bcb:b0:4c9:b8a8:78d4 with SMTP id
 ft11-20020a0561223bcb00b004c9b8a878d4mr5531562vkb.3.1713606328104; Sat, 20
 Apr 2024 02:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Sat, 20 Apr 2024 05:45:17 -0400
Message-ID: <CAE5sdEjqMe2pMDOO4MZkuncKu5PxMvcxtXmnpjwpHSM1Ek9Hgw@mail.gmail.com>
Subject: [PATCH bpf-next] Add notrace to queued_spin_lock_slowpath function to
 avoid deadlocks
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, daniel@iogearbox.net, 
	Jiri Olsa <olsajiri@gmail.com>, andrii@kernel.org, 
	Yonghong Song <yonghong.song@linux.dev>, "Craun, Milo" <miloc@vt.edu>, "Sahu, Raj" <rjsu26@vt.edu>, 
	Roop Anna <sairoop@vt.edu>, "Williams, Dan" <djwillia@vt.edu>
Content-Type: text/plain; charset="UTF-8"

This patch is to prevent deadlocks when multiple bpf
programs are attached to queued_spin_locks functions. This issue is similar
to what is already discussed [1] before with the spin_lock helpers.

The addition of notrace macro to the queued_spin_locks
has been discussed [2] when bpf_spin_locks are introduced.

[1] https://lore.kernel.org/bpf/CAE5sdEigPnoGrzN8WU7Tx-h-iFuMZgW06qp0KHWtpvoXxf1OAQ@mail.gmail.com/#r
[2] https://lore.kernel.org/all/20190117011629.efxp7abj4bpf5yco@ast-mbp/t/#maf05c4d71f935f3123013b7ed410e4f50e9da82c

Fixes: d83525ca62cf ("bpf: introduce bpf_spin_lock")
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
---
 kernel/locking/qspinlock.c                    |  2 +-
 .../bpf/prog_tests/tracing_failure.c          | 24 +++++++++++++++++++
 .../selftests/bpf/progs/tracing_failure.c     |  6 +++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index ebe6b8ec7cb3..4d46538d8399 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -313,7 +313,7 @@ static __always_inline u32
__pv_wait_head_or_lock(struct qspinlock *lock,
  * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
  *   queue               :         ^--'                             :
  */
-void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+notrace void __lockfunc queued_spin_lock_slowpath(struct qspinlock
*lock, u32 val)
 {
  struct mcs_spinlock *prev, *next, *node;
  u32 old, tail;
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
index a222df765bc3..822ee6c559bc 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
@@ -28,10 +28,34 @@ static void test_bpf_spin_lock(bool is_spin_lock)
  tracing_failure__destroy(skel);
 }

+static void test_queued_spin_lock(void)
+{
+ struct tracing_failure *skel;
+ int err;
+
+ skel = tracing_failure__open();
+ if (!ASSERT_OK_PTR(skel, "tracing_failure__open"))
+ return;
+
+ bpf_program__set_autoload(skel->progs.test_queued_spin_lock, true);
+
+ err = tracing_failure__load(skel);
+ if (!ASSERT_OK(err, "tracing_failure__load"))
+ goto out;
+
+ err = tracing_failure__attach(skel);
+ ASSERT_ERR(err, "tracing_failure__attach");
+
+out:
+ tracing_failure__destroy(skel);
+}
+
 void test_tracing_failure(void)
 {
  if (test__start_subtest("bpf_spin_lock"))
  test_bpf_spin_lock(true);
  if (test__start_subtest("bpf_spin_unlock"))
  test_bpf_spin_lock(false);
+ if (test__start_subtest("queued_spin_lock_slowpath"))
+ test_queued_spin_lock();
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_failure.c
b/tools/testing/selftests/bpf/progs/tracing_failure.c
index d41665d2ec8c..2d2e7fc9d4f0 100644
--- a/tools/testing/selftests/bpf/progs/tracing_failure.c
+++ b/tools/testing/selftests/bpf/progs/tracing_failure.c
@@ -18,3 +18,9 @@ int BPF_PROG(test_spin_unlock, struct bpf_spin_lock *lock)
 {
  return 0;
 }
+
+SEC("?fentry/queued_spin_lock_slowpath")
+int BPF_PROG(test_queued_spin_lock, struct qspinlock *lock, u32 val)
+{
+ return 0;
+}
--
2.43.0

