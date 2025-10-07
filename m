Return-Path: <bpf+bounces-70523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55757BC2799
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 21:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C6E3C52D4
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 19:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E7B2222D8;
	Tue,  7 Oct 2025 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g42K/Agy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72359222578
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759864149; cv=none; b=C5Ow92ohezAII+mnUoidmVMryUr8oKDJIjgJSpgpi0JtOojc5qftQosTgfM5OLppAnW1Pfmi3I0He7gshIlPoVHMkHu5DnxBSCN9aufhEqYzDU9nHTmXY5aDnQcctCAT6ves70U01c9XZhV6AVZh4n15FKWjSw6jYSeoErKtl0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759864149; c=relaxed/simple;
	bh=7qfILTdOnXl49xa9uvrKu6iojcn1D6WUQkXC1XmjyrE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KIfQcaNH6xQmWwG9hcc3WLd9c7DojpgIlAyjHjxC5A41gmWX7hnWVFIoJufVLCWThOUwa5u+ccgsayaJECnm4O1cTu2Jugj2ItXoATsgYKDJ205+jhjijZOrRVYD1lgP9u2vQL5FP6ns7KEIMffiPVCcjtMrsw5H/uOTD8oYcF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g42K/Agy; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77f67ba775aso8784003b3a.3
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 12:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759864148; x=1760468948; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B3vDi3nnc06D2RJguLyJekrIC1JkWfrTZHrSiKkmKyw=;
        b=g42K/AgyKDOTkBWIhJaXTVnEKGLl8liqdGTNyBXluwMlrWCe/XGtW+UBUFxMHd3J/2
         yGKrT9SIzFIkIwlBETjagpJN2Q0bToE4WMutGvZMYtnrwK6mba3jmYvwQHtPJEl6LRoA
         XrBpLUyRRjOO0R+O8GFJuGradQnxiyga9dEFpLrWPNORDVZDLykTSnX1HZT2mwYs67ls
         dPu84mmBIN/w0gGNBPy+T6Cx6oehun9tqViIUghr//9pZ9DKrBmcW8sUO+6K2WAyghi/
         yDE4esJK95kPbME8s1uaI+qBdoo+sf807mTRYAWzsuU98h/IW11pXERHDq6PtiGaiJ4d
         PVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759864148; x=1760468948;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B3vDi3nnc06D2RJguLyJekrIC1JkWfrTZHrSiKkmKyw=;
        b=A31V23EHq2Pv4DsnZXWv5aMwGE6KMWK/Q3hrnXQ1mxB9ADYPTkk7SLa88TjY+uZ4Lw
         30MyMvhR1qkq/g5GNuokcko6sxY3WaqUppAGu3FbGUR5i3wSP5msLuDAzIK4oLjNAk50
         3QCmOUDVvaXxxU70lkI0eQ3mhcl4zdD8tUuHzhXkCQMJgYvNR4uTf8WCVLYQSNRTx4hO
         jUlITjU3wa9SokrFr3eKoKc0hnRhhBUvVe1jrcLaG+0UB9y08bl5N1DiGtCfDgd6XYzC
         JMmA38cvxie4xhsiykqNhOHYLfV7KTioy5R9wQ/WLCqFQ0ClInIlpYoywqLzPPjatLMB
         xr8g==
X-Forwarded-Encrypted: i=1; AJvYcCWel7dYbV3jAugC+v7Qm44DpkiUhCMl1a2APmfEyioyhUjr1iY98Z6oaKZw/Y6/pk4dd34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkQ7T3u9mlL2cjime+McGBFLNeyL4SzBrEr1t8cib3vQS9azbw
	htRAU7ygGmg5yA0aZ3IUNivho5FtUutb/oBHT+JsyAWIMVeue+reMFLOF6Y9mJx3
X-Gm-Gg: ASbGncuqRsd1vIqae4LnkXFKWlhjZlR314dQyv8eLOaBdgp2Cu3mYhc7dz7uMtpBSZt
	y7S6LT77nlZWKCo1zQd44QFTEaFbpchOlCeIRRY7R0LrkLVZ3h/N+8cJSDQVCTwzNBA3eLz2EHN
	gE9UtRv535LOoFa/cH27S0XgjFy0EWD39Er90SR+NVSUwxazeGLN7FFGe6j2JJHDmBnL9X/iJJa
	5GvTiJxyYDWml1w/ItRUsVgpSOeC9+XsPL2brIOH3QHJGo7/flkDtjMGUlXgHc2yNaFms/5m5Ff
	/pK/+KO6dbYPSl3RKFJhBwzkd+yiMkaC5mpAvlMW9Xdp0VhdEds3TmMpT1uMo74t4JEHcuJ9r8f
	WCpJqolfADv7yhXKNYe0b7aFpYUnR04v+8GU1naPbwht6WF7Zl75gPGucm25MOTsu215AEp+a
X-Google-Smtp-Source: AGHT+IFAU4mNMqGOkbX8V9rKxJXNhVG1TfAtOqScLAMry51Y9ToxZyiJk27RcUe7WExcvMo/oC7Qsg==
X-Received: by 2002:a05:6a00:1741:b0:781:17ee:610 with SMTP id d2e1a72fcca58-79386e51022mr849608b3a.17.1759864147582;
        Tue, 07 Oct 2025 12:09:07 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:8bd3:2c4e:e9b8:4ad1? ([2620:10d:c090:500::5:b7ce])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0206e6ccsm16409880b3a.63.2025.10.07.12.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 12:09:07 -0700 (PDT)
Message-ID: <340fce3310df92a9a2cefb25e3eb2781424958e0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Fix sleepable context for async
 callbacks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, kkd@meta.com, 	kernel-team@meta.com
Date: Tue, 07 Oct 2025 12:09:05 -0700
In-Reply-To: <20251007014310.2889183-2-memxor@gmail.com>
References: <20251007014310.2889183-1-memxor@gmail.com>
	 <20251007014310.2889183-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-07 at 01:43 +0000, Kumar Kartikeya Dwivedi wrote:
> Fix the BPF verifier to correctly determine the sleepable context of
> async callbacks based on the async primitive type rather than the arming
> program's context.
>=20
> The bug is in in_sleepable() which uses OR logic to check if the current
> execution context is sleepable. When a sleepable program arms a timer
> callback, the callback's state correctly has in_sleepable=3Dfalse, but
> in_sleepable() would still return true due to env->prog->sleepable being
> true. This incorrectly allows sleepable helpers like
> bpf_copy_from_user() inside timer callbacks when armed from sleepable
> programs, even though timer callbacks always execute in non-sleepable
> context.
>=20
> Fix in_sleepable() to rely solely on env->cur_state->in_sleepable, and
> initialize state->in_sleepable to env->prog->sleepable in
> do_check_common() for the main program entry. This ensures the sleepable
> context is properly tracked per verification state rather than being
> overridden by the program's sleepability.
>=20
> The env->cur_state NULL check in in_sleepable() was only needed for
> do_misc_fixups() which runs after verification when env->cur_state is
> set to NULL. Update do_misc_fixups() to use env->prog->sleepable
> directly for the storage_get_function check, and remove the redundant
> NULL check from in_sleepable().
>=20
> Introduce is_async_cb_sleepable() helper to explicitly determine async
> callback sleepability based on the primitive type:
>   - bpf_timer callbacks are never sleepable
>   - bpf_wq and bpf_task_work callbacks are always sleepable
>=20
> Add verifier_bug() check to catch unhandled async callback types,
> ensuring future additions cannot be silently mishandled. Move the
> is_task_work_add_kfunc() forward declaration to the top alongside other
> callback-related helpers.
>=20
> Finally, update push_async_cb() to adjust to the new changes.
>=20
> Fixes: 81f1d7a583fa ("bpf: wq: add bpf_wq_set_callback_impl")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -22483,7 +22495,7 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
>  		}
> =20
>  		if (is_storage_get_function(insn->imm)) {
> -			if (!in_sleepable(env) ||
> +			if (!env->prog->sleepable ||

This is not exactly correct.
I think that this and the second patch need to be squashed.

>  			    env->insn_aux_data[i + delta].storage_get_func_atomic)
>  				insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
>  			else

[...]

