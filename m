Return-Path: <bpf+bounces-18827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41105822578
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 00:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559AC1C21B03
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 23:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD8D17740;
	Tue,  2 Jan 2024 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnCLPSm9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DAA1773D
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so2542723a12.1
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 15:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704237916; x=1704842716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WM2W/DgUcPqerFU2Fzf/g3QFmamtZ9DdC0mirDJc7rg=;
        b=GnCLPSm9TGbakzl7DeTCVrUbQLbkA/v3ef5+Eq9gaDy0BzPOAp5MyoaIXZQkkakaoj
         QXvtXPwDs44CA0EXcbafB/GnJ115FbZEAMbv8h2YnBFD92oZ3bAWtstDSoSjv47kG3on
         3e7lWjBf+WJ9M7oIBWZtY0r5fydO1DjeDmKTVWjRLKLHuvq4i1SqiisBg6FGiSt80Dzb
         CGPZ14BaPFnXGeMQBRQkOUK4RPqVstJQX78x78280vAQazl1GRSnwq9Rv8nDrpZAIAqo
         xWJMAE3KGE0Ubf2t7M2T5jlz5dqqjy9wDDeaZRBMg7eiLaC6PgtTqyE4A1PpKQhUtYGL
         R7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704237916; x=1704842716;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WM2W/DgUcPqerFU2Fzf/g3QFmamtZ9DdC0mirDJc7rg=;
        b=ZmjQDR/9wwemfPuUW3oQqr001dVQ2IWBreuHTMmS3X2YiL14D1JdK/ecpAe/vs8C0A
         QEI/NbR5lEfQ+0vaj3f1cW0IrMRD59q713knsInhMGezVkL4PA9VjeN/MeCcfilvo/jd
         0C4o3U7OP4y5V5TvSiypYW72F+hPe8V2c3dSYfBoJAL9mn/HLgy2wUxk3uhSfISzIdKW
         GTLOT0QnnrHoQVT6RAnETEuDtB2fEc+lX4QKNiZOlkgSBHlRZvcbpruM3up+YLySLYEA
         sD7H2sqv1WYtYdu5nNt+E+PDiHqPS72L6OysctkD79QlSbK1sNohvGmgasE25suDmzkZ
         j/+g==
X-Gm-Message-State: AOJu0Yy20jOtzMtx6w7SHYIhQ8sRc7xQC4twIggqsGzdu5RCkAugCNPi
	WebVyPLa5c/YjpEsx81cyKob9bgrRwo=
X-Google-Smtp-Source: AGHT+IF4C3f0233Fg/70G1svgtSo2q9XBaaIDynKygdpOy+ksPSHFIUjPjeK2n1nlfLCzpm4Z+/a/g==
X-Received: by 2002:a17:902:ecc2:b0:1d4:4eb6:877 with SMTP id a2-20020a170902ecc200b001d44eb60877mr8718117plh.116.1704237916526;
        Tue, 02 Jan 2024 15:25:16 -0800 (PST)
Received: from localhost ([98.97.37.198])
        by smtp.gmail.com with ESMTPSA id jd19-20020a170903261300b001d4ca3087dfsm1634242plb.234.2024.01.02.15.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 15:25:15 -0800 (PST)
Date: Tue, 02 Jan 2024 15:25:12 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: P K <pkopensrc@gmail.com>, 
 bpf@vger.kernel.org
Message-ID: <65949b58d9a1a_11e86208cc@john.notmuch>
In-Reply-To: <CAL0j0DFrjP=y2TMCmsFr7yYL+dxZ7oJTc49_1WUj-YvK-78kMw@mail.gmail.com>
References: <CAL0j0DFrjP=y2TMCmsFr7yYL+dxZ7oJTc49_1WUj-YvK-78kMw@mail.gmail.com>
Subject: RE: Need help in tracing nf_nat kprobe
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

P K wrote:
> Hi,
> 
> I want to track the Source IP for outgoing packets which are
> masqueraded via iptables in Linux kernel while routing the packet to
> destination.
> 
> I was using kprobe for nf_nat_ipv4_manip_pkt for the same but which is
> not working anymore in the latest kernel 6.1.66-1 onwards.
> 
> What would be the best way to do the same in bpf or kprobe?
> 

Why is it not working anymore. Presumably because the function
was removed or maybe got inlined in newer kernels. Either way
looking for a similar function on 6.1.+ would be one answer.

Perhaps a more stable approach would be ot use the sock ops
hooks. I would just grep for sockops in ./tools/testing/sefltests/bpf/
to see examples on how to do this.

Thanks,
John

