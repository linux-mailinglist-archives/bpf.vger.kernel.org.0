Return-Path: <bpf+bounces-20760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFF5842B86
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 19:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432141F26710
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C50156968;
	Tue, 30 Jan 2024 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB7NM3u9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC131552EC
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638471; cv=none; b=D/L0tDlQLZvjI6+xsS1X0YUuzn/0DdhGRC1tNMkWz+QZTWzn2/a0w+uyQACSiHVog0CBurK9j/5GavQAvO8FEX/nKIonHnUWfAH35QvmQOYwtuGhgJOf6h6Ja8mp5dHxlBRpp0fAszT/3faZWuCxY9CuovVEWM4J3t8WN4VXuh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638471; c=relaxed/simple;
	bh=Kqy1xsiI6NbCSyeG3HtehvfKjJyHlocMaYgyfD3ZTd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pldO8MWrE2Bht1PlKoGUHm6c5xGX1rF+P0q4gkuf+Q300vpVMnDtPGMwNrMdKWz/GHvC9/DZFrsIHcvTLwq5sHeOw33CTjLFbGmFRw0cFcfTRPpiVCyXk88bf2AAGLp7/xyjbDQcuzGOm3odFjvAhB6MuPzBVFiRx80UemwEspI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aB7NM3u9; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso2113783a12.0
        for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 10:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706638469; x=1707243269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1TJgia2lRqLhdQ5NLWeCsYy+FHNwRqmbUx7xZSDWHU=;
        b=aB7NM3u9kJzRsTtmfdp0CBSS8qVSePDWwvKvyKU4GzDzoMdHWvaggpHA/LdaOkCNht
         gV/TaekEhfepgtJ2bEcSDMm1VHcymlTuuY1OY73t7cBm5mD4WLE1gonjhHM0ZFv+fh3Q
         Yo/LNxlfsMTmrZVRXKRLRYbIBsttzXBJu/y7sMvKlSH8vPDmtiTOsJtJgjuvwCkD56fY
         zursmddrDxlQA5mbQ8Xw2T1H+EshlmK1ypv3Xim4KT6wRxC9AX76HOJa9sMiBT4wlvfq
         gencNElHA2iOI4xmviVW4iDjv63KkwZLLVJm+3zTkNPZ+i/CD8kX+K/+41ZuA4OdgoC/
         ge0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706638469; x=1707243269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1TJgia2lRqLhdQ5NLWeCsYy+FHNwRqmbUx7xZSDWHU=;
        b=xRASJhtzfu/YKH0kfB13GPHwUaIlwytJsPaqvlEFjTnddQt2Ol0euYLHWy6rV+CSiP
         AcxZoFl14InV/ynpSrE4LJeLs5lru4XdAyLjZ5zQqCrQ+2dpVLgsh/DH6K8uJH5v5FED
         XtlHN+/zYJAPg4weYfFab3kpYtEnj6qDw6+Rhbm5LsspB4ib2EyDlcyjONpdICtb/3cY
         3UQf0z1lZg1O8wYlaTP3CCTRSNJ5o9hjGjf/CPx+NRqxZUB60ZN/QpqYCQKQ8BQMbRay
         ViIbnpBQLKqYWfoTzmIxDe9JVyE8FZ5LgK0uFC/GGx0jkYHP74q+4TsaqhLxi4pZzNsd
         l9YA==
X-Gm-Message-State: AOJu0YzBazOSXA42cXEHVTDOsBROajm+YP61IEtwFZHP5hVK/YvJQ81u
	PtGlXq32so+xQRhB5gLu/EYu0kUY/ZtM57wk56jQK29tKb/HEKYut/gyS4G53nvMKRdf6CZ1429
	mQ1RR4vrrgeSzmDHLqcZuifdWN84rIpfC
X-Google-Smtp-Source: AGHT+IEMNkpQLfqgjud/MQzE/u4/WOwLSGRLYg0Qf8m0lJaUw93FCZOcSSCVtvu1S4movavlcWMy8gloyQ6RbPzm684=
X-Received: by 2002:a05:6a20:bb03:b0:199:29c5:12f7 with SMTP id
 fc3-20020a056a20bb0300b0019929c512f7mr4866426pzb.29.1706638469185; Tue, 30
 Jan 2024 10:14:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130143220.15258-1-jose.marchesi@oracle.com>
In-Reply-To: <20240130143220.15258-1-jose.marchesi@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 30 Jan 2024 10:14:17 -0800
Message-ID: <CAEf4BzY73K46a=VS-5M45H0abfqt1XCTE9vRnuuGn5rq65ibmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: use -Wno-address-of-packed-member when
 building with GCC
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	David Faust <david.faust@oracle.com>, Cupertino Miranda <cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 6:32=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
> GCC implements the -Wno-address-of-packed-member warning, which is
> enabled by -Wall, that warns about taking the address of a packed
> struct field when it can lead to an "unaligned" address.  Clang
> doesn't support this warning.
>
> This triggers the following errors (-Werror) when building three
> particular BPF selftests with GCC:
>
>   progs/test_cls_redirect.c
>   986 |         if (ipv4_is_fragment((void *)&encap->ip)) {
>   progs/test_cls_redirect_dynptr.c
>   410 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
>   progs/test_cls_redirect.c
>   521 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
>   progs/test_tc_tunnel.c
>    232 |         set_ipv4_csum((void *)&h_outer.ip);
>
> These warnings do not signal any real problem in the tests as far as I
> can see.
>
> This patch modifies selftests/bpf/Makefile to build these particular
> selftests with -Wno-address-of-packed-member when bpf-gcc is used.
> Note that we cannot use diagnostics pragmas (which are generally
> preferred if I understood properly in a recent BPF office hours)
> because Clang doesn't support these warnings.
>
> Tested in bpf-next master.
> No regressions.
>
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: Yonghong Song <yhs@meta.com>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: David Faust <david.faust@oracle.com>
> Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 1a3654bcb5dd..036473060bae 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -73,6 +73,12 @@ progs/btf_dump_test_case_namespacing.c-CFLAGS :=3D -Wn=
o-error
>  progs/btf_dump_test_case_packing.c-CFLAGS :=3D -Wno-error
>  progs/btf_dump_test_case_padding.c-CFLAGS :=3D -Wno-error
>  progs/btf_dump_test_case_syntax.c-CFLAGS :=3D -Wno-error
> +
> +# The following selftests take the address of packed struct fields in
> +# a way that can lead to unaligned addresses.  GCC warns about this.
> +progs/test_cls_redirect.c-CFLAGS :=3D -Wno-address-of-packed-member
> +progs/test_cls_redirect_dynpr.c-CFLAGS :=3D -Wno-address-of-packed-membe=
r
> +progs/test_tc_tunnel.c-CFLAGS :=3D -Wno-address-of-packed-member

Why Makefile additions like these are preferable to just using #pragma
in corresponding .c file? I understand there is no #pragma equivalent
of -Wno-error, but these diagnostics do have #pragma equivalent,
right?

>  endif
>
>  ifneq ($(CLANG_CPUV4),)
> --
> 2.30.2
>
>

