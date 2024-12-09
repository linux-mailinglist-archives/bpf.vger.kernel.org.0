Return-Path: <bpf+bounces-46414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E01309E9D3F
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 18:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C531887745
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 17:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5C715535A;
	Mon,  9 Dec 2024 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8a6vMbo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A00233151;
	Mon,  9 Dec 2024 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766230; cv=none; b=rW+uAg2hN5QfJmywqOYYt3deEwBdkqoX5jrleJ+Zgq/jv3au7icmCtjnz+4k1sLWjQP65WJn1SRXSn3cicD39QIvyu70jXIioNp1xCNG2OvzGrTTUeEYVUfH7Oj7MXxoNPVuxdYnsqbc+TAtMcUHIHkJKGrZsbqQ++yhqQ14p/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766230; c=relaxed/simple;
	bh=q/rcTOvcDwZyPaQTo31tJDbxBrL528rUIEpQq1SvPmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cce/PolS2l6k8LoGtACOPb/ueQ7g6+7WHSdqzQjrd6hnbGjektgOay1E7fmuxf2of2/uuKjrhUh6pLRS+/7p8mfF/OA8xmm4hr1SmAQ4BdJExBZhNoN2+cYOBXuy+l4VV52zXYumJ6uRlFwICeg9YtkhnVsjsi+CwE0kF8JAcfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8a6vMbo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216395e151bso10978065ad.0;
        Mon, 09 Dec 2024 09:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733766228; x=1734371028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8t4rQo4GlIJNr1Ck0WNYMLnLZ4WaSFJXClmAi03iA4=;
        b=X8a6vMboh2cUShWYAaWIOBjShJUqoXjqBHvg3+Wa48to13PGN9jN/w90FigY4jd+Sn
         y1ffQdrm8Tbn24PbsDal4ANtFXOO7BXzHp8/8ExTYtSzUyTYaPlgebk/Dq7aX9xf1qWo
         +JPiNBhuCfJXoV/tX4Hfpk0+E0wf6n5EXAKMDWeU3r4khiKNZdMTDza56xqw8PyOhWIc
         R/weVnjTJxx+pQ2LBCcO0mqxtGsTkGxs2DHy52FdbhXfhJJWBCOKAMPgDcRb218W0or5
         TgNZwVY+oSnRkDHb10G95JPQy2qAu3E3NSPzsbDn60U9sWt20RoLhTEbw303DTqWb3Zv
         hVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733766228; x=1734371028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8t4rQo4GlIJNr1Ck0WNYMLnLZ4WaSFJXClmAi03iA4=;
        b=bwy+srWYnLEFTheT1XaAseTBw67bx/BLg60tmbY3QX86G0OVlHzbOvBrPAy91We764
         D+SqN+QQroc8kLUkY9bmbYi/X49WiOqdFbcoHHmHY+ORsmjw+9DPnN5aPqrSs0Oyn2/Y
         1FivyC7XYb4jQgHZrkIedWMXiPOVic5tHLH1VqTANSoMeZLZ6sWAYOvncZIZUHMr4C3l
         h9tyuoORlJ20J0YjPs63L0sp5OJ3c3Vov8U8wAcPZw00smJ3NPxAG2SqCWz0rdrLMaTB
         rERAtLAz7HhRLpuDgIGt1n3DQXjrBS4FFPEYglxYYoPhI1n9apBioduzIQ5nNnt7fHXz
         xknw==
X-Forwarded-Encrypted: i=1; AJvYcCU0vB5jILUzVyCxEsqCQAdyzwuapEl9z4YulSXFfT3QyU8bKjsngwoyh0H9X+9PMuwzmYna8z7Sod45UDay+Q==@vger.kernel.org, AJvYcCU882Sks7zUUX5ewXg+isnnu0ehwt3K35aXqwSqlPHdSNcsbcaSN3LUxhsf3lbHT7hOSUbEPSsc8XvBh2SybguPMRAdUw==@vger.kernel.org, AJvYcCUSRBSuK27MY8aF5R9UyMlDZ3tcyo2bJCVfKW7IUvgJiyzc2ZPV6bmMEw9mapPM2qYyDQI=@vger.kernel.org, AJvYcCUpBvvCWFlAXG6ucN02R6Cporu0YJarlIqEpmCeZTRMip38iGlwrTXAV6O3e5jV6+6Clrg3hUlp5dSj82Mq@vger.kernel.org
X-Gm-Message-State: AOJu0YwhcJJsZR3lWOm2BB4CzocMnnYJXXMW5x6BOsfBNVwGOzZjX1EL
	VcWPn8PzbksqWS4M5MKcsZjyR2QHVd61UNLwu7jTzgq0AvrUMwN+YnNeTp9AFJSM93vCmsDSgxk
	DCawmfUK+He0FAzE9hqbZ8YPMMc4=
X-Gm-Gg: ASbGncsReDRqo2qJCXZuLFhSsG2Ff88ngF7s3+ZWajQJwc0KPX1JnYrmvxVRUEGD7Fz
	VNV90aOsu5BPV3YCyv37L3LRDIyE5mC8BeHSPvAKA2N7PeKs=
X-Google-Smtp-Source: AGHT+IF0BTr20MkxNzRSFNpph/h8vHNhmBKsOAPeY6Y0QdSHKlV0GxM2a08SVsbCGBad04gFH5w/DXOJoS3+X7u/Wjg=
X-Received: by 2002:a17:902:f541:b0:216:4676:dfb5 with SMTP id
 d9443c01a7336-21670a3f62cmr3456875ad.21.1733766228322; Mon, 09 Dec 2024
 09:43:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205-sysfs-const-bin_attr-simple-v1-0-4a4e4ced71e3@weissschuh.net>
 <20241205-sysfs-const-bin_attr-simple-v1-3-4a4e4ced71e3@weissschuh.net>
In-Reply-To: <20241205-sysfs-const-bin_attr-simple-v1-3-4a4e4ced71e3@weissschuh.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Dec 2024 09:43:36 -0800
Message-ID: <CAEf4BzYtD-njaaSr8zHK3ay0hzWFHamJ+DEqoXOcjM9LDdY4Zw@mail.gmail.com>
Subject: Re: [PATCH 3/4] btf: Switch vmlinux BTF attribute to sysfs_bin_attr_simple_read()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 9:35=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weisssc=
huh.net> wrote:
>
> The generic function from the sysfs core can replace the custom one.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>
> ---
> This is a replacement for [0], as Alexei was not happy about BIN_ATTR_SIM=
PLE_RO()
>
> [0] https://lore.kernel.org/lkml/20241122-sysfs-const-bin_attr-bpf-v1-1-8=
23aea399b53@weissschuh.net/
> ---
>  kernel/bpf/sysfs_btf.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
> index fedb54c94cdb830a4890d33677dcc5a6e236c13f..81d6cf90584a7157929c50f62=
a5c6862e7a3d081 100644
> --- a/kernel/bpf/sysfs_btf.c
> +++ b/kernel/bpf/sysfs_btf.c
> @@ -12,24 +12,16 @@
>  extern char __start_BTF[];
>  extern char __stop_BTF[];
>
> -static ssize_t
> -btf_vmlinux_read(struct file *file, struct kobject *kobj,
> -                struct bin_attribute *bin_attr,
> -                char *buf, loff_t off, size_t len)
> -{
> -       memcpy(buf, __start_BTF + off, len);
> -       return len;
> -}
> -
>  static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init =3D {
>         .attr =3D { .name =3D "vmlinux", .mode =3D 0444, },
> -       .read =3D btf_vmlinux_read,
> +       .read_new =3D sysfs_bin_attr_simple_read,
>  };
>
>  struct kobject *btf_kobj;
>
>  static int __init btf_vmlinux_init(void)
>  {
> +       bin_attr_btf_vmlinux.private =3D __start_BTF;
>         bin_attr_btf_vmlinux.size =3D __stop_BTF - __start_BTF;
>
>         if (bin_attr_btf_vmlinux.size =3D=3D 0)
>
> --
> 2.47.1
>

