Return-Path: <bpf+bounces-35950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FC9940025
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 23:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A26282C56
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 21:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E1C18D4B0;
	Mon, 29 Jul 2024 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCz/4CH1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68C618C35B
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 21:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287366; cv=none; b=MMmp66qrbYZrjgSaLWuezXSDzN1shuY7icNSM+UTRLqFBtZcR2gN9BgDqDCoU4b6z8zpq95pbsSCGcpBZqumoYZzdorcfVyVjSxcIJzcWoTgQZlI29zKQQtsdeihvfCEJuzBhQ+sW8qPMoJR1+XlIFfrAO9YFcBSl5Ca2UbR1fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287366; c=relaxed/simple;
	bh=TmK8H7y4E4DlCyykOkzNTtMIhvG4YJtNYse+VXs4Aug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ij/aRE9ZI5jtMXiG5UIcPACwg/irdz0Gy2xjata+5ViJZfIjiwFZFIc2inM+aYhVr7FADqWrHu9IQnddzlDn5rZ8jtLcFJmS0ljkM6vqjFw4PJtC9Dp7ePwYR07Om4x/dvGIy8j9v0/ioZiTrSQ7TJgePHGudt12F9ltDk8/ggM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCz/4CH1; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cb4c4de4cbso2300637a91.1
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 14:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722287364; x=1722892164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNZolaaMOdzPh6A1hJ7oWAinPhqUHEmMp1xqcgcTYzU=;
        b=kCz/4CH1jRtEV1UmoynJBEiMlXZTpMt+OVWRO4Rw5DYCH0UWJdfDuOChVP/psPyDSh
         LiBgJa1+nTu0FZIfNYI1ISk+MPGu+iaEbYPJpTeblS+KnhCu1e/7uvwcZP30ipR2HT1M
         3RL0YF2zYdk9WeqtxopmDe4uVa4V83zcU8VkFYzYz72gQ81NfonVUIcszJZs8TFqYzCz
         osGgMo7nfc1qCaig47GertgT1A0M9lRToxX9lgdg6LGfNIvmntTRGhAvMqBV6CLjiVWl
         RlFcYhiQM1JHelVZdqnOXmU26/hCsg+F094ceaw0+W/HYBPP5OXKC+TDWFUz2j6+qCgx
         FVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722287364; x=1722892164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNZolaaMOdzPh6A1hJ7oWAinPhqUHEmMp1xqcgcTYzU=;
        b=CJ9ao002EUYC5jR6hSTNNUdoOCrLGTvEzLXnzP0JAIGD2wVjwLvGoE6k9PV+b+6MDO
         GQEzIOdnIU5y6YL4SJk8xs9wNTGRYU0G17dRe35eThEt0T/GqVOyJIZEGAL17kfRw8hk
         +hTJcDG6OSMWHEG7nFhU0igp8IjhwGpnYPG9t7qwCc7v1wTnqS/f56Lih1ntEKNPZLTD
         2ra24XRn8SC5PEVDlFO0sPmkQbzc3pztP1LR1A7y/2mzv3kngXJ/3J8uqEIukPdd0Y01
         puDCcJX2Ez0s2y3V7ituGQXN49bqo90/AqkA5hYH+apxwLNfNaxZgDlwjTohhUfS4uIV
         xnxw==
X-Gm-Message-State: AOJu0YxaAubvQCXoPd31mWhMgPr7/zLR9O3Ov3trKQTBg7Ejh0hCvxfv
	nkm42qjU7rcIfyHjEbno+Hequfg4IRxAcWDYaTH7vD7bL1SF2bPO/b2FlkxpK5TAx5ryt9jTUgm
	h7Fm1adSlNaqon5hKfpHWt1iUof6nTA==
X-Google-Smtp-Source: AGHT+IEy5JCEQvILDPvESnpwjtgswI/wVwW558l+8Ym+gmvzjPTDTDLTPEfMyFCLqCqfwAs3qX90sj5s2zY59oSgO/A=
X-Received: by 2002:a17:90a:d708:b0:2cb:5de9:842c with SMTP id
 98e67ed59e1d1-2cf7e1fba41mr7116916a91.25.1722287364048; Mon, 29 Jul 2024
 14:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728202853.87641-1-sergey@lobanov.in>
In-Reply-To: <20240728202853.87641-1-sergey@lobanov.in>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Jul 2024 14:09:11 -0700
Message-ID: <CAEf4BzZ1Nd742GOi_GeM_sSmTURSV13Fex4EuULXjiwp-whvcA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/1] libbpf: add an ability to delete qdisc via
 bpf_tc_hook_destroy from C++
To: "Sergey V. Lobanov" <sergey@lobanov.in>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 1:29=E2=80=AFPM Sergey V. Lobanov <sergey@lobanov.i=
n> wrote:
>
> bpf_tc_hook_destroy() deletes qdisc only if hook.attach_point is set to
> BPF_TC_INGRESS | BPF_TC_EGRESS, but it is impossible to do from C++ code
> because hook.attach_point is enum, but it is prohibited to set struct
> enum member to non-enum value in C++.
>
> This patch introduces new enum value BPF_TC_BOTH =3D BPF_TC_INGRESS | BPF=
_TC_EGRESS
> This value allows to delete qdisc from C++ code.
>
> An example of program compatible with C but incompatible with C++:
> \#include <bpf/libbpf.h>
> int main() {
>     struct bpf_tc_hook hook;
>     hook.attach_point =3D BPF_TC_INGRESS | BPF_TC_EGRESS;
> }
>
> 'clang program.c' is OK, but 'clang++ program.cpp' fails:
> program.cpp:4:40: error: assigning to 'enum bpf_tc_attach_point' from inc=
ompatible type 'int'
>     4 |     hook.attach_point =3D BPF_TC_INGRESS | BPF_TC_EGRESS;
>       |                         ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
> 1 error generated.
>
> The same issue with g++.
>
> Signed-off-by: Sergey V. Lobanov <sergey@lobanov.in>
> ---
>  tools/lib/bpf/libbpf.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 64a6a3d32..494f99152 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1257,6 +1257,7 @@ LIBBPF_API int bpf_xdp_query_id(int ifindex, int fl=
ags, __u32 *prog_id);
>  enum bpf_tc_attach_point {
>         BPF_TC_INGRESS =3D 1 << 0,
>         BPF_TC_EGRESS  =3D 1 << 1,
> +       BPF_TC_BOTH    =3D BPF_TC_INGRESS | BPF_TC_EGRESS,

BOTH implies there could be only INGRESS or EGRESS, right? But what
about TC_CUSTOM? I'll leave it up to Daniel to comment, but something
like BPF_TC_INGRESS_OR_EGRESS would be way more mouthful, but more
correct, IMO?

And as for C++'s woes with enum, you can always cast, no? Ugly, but works.

>         BPF_TC_CUSTOM  =3D 1 << 2,
>  };
>
> --
> 2.34.1
>
>

