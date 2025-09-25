Return-Path: <bpf+bounces-69797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D5BBA1FB0
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 01:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E083B4990
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 23:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E922EE27C;
	Thu, 25 Sep 2025 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyG+GsIt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A66E189BB6
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 23:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758843148; cv=none; b=utLGGW5IyH+OJOtXHKh7os+YiO8yJz9tTCceQ4HTn+qeLwMmbfsKTrozM6TkUAkVXt6K72ZJQuM+0yFEACmN+NBn5VJc44MAgGLxcLPMJe3uvPLl6SA3R1M+7UkF7ji659+w9/T50Er0OfU3y14bfThaXE1VOZLccmQ19h4GJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758843148; c=relaxed/simple;
	bh=l5LRunuTe/LqJ3h4k3fN0y4sQ6ZlASLvxnuyjT0c2dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWChtFdEiRs0XJW6iVZmzH3l1SVBWzikLIjAzlUrdYs2eCIbGVqiQnvjh+0fpxr4mHk1vBOQMkWAHJ3V3kIGgTBOiK1AVjbr+/CSIn2BqQ6bD9W1FUiUMOoIOdZDBeuSPK6Z/sPKfhS3nB3yU+Loh3tMrNy7/NbkSHDTVU7Ywew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyG+GsIt; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so1809341a91.1
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 16:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758843146; x=1759447946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8PWUy95/xwAeHXQlv9LwNQfamqkfSoV3CUxibqo+As=;
        b=ZyG+GsItC6RmhbuH8JACJ/a7IoR6OJP0dOMRWNK37GIE72YeGq9bOU80VUidOy/+xV
         FFPZTC4p1WnUL400zxmjuf9xoxSSJRxBDLYVCDdApqIKZ2RPKZgG9Oimd5pFa0Ir/R89
         4Ga+AlP3e1Nvt7YwARkyptXIbmv1LyB9RYHLyBtPOXhXrbhsUy3Hf7UzjgqQJXZ02TdE
         aN5EJrmlWroRyS49MVjjouZ7Pj+84Sa5GgAa8bhcL5aEebMIDjjV4RdVSdRuG7WMJhrF
         Pp42dCcm+Yx0ydsh37whjpTgX19/MjrKtxRvjedmLVVDHX6lShLSnpAkeoavCzKDfE88
         PNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758843146; x=1759447946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8PWUy95/xwAeHXQlv9LwNQfamqkfSoV3CUxibqo+As=;
        b=GmXu5IP3LqdMZDilPSBbZDNbrdfKtTK6VHS8jIa7GA8QSPv2nyzeqjPeIBTazOzxSY
         VeumOHc+txoq+RDSvsfQpuujXJ7ljbs8MMlHopv0qBgjr4d0WzQc92+nAAmgnitQeK9Y
         ZrgDO+BnsQ0FmVsVZloaHAR/xgf0G5ngyCJn9r5LbsIY7DgFCCt++vnFc42J4kuTNKWo
         lzpUEEZBZhJE/4vDXSqF4AXcB3kPyuUiJFYSMN9ak3P0Y9VIFEgT/rBDkNNKuMFIBv3x
         do3BnliOb4wGrV/be5py3vc3Ua8z9zIQK6+iTrJlC+ZZOV3pswo8S9jaix3JHnnsUK12
         m4iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm2CYgGjVEym9OI7TQsgaDLFhDTZZs6/P9FcpL86vgu5UrbhUHATqNC7WkQyllTxlzcZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXwoeLRjz1DQpSPQ1WF6QniJ2OEpPOI0pGu/lHp6aCFUKfCR8b
	D6yswAdwP/SOae8mSyJ+Lw/53p8xKuoMm1DHsgRtKxCjdsB+Ma0BH1AjPzaKLTVCIARlPflPcoX
	yiNIh90c49YTx8C2PcHfxPfWesnu4h8c=
X-Gm-Gg: ASbGncuBQzXmoFU6f6dAnRr9ro5DJnjvUdCpmjhq03q071UPAH19gR7gsCvqqcgmNrt
	yfGYpLOycQ3Kgaok9WkIzs7FRe+pd1UBehwolB+BpACWFUj1WaZr4JiMD5ppbSiTK6YyWxQSUuQ
	VIuZBXY/4VNDv9TL4Srb+0GXR9l9wh0qr5XN4ttOyEu4oLSm/NJFmpFI4BhrUOcS33hTNcL54xu
	qJY4e4RUU2q8KzbgNjVD3dbFGE/MJIVEw==
X-Google-Smtp-Source: AGHT+IFyG6lAkXqNECGf0CPqvA5WLNFwkWpmgIcJv7d6UG7Fy+qA0wGWEdL6nyUo+sCagqxDXc40BM4LYLvFPLy3JiY=
X-Received: by 2002:a17:90b:3ecc:b0:32e:7c34:70cf with SMTP id
 98e67ed59e1d1-3342a300aafmr5225649a91.36.1758843145829; Thu, 25 Sep 2025
 16:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 16:32:11 -0700
X-Gm-Features: AS18NWAPxbw3Q7HkczSi0SkphLUmd3YAUtjm9M5fUjRW3Bv2KTPZjdUhgqDqjkE
Message-ID: <CAEf4Bzaf81OYLTzpN6E4ths_mN2gP29rMYBmbp7P2GqSMj8FbA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] selftests/bpf: Prepare to add -Wsign-compare for
 bpf selftests
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, hawk@kernel.org, linux@jordanrome.com, ameryhung@gmail.com, 
	toke@redhat.com, houtao1@huawei.com, emil@etsalapatis.com, yatsenko@meta.com, 
	isolodrai@meta.com, a.s.protopopov@gmail.com, dxu@dxuuu.xyz, memxor@gmail.com, 
	vmalik@redhat.com, bigeasy@linutronix.de, tj@kernel.org, 
	gregkh@linuxfoundation.org, paul@paul-moore.com, 
	bboscaccy@linux.microsoft.com, James.Bottomley@hansenpartnership.com, 
	mrpre@163.com, jakub@cloudflare.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 2:36=E2=80=AFAM Mehdi Ben Hadj Khelifa
<mehdi.benhadjkhelifa@gmail.com> wrote:
>
> This series is preparing to add the -Wsign-compare C compilation flag to
> the Makefile for bpf selftests as requested by a TODO to help avoid
> implicit type conversions and have predictable behavior.
>
> Changelog:
>
> Changes from v2:
>
> -Split up the patch into a patch series as suggested by vivek
>
> -Include only changes to variable types with no casting by my mentor
> david
>
> -Removed the -Wsign-compare in Makefile to avoid compilation errors
> until adding casting for rest of comparisons.
>
> Link:https://lore.kernel.org/bpf/20250924195731.6374-1-mehdi.benhadjkheli=
fa@gmail.com/T/#u
>
> Changes from v1:
>
> - Fix CI failed builds where it failed due to do missing .c and
> .h files in my patch for working in mainline.
>
> Link:https://lore.kernel.org/bpf/20250924162408.815137-1-mehdi.benhadjkhe=
lifa@gmail.com/T/#u
>
> Mehdi Ben Hadj Khelifa (3):
>   selftests/bpf: Prepare to add -Wsign-compare for bpf tests
>   selftests/bpf: Prepare to add -Wsign-compare for bpf tests
>   selftests/bpf: Prepare to add -Wsign-compare for bpf tests
>

I see little value in these transformations. Did we catch any real
issue here? All this type casting and replacement is just churn.

I certainly don't want such churn in libbpf, and I'd leave BPF
selftests as is as well. int vs u64 can have subtle and non-obvious
implications for BPF code generation (for no-alu32 variants
especially), and I think BPF CI already exposed some of those already.

I think we can live without -Wsign-compare just fine.


>  tools/testing/selftests/bpf/progs/test_global_func11.c       | 2 +-
>  tools/testing/selftests/bpf/progs/test_global_func12.c       | 2 +-
>  tools/testing/selftests/bpf/progs/test_global_func13.c       | 2 +-
>  tools/testing/selftests/bpf/progs/test_global_func9.c        | 2 +-
>  tools/testing/selftests/bpf/progs/test_map_init.c            | 2 +-
>  tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c   | 2 +-
>  .../selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c      | 2 +-
>  tools/testing/selftests/bpf/progs/test_skb_ctx.c             | 2 +-
>  tools/testing/selftests/bpf/progs/test_snprintf.c            | 2 +-
>  tools/testing/selftests/bpf/progs/test_sockmap_strp.c        | 2 +-
>  tools/testing/selftests/bpf/progs/test_tc_tunnel.c           | 2 +-
>  tools/testing/selftests/bpf/progs/test_xdp.c                 | 2 +-
>  tools/testing/selftests/bpf/progs/test_xdp_dynptr.c          | 2 +-
>  tools/testing/selftests/bpf/progs/test_xdp_loop.c            | 2 +-
>  tools/testing/selftests/bpf/progs/test_xdp_noinline.c        | 4 ++--
>  tools/testing/selftests/bpf/progs/uprobe_multi.c             | 4 ++--
>  .../selftests/bpf/progs/uprobe_multi_session_recursive.c     | 5 +++--
>  .../selftests/bpf/progs/verifier_iterating_callbacks.c       | 2 +-
>  18 files changed, 22 insertions(+), 21 deletions(-)
>
> --
> 2.51.0
>

