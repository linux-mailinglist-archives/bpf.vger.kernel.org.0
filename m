Return-Path: <bpf+bounces-62181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5A4AF6219
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 20:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ADB0161F1D
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 18:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAD12BE63A;
	Wed,  2 Jul 2025 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0O14ZFb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AD7248F54
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751482731; cv=none; b=SZhinPY8Te3BZcek/hKjatPkfMoRm7I8D+5VXjc4L0Hoae6NyZgFEIdkdkdhu/qLIwntp2WNcE//Y5r5/GWuxuQ/g/M8W3hLLdT2E91RVz9IZWl4zt4Fa4dsS3bYFjzgt4Pxs83n233pVVIeeAA/cBC+bVAEbxwfiyLtQtq+O/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751482731; c=relaxed/simple;
	bh=eARtE1DYiWGkqZJKcU/O2pv88BfjjTAoni4E27y98iE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Frk5B96dR3qUAT/AlHud9kAoAbAJDwIJz84reT5Jq+Zn5dgPTmjqyIKfuQah77P2cB8owid1OpX6JVRuUhyjSa6ZhiY7QzO3TKlWi0gxg3SVYv81u6mPgjonPpOewZzAP56TtgKNxxlzI4XPMw2JVkuJw7hUgFV4JUdiSFGVUBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0O14ZFb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23c76ed4a7fso5718855ad.1
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 11:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751482729; x=1752087529; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D3M/FXWFbBPN9W1VGkPnh9Ei0kS1rIrGwsj0j6L6Lrs=;
        b=l0O14ZFbszaDmjqSMSQrIMyG4c4uoIgqQSLVuTnxyYq3K7kShfXF30Ffz3m5ANIrIP
         4IzgH37T8XclEOAZKLEJ5AlSyky7inPVnz4rCX4dEU3jFbfyFmeZsxKWlB3ZE0fHLo64
         QPddDyIwzc/aqZxt235TpZPlIoJKvAvAA6x+X4VwZ4Y9ReOgfJjXRTTY6IdXY7YZFnr2
         Rvj4qFCQLZ5RRyyCr3lF+hD1Ra3GgHsFKqt6JuV5Sgp45LTEY5qG+EtgH4bkQzHQn1rm
         mQkma8W5b5LKb4TZuoxvn4vTRE6B5u7kUBZUYmGYOCfduIjNasE166EhVanzT5mmneX5
         6ifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751482729; x=1752087529;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3M/FXWFbBPN9W1VGkPnh9Ei0kS1rIrGwsj0j6L6Lrs=;
        b=sLhj38+S0rSSNacjOhL3lUHKMNeB9e1+V9uNALp5jU9kVmnkYXlsvJHRp5FhTGQi5d
         FcJjJjsrbtMJCmHpzq7wzZVu9Xxov6XPZ6tESB3D7ip7VTAv/zn6QcOaE/k1Hv2CIBck
         4kt5Gzm58n1t3FYOaamGQXLLiQeCLhNBS6bj0q4WfCIYKzLSezDGJ+jKsJ1eFYtDltPg
         nq4RHkGMKs7rHwMcwbluilt7VuRBmiAPkUjrJ/syVdEHIWs5oN5RTHTqUpWgOgamJSjg
         /PHSSmXwzEVjdZAMlxSPiYjYkN/tZu3ABKe0+qFnV1bhkX8feAvYRdVv52MpSC2N13AL
         5Kyw==
X-Forwarded-Encrypted: i=1; AJvYcCURkNgJy64n8BMogbaPlWn1yvyJtYAVDReXvt7pH5pZZrXSV11g31OqXUOXDOXQupKneYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnJzJHQVe6KmfqZNXQx83qOt2bAmgKX+fyQU5iVipNCBpocVT5
	Qglt3h8nWmgL3XMzuVHiVvyL3kGB4TSruZ97hsdnL/1gBsGvi9zqyV1e
X-Gm-Gg: ASbGnctFT6qky/auIfYGuYy0O8KlC0ErPrUHzPvkWdRfJgxJJRyVskhNl0xoW3Ebx0R
	xJttamat05pm5RaryERr2If7aqjg8r+r7qSw3ywWeDtivdyoYv7aSuG4Syq7Ialpa6uNGHuMT/J
	oAmOfVWvx8wKA9I9ccZdrXdngrF9qdKXq6tMXb7wMVucezwn4cPc1BE3rMMPTS0LqYv19TF1bo9
	nTrNyG5g9fJHKV4qXjwp2EM3QRMrLE+PKxY+sZ6a97z4SCluxBFhY6S8tEItsFgoq8PR91qTny2
	yTvM24DBklCZ9qnTV13/oqcLfuiVOyilEDPmL0qzagvHsUGTAJEIzXtXy/W0CLhGLCZnYfJ6Lam
	RWQbygyn0gM0=
X-Google-Smtp-Source: AGHT+IHU9Yp8Uy7EpJzqoURAit3DNBD+bq9eOCqzxCtI7hopbfEwPl46TeqewsOz3qPQYWdX+/DulQ==
X-Received: by 2002:a17:902:ea0f:b0:235:f632:a4d5 with SMTP id d9443c01a7336-23c7a1db99dmr1128765ad.9.1751482729315;
        Wed, 02 Jul 2025 11:58:49 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:ce31:8a4b:8b7d:e055? ([2620:10d:c090:500::5:5e14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bd19sm140315825ad.120.2025.07.02.11.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:58:49 -0700 (PDT)
Message-ID: <6c76267ef99ec33d98eba422ae3c4e601341fa9f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Simplify assignment to struct
 bpf_insn pointer in do_misc_fixups()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Wed, 02 Jul 2025 11:58:47 -0700
In-Reply-To: <20250702171139.2370585-1-yonghong.song@linux.dev>
References: <20250702171134.2370432-1-yonghong.song@linux.dev>
	 <20250702171139.2370585-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-02 at 10:11 -0700, Yonghong Song wrote:
> In verifier.c, the following code patterns (in two places)
>   struct bpf_insn *patch =3D &insn_buf[0];
> can be simplified to
>   struct bpf_insn *patch =3D insn_buf;
> which is easier to understand.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

