Return-Path: <bpf+bounces-61128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8775BAE0F84
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 00:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA413B8A72
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 22:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6754E220696;
	Thu, 19 Jun 2025 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buBSxM8N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872A30E833;
	Thu, 19 Jun 2025 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750371446; cv=none; b=XA97wiNVTl+5QHgmNTTTEekmn+FTxdQ5Gmt2BakSxyKcoE7AMHHH/dZ/uQ8KqylGSk7g9MI/GvHwKP8vpDpAwKKUmpDIxKoY+k1KcZyh1c0D42NsKno8AgXLCUdXqmZcbOeQveBKYwoQgRb35Ojc38OZ56zoWg+0ItVNS0EYprA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750371446; c=relaxed/simple;
	bh=cs3dedHqmtsD8vQcMV/N+5BhRDxgc+s1nST2ty7DzDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Ez+OWNeZbu54Qn210Rs5sqppYC0QxlrsUCh3PebKSaxpDY/asvx2fmFsUq+INGQlSCUM2KERXtT8uwIt4nu56GErzDsIORZZEqbbNf5kNCFAVshhNJM8f2RBqzAUKb6dhXDLAo7L4hr88qxGyh8P5yAivNtr6mzmlt1mJD0k6AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buBSxM8N; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5315972826dso805133e0c.1;
        Thu, 19 Jun 2025 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750371440; x=1750976240; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cs3dedHqmtsD8vQcMV/N+5BhRDxgc+s1nST2ty7DzDE=;
        b=buBSxM8NInHFYK03AJlqulgau0Tm5b3qm+ubfo861aQzF2QfwADNtNHOVJj4FWaHwp
         nAPTW4FiJ0vc5yxknFubnkATa592vqt7b0SiMgwyjwYihy80hztTpXNoxqQYlF7UiekG
         zeRkqbLMXn7ifOThcGa+AGsTjwpzM8sB6IURBh0QQDijemL096uFMO2mhNgoWIV+7WbE
         eOOO9tOSQdSN7ugIsIEi58cy6zr5ctPNW/uB0xPHwz40H6TFofvMYCWzDJkK2Y0iekih
         9PVebKnfF/8hkGrSS6u/8k/eSMp9ocd3pBOA59OTZMeCbgUf6HfDEX5uV85u4lGish08
         1lWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750371440; x=1750976240;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cs3dedHqmtsD8vQcMV/N+5BhRDxgc+s1nST2ty7DzDE=;
        b=umU1RgpPkvljDj9f0yyotj0oLouwjcppXaFSZA6VO8vOdX5InOnFdj4gabaWpIPuC6
         JrpJaLFM5RyzoLpi8a3XJRNW3URbqFZJL9BlEJ9WJztHJaWLUCAU3L88fYZi8Syi3fM9
         PGiOv+7rfzLeJ5jVzp+rxAeDvpSrIldCClTfRtSIt8vK2Au0e+G72RETUPNK4hGDEKcj
         qrQgEVa1Qa6hWTEIR3kog9f+ah7anN11h+VkRJGwuC01HIvEXU4sQ+G0WquGJFOEHnK1
         hpr7pbX8JdhDIKGXfc0UZPRgppxa+a0hhZTGVI8IKM4W7MgQToKI2MzggCyqm8iDEpKU
         JnwA==
X-Forwarded-Encrypted: i=1; AJvYcCVV86u4SjknjANOm2PI0Tn23lw100gIl8BgyxRIbVwfQLIk1yU390e3S8mX7WTggBEbSJ0=@vger.kernel.org, AJvYcCVhKhAvBRR1wuvWiwN7Giz7GZGsffYR1pMGuGEaB5z76ZfF483yIazRnLpa6S9rsjPtZUz8rxQ43EEy2y5+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvw91usYuBOr7dlAeQebbeA1Z/I+mkv1uK9Rgti0RoowBaSUa9
	9kVHiSYIaR0GGEtsdwsPWIcN3jyR5Kvq94C9fZAzgf0I+M0ouYrkEqBgZ01cAer+rFScJrjGbzZ
	/Z3CIYgTB2gjqRnTARh13Ug8LYhr4I7E=
X-Gm-Gg: ASbGncu2CqRhFd0HPVdogQmDMDPxNV5Kjw8gbWSYN42Uhkfc5Ws7zUOyv5zDxdbYnDn
	2XWG9ADqEdn4Yudmk5dXlNobWGS7la1HOta362beGFP+IWMJb1ifCY1EOsrRxDveDXJaHl3UlTC
	tB2h7zAE5ehdeXMuKCArMC4J7vOlG/0gFmI2aEj5D79lpePMZUGLG8zPwROzh4dkRwihc8YprGn
	Omzqw==
X-Google-Smtp-Source: AGHT+IFJHdC9mcG8qmF3kyk0GuDJLjxtH8LqgxzsvuxEdjLlLC/oceuzhAAanaTzGxB+sa65QJ50c4RC0y5n9ScmgHQ=
X-Received: by 2002:a05:6122:4b8c:b0:531:188b:c1a0 with SMTP id
 71dfb90a1353d-531aeb8cb51mr41302e0c.4.1750371440279; Thu, 19 Jun 2025
 15:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617231733.181797-1-harishankar.vishwanathan@gmail.com>
 <20250617231733.181797-2-harishankar.vishwanathan@gmail.com> <20250618112339.ezhjt25lnztck6ye@ast-epyc5.inf.ethz.ch>
In-Reply-To: <20250618112339.ezhjt25lnztck6ye@ast-epyc5.inf.ethz.ch>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Thu, 19 Jun 2025 18:17:09 -0400
X-Gm-Features: Ac12FXyRtEecvtEn-ZQ-9VuMAXBZi-abBuTBBB31H8Xqmfbo_w0QHeFz76P423w
Message-ID: <CAM=Ch06HkqNgh67TGv=_LGp8qdmdtOt3oYk1ZozF15Jg9c3PnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf, verifier: Improve precision for BPF_ADD and BPF_SUB
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, ast@kernel.org, 
	m.shachnai@rutgers.edu, srinivas.narayana@rutgers.edu, 
	santosh.nagarakatte@rutgers.edu, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 7:24=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wrote=
:
>
> On Tue, Jun 17, 2025 at 07:17:31PM -0400, Harishankar Vishwanathan wrote:
[...]
>
> Both cvc5 and z3 can prove the above, and one can try this and expect
> it producing SAT on:
> https://cvc5.github.io/app/#temp_a95e25c4-88c5-4257-96c8-0bd74125b179

Thanks for verifying this! As mentioned, we tested the new operators
using Agni, which extracts SMT encodings automatically from the C
source code and
verifies them with Z3, and found the operators to be sound. It is nice
to see that your
testing also concluded that the new operators are sound.

If you=E2=80=99re comfortable, feel free to reply to the patch with a
Tested-by: tag. I=E2=80=99d be happy
to include it in v3 of the patch.

> In addition, the unsoundness of partial case-b can also be proved by
> the following formula, and the counter examples generated may be used
> as test cases if needed:
> https://pastebin.com/raw/qrT7rC1P

We have found that using counterexamples directly for writing test cases is=
 not
straightforward. For instance, consider constructing a test case for the pa=
rtial
overflow case B. A counterexample might return specific range inputs
([umin, umax]) to
scalar_min_max_add(), which should cause the output to be unbounded
([0, U64_MAX]) due
to the partial overflow. However, these specific range inputs suggested by =
the
counterexample might not be reachable at all during real verifier
execution. In other
cases, the *tnum* may later refine the result in reg_bounds_sync(),
making the final
output not actually unbounded (when seen in the verifier log).

As such, we adapted Agni's enumerative synthesis procedure with
additional constraints
to generate the test cases.

