Return-Path: <bpf+bounces-4395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2577B74A9E2
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 06:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9E8281637
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 04:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F5E1FAB;
	Fri,  7 Jul 2023 04:22:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541271876
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 04:22:45 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D5EE65
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 21:22:43 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so2130432e87.3
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 21:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688703762; x=1691295762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfmggFqmyue1uR61qiDJbG5VAckO0GKKFSXe25pAQ58=;
        b=U/q+zmG5Y3nuSaxKfHW1H/EL24mYin/MCQuIJ80DFstv3gsnPR7xuGG48zfsYpRcaG
         RkEiPGcGtN+ZQGivMfZj9CFPiZK/FK9yDSgiGe4bmtSaJiiA45FotOCdoN3yxqT+qGu0
         /vllwC1zUKeHip/fLh90fDAEGp0dePKHCRkRREFNNjSwTjlJA2IUotgLjNHuupREn2oH
         42wRuadMchAng85FM1Eo1/JZLQn+viDTJgGB73hyBz78CtewRIl2NNq/j1U6rCTtmpi5
         U3BxUH9wjgIvToN/4+K5KE7IZeVOPqcuk2TSpb5NPt6KfIbBxPrat8Z8ACNmng6ZNQCO
         UX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688703762; x=1691295762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfmggFqmyue1uR61qiDJbG5VAckO0GKKFSXe25pAQ58=;
        b=kWWan1LHp2pdkfTGUsTweBhOy3/pik7MwjsW0YHMtR7/cKLz2FOE0KlNfblKurnIDf
         OSslVy0bduJc+EB3JOLazoHrwUQLlro2oZu/kAtPnxgHt7nC8z7afbaN+tKAeiCKMI9j
         tTy3d20dhFzg2Kz2pJoQXPr9hHKJa5tNgY24SRs4nFYGbvlnyA4VvT5zOphJkjXNLJ/6
         Fu9gV92mRvoLNxtoNaLuOthAfy5nEqwyzWmVejz92VSYt5wiu5Y41GFfwsCKTHoNwioX
         4xRFxg37SlyESzicUzAvcAtWbqMFoiFDJyEAVtn0RSvCbbHz+cir5i8McZdC45QpWBV3
         AVlw==
X-Gm-Message-State: ABy/qLbHp45WPjxyokREgCmC0zLitEO6iDg7kuuwbOQcuBS+cj2p+Esv
	bsFxtnVYRxbD+G7PiTZjgnl+nlmvKisw1aKtL2Y=
X-Google-Smtp-Source: APBJJlGZZjMUa5q0Usn6K/muGAhcnh9zlSF4XKiOMvrQyt7YDgv0FNlj9VIviAzluSttMi2Rwi6zgy4uvk5Zfi0nvoc=
X-Received: by 2002:a05:6512:70f:b0:4fb:889a:b410 with SMTP id
 b15-20020a056512070f00b004fb889ab410mr2677632lfs.65.1688703761442; Thu, 06
 Jul 2023 21:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-3-jolsa@kernel.org>
In-Reply-To: <20230630083344.984305-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Jul 2023 21:22:29 -0700
Message-ID: <CAEf4BzbxuCRmk3fTkpAM0=GPJErKQq-FezqGEf05zueFcWJa6g@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 02/26] bpf: Add multi uprobe link
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

On Fri, Jun 30, 2023 at 1:34=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding new multi uprobe link that allows to attach bpf program
> to multiple uprobes.
>
> Uprobes to attach are specified via new link_create uprobe_multi
> union:
>
>   struct {
>           __u32           flags;
>           __u32           cnt;
>           __aligned_u64   path;
>           __aligned_u64   offsets;
>           __aligned_u64   ref_ctr_offsets;
>   } uprobe_multi;
>
> Uprobes are defined for single binary specified in path and multiple
> calling sites specified in offsets array with optional reference
> counters specified in ref_ctr_offsets array. All specified arrays
> have length of 'cnt'.
>
> The 'flags' supports single bit for now that marks the uprobe as
> return probe.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/trace_events.h   |   6 +
>  include/uapi/linux/bpf.h       |  14 ++
>  kernel/bpf/syscall.c           |  14 +-
>  kernel/trace/bpf_trace.c       | 237 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  14 ++
>  5 files changed, 282 insertions(+), 3 deletions(-)
>

[...]

> +       flags =3D attr->link_create.uprobe_multi.flags;
> +       if (flags & ~BPF_F_UPROBE_MULTI_RETURN)
> +               return -EINVAL;
> +
> +       /*
> +        * path, offsets and cnt are mandatory,
> +        * ref_ctr_offsets is optional
> +        */
> +       upath =3D u64_to_user_ptr(attr->link_create.uprobe_multi.path);
> +       uoffsets =3D u64_to_user_ptr(attr->link_create.uprobe_multi.offse=
ts);
> +       cnt =3D attr->link_create.uprobe_multi.cnt;
> +
> +       if (!upath || !uoffsets || !cnt)
> +               return -EINVAL;

see below for -EBADF, but we can also, additionally, return -EPROTO
here, for example?

> +
> +       uref_ctr_offsets =3D u64_to_user_ptr(attr->link_create.uprobe_mul=
ti.ref_ctr_offsets);
> +
> +       name =3D strndup_user(upath, PATH_MAX);
> +       if (IS_ERR(name)) {
> +               err =3D PTR_ERR(name);
> +               return err;
> +       }
> +
> +       err =3D kern_path(name, LOOKUP_FOLLOW, &path);
> +       kfree(name);
> +       if (err)
> +               return err;
> +
> +       if (!d_is_reg(path.dentry)) {
> +               err =3D -EINVAL;

as I mentioned in another patch, -EBADF here for feature detection
(and it makes sense by itself, probably)

> +               goto error_path_put;
> +       }
> +
> +       err =3D -ENOMEM;
> +
> +       link =3D kzalloc(sizeof(*link), GFP_KERNEL);
> +       uprobes =3D kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL);
> +
> +       if (!uprobes || !link)
> +               goto error_free;
> +
> +       if (uref_ctr_offsets) {
> +               ref_ctr_offsets =3D kvcalloc(cnt, sizeof(*ref_ctr_offsets=
), GFP_KERNEL);
> +               if (!ref_ctr_offsets)
> +                       goto error_free;
> +       }
> +

[...]

