Return-Path: <bpf+bounces-33583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF8691EBE4
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 02:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B054F283598
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55884523D;
	Tue,  2 Jul 2024 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7vfi4vU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9020E846D
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 00:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719880937; cv=none; b=Lq1kqEnwPIZF/WmdIfDNQ0aJ3UlBLzANhB03US+cCrUDPmzFoNuNfVmRvc6fXNkW34rc8sADWCZRf3M/K0OUxGLvkr+W2b0iN0pv9Sx/379Znr4q/to0sPapXWz3gJiWQxX7iR+0xKgRQUmIcV13lvWkRKjm000rI420/0O5d2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719880937; c=relaxed/simple;
	bh=X0ABhzi3Z6Kil6kaM5T2GQMhZrjJhRezbOn+XJ9kkbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCVZrQ16QOE+OutmvlbvQHMtaGfop7y+Rny0PCIySmiZmigu4jg20avyJKgDBJIjeHWWWiyv5cXJPaUnrx7VjPFrEvp/XV/RQFQJLIKQZ6zK+EOCBYgxmh7bR+HeIeHmikiSrbJ9E3uSeSPttj2fe46uEtNh7clZb+QID/PtfUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7vfi4vU; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f855b2499cso2161295a34.1
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 17:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719880936; x=1720485736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrlGJsCPJkjnKPVXpsmPt0wOnEllKNAuNVW6jCmA2Ck=;
        b=S7vfi4vU/duyuMZAvE9JKv7jEPHbmeEow+DIxEibtMKKXkYGH3zO9il2xQkZuNc45G
         hxkkcUj24zJqHJpKa/R36WUtnqAY7nswls3lQEclxolVd0XqELpaIw6SBXJnAfVYngAu
         wwldrZ5vnYYufL+JTcqUmGc8YUS/4eCKqvMEMADFb6IFc/HLFk7MdkN+HbPu1YFUFXtc
         m7tel4Sl2dGpjjiJ8XkNhirhpHTGTJBWTehjK+qYQ2Sok9RaH/OB7tKsIM4OH3pfgi3M
         rNjqza1gBsfrqSEMeo61YW3J6iYnLc0XRcyBcHnsLp7TEEAlxH5Z9aPYdvTnvcsO7mVT
         YZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719880936; x=1720485736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrlGJsCPJkjnKPVXpsmPt0wOnEllKNAuNVW6jCmA2Ck=;
        b=pRNkfCwa2lSVcqCGyMr2Zf1eVfjzERjs2qO1sEo7bz/jrHwQRUMH8+vs1mxl4HKEbG
         9x9zL3MAbE0Wl9bnZrj/sD5vNcYyiMY/IWf+riDxRDEiQWqPFLqjtvXvJsf0/OVpj5Pk
         jILHbADCMjMdluDKsj4xhQeYp2zFnM9+HkLeLAWZsWFUBv6Uq2vaKu8c3TlfC9IFBGXk
         thgzMERr5aaXJj/acbo21YXEhTvfPVuT62my4O8XJM2Tb9r6T2FUm8iSiTRUEtoPYibp
         N/jPGso47Zr58cv/y3jtXXcezQUpL6H7GQ5UD2kfrdA4tWpg+EYMyr5sSux2StXbNrKq
         zXWA==
X-Gm-Message-State: AOJu0Ywmff8vqi1g+wVszg1KMxo+1av1QnuxMgdqQrxkGfRqtbvgNZwG
	+m8zJjT09O5Oh3gI2hE5xdMUBjFZDRFkr9xNUDPcs2kzHAs08MN6CrYAhAEWQzYLFFO5FlN0Lb8
	ozvRYGoSTKeFGQxQ6COembWMw+HU=
X-Google-Smtp-Source: AGHT+IFPybhe+fQfR+ioMl5Oyl7MHBKsxDgjuDKEh5g4z8XpXw3EcLH+nry1KvwxHXjzLaetq7o2R02tRQ36XGmq1II=
X-Received: by 2002:a05:6808:144d:b0:3d5:1bd8:ab1f with SMTP id
 5614622812f47-3d6b35ca42dmr11554115b6e.17.1719880935685; Mon, 01 Jul 2024
 17:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629094733.3863850-1-eddyz87@gmail.com> <20240629094733.3863850-7-eddyz87@gmail.com>
In-Reply-To: <20240629094733.3863850-7-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Jul 2024 17:42:00 -0700
Message-ID: <CAEf4BzYtG-6po-z7AvtcEnW_y963awzD-ShXowWOKsp2RRKxcw@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 6/8] selftests/bpf: extract test_loader->expect_msgs
 as a data structure
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 2:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Non-functional change: use a separate data structure to represented
> expected messages in test_loader.
> This would allow to use the same functionality for expected set of
> disassembled instructions in the follow-up commit.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/test_loader.c | 81 ++++++++++++-----------
>  1 file changed, 41 insertions(+), 40 deletions(-)
>

Just being a PITA below :)

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
> index ac9d3e81abdb..d4bb68685ba5 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -55,11 +55,15 @@ struct expect_msg {
>         regex_t regex;
>  };
>
> +struct msgs {

but then "expected_msgs"? It's not messages it's definitions of
expected message specifier (which is a substring or regex), seems
useful to preserve distinction/specificity?

> +       struct expect_msg *patterns;
> +       size_t cnt;
> +};
> +
>  struct test_subspec {
>         char *name;
>         bool expect_failure;
> -       struct expect_msg *expect_msgs;
> -       size_t expect_msg_cnt;
> +       struct msgs expect_msgs;
>         int retval;
>         bool execute;
>  };

[...]

