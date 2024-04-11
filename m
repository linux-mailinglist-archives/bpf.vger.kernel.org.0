Return-Path: <bpf+bounces-26569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988498A1E7C
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 20:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52499290007
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 18:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F297651C5C;
	Thu, 11 Apr 2024 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GP088t5u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54F251C44
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858980; cv=none; b=srO+N3lKVreecvdcLcxizkLsPYt2+2lT41IzNcO/50B2HWtcPkfCzCObzyiLI5yzRIWSjTi4C5GGd0t0BlSMxUrBE7mPewV4dTxXWSrDX+qSkuBCcrWpZi4+f4XivwphBU4ELh3CxJ1K3vWpNDJsN81J8hGCdgU+e34sZIuNbN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858980; c=relaxed/simple;
	bh=7sQCResQHcHFaajY/affxbUQdzkJ+QOQsXOVt7r+6/o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MjZAMOLMYmbJDNQym1wZ3AzLkHqn9ZsXNlcdn4FfHFHc1XfDYBqb/x/E7zVYcmup6kBrS67eXJE3bKt1hHnKc/kBhKN6RwUqZNoyFRFlNub2RiLpWj3Rt4jUTnBmZu/lXSXBSSVvXFPPWOD3cnyhJLzBuRdwr/WUw5rfAtdv2h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GP088t5u; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61587aa956eso363237b3.1
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 11:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1712858978; x=1713463778; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xbtisnhUzZ5+5osOX2htiyEfxmKmwf+lNIM3kB5/lv8=;
        b=GP088t5uqDEAw37lXuL6pzgmZg8DkXCZq+lMEya04SkKxaBIJrrwYkTBG5aZLUYUhd
         X2C7mXN8iM14w4H9EsdAcqqGTYsBIwH6Mb3wzrM8hE7c4pZNvcqz6VLR67qRdxETy65q
         sYJiS5rKYYoD+i3QWuRtqFUaBOyJ08u87Kedf8QbKQX2Ef9uQeot7T9rQiFI7PE2MA2o
         VUXIOYVT0kZsK/hBoNWjfnWWmmugr54x55wv/5d+kqr+Rn6lAObvdzGjOt5skH8NdoPn
         7hBHgCDaC6uTfKHLGOu/jOPS7dGzEB+O+Rxei3xfMbbLntUPMYNYG/PXp2bIpz3TaiXa
         QUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858978; x=1713463778;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xbtisnhUzZ5+5osOX2htiyEfxmKmwf+lNIM3kB5/lv8=;
        b=VD/n8WQTa3wqbbnAbBXX2HA77SOiRfDGnLnQaQLcoRgHotM6dEyuSrgPqqA6XiU/Cx
         yQ6DsNqXF4N3C0tPnjly+groJS/L99JtNKi8UKh2z+OWkcRz5kDjl2l68L6lYh7KhuUb
         66sx1mEgfA63CPSl0lxtvNs5Z84RO4n1SKzk5lVHk43EJB9FdT1Guz9roihYgN9ezhEL
         fRufmnPaohozrCEibsU7wFAdPq19RodQt6Wde2wWXuSYsC6e7oOKdxlDhECDja04ozlA
         2aHQgjzpjPj/fTWtL+vR/UnZ4XiWSZLUF6/QAq0J4CeIVefND4R33cKSPjDnhpn0MMuX
         Z4Mw==
X-Gm-Message-State: AOJu0Yx2qqZGESvVTiZ6qNawirkPDsQraNmFY60X4UN5T+Yk00MAIpIB
	LsRt+r2mtYfybhvxxjHqlFdqxSm4eDQDRHzoSF26VhjLP/eSYfqf85pwkGNjAehqpNEkwFTlFni
	1V+0YcCnW3MibEUxI/kon1z3wkQhugl05u6gahBJuqvqyTCybADI=
X-Google-Smtp-Source: AGHT+IFjut8ojZSB7SsskjRLnevw7J7Ig31tm4K7lbYdaL9osUI14ma4WRSeewKQg94P/MTh+oQCy1TSxXzOI4oUCa4=
X-Received: by 2002:a0d:d695:0:b0:611:18fc:9489 with SMTP id
 y143-20020a0dd695000000b0061118fc9489mr218230ywd.28.1712858977725; Thu, 11
 Apr 2024 11:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ivan Babrou <ivan@cloudflare.com>
Date: Thu, 11 Apr 2024 11:09:26 -0700
Message-ID: <CABWYdi0ujdzC+MF_7fJ7h1m+16izL=pzAVWnRG296qNt_ati-w@mail.gmail.com>
Subject: Incorrect BPF stats accounting for fentry on arm64
To: bpf <bpf@vger.kernel.org>
Cc: kernel-team <kernel-team@cloudflare.com>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

We're seeing incorrect data for bpf runtime stats on arm64. Here's an example:

$ sudo bpftool prog show id 693110
693110: tracing  name __tcp_retransmit_skb  tag e37be2fbe8be4726  gpl
run_time_ns 2493581964213176 run_cnt 1133532 recursion_misses 1
    loaded_at 2024-04-10T22:33:09+0000  uid 62727
    xlated 312B  jited 344B  memlock 4096B  map_ids 8550445,8550441
    btf_id 8726522
    pids prometheus-ebpf(2224907)

According to bpftool, this program reported 66555800ns of runtime at
one point and then it jumped to 2493581675247416ns just 53s later when
we looked at it again. This is happening only on arm64 nodes in our
fleet on both v6.1.82 and v6.6.25.

We have two services that are involved:

* ebpf_exporter attaches bpf programs to the kernel and exports
prometheus metrics and opentelementry traces driven by its probes
* bpf_stats_exporter runs bpftool every 53s to capture bpf runtime metrics

The problematic fentry is attached to __tcp_retransmit_skb, but an
identical one is also attached to tcp_send_loss_probe, which does not
exhibit the same issue:

SEC("fentry/__tcp_retransmit_skb")
int BPF_PROG(__tcp_retransmit_skb, struct sock *sk)
{
  return handle_sk((struct pt_regs *) ctx, sk, sk_kind_tcp_retransmit_skb);
}

SEC("fentry/tcp_send_loss_probe")
int BPF_PROG(tcp_send_loss_probe, struct sock *sk)
{
  return handle_sk((struct pt_regs *) ctx, sk, sk_kind_tcp_send_loss_probe);
}

In handle_sk we do a map lookup and an optional ringbuf push. There is
no sleeping (I don't think it's even allowed on v6.1). It's
interesting that it only happens for the retransmit, but not for the
loss probe.

The issue manifests some time after we restart ebpf_exporter and
reattach the probes. It doesn't happen immediately, as we need to
capture metrics 53s apart to produce a visible spike in metrics.

There is no corresponding spike in execution count, only in execution time.

It doesn't happen deterministically. Some ebpf_exporter restarts show
it, some don't.

It doesn't keep happening after ebpf_exporter restart. It happens once
and that's it.

Maybe recursion_misses plays a role here? We see none for
tcp_send_loss_probe. We do see some for inet_sk_error_report
tracepoint, but it doesn't spike like __tcp_retransmit_skb does.

The biggest smoking gun is that it only happens on arm64.

I'm happy to try out patches to figure this one out.

