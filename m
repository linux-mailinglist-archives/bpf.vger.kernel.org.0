Return-Path: <bpf+bounces-40075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 529A697C2CC
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 04:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0DB282E82
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 02:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD28E33985;
	Thu, 19 Sep 2024 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAl1DphR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D1124205
	for <bpf@vger.kernel.org>; Thu, 19 Sep 2024 02:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726712113; cv=none; b=izjDPws5UpAf9QgYPB9k0kvgB//R4nqANlW+eVnzkHXKfWpNaOHWyCXovG6mZdk0U+gTgurzmJHj5PQR+PthB++1eIqXYOTF2G4fQoPXqviq8UpSVDRoJArzPpY4KRNECwH8ScpVaVzssQr7dBLY8666k7sVWLNAXBR2BpOmTjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726712113; c=relaxed/simple;
	bh=XotQEDvYC71Eap8gVTyX47P8mTp7NiIkkIj0Yijsg4I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MhPtSiIH7jXR2KG8M0AcIpOGZG7UDzU7/lJGg+lsaacls5FKdeKujrsQiMo77O7G+KSuhMAtJCL6lsPUeOE0AmVXtgzmNpGHh+rPaJhD4fJjIjK+DFgJv2SJgbY8ITbcRaSfTJ5d7wKYP6OSI2YHTqGD9VT9rAx36rnqJaTWOdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAl1DphR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20543fdb7acso3324935ad.1
        for <bpf@vger.kernel.org>; Wed, 18 Sep 2024 19:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726712111; x=1727316911; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=73pJF0giD1vlqSF2aJbI/7GMbDFvyq6eU64/u/16fL4=;
        b=JAl1DphRFobT+F1YW/b/ZuDO8wg9xSFuCuRWOBDALgIsWzRUMemtmIPgR5U/yHiede
         fASef0DE0fSghRC3vIfOE40a4uISG2zeWlxCBUPZ7zgS2zGT4VYZlX4hFgIViScXPgLF
         hQ6PQT0Zkn6cnlmgISDjj+e94OQvW4khSn0TBzcbaEjAzP0TaMP2WSmbcdjypyrMbWLx
         GaABOCmtZFZ2BMKukaYzCrz+UeAJCfvGaEDrmEp1VlgYnyxfN0oVjC75+Kd2WZQBQo9Y
         Vj2dZhmGzUp1RPuGoJBysMTXrbn62YKbWcwbGIbm9cVejF1h4ST5KuB4YwRCM9aV6ZTm
         Z65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726712111; x=1727316911;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=73pJF0giD1vlqSF2aJbI/7GMbDFvyq6eU64/u/16fL4=;
        b=Af8EvZskZMN5W2egyPMZ5L+XVQhuw9rkfyOEGyOVXUQ0XZCyB8n7ZZTxWKr4GskiMh
         wIMhx5j+nt7ycmhpLLMeGXisc/yyLTmh/FRlB87eXU1XGD9EwRlxV+XrPBBv3eHQI533
         ecYPHS3glkPaU3LWpansq7PEoCK4hcbA1bO+XASMkyk+YpMulYOWtiXHLXwRZUd9x/PN
         GyNzyAvQOPsAAss8yqu3dlSPMy/L4kxdsQgCG+/YQearZCVuQ6dEnDYulzGbQyPydtzt
         9wNtR9+lH+oS02j3NhxZ5Ed6GkjfiEly77cr6DiIG25QkqfMryxuhZmfXEIdKUc1jEjf
         pdgw==
X-Forwarded-Encrypted: i=1; AJvYcCVGAuDNEqDSE4y1hza7U9BW6+s4rbFmJWq81Wf9l8wCJ52/8yP2SkZZwWt8oSMVsc392PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUeCpQqNrRD/CFxobP+becBrw9cUF8K9YY+EtkFs/gcWSmT4mu
	wrXQVt1FZHQAv5Gks9b2Um+rxO26rCSH05ElITOaxYVXtJtBDRhK
X-Google-Smtp-Source: AGHT+IGoqnErPiRbmoQbqxQhMDwvg1+HrnOVQrDFSWurTERTjSI3K+OewG+D6/0xzoQNSGU25diM0A==
X-Received: by 2002:a17:902:f641:b0:206:b399:2f2f with SMTP id d9443c01a7336-2078296a9e6mr318574635ad.47.1726712111150;
        Wed, 18 Sep 2024 19:15:11 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946017e1sm71040415ad.100.2024.09.18.19.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 19:15:10 -0700 (PDT)
Message-ID: <733608c444d491bd3d94d974441c856f7ba64fb1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: emit top frequent code lines
 in veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 18 Sep 2024 19:15:05 -0700
In-Reply-To: <20240918203925.150231-1-mykyta.yatsenko5@gmail.com>
References: <20240918203925.150231-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-18 at 21:39 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Production BPF programs are increasing in number of instructions and stat=
es
> to the point, where optimising verification process for them is necessary
> to avoid running into instruction limit. Authors of those BPF programs
> need to analyze verifier output, for example, collecting the most
> frequent source code lines to understand which part of the program has
> the biggest verification cost.
>=20
> This patch introduces `--top-src-lines` flag in veristat.
> `--top-src-lines=3DN` makes veristat output N the most popular sorce code
> lines, parsed from verification log.
>=20
> An example:
> ```
> $ sudo ./veristat --log-size=3D1000000000 --top-src-lines=3D4  pyperf600.=
bpf.o
> Processing 'pyperf600.bpf.o'...
> Top source lines (on_event):
>  4697: (pyperf.h:0)	=20
>  2334: (pyperf.h:326)	event->stack[i] =3D *symbol_id;=20
>  2334: (pyperf.h:118)	pidData->offsets.String_data);=20
>  1176: (pyperf.h:92)	bpf_probe_read_user(&frame->f_back,=20
> ...
> ```
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

I think this is a cool feature!
It's a bit of a shame that we don't collect information like this in
the verifier itself, where it would be simpler to do (e.g. associate a
counter with each instruction, or with each jump target).

[...]

> +static int print_top_src_lines(char * const buf, size_t buf_sz, const ch=
ar *prog_name)
> +{
> +	int lines_cap =3D 1;
> +	int lines_size =3D 0;
> +	char **lines;
> +	char *line =3D NULL;
> +	char *state;
> +	struct line_cnt *freq =3D NULL;
> +	struct line_cnt *cur;
> +	int unique_lines;
> +	int err;

Note:
  when compiling with clang 20.0.0git the following warning is reported:

veristat.c:957:14: error: variable 'err' is used uninitialized whenever 'fo=
r' loop exits because its condition is false [-Werror,-Wsometimes-uninitial=
ized]
  957 |         for (i =3D 0; i < min(unique_lines, env.top_src_lines); ++i=
) {
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
veristat.c:972:9: note: uninitialized use occurs here
  972 |         return err;
      |
  ...
veristat.c:903:9: note: initialize the variable 'err' to silence this warni=
ng
  903 |         int err;
      |                ^
      |                 =3D 0

Also, a nitpick: declarations should be sorted in a "reverse Christmas
tree" order (at-least that's what Andrii enforces :).

> +	int i;
> +
> +	lines =3D calloc(lines_cap, sizeof(char *));

Nitpick: here and in a few places below use sizeof(*<array>), e.g.:
         calloc(lines_cap, sizeof(*lines))

> +	if (!lines)
> +		return -ENOMEM;
> +
> +	while ((line =3D strtok_r(line ? NULL : buf, "\n", &state))) {
> +		if (strncmp(line, "; ", 2))
> +			continue;
> +		line +=3D 2;
> +
> +		if (lines_size =3D=3D lines_cap) {
> +			char **tmp;
> +
> +			lines_cap *=3D 2;
> +			tmp =3D realloc(lines, lines_cap * sizeof(char *));
> +			if (!tmp) {
> +				err =3D -ENOMEM;
> +				goto cleanup;
> +			}
> +			lines =3D tmp;
> +		}
> +		lines[lines_size] =3D line;
> +		lines_size++;
> +	}
> +
> +	if (!lines_size)
> +		goto cleanup;
> +
> +	qsort(lines, lines_size, sizeof(char *), str_cmp);
> +
> +	freq =3D calloc(lines_size, sizeof(struct line_cnt));
> +	if (!freq) {
> +		err =3D -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	cur =3D freq;
> +	cur->line =3D lines[0];
> +	cur->cnt =3D 1;
> +	for (i =3D 1; i < lines_size; ++i) {
> +		if (strcmp(lines[i], cur->line)) {
> +			cur++;
> +			cur->line =3D lines[i];
> +			cur->cnt =3D 0;
> +		}
> +		cur->cnt++;
> +	}
> +	unique_lines =3D cur - freq + 1;
> +
> +	qsort(freq, unique_lines, sizeof(struct line_cnt), line_cnt_cmp);
> +
> +	printf("Top source lines (%s):\n", prog_name);
> +	for (i =3D 0; i < min(unique_lines, env.top_src_lines); ++i) {
> +		char *src_code;
> +		char *src_line;
> +
> +		src_code =3D strtok_r(freq[i].line, "@", &state);

Does verifier guarantee presence of '@' for each source comment line?

> +		src_line =3D strtok_r(NULL, "\0", &state);
> +		if (src_line)

The '.line' string is null-terminated, can 'src_line' ever be NULL?

> +			printf("%5d: (%s)\t%s\n", freq[i].cnt, src_line + 1, src_code);
> +		else
> +			printf("%5d: %s\n", freq[i].cnt, src_code);
> +	}
> +
> +cleanup:
> +	free(freq);
> +	free(lines);
> +	return err;
> +}
> +

[...]



