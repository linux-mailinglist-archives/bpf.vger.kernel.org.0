Return-Path: <bpf+bounces-2946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77B87372A0
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 19:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F211C20C8F
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFEC2AB47;
	Tue, 20 Jun 2023 17:20:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6074A2AB37
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 17:20:34 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A586DDC
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 10:20:32 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f954d78bf8so1207012e87.3
        for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687281631; x=1689873631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzNPjtwSyv2tNpSs5/kTzc+ULEw6bIPvaCDPAU1H2Wg=;
        b=VgvuePcMRhxXx5fzhWzscDl5sK/Br6GY0X8IHMffWB/i6OZVT7+6BaqRbR5zzfoiwf
         ht2N2GXls/UxCGb7xlR9yfhn9j2ECjBwqddsdMEOPeHHWKvV8h8x0VAKONp284cgcl3t
         06P9BOzzv46JbHJYNFE87rn8x1FPJVyF5YQlNDfVsuAL1FI7jgWv6LyTftyds5AU5yvh
         oVjAF7ua46jefmFRyKFuI6ZjTs17yGcWdILmelcB1JfcGE+6bBjGKGoi7eXCeFybjF9n
         KHjYpxnOd2kiYygTLK6CZpz0KnZqUJ1aPq2Gj7t7i4F29N9I3jOORYrtCpIzFjksxVN+
         5IAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687281631; x=1689873631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzNPjtwSyv2tNpSs5/kTzc+ULEw6bIPvaCDPAU1H2Wg=;
        b=KMx1dDgmW+JOi1Y9YM0LRomlyUz1+mf/vk9oUIZp1l68zBrVaa4VSeYh6AtiVuJbSj
         VkkYBIxqQAt/pGTDBq9VgwZ8LWBoxGQWscCtm3LvUc9B4gzbUA2JSryP40OsoHTYbX6B
         YGs+AhhcaeWc3wvAu34Uq/QfdsPwiiP2EZzRJIMxqpopzfYwkq/wd922zK9pyl24yhR+
         vGY+fcC5raItr8/Mi6f8xBe2daJs/Yafbr2PWZvY6ebuuzM+x244NBJz8ct8ssrH7gQW
         N0wUvkPpDRW8x9YULiaJ2np5uR6ucACwK1pX+A2eNB106M5LG63v9Q8QZwutcJFEyUiJ
         mG1g==
X-Gm-Message-State: AC+VfDwkXSSv3ZL5NQZobuiyklRLpVnReu6DIfyyEuehGd5E9jrdKo+t
	6FKY9cgVIin2jWCkXHkUIhtTD4tzDnHaFNtxE1g=
X-Google-Smtp-Source: ACHHUZ4NF/n2qhu5jbcM7h2CGFAexJi7aZakmyod2VtVA1MSy90CrxMN/UGCoaOaxDp0dQSVMA5rubSO6PvrzBoBUB8=
X-Received: by 2002:a19:da02:0:b0:4f7:6453:f3f1 with SMTP id
 r2-20020a19da02000000b004f76453f3f1mr2060519lfg.15.1687281630578; Tue, 20 Jun
 2023 10:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230618131414.75649-1-jolsa@kernel.org>
In-Reply-To: <20230618131414.75649-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 20 Jun 2023 10:20:18 -0700
Message-ID: <CAEf4BzakXdj4hrc-jGtUMzJVQnpfTi0NP0wAV7DGBLfVunL-UQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf] bpf: Force kprobe multi expected_attach_type for
 kprobe_multi link
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jun 18, 2023 at 6:14=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> We currently allow to create perf link for program with
> expected_attach_type =3D=3D BPF_TRACE_KPROBE_MULTI.
>
> This will cause crash when we call helpers like get_attach_cookie or
> get_func_ip in such program, because it will call the kprobe_multi's
> version (current->bpf_ctx context setup) of those helpers while it
> expects perf_link's current->bpf_ctx context setup.
>
> Making sure that we use BPF_TRACE_KPROBE_MULTI expected_attach_type
> only for programs attaching through kprobe_multi link.
>
> Fixes: ca74823c6e16 ("bpf: Add cookie support to programs attached with k=
probe multi link")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/syscall.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
>  v2 changes:
>  - moved the check to bpf_prog_attach_check_attach_type [Andrii]
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0c21d0d8efe4..129cc5c276c0 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3440,6 +3440,11 @@ static int bpf_prog_attach_check_attach_type(const=
 struct bpf_prog *prog,
>                 return prog->enforce_expected_attach_type &&
>                         prog->expected_attach_type !=3D attach_type ?
>                         -EINVAL : 0;
> +       case BPF_PROG_TYPE_KPROBE:
> +               if (prog->expected_attach_type =3D=3D BPF_TRACE_KPROBE_MU=
LTI &&
> +                   attach_type !=3D BPF_TRACE_KPROBE_MULTI)
> +                       return -EINVAL;
> +               fallthrough;

there is no point in falling through (other branches return without
falling through as well), so I replaced this with `return 0;` and
applied to bpf tree, thanks.


>         default:
>                 return 0;
>         }
> --
> 2.41.0
>

