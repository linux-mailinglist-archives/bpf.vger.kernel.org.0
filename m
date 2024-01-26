Return-Path: <bpf+bounces-20439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A40883E6C5
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 00:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C55290C99
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 23:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE135A7B0;
	Fri, 26 Jan 2024 23:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irqO79qX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FF151033
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 23:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311314; cv=none; b=THQY3FAlxE1WKHHBuLfv0fWqYWQSlImWxDQsCBF4fRIWQB8KK4LdiaNLwApQMCYgntAsYY0W+gWE1/tKD5akPshQWRVsogaWGRy34M2VYg1wCqPnInuzkI/3ATb/7abW4WXL5UEilJ59bD987SG1PVXW9VoHalzOZ0AbH12jJGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311314; c=relaxed/simple;
	bh=ULbD1mBY5VorOQKYnPVvw3NZwssTqWDaVa890uEozaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qROajpzUWUt7Kek8S5SXbxWauEKS3QgL9PIZtjMGnHcWwyY9q7euJlfh9pGuSRJzKUf0b5hIlLrPutxHrYR6wzshnxNzpxNERw8rSrTNBaeapFlnDeFWX/dsit8fQMfOMCqOBCNW1LpHHj10D5SU7ZGkD3CPosVlGwAs4BrQZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irqO79qX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ddc268ce2bso871065b3a.0
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 15:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706311313; x=1706916113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cSF6QzfoA1omz0AubWAP/5ZjE3N28LBbpDiLrqVgzE=;
        b=irqO79qXwGU9l++DcR05HdJs6+fFI1FpRbb7jbOM5lGJxH9Scjscb2zEpqYhkLyI8T
         sX88lE7nYe+9JGGk0K8JKkOSxaZKv1pZlr55XvOiN0tPgu0OLSMyTuzoi9WVPlj9yLXz
         WFfwYz1vxEjkJoh1voFmFKhiJmuuXwGh1ESlYfoT2HcuOL1k9lbU+DNsCZx2OOk02nUG
         PwAa+WnINYAzZ2vLcpUEIInxkIsRrLMsQa8vatm+ZKCF6hp05uVlpan/mn2V196MiLkW
         c+Iks1AGJy+9liamFHgvLTOgslm4xZhuadF9niCPmTW05hI0PhlEOvQFnkXELVY0lx+y
         SRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706311313; x=1706916113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cSF6QzfoA1omz0AubWAP/5ZjE3N28LBbpDiLrqVgzE=;
        b=YsO80ebXjVUqt5Ajf95mxusK7iYgcdUTQsg1m2ry83iGs72KXWWxflqewLseltAIZH
         6LkGphsf/BIIJLBmLjDSSk3szhO4UYq11tDHKCXfV+l7TaldP3mf3B3eZEtjulIt5dzw
         fdNIEqMhWFv8kXAfa+rOhxqMcC/Y+5OcGilBnvdatBVJMNLiaVqkAJIougj41oCEfI/P
         PvqDHmEfDZcJ0xXMP+21MOfn/nHkFCJP3nWOR+86lvYaLqXa/CC+0/SJku8L2C/qw/4I
         QrjVcUr/DS+N4HrKAlmOqKKS3d/i/OZlPwVPM6QVrPXgULADmCwsb5paIzBO1zYL8/mh
         OYSQ==
X-Gm-Message-State: AOJu0YzAEzUEbzkO32RSAmxovz8HDDq8GWFjyr9ei+dUZvvZphsyxgD6
	opcP+fADYI7k42INLVEdAAo7erAIDgM9vlFHblHctyxad7xUl+FRmPF7GJu3l32eL6leewxYMam
	FwSz1OLHg64Ji3zyI1xIiad6/0h8=
X-Google-Smtp-Source: AGHT+IHID/XX0SmCyKIp7ASDb8y62Ket+xl2iFtuh8VoY6SQUl8JG1nrsOhVz9RKV8RRlt34XCvOeuv5eaC1pogwW6Y=
X-Received: by 2002:a05:6a00:b03:b0:6dd:849a:d2f8 with SMTP id
 f3-20020a056a000b0300b006dd849ad2f8mr704460pfu.16.1706311312653; Fri, 26 Jan
 2024 15:21:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122212217.1391878-1-thinker.li@gmail.com>
In-Reply-To: <20240122212217.1391878-1-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Jan 2024 15:21:40 -0800
Message-ID: <CAEf4BzbQJXGw3w0RnjuUg=RRMDE9jGgOYxVcA9q9hbYnvFBHhg@mail.gmail.com>
Subject: Re: [RFC bpf-next v3] bpf, selftests/bpf: Support PTR_MAYBE_NULL for
 struct_ops arguments.
To: thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, davemarchevsky@meta.com, 
	dvernet@meta.com, sinquersw@gmail.com, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 1:22=E2=80=AFPM <thinker.li@gmail.com> wrote:
>
> From: Kui-Feng Lee <thinker.li@gmail.com>
>
> Allow passing a null pointer to the operators provided by a struct_ops
> object. This is an RFC to collect feedbacks/opinions.
>
> The previous discussions against v1 came to the conclusion that the
> developer should did it in ".is_valid_access". However, recently, kCFI fo=
r
> struct_ops has been landed. We found it is possible to provide a generic
> way to annotate arguments by adding a suffix after argument names of stub
> functions. So, this RFC is resent to present the new idea.
>
> The function pointers that are passed to struct_ops operators (the functi=
on
> pointers) are always considered reliable until now. They cannot be
> null. However, in certain scenarios, it should be possible to pass null
> pointers to these operators. For instance, sched_ext may pass a null
> pointer in the struct task type to an operator that is provided by its
> struct_ops objects.
>
> The proposed solution here is to add PTR_MAYBE_NULL annotations to
> arguments and create instances of struct bpf_ctx_arg_aux (arg_info) for
> these arguments. These arg_infos will be installed at
> prog->aux->ctx_arg_info and will be checked by the BPF verifier when
> loading the programs. When a struct_ops program accesses arguments in the
> ctx, the verifier will call btf_ctx_access() (through
> bpf_verifier_ops->is_valid_access) to verify the access. btf_ctx_access()
> will check arg_info and use the information of the matched arg_info to
> properly set reg_type.
>
> For nullable arguments, this patch sets an arg_info to label them with
> PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL. This enforces the verifier =
to
> check programs and ensure that they properly check the pointer. The
> programs should check if the pointer is null before reading/writing the
> pointed memory.
>
> The implementer of a struct_ops should annotate the arguments that can be
> null. The implementer should define a stub function (empty) as a
> placeholder for each defined operator. The name of a stub function should
> be in the pattern "<st_op_type>_stub_<operator name>". For example, for
> test_maybe_null of struct bpf_testmod_ops, it's stub function name should
> be "bpf_testmod_ops_stub_test_maybe_null". You mark an argument nullable =
by
> suffixing the argument name with "__nullable" at the stub function.  Here
> is the example in bpf_testmod.c.
>
>   static int bpf_testmod_ops_stub_test_maybe_null(int dummy, struct
>                 task_struct *task__nullable)

let's keep this consistent with __arg_nullable/__arg_maybe_null? ([0])
I'd very much prefer __arg_nullable and __nullable vs
__arg_maybe_null/__maybe_null, but Alexei didn't like the naming when
I posted v1.

But in any case, I think it helps to keep similar concepts named
similarly, right?

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20240125205510.3=
642094-6-andrii@kernel.org/

>   {
>           return 0;
>   }
>
> This means that the argument 1 (2nd) of bpf_testmod_ops->test_maybe_null,
> which is a function pointer that can be null. With this annotation, the
> verifier will understand how to check programs using this arguments.  A B=
PF
> program that implement test_maybe_null should check the pointer to make
> sure it is not null before using it. For example,
>
>   if (task__nullable)
>       save_tgid =3D task__nullable->tgid
>
> Without the check, the verifier will reject the program.
>
> Since we already has stub functions for kCFI, we just reuse these stub
> functions with the naming convention mentioned earlier. These stub
> functions with the naming convention is only required if there are nullab=
le
> arguments to annotate. For functions without nullable arguments, stub
> functions are not necessary for the purpose of this patch.
>
> ---
>

[...]

