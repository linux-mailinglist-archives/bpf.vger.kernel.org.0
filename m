Return-Path: <bpf+bounces-66078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DDBB2DB26
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 13:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3654C5C78A3
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 11:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE032E54B6;
	Wed, 20 Aug 2025 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6HzyjQd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFE02E7179
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689659; cv=none; b=V/NGpAqUqZyJkEkF42Bu4gao2tGbWYhBz4oq8AcBq73k7t3pcw22z7zsjvZjzJNyiLGmfygNIPCupM9W8mPc0D9j2ZdVKpW11R5ud7bWZ5u6NIaw47SGfczpAnYSAEkTpLDMfpIjDqMgeBazAtL7zwckUy3D2jqV/rthr2habgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689659; c=relaxed/simple;
	bh=d2CMTsFOfospJM6Ts49dEKniaIoVRgIPj7W278GzAJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPXdhkxZDUolkndymrN7o8auBkHeEl5sKZ28VuSqWpvgOoskas9aOvZy8898exluCvJhFvJ+IyA/R8YYgagcHBrpMWmiccUtJxc4tkE17ykDDvtFd+LyiworRpEDgCTOoUhEYl3kt9VzUReTZnfU4pncJsFRk0EByZP5SsDtWOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6HzyjQd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b05ac1eso33380525e9.1
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 04:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755689656; x=1756294456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXH+qPEUNUSeKVkwKxdBzrKxeCxplvf+HtayDB2icuw=;
        b=O6HzyjQdg8A2Bwk0L40CRnfwu5dhvnnOxHYv7ZasQvdap+XHRRip2j2fHgNm0kj54v
         gNnyIoDbMWcUIYadknN3n3a8yhoG3qV+PIHJvTzYSntsTrhXigtrjoomhrj/W4jau4fc
         K2pEEEfb53fBtLJSrW48i6EPlieHUZyBcGok5uGK0O9Rbq4TCRuA4OS+JbMEUan4G93G
         IMulnbbcLRyJqousIUXNXasrx3A+VBv/Vz3oSKey4VucGCH3qgdDroky9aKIW96xefa3
         N6lV2271paEzTKlvRUOC9ABycInGpCg2YdzKngKk3ng9QkuEX3XRMUHJ1txAIHzHHSwd
         i62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755689656; x=1756294456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXH+qPEUNUSeKVkwKxdBzrKxeCxplvf+HtayDB2icuw=;
        b=uo6MBl2gnajYmMVQU9BWnMnS3RDuagAUrzu3DViftbGzX/RXjygnqLPIci0XfKLaDs
         2+KwBuk0iXqPwZ0fa47My9POboBdZeW+UsB+eEoqjLxx+vu0R6Jl/lhKMvSaPAtalQqK
         rVC0wh59mAHkSIteCT2m1PtheuULzZvZQghAZy+Gzg3BMr8oTGkyohvHOn4x0qwQrrE2
         wdJn1VTq+FSHWL0RrJkMa1PykllTg/HoU5fSbSVRmVAuuZuLN9I8E4iNQxiSbRrB7l1I
         kzIuCST6zONQH99Onh7Le4y/sWHVOwbGNl2seDarjXmR4Jy68h/eR9XS+gKtwwjanxIy
         UGnA==
X-Forwarded-Encrypted: i=1; AJvYcCU7e8Qs0+gRskePXiQ9RCOnqJc7tYUwLv4B0Ctr3g26ujhWYZr10iQnwmB3crVHqnTBotk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfZMs+wl3FxGxXaP3d3L60C0kfcnnVsCLQXiCIq7sSN6aTru+K
	g7KxDAs5ahjdI7qEqORaXxy7/tDJQN9nuUDi1g8rmQiOIgiEb9Dyn8ce
X-Gm-Gg: ASbGncuZDSTrHWMUtnOKTh64lSQarFIDL5GqGxRwVF7KYsHAOqC2f8jxUhT4XkU3joe
	C4M2abWe+rebJXYGZJG2WTnqVdPlzMwugxzSkroAsg0Upd7VhHi1N7bVjz5jrVoMXuoucTwPFUo
	R/wlrRhx60/RGoNS3dKXspkmat2MQS9eRGy+g1t5gBtIDKTVVMUFzOMaC3MT9PgPgqQA+ocspge
	jxsYdziJ8IbWnsrEcLtY169NNlyEzPLKX/ARKHGJSqJ69H2IHyc3clFL30hAxEnUkVebENnRKNq
	K3z705Y+h0j3DWHoWH/oD/CBdCFQ2ZrT3RTPn9dF/I1GWsGMPJUDn7Kn1xgwge+RYJK9TnHCzHc
	JfI99qf+UYJnygY93RjUMnJggdMoiqt1sUPII46+Mo8m25xbOzyrSq7vG3AY4FJcUAbMrF8N3LB
	0Q3TcoFU2FlnFnbZnUu4vjLZwUFMLvC70=
X-Google-Smtp-Source: AGHT+IECunXqBGlVdSyROfRgJ5fukZidvqWlPfHSoea9nFU4IDulE/wYai8mTkzdV1RYKNEodU61Fw==
X-Received: by 2002:a05:6000:2481:b0:3b7:8268:8335 with SMTP id ffacd0b85a97d-3c32fb2fe1emr1793826f8f.42.1755689655922;
        Wed, 20 Aug 2025 04:34:15 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0086dd4a301ba288fd.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:86dd:4a30:1ba2:88fd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1677sm7546278f8f.39.2025.08.20.04.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:34:15 -0700 (PDT)
Date: Wed, 20 Aug 2025 13:34:13 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: syzbot ci <syzbot+ci59254af1cb47328a@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, shung-hsi.yu@suse.com,
	yonghong.song@linux.dev, syzbot@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: bpf: Use tnums for JEQ/JNE is_branch_taken logic
Message-ID: <aKWytdZ8mRegBE0H@mail.gmail.com>
References: <ba9baf9f73d51d9bce9ef13778bd39408d67db79.1755098817.git.paul.chaignon@gmail.com>
 <689eeec8.050a0220.e29e5.000f.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <689eeec8.050a0220.e29e5.000f.GAE@google.com>

On Fri, Aug 15, 2025 at 01:24:40AM -0700, syzbot ci wrote:
> syzbot ci has tested the following series
> 
> [v1] bpf: Use tnums for JEQ/JNE is_branch_taken logic
> https://lore.kernel.org/all/ba9baf9f73d51d9bce9ef13778bd39408d67db79.1755098817.git.paul.chaignon@gmail.com
> * [PATCH bpf-next 1/2] bpf: Use tnums for JEQ/JNE is_branch_taken logic
> * [PATCH bpf-next 2/2] selftests/bpf: Tests for is_scalar_branch_taken tnum logic
> 
> and found the following issue:
> WARNING in reg_bounds_sanity_check
> 
> Full report is available here:
> https://ci.syzbot.org/series/fd950b40-1da8-44b1-bd12-4366e4a354b1
> 
> ***
> 
> WARNING in reg_bounds_sanity_check
> 
> tree:      bpf-next
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
> base:      07866544e410e4c895a729971e4164861b41fad5
> arch:      amd64
> compiler:  Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> config:    https://ci.syzbot.org/builds/c4af872a-9b42-4821-a832-941921acc063/config
> C repro:   https://ci.syzbot.org/findings/8dfae15e-cda5-4fa6-8f95-aab106ebd860/c_repro
> syz repro: https://ci.syzbot.org/findings/8dfae15e-cda5-4fa6-8f95-aab106ebd860/syz_repro
> 
> verifier bug: REG INVARIANTS VIOLATION (true_reg1): range bounds violation u64=[0xffffdfcd, 0xffffffffffffdfcc] s64=[0x80000000ffffdfcd, 0x7fffffffffffdfcc] u32=[0xffffdfcd, 0xffffdfcc] s32=[0xffffdfcd, 0xffffdfcc] var_off=(0xffffdfcc, 0xffffffff00000000)

My is_branch_taken patch fixes some invariant violations. The test from
the second patch is even adapted from a syzkaller reproduction manually
extracted from logs at [1]. Ironically, by improving the branch
detection, we can also sometimes degrade state pruning (as discussed in
the first patch) which causes the exploration of new branches.

All that to say the current syzkaller repro is not directly caused by
my patch. It simply causes a new branch to be explored, and there is a
different kind of invariant violation on that branch. The full (sk_skb)
program is below [2], but the end of verifier logs are enough to
understand what's happening:

    12: (2f) r5 *= r6                  ; R5_w=scalar(smax=0x7ffffffffffffffc,umax=0xfffffffffffffffc,smax32=0x7ffffffc,umax32=0xfffffffc,var_off=(0x0; 0xfffffffffffffffc)) R6_w=0x9fe719f2
    13: (65) if r7 s> 0x1 goto pc-7    ; R7_w=scalar(id=67,smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
    14: (07) r7 += -8243               ; R7=scalar(smin=smin32=-8243,smax=smax32=-8242,umin=0xffffffffffffdfcd,umax=0xffffffffffffdfce,umin32=0xffffdfcd,umax32=0xffffdfce,var_off=(0xffffffffffffdfcc; 0x3))
    15: (1e) if w5 == w7 goto pc+0
    verifier bug: REG INVARIANTS VIOLATION (true_reg1): range bounds violation u64=[0xffffdfcd, 0xffffffffffffdfcc] s64=[0x80000000ffffdfcd, 0x7fffffffffffdfcc] u32=[0xffffdfcd, 0xffffdfcc] s32=[0xffffdfcd, 0xffffdfcc] var_off=(0xffffdfcc, 0xffffffff00000000)

The invariant violation follows the same pattern as usual: the verifier
walks a dead branch, uses it to improve ranges, and ends up with
inconsistent ranges. In this case, the u32 min value is larger than the
u32 max value. We can notice that the condition at instruction 15 is
always false because, if w5 and w7 were equal, the intersection of their
tnums would give us a constant (0xffffdfcc) that isn't within R7's u32
range. Hence, w5 and w7 can't be equal.

I have a patch to potentially fix this, but I'm still testing it and
would prefer to send it separately as it doesn't really relate to my
current patchset.

1 - https://syzkaller.appspot.com/bug?extid=c711ce17dd78e5d4fdcf
2 - syzkaller program:

    r5 = *(u32 *)(r1 +112)
    r3 = *(u32 *)(r1 +108)
    r0 = r10
    r0 += 85328110
    if w3 != w0 goto +1
    if w5 == 0x0 goto +0
    r6 = *(u16 *)(r1 +62)
    r7 = r0
    if w5 > 0x2007ff0f goto +7
    r6 <<= 32
    w6 -= 1612244494
    r0 = r5
    r5 *= r6
    if r7 s> 0x1 goto -7
    r7 += -8243
    if w5 == w7 goto +0
    r4 = r5
    r4 += -458748
    if r3 < r4 goto +1
    exit
    if r0 == 0x0 goto +0

[...]

