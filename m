Return-Path: <bpf+bounces-39685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6927D975F94
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 05:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91F9BB2379E
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 03:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C52A12D760;
	Thu, 12 Sep 2024 03:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3K2g4gr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFB1126BF9
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 03:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726110878; cv=none; b=ZqZOHk06tVMRAXlVsz9HWG5l7o5M6A6wljeHvJIaWitKAlXtgAG3UsV1+UX1kC0Ys6yoGtAcDB/vp8iZackwvBKg3TDNcP+jddCA/zSxzOy6Jw8i2uLCcTNDIHTLueZ0X6RuEyzSK7DGEjYww5MTYZPpcl9x0xdKhiV2Im1obsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726110878; c=relaxed/simple;
	bh=oMmDldC1RDqQIkPywTYOuSX1yFkIV7wUE4M8oYG0sXU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dHgZSJ8RDUu7fdY2z/Sw/mzl6c4EDfopxJxBrQ3Ook5+wer760dx7hc2pAqb4GdelfO/xJ+T4cC13BxzXX54m/7PmSGnVr6uUUx0GjUYJ0gcoENbv8oXAxtGoepe2tWFe9xt6V7Zi2xxr16rmOwJDEtWgWvkiS8MDBBIRNf2+20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3K2g4gr; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d88edf1340so335995a91.1
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 20:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726110876; x=1726715676; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HaT2/A0mFjOkJaUgEd2iseZgfuu0b4g9DPGV7pGwisE=;
        b=Z3K2g4grmSlUyTxkIBEjXIU1Sdj62hVIfDCt9iJNEhVSea2xPn8fNq7Veyd08ehPW4
         xJ9V5xqOfdzU931P3pXdQSma/bRy9jWnayem0QnO0oYy8zflF2/Ux/yZ/i6ctQzx0U/E
         UNe3EICsKpgDUU1x1bzdIhXk+PIDpOX5m0fzzFdoR3sxPLggSkS1++AGNVzk/QVKPUHs
         ZnI3LicsHO/aObkoioKzhTbg2Gva+4HxUB6RcRpFfTB0zQAYJSQeWc8lfMTSzrImJOiJ
         y7OUuq5YB+jbcOvI3GqWrxs8nlQzw3V7Jv4vK9q+kB1ihDj28fSTY7wvFq38MSX6xD1K
         gk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726110876; x=1726715676;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HaT2/A0mFjOkJaUgEd2iseZgfuu0b4g9DPGV7pGwisE=;
        b=Br8QMl9jcZKp4pOtqsQtrzQEKuvtdcKBkeBTadsdMIWPrRUiSVYEbIyYrz01cA0VR+
         qhFt/+THiGQJhLdqI3jkc8bnSVXW65w34xOmozfnB34I/KgYEEycKuI22uJoCRkmLrAe
         KmLRM7tTdKb964QX9HpotbVMsSyxnLBpz68hDJWNdpX81DLsgNPgHTCO9Fvhtyq0/UXa
         94LGFRTII19A05CCbpbVhKRmm+x0J2C73m9VO7vbL8LSIJsCSlTXKYIMbrZUi1cI9d8e
         gya98JpKgALsn+LFczKkcTyDl2wIOQ5ToWs+OWwbFE9XB+HlQz8avX2iWAk7TGz4ZK4n
         IZGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM6/wtZfAOJMOmSCDRp6Yj/8JlEvoL4rG4W8D7oWl2l6MSgsfSmEuH24FsF0bkU4yCc1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCJ1FNEBNV4nryvRDYq2Xt8FhyBxEYCUx7qoOTvviaQSVCtRXF
	1q81hJhzNmO9LzDIohr+0Jz2ITKESlL3WfUgcFUA0O9yyjgTjg9C
X-Google-Smtp-Source: AGHT+IGpWIKEmji4Xhkvq6gAl7fxMmVbZMXzG/mG1VUTKbFCNuamSXvcwwPqy/DF83Rh59AytNTppA==
X-Received: by 2002:a17:90a:4b48:b0:2c9:61ad:dcd9 with SMTP id 98e67ed59e1d1-2dba0064f89mr1675619a91.27.1726110875471;
        Wed, 11 Sep 2024 20:14:35 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc040397sm11342047a91.25.2024.09.11.20.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 20:14:35 -0700 (PDT)
Message-ID: <8efb866f50259206e127079686aed51f201c3810.camel@gmail.com>
Subject: Re: [RESEND][PATCH bpf 1/2] bpf: Check the remaining info_cnt
 before repeating btf fields
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Song
 Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh
 <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>, 
 houtao1@huawei.com, xukuohai@huawei.com
Date: Wed, 11 Sep 2024 20:14:30 -0700
In-Reply-To: <9a7d4f5ff0ea8af86a6d7a5b630c38cb7ecc2075.camel@gmail.com>
References: <20240911110557.2759801-1-houtao@huaweicloud.com>
	 <20240911110557.2759801-2-houtao@huaweicloud.com>
	 <16794f86fd1030d923e3ab7356c5ff3617b2b193.camel@gmail.com>
	 <99c3bd09-054a-2c7c-7c6f-f1c613444f1f@huaweicloud.com>
	 <9a7d4f5ff0ea8af86a6d7a5b630c38cb7ecc2075.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-11 at 20:03 -0700, Eduard Zingerman wrote:

[...]

> Please bear with me. Here is btf_repeat_fields():
>=20
>     static int btf_repeat_fields(struct btf_field_info *info,
>                      u32 field_cnt, u32 repeat_cnt, u32 elem_size)
>     {
>         u32 i, j;
>         u32 cur;
>         ...
>         cur =3D field_cnt;
>         for (i =3D 0; i < repeat_cnt; i++) {
>             ...
>             for (j =3D 0; j < field_cnt; j++)
>                 info[cur++].off +=3D (i + 1) * elem_size;
>         }
>         ...
>     }
>=20
> The range for 'cur' is [field_cnt .. field_cnt * repeat_cnt].
> Meaning that at-least 'field_cnt * repeat_cnt' entries are necessary
> in the 'info' array.

Ok, I'm wrong.
The range for 'cur' is [field_cnt .. field_cnt * (repeat_cnt + 1)].
So with parameters passed maximal value of 'cur' is 'ret * nelems' indeed.
Sorry for the noise.


