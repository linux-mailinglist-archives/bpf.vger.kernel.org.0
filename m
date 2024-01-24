Return-Path: <bpf+bounces-20237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD01783AD9D
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 16:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EED41F28CCA
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 15:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA677C09D;
	Wed, 24 Jan 2024 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j38NdcDQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0037C099
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706111025; cv=none; b=ftMvHObbmTk0nQL1GX+W3FH5DLYDjodtMdO+soYI5223SrK5foP2ujqOqBFDkdAxMtmjIW5qmDXhzurBVAkiaDTNuw4LmXXOfzEbEuo20hOPuO79PyQfCNL6Frd8bQBpe0PBfxt2DZw2ikcln+cgZn8opowvwIPPCwVqEWJoCFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706111025; c=relaxed/simple;
	bh=hGQqiKBHvzb3o2ms9is45LVkn1my/EJQ8YhiHXiMpRU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UsVbZ2Bd/bt2KZXStXDwBHyO0BAelQNyWioYURqoF6PH4wcipJz3gehtKT+otoZFmR0xcSrcLD1jcqQMaYDhusUn+NZfP80VvA9tl3j/KW4vzf1o8CUViISTPTG6t0p9QJu1dsQfdWuMBFGchvyPyHULyVyyrrnh4z2Nz6lcark=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j38NdcDQ; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-46af87380c7so520366137.3
        for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 07:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706111023; x=1706715823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dieMocq8dOdDtcyP+j8s7bY5QEd7/F9sYxiZCAejqkA=;
        b=j38NdcDQ17K/g+CFGvBf3dBtG2ZqS9t+QrVOv1eHrbcsF601HJmJgVwdD8+ozW6+07
         QBim+HiDaQ07VbtHZHXOaGB2oUbQQgLZBtGAcjc2f7HtdAyJCTzVffO9FCIzfIfUbtTK
         CNWZlOBHOPckwmDb7m2xpd80tKJJ5Q3gNUuTSXO2Vpon6cvb/M2sbbYPh84j6SfcxK3z
         csugJjA4EP+n4Lv60hol+oiRLUxeXF+LY+xn9UPAjmLvCXAakZLGLWpXFc3hDnESVJGr
         NyyVBl2pEm/tWu7oJJcoiEDiELTGwU8IyUcTiUi+1/iWqa/i3F9qIXcxY2XD5Jfmvz6p
         9AWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706111023; x=1706715823;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dieMocq8dOdDtcyP+j8s7bY5QEd7/F9sYxiZCAejqkA=;
        b=ex5806YzspjgjRtTosUFT9gRNPJtR3EC34Wnn1sjIR3C8IrUifRAVkrgTsLHDLaDyk
         RN4sFYlDqHtUJEvF/0ekjGY41B9uO8YhIV7LbIXk/Pm3nhAzHGAhAuPoV2DrRUTIepjk
         jr9ahhzBHxwqfR9Sff5Pc8U9LH57LsRy3joBVYYUuW9jRi0ARh3K7ubwvhK3qrhrmH2J
         z6bedbZGVbLgHvSbbZ9uoIRXi5YbHdw7Qf66bI04y5mrzBGXpQBvmSHuqfOusIq6jjA7
         Rgy0VufejqjazZD2dc/M74xkmAmWDcUpqn3XceoOWd8h4DH2QFXQnpcot1eoCyQhTyuW
         aNeA==
X-Gm-Message-State: AOJu0YzmsM1JHxQ6KBpFaRmPI9DojLhYY008nVhuiY3UrCrQHckWo87N
	sMZiR594r7j/06t6L+VqcczNXktb56/9ExclaQpMECVRSWPK69hrdyL4DdKVWu6AT0C2IkcCNX7
	T3wd0XqF7xwbDL9RlyolN8w3ynbork8rDQUzB+w==
X-Google-Smtp-Source: AGHT+IFJNkCeCdjV/I3qIoV+3b1ziUOqk/J0g5qOVmv3QFmM9fMP4ZZflxgLMTv6VJtje91jOBQBspAEkbCU/wMgJaQ=
X-Received: by 2002:a05:6102:2921:b0:468:db1e:21b5 with SMTP id
 cz33-20020a056102292100b00468db1e21b5mr5899474vsb.12.1706111022971; Wed, 24
 Jan 2024 07:43:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Wed, 24 Jan 2024 10:43:32 -0500
Message-ID: <CAE5sdEigPnoGrzN8WU7Tx-h-iFuMZgW06qp0KHWtpvoXxf1OAQ@mail.gmail.com>
Subject: [RFC PATCH] bpf: Prevent recursive deadlocks in BPF programs attached
 to spin lock helpers using fentry/ fexit
To: bpf@vger.kernel.org
Cc: "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "olsajiri@gmail.com" <olsajiri@gmail.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "Williams, Dan" <djwillia@vt.edu>, 
	"Somaraju, Sai Roop" <sairoop@vt.edu>, "Sahu, Raj" <rjsu26@vt.edu>, "Craun, Milo" <miloc@vt.edu>, 
	"sidchintamaneni@vt.edu" <sidchintamaneni@vt.edu>
Content-Type: text/plain; charset="UTF-8"

While we were working on some experiments with BPF trampoline, we came
across a deadlock scenario that could happen.

A deadlock happens when two nested BPF programs tries to acquire the
same lock i.e, If a BPF program is attached using fexit to
bpf_spin_lock or using a fentry to bpf_spin_unlock, and it then
attempts to acquire the same lock as the previous BPF program, a
deadlock situation arises.

Here is an example:

SEC(fentry/bpf_spin_unlock)
int fentry_2{
  bpf_spin_lock(&x->lock);
  bpf_spin_unlock(&x->lock);
}

SEC(fentry/xxx)
int fentry_1{
  bpf_spin_lock(&x->lock);
  bpf_spin_unlock(&x->lock);
}

To prevent these cases, a simple fix could be adding these helpers to
denylist in the verifier. This fix will prevent the BPF programs from
being loaded by the verifier.

previously, a similar solution was proposed to prevent recursion.
https://lore.kernel.org/lkml/20230417154737.12740-2-laoar.shao@gmail.com/

Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
---
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 65f598694d55..8f1834f27f81 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20617,6 +20617,10 @@ BTF_ID(func, preempt_count_sub)
 BTF_ID(func, __rcu_read_lock)
 BTF_ID(func, __rcu_read_unlock)
 #endif
+#if defined(CONFIG_DYNAMIC_FTRACE)
+BTF_ID(func, bpf_spin_lock)
+BTF_ID(func, bpf_spin_unlock)
+#endif
 BTF_SET_END(btf_id_deny)

