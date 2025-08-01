Return-Path: <bpf+bounces-64938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79B9B18942
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 00:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB17F627A19
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 22:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F28E236A79;
	Fri,  1 Aug 2025 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrUgXUf0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAB213A3ED;
	Fri,  1 Aug 2025 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754088091; cv=none; b=rSm7OeufMrU/ZDss8t6sxkg/LaiYc0CdFjPkk2mueW5H1dWJn7LVrrVgOPIvFXiul/rPzgr2wc+SV8NEtMfsrjVVJoclV3DprtVYvnDBGvrmWETg8EhX4LXW+nL/PFUoYQCqdq/xolPQAXT/Igbwz6AtrbYdr97VeyaRBl1r530=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754088091; c=relaxed/simple;
	bh=tmkBsNfvLY5Ls5g0seWdOK8SmyU5N65ROPp8aH5mD74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P74H6JoMApXz/56Lcos7j8V8i+h+tN03zxZjUA2QaJGxTOvUpaTdv8VMNNqxoDppO8w823c61OxwTXjo31H6Ha4hD4WKkCOXv5NsGeGPJI4CRLiZBBBwE7MGkEgMQbE0TZFR8Y/5Mpk+RX8409qIcNc/SccF2ek8boHkgmELoF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrUgXUf0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4561a4a8bf2so13440885e9.1;
        Fri, 01 Aug 2025 15:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754088088; x=1754692888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/dtd1R/YKxJbtCS8+hX8EAXfF5gtV7Hz3MRhL0yHBg=;
        b=VrUgXUf0qcHFZZkL1pcnT+5rNTNDI3QBqo0FQ9Hfr+C/OLG7bzUWOrcJmk0lbtc+yn
         TRsjkEXts1gZlVi6DjiFY+uK1RAlZ6URBaa25+QlXkxBA9uUWrwHl92Uwp9fOhnzxXVQ
         OHvxUagQIyBHrGxlLWEVEkDjs6fv5YQL8U/9wHobnMWkElIbnSp5xo8f+fRuxS7PBkmy
         Etj7JuSI++bsiPRv9D+vECpG+D+AM/pfVFMwd+jhV4uXHZr46mwcXKQ3zJFVTVTGcEgw
         s/1FsJmlZ530nV9s4f3dCMESwDd+nVdECA1IxKTybScgZuTIoIdhwi+V3tlS+BWXf5lC
         kWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754088088; x=1754692888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/dtd1R/YKxJbtCS8+hX8EAXfF5gtV7Hz3MRhL0yHBg=;
        b=i1iyKjlbzLYXSQsG/jJGaEoDO4wkhQe4gpRthurqaU/oX2QHd/U2OVuWg9l3sE6ROe
         1wThjgBkucro2BSqhlzQRhNq8TwelX02XbRX3HzMHRQlr+Sxb1loKpWy9idNxQ9y4tYl
         24OTEoTtw6SsOC4u8/1FbssoHBwcZGhvdemxhyVMP3zGHlikkejhWtX/lZFauYpKCJve
         A3+1+LYeRU2+uXMrLionwc8hOVQghFzTPOOPf7FuSlXNfeTnnAi+1uuHLENQC9rikkTd
         HTg57IfL75NwTGVQFU+QthHVBxNTjXqm6fS90n3EN8Op/DtwUvAfyWzuBhqHjLAvmpt9
         5TSA==
X-Forwarded-Encrypted: i=1; AJvYcCUBxN8+8NGqe9UPXlUgnB5vJTb9tglW15JtSCH+59wbK3t0Y8EZam1TxG4Ypfo3EClhPVE=@vger.kernel.org, AJvYcCWugDl+W77Xhir3nmCFA3qblpUz5OsmmHTXxmm3YuZGbXTnAP56j9JZkC3LzWxKl5CnZBnMDciGlH9nLLsP@vger.kernel.org
X-Gm-Message-State: AOJu0YwpV/wFDtzBekf0lplATeeLUTAcaN//JhTTccsX0Q0Iuq4mvk7z
	njkQ+jXHGV52aQLIZ2KU+bXFd+J0wfiy9QOWnf4yqQ6m/Wgbm7Y5s0CfJya2PVIhO7rgzdF6xCQ
	68VUcWm6d13vDVw4g/ZKbIXu3UijkbpOBJ4ON
X-Gm-Gg: ASbGncveZJuGQVMPCfhpKXtenStuNgflTwFf//zXnAm8T2zn7iA0vhagKRC6mIa3A2+
	085IhhT5KVPLBf3+i0Yo6ZJHeocpOHlV3xwHrWtPIk1BomPnzB86OoGTxsLLVbl/RNaOH/0l+5C
	Bp2knisNbestTpaT2seIV1ILUnCRds2tsb53VeMw+a49EmxcgjATSfphTig5kuJ51TA70PQaOEp
	avqTx681dABaibPQPmZA77C/shXJxBiB5Pl
X-Google-Smtp-Source: AGHT+IG332BLmMRBMnW3M5xO7U/xsKr1ShlqXTK4eWIMUy09Zwkdgdcgab5Tu2tmUonyHVzZOWkb9s6RbGJSclVr/t8=
X-Received: by 2002:a05:600c:3b0c:b0:458:9f0e:ad1f with SMTP id
 5b1f17b1804b1-458b6b47b0dmr6559605e9.27.1754088088082; Fri, 01 Aug 2025
 15:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <97100307-8297-45b2-8f0b-d3b7ef109805@kernel.dk>
In-Reply-To: <97100307-8297-45b2-8f0b-d3b7ef109805@kernel.dk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Aug 2025 15:41:17 -0700
X-Gm-Features: Ac12FXzve_ykeVckxKan46oMDOZKfRHdETbdYowk0rNxLDCq8zO2QzhxFR7_phQ
Message-ID: <CAADnVQKXUWg9uRCPD5ebRXwN4dmBCRUFFM7kN=GxymYz3zU25A@mail.gmail.com>
Subject: Re: bpf leaking memory
To: Jens Axboe <axboe@kernel.dk>, Eduard <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"open list:XDP SOCKETS (AF_XDP)" <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 9:31=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> Hi,
>
> Current -git (any within the last day or two) leaks memory at boot,
> as reported by kmemleak, see below. This is running debian unstable
> on aarc64.
>
> unreferenced object 0xffff0000c820d000 (size 64):
>   comm "systemd", pid 1, jiffies 4294667980
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 ff ff 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 84021ac):
>     kmemleak_alloc+0x3c/0x50
>     __kmalloc_node_track_caller_noprof+0x370/0x500
>     krealloc_noprof+0x238/0x300
>     kvrealloc_noprof+0x44/0x100
>     do_check_common+0x2668/0x2d50
>     bpf_check+0x2464/0x2ec0
>     bpf_prog_load+0x5c8/0xba8

Thanks for the report.
Reproed on x86 with just boot and
# echo scan > /sys/kernel/debug/kmemleak
# cat /sys/kernel/debug/kmemleak
unreferenced object 0xff1100010174d000 (size 64):
  comm "systemd", pid 1, jiffies 4294669288
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 8c5ed7af):
    __kmalloc_node_track_caller_noprof+0x338/0x490
    krealloc_noprof+0x1db/0x2a0
    kvrealloc_noprof+0x36/0xb0
    do_check_common+0x2462/0x3290
    bpf_check+0x2c29/0x3770


Eduard,
please take a look.

        for (i =3D 0; i < env->scc_cnt; ++i) {
                info =3D env->scc_info[i];

loop is wrong. Nothing updates scc_cnt.

