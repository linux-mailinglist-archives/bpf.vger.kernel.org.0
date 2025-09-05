Return-Path: <bpf+bounces-67629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EA1B4658E
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF41A1C81833
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526A3280325;
	Fri,  5 Sep 2025 21:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzvKl6Ts"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E6E2EFD98
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107917; cv=none; b=rE6HjB0FO16RanNvPE03FeUyir5HP4LAtp+p/7hQ8tIZz0yXaPy8Zbz/AgINxWsv/wAzEQs8rrZWzjLgvP7J9RPbaD3wxuqkrtYuh8KFWge7ODB0/ROTl5jGAMlc1RpTdsKeZMaJnt+UKML7sbNnqrhnnWHQJN+58BkB2kRtIS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107917; c=relaxed/simple;
	bh=z4tvDP1mEIgEeF6KkK5lKDdKjpxo27HKvT6OMoqWdmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqePsV80LlWz74quPXSUFH5UgMr+WFSwylr81KC+JoiNue/DQI4b2kND9TO8ttfFGNOcLRcKGz3GIx3PvV0Rup0+c4LGBzsGzO4lcfzZOI902ZvPMQbkcsPkBq/HcstHe0Ej35hd32B7SiyFqJBMkR3JznXSDrvJCN41U6Zz/5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzvKl6Ts; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so2110807a91.2
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 14:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757107916; x=1757712716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DumsnFaAnAFkWDED2ynYRPbCzobgGC4xeOM1E/S1VXA=;
        b=fzvKl6TsyclPkF0L4PnyJNT1M+5Wq6Vo+7ii5uxsURN6rsd1qzK8Anez55N9Rue9LW
         g7L5WTIEJK50qbFn9rXDsuJmQWU19JVv0W6CUnVVxEf1sdEhxYffbUDt7/TFy5uz4fK8
         HPqisTjWW9w/nWchRgJ9jEgw9fC4kY9LVJKNO4KYOZqLMtJFOjpZs21zTU6vv9XRBK4h
         6GX5/OojmT2evbVRIpfbaAWVu4wt+4NcwqY96EIPJ/3gHD7v2gk9h1cxeNwt+/vZ5jea
         iBX7j3WVNJJvMCo3z6K7zWFQGWVdggFvHOJik+ihJCYW1+fva5Krir4APAs2B4vc+JId
         bulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757107916; x=1757712716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DumsnFaAnAFkWDED2ynYRPbCzobgGC4xeOM1E/S1VXA=;
        b=VD6xECMMGr2gHFhuy78HiuOwzHhQHzlG/QVAN7SJQHCe+0nY52+Oi1m0kkxCq0H2kW
         MdC2x2Jj3oRxFufAoN/QkVjb3ZVQKAj/5hWBGeljVSXwTn7TxbZGbd/D7gLcsxnV26mt
         yM244DIVe10ZPLPzs5yqh8f/A/c3XIfyZlS95bK3OGy2zqm8XFpjrn8dzSF/EhreosVq
         YzmPg9DsdAZ+dsn0bQKn6doGNAMQmPZOuAjo3qQKlGycib/tqsCapr7wCQO9NUd4pJ5K
         kOZGIoZYDAJKLL+vTSqjRNxifAXy7mBxa6qqOhb90R8UmmsCUkzrdvki9qoZZFIpL6Zx
         5VlA==
X-Gm-Message-State: AOJu0YxYHfR+IsOm2qIZQPL/8NgS4awa2BSbxMNUmkrVyO4t2NqIq/pu
	Vy1g69EGDK+P0mpFoSrldI+9qbVB2pPdBls/Emzd+JggSRrGuOFnu7iNCou5k012OF+MgJgMEPu
	H6XVh/S0p1+SrKbqKY70PbtAYGfjr4o8=
X-Gm-Gg: ASbGncvIsS60te9YlrbVizvdMQkvpHhHTXrDCrU3U2lfMCD70PTUVFyIeKONfiDINr4
	eOyhbNFFKXd8SWM7fAtekY+EiKWIltKkY0/DCAkyzglIzAOrF7qvvi9gl/5AyhJG6HVQwy2dOBe
	EWouVhmRluIc4XM006tqbf/plCZ/hUHm5WBI3XvJM6ifCfXZWxMo9fNrbjzjn+w7QM8m+hbDwgZ
	pqr
X-Google-Smtp-Source: AGHT+IGdetht1gRuSIYAw62CqS5GXHrjGX8iBm7+ptAgek1sWZ7XK93L8ryQuBzUaiWD+v7E18RX3MvvQgyBdpQd100=
X-Received: by 2002:a17:90b:3ec1:b0:329:d85b:d9ee with SMTP id
 98e67ed59e1d1-32d43f5bcf9mr415768a91.23.1757107915694; Fri, 05 Sep 2025
 14:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com> <20250905164508.1489482-6-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250905164508.1489482-6-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Sep 2025 14:31:38 -0700
X-Gm-Features: Ac12FXxuRcCFwAee0eXsiCXJQDKczPC54W1Yx31UzLixWG2weeTqKzH2kAtV1FI
Message-ID: <CAEf4BzYnWe++L7Mh3zTU88kQAQOy8XY_pu4v4kDhFMFmVXgd_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 5/7] bpf: extract map key pointer calculation
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 9:45=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Calculation of the BPF map key, given the pointer to a value is
> duplicated in a couple of places in helpers already, in the next patch
> another use case is introduced as well.
> This patch extracts that functionality into a separate function.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/helpers.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
>

lgtm

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 89a5d8808ce8..109cb249e88c 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1081,6 +1081,18 @@ const struct bpf_func_proto bpf_snprintf_proto =3D=
 {
>         .arg5_type      =3D ARG_CONST_SIZE_OR_ZERO,
>  };
>

[...]

