Return-Path: <bpf+bounces-38452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31554964EC1
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 21:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35342819EC
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 19:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8021B9B38;
	Thu, 29 Aug 2024 19:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUYdJCwt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B144D1B9B33;
	Thu, 29 Aug 2024 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959473; cv=none; b=iw4zYkp6nVGAvpEqsldUIAgmLnHjAb6ARrm5ueWxABfhn8r0lQ4dJzBfD2azk1iVryWFsWcUKqryt9vwrMqAeXI7hbSB4lFAs+DyYrxEscCZi9y2IeOQYlBNpG/y4YqVN03d0S1f+RWUyhudalPonCaRVyKs7idwPB+E4jfLbog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959473; c=relaxed/simple;
	bh=BmFEeWRoTKmrRXWSutrOaYv0xbNIQ74TxBbzWKgjmLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ep+7vnNpwNtIQaWevT80bkVqre4gF5b+csJgB3YVJdOzXg+5I9A7nhkmop/t3Z9Q9khAqc/Fm6tmw2OEAeNW8kCteMVHV2it1IfRnOK2vhHm+G9IpG/o6veQSYb4jbC/cQzJGORm9OoEnJda8Mi7RjpXE8wmthS8UmkQQWkYgLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUYdJCwt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37196229343so706819f8f.0;
        Thu, 29 Aug 2024 12:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724959469; x=1725564269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmFEeWRoTKmrRXWSutrOaYv0xbNIQ74TxBbzWKgjmLw=;
        b=RUYdJCwt/u956eZU3V1cyhuwOI8iM6HWc0eFdqosBAHZl/6eMFdGSI6lvVvV2pZDiP
         eLolEyMaC2uauRt5JEEdn0eQwEdxjMT+hMMh/czKb7RPCD6Oy3rjDbg9v/eKDd4yhC2d
         EEySCsy0LaU6GdQ648sIzAPy3lvkq+ioahkxITd3k6xCPHJBlUwDDa/DzLUm92Npkw6j
         1BRECUJUiAIzJy8LYuYq1KAEIAJUSanFRbZpltLFQNjK72hxNi4g7KAWlD7FbeVks0Df
         nDTaxJc+rWlG9ns0Dspob1xO/a8T3MC9gKuX0qtyw5fISphhfBjgXTcPgZXhxIcpVQbJ
         eMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724959469; x=1725564269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmFEeWRoTKmrRXWSutrOaYv0xbNIQ74TxBbzWKgjmLw=;
        b=Jx2TRsruJlXOxssPrlkRIbHFVoQneWij1vtNiwjS8FR2GuqDUqWGfAp9dIFqy2CgnJ
         zSex2wLQopPirgHsPsiuDEjOs5HqFgMeHW2XcIpXjIVQjM4KN4bl+EG5yhjMfdVTARyl
         M3qmLIyCzdvaigMaL4jhTgimde8/BqtzrTUEuZ0WMkl8xTNKvBegUoa2KMPMarChFeWj
         qfaPSiNSXQod2vl7zOiiXV+u+ifVn8HAdIGvNfggicDAhv0T7uyKqpsXdRJURyJ0JNJe
         MKq0jzhHU9CxNWnuZ4ZgVB4IRv0/38CRmmcSdTFtxDITcmCuYWJIjmy8kXwI78UbtSxW
         tnUg==
X-Forwarded-Encrypted: i=1; AJvYcCUJog4NtmwPTDhczeY3iZwpYP80Dga08njHtjPEcjbx6kdVOfccIRvwOylka/nVcnzre8CQzxbTf0ZPty1c@vger.kernel.org, AJvYcCXhp1XU/2PwSWBqojp0nta7NRLQoVr7+uoRPQN8uUojXQpI2Y8T9jH7ZMmGzdVCwZizn8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoXcxIV7r+I9ILGorQdh1qFhlm+B/o877/zIiNXFlmh0qXXhmY
	XVjvsitvov+MkOEd0CUIJin0hShqwZWelpmp+qYzWmgqUkJ9v6ITvsrxG3tVpOZkuYjYjNF1LEN
	sohqU2FbRq5u/sfk9hFwOki/qgsU=
X-Google-Smtp-Source: AGHT+IHOkEO16tIXxM5kBfCPn575boZ5jVxseMjoaohbBQ6j6UJ1g0BXSfTd5JZCM80of12ANtAKGQEsyphT9T8sK4k=
X-Received: by 2002:adf:f691:0:b0:371:8dbf:8c1b with SMTP id
 ffacd0b85a97d-3749b56154fmr2842662f8f.34.1724959468964; Thu, 29 Aug 2024
 12:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNATb8dbhvdSgiNEMkdsgg93q4ZUGUxReZYNjOV3fDPnfyQ@mail.gmail.com>
 <20240828181028.4166334-1-legion@kernel.org>
In-Reply-To: <20240828181028.4166334-1-legion@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 29 Aug 2024 12:24:17 -0700
Message-ID: <CAADnVQL4Cy-F_=RJy_=3v97mfaMRWGp54xN-t9QzOqY3+hoghg@mail.gmail.com>
Subject: Re: [PATCH v3] bpf: Remove custom build rule
To: Alexey Gladkov <legion@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 11:11=E2=80=AFAM Alexey Gladkov <legion@kernel.org>=
 wrote:
>
> --- /dev/null
> +++ b/kernel/bpf/btf_iter.c
> @@ -0,0 +1,2 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "../../tools/lib/bpf/btf_iter.c"

These files are licensed as
// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
in libbpf directory.
Pls use that.

Pls keep acks/reviews-bys/tested-by when you respin.

Thanks

pw-bot: cr

