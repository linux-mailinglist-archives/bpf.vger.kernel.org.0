Return-Path: <bpf+bounces-20112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C374B8399EB
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 20:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E526CB26531
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 19:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0F582D8E;
	Tue, 23 Jan 2024 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEgvV1Hg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA3D823D4;
	Tue, 23 Jan 2024 19:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706039864; cv=none; b=Pp5OBPOvA9paDA/sjbWB+ikWbJYavidb4hMRtswErovNvNJEY7rBe8E/n22iEjkeOUhmQeVaI4rrgj1DVvDOabKnTunx2kL25mLT9Y0noNomXT45FSy+nDtg9M1/f3OQh5r3Q+CUuqQF+NMAda7NOu24ZfY65Bi29IQuMdh1aGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706039864; c=relaxed/simple;
	bh=6kxs3ZRNvsnBerU+pBLILGlvcZuN7Asm/1eLx4m2eKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePs55uIxn/9NV9WI1WJz0D/xijBey0J+x32pS1vA4CXsUFTtP3ikF0qxmlwp6xAfu7ABipZ+6qfPM+5/JnWXgl4whzC6292Fsv7aCosAYWmeRh3YXPAVBpbhLgB79jwUqxDacAVpf/s8HLfVivKvoQQ0jwcXRqonKUpFuXeCzhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEgvV1Hg; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so4652932b3a.0;
        Tue, 23 Jan 2024 11:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706039862; x=1706644662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhXtvpl1MwEVA0HGf6b0dQAn6qf2NBu4JbI0qDtQpds=;
        b=DEgvV1HgHSFEatdIKN/iO58TUXikAeyhIUkKuTzcNpYAIIkgvfOqGfkQ9QKhJOLTAp
         uyc07YlGYSLpZhyLIpGsJ58xQWsMnCSqts9VHuktNNG6jKmS399TtepO5uqpZTcdRkxB
         w5cyBYs7h4v0OQeLB9qCAk4dEpNVymx+b/mUbqgtxLfDI0yRnXvYWpBHsVaOK8np158E
         9cCwi5FS5+zBMYleY1W5RJGMl3EajNV7XXOU8BainHWGrpA4GeergzrsGDyB8kvyV6kL
         st3SKlEwlJebv3VzX4Qc5BuDwx8yI0/XxkB4FpohhKnfK5N+IQXtUaEZDsvj7+Qv0p8a
         891g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706039862; x=1706644662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhXtvpl1MwEVA0HGf6b0dQAn6qf2NBu4JbI0qDtQpds=;
        b=YltenMu5ziiyRCwCwYVsVBJAYdA5ZEBK1vvCRXpKwm1wazhwcQQwXNBA8zqN0vPZIX
         Ruraa6mCRTZ/ZOCXGTenlYg4+Zu0HG+TvIiINelaqCazxrbO2wab7uU6g3KHduTpUdb3
         ioCGF1ckcFzUOX214iz44F1eUGK2zkNsddqn3qkeXjnGIzr7DxWkX2hU7gjmjN4cN9qI
         MX1jkYpPLk8NOi1ZRr+vbreIAFxwa85LBhvX3lKkAajkrE35znwhcDVDLqeE+PcSw4yf
         B8dLFmOdIJUzREm9T/kRAwxdZvJgiu95KfPp2++SgQkarlx9b/A+c4HGPnQVqhlQ4R1/
         s4gw==
X-Gm-Message-State: AOJu0Yyvd3GYo/MNLE1OSf6AAhLdWYYUGwVwR75V71nm7j9e57u0UFQm
	eXd/F4f0Swg1We/uB14PMIjWwni/4ro5Ulj4D3pCesdl+FhdB1miLNMk9JNc923cDdbRYcPIrzW
	8jinLgbP/E0a13hSvE9wCX0vEb/E=
X-Google-Smtp-Source: AGHT+IEY+LkXyHE5SgKdIdtnVLzWWe7swd8YxY+/9MoHabQFzw+12nk24kt3Qs8+x090M5VzCv9PChODXQA4lcutdOk=
X-Received: by 2002:a05:6a21:a592:b0:19c:6687:13d0 with SMTP id
 gd18-20020a056a21a59200b0019c668713d0mr124067pzc.27.1706039862102; Tue, 23
 Jan 2024 11:57:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123-b4-hid-bpf-fixes-v1-0-aa1fac734377@kernel.org> <20240123-b4-hid-bpf-fixes-v1-2-aa1fac734377@kernel.org>
In-Reply-To: <20240123-b4-hid-bpf-fixes-v1-2-aa1fac734377@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jan 2024 11:57:30 -0800
Message-ID: <CAEf4BzbE-YHR1FuXfG7ryi_77H=nzF0XBoppqrbG4Uh1uPz8Lg@mail.gmail.com>
Subject: Re: [PATCH 2/2] HID: bpf: use __bpf_kfunc instead of noinline
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 8:46=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> Follow the docs at Documentation/bpf/kfuncs.rst:
> - declare the function with `__bpf_kfunc`
> - disables missing prototype warnings, which allows to remove them from
>   include/linux/hid-bpf.h
>
> Removing the prototypes is not an issue because we currently have to
> redeclare them when writing the BPF program. They will eventually be
> generated by bpftool directly AFAIU.
>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
>  drivers/hid/bpf/hid_bpf_dispatch.c | 22 +++++++++++++++++-----
>  include/linux/hid_bpf.h            | 11 -----------
>  2 files changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index 5111d1fef0d3..119e4f03df55 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -143,6 +143,11 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev=
, u8 *rdesc, unsigned int *s
>  }
>  EXPORT_SYMBOL_GPL(call_hid_bpf_rdesc_fixup);
>
> +/* Disables missing prototype warnings */
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +                 "Global kfuncs as their definitions will be in BTF");
> +

would it be possible to use __bpf_kfunc_start_defs() and
__bpf_kfunc_end_defs() macros instead of explicit __diag push/pop
pairs? It's defined in include/linux/btf.h

>  /**
>   * hid_bpf_get_data - Get the kernel memory pointer associated with the =
context @ctx
>   *
> @@ -152,7 +157,7 @@ EXPORT_SYMBOL_GPL(call_hid_bpf_rdesc_fixup);
>   *
>   * @returns %NULL on error, an %__u8 memory pointer on success
>   */
> -noinline __u8 *
> +__bpf_kfunc __u8 *
>  hid_bpf_get_data(struct hid_bpf_ctx *ctx, unsigned int offset, const siz=
e_t rdwr_buf_size)
>  {
>         struct hid_bpf_ctx_kern *ctx_kern;
> @@ -167,6 +172,7 @@ hid_bpf_get_data(struct hid_bpf_ctx *ctx, unsigned in=
t offset, const size_t rdwr
>
>         return ctx_kern->data + offset;
>  }
> +__diag_pop(); /* missing prototype warnings */
>
>  /*
>   * The following set contains all functions we agree BPF programs
> @@ -274,6 +280,11 @@ static int do_hid_bpf_attach_prog(struct hid_device =
*hdev, int prog_fd, struct b
>         return fd;
>  }
>
> +/* Disables missing prototype warnings */
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +                 "Global kfuncs as their definitions will be in BTF");
> +
>  /**
>   * hid_bpf_attach_prog - Attach the given @prog_fd to the given HID devi=
ce
>   *
> @@ -286,7 +297,7 @@ static int do_hid_bpf_attach_prog(struct hid_device *=
hdev, int prog_fd, struct b
>   * is pinned to the BPF file system).
>   */
>  /* called from syscall */
> -noinline int
> +__bpf_kfunc int
>  hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, __u32 flags)
>  {
>         struct hid_device *hdev;
> @@ -328,7 +339,7 @@ hid_bpf_attach_prog(unsigned int hid_id, int prog_fd,=
 __u32 flags)
>   *
>   * @returns A pointer to &struct hid_bpf_ctx on success, %NULL on error.
>   */
> -noinline struct hid_bpf_ctx *
> +__bpf_kfunc struct hid_bpf_ctx *
>  hid_bpf_allocate_context(unsigned int hid_id)
>  {
>         struct hid_device *hdev;
> @@ -359,7 +370,7 @@ hid_bpf_allocate_context(unsigned int hid_id)
>   * @ctx: the HID-BPF context to release
>   *
>   */
> -noinline void
> +__bpf_kfunc void
>  hid_bpf_release_context(struct hid_bpf_ctx *ctx)
>  {
>         struct hid_bpf_ctx_kern *ctx_kern;
> @@ -380,7 +391,7 @@ hid_bpf_release_context(struct hid_bpf_ctx *ctx)
>   *
>   * @returns %0 on success, a negative error code otherwise.
>   */
> -noinline int
> +__bpf_kfunc int
>  hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
>                    enum hid_report_type rtype, enum hid_class_request req=
type)
>  {
> @@ -448,6 +459,7 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf=
, size_t buf__sz,
>         kfree(dma_data);
>         return ret;
>  }
> +__diag_pop(); /* missing prototype warnings */
>
>  /* our HID-BPF entrypoints */
>  BTF_SET8_START(hid_bpf_fmodret_ids)
> diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
> index 840cd254172d..7118ac28d468 100644
> --- a/include/linux/hid_bpf.h
> +++ b/include/linux/hid_bpf.h
> @@ -77,17 +77,6 @@ enum hid_bpf_attach_flags {
>  int hid_bpf_device_event(struct hid_bpf_ctx *ctx);
>  int hid_bpf_rdesc_fixup(struct hid_bpf_ctx *ctx);
>
> -/* Following functions are kfunc that we export to BPF programs */
> -/* available everywhere in HID-BPF */
> -__u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx, unsigned int offset, con=
st size_t __sz);
> -
> -/* only available in syscall */
> -int hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, __u32 flags);
> -int hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__s=
z,
> -                      enum hid_report_type rtype, enum hid_class_request=
 reqtype);
> -struct hid_bpf_ctx *hid_bpf_allocate_context(unsigned int hid_id);
> -void hid_bpf_release_context(struct hid_bpf_ctx *ctx);
> -
>  /*
>   * Below is HID internal
>   */
>
> --
> 2.43.0
>
>

