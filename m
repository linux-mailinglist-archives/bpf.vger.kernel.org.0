Return-Path: <bpf+bounces-70524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C0ABC279C
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 21:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44FB3C7220
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 19:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3252236E0;
	Tue,  7 Oct 2025 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irJDTrDY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE6E1D95A3
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759864228; cv=none; b=t5p8aM4zLjMdmiUymgVdbge6OZBgkUKtYzHC2DxsqJBDG7cvScVaO/EiYaNQfDtamZWL3fAFTAvb4olvdaw21y1vPd5hBnsLme2Qo8vxxmFVNws3sZEENDIcqEQdEXwkKHWhlmWi2pfZsHIOxo326oU0JZhUutmqhy3sMoHr4kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759864228; c=relaxed/simple;
	bh=Qqyk1gRJ9+Fz5opwHcGCU8yiJ/fT++cxp/vcU3agpr0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DyhjWCHIefTxs57878AcRFSGTZT8fRLBwLhP/HlfNJ9vS44H+92e2OsSduRqnVH73ZqJrUPyt5b05RkiD+9x2HU4kRlIw1JRiNIVreZB2ERxBX4fL1wAm4xu5zbs+SJfUE+QP9k1VJEYaHQXiRq3lY4S6PmrVovCysQuD0/NK7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irJDTrDY; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6093f8f71dso4380583a12.3
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 12:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759864226; x=1760469026; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vpUjtDzbQtiJh0sKRf024qqQfg6PDXLfhzF9dZB41jc=;
        b=irJDTrDYbPiBx7UszGZEDOHbKlxWRC43E3s4D55rRRMrKHclGC8onhkvqGlSVxTXDA
         v/8fQbqPyC1YH8RF7KaK5mxJ/BNjtUdElVuXmb8jB//fjZ4CjlIcABGctF3xF6/mXAQy
         W0NH26dEYWNyPJp/ct523e/T/szaEI+Xw8u2iNC6ShOj9xIQ1wMjFRUmLXcdNvoqKwtV
         GW/uZWcVyXnWTGCjQKfpMTBz+rONNqPSwVGE8shGyD+T85VzQPWUfeyGIJ8/tq4OeR+r
         dnRXphOzWiNp7Og2Px6VE1pyY12hq/Vp1qoYrTiHfq6sZwVLc4qiPkhUnUOQoacprcIE
         JDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759864226; x=1760469026;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vpUjtDzbQtiJh0sKRf024qqQfg6PDXLfhzF9dZB41jc=;
        b=oHx5sCwyUirl3T6LFQo6+zDA1JtutOxtgpmg1EcuV8dQg9sjogIZZriiUnNaKAeBtR
         6T48BwI8rEVeb1dN/kO08sfTMx6/Kzg8dUpcmXzFjoMx9whroaTSkbCCyEQrqOVVRboS
         vYqAYZiO+/qWKZklyVqhgTysfIvDR5LmvEQfDfWpSeUAlMBnbjXz5gcCSOCmV4+yKFmL
         LQR5Nyru0bLYo/O1VrnGKn730hIAypXT5pqtbzAFOfslPv3xJVRe25xqE4EAqZRx2DIs
         QJWfM/WvhfYYOuQxedZ3mv7lo6NyOS5HsS/tx38ZPRfcaOdnR6tzdPNH+RCFR13xTAM4
         /Bqg==
X-Forwarded-Encrypted: i=1; AJvYcCWQFz9SRZx8tAxLzPlOWU75ec1pLzuc9KZiuPGTGlSzMWLJ6THeoIVeNG0blOkGdzFqNvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7/KhQmLDW7krSjCBk1zLh5dOENJpEnMe62PyV9pUL9Ojc/4ct
	dwnr6Yps/A968fCYNj2fHJiDpiFdhoe7zU/g9kTdvXq4OauaoEbFIGCQ
X-Gm-Gg: ASbGncvYYm5v/d8Z2762df4ClzFJOaagHEgYftd6zslIpcrJ3KeO92POOV+fiRtlRZU
	Udb9poR7Df+eoqIjlJlsoaydgrv02Kh8YMCIDnXrMKkkW1nB4UEqA1wr3bsXk67MbJUFMWfqnSM
	tx9vqctt/1pWFaAwxumLbIrLWwayzNhMzc/U57c2tZ3/DZIcf9WEz+Te71J9puHbmC0RWCRCWrX
	QHt0q4L01Wpi463phSBd/s67k6LCl9sCqKI+09KvkTPq/9Q93rFyr2roM9pdOWi3M6EM+cAqVbW
	J+KlN7YAaGRlaW+29CzgpGh8OkzfVYrcXJ1sz+y7BHnF7ZRI5hq5xAddiG/E7LF3BTMQaTYrS1R
	jI6yzPR+AYiDraN2SELvdiZePmnDQRAyoI0rsVW6L2OYre+W8RviZ/Qk0WXLNPcXJWhkSQqeK
X-Google-Smtp-Source: AGHT+IH93pYc8QyRAkZV7dgqoRwZkMS+XtUjDiTUQ0BCp7mK+tQq071N/PZQ4DlRcYROm5WEOnCUPA==
X-Received: by 2002:a17:903:2d0:b0:25e:78db:4a0d with SMTP id d9443c01a7336-290273eddd5mr10599905ad.36.1759864226399;
        Tue, 07 Oct 2025 12:10:26 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:8bd3:2c4e:e9b8:4ad1? ([2620:10d:c090:500::5:b7ce])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1280a1sm173956785ad.51.2025.10.07.12.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 12:10:25 -0700 (PDT)
Message-ID: <8312f8cca2d5173445bc3fa6bf3bba0e1f70ded7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: Add tests for async cb
 context
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, kkd@meta.com, 	kernel-team@meta.com
Date: Tue, 07 Oct 2025 12:10:24 -0700
In-Reply-To: <20251007014310.2889183-4-memxor@gmail.com>
References: <20251007014310.2889183-1-memxor@gmail.com>
	 <20251007014310.2889183-4-memxor@gmail.com>
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
> Add tests to verify that async callback's sleepable attribute is
> correctly determined by the callback type, not the arming program's
> context, reflecting its true execution context.
>=20
> Introduce verifier_async_cb_context.c with tests for all three async
> callback primitives: bpf_timer, bpf_wq, and bpf_task_work. Each
> primitive is tested when armed from both sleepable (lsm.s/file_open) and
> non-sleepable (fentry) programs.
>=20
> Test coverage:
> - bpf_timer callbacks: Verify they are never sleepable, even when armed
>   from sleepable programs. Both tests should fail when attempting to use
>   sleepable helper bpf_copy_from_user() in the callback.
>=20
> - bpf_wq callbacks: Verify they are always sleepable, even when armed
>   from non-sleepable programs. Both tests should succeed when using
>   sleepable helpers in the callback.
>=20
> - bpf_task_work callbacks: Verify they are always sleepable, even when
>   armed from non-sleepable programs. Both tests should succeed when
>   using sleepable helpers in the callback.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Maybe also add a test case with a global subprogram, so that it is
verified that subprogram inherits program sleepable status?

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

