Return-Path: <bpf+bounces-77546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A781CEAF12
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 00:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D71C33012BD6
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 23:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5912FE05D;
	Tue, 30 Dec 2025 23:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMkozXzM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A312BE7A7
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 23:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767138991; cv=none; b=dBzA/h1q4dhYKzXrzV42ZQEAIw9sdundtnXzgYNp7nlbV6EgVWLjVfEDYIg541euUR8/TskQBrXhKGXdBWNe2RDaH7bGZ03zURKN9MP/Aepo0WuYwNK25LfNUBMseLSfpuS29EP/7nRoTyWHnmZjlqYp24xmHEMAsCCgPk5fhk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767138991; c=relaxed/simple;
	bh=viVEouxgZ4vdI4fpPCl+5MsHCSKijtEtOyKikFVFXZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbSTQfnIdd6QxlpXijYoK9WpmBa/pRbj2AV8hqAx+7pVQjTuSyATqfU1vc2fYJr8YpMTZUEebhBxjzITTqIiYy4SDto86+1zbCi+Qon0ZuY0oe5z3l3UHdptKUkCvg+KN2PRoASRZpkivwKEb6bVFzy1omWSTRxblHL3bSMf46E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMkozXzM; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fbc3056afso5601631f8f.2
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 15:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767138988; x=1767743788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBsn/djui7Bc/V/oeSQy6ChFrOic7ls0uIkky6ScPag=;
        b=jMkozXzMTYdYNoFmNSuoNUFtdRtpJOlNBxtmsn1U9hwMQgmbZXieCc1kWFUijhfd2Y
         hM8I9yLFotjTEIlxGSfvSG345CnA6IhJ3EWb2N90OSv1BsDi9674pq7HySY04rFFzOgL
         garhoTmuEfxGGlg0S7iPnDddQBATNEw8vJgkcuihG3lC54S+vBreDB10rf04UgptfD4x
         OOiRbppgTX5E7QZRWehPR/o3C9SMMLYUW25ki+2oGVnBTmJtKQyZ1V2eYV0ypMuyM+sb
         RE/P/UOa1CAlbolvIIlR9AFBsVXkeI0CIombGsr45myZsas1kaIA4pWUN7iVscczBtgE
         cMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767138988; x=1767743788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RBsn/djui7Bc/V/oeSQy6ChFrOic7ls0uIkky6ScPag=;
        b=LzgPOcNN42PEyUQx+SU+4S54U3GdeIOWTnTFgVuXbQRliFra5KBFSt4XRMF3AOwn0E
         WXn0daBNOlrg1FJa5VvLoaCQrZm74N9jgTruK9b4ByBeIc+byxo10RXelMDK4r5TVRTn
         g31p9uh5ZszrlCOfj633D1lsOSCqfSdaZjhwNbcP5QH/do6KrwQsnYUvMHJZiTjMgHdI
         eaR32Z+gqfcSVSFkPEN1CStqAycKI9F3phkAC5oiztNEaJBj69gtyaQIW3dWFtwfZNwd
         GB8E1tEQo+xuIRm1lUaOgMiAN3+SYaJabJHzlVePizlXAW1E7+Uir/j72NFp7XDlJLFc
         Z0HQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6NirD4OmEAk5SeGSku4621aAH0RQdVKueJBbBepx7v9EQmOYGjEsgykEi1mfDF2DbamI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFK20hFAXr5h7S0beW+ErHSGDXWGz9kPWv+lcG9vldJn3C7cA+
	bsG9Bw3H1t7HftoRak/VUs0t/mX9CW6t/GQqZ4sxsTNXpStM5ZWe+vOENB/EcnsdnINbUbFsIMh
	aGQaFNCUWkrcf+vMwq/rjH3l4hsEimS4=
X-Gm-Gg: AY/fxX7zIAkGYKAis4trfpBYgDRaKUe0rI2GUZg2IXWzk0EdVFRzPtfSLfWWCyFQrxU
	yE7wuzFw7vSyBwfYEYb08G7KvT2x6Vks2not0LMD/I90QeR/8E6ZKUHxTZgK8apHn14oZyZAQsU
	cbwLR8XSJc0CWXyBh5NrHetgFQvQJjvpb5+EZmwy40q9Y2H38Z7TgNCXVDaB9da086TuaBmpS16
	YqBaw3IkFU/kzp1oa4bo1Hto/Hd1IUdD68ummfNtie/OpXaRjXHod7v5I5Lu7LWF7eucDLLcRvW
	QkMVf6LGe9nrGrjck4fO4cUhPZrDkC8UEIjSx/I=
X-Google-Smtp-Source: AGHT+IHX2DtjnU+gojgDr4wMQdBdYuFw1rhS0tG7t8tIXaiGQQcdee0mk/d6ituc5XL1XleZcjignP2Oqqu/Btl6kbQ=
X-Received: by 2002:a05:6000:2886:b0:431:764:c25d with SMTP id
 ffacd0b85a97d-4324e4fab99mr42261292f8f.35.1767138987652; Tue, 30 Dec 2025
 15:56:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224192448.3176531-1-puranjay@kernel.org> <20251224192448.3176531-2-puranjay@kernel.org>
 <4cb72b4808c333156552374c5f3912260097af43.camel@gmail.com>
In-Reply-To: <4cb72b4808c333156552374c5f3912260097af43.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 30 Dec 2025 15:56:16 -0800
X-Gm-Features: AQt7F2rXqfVMSuT9GqY-FSnnp4vWVi3lawY5AZIj2_zRPSYsH2hLGRLRYwbED0k
Message-ID: <CAADnVQJU=pboBLKapwySw1vG3EBxuAAPX4xR_1_6ALFYoMt2vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: Make KF_TRUSTED_ARGS the default for
 all kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 3:49=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-12-24 at 11:24 -0800, Puranjay Mohan wrote:
> > Change the verifier to make trusted args the default requirement for
> > all kfuncs by removing is_kfunc_trusted_args() assuming it be to always
> > return true.
> >
> > This works because:
> > 1. Context pointers (xdp_md, __sk_buff, etc.) are handled through their
> >    own KF_ARG_PTR_TO_CTX case label and bypass the trusted check
> > 2. Struct_ops callback arguments are already marked as PTR_TRUSTED duri=
ng
> >    initialization and pass is_trusted_reg()
> > 3. KF_RCU kfuncs are handled separately via is_kfunc_rcu() checks at
> >    call sites (always checked with || alongside is_kfunc_trusted_args)
> >
> > This simple change makes all kfuncs require trusted args by default
> > while maintaining correct behavior for all existing special cases.
>
> While I like the idea behind this patch, I don't think this is 100%
> backwards compatible change. Not unless you check definition of every
> kfunc in the kernel and add appropriate __nullable annotations,
> like you do for some in patch #2.
>
> For example, consider the following kfunc from drivers/hid/bpf/hid_bpf_di=
spatch.c:
>
>   __bpf_kfunc int
>   hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
>                      enum hid_report_type rtype, enum hid_class_request r=
eqtype)
>           ... __hid_bpf_hw_check_params(ctx, buf, &size, rtype); ...
>
>
>   static int
>   __hid_bpf_hw_check_params(struct hid_bpf_ctx *ctx, __u8 *buf, size_t *b=
uf__sz,
>                             enum hid_report_type rtype)
>           ...
>           if (... !buf)
>                   return -EINVAL;
>
>   BTF_ID_FLAGS(func, hid_bpf_hw_request, KF_SLEEPABLE)
>
> Currently, it is possible to pass 'buf' parameter as NULL.
> In this particular case it would lead to an error code returned from
> the function, but is it the case for all kfuncs in the kernel?
> For some kfuncs NULL parameter might be expected as a part of a
> non-error scenario.
> Also, there is a question about kfuncs declared in out of tree modules.
>
> So, I think there are two questions to be answered:
> - a review of all kfuncs in the kernel checking if there are
>   sufficient __nullable annotations;

right. that's necessary and HID was missed, because it has its own
selftests that are not part of bpf ci.
sched-ext kfuncs need to be reviewed as well.

> - are we ready to potentially break BPF programs working with kfuncs
>   defined in out-of-tree modules?

Absolutely. That's not even the question worth asking.

