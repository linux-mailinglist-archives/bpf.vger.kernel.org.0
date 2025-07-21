Return-Path: <bpf+bounces-63958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E41E1B0CC9A
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 23:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A29189F6BE
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 21:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1013E23F413;
	Mon, 21 Jul 2025 21:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz0Ybxet"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455762236FD
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753133380; cv=none; b=HliBsBSdD1jYkrS3hSFDNW3ZPjMEDNOaVmvWM2Mpo0GgGUzJMBL96X6ZuEw6DEe/mOpOOwEfGNZDwOOFCkpvcp9pimCxgF4NdRUs4RV85y9medJl0B9cPT3BUt3Ff3GuuOjcQGjn1ks9vEcYGUSpekd0L6vI0efRfp3Tx1gfRYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753133380; c=relaxed/simple;
	bh=u38svJZK85xfzoHg7U/AJ7fjlvicYBDGIG3rI6xv3/Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i8/gTF6g0QyBDxfHJeAOAMpK0Zvt6OvOkcY2ThYRHtlo2lM1LC7oL2TNzACh2XMCr0ocUcXHc10DZPEpd2EqLrru/woEmvX/R6cmTAw7QfedNLdmZa+jTZCeu0Xs32V6DRP7aI5gDJx6j5ya9lEbbqXoM7N2M+jMaDAuI4qBxxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz0Ybxet; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b3bcb168fd5so4003753a12.3
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 14:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753133378; x=1753738178; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0EKnRlpC2+oBJX4NEAeiVW9JeXCAkyyUdklm4GDqkkM=;
        b=Jz0Ybxetx2Hhe+YIV6mBGyd6J2+5b6yBX914Kpz5T6f++N/Agillv7LnvjgvEbwlml
         1jn0M9z4XL16VpBQjV6erXrSU5WlkLGpEYO3rRWdfzHQE0RSOF6JuafsanhMCKRmV2xv
         mTgtG+fcOPKoI3VHuYerEFR5bkGrNVJmX+7EsZEbjYOmfPG5BvL4qaylKn7cg4SFQeAv
         4bH7sQszhuApCEJ2JUJ1XovCWBqaZXrcpCsQ41a5QTymKGUHES2YtzJpLuYBy0Q0ALcH
         uV3FP2SS1fivWezXdFSo6sZ2lzxi4CTLc15bB1F+PX+TyoBqg3KGbaDib+Azim1q50eb
         udFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753133378; x=1753738178;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0EKnRlpC2+oBJX4NEAeiVW9JeXCAkyyUdklm4GDqkkM=;
        b=tECxxbSs4T7sP7/xBkL9dgQzCn6FbL9Snl/GS/y5hb/sBKBjvJz8zuV0fOWasblSDm
         XuTRnyfDrTHAO+nfRBfwfCVRAT5hrV3vjumb5Hd+3zqF7mTsvHOlLzKFxVodQUXd1u/2
         m3vFMI4+MebYknzpYMSl+gUbJxThPJZn20wnbz2lpKiPRArES3YBTx2+YWQFZZ7fa/OF
         O0NfBl4Dkvu0Io/ikyVjAyTkEtp+E2JCg/qRx7F7AG8rzjUIUrEyOnWJ0UqN0R6kj6Fz
         oL0h2GF2uJco8i/xJzsdSOgRX40FDzl5OZJ5lmndzCMpQ7BTpbRu+SJNn6+z3XRDdewY
         4PyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa/t2KmGQDqVMIYiX+VHSHASYw1YxANlj/wFh1ka0vbTrZ3zKeIfHmeL4zVrAWC4bAJGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm48SGKjpQFj5PdoxK6z8naiI1mOS9j5pfCtIRkXvKb/Qr4lvb
	1M75S+G1v5L5qsneQc1rBO6cQS40278f82r5IbGdINzMVZIY2Ro3+0LvN9RYUNt/
X-Gm-Gg: ASbGncuNPzHd4aoF4039xcZhxtNl1LuQ6bE+9h2RZDE8Ogq9/742VKGj9HCxOBNl7jD
	S7MQwVOsOZgnEfnDsm+VkXxF8o6ffjHSTrynwtD89UTjnlSSpN8eHTjsHT7EAYRv6xJbuR35i0x
	0W39ihRDZRg8R4e7j2Xk1HiGadV+gZGbOaqrfufb+pzMmDyQ4zhHerFnmV1dMB/XymbCB/CJtL/
	Cy87R/0cst6HYSBq5N/PQGJmGgU+3mMI5j8ozVYsAUp0lzDHynp/PCVW91JrSwWwE3FQHtKNQ5d
	cYT9qOTP2rhg1n5SugsvDnqZJ4w+kUgfoPM/qq3m0zKh94aMFzC0iD6qxHCgTyOHEGmPQZMO4ub
	tJ5IjPSGBu8G6bKMKvUTquVhT9UtszeTHHsNlsbk=
X-Google-Smtp-Source: AGHT+IGTIdAz1QbXlkjTGKZU9lo041rJa7+MG2AmtNfG1u38/RfM2XQlreuw+vzVPSmMdKDKaIHT/Q==
X-Received: by 2002:a17:90b:3c10:b0:311:ff02:3fcc with SMTP id 98e67ed59e1d1-31c9f44bcd8mr33150481a91.14.1753133378543;
        Mon, 21 Jul 2025 14:29:38 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:7203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e40d7c600sm20785a91.2.2025.07.21.14.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 14:29:38 -0700 (PDT)
Message-ID: <274ef31c1c14226065ea2a74cb0c900b7ec085cf.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Improve bounds when s64 crosses sign
 boundary
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>
Date: Mon, 21 Jul 2025 14:29:36 -0700
In-Reply-To: <d5be66c893ee61f7ceb9ac576fd92a3ecf7d0fa1.1752934170.git.paul.chaignon@gmail.com>
References: <cover.1752934170.git.paul.chaignon@gmail.com>
		 <d5be66c893ee61f7ceb9ac576fd92a3ecf7d0fa1.1752934170.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-07-19 at 16:22 +0200, Paul Chaignon wrote:

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +		/* If the s64 range crosses the sign boundary, then it's split
> +		 * between the beginning and end of the U64 domain. In that
> +		 * case, we can derive new bounds if the u64 range overlaps
> +		 * with only one end of the s64 range.
> +		 *
> +		 * In the following example, the u64 range overlaps only with
> +		 * positive portion of the s64 range.
> +		 *
> +		 * 0                                                   U64_MAX
> +		 * |  [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]              |
> +		 * |----------------------------|----------------------------|
> +		 * |xxxxx s64 range xxxxxxxxx]                       [xxxxxxx|
> +		 * 0                     S64_MAX S64_MIN                    -1
> +		 *
> +		 * We can thus derive the following new s64 and u64 ranges.
> +		 *
> +		 * 0                                                   U64_MAX
> +		 * |  [xxxxxx u64 range xxxxx]                               |
> +		 * |----------------------------|----------------------------|
> +		 * |  [xxxxxx s64 range xxxxx]                               |
> +		 * 0                     S64_MAX S64_MIN                    -1
> +		 *
> +		 * If they overlap in two places, we can't derive anything
> +		 * because reg_state can't represent two ranges per numeric
> +		 * domain.
> +		 *
> +		 * 0                                                   U64_MAX
> +		 * |  [xxxxxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxxxxx]        |
> +		 * |----------------------------|----------------------------|
> +		 * |xxxxx s64 range xxxxxxxxx]                    [xxxxxxxxxx|
> +		 * 0                     S64_MAX S64_MIN                    -1
> +		 *
> +		 * The first condition below corresponds to the diagram above.
> +		 * The second condition considers the case where the u64 range
> +		 * overlaps with the negative porition of the s64 range.
> +		 */
> +		if (reg->umax_value < (u64)reg->smin_value) {
> +			reg->smin_value =3D (s64)reg->umin_value;
> +			reg->umax_value =3D min_t(u64, reg->umax_value, reg->smax_value);
> +		} else if ((u64)reg->smax_value < reg->umin_value) {

Nit: I'd add a drawing here as well:

		 * 0                                                   U64_MAX
		 * |              [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]  |
		 * |----------------------------|----------------------------|
		 * |xxxxxxxxx]                       [xxxxxxxxxxxx s64 range |
		 * 0                     S64_MAX S64_MIN                    -1

> +			reg->smax_value =3D (s64)reg->umax_value;
> +			reg->umin_value =3D max_t(u64, reg->umin_value, reg->smin_value);
> +		}
>  	}
>  }
> =20


