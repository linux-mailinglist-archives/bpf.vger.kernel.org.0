Return-Path: <bpf+bounces-18748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB5882033C
	for <lists+bpf@lfdr.de>; Sat, 30 Dec 2023 02:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6564D1C2112A
	for <lists+bpf@lfdr.de>; Sat, 30 Dec 2023 01:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D8CA5B;
	Sat, 30 Dec 2023 01:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/jaaUDQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8545A7F0
	for <bpf@vger.kernel.org>; Sat, 30 Dec 2023 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a26f5e937b5so410391066b.0
        for <bpf@vger.kernel.org>; Fri, 29 Dec 2023 17:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703899877; x=1704504677; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OETG+HnWaILDB7yqzJO+xaCk55ds0Uux2TbYMqWwPkA=;
        b=E/jaaUDQoIFhE0352NsMyDI3Oyr02xTTk2U8s/GUJvPlIl6XX5sdqbM46EwdV6ifOm
         Q7VhLKNj8tNn6LWnr/TTws5JmNHX2v22tJuDfeBUUGjfxRWGOtRcuSiRwYpWh6M1gsPy
         q+mz6Dfv6lXzx+0XoD1YCt7oCgdqxbKUouW7zMzLuLOgQNesyAXNFaCa9vyd5Uq53whw
         9hLllT4yguCKlmh0e1Koz8luLdlwlI23T7GcaV1biI+8pkgqFLoh0tlAg4j3nDYwJyhY
         nccb/qgTXrHLSsERVDpL4xKBmmxk9DYRVBaaKgNv3CbbyJA3qqUc1djFmGZEiyjBdBDf
         XflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703899877; x=1704504677;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OETG+HnWaILDB7yqzJO+xaCk55ds0Uux2TbYMqWwPkA=;
        b=XGUUZBZ1pGoOJZSG9BcX5GkmVtgnLywRqY2YsPhdEg972b59cutBr5r0mB3dCfFFhG
         Du/jTK/oYFkPQ9QlTnqjGA5e+Nk4777slUIE2F9SzWEoSHuG0uDKgsTh2UhDVFOOexDd
         lyq3TjCYZDOz5cC6vjMgCSLRfSA2gjhh6tD0D3w9uW5IH0y09wL8eCr0T5daIFq/oqE9
         uIBMD8L40whmCaidcLz1tyJtEmsPsfEVb+/Lp/bsPt3B+r9m6KsGRbJI801aOWKZI8ry
         wtEyMyut1lz3InqeLChYrDabaAGIasrrzPkU65CzNqvGUSznOozQOVI1xNxfozY0AgLW
         /oGA==
X-Gm-Message-State: AOJu0Yy5tqNaxUTbB9/W4YHgXpS8p3FZvNDCoZSssKk6WOKFnpbY5GcH
	mc9KizNjIC+WrZQUEu2fiXQO7HNCnAKiRBpJpkOpKW+wI7LOKQ==
X-Google-Smtp-Source: AGHT+IHPMiUiFp/JPkg/oiu8ZU4lmbYoKY/wOZ3/WZGtgnqQF5Ks2AfHJvQB709GnqC5ncCg3qQFxEDARZPt5yU2yjQ=
X-Received: by 2002:a17:906:48c7:b0:a26:90a0:696e with SMTP id
 d7-20020a17090648c700b00a2690a0696emr6188151ejt.41.1703899877159; Fri, 29 Dec
 2023 17:31:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Fri, 29 Dec 2023 17:31:06 -0800
Message-ID: <CAHo-Oow5V2u4ZYvzuR8NmJmFDPNYp0pQDJX66rZqUjFHvhx82A@mail.gmail.com>
Subject: Funky verifier packet range error (> check works, != does not).
To: BPF Mailing List <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"

I have a relatively complex program that fails to load on 6.5.6 with a

if (data + 98 != data_end) return TC_ACT_SHOT;

check, that loads fine if I change the above != to (a you would think
weaker) > check.

It's not important, hit this while debugging, and I don't know if the
cause is the verifier treating != differently than > or the compiler
optimizing != somehow... but my gut feeling is on the former: some
verifier logic special cases > without doing something similar for the
stronger != comparison.

...
453: (85) call bpf_trace_printk#6     ; R0_w=scalar()
; if (data + 98 != data_end) return TC_ACT_SHOT;
454: (bf) r1 = r6                     ; R1_w=pkt(off=0,r=42,imm=0)
R6=pkt(off=0,r=42,imm=0)
455: (07) r1 += 98                    ; R1_w=pkt(off=98,r=42,imm=0)
; if (data + 98 != data_end) return TC_ACT_SHOT;
456: (5d) if r1 != r9 goto pc-23      ; R1_w=pkt(off=98,r=42,imm=0)
R9=pkt_end(off=0,imm=0)
*** IMHO here r=42 should be bumped to 98 ***
457: (bf) r3 = r6                     ; R3_w=pkt(off=0,r=42,imm=0)
R6=pkt(off=0,r=42,imm=0)
458: (07) r3 += 34                    ; R3_w=pkt(off=34,r=42,imm=0)
; uint64_t cs = bpf_csum_diff(NULL, 0, data + 14 + 20, 98 - 14 - 20, 0xFFFF);
459: (b7) r1 = 0                      ; R1_w=0
460: (b7) r2 = 0                      ; R2_w=0
461: (b7) r4 = 64                     ; R4_w=64
462: (b7) r5 = 65535                  ; R5_w=65535
463: (85) call bpf_csum_diff#28
invalid access to packet, off=34 size=64, R3(id=0,off=34,r=42)
R3 offset is outside of the packet

Side note: bpf_csum_diff() is super non user-friendly, but that's for
another thread...

Happy New Year,
Maciej

