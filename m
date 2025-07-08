Return-Path: <bpf+bounces-62578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DD0AFBF43
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9C54A6643
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 00:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66099185920;
	Tue,  8 Jul 2025 00:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMMEuwaF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844A72AE6F;
	Tue,  8 Jul 2025 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935035; cv=none; b=es7YXeSnqvMJQg6tIxURL7WMJfcEwMb8wUM4AsZ3JPBH/OqtrgJWYaqSNoVSEARpMqTgtl0GuFfvDWCuBPSXo+AvyH3Me6feL4oSvB6/YkllcMSBY7AfVB2PG6ofPvmYY4idGPjHzPmTRJBdGtEfmbbn9KFzz8r/0Ve3o6LD2vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935035; c=relaxed/simple;
	bh=ljsl2Z5VY5LDR3C5S9CzYzXKO+MT1Tzi6VlGcajsgxU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gcRKxm3h4kqSZSFNn8pwsdR5e4pnmQGVBN1i9mA9HNG9LznXAQkX3+xGrksea91MnWxEWOlTjbzB40R4zRXbuftz2D3LBR4Q2U4UFoL80iHwjNoYyNb3io9NcqDn5icCO63K3qpGHjm7ze3OMOL+rkgUETblH42Qo/CIl3wlnOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMMEuwaF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74af4af04fdso3691715b3a.1;
        Mon, 07 Jul 2025 17:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751935033; x=1752539833; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OorcVwknaSDvxF+3M7/rvx8hjWtBqy73MQxzqWLBaAI=;
        b=LMMEuwaFgYMSSzkQPOUWH9NNt5ND6euv8IQ1sHTAJ173GDyKwXF/O0bhWEAcluUCfj
         vtQC2HeK78f53FNJpROG3Xnle7LhsjX7t0QjNNIO3+UW1CjaKS9yYOFWL/tmIjFqw2IS
         DVigJlAmOJ+KTAaqMUPHIQF9P2eLGn8cvRaN4tJV6//T35srU7Y4RkUBL5aIb5eJOYGC
         iFhB0QJ6PeF/RfoVXZke9XdzQ+HbGRLCE4l9+eBydyLSpjWjUqo6DCzE8Smzl+6ystET
         CTt7U36hOlM6kixctNmYqjaNssLU3drFlIevIgXwib5kVyf9sWTShPnbczVGQOaxfaAv
         h2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751935033; x=1752539833;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OorcVwknaSDvxF+3M7/rvx8hjWtBqy73MQxzqWLBaAI=;
        b=Y3yeKwZBWQgbOZdNbfTC4oemoW4utOX5FbJ4bl2/LP7WFP/pkGxF64VUBI27QYC4Fv
         ovaztVhCuXfDfs4TJ3PsmrF5FA9ssSTPoMI0Q8CE8ng0lxGk2pE6jdeZY2IaadUhf2u6
         hguVGvcLZP+PXPb4Vp6Q3TQzs12cOiqLEazQwrfKNtEibaxVlTHDR3P3lzNYNnG1WQXZ
         T1Wtfd8HFmz/7ude/jSNXXZQvQTLfruwbphgzyjC6crn1aE+VgqTw3a9SV/qy5Js3hqp
         U6UCMm4UJpQ/SLGiSu3GDkIR+WeSixh0ngrvs+mHpCpI02RmcZX6moA8wSFkg6IQFX59
         Tn+w==
X-Forwarded-Encrypted: i=1; AJvYcCVisBiDxO4Xp/8uOtg/nTbmuZP+BPvV4GvWZcD3w++qzK1LDbB4uqmfpK6UZKRnNV1VeN5VKzvO@vger.kernel.org, AJvYcCW9L6nJaCVt5PQHs9mTf0O+jRmtKCOZ7IceR5TxLCI6LS5E8U315QbB1Wc+v38QOjv6FWU=@vger.kernel.org, AJvYcCX7gxalSyrqCdOvXJFCv84QRFR+uSq6oPuyN4u5vsQ1wKXcpULLUR/wPtf5s51y4DicF1m9t8FjN7y/iKGn@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8BqtCYKmhlf6XJHA37boDeu/0E6M8BPegbLOtKvVq1UZT3hON
	DJGPShEkUWHl1nhD/HryJtmJhKCBI9CdeQM+FSO0BwjEgo/oRbDhcIMb
X-Gm-Gg: ASbGnct8Lf47GCpjafg42ahFDZ0mzje8gQA1T4uSQk+M6n5Q8E6PvZ/lep6SYjGu6pj
	WqydWAZUi2U1gnvVN5fTpLnwYHB/b4+LNkie45LLpZNAz45Kwl0b9L/M0BkDs7Q9YjV5xVVHuxQ
	TC8vBLoZ4IuoorCujGkGc+6R62WNe5GN1c1dyLkLlRHL5idPKDKT3euUDUxZOkcowgU427smkIh
	sTHdDNzcsXt+BTKwma4YHDUSFn7flhEthwk+r5FcAKoO3f4V/mfnzOlMGsb1xADpawiWMZWme/c
	sD/rX1AIbkgd648UUh92H6hWL57Q2tQd57QZHQD8uLfrsjNCXVhJQIehe0S7ASjTIq4=
X-Google-Smtp-Source: AGHT+IF1Br8HS7wsPZoPtrPYtrum3FOq3cVJgd2tLBiZmhUC6H7UzoTtf7UA/ohLv8w0iSVGMsIuAA==
X-Received: by 2002:a05:6a00:1403:b0:748:a0b9:f873 with SMTP id d2e1a72fcca58-74d267dc857mr785208b3a.9.1751935032705;
        Mon, 07 Jul 2025 17:37:12 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:6ad])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a1ca0sm10490375b3a.138.2025.07.07.17.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 17:37:12 -0700 (PDT)
Message-ID: <c35d5392b961a4d5b54bdb4b92c4e104bd7857cc.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: syzbot <syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com>, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, 	sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, 	yonghong.song@linux.dev
Date: Mon, 07 Jul 2025 17:37:09 -0700
In-Reply-To: <2fb0a354ec117d36a24fe37a3184c1d40849ef1a.camel@gmail.com>
References: <68649190.a70a0220.3b7e22.20e8.GAE@google.com>
		 <aGa3iOI1IgGuPDYV@Tunnel>
		 <865f2345eaa61afbd26d9de0917e3b1d887c647d.camel@gmail.com>
		 <aGgL_g3wA2w3yRrG@mail.gmail.com>
		 <df2cdc5f4fa16a4e3e08e6a997af3722f3673d38.camel@gmail.com>
		 <e43c25b451395edff0886201ad3358acd9670eda.camel@gmail.com>
		 <aGxKcF2Ceany8q7W@mail.gmail.com>
	 <2fb0a354ec117d36a24fe37a3184c1d40849ef1a.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-07 at 16:29 -0700, Eduard Zingerman wrote:
> On Tue, 2025-07-08 at 00:30 +0200, Paul Chaignon wrote:
>
> [...]
>
> > This is really nice! I think we can extend it to detect some
> > always-true branches as well, and thus handle the initial case reported
> > by syzbot.
> >
> > - if a_min =3D=3D 0: we don't deduce anything
> > - bits that may be set in 'a' are: possible_a =3D or_range(a_min, a_max=
)
> > - bits that are always set in 'b' are: always_b =3D b_value & ~b_mask
> > - if possible_a & always_b =3D=3D possible_a: only true branch is possi=
ble
> > - otherwise, we can't deduce anything
> >
> > For BPF_X case, we probably want to also check the reverse with
> > possible_b & always_a.
>
> So, this would extend existing predictions:
> - [old] always_a & always_b -> infer always true
> - [old] !(possible_a & possible_b) -> infer always false
> - [new] if possible_a & always_b =3D=3D possible_a -> infer true
>         (but make sure 0 is not in possible_a)
>
> And it so happens, that it covers example at hand.
> Note that or_range(1, (u64)-1) =3D=3D (u64)-1, so maybe tnum would be
> sufficient, w/o the need for or_range().
>
> The part of the verifier that narrows the range after prediction:
>
>   regs_refine_cond_op:
>
>          case BPF_JSET | BPF_X: /* reverse of BPF_JSET, see rev_opcode() =
*/
>                  if (!is_reg_const(reg: reg2, subreg32: is_jmp32))
>                          swap(reg1, reg2);
>                  if (!is_reg_const(reg: reg2, subreg32: is_jmp32))
>                          break;
>                  val =3D reg_const_value(reg: reg2, subreg32: is_jmp32);
> 		 ...
>                          reg1->var_off =3D tnum_and(a: reg1->var_off, b: =
tnum_const(value: ~val));
> 		 ...
>                  break;
>
> And after suggested change this part would be executed only if tnum
> bounds can be changed by jset. So, this eliminates at-least a
> sub-class of a problem.

But I think the program below would still be problematic:

SEC("socket")
__success
__retval(0)
__naked void jset_bug1(void)
{
        asm volatile ("                                 \
        call %[bpf_get_prandom_u32];                    \
        if r0 < 2 goto 1f;                              \
        r0 |=3D 1;                                        \
        if r0 & -2 goto 1f;                             \
1:      r0 =3D 0;                                         \
        exit;                                           \
"       :
        : __imm(bpf_get_prandom_u32)
        : __clobber_all);
}

The possible_r0 would be changed by `if r0 & -2`, so new rule will not hit.
And the problem remains unsolved. I think we need to reset min/max
bounds in regs_refine_cond_op for JSET:
- in some cases range is more precise than tnum
- in these cases range cannot be compressed to a tnum
- predictions in jset are done for a tnum
- to avoid issues when narrowing tnum after prediction, forget the
  range.

