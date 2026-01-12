Return-Path: <bpf+bounces-78600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFDAD14575
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 18:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBBD9307FB2D
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 17:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7EF376BEE;
	Mon, 12 Jan 2026 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="gOuzbzWb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F3D37416C
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237555; cv=none; b=W415akh/p4Z0026odzmZUiPqPpBbwP5+IvR/Ckzg2R7i4XSdrJnfR+HC8gGpNYLz8IDmXqVGFbQYk1q3pqbvMCBTiPymko/eFnlB+d21FbOI/zyf+gTFAEXbreOhMYU4WtvH4Q70Y0SEkJi5NsZ8jeuUutlvLvk7s6JDAAWk8Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237555; c=relaxed/simple;
	bh=RGpJvx/8EZqp33yxXMiMAIHbf5TRd0zycdNoVI0DJqk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=LrO+uAR5VAI5O0kNSc45s1BiOp7MiYqQk5moAvE3g7yCDSeC7EAldJFEeAJ7cA/84gO2Zsr8SRxtGUc069bcgED5dZU1ydmtQkUzjSgdbuminFwtOmTWW9ht87CxNylUFrvWHAbzynoa34CFimIe0OiZdPP20Y/7xy8UurhUSj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=gOuzbzWb; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4f4cd02f915so49047651cf.1
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 09:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1768237552; x=1768842352; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqfe9suitCm3S7uQRbOYXDrbNeaPrrhougrlTGvIg7E=;
        b=gOuzbzWbBXINQq454OIMoo1kjyDrI3LADFUm3dJEh5ZrqlHzAZ4rUSODBTb5GzVRiu
         soYQ7ym/FesNf5hQF9u2+tzhyXKhzK/W7S1+q8ioplkDDJAgy7tO9t7EiesltDlVhfJx
         tLBJraRmtyjSOtCoeuNUwVPLwFs75leFRLeLxXiKsALp3CmaBke9y+/zLoaqkNgJRpzM
         W4OwOGVNLMJkdQn6VNZm/J6QKWh1nlJGWEnSSTpgZPuk5Dgj1teTrJZRQaKpqQa7DQox
         hVFxgAvWx8/9thulZNZHG7FtyY43WKXj3W+w5J2NAXlUxmDyUYI1yeLedZT3urlAKWL+
         J0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768237552; x=1768842352;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jqfe9suitCm3S7uQRbOYXDrbNeaPrrhougrlTGvIg7E=;
        b=t6mNv31VxHjrnGa9a9YnB8vrrWwvvfACG0N28kU+Wwnxu0OT4/YszVAmtABsRvq/eE
         dC9RuY3sq1JIhdkSHozS2She0TvK6oCxrDenNpRfE62ixkSIT6oUYnvmcJMEE9xwYphW
         Y6QWJxUt9RDlQEFTgS9p3dPImNAOFlIQJVRt4mgONwDr7DTxDYeXFgnMoelWZbMiLZF6
         Uaq2wxiqQlecaYaEyqHNqhJfXdLhyAdwuoLljGU52EqSBQeZoId7fWVYo+0x+6IBX5y2
         8hl4jiHFoSrlAOJVWIeLRKfHBLq5m5eTwBMJXrO8pwtOAof0L9OkxdSLpYODCKA8t8yh
         Wk7w==
X-Forwarded-Encrypted: i=1; AJvYcCV6v/VLDGb78rqEl5Bf2KthZIY2TZw7Uwqz6N+iyInVwoMwf1xkXiZUBFFgRhKLDZ74GmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXw5ilQxZP/12SN326pJt9RN8OnVt6H6YikY/ru1EBN/m/QDuH
	HER1VpaLfLZPGS4hyWL9XqOf1fLCfrqvWnyXJCDt0yKPz/qEzni5Fb5rnuDxT5EIb3Q=
X-Gm-Gg: AY/fxX6m3Wf/zgn33Il/qOodHYGMsdvLnZQ/fOzkp2ZT95q4ehd4mZlT+zVHhIpwXzN
	wfVpWMdombLg6objW0sWG2YR/plAZtIKaCtmwGwCckV/fqJPx3bpaEAOlX//Ihorcyc/1pxaajH
	8BLQr0v0UKGU/1T/yIJqb1uaU8cpo8vnmk7R3CvL9s8C9ZwThb+h7YRDsVdtrtrRq/3GjtiwjMY
	0uAvFkq3tLcIPK6x4GsQZ0RoZwzHK9RtOgjreYvxqKG9psLC7KKYTOcwLg1UYAKOMeWJRk5cVP1
	6jMNQ3fwrlDIvWdwE3CrMFr3hSBkPqJ4u5m1zF9S0qRFxo1+GM+PcTaE1WAzLRohxZj9nsuyK6G
	ial/JH8UPuuUBmSdV77rVbA8rgxu4Fib+B40tUlioyOekaWMXuCiyLGzJ0urcm6hx9N8M33BQLQ
	DInPk7Jg1Nq+g=
X-Google-Smtp-Source: AGHT+IGVfkvyU3rX0uK2NCWNdX4/fv+g4vlcfF6xA8isMWrnrwvCuMuLt7Gv9MgXultV5uFNl2gVYg==
X-Received: by 2002:a05:622a:34b:b0:4f1:ea19:da with SMTP id d75a77b69052e-4ffb4a44725mr252705761cf.41.1768237552094;
        Mon, 12 Jan 2026 09:05:52 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e36287sm124826991cf.17.2026.01.12.09.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 09:05:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Jan 2026 12:05:50 -0500
Message-Id: <DFMRWCMZ9M2K.3AW08WLJR8NDR@etsalapatis.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: insn array: return proper address for
 non-zero offsets
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Anton Protopopov" <a.s.protopopov@gmail.com>, <bpf@vger.kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Yonghong Song" <yonghong.song@linux.dev>
X-Mailer: aerc 0.20.1
References: <20260111153047.8388-1-a.s.protopopov@gmail.com>
 <20260111153047.8388-2-a.s.protopopov@gmail.com>
In-Reply-To: <20260111153047.8388-2-a.s.protopopov@gmail.com>

On Sun Jan 11, 2026 at 10:30 AM EST, Anton Protopopov wrote:
> The map_direct_value_addr() function of the instruction
> array map incorrectly adds offset to the resulting address.
> This is a bug, because later the resolve_pseudo_ldimm64()
> function adds the offset. Fix it. Corresponding selftests
> are added in a consequent commit.
>
> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/bpf_insn_array.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> index c96630cb75bf..37b43102953e 100644
> --- a/kernel/bpf/bpf_insn_array.c
> +++ b/kernel/bpf/bpf_insn_array.c
> @@ -126,7 +126,7 @@ static int insn_array_map_direct_value_addr(const str=
uct bpf_map *map, u64 *imm,
>  		return -EINVAL;
> =20
>  	/* from BPF's point of view, this map is a jump table */
> -	*imm =3D (unsigned long)insn_array->ips + off;
> +	*imm =3D (unsigned long)insn_array->ips;
> =20
>  	return 0;
>  }


