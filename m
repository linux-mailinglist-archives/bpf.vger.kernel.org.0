Return-Path: <bpf+bounces-8703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C1C78903B
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 23:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CE72818AE
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 21:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674F5193B9;
	Fri, 25 Aug 2023 21:14:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB9219386
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 21:14:04 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AD8211E
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 14:14:03 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52a1132b685so2052908a12.1
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 14:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692998041; x=1693602841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1Dq8cfoaWgutFoZvuhSiT5t3e7vxsDH0IeD/f3DW0Q=;
        b=RcUMytOzEz5w0bKQu942i00eZP+UZwy90m+JEy93XaNK+vxD+KpTBMKAzduuCX/quI
         8KH91tNyfr8HLGB4zhIwyXP/U9brY2AE5yBjjlPe9+ZKGVYZH5TuueBuAGEYQ+1Dxbil
         sJKpT2wa52BEqMMEFV/uAylLCmwYrEstdD1pTUULjBHxS3Y74gGOhhxUIUwLDQCoggPd
         lcyLmsnhyI3OOM5aaIZoVp6ZxLT/YV3ZuWorwhxV+icxSgbC1Q7uneB1tDx1gSRh6xZR
         1KJCs5BiacDguRcbbwZBSrUfwdoiBnbf2sgi8fvCwm79FatffNRF+HhpFhkALWNGj1Sn
         yjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692998041; x=1693602841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1Dq8cfoaWgutFoZvuhSiT5t3e7vxsDH0IeD/f3DW0Q=;
        b=Edi9nbI+4TMDKRT3YiYvfcOdCq982kjZCP5WKeJXw1L3Slw5ivCK23Q4cq0NlR8LiA
         75b6SymwuFxL3s/SkNXRCVQQ7/FjuBioUyI9DtkP13wJMM/GKYKbVfMJLT8OGw/ZdCl7
         cSYuVh3esvPV2SnajjVYVgHBZd/TYPpNoMfFh5l/zlM8KZFuDVvVU3X9lYpk0BLL58ES
         CNo86gNhhaPPlECjendYJ7hl/vS5eMvhBtLNkDssMydzE2CQSMBj36dHi6jqgOSHPLbj
         NsLtZniQ+5rYAKS0nzb5A1ZPEoIRzNbdqxTH3WMIkSqDArYvUXeB5bAnimUByBIQpdAO
         pmHA==
X-Gm-Message-State: AOJu0YxZsAOEFr3t5e/vXTfw2ek20Xc6tdzb6j5H6k09BiykpfqKwquc
	+gR3lM5Q3E0RBa3VF3BTk3ZwfXpR5wPonkbnxnQSNp9o
X-Google-Smtp-Source: AGHT+IFbH5MqVxLs75tIRDywJASu87mr7TZybbE4DvJHwdWpC5PiS2EtFlSD53+2TpM+5WqtrVfL1c6N82H99R8kBBQ=
X-Received: by 2002:a05:6402:339:b0:523:2811:5531 with SMTP id
 q25-20020a056402033900b0052328115531mr16351437edw.4.1692998041395; Fri, 25
 Aug 2023 14:14:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230825195328.92126-1-yonghong.song@linux.dev> <20230825195359.94315-1-yonghong.song@linux.dev>
In-Reply-To: <20230825195359.94315-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Aug 2023 14:13:49 -0700
Message-ID: <CAEf4BzaA6y5sru6y0HK=6u4n+F-tOZ+5TFvBCbiMfRj7Ti-iUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 06/13] libbpf: Add __percpu_kptr macro definition
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 25, 2023 at 12:54=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> Add __percpu_kptr macro definition in bpf_helpers.h.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/lib/bpf/bpf_helpers.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index bbab9ad9dc5a..77ceea575dc7 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -181,6 +181,7 @@ enum libbpf_tristate {
>  #define __ksym __attribute__((section(".ksyms")))
>  #define __kptr_untrusted __attribute__((btf_type_tag("kptr_untrusted")))
>  #define __kptr __attribute__((btf_type_tag("kptr")))
> +#define __percpu_kptr __attribute__((btf_type_tag("percpu_kptr")))

total nitpick, but given kptr_untrusted, should this stick to the
pattern and be __kptr_percpu? It keeps this "kptr" umbrella/namespace
consistent

>
>  #define bpf_ksym_exists(sym) ({                                         =
                               \
>         _Static_assert(!__builtin_constant_p(!!sym), #sym " should be mar=
ked as __weak");       \
> --
> 2.34.1
>

