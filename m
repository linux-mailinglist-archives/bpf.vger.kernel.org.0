Return-Path: <bpf+bounces-62422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D5BAF9A4E
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 20:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5FD31CC0EC9
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 18:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEA7207A18;
	Fri,  4 Jul 2025 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDQwTRIi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702972E3713
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751652391; cv=none; b=H8T1SEGpwHRtMRuxZewZXKzJT5XXyWumsS4a9pDAqABH0POIWLTom1V8CRNBh0r0UB8rXiHjNVyoHfQ8vd2FfzD4o3jj3sdvjzvRJuRmI1mtPL0pSoRflhd1iVlgG92NDrpvkOohgQUuwPmgbM1TnMoV+H3N3sylsPaEqYnbCXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751652391; c=relaxed/simple;
	bh=hXBurLFqQIOumxrp9sA8tloapMaybn1YEfVNysAfC7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAQrvXZGqfqEgnDGN7auutqe7adDM53Q9zi4dhjfJQeCGgCaDFPAtinYsmUVjMnF+tFQ+XfZRK84Jzqfqs+zi+5BQcOnFW2KNgWfsDlgxFOcbpZSIKSzspdHSxcjepIVpS+fnXTAEPQw4S0vz2ij4QUcEoYTbiJ5YVnNMv1TshA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDQwTRIi; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ae35f36da9dso223206466b.0
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 11:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751652388; x=1752257188; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m/Zuj07YYtlqKcGkqSJzhubM33le9OmOdO/VA83MutU=;
        b=JDQwTRIiKeXXgFAWuLo5ziBdhqml+mGg1KP+nTcgj1aXNnYXXnm3YHOvCafsLueGp/
         eTtxDUFeUUTBrP2VtRFpYuA9opHWRDuaUtKkUG6sT4e/gPkLa83jCAb2QYam9XnNCO6k
         /GaVILSpu57NSpd7x0ETDXsekrJfnIuTZ23TJX7Uy+FpvDy7lGzqXnPjGO5J7R7xtzZm
         kR3yta7OOTzQW76mvzEZCpX2LjTFXs1MXzBIy25qvrCQpNrRX7iZG6r5Q+/uM0lQ9h9v
         SxXuSuhD6YWfI0xvaa6QRf9kEvs8xJIcR6uH/YM4IaNYYgU2W2W8Fhft59J+BTfH/RDX
         paCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751652388; x=1752257188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/Zuj07YYtlqKcGkqSJzhubM33le9OmOdO/VA83MutU=;
        b=b5s9eradQztFY/hW66EPllIjdkRCY0PkBhZoS83Y8T25cqFrsPVsnx1JqqUvDPZEsO
         HC+O7UQYzUQVjkPzvyaDNovoDqdjusLHPOoCcFRkGFWI1A7Pai6uf3KO69+aBeUPzH13
         F11WfYQiJrm5PuyxLwVntgL90uHYrV+cDXuuZyJo6P668jhQ0b+tw3xvXJwDTv8Hiwe/
         JplSkPusYB09JtXS5123pYN+Iuv4SYv/v53vcRsYigCy/Dm8cV3T0mnVeFOYcfVhDxKl
         m1j6Wqtgnyk+EskK9hvXDYlqs1BabduJLn5yn8rlYzxcgFkaw1CkKMsBEvNqg2+RL123
         KG4A==
X-Gm-Message-State: AOJu0Yy2ddtv5L+XFgii6dvCxoZbN0zpth4WRwa491m9GzLapZpWlBfU
	gA//V+oct8LCTE5u3XUNooExA1Ga9VJg48L1/g/g0bMkxdaDDrC5Rx22uHnRMU9TOxbhJoaZ5gZ
	rt+AJtGWhgkOgPzKzOa8SUSjM/70v6JE=
X-Gm-Gg: ASbGncsVnTD6ChaX0MROpWz7AFL5W4yO9k+SyInueY9CLi7vIy7++aTXH2M74/0eOIb
	2ilp/OpdoUgx3h7aWVIc2uL4Jn9fNlhofi6sx1ITQNzGbVDY0bjIVi0nH3OF4D53cIdrm7ADQ2i
	3YVIrdsRcIDkWEoy6LsWhKwlJmniDjJOJ64RlhGdBz7YGD/A1ETjoRQNNFGYCf/pdsCo8lGqKLZ
	AI=
X-Google-Smtp-Source: AGHT+IFe4CQYEF/UaKNLhc65ZzVetdHNMh/DtmTsU0lDAHYOcHE+xYForG6kOFzEak0vQqLUmjLjJevlYLcKhvC4bZA=
X-Received: by 2002:a17:906:9f88:b0:ae4:a17:e6d2 with SMTP id
 a640c23a62f3a-ae40a17e808mr123439566b.24.1751652387599; Fri, 04 Jul 2025
 11:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702224209.3300396-1-eddyz87@gmail.com> <20250702224209.3300396-7-eddyz87@gmail.com>
In-Reply-To: <20250702224209.3300396-7-eddyz87@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 4 Jul 2025 20:05:51 +0200
X-Gm-Features: Ac12FXyHD2Ug_me4WGhpSslkG06ENRhhXE0msVRF9xAb262xb2JN-X0DLlgKGDQ
Message-ID: <CAP01T75+gcUF_1=9edR=g_ztC1ww95OY6A-q1nXhcp9qqsvnFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 6/8] selftests/bpf: test cases for __arg_untrusted
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 00:42, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Check usage of __arg_untrusted parameters with PTR_TO_BTF_ID:
> - combining __arg_untrusted with other tags is forbidden;
> - passing of {trusted, untrusted, map value, scalar value, values with
>   variable offset} to untrusted is ok;
> - passing of PTR_TO_BTF_ID with a different type to untrusted is ok;
> - passing of untrusted to trusted is forbidden.

If you decide or do not decide to support program local types, one
extra test could exercise support/lack of support as well.
It should fail to find the candidate if unsupported, succeed if supported.

>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  .../bpf/progs/verifier_global_ptr_args.c      | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
> index 4ab0ef18d7eb..772e8dd3e001 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
> @@ -179,4 +179,70 @@ int BPF_PROG(trusted_acq_rel, struct task_struct *task, u64 clone_flags)
>         return subprog_trusted_acq_rel(task);
>  }
>
> +__weak int subprog_untrusted_bad_tags(struct task_struct *task __arg_untrusted __arg_nullable)
> +{
> +       return task->pid;
> +}
> +
> +SEC("tp_btf/sys_enter")
> +__failure
> +__msg("arg#0 untrusted cannot be combined with any other tags")
> +int untrusted_bad_tags(void *ctx)
> +{
> +       return subprog_untrusted_bad_tags(0);
> +}
> +
> +__weak int subprog_untrusted(struct task_struct *task __arg_untrusted)
> +{
> +       return task->pid;
> +}
> +
> +SEC("tp_btf/sys_enter")
> +__success
> +__log_level(2)
> +__msg("r1 = {{.*}}; {{.*}}R1_w=trusted_ptr_task_struct()")
> +__msg("Func#1 ('subprog_untrusted') is global and assumed valid.")
> +__msg("Validating subprog_untrusted() func#1...")
> +__msg(": R1=untrusted_ptr_task_struct")
> +int trusted_to_untrusted(void *ctx)
> +{
> +       return subprog_untrusted(bpf_get_current_task_btf());
> +}
> +
> +char mem[16];
> +u32 off;
> +
> +SEC("tp_btf/sys_enter")
> +__success
> +int anything_to_untrusted(void *ctx)
> +{
> +       /* untrusted to untrusted */
> +       subprog_untrusted(bpf_core_cast(0, struct task_struct));
> +       /* wrong type to untrusted */
> +       subprog_untrusted((void *)bpf_core_cast(0, struct bpf_verifier_env));
> +       /* map value to untrusted */
> +       subprog_untrusted((void *)mem);
> +       /* scalar to untrusted */
> +       subprog_untrusted(0);
> +       /* variable offset to untrusted (map) */
> +       subprog_untrusted((void *)mem + off);
> +       /* variable offset to untrusted (trusted) */
> +       subprog_untrusted((void *)bpf_get_current_task_btf() + off);
> +       return 0;
> +}
> +
> +__weak int subprog_untrusted2(struct task_struct *task __arg_untrusted)
> +{
> +       return subprog_trusted_task_nullable(task);
> +}
> +
> +SEC("tp_btf/sys_enter")
> +__failure
> +__msg("R1 type=untrusted_ptr_ expected=ptr_, trusted_ptr_, rcu_ptr_")
> +__msg("Caller passes invalid args into func#{{.*}} ('subprog_trusted_task_nullable')")
> +int untrusted_to_trusted(void *ctx)
> +{
> +       return subprog_untrusted2(bpf_get_current_task_btf());
> +}
> +
>  char _license[] SEC("license") = "GPL";
> --
> 2.47.1
>
>

