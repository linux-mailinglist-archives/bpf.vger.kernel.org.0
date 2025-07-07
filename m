Return-Path: <bpf+bounces-62571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE7DAFBE9A
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 01:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1855C3BBECF
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 23:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6C028853D;
	Mon,  7 Jul 2025 23:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6oYTr5b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276E31A76D0;
	Mon,  7 Jul 2025 23:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751930975; cv=none; b=Va6G1utD0Xf0Um9DZjGK1HxpgADsiXPtytIsJ5vruX5TUjVn0vmgW06MTX3oHy3PIrqGGYfzlAmYGMSx8JIK9Gx+Iooxo5WYbep6n0IwEtvHzdONN4ODCo1BBxKkjmoI6zkK3E+9FgT1hb4h+SctNLO5sjEXBY/gnfbGIqUY5fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751930975; c=relaxed/simple;
	bh=tDfslSGThUSSeDw6MEDGAodzhrzY37bUiuz93OXBkP4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hWfIuaBOirky8LfvOg52jK3LcUdOhw3WivLUu7kvJXDvxV4dnkwY3qZ87rpmbTWSb+z8tzrNSz6T5DcsjVn6hjJRigLjNB0QK+uX3vAQ6OWTWXkk8FDRlw/3DaWPZ5ql7k8wFQUzW3ETX2fYZoFVdyuqg1jjR/oiQlQBKmDJ5Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6oYTr5b; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b34a8f69862so3005946a12.2;
        Mon, 07 Jul 2025 16:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751930973; x=1752535773; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E2q/+ZmwOZVJfPSae1Ojo1PnKlFTAiIjYB1Ogh0Ew14=;
        b=f6oYTr5bdFeHm2JKwrHCYK0p1b/J0NHdVsfZOVbOPNLVwmMD7PmvhZ4cUaAdiM6spv
         e0s0ogS1/lGYtUvyeQNl0ZCtIRfgM0ha5tfnYcJI8DtbMPksY1tI/yYOd25p/84QfOl7
         ATx7indAF77cTeahDrAc47kZgNnozs1yw4JRFkHbHnXDkCiqoe4JgGBufecs5DTU/w2t
         TFdA5mtz9CMHUZ8UBQ6LiPIQ3w0XPgM39+f2PV6CGGxqd7U/GMwnVV5tyH8ODamcS09Q
         vNT00mKh8Ah1HMDY5IOhTB+285bRA+m2mQAeHNWtbCq8ReevbWyYDmevh8WdidXOYH0K
         xchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751930973; x=1752535773;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E2q/+ZmwOZVJfPSae1Ojo1PnKlFTAiIjYB1Ogh0Ew14=;
        b=D92qyw9f6PBhZKNcMVDAqAqFt5L79QoNHJKgkPhWiNzCqA5lqSy8KjqyykM2n02paj
         zzGWQ8g94IkW8VOHdIgHhNnCoc/GbV5rwkqj/zQfM2CgIZ7MIx6klRRORZEVksrL2FiD
         dk6PvfJmU8T2vo8FIelQ+k5al/At4nKPVvnOgbP3/U1QV1cfbuxdoMpk+jaP74E2WZa1
         jO5BuFErmjsKTfWnrT+BAIfjrRy8MKZqn5U37XUTzcm7gpqUSp/N/YBdMc1FwEHRbIsG
         /K1AEMGtnXowRkkXwSfTetLEr0DEQ8BduQqGLjyexmdsXBHsda9uth29MzKPb7Cwonk2
         bFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/5eJxtH6mtA+LGrL+WmdqOmeQ99ykDJb8sOUP3ajURwdy64b0ybYWa6YYIA3OzI8HFJf4YkzR@vger.kernel.org, AJvYcCWwH80N9VBPAwwgqC7mWwI50MYColfNrcRZ8HMKMPXvTLuowx6QDs1yDwv17J9T63s4+ys=@vger.kernel.org, AJvYcCXkRQGIm/czxCVC2y9/Oo0aB9ZW/7pnuRQk3lBLwUnwI9IPUu4xd7rl0KQ8+rzpt8r5YVUdNIA32ExUMO/5@vger.kernel.org
X-Gm-Message-State: AOJu0YyFScCagIwGFkxvamUTHFMCVS/c3EaBj/Mkv6Y4KYp68LtUReRM
	vQhK/a460jVhOoTHoqihpZIFtz1sJajQlnv3kFq4hPAlLyi8sBu+b7Fd
X-Gm-Gg: ASbGncvFtbwTxK2xQvvIXl0T4XnLTGvNPTEMWf6IQPYAA0ubFi+dWyNUtEcPwpML/Z1
	khMco/khoSglInYUa94373PvV8J1yzTKG9vJOL2tXyeN1zpow33M2BVpuyHMd7RTtU7oyaSHWIQ
	oYro1yZCZyvuWbJf8h00LBElZ4xEcOfjcDisxPzsOdRA8/B5O+urwOQ7SNaXxZ3t8rQbEL1QLlr
	1eUh8bu+5abXc1qQhQZYPPj0qK/WuhYfmHvJwZTQoK2wU0X2eiwgNi6V45r/f0eEPCsXBeXlTt9
	+YiH+2cI/4zEONQ3KXWM7i2k96QjgZ/BEh9hwB8oIOxY+twG0abArL6C+kf81sePxvOEjKOn3p/
	upA==
X-Google-Smtp-Source: AGHT+IErKy9RXCWcp7pW7oyb6XeYmVhmOvLiTSI7Vg7m1R7gHY/FjLmoN5ZMF2R+4YVgEEH8vs/AKQ==
X-Received: by 2002:a05:6a20:43a1:b0:218:17c4:248c with SMTP id adf61e73a8af0-2260b2953dfmr21552737637.22.1751930973280;
        Mon, 07 Jul 2025 16:29:33 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:6ad])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee450a61sm9882340a12.8.2025.07.07.16.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 16:29:32 -0700 (PDT)
Message-ID: <2fb0a354ec117d36a24fe37a3184c1d40849ef1a.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: syzbot <syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com>, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, 	sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, 	yonghong.song@linux.dev
Date: Mon, 07 Jul 2025 16:29:30 -0700
In-Reply-To: <aGxKcF2Ceany8q7W@mail.gmail.com>
References: <68649190.a70a0220.3b7e22.20e8.GAE@google.com>
	 <aGa3iOI1IgGuPDYV@Tunnel>
	 <865f2345eaa61afbd26d9de0917e3b1d887c647d.camel@gmail.com>
	 <aGgL_g3wA2w3yRrG@mail.gmail.com>
	 <df2cdc5f4fa16a4e3e08e6a997af3722f3673d38.camel@gmail.com>
	 <e43c25b451395edff0886201ad3358acd9670eda.camel@gmail.com>
	 <aGxKcF2Ceany8q7W@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-08 at 00:30 +0200, Paul Chaignon wrote:

[...]

> This is really nice! I think we can extend it to detect some
> always-true branches as well, and thus handle the initial case reported
> by syzbot.
>
> - if a_min =3D=3D 0: we don't deduce anything
> - bits that may be set in 'a' are: possible_a =3D or_range(a_min, a_max)
> - bits that are always set in 'b' are: always_b =3D b_value & ~b_mask
> - if possible_a & always_b =3D=3D possible_a: only true branch is possibl=
e
> - otherwise, we can't deduce anything
>
> For BPF_X case, we probably want to also check the reverse with
> possible_b & always_a.

So, this would extend existing predictions:
- [old] always_a & always_b -> infer always true
- [old] !(possible_a & possible_b) -> infer always false
- [new] if possible_a & always_b =3D=3D possible_a -> infer true
        (but make sure 0 is not in possible_a)

And it so happens, that it covers example at hand.
Note that or_range(1, (u64)-1) =3D=3D (u64)-1, so maybe tnum would be
sufficient, w/o the need for or_range().

The part of the verifier that narrows the range after prediction:

  regs_refine_cond_op:

         case BPF_JSET | BPF_X: /* reverse of BPF_JSET, see rev_opcode() */
                 if (!is_reg_const(reg: reg2, subreg32: is_jmp32))
                         swap(reg1, reg2);
                 if (!is_reg_const(reg: reg2, subreg32: is_jmp32))
                         break;
                 val =3D reg_const_value(reg: reg2, subreg32: is_jmp32);
		 ...
                         reg1->var_off =3D tnum_and(a: reg1->var_off, b: tn=
um_const(value: ~val));
		 ...
                 break;

And after suggested change this part would be executed only if tnum
bounds can be changed by jset. So, this eliminates at-least a
sub-class of a problem.

