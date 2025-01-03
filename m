Return-Path: <bpf+bounces-47838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4872FA00835
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 12:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF063A4421
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 11:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672821D131E;
	Fri,  3 Jan 2025 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyKup89a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED191B6CE6
	for <bpf@vger.kernel.org>; Fri,  3 Jan 2025 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735902204; cv=none; b=GtMm9ZUwQMkEYgohXah+gXOJD/4IGNA5+vR88xIiScQzOZOrxBbv4F3Ln30fTse8FuxFDKqc6Ku9eBQhhIKauKB2f24pU8ghjgQcbykXMoAEaW+x3HwRtvImIG+26xJ+pPu1j0EIbi5q560/7rl/zZs6c40qbum1CHusz2JfrRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735902204; c=relaxed/simple;
	bh=n/8jhcCXa3b70qjyYdMbO1jJgBZ8sIRjD/Qeh5FBrQg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=O+1aJFGDQQ3fw9EAmeiiDeUDbSQfzzPZBjHIEo3GDY1JfNtqldOuwg2cok53yhcZYTCJNnLDJ6tJ++8eUWwmkkaEvCPMJl/oC9tmk7TbkjkXQBnbhhpCo5aM1iyK+cOB0TJPQjrAu5JKR1RpC052DJPR36aU+PRSsaUn8hIxzeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyKup89a; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21634338cfdso242222005ad.2
        for <bpf@vger.kernel.org>; Fri, 03 Jan 2025 03:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735902202; x=1736507002; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+uFkoY2cyuru4W8MiypLuvmT5BaUQLkEorS4fXtJiIs=;
        b=VyKup89abXS/7IwrX5/GBfyQkVC1tmylSaWywbRf7c8zC9az4xgGAlyLzT8iaIHCMT
         pMRrefL/RKOvu++Bj8oWb4YUyY5BgZF6N9mYy57boiwYrvFeOpNI4Mf5aNp7PLsFDczE
         HilVCy0byamLnGkk1D0Iz1OzRX6BBQJ8NICTfnRV8K27yxEw+PSdqMj/DtRoFDsOMDIQ
         3jhfLIXi4sNiKkn2ja7MUFVvVU4A//5xvriIdGvnS92aAHXJ9xa2mPbl+obUiPnjdRpO
         wc9AN3f4sIZCvkjjJ6ETKHZCNEIoBsGDrbjDRlbaauecC5ztcMg3U5y9t+1fDC4Q1Vsu
         s3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735902202; x=1736507002;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+uFkoY2cyuru4W8MiypLuvmT5BaUQLkEorS4fXtJiIs=;
        b=rjP6H/l9FIXuxFIM6QML0sHJtf+sr8XhL6nocO8Lq6O4YiOzMZgxe4a+X9A0qWiNyC
         7Px1a8cGR9fCF9zxm56lKim3c7cVAyBuOnMC2Qg+HD/g0KpHet/U5MieFYNwiWt38n1G
         lCkFm31nLr+4W1e1pcShv0xy09IQbGRJ1T7rxOCA70LmBQYBDPBjZQJ4uSL5vnXL0FcG
         2TSyttyOsg68XjOUFO4ZH9uGl60Pjgj0AEP+XEnE6uOF/yvt59azbirw6wgpY04GL6v+
         7XJgVVaNZxDALyZ7Y5eaVWum8JxdMKrcP+LGynd4pVD9mELnNUNLqX8+Y+ciL5uVZEnR
         Q0aA==
X-Gm-Message-State: AOJu0YzGzZyB+lAMxrPeiBgjCVha1uDLj92pWYIchXEcRZ7Uvw9kKQc0
	IaF2q65Ofjsg52dsNTF2GVegFK2lql/uwzBfeY/ngmiulpMC05tH4D71uD5l8FrUAY+rpWcueqr
	5hR2Pb4aX9gvlt78/mi4cYm/MKj9UPDRA
X-Gm-Gg: ASbGnct9wxvZs9JFH4Hbqt8bPGhCoY+j1rR5Xb+Trld8uFoYXJn3VlVwdU0xJWK4dcN
	IuNFA2Wb+391d4oN2k/kw4sG4DbTlZyldKQeaZA==
X-Google-Smtp-Source: AGHT+IEIjNWaPDAMjtiaxdi87Bn84PfCsO6iMlRpqwm/QYpTiZU+AplReoVPrNqMLl07XBEOwgt6bE13DGzXPVgmBl0=
X-Received: by 2002:a05:6a00:4c07:b0:72a:9ddf:55ab with SMTP id
 d2e1a72fcca58-72abdd9c06dmr71648103b3a.10.1735902202447; Fri, 03 Jan 2025
 03:03:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: andrea terzolo <andreaterzolo3@gmail.com>
Date: Fri, 3 Jan 2025 12:03:11 +0100
Message-ID: <CAGQdkDt9zyQwr5JyftXqL=OLKscNcqUtEteY4hvOkx2S4GdEkQ@mail.gmail.com>
Subject: [QUESTION] Check bpf_loop support on kernels < 5.13
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi folks! I would like to check with you if the verifier failure I'm
facing is expected. The verifier rejects the following eBPF program on
kernel 5.10.232.

```
static long loop_fn(uint32_t index, void *ctx) {
  bpf_printk("handle_exit\n");
  return 0;
}

SEC("tp/raw_syscalls/sys_enter")
int test(void *ctx) {
  if (bpf_core_enum_value_exists(enum bpf_func_id, BPF_FUNC_loop)) {
    bpf_printk("loop\n");
    bpf_loop(12, loop_fn, NULL, 0);
  } else {
    bpf_printk("skip loop\n");
  }
  return 0;
}
```

With this error:

```
libbpf: prog 'test': BPF program load failed: Invalid argument
libbpf: prog 'test': -- BEGIN PROG LOAD LOG --
number of funcs in func_info doesn't match number of subprogs
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'test': failed to load: -22
```

This sounds like a valid use case. I would like to use bpf_loop if
supported by the running kernel otherwise I can fall back to a simple
loop. This issue goes away on kernel 5.13 with the introduction of
PTR_TO_FUNC [0]. Is there a way I can use CO-RE features to avoid this
issue? I would expect the verifier to prune the dead code inside the
`if` but the error seems to be triggered before the control flow
analysis.

[0]: https://github.com/torvalds/linux/commit/69c087ba6225b574afb6e505b72cb75242a3d844

