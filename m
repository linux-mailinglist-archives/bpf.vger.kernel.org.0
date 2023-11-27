Return-Path: <bpf+bounces-16009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CF47FADA3
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 23:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EB11C20C1B
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 22:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC7E48CEE;
	Mon, 27 Nov 2023 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Qz4dPqUC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0633137
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 14:42:16 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507a29c7eefso6274468e87.1
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 14:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1701124935; x=1701729735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YOZIDCSlIizVR0CsIQ1T7xinPGLNwnVXG2YClpqXvIw=;
        b=Qz4dPqUCX5kedrJpQ/uX0bsMOCnUtJBgXB3cuHOZAsm6G5E8wdxoiWZWjksD8V2q5W
         NyE9RYRAwbZvmZpipgSp4LInrr0yLRDgPftwWSyFofzF4zeltB8McNDIYQph3xnMoLQM
         fUpLzCJ/Db6UsMwVRYtJn89HdviqjjtrmkivIikmhwegNrQZ54Ha993OcMCP7TPlxnO0
         RYHrS5O3UlhnB+9hv1mH/zQVB2hRh9ntoPZXfVN18/UhCdHVIo0S7IpLFzRapwmUWmFS
         SgEj37rDDhKHMZXMJSqRHjDexGj4TbJcHKuEOIrxk+jDAwQwpjTnMCjnyYvsY2eDuUct
         2kDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701124935; x=1701729735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YOZIDCSlIizVR0CsIQ1T7xinPGLNwnVXG2YClpqXvIw=;
        b=k5F7MwCJAzoyoopyNtK3ihAcFvllQqa8MBleUP29I3E8yHLfXfSMKaOO3pyYnyumyf
         6bJzmT1L72big2qRI+NhqBEo2NuzcOUN0zHua7R1L5+X2yAShFCoahah0xRUJJldXoyw
         Hbpa5kp1J/TRBrPgdIjsc710CY7i+G/7hEL2G89CY7OZ+ymgHS9OaA14a79tw3PHQhav
         YYUHCbarvDP3SSgdwrMbGlUfs5BaGhVBcWZx/pclVZ4fA8ss4ZIpltyA070bNh8GlPRW
         tvaOm4j7SJSAGhbQSakPFxfBehr3arcShqNcczhKgRTUA6DIY9msOP2VXYRmqkHtjMwr
         SMSg==
X-Gm-Message-State: AOJu0YxbXLycgGD0PJU5/fBo9XrwkWr3sjjPrtJO1GSvW6pCwWMN2IwC
	/bGltmgDo5Vt9IK8FXoIRILgXL016NsZnUEGaNHUcADpy8sZ+BqLvt5TUQ==
X-Google-Smtp-Source: AGHT+IGefKY9i4E/NBdXhjH+bgiLq/wjRp0I5F9qSdopkiafqosQCZ1wKFxqUUO+pMVsO3+OCZeL8qLr8jOBdX41yqI=
X-Received: by 2002:a05:6512:69:b0:50b:aabe:7948 with SMTP id
 i9-20020a056512006900b0050baabe7948mr5474205lfo.53.1701124935170; Mon, 27 Nov
 2023 14:42:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127182057.1081138-1-sdf@google.com>
In-Reply-To: <20231127182057.1081138-1-sdf@google.com>
From: Quentin Monnet <quentin@isovalent.com>
Date: Mon, 27 Nov 2023 22:42:03 +0000
Message-ID: <CACdoK4Jg_DffjRz72_Zsg3wCUs5eMAn+Jo61tMUVQvPNqM4pBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpftool: mark orphaned programs during
 prog show
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Nov 2023 at 18:21, Stanislav Fomichev <sdf@google.com> wrote:
>
> Commit ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD
> and PERF_BPF_EVENT_PROG_UNLOAD") stopped removing program's id from
> idr when the offloaded/bound netdev goes away. I was supposed to
> take a look and check in [0], but apparently I did not.
>
> Martin points out it might be useful to keep it that way for
> observability sake, but we at least need to mark those programs as
> unusable.
>
> Mark those programs as 'orphaned' and keep printing the list when
> we encounter ENODEV.
>
> 0: unspec  tag 0000000000000000
>         xlated 0B  not jited  memlock 4096B  orphaned
>
> [0]: https://lore.kernel.org/all/CAKH8qBtyR20ZWAc11z1-6pGb3Hd47AQUTbE_cfoktG59TqaJ7Q@mail.gmail.com/
>
> v3:
> * use two spaces for "  orphaned" (Quentin)
>
> Cc: netdev@vger.kernel.org
> Fixes: ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD and PERF_BPF_EVENT_PROG_UNLOAD")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks!

