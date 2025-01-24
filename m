Return-Path: <bpf+bounces-49694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC09A1BC34
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 19:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46013188A3AA
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 18:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE0F219A8B;
	Fri, 24 Jan 2025 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDmfKlUp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB081D88BF
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 18:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737743680; cv=none; b=a1YKayPY6rpKodyUOn6leUI8LHVzJYPSAfuCYYu/XLyU2WkFI0A8tgUGMUsnz3keRU1WDcQNMcCHZp2vbSq07SyotkcRe5bLEz8x+bFmPvRLRKr1dHo8f3sGdPx0zObDKEIWdqaXFGZ++VOKyROgxaWKFnMlnDbDUocLPvWrZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737743680; c=relaxed/simple;
	bh=sreMa90F3GXz3UKdI5emJeajBfxlmPef9cFuDtRzqbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rk+fLtPySezYmsUbqAaLDGratPeVGu4dk8I3J3Gf6WNyic/uaX6qdvzCRpjvAeZ6Xte4VBf9ueZW13AeU5O9NiZkfAL7WAN14awwKz3CULB+AnVVg1R6taVWDqytlAXhDsJwHcDQKYuCKK4kAerbm/ggRrsvfrZ9QfK2ydAWptk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDmfKlUp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2163b0c09afso47402825ad.0
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 10:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737743678; x=1738348478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAKXVuUu1R0kKi2huLqEaWSXgHnx3xQANNMPTixO7+w=;
        b=SDmfKlUpY4wedavpb9NFGnEEetmFITkdqVEbmCm+V5qG2El20KCWlzRqdy+DuXo+ey
         3J1AsWX3oCcZ68SulwK4mOfDtmrqSBteqmf38spNsFOG3hB6D0rgPBOQoiKHnOny4UzY
         r/FinhgaO2N1lTJ81w+qhmeLhgtvBRXKKG1RX8IpiTX+YUSbgOdkZJxIssRBH3xrg8CS
         gWJycSyarRbm1bfp84OqtYwcPF1pD/o1Crql89IIspdKtu9krRv/0amZiQiSkpZH2iht
         4uhQaxAQJ1usQ+MHdgifQKkxKyDiasT2ikp8vOFeUn6q5ci4qR38NJbPdBV6n9y3f24G
         P7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737743678; x=1738348478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAKXVuUu1R0kKi2huLqEaWSXgHnx3xQANNMPTixO7+w=;
        b=GFGwQZ4iZzkM4wbSrxBlTrXeZ88nam2ShEdHFo93x2BT8POinIiomeBljOlDlenXik
         /ocOlHsm3Cbmzra2mEBT6ZuiGMuFZPaJXlR7+oyJICUtfELz2yjV7HBwMmb2pqwNYeCR
         aAM+qMzj2nLro+DNyI+QS8CbiYvSlIMa+MhtBVClMAYSMWQbS1tJL1TRal2XL82BjPBu
         zSDWiXy8cubyPep0rNKVM1IuKhj2xv3B0tunU6BDRAX2crgh6K/zvmBGcyvRIhL+Lhvx
         a3gRMnN1tzDYUHIgvlU+5eLZNRh3WnyKveKuOt0bqxESXfyscTvXJQ7+5Q5huO6l/9mO
         mzAQ==
X-Gm-Message-State: AOJu0YxYUOoCDJKuxDdKAIRhIdkyUUsD0EnoWPgoGNuD8qUVZ+I24Fm/
	zLzMmq5Iz8UOnDcFy7IJRl7KyypVaBLU1IiMkv6xfjGkd73NVp8JhRfjMUuPoI/Gt/U833yfTYy
	n0EJjhoXWTsyc9MSLR5zof1fKuOM=
X-Gm-Gg: ASbGncvcNO50vf2jgFMMQoQ9xczAEuCYSjkN+I8L7gtcy9NXaInRBWdG5L2Nc0AZvBq
	PMFetCVfVVHWw1DKdbyXc+tmgZABjvECW6G6jkmR+xZThQcTAhUrGB59Hd24NwHYaUMU3oGn1jP
	FJog==
X-Google-Smtp-Source: AGHT+IGJAZ6uHcOWOLQaSpdZ1qWxs96vsf6ItXLuU9Ixu0j7zWif+94N5x9KF8/Yci3IhgX2aWIb5Uc4xOPfJ0II338=
X-Received: by 2002:a05:6a21:6d8a:b0:1ea:f941:8da0 with SMTP id
 adf61e73a8af0-1eb214e52damr44143662637.24.1737743678431; Fri, 24 Jan 2025
 10:34:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122022838.1079157-1-wutengda@huaweicloud.com>
In-Reply-To: <20250122022838.1079157-1-wutengda@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 24 Jan 2025 10:34:26 -0800
X-Gm-Features: AWEUYZnrGsqF-qRkGPD6KeXPqrc-ujQXQrXXjbU6id4tZallPXIubvuDEN0Qb7o
Message-ID: <CAEf4BzYzqx_08Sg2YMf+ossSDLStWg2US0j7ohBWjTRxv44FqQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] selftests/bpf: Fix freplace_link segfault in
 tailcalls prog test
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	hffilwlqm@gmail.com, leon.hwang@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 6:29=E2=80=AFPM Tengda Wu <wutengda@huaweicloud.com=
> wrote:
>
> There are two bpf_link__destroy(freplace_link) calls in
> test_tailcall_bpf2bpf_freplace(). After the first bpf_link__destroy()
> is called, if the following bpf_map_{update,delete}_elem() throws an
> exception, it will jump to the "out" label and call bpf_link__destroy()
> again, causing double free and eventually leading to a segfault.
>
> Fix it by directly resetting freplace_link to NULL after the first
> bpf_link__destroy() call.
>
> Fixes: 021611d33e78 ("selftests/bpf: Add test to verify tailcall and frep=
lace restrictions")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/tailcalls.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/t=
esting/selftests/bpf/prog_tests/tailcalls.c
> index 544144620ca6..a12fa0521ccc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> @@ -1602,6 +1602,7 @@ static void test_tailcall_bpf2bpf_freplace(void)
>         err =3D bpf_link__destroy(freplace_link);
>         if (!ASSERT_OK(err, "destroy link"))
>                 goto out;
> +       freplace_link =3D NULL;
>

libbpf will free the link even if bpf_link__destroy() returns error,
so goto out above will still cause double-free. I moved `freplace_link
=3D NULL` two lines up to avoid this. applied to bpf-next

>         /* OK to update prog_array map then delete element from the map. =
*/
>
> --
> 2.34.1
>
>

