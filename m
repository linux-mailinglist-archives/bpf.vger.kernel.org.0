Return-Path: <bpf+bounces-7499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF227782F7
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 23:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6419281EAD
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 21:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC71025142;
	Thu, 10 Aug 2023 21:57:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AD222F02
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 21:57:24 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477D4ED
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 14:57:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d41bfd5e507so1375479276.3
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 14:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691704641; x=1692309441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MNwLy3iHZtOpcl0meS/wC+MlR+oWmH9NnQj2g+LUwL8=;
        b=IhNUAiMeKyD7T6gFhFBhkb+A0pYbVfWj2qjbGtMLMcd5yyRVwaMACnSxNjtCyOij9u
         pwhH89dPquHDmA+kcLk4m4u8YdBmT+jfqyclMcbjW4LRCHCP1toChQvrMnJa4dxXT0UY
         kLCzi35W0lvlWmZ0IdqiZV8LmdT1Y34ettYn3iisJLpbpPFILaeLjZHTizIq1HulSFN6
         0Avq89czrlvDJlzQCoSVj2xXvtdccs8mSGamZbVf2SYRZkOgq7vs+4jDT+VBP56s7m+A
         nNJ3E3ou4QABbo9RNDaBz2NhbkM4K0EgyH3cxeNo0713eTu7h5Fc6pMgveZwuLJGS9/I
         nOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691704641; x=1692309441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNwLy3iHZtOpcl0meS/wC+MlR+oWmH9NnQj2g+LUwL8=;
        b=QML/Lrd62eb6sQwgGmxIuibTr5v1j814dGZRUna52WxE+lGGS3fYPlWArsWEnM3AQ+
         TiO9G/duBVEYYPSAe0T1mLY0fBzSRpJLGiT4ajuKqR1J6ghPs8z2S90K4Pv8lnBKYZLi
         FzUjBvy0KEuexH3z4D6KiRv14Fi+Ow2SH2d2eKqCZFwKYd3N+S+VQh6BEuNPxuuIEzqv
         793IJFZhrwmUs3seUB8Ec2BBC04ZjLHo24iePZwUEQmVqD18J1IUVZcvNz1FWbzN9ixr
         M3L8XMnNKohkAxvfUVcgjj2wrOztfHgZ1naTOxVhepE3PZSyzuyqxl91uvsKZNi31eqX
         uh7Q==
X-Gm-Message-State: AOJu0YybaqNpKIcpSl8raKMpxn5bL49dbgRkio3vTEczKpcW90A+VxnU
	CUSr5+pAlhiWB61wc0uftgati/0=
X-Google-Smtp-Source: AGHT+IFsyof2NL/dYaUfbxcL3lvCoXo5tZDKsBLCsWMhclWtvt/1uJfhLbGNPF6aDg3Sa73QDaWO6XM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:160e:b0:d4b:99ce:5e51 with SMTP id
 bw14-20020a056902160e00b00d4b99ce5e51mr58872ybb.6.1691704641553; Thu, 10 Aug
 2023 14:57:21 -0700 (PDT)
Date: Thu, 10 Aug 2023 14:57:19 -0700
In-Reply-To: <20230810183513.684836-3-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230810183513.684836-1-davemarchevsky@fb.com> <20230810183513.684836-3-davemarchevsky@fb.com>
Message-ID: <ZNVdP0mA9REeLQJj@google.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Introduce task_vma open-coded iterator kfuncs
From: Stanislav Fomichev <sdf@google.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Nathan Slingerland <slinger@meta.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/10, Dave Marchevsky wrote:
> This patch adds kfuncs bpf_iter_task_vma_{new,next,destroy} which allow
> creation and manipulation of struct bpf_iter_task_vma in open-coded
> iterator style. BPF programs can use these kfuncs directly or through
> bpf_for_each macro for natural-looking iteration of all task vmas.
> 
> The implementation borrows heavily from bpf_find_vma helper's locking -
> differing only in that it holds the mmap_read lock for all iterations
> while the helper only executes its provided callback on a maximum of 1
> vma. Aside from locking, struct vma_iterator and vma_next do all the
> heavy lifting.
> 
> The newly-added struct bpf_iter_task_vma has a name collision with a
> selftest for the seq_file task_vma iter's bpf skel, so the selftests/bpf/progs
> file is renamed in order to avoid the collision.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Cc: Nathan Slingerland <slinger@meta.com>
> ---
>  include/uapi/linux/bpf.h                      |  5 ++
>  kernel/bpf/helpers.c                          |  3 +
>  kernel/bpf/task_iter.c                        | 56 +++++++++++++++++++
>  tools/include/uapi/linux/bpf.h                |  5 ++
>  tools/lib/bpf/bpf_helpers.h                   |  8 +++
>  .../selftests/bpf/prog_tests/bpf_iter.c       | 26 ++++-----
>  ...f_iter_task_vma.c => bpf_iter_task_vmas.c} |  0
>  7 files changed, 90 insertions(+), 13 deletions(-)
>  rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c => bpf_iter_task_vmas.c} (100%)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d21deb46f49f..c4a65968f9f5 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7291,4 +7291,9 @@ struct bpf_iter_num {
>  	__u64 __opaque[1];
>  } __attribute__((aligned(8)));
>  
> +struct bpf_iter_task_vma {

[..]

> +	__u64 __opaque[9]; /* See bpf_iter_num comment above */
> +	char __opaque_c[3];

Everything in the series makes sense, but this part is a big confusing
when reading without too much context. If you're gonna do a respin, maybe:

- __opaque_c[8*9+3] (or whatever the size is)? any reason for separate
  __u64 + char?
- maybe worth adding something like /* Opaque representation of
  bpf_iter_task_vma_kern; see bpf_iter_num comment above */.
  that bpf_iter_task_vma<>bpf_iter_task_vma_kern wasn't super apparent
  until I got to the BUG_ON part

