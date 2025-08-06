Return-Path: <bpf+bounces-65159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDA0B1CF44
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 01:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F367E7A38AF
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 23:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D6D21CC79;
	Wed,  6 Aug 2025 23:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgVWxKv9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84CC145346
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754521494; cv=none; b=P6kRNct3zuoqIu/Z4MzG4ZthTpPIaTcOWrqaFuoWm5fyk2RFloe85oANB0QRclIcqSQ6X2ekVaTBbk70NW86iI2sejJggf4ImAqvneDOy+07RWlk6r7s19p7BWllren2mk2XsFKZmxVIYa7yvYvSmEqoF21Nvdjtq7SChAy4s1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754521494; c=relaxed/simple;
	bh=EeqXUgwOvwbYTn28vONbo1N+MtJrIGks5MAknmH5ZCk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lcFPaDHdQ2tMRDtXKXsuHcE4xBq8u1COA+20fDkCB4VDGsaECiFKETX0k1I8UX5BfWBBvzALryBnj1syJnPlvQXm4v9uHjUm4b3RZZGg+wbA7yRlrIIeULplDPYrYw7RPZVW1Qs5gia4j7cS9q1qNY3qnsEOSjQ4uWgV9/o75Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgVWxKv9; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76bdc73f363so456418b3a.3
        for <bpf@vger.kernel.org>; Wed, 06 Aug 2025 16:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754521492; x=1755126292; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GI+AAN7ttfkdA+Nnw8aBJsVQ/40J+1Wk6PoPzG1rUZg=;
        b=WgVWxKv9689L7JnUxMViStEz9TJcXoAg+5kh8Vy29+S7tHCKuBf2uU+KCUhCWYq2Wu
         3i7284p44APj2Fs9qlpxzVqTJMukqt0jkfAnt3J2p+i4NTu+NEQPOGHF5EFUYHKMv3rC
         JuVy8f8QvFeW6O8SoVFzNnvkPvrJAMmjjOBFkGjQF36s4/zSbUHEmYNdkQh6HlCabEzG
         lBOC1v6OTMkGJc+rilcaYzP0Zud7O5JbR58nDUr3e2gKc/PHRs/DFYOes3pA3UzhAiQW
         amTCrmP2tt0DwxCqThsrt4AEyn/UOwdMcmw/TfFG7yYM3XoS0a678am4sgjMC5/KxRxp
         DbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754521492; x=1755126292;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GI+AAN7ttfkdA+Nnw8aBJsVQ/40J+1Wk6PoPzG1rUZg=;
        b=dIgpgy/zehqMCWfxEbgzArfT8n48ar4yMc1Yr3ce45qR1wR9bzI7uw3iz8g6yRb230
         Zqtu6TDeA4cxASUnD068KzfKWQz6WlxapCTMe0xNVw5XxogwG6+lyGvHpNG5zhMy4M96
         KegZP7hOXO6ORaAYPHSezZQhs3N52shiPpVEpr2hsz40qTfHSylzwdUYeI9Llu//IPRl
         QLheSKtFqSHynRtT4uc2MfUov3+pwnvgEkvlkhnd2+eI/HOGCbKqzApqs7rjHWqloCvF
         sTEYCC34l9dSjrkyyDbTiK0Z29r3rTGxgDXH3YD2BFOb1+hq5kdq9F5qCLhCb0cZxlUK
         WUoA==
X-Gm-Message-State: AOJu0YwOTck5BjqDhdS8Z2hLF9CprRPFj15iwrcm9V1ES5Gxme01iGNA
	yIqfhH3F8rKJbuzeETyCbYP16/WamJXYN/qELosGfucfgXLaCf1r4qjgnNLD1z9V
X-Gm-Gg: ASbGncusrKgfXLPeE+WpWEdZAPnsO3e9HqbPOarKo6NeFA6mLtqRIG1FFtkgiaAqW+m
	qAgQdXUwJ74biyq+uPHkTstYRBshiYGQKMbcb3LFEmImeTEdDjlo/mprNy4ek3UcbeJscPY+4Vc
	MKNTt774fcqmAJ4WgvMc4MRhZ2KmBE8qbfH/4G2yf3W1GnqScX9E4y01SX6rihSdi7Beoqeb/HZ
	DWfGXVTHOGqLDDNh1T6JqSIe9HUfV8DeLEeHsDBa+4qxkbGs8t07CAbXu8Z0pD0CU/k3G4UxyKX
	isihGvKIkiil9yziikEC4grrAxuv6W3GycdA7ZoVgM3OARk+I2GBU6G2nFemG5Gpi8DfOCNplsD
	9iDWohYAs6LmOC2vWf3i4ouDF
X-Google-Smtp-Source: AGHT+IEmZW+EYJs+oWDpTMW7m4xPv4CAHint5mMvnyh4B6kMbI6DShcCoiU8iXVk56o2rBDsn+W8gw==
X-Received: by 2002:a05:6a00:2301:b0:74d:3a57:81d9 with SMTP id d2e1a72fcca58-76c2a2c211fmr6593868b3a.8.1754521491668;
        Wed, 06 Aug 2025 16:04:51 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::6? ([2620:10d:c090:600::1:e57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6fe4bsm16442547b3a.9.2025.08.06.16.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 16:04:51 -0700 (PDT)
Message-ID: <4ad7e189907669e140553fba42759e97c691bfa0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] bpf: use realloc in bpf_patch_insn_data
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 06 Aug 2025 16:04:49 -0700
In-Reply-To: <20250806200928.3080531-2-eddyz87@gmail.com>
References: <20250806200928.3080531-1-eddyz87@gmail.com>
	 <20250806200928.3080531-2-eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-06 at 13:09 -0700, Eduard Zingerman wrote:

[...]

> @@ -20712,22 +20711,19 @@ static void adjust_insn_aux_data(struct bpf_ver=
ifier_env *env,
>  	 * (cnt =3D=3D 1) is taken or not. There is no guarantee INSN at OFF is=
 the
>  	 * original insn at old prog.
>  	 */
> -	old_data[off].zext_dst =3D insn_has_def32(insn + off + cnt - 1);
> +	data[off].zext_dst =3D insn_has_def32(insn + off + cnt - 1);
> =20
>  	if (cnt =3D=3D 1)
>  		return;
>  	prog_len =3D new_prog->len;
> =20
> -	memcpy(new_data, old_data, sizeof(struct bpf_insn_aux_data) * off);
> -	memcpy(new_data + off + cnt - 1, old_data + off,
> -	       sizeof(struct bpf_insn_aux_data) * (prog_len - off - cnt + 1));
> +	memmove(data + off + cnt - 1, data + off,
> +		sizeof(struct bpf_insn_aux_data) * (prog_len - off - cnt + 1));
>  	for (i =3D off; i < off + cnt - 1; i++) {
>  		/* Expand insni[off]'s seen count to the patched range. */
> -		new_data[i].seen =3D old_seen;
> -		new_data[i].zext_dst =3D insn_has_def32(insn + i);
> +		data[i].seen =3D old_seen;
> +		data[i].zext_dst =3D insn_has_def32(insn + i);
>  	}
> -	env->insn_aux_data =3D new_data;
> -	vfree(old_data);
>  }

veristat-meta job failed on the CI [1] because the following piece is missi=
ng:

  @@ -20719,6 +20719,7 @@ static void adjust_insn_aux_data(struct bpf_verif=
ier_env *env,
  =20
          memmove(data + off + cnt - 1, data + off,
                  sizeof(struct bpf_insn_aux_data) * (prog_len - off - cnt =
+ 1));
  +       memset(data + off, 0, sizeof(struct bpf_insn_aux_data) * (cnt - 1=
));
          for (i =3D off; i < off + cnt - 1; i++) {
                  /* Expand insni[off]'s seen count to the patched range. *=
/
                  data[i].seen =3D old_seen;

I'm trying to figure out if I can add a selftest for this.

[1] https://github.com/kernel-patches/bpf/actions/runs/16787563163/job/4754=
2309875

[...]

