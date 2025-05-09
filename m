Return-Path: <bpf+bounces-57929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8CAAB1EC9
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 23:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693E73A938C
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 21:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC7A23535B;
	Fri,  9 May 2025 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkXWlFQg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B88A41
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746825492; cv=none; b=SEesKAqlVi5I2Jj/OGQb/V8uPr0RRLLB4Hj89T61NbTtO0HQZwucck5VaDo7UldPmc8r/3gGISa8qQoPeMweu5PS+C3YU97Rro5m35Bq1U3rgXcpyd683yhrbuNt5npKpFpAVMOt6HlwEIBcvi2qkdCFQjejQ0wdkEucmsE3lM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746825492; c=relaxed/simple;
	bh=bTPkMs3s28+OYCHwQ0LBeoeHqiU7rJe8DX3tz7nes1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfU1mZt8MLVIEKZ5LrlueKQcPm0eLYEwZ8Q7tTQxLoKtuI9tvmFciPzTjBB7G69gXSQG/BKcyzkTzMLIkpC+twPQhVwi+KOLeJRJm+YIXoRyx3Jm5zO+EgMdAK/6kFe4D7q4tNsJN4aQSKxvq+C1xKimq7QUxgKcLSaaZwH+s5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkXWlFQg; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3081f72c271so2589069a91.0
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 14:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746825490; x=1747430290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfQeSc9dPHe8Vh41PPuOX3Sm3veUKDhVbGc7ieAkeao=;
        b=FkXWlFQg1cd521qkBayJPzSPufBdmwOjedfElsZ8FCGSmmXKTqX3vWwO0kik/6t3mO
         OxuucgcshnlConqAypd2ftBMP2r1ygOIpj97zgVP3FXrx6D7R+ZUyWLAfnStlb/6410q
         iD6OVFhFXDmxUpmbIBbdA5SLjMxBafSBmydDZ/Qf8+U+83D1U+k272DJ9kq+0W/xGGwH
         w1XyyGjr3QnRkSQbtwFiu1FtF+uQEcnTVkJLYM8DlbzXSDqhv9E6UGAnr0UDlWulIpJz
         ZAkINJrjh851bPNGcKnz2eqwF8XoDe468zegMF7sqlmRcQ/4Yz4dUDOMjY3OcchWLN1h
         b2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746825490; x=1747430290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfQeSc9dPHe8Vh41PPuOX3Sm3veUKDhVbGc7ieAkeao=;
        b=hsHfZlCS+3quD7hux2TKmYP9M1II6Zz9a5KI3/pfqo98pw9+O2xhlmIRG0l15pOikS
         gyOkCaELHtiV4c80WcwWpbd54viaTk3r1k4rEe08eoHcifzSP/HFr7q7oDU/HqYH3qst
         bf75w8DphavBBx/3+/1ip0Zv7lXkVDSIHiU4CWgwc3PWNNMWA8dnwnOFH0E+ovHSXpTu
         C2Z7K3sn7WOQ/5mMzkqwHAzxOBGu4Y01pUqgPwWGMnK3dqLm3xv1bhP3Yk/AF/Xgd/1W
         30TAIKm92JWb3C8uC+Tcduj6BK004rGQ1JBt2v0kAVflikofmc/VnTpPhrhAUtUjoFPP
         JUZg==
X-Gm-Message-State: AOJu0YyhpKXO/3CK6Z3u3AEw7u6+ayMLo5NPT5eAKYM2TXp1hk85aTTd
	dQ2yxvYF26P42rpnQcw9gvhF5LUrJjgrilIvGyeqLa6lCKaxHKzaWbjqvRj9vgE1N2ABEMzI1a1
	TDxLxlvXmLNJYjtnzheDzRmoh0ogKjYYR0tM=
X-Gm-Gg: ASbGnct5jMNcniE/ddVUo5qM0uvCrFLBbFnsWgBEMMI+JIalBGufnmPHprwo/0aUBBv
	4caoTJT3PhkyviFhR5ujfNhM8IgFXlpTUJBd/Oq5s54y0lkCLlM6MsT8xRehpPGs4f1f8daKhnx
	jZYocHFf4E/3lkD0ufE3b0KZ+h912oKfy9XQ8/lo12cBXYupz/
X-Google-Smtp-Source: AGHT+IEiGO5A78q2Alnsj715PpcUEpAM/kFZwiff7yCEPhzgYNN13DWCvlw+gCVba1sQIf5+V/4GLlbpf4Ml0xLx7No=
X-Received: by 2002:a17:90b:2d06:b0:30a:2196:e654 with SMTP id
 98e67ed59e1d1-30c3d2e1be3mr9123967a91.15.1746825489908; Fri, 09 May 2025
 14:18:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507171720.1958296-1-memxor@gmail.com> <20250507171720.1958296-4-memxor@gmail.com>
In-Reply-To: <20250507171720.1958296-4-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 May 2025 14:17:57 -0700
X-Gm-Features: ATxdqUE6Fzt0icFjUoEBMFm3ErN4teK0N1-sbzkyqcwWkVGyYbT5ZDQo22xI6pg
Message-ID: <CAEf4BzbxrHy2VnF6XNZ4pDVGXzuRu_Sv5TOGmMW87=WV5UpPYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 03/11] bpf: Add function to extract program
 source info
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 10:17=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Prepare a function for use in future patches that can extract the file
> info, line info, and the source line number for a given BPF program
> provided it's program counter.
>
> Only the basename of the file path is provided, given it can be
> excessively long in some cases.
>
> This will be used in later patches to print source info to the BPF
> stream. The source line number is indicated by the return value, and the
> file and line info are provided through out parameters.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h |  2 ++
>  kernel/bpf/core.c   | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 2c10ae62df2d..f12a0bf536c0 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3644,4 +3644,6 @@ static inline bool bpf_is_subprog(const struct bpf_=
prog *prog)
>         return prog->aux->func_idx !=3D 0;
>  }
>
> +int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, cons=
t char **filep, const char **linep);
> +
>  #endif /* _LINUX_BPF_H */
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 22c278c008ce..df1bae084abd 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3204,3 +3204,43 @@ EXPORT_SYMBOL(bpf_stats_enabled_key);
>
>  EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_exception);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
> +
> +int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, cons=
t char **filep, const char **linep)
> +{
> +       int idx =3D -1, insn_start, insn_end, len;
> +       struct bpf_line_info *linfo;
> +       void **jited_linfo;
> +       struct btf *btf;
> +
> +       btf =3D prog->aux->btf;
> +       linfo =3D prog->aux->linfo;
> +       jited_linfo =3D prog->aux->jited_linfo;
> +
> +       if (!btf || !linfo || !prog->aux->jited_linfo)
> +               return -EINVAL;
> +       len =3D prog->aux->func ? prog->aux->func[prog->aux->func_idx]->l=
en : prog->len;
> +
> +       linfo =3D &prog->aux->linfo[prog->aux->linfo_idx];
> +       jited_linfo =3D &prog->aux->jited_linfo[prog->aux->linfo_idx];
> +
> +       insn_start =3D linfo[0].insn_off;
> +       insn_end =3D insn_start + len;
> +
> +       for (int i =3D 0; linfo[i].insn_off >=3D insn_start && linfo[i].i=
nsn_off < insn_end; i++) {

have you checked find_linfo() in kernel/bpf/log.c? it uses binary
search, why not do that here as well? Or better yet reuse the code to
find bpf_line_info, and then extract whatever derived data you need?

> +               if (jited_linfo[i] >=3D (void *)ip)
> +                       break;
> +               idx =3D i;
> +       }
> +
> +       if (idx =3D=3D -1)
> +               return -ENOENT;
> +
> +       /* Get base component of the file path. */
> +       *filep =3D btf_name_by_offset(btf, linfo[idx].file_name_off);
> +       *filep =3D kbasename(*filep);
> +       /* Obtain the source line, and strip whitespace in prefix. */
> +       *linep =3D btf_name_by_offset(btf, linfo[idx].line_off);
> +       while (isspace(**linep))
> +               *linep +=3D 1;
> +       return BPF_LINE_INFO_LINE_NUM(linfo[idx].line_col);

we do a bunch of this in verbose_linfo(), maybe extract common code to
reuse? (no strong feeling about this, it's just a few lines of code
that are unlikely to change, after all)

> +}
> --
> 2.47.1
>

