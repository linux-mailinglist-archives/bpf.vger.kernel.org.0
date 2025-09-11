Return-Path: <bpf+bounces-68102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B671B52EFA
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 12:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831C01BC7CBA
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 10:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FD430FF13;
	Thu, 11 Sep 2025 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nALQ5mM8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F863347D0;
	Thu, 11 Sep 2025 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587921; cv=none; b=O4e45xYhDzCU9EUkyv70YZBFyjAVr/I0cZ3UOv4FW2m2+xk4I+UkMRWDBx2FgSP/IIL7wdHGZTT3/DidN/uDzweu07N/mceQG98lvZ4GMmlhilAyVpnYBhUenW3RCUnL4Lt3esoJFUhC1da8Rt5v8np6Tj76tYwNg0IvZ1Wj0vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587921; c=relaxed/simple;
	bh=XDfnGzQvgAsoBlF/K94mzdMnT8O5TmQEWbVoEbnzsy0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=l9P5Xhm/0Blxf1RJooxiDn5K7ksYrC6hSQopu4atPPjT7snwYFu5rWzwR3x0MmkViApwi2UJJQxQqmTJUKsmzBsoGYbBe3WIpZz9wusOV69YR03QrAenRhiXW86lBGW1EnU5yzu0gjZ8iiuQKiol4xhGFqTma3srT/4G8mO0YPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nALQ5mM8; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-336cdca667aso4662561fa.0;
        Thu, 11 Sep 2025 03:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757587918; x=1758192718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0ixdR1P5S055FmVwQTh6Cai1jKWFGKTiPJeK5lzYK6I=;
        b=nALQ5mM83NVCEyn4ACzXNXDxXIwmwYmOzWFDKr1MiRsM5qdVlblMXeBTCxOimDdu7J
         sYCHa80S+9fqxMUJ9d5FwkhWfLmv1j26CsNhxEGnmlFw+P1jf+/lcjIZleMB8mnpzUVp
         uIUbPKskBniKB+Iz7AULLLmCPivW0k9Hd4mqkwmLiAO+0Kfu9IHFz3wLq+gqY7pukwPe
         LW9OaJr/4RivNDbqLKsFbeDk5USnZYz6dvO8HG7spYfdhuD8cXkuud2DZVrC3yPrljHd
         jreD8xEcvQOO40v04Kdxau+lAQWef2l2DEBR7ZIP1kwIMnl0t2IOhlxlSF+TlxUit/ju
         4AiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757587918; x=1758192718;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ixdR1P5S055FmVwQTh6Cai1jKWFGKTiPJeK5lzYK6I=;
        b=NvWmSNBpcHaLODuQngwLVdPdIpQrsXCLcRhG3fvzyaG6Znt7eds3ZvjJa4i9DD1T4f
         CKBLGawQDd+P23gFogFh+ItfoxRzV8Bjo6yFrKKtxMqs2SCWyzDOkW6ADfDy4KQiZ1nP
         a3mOjmoDaKeuLysfNit21b3pzSjqrujYTmidcEkU0MscDuNvcIREii5XQMYbUCMNO9hi
         Eu+UUGHfE5vno7Uyi4S1j9XpXj3JbibHm++wvA4Dmd/kgvztpBFYzkUKGGYDA9vwBIx8
         Jw1CWvz5BcKE6QKoQjmKkSVmWspUyNDpTzMQXwKmUMGIMg+Meb6FF+5vuixQhmOxOrep
         k3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4GBrEiGTPLSKADk4ggLQcA6lETscxVSVtAUUtrfZjYnVRr3F+uTtbJhn1t4zb8mKAXxdknCMK01g=@vger.kernel.org, AJvYcCX8YmzfGwqpW8SQLdLoTnz80mMrXH+nuXn5ksI33mow44mjChCBiIrv7t9P8v+kxi0ShxySZNpTLaoJMxYs@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjn0VdXAaYMhdo6gDzWphjK2K6EeFJuCAYgZi7h+vpRw+H6x0+
	mqzC2BF7turLFBkc7NP4IVAxoBWpJ3AIm2OLvIAqTMHRvmCiuUSL0016pftRkG5qZJXFPlSoCUy
	atSxIOyD/qQ64ltnazrOPbjbyknTs36QgndYTazZr7g==
X-Gm-Gg: ASbGncsbnV26AK1Xp8NuiL6lDyi6WzoGZbQRW/ys1+lnwe8b7JFYaV2nDha7npCdmiO
	m1uR8Wd1XFOcmP0KZNKWsJflt76GBVlF/rX9fr4bN6JX0iUNaRB/DqKiCZVVvwlRv+C0wu/4tc6
	8F2W7qHW8Oth/1GIr4AC9U6j8pNNae918GucuxH3/4+Kk/r1lUWRwPyj0wIGWBScPvUcp43v6sE
	W8yJtOzf/9TRu/fYBw=
X-Google-Smtp-Source: AGHT+IHwmeQF/QpdMejZQgqtbEtmtPGeG7MA6HXsyBPQloibGMLBag0P50QIFGu55kfsGA2ooOUfhh9nPeaYGHL3tzQ=
X-Received: by 2002:a2e:bc08:0:b0:350:580c:dee6 with SMTP id
 38308e7fff4ca-350580ce6d8mr547721fa.37.1757587917540; Thu, 11 Sep 2025
 03:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ariel Silver <arielsilver77@gmail.com>
Date: Thu, 11 Sep 2025 13:51:45 +0300
X-Gm-Features: Ac12FXwhLXpMFLrgl-uHRsXdAD7Zedj745SedLjljUtczYbDYAGRw8CjHjbqB_k
Message-ID: <CACKMdfmZo0520HqP_4tBDd5UVf8UY7r5CycjbGQu+8tcGge99g@mail.gmail.com>
Subject: [PATCH v2] docs/bpf: clarify ret handling in LSM BPF programs
To: bpf@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: kpsingh@kernel.org, mattbobrowski@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"

v2: Fixed trailing whitespace (reported by checkpatch.pl)

Docs currently suggest that all attached BPF LSM programs always run
and that ret simply carries the previous return code. In reality,
execution stops as soon as one program returns non-zero. This is
because call_int_hook() breaks out of the loop when RC != 0, so later
programs are not executed.

Signed-off-by: arielsilver77@gmail.com <arielsilver77@gmail.com>
---
 Documentation/bpf/prog_lsm.rst | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/bpf/prog_lsm.rst b/Documentation/bpf/prog_lsm.rst
index ad2be02f3..92bfb64c2 100644
--- a/Documentation/bpf/prog_lsm.rst
+++ b/Documentation/bpf/prog_lsm.rst
@@ -66,21 +66,17 @@ example:

    SEC("lsm/file_mprotect")
    int BPF_PROG(mprotect_audit, struct vm_area_struct *vma,
-            unsigned long reqprot, unsigned long prot, int ret)
+            unsigned long reqprot, unsigned long prot)
    {
-       /* ret is the return value from the previous BPF program
-        * or 0 if it's the first hook.
-        */
-       if (ret != 0)
-           return ret;
-
        int is_heap;

        is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
               vma->vm_end <= vma->vm_mm->brk);

        /* Return an -EPERM or write information to the perf events buffer
-        * for auditing
+        * for auditing.
+        * Returning a non-zero value will stop the chain of
+        * LSM BPF programs attached to the same hook.
         */
        if (is_heap)
            return -EPERM;
-- 
2.50.1

