Return-Path: <bpf+bounces-50306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5701FA24FDC
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 20:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16863A42E6
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 19:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8077C1FE473;
	Sun,  2 Feb 2025 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TC9G/XJR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED21101E6
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738525608; cv=none; b=FcZpFFXot6VQ+9DZahfTAFzUXbn73ppeCqhj3Rs/7T3MtLGKFwhzNNmescajhs5z3LkzPNxDAt1dS+iIYb+eK0FxgDvnHEhbTqtpMiqV6gcJJIUpSCLvQ14hbm5AhNMviGZMzh41RpPappNS46iTYr+KwNABpCXW/fP6yTbviNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738525608; c=relaxed/simple;
	bh=81wkzfIj1c3W5STLN0ewYTEeHx2cEdP2zRQBDyahvbc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IEJQmFaUOaYuGzs/uF0g1TfSoXMbaEoARC+yQ+qYoDmB2L2hI2jIo6I94JgVXw4Yhmw1OFNpYkEA2aeq5tbFhpl4UkS5vd70Zj3+/dseSITaLjJL04rl2zyI9pVY1TR3U3VhWkKnszm81h7xwpPwE8gM0QjUvSTzq6eWquwgzv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TC9G/XJR; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46785fbb949so44420311cf.3
        for <bpf@vger.kernel.org>; Sun, 02 Feb 2025 11:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738525605; x=1739130405; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eYJzPNWnPw7kx8gVC3Px5i7yjDi8l+1nuGi69pqFAUI=;
        b=TC9G/XJRRBZzbHtTkKgZdOWlcOAmX88EjIiJR+hbUBZktq5XW5wqpgX2j3v+McGolU
         WqbktCCobq2hNTrJQ5JidCg9gA1rLiU0WMrgSvlU9H3yvjqKMaM9+M8MLIo6ofj/A7kh
         IuITHH8uyuAd30HZpZc7jJpTriGxPuKcDZY3lSdaANvHTioFvRfKY2b1ST4EBlaBlO3j
         OyERa2D2FL87baKx78n4jtz4FYFn+VG4vpGcf4leGYUUuJV1fELVEWL56L0fxjy3Oo6U
         nzHZXqlzLr1mTpnrQz2pXSNkV6sYKlKQhlXTphDV4guKChbS/AHd4R0+iqRR+pgapFpr
         XvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738525605; x=1739130405;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eYJzPNWnPw7kx8gVC3Px5i7yjDi8l+1nuGi69pqFAUI=;
        b=GGYIO+IJVcliUftahvq2Ka3zWNGeLOa9cEwrXt5p4CRccy1wosPyusEI/O9E0svtea
         22M52RqvCEDNcuBf19o4IC7ImIJNs4J01CEEtGnChm2ZbpgtldmVegHUUC1X2Pa3VJvF
         z1l51Um6pDFF5kcOS5JPTc/qD8NH24cAR6GWMR3TrOSkW9ch1UClXcfsi4w2HdFK4alk
         Yd2awgSuU9dc4UGV1E66Ho//ZRjC5GKhbbSAKwy5Savih9uz2dwHFjWLotdqSE073YLx
         3uAUn9hhC4btpgrkaX15HyVH1I1AT4TNphT5yK/dX3lAwJBP1KrSKaW8weeChANr382s
         a4LA==
X-Gm-Message-State: AOJu0Yyw/0eP7/lZfpEv0OXyeXdOJV8b3uBnep1UpveGxG/GJ7wChuLs
	DaCgSwaeWMheG16hIzxMeBSYBqXC4y04+r+PIqvAR4ypqNxKnsk+O308uo9iITM6ut4kx1IQZ5W
	pi5w5FkBZ5tOZjaDrXV5GwYL9EmBRjbgm
X-Gm-Gg: ASbGncv2OlciCYCHILE0ZrUYdbjwskX6TgZU3HbNCM04VsAwMstiNCwAsntuqpwoYyX
	OCgfcBJuU0g8q/DBQfyPzU67OiKGthE7rm1lXfuq+SVS4Ol2CdZJGlAkfa3ayiqk8rfN5WStf
X-Google-Smtp-Source: AGHT+IHLxE9wK/BN6eVUKH8RU/utBAZ+J1fXORkjzffc1NL4IYcQcxUi9LmjlGJDGtva5P+miCGjt3ArzwOmkcicVGQ=
X-Received: by 2002:ac8:5f4b:0:b0:467:5712:a69a with SMTP id
 d75a77b69052e-46fd0adcab8mr288164931cf.29.1738525605229; Sun, 02 Feb 2025
 11:46:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Sun, 2 Feb 2025 11:46:34 -0800
X-Gm-Features: AWEUYZlphhc8uGtEDr5CCevh7TS7QVgyHVnCIb90XRUbEbEgTFgnGMQBEjQkQRs
Message-ID: <CAK3+h2xsd4H-mYmhb4-gwBV9ogXZDK6XaLU=jRfHT9X80=5Oow@mail.gmail.com>
Subject: [QUESTION] map has to have BTF in order to use bpf_spin_lock
To: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi

I am attempting to load loxilb ebpf load balancer project  ebpf
program and ran into bpf verifier error like below, the kernel is
upstream stable release 6.12.5 and has CONFIG_DEBUG_INFO_BTF=y kernel
config. I tried both clang 18.1.0 and clang 19.1.7. I reported the
issue to loxilb here [0] with BTF LOAD LOG and PROG LOAD LOG output
detail. Google search and AI  hasn't been helpful so far :)

8113: (bf) r1 = r8                    ; frame1:
R1_w=map_value(map=polx_map,ks=4,vs=96)
R8_w=map_value(map=polx_map,ks=4,vs=96)
8114: (07) r1 += 16                   ; frame1:
R1_w=map_value(map=polx_map,ks=4,vs=96,off=16)
8115: (7b) *(u64 *)(r10 -16) = r1     ; frame1:
R1_w=map_value(map=polx_map,ks=4,vs=96,off=16) R10=fp0
fp-16_w=map_value(map=polx_map,ks=4,vs=96,off=16)
8116: (85) call bpf_spin_lock#93
map 'polx_map' has to have BTF in order to use bpf_spin_lock
processed 757 insns (limit 1000000) max_states_per_insn 0 total_states
24 peak_states 24 mark_read 11
-- END PROG LOAD LOG --
libbpf: failed to load program 'tc_packet_func'
libbpf: failed to load object '/opt/loxilb/llb_ebpf_main.o'
13:12:12 ERROR common_libbpf.c:183: tc: obj load failed
13:12:12 DEBUG loxilb_libdp.c:3147: llb_link_prop_add: IF-red0 added
idx 1 type 2
2025-02-01 13:12:12 ebpf load - 1 error

[0] https://github.com/loxilb-io/loxilb/issues/953

