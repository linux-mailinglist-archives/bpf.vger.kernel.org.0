Return-Path: <bpf+bounces-41651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0032E9994A0
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 23:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC6E282FC6
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 21:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFA11E230A;
	Thu, 10 Oct 2024 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGgfCUBM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E950E19A2A3
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728597020; cv=none; b=iJKM2hw6J01t8p+oHoRR6By8QIFAemLiWMdQ6ZlGQHWWvc/xEqwI1cJyVnZfdFAXFZAvap5BDI+1Q9MfdcIaAMDwz5rCmN4BVTXBhsCg3LD/+swfPO3lKxUInxg85W52qaoCrsiZuW/8CB3E0+CIzAFCsvKWmqpxDx5AMc6Ktzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728597020; c=relaxed/simple;
	bh=4iBGMHpf8A1lRB/K7Yn+YmbsWzC7y+Vnp7CQZllrlNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIrHBkPRuUsixRbEqFmMVSwLKDp4KqBc51uuosND6aTWo+ZA5cku0o1GwO9cxamHAEs4xvGWSdna/tHF/5N/Yb2Y0mjpJV0sxFSO2uGAHCOR5fJ3gQl8DKpDHmv02HXkOf7vwvN6UgGQxXLKmcvB5gjoAwXg/1Mc2Q17epFFnKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGgfCUBM; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ea07610762so993021a12.0
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 14:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728597017; x=1729201817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWV423oB00CF5O64J32/8MIZdh7IOVfdZCai6dQPsEE=;
        b=nGgfCUBMfHt9f0dwzx+kwEjq65HPiJvex39sS1xvl5Z2t51+Ql9XqIMDo8AEM2Q0if
         ycKDGdrukduLlx4rUktneAKOncw+dDuFFwbXYtEpzULPBbOgiKLHj0RAXufN/Or2AgEh
         bfyDdYwlCgvoSF+OgKCtjoN4Xv4+TcemPTegr1GcGq8lqgIeUhhHrP4LbjaJeLXQGcwR
         5UtCNnmNMsZ3zl0wkDtSobJ0V57j6MlJJ30miPUeYgtHKro49OOHHybIzmN2P+5HGxx5
         Wd4w4p9Y6cv6VajaAAUhupAeN2IaUJawXgide/3P9duB5Ux2nghQ9hNm6b1VGsCoaLai
         vj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728597017; x=1729201817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWV423oB00CF5O64J32/8MIZdh7IOVfdZCai6dQPsEE=;
        b=cLlKEkNZRs1kbpR15PaQtbOECyA8T6EhH5+xllyhfX3IU+Ssq0plEDq0/UENyLU2ac
         +0wgGATtasN9KS19E8++qETaa+zNRnzrEc2wWVXBfKlJZrL/5y8KEZzrcryqVWOsbstF
         S4mKic4SeeaZ+1+YO1QPlO8vVVr5GFL/Z0glL49+kny7Hj/5Ln64659kRKyGjESheDtd
         RzKhfjy2tb/mck7fuLjeLM/YQdxWazSJR0I7rcCzNlq3LsDaCDCXjRDpgsDR2vhgYuAr
         TxA70ZHoDHiXsYttHfDvYUkuBup3eJjMZ22FVCB9IFriHVdPu3PI33mtqPrqzvvRYjks
         tQlA==
X-Gm-Message-State: AOJu0YwKfmhaWaGLSA32/KnYjSwXohK5tpSNY9Q03scPHD1gbW5B5jj+
	5vT4gFaUMSglPbAdOd3S3GTA55wlum+AIJlT6G4utzDifhWgIQ7sxzxX8IMDRcOTZ7enUQPRdcL
	uTe/jIbm2AZp8KrvuG1B2pS0jn5zjpQ==
X-Google-Smtp-Source: AGHT+IEmuQzwUzjsW0E6AvpPfOOMExi+/nYQg6sRUiH0gpR1zdwmtqUnNfY2ZjPH5Dayn11e0PdPzMiAoaUxGRY0f+w=
X-Received: by 2002:a17:90b:f16:b0:2e2:a850:6921 with SMTP id
 98e67ed59e1d1-2e2f0a49228mr877965a91.1.1728597017148; Thu, 10 Oct 2024
 14:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008091501.8302-1-houtao@huaweicloud.com> <20241008091501.8302-7-houtao@huaweicloud.com>
In-Reply-To: <20241008091501.8302-7-houtao@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Oct 2024 14:50:04 -0700
Message-ID: <CAEf4BzaVNBaNULS3=9o6hwnruKBTcz-Z3c0DMf+q17G=RfPkEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 06/16] bpf: Introduce bpf_dynptr_user
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 2:02=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> From: Hou Tao <houtao1@huawei.com>
>
> For bpf map with dynptr key support, the userspace application will use
> bpf_dynptr_user to represent the bpf_dynptr in the map key and pass it
> to bpf syscall. The bpf syscall will copy from bpf_dynptr_user to
> construct a corresponding bpf_dynptr_kern object when the map key is an
> input argument, and copy to bpf_dynptr_user from a bpf_dynptr_kern
> object when the map key is an output argument.
>
> For now the size of bpf_dynptr_user must be the same as bpf_dynptr, but
> the last u32 field is not used, so make it a reserved field.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  include/uapi/linux/bpf.h       | 6 ++++++
>  tools/include/uapi/linux/bpf.h | 6 ++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 07f7df308a01..72fe6a96b54c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7329,6 +7329,12 @@ struct bpf_dynptr {
>         __u64 __opaque[2];
>  } __attribute__((aligned(8)));
>
> +struct bpf_dynptr_user {

bikeshedding: maybe just bpf_udynptr?

> +       __u64 data;
> +       __u32 size;
> +       __u32 rsvd;
> +} __attribute__((aligned(8)));
> +
>  struct bpf_list_head {
>         __u64 __opaque[2];
>  } __attribute__((aligned(8)));
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 14f223282bfa..f12ce268e6be 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7328,6 +7328,12 @@ struct bpf_dynptr {
>         __u64 __opaque[2];
>  } __attribute__((aligned(8)));
>
> +struct bpf_dynptr_user {
> +       __u64 data;

what if we use __bpf_md_ptr(void *, data), so users can just directly
use this struct (and then the next patch won't be necessary at all)

> +       __u32 size;
> +       __u32 rsvd;

please call it __reserved


> +} __attribute__((aligned(8)));
> +
>  struct bpf_list_head {
>         __u64 __opaque[2];
>  } __attribute__((aligned(8)));
> --
> 2.44.0
>

