Return-Path: <bpf+bounces-60356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2A0AD5D2A
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 19:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1102317C764
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AAE221DB9;
	Wed, 11 Jun 2025 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJuuEwr4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE967213224;
	Wed, 11 Jun 2025 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749662446; cv=none; b=NnGlMOQmD9rYviBsD2vI+4VKP1CWe+Nkc6/RryGWMOsnULecpVyh86979v+tkdojmGTrULMsdcTg+Qgip+RaoegOmMHVjmgI3wB+/rOfVa7tMrb+0Ba8X0o5Ilno/w4quuFkGvma7jNsFn7y3h/OgDUhOQDTDLNX7AzMUqZcnzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749662446; c=relaxed/simple;
	bh=Sx72HRw3Yn4RGEQZlP+yprFbOX9B2FZRRX0q7mBUedI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b7H2yCP1bjDDVvyoczreTUcz244r5z8R4qAEbJhqOoOw32+YULXhp2AMfDZcWnh8EUU1ebRU6GleuNnu8x3tJYwSEmw1uj8bVrdcf2epEsh1KzVrlrSqQVHtq5j58Ahhe4x7PMZlchbRtUTQj38iFzRIkm7BmictFqgFDqird1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJuuEwr4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-313a001d781so130415a91.3;
        Wed, 11 Jun 2025 10:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749662444; x=1750267244; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cRCQe7LEqIZN/9wZ4INmjcrgEW8kPovwHFWEMLe8e2s=;
        b=WJuuEwr4JFs3hAhk3txMWroWQa1bvD8n6W8WIBUh8g3Ip8iHQ0dfTCMlURDtcqOHf0
         VJhQ5vQ6UFGihz1UJ5XHHSIcsa4YllUhPIwGPTxNjCfLpLrrU7GTd+oY02t8PKW+Z0Ji
         arWHFeJwTCZU5FWwLdSaHtHcXIbvnJs8rXLgki1DnorYHUT8A801lwXC2YAAx9+q1S0O
         nPOn8dXQCdUxCkWAwhwlaKQ4lTT9QFl1xahwWoLhz4xz8baJKEBrMoo7Sc5hnc+IGo2G
         CQDaROXNMwiW0aG087xu4LqTkmI2oXK4BPqQPr8lZ86TB/KAV8pRmKJRSfyzx9Bng1N4
         tT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749662444; x=1750267244;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cRCQe7LEqIZN/9wZ4INmjcrgEW8kPovwHFWEMLe8e2s=;
        b=d4+iXQ5NEAZpoCMSbdukuKCQbl7CDyoZtEXkCGUfuyWYA0kSrOewo63RgeXSEn2oGP
         T7u90W6a7y9eYuKplvgGsuC06QldF1T32qkFuxUjwyY33DMFuAec6lSHytFxb7gDfevd
         12rJN2X9WqXOByUT4sDJhVhxNV1sD+zQtdUBF1oGRhidjdWHUmwo8H61dKZh/HkESgll
         D6oNAArpbFcXC9J5ripvI9kUvSPtuivfTNpj6CIn29LDhngeaNTXrl+7XCSGUOuN6I1R
         RTsKJVLIb1BtTNR48BiG21M47+k+MgyEaux4sgfunLmHAQ4SbKiqE5ou6AU2GQvLJLHk
         eiNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlQGEXAmQfFSAl4BSml1FHLeqZz+XBZ2kxODoHLs3UOH4lyP87TsXJ99Hi+17MKtInuR3TuLyhXt/+hfXx@vger.kernel.org, AJvYcCXPc08QRx3WOj8icdziNr64HY8F4i8Jv+wm3ZiGkMdE6lOuYEv6qNfSuyJeK/9M3gMXTw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/6iaBMjGOpk+C6/HRpmQtGKZ9u6nPenuLwjjC0kH4izqpH34j
	Bh8Uw8SQZsnSOcqF+A62sUMWZ4qyq652PtIttPIhjP8jiVKr/DmavILy
X-Gm-Gg: ASbGncu/sozgVvNFBUap+Zb8lZc/nIyqzpLNLa/BgzmRgu/74QBE3lsFOpy3Z1aw4lX
	lgVSS8R3DWRyOeS4M8K/+T7Xiq0XWFIHFb2e3DmM0quGp9yWFSwsq41/hH7wDmMACn+jHldEB4i
	516QPpC9Af4eNelc/lMeGVMbcuu6Qpoqc1zgBrX700R4y53pNhuWBBrXxwfThzjDFz113OYM3m6
	OibrLXVY0hBwmNmm4V8duDPmX4l+iUS+8EemIl086xLA584LfJG6epGgAYxNIsAuXCvgpW4RzXk
	d21edZLZpexdrS1Suj8cDzz3taXSYfjiBQN5OjV6lhEomD32ReGTB7uSSHrdwjim/TOPP4PJ9v9
	+vFDr3LvIQLU3D3z1xyPd
X-Google-Smtp-Source: AGHT+IEjYarozUxyVFKxunE1PiLYMLbHE9SCdBC+v1q5zJGeSpPkCSJioDtC3uQQvGR0VYPNKy7B6w==
X-Received: by 2002:a17:90b:5706:b0:311:b0ec:1360 with SMTP id 98e67ed59e1d1-313bfc15c8fmr439284a91.29.1749662443650;
        Wed, 11 Jun 2025 10:20:43 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:b1d2:545:de25:d977? ([2620:10d:c090:500::7:d234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313b200a09csm1558604a91.16.2025.06.11.10.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 10:20:43 -0700 (PDT)
Message-ID: <b6931bd0dd72327c55287862f821ca6c4c3eb69a.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-use-after-free Read in do_check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Luis Gerhorst <luis.gerhorst@fau.de>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, 	song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Date: Wed, 11 Jun 2025 10:20:40 -0700
In-Reply-To: <87frg6gysw.fsf@fau.de>
References: <68497853.050a0220.33aa0e.036a.GAE@google.com>
		<38862a832b91382cddb083dddd92643bed0723b8.camel@gmail.com>
	 <87frg6gysw.fsf@fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-11 at 16:03 +0200, Luis Gerhorst wrote:
> Eduard Zingerman <eddyz87@gmail.com> writes:
>=20
> > Accessed memory is freed at an error path in push_stack():
> >=20
> >   static struct bpf_verifier_state *push_stack(...)
> >   {
> >   	...
> >   err:
> >   	free_verifier_state(env->cur_state, true); // <-- KASAN points here
> >   	...
> >   }
> >=20
> > And is accessed after being freed here:
> >=20
> >   static int do_check(struct bpf_verifier_env *env)
> >   {
> >   	...
> > 		err =3D do_check_insn(env, &do_print_state);
> > KASAN -->	if (state->speculative && error_recoverable_with_nospec(err))=
 ...
> >   	...
> >   }
> >  =20
> > [...]
> >=20
> > Either 'state =3D env->cur_state' is needed after 'do_check_insn()' or
> > error path should not free env->cur_state (seems logical).
>=20
> Sorry, this was my error from [1]. Thanks for the pointer.
>=20
> Yes, I think the former makes sense (with the respective `state &&`
> added to the if).
>=20
> The latter might also be possible, but I guess it would require more
> significant changes.

do_check_common() has the following logic:

   out:
         /* check for NULL is necessary, since cur_state can be freed insid=
e                                                                          =
                                                                           =
                                                                     =20
          * do_check() under memory pressure.                              =
                                                                           =
                                                                           =
                                                                     =20
          */
         if (env->cur_state) {
                 free_verifier_state(state: env->cur_state, free_self: true=
);
                 env->cur_state =3D NULL;
         }
         while (!pop_stack(env, prev_insn_idx: NULL, insn_idx: NULL, pop_lo=
g: false));
         if (!ret && pop_log)
                 bpf_vlog_reset(log: &env->log, new_pos: 0);
         free_states(env);
         return ret;

Same cleanup cycles are done in push_stack() and push_async_cb(),
both functions are only reachable from do_check_common() via
do_check() -> do_check_insn().

Hence, I think that cur state should not be freed in push_*()
functions and pop_stack() loop there is not needed.

> state->speculative does not make sense if the error path of push_stack()
> ran. In that case, `state->speculative &&
> error_recoverable_with_nospec(err)` as a whole should already never
> evaluate to true (because all cases where push_stack() fails also return
> a non-recoverable error -ENOMEM/-EFAULT).
>=20
> Alternatively to adding `state =3D env->cur_state` and `state &&`, turnin=
g
> the check around would avoid the use-after-free. However, I think your
> idea is better because it is more explicit compared to this:
>=20
> 	if (error_recoverable_with_nospec(err) && state->speculative) ...
>=20
> Does this make sense to you? If yes I can send the fix later today.

I think this flip makes perfect sense and should be done.

[...]

