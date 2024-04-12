Return-Path: <bpf+bounces-26597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FF48A235C
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 03:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6079A1F22F7C
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 01:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736D06AA7;
	Fri, 12 Apr 2024 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vw9f3nVY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40CF4C6C;
	Fri, 12 Apr 2024 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712886473; cv=none; b=XeDgX1aEb9NtywBiupSHYk4B/35HEXjNJK4Zq4Pb+28YvJ06XnHZ2En0xR7cJC2yWPQhmoA+j70gbgG277uesG+cGgNuu0e68TZNp1te+L4WfNDwAvDNUIOSALzaPzUnS/OUM5nnFufduXNTaRA24ClgBeMtJJNkmNhp9sUjBhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712886473; c=relaxed/simple;
	bh=nnur/tWSme6wQzS5xqHs+Ck4oghMmY6NKkGGpke7m54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6WD+OEkjrw3b3nk7MmJDy8WJ1cpxP6cctPBjE9JuuPYh46oodeApJTuEC3t4/96sZlMgoopK2DU4PJrRlOb8zGN/RKVnH0kpC813tkauTJ2pBahLndZaUphUKPIME0JG5j12L2YE2v2zLhrEyYGRtrZbgG2ltE80qgJiS0vufs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vw9f3nVY; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d031abe8f8so17783139f.0;
        Thu, 11 Apr 2024 18:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712886471; x=1713491271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=px1s0Tuc5nvk78ICl8X6jfug8TRSoIbngCVQwWuJfj8=;
        b=Vw9f3nVYUodBC63Y3ANINB19+iDnpowjaVpsHtXH+ZeX9KVzZ3RW+l9dXMWTZqXS5H
         +qdFH2SXuzLmoimiQqTV3LaAqQ0/pNAaflOPh6bRS1h9xhneGA7unyWB/1fX7MszToYC
         mbwZv7MXDy9sz/sMMMNxLe74edWnqbs0IqUHYT3m/zY2Y1sZP0Ifz4LmqUPdwQzkl/4Z
         GVt6yGo+03b8qAFuYrN8nW2g+FzQU1uGCVu8S6ucRVUlXiqC9xsGyyeB0mrXZvalt4HA
         +0v6TYQ9d+3yaVYozd1V39Fzeu+x4mzLK8djeCmZBSrkNJxFaUJSD2Qisctdak4uJiAX
         EGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712886471; x=1713491271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=px1s0Tuc5nvk78ICl8X6jfug8TRSoIbngCVQwWuJfj8=;
        b=Gzb+/91qjtY/bHaO/iYh9AF4Z8z3voDDXI/kqrb5jtFeU8UitF6PPkjKoNld0c0xgS
         oGnuvwjJYLIZ+DG1t5sdpbmhQX9rdfOCzqPEEMIdtvCqZY9Jh9UtHYhQ1YKRRkDSTrp8
         LrAuvns0OTzB2jhfqHQV8cdNNXdx5RwPsQLsA7HgROogR+chHZ7A9oQCZFropvsVEZM1
         knxog5nO7iGWAd5cRiI6Kmr0Su+pnaD7LEiTW7fJlzD4wwJ+r/rJUSgOqk3VpyK/E7KK
         MfbhrNlVHrgHYyGUQXubHarcPbm/cpEHibJscbpA+qikQnYbpLH1yVZfoRNCI5G+vetC
         YpIA==
X-Forwarded-Encrypted: i=1; AJvYcCV993cjuCUJCGnN7uBRH1b6R4HHWBUw8rTvQKnuIC3/SNJuYO0BMoyCyPE7UsiZd8RN/zNyg2gD/3F8yuABZjtZbHdem9fhawhiHCGT
X-Gm-Message-State: AOJu0Yyi0iOMH+Q+typjulUgn1SwD4K9nFS3/XyFojPW2OyPhxsK5KMV
	ZavuK+rOLaA81ZbZ3rFJG7/LJ+PTkQWGM3v/XvcX7rm0ivx4J8vf
X-Google-Smtp-Source: AGHT+IFZmHSL6h/NTk+tbdagbZ50OBmDPc48GSTs0l0uQAPV7IzwvIZjJ+MNyu9arLEruM719yOt9w==
X-Received: by 2002:a05:6e02:194f:b0:369:b883:5208 with SMTP id x15-20020a056e02194f00b00369b8835208mr1075039ilu.7.1712886470772;
        Thu, 11 Apr 2024 18:47:50 -0700 (PDT)
Received: from localhost ([2601:285:8700:8f20::3271])
        by smtp.gmail.com with ESMTPSA id k2-20020a056e0205a200b00368653f2022sm702553ils.24.2024.04.11.18.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 18:47:50 -0700 (PDT)
Date: Thu, 11 Apr 2024 19:47:49 -0600
From: Jose Fernandez <josefernandez.dev@gmail.com>
To: Ivan Babrou <ivan@cloudflare.com>
Cc: bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: Incorrect BPF stats accounting for fentry on arm64
Message-ID: <tzipljfgxmmbeq33b6lspre7ajqm7v7457ukm4i4kfezek5coj@ad7ex72z46nx>
References: <CABWYdi0ujdzC+MF_7fJ7h1m+16izL=pzAVWnRG296qNt_ati-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABWYdi0ujdzC+MF_7fJ7h1m+16izL=pzAVWnRG296qNt_ati-w@mail.gmail.com>

On 24/04/11 11:09AM, Ivan Babrou wrote:
> Hello,
> 
> We're seeing incorrect data for bpf runtime stats on arm64. Here's an example:
> 
> $ sudo bpftool prog show id 693110
> 693110: tracing  name __tcp_retransmit_skb  tag e37be2fbe8be4726  gpl
> run_time_ns 2493581964213176 run_cnt 1133532 recursion_misses 1
>     loaded_at 2024-04-10T22:33:09+0000  uid 62727
>     xlated 312B  jited 344B  memlock 4096B  map_ids 8550445,8550441
>     btf_id 8726522
>     pids prometheus-ebpf(2224907)
> 
> According to bpftool, this program reported 66555800ns of runtime at
> one point and then it jumped to 2493581675247416ns just 53s later when
> we looked at it again. This is happening only on arm64 nodes in our
> fleet on both v6.1.82 and v6.6.25.
> 
> We have two services that are involved:
> 
> * ebpf_exporter attaches bpf programs to the kernel and exports
> prometheus metrics and opentelementry traces driven by its probes
> * bpf_stats_exporter runs bpftool every 53s to capture bpf runtime metrics
> 
> The problematic fentry is attached to __tcp_retransmit_skb, but an
> identical one is also attached to tcp_send_loss_probe, which does not
> exhibit the same issue:
> 
> SEC("fentry/__tcp_retransmit_skb")
> int BPF_PROG(__tcp_retransmit_skb, struct sock *sk)
> {
>   return handle_sk((struct pt_regs *) ctx, sk, sk_kind_tcp_retransmit_skb);
> }
> 
> SEC("fentry/tcp_send_loss_probe")
> int BPF_PROG(tcp_send_loss_probe, struct sock *sk)
> {
>   return handle_sk((struct pt_regs *) ctx, sk, sk_kind_tcp_send_loss_probe);
> }
> 
> In handle_sk we do a map lookup and an optional ringbuf push. There is
> no sleeping (I don't think it's even allowed on v6.1). It's
> interesting that it only happens for the retransmit, but not for the
> loss probe.
> 
> The issue manifests some time after we restart ebpf_exporter and
> reattach the probes. It doesn't happen immediately, as we need to
> capture metrics 53s apart to produce a visible spike in metrics.
> 
> There is no corresponding spike in execution count, only in execution time.
> 
> It doesn't happen deterministically. Some ebpf_exporter restarts show
> it, some don't.
> 
> It doesn't keep happening after ebpf_exporter restart. It happens once
> and that's it.
> 
> Maybe recursion_misses plays a role here? We see none for
> tcp_send_loss_probe. We do see some for inet_sk_error_report
> tracepoint, but it doesn't spike like __tcp_retransmit_skb does.
> 
> The biggest smoking gun is that it only happens on arm64.
> 
> I'm happy to try out patches to figure this one out.

Ivan, I recently submitted a patch that improves how the bpf runtime stats are
calculated. I'm not sure if it will fix your issue, but it would be useful to
see if removing the intrumentation time from the runtime calculation helps.

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=ce09cbdd9888

You can also use bpftop to chart bpf stats in a time series graph. Visualizing 
the stats that way may help surface more patterns about the issue.

https://github.com/Netflix/bpftop

