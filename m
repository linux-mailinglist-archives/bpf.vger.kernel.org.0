Return-Path: <bpf+bounces-55663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A228AA84752
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 17:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBAB38C1E90
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 15:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1621DD889;
	Thu, 10 Apr 2025 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crEsShYe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B2F1D95A9
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297566; cv=none; b=Z7gGv5Vf+InScq+/2hRFH6RLd5f8EZH0dvMN+9V3cMuSyU7z6Xj33jqUunYoRgafLfxyM9qn4WW3xSBaMJZ0LYTybocJw0jCFb4HSIgAiztZhKl7S5J0Etl9UlBG9ogGF5HIMSuiIjqUHYdQfE7i6sdn4Q/5mjJbxbWXHWsVi98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297566; c=relaxed/simple;
	bh=8gBKr51IaJnWKb6kYg1tNkqD1aBjim44XHxDDRKXnhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6d7vOyrcZNmYBEuh1g/iOYezOVO8XBWqAeaKWu+KrNpYbqpHwa3ZiBBCwGm/bbjYIcYWDBN1E/mJX4id/B/h70fbm862hOtufoh5Bug6kYL7vHd5pRsLXhfZ25Xj7EUxsmYexNTtPsKuUmTXji3j2U/THlOcaKk+IMtqph2n6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crEsShYe; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfe574976so7401535e9.1
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 08:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744297563; x=1744902363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5/UmRod4T2ZrVOnqe+nN1TrLEpUT4sR2zlwViw42Sk=;
        b=crEsShYe1XjlXhLfWiRwSCiUu7k+YV1YpLhv7ixEPPVsjHgF5e6YNRdzt+2AukzIVC
         ekHV6BRS1oByZ4bodX7wQBhx+KV4CZoYC57EA8sNmGVT/TIOmTBNwgHZ2tmTaWmNYcuC
         E6VdMluXWKzq9O0oVHgdeqz69Q8/F9i6rG5heEWb//d9FSipBwnEumb8Te2E1uHiwyaY
         nYDnIJ5x/vFZKr+lWg7tD5lF7XavsBuXYgKhfEEMktoL6G0/NCcdakTFsqZPZbdjxMhH
         eEIU/Xv5OxXsz/nhAia355E8BOquoxhkxXtDZ+EX5oA6GNDukP+g7JX2wZTY8htLTDwT
         L7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744297563; x=1744902363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5/UmRod4T2ZrVOnqe+nN1TrLEpUT4sR2zlwViw42Sk=;
        b=d10Ik2H0vqnCPaAxBvKMAPIf1zBb8spnImKCWwgCXM7j/Snk87mhvk6Uh/Eyw+jAAe
         Y4RK4V6S+RP1cOVfzB6WYCAIE+jzcQvLOPBljE+z6WWqTQIYCj6jx40wZvPfHJdBL+ue
         Sp2efQ9roLPKZioO4vpUJbhUQrZKqoif18epB75LCirLhc5RoWRo17oNQ5ziolIJ6sj/
         1tj+MeDlnyewbXMcrfZc0pzh61kVfSqHhTiM1Jx6kSBX2VG/F9cEFXmQLCoW8L1IJobP
         0aJjKkyqtqnUSHD0CHZ24P8wUo0L1oX94vhPVH5GpnZb5/HVqXXG4rR9Fem9Wy6sUlTR
         SnUA==
X-Gm-Message-State: AOJu0Yy97557mzqXzbEWy6xcWqwldqWHXN9VFBOonzgwRyxxtTNNQcmd
	/8hx7NElN7ft8PWOMh9s+VxFbUP6kHW+N0PN5c3G9S5xcb/zPCFQrQBTm5XGPWPwYQrkiYefasG
	+AtOCcRczGHE7vws++wgn819xXXU=
X-Gm-Gg: ASbGncvJ9Cdk7I87gjypQ4xTqT5S7p5w9Oix8RC0wqzgoUNoERoHVFNtnPiCn9/vixy
	62cbUsFwM0/0YokEeaK4kbrMeFYbmsCep/lyFvmQiLO8AIAcdCL8EhBlCqvd5mhPbnJGRUwudRY
	lNxTAyaSKsH/B31mPYpI+LbxJ/0J6NZOFlkyyESg==
X-Google-Smtp-Source: AGHT+IE5U7UOo2llo6XeFBgzL1AhU3+gshzlT6d5gt/tPd09s5zAwj7vAy+oYycvRY4mRIIuQYGhegaAsEtfNOtxlRk=
X-Received: by 2002:a05:600c:4ec9:b0:43c:e9d0:9ee5 with SMTP id
 5b1f17b1804b1-43f2d7d705cmr30645645e9.18.1744297562973; Thu, 10 Apr 2025
 08:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <525d54bc-5259-49f2-acbf-7396bab48dec@gmail.com>
In-Reply-To: <525d54bc-5259-49f2-acbf-7396bab48dec@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 10 Apr 2025 08:05:51 -0700
X-Gm-Features: ATxdqUEX0dYv8J5qJamtMkq0ksyg5ySGs-cgsLs4Zno5ghTsaZ3ZX7ZPlEMtJH0
Message-ID: <CAADnVQ+ip7yB-8deWjHNBQxZHhV1Xi-5gTiYJVRy4gU5+Chkqw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: filter: remove dead instructions in filter code
To: Lion Ackermann <nnamrec@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 1:32=E2=80=AFAM Lion Ackermann <nnamrec@gmail.com> =
wrote:
>
> It is well-known to be possible to abuse the eBPF JIT to construct
> gadgets for code re-use attacks. To hinder this constant blinding was
> added in "bpf: add generic constant blinding for use in jits". This
> mitigation has one weakness though: It ignores jump instructions due to
> their correct offsets not being known when constant blinding is applied.
> This can be abused to construct "jump-chains" with crafted offsets so
> that certain desirable instructions are generated by the JIT compiler.
> F.e. two consecutive BPF_JMP | BPF_JA codes with an appropriate offset
> might generate the following jumps:
>
>     ...
>     0xffffffffc000f822:    jmp    0xffffffffc00108df
>     0xffffffffc000f827:    jmp    0xffffffffc0010861
>     ...
>
> If those are hit unaligned we can get two consecutive useful
> instructions:
>
>     ...
>     0xffffffffc000f823:    mov    $0xe9000010,%eax
>     0xffffffffc000f828:    xor    $0xe9000010,%eax
>     ...

Nack.
This is not exploitable.
We're not going to complicate classic bpf because of theoretical concerns.

pw-bot: cr

