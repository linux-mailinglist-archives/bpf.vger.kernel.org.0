Return-Path: <bpf+bounces-45641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8D19D9DF9
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 20:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1031D282B64
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 19:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3961DE8AC;
	Tue, 26 Nov 2024 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avmpcmAe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586C81DE4F8;
	Tue, 26 Nov 2024 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732648896; cv=none; b=jqV5prKcVnEpBHaEeo8sqAvcjgTaGeHbzBC6uO7km+D7xBb6OOMFQWhfjz6Lk3zXSDWfcedxnVhnXPSlpmcCflIjtSJ+webMappSHNlyEJsra960epXQkhrVA0c4nocbXO1GWYE1vn0WLhbnBnRq1oq3WeECJ29BhGKOqZch2NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732648896; c=relaxed/simple;
	bh=U6myVqWdQYYw26A+8XnZ8Z55i2Z4AyLhIWH6ewmuI20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o30CpU2m8ejrZAXABq1opo3NKytEPn3vsha7vZwtZ5ldJol+fdy/aUUDyMQ/NapysInfT40MB6IA4jbyt9R5LtKFvwjETI6KKrQ4x1lII41Ult4gi8XVU05qZBpNQVcXZpT9DuRUyItEBT5yj5nzBjjOpxAyOiLjA00e/lugSSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avmpcmAe; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-724f42c1c38so3060292b3a.1;
        Tue, 26 Nov 2024 11:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732648894; x=1733253694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOqAjlFCyaRT9qFIJXMcAiIJBo03YE98V6U0eNLQrFE=;
        b=avmpcmAeBs6DgDfNopIZZNiaD2eJfQKHpdTn1Kc0xKwC3sJ/f3xpHUYdrnRlHEoDMq
         cNTKd1by0iqkI/S4pR/iDQ8i2fUgJNumczH2LQsgmuFW6xL//dm77QX6MR7h2FELaqPa
         GEb85IEBvA/Ui3lWkkIfCJ0b2g9ij6FUpcaQHCqY3J1j9Z6gDTHdMs5DuGzwIZ8zUXNn
         DBRB0Q0imqjFQHpBfPPNNwc33sOzG0+K7TbaqziZqKp6b9MeoD+61q6TMU5vhe/2A7/V
         I6qLvk5hOfaVRELQ8iAcq0jtSuYlX8kl+DMp26JdDj/BQScDCfHXW/J7eRHa8xvo59d+
         B95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732648894; x=1733253694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOqAjlFCyaRT9qFIJXMcAiIJBo03YE98V6U0eNLQrFE=;
        b=t0Jk8I+tzUa8vNfJIb3VXrDJwpasus48D2jdjHlFB57qq1nuPWq4tZA87dW8Ze8cNj
         P1faI4CKZkTsdlDmfCOuU9ZrnBxKkxY6UGfHVXI57L0eQPRVcENDwCxdgsV7G0IWrUR5
         nbmNqJqFjjrnBpt4WUPImQRvimGTyABDUOWtrZkoSGq5bXJOFv53CheKYsdgpNouMZTb
         thoSQjUfIieHm9hMP9Bjmq1LwN0UXC2M0xnpQ6ya5Okad3czbWPULzersdqJT9KJ6xpG
         q/wXPdjlPcXDEWO2qVDZ4OSGT2qrbiFCIwDMqjNzr2xAiFdsByblTHX34OXizWl6o4+V
         X7aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGW7ZvL94Sn3zqujgw/kWVoWn3pi9t6NrfSpHdZnsnA3w86zfQD17vSXJmEyD13fL662E3ZF81WF4hJQ+/@vger.kernel.org, AJvYcCXDkIO2pIRVuVqG6008dud9ApXOfi8J7otQ4VYBFFBYrvDH75/1D0SRNvneYQsW9dvzBCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWNO1Yn8lYRivUnXMDT3HsfvTGNKGQRmfGoUrEssh27fTRoESw
	cEaNKM2To/Xb/537cOoIG48hSguQH/+m6alygK8BD7n3CjK6d1iEbvMQyQQA4G1DLsd8LrBlfcs
	Cy3tZfRBho7JSYv6+oL7N/UiWTeU=
X-Gm-Gg: ASbGncvPV20kr0o1krVTial55pcLe2J2jHPUOG/5PWHjXXrjpm4mkYFt4N38WP9t5s+
	xUqjlMS01W7yuawx6euTfi7G0q/wNYEZMLDB8tC09tuKL96s=
X-Google-Smtp-Source: AGHT+IEGuxvW0XuYyEglyuKW4iAJqUq+E4GjmtaCkswWLVsgV1XqOleebfe2aIibrw8rYkkA9f4X1pqY49zCAoLCJT0=
X-Received: by 2002:a17:90b:4e8e:b0:2ea:4578:46e0 with SMTP id
 98e67ed59e1d1-2ee08ec815amr620054a91.17.1732648894586; Tue, 26 Nov 2024
 11:21:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zz-uG3hligqOqAMe@bolson-desk> <Zz_YBK3SWnZnze-n@bolson-desk>
In-Reply-To: <Zz_YBK3SWnZnze-n@bolson-desk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Nov 2024 11:21:21 -0800
Message-ID: <CAEf4BzZtD2Dge4EV+ehKLk+-DVRNxTc4YfuJ+W5ytTVwgwFHjw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: Improve debug message when the base
 BTF cannot be found
To: "Olson, Matthew" <matthew.olson@intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 5:07=E2=80=AFPM Olson, Matthew <matthew.olson@intel=
.com> wrote:
>
> From 22ed11ee2153fc921987eac7de24f564da9f9230 Mon Sep 17 00:00:00 2001
> From: Ben Olson <matthew.olson@intel.com>
> Date: Thu, 21 Nov 2024 11:26:35 -0600
> Subject: [PATCH v2 bpf-next] libbpf: Improve debug message when the base =
BTF
>  cannot be found
>
> When running `bpftool` on a kernel module installed in `/lib/modules...`,
> this error is encountered if the user does not specify `--base-btf` to
> point to a valid base BTF (e.g. usually in `/sys/kernel/btf/vmlinux`).
> However, looking at the debug output to determine the cause of the error
> simply says `Invalid BTF string section`, which does not point to the
> actual source of the error. This just improves that debug message to tell
> users what happened.
>
> Signed-off-by: Ben Olson <matthew.olson@intel.com>
> ---
>
> Changed in v2:
>   * Made error message better reflect the condition
>
>  tools/lib/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 12468ae0d573..a4ae2df68b91 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -283,7 +283,7 @@ static int btf_parse_str_sec(struct btf *btf)
>      return -EINVAL;
>    }
>    if (!btf->base_btf && start[0]) {
> -    pr_debug("Invalid BTF string section\n");
> +    pr_debug("Malformed BTF string section, did you forget to provide ba=
se BTF?\n");

I'm not sure why, but this v2 didn't make it into patchworks, so I
can't apply it. Can you please resend?

Also please make sure you don't change indentation (tabs -> spaces),
because it looks like that's what happened here.

>      return -EINVAL;
>    }
>    return 0;
> --
> 2.47.0

