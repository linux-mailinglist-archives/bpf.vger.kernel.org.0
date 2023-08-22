Return-Path: <bpf+bounces-8318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FF2784D62
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 01:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C89A2811C0
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 23:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9C620EFD;
	Tue, 22 Aug 2023 23:37:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B2320EE3
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 23:37:16 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C6DCF
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 16:37:14 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so12459421a12.1
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 16:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692747433; x=1693352233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sh4Ht/ksIutfttokE/U1auB5fjhoeiFEDZdP+DXvXDY=;
        b=lwNBKvCz1QnoBB1wbLQegjS883YwfuvL1R5y3r5EOyZYhgjG/+QVtjX+eXjuCD+iaE
         xJzaFDxWBOOOqE1BjNLb9YSxJeS/jWRdhdQ+dOQ+2YOV1FouInKGp+IWSVSZMdI4SHxR
         +eFw7WUBdClQPhQohj9cWrWx5Z4RSwg6VCUyBRTrCZX7ZQibjGwgV+2w4rwpY5QIyyFg
         uzkIj5Evjb6HXaeEKRHkj9mYrEwFYhILuS3zSSuqN/VmYb2RB44XpyIU3OogkvWb2odn
         Z6v7uq6K88WfhZC8S5LLltQD1oXw3EuO4+nYNHVPAmCJBa5zuXrJkZgcpOz6bgIiSJl3
         xO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692747433; x=1693352233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sh4Ht/ksIutfttokE/U1auB5fjhoeiFEDZdP+DXvXDY=;
        b=kkgwOJ5Xn5uoR3nfqBQzBYDBIElyMWsR6PK+KjcqVN4fiiH6cgqAkKhTD8XdoF5nnp
         U/2foCDrvsOAlXdrlACjxypSDHyWzh4V/zAGmtrzw3i+/XO+1xTDFDpcnM1NcpCLTxft
         n1vj/t9qFJRPhtpaq873Jv5QshipJzu/EjTM3UylfYtUKrSfci9aGqlUkHSw29+19Sti
         7DhmHxrEfttBfMFfssOdnuIvpYgZQ5GdFMVMk5KT57F5KHSTJkUe0Ege1B49FADubx6g
         mupECzhS8yMLdIgkGhKyiKrpVsLTBZIAYOMZINl9IB4dEhox0auJTFv+l+tD73sVkJCE
         JrwQ==
X-Gm-Message-State: AOJu0YxWfvYYTSpUTOj8kN9tzCzP9b1ztf7j/Nup/yMy3Rx2LthRxEQz
	YyfJ0qTiRei+RIpDbli9k5XQFT1at6ZeTrYDhzM=
X-Google-Smtp-Source: AGHT+IGQFYlyDPVrN/o/YvpJNAtbksCU6nFQGH991Oxuysvzo00ZHyG/o/6jPxmQDRnMRV0ipVHjhblIv8Vm3BZrNh4=
X-Received: by 2002:a05:6402:b37:b0:522:b876:9ef5 with SMTP id
 bo23-20020a0564020b3700b00522b8769ef5mr12597454edb.8.1692747432673; Tue, 22
 Aug 2023 16:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230822050558.2937659-1-davemarchevsky@fb.com> <20230822050558.2937659-2-davemarchevsky@fb.com>
In-Reply-To: <20230822050558.2937659-2-davemarchevsky@fb.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Aug 2023 16:37:00 -0700
Message-ID: <CAEf4Bzb8ce=Y9t0Yth=bamyTDwkVgTO8UVAQ-7DM8HXrEoXA9g@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: Don't explicitly emit BTF for struct btf_iter_num
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, yonghong.song@linux.dev, 
	sdf@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 10:06=E2=80=AFPM Dave Marchevsky <davemarchevsky@fb=
.com> wrote:
>
> Commit 6018e1f407cc ("bpf: implement numbers iterator") added the
> BTF_TYPE_EMIT line that this patch is modifying. The struct btf_iter_num
> doesn't exist, so only a forward declaration is emitted in BTF:
>
>   FWD 'btf_iter_num' fwd_kind=3Dstruct
>
> That commit was probably hoping to ensure that struct bpf_iter_num is
> emitted in vmlinux BTF. A previous version of this patch changed the
> line to emit the correct type, but Yonghong confirmed that it would
> definitely be emitted regardless in [0], so this patch simply removes
> the line.
>
> This isn't marked "Fixes" because the extraneous btf_iter_num FWD wasn't
> causing any issues that I noticed, aside from mild confusion when I
> looked through the code.
>
>   [0]: https://lore.kernel.org/bpf/25d08207-43e6-36a8-5e0f-47a913d4cda5@l=
inux.dev/
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/bpf_iter.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index 96856f130cbf..833faa04461b 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -793,8 +793,6 @@ __bpf_kfunc int bpf_iter_num_new(struct bpf_iter_num =
*it, int start, int end)
>         BUILD_BUG_ON(sizeof(struct bpf_iter_num_kern) !=3D sizeof(struct =
bpf_iter_num));
>         BUILD_BUG_ON(__alignof__(struct bpf_iter_num_kern) !=3D __alignof=
__(struct bpf_iter_num));
>
> -       BTF_TYPE_EMIT(struct btf_iter_num);
> -

heh, hard to notice this typo... I think I needed it for the version
of patch set before the switch to kfunc, so yeah, we don't need it
anymore, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>         /* start =3D=3D end is legit, it's an empty range and we'll just =
get NULL
>          * on first (and any subsequent) bpf_iter_num_next() call
>          */
> --
> 2.34.1
>

