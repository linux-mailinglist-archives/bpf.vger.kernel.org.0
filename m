Return-Path: <bpf+bounces-3311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DB573C094
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 22:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92761C21273
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 20:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E32D11CA6;
	Fri, 23 Jun 2023 20:40:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2B011C80
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 20:40:58 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAFC2D5D
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 13:40:25 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f9002a1a39so11839205e9.2
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 13:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687552816; x=1690144816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEGQ4AAG7X+wsjZkk83FYWWdsAXkRzXEWCUoTyJ85b8=;
        b=lWRcKEvHSaqlxP5Ij/mGQkjNHePBJUo7WAWzjd90yPcarTKOmIFUom+BHUHWPBFw6V
         hfyMDTodOktQIFwqG9p4NrVgPYBCOniOW8bb+Ds0Khed6ahnQY54QXmBhRShi4B4pYfw
         JPvSjNjSBE/YPOI8bGIO14aQSqTme7avJSbLuvnUX7FLiMkR/SdQo6JqFVnNr2LxJ2pH
         fdCIBxWL2tOdorFkUElcErS/rf0YCps0xwGntbiWk1eZlgjiHpAJqZgxkEMc/XIggHrh
         27rL9kc5SWeQIT++RyFOHFmS7G27WiWLb6I6DFpCspMCeEQIWrxbyxLZmlOeut5oUHNM
         hUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687552816; x=1690144816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEGQ4AAG7X+wsjZkk83FYWWdsAXkRzXEWCUoTyJ85b8=;
        b=lTrpEdUr63t4PDobDgTPTjPkBZ6zOd9HMpCOCoYe3Huvls8cxKYN23XdKGNEuIjq7X
         1SzRAgPGD2DZv6NndW0NOd6t8ZkFX1pK8O4UonkK3QmB5cc7QA1F62li3lvDDwL0cK16
         /zL9LxnvdmAYz3OEftfZvBBdbuQAqpZwyCw7hu6bcmyetoOsQmgzbmhdvKu1En2FMzSH
         VXlX03mNbKfpWmwg6mudMGmQ3VxBIXIHKhzEmOLydfZbs4JjcsCd/RcrCrG9EYcWdMiR
         ub7DM0F7LLvfwBoT+gztc9J9xMn2eWTsiO190g0sy456nscZy2wcoFNHL8by+A8uT4SP
         4d9g==
X-Gm-Message-State: AC+VfDyVE13mRVvZ46EcOGeHs/f4k5CnrrPMtgqcs1AcFbR+Za4Txjwo
	mqMBpKk2DKbZ59tjXNDS07Tfz5GzzcAyqK15jbI=
X-Google-Smtp-Source: ACHHUZ4rKQ5d33ZI1seqPIDK5x2WZoueuwgs27/7mGze7vALTHE4qhyF7S99iv9bZc5y8ZkVQje8GhvaDnMTWiM1kd8=
X-Received: by 2002:a05:600c:b44:b0:3fa:82ae:3577 with SMTP id
 k4-20020a05600c0b4400b003fa82ae3577mr448951wmr.9.1687552815556; Fri, 23 Jun
 2023 13:40:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620083550.690426-1-jolsa@kernel.org> <20230620083550.690426-11-jolsa@kernel.org>
In-Reply-To: <20230620083550.690426-11-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jun 2023 13:40:02 -0700
Message-ID: <CAEf4Bza78pPp_FKx5+y1P5qaNrmVr9WWeV0ZHPS14fTurbX80Q@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 10/24] libbpf: Add bpf_link_create support for
 multi uprobes
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

On Tue, Jun 20, 2023 at 1:37=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding new uprobe_multi struct to bpf_link_create_opts object
> to pass multiple uprobe data to link_create attr uapi.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/bpf.c | 11 +++++++++++
>  tools/lib/bpf/bpf.h | 11 ++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index ed86b37d8024..0fd35c91f50c 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -733,6 +733,17 @@ int bpf_link_create(int prog_fd, int target_fd,
>                 if (!OPTS_ZEROED(opts, kprobe_multi))
>                         return libbpf_err(-EINVAL);
>                 break;
> +       case BPF_TRACE_UPROBE_MULTI:
> +               attr.link_create.uprobe_multi.flags =3D OPTS_GET(opts, up=
robe_multi.flags, 0);
> +               attr.link_create.uprobe_multi.cnt =3D OPTS_GET(opts, upro=
be_multi.cnt, 0);
> +               attr.link_create.uprobe_multi.path =3D ptr_to_u64(OPTS_GE=
T(opts, uprobe_multi.path, 0));
> +               attr.link_create.uprobe_multi.offsets =3D ptr_to_u64(OPTS=
_GET(opts, uprobe_multi.offsets, 0));
> +               attr.link_create.uprobe_multi.ref_ctr_offsets =3D ptr_to_=
u64(OPTS_GET(opts, uprobe_multi.ref_ctr_offsets, 0));
> +               attr.link_create.uprobe_multi.cookies =3D ptr_to_u64(OPTS=
_GET(opts, uprobe_multi.cookies, 0));
> +               attr.link_create.uprobe_multi.pid =3D OPTS_GET(opts, upro=
be_multi.pid, 0);
> +               if (!OPTS_ZEROED(opts, uprobe_multi))
> +                       return libbpf_err(-EINVAL);
> +               break;
>         case BPF_TRACE_FENTRY:
>         case BPF_TRACE_FEXIT:
>         case BPF_MODIFY_RETURN:
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 9aa0ee473754..82979b4f2769 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -346,13 +346,22 @@ struct bpf_link_create_opts {
>                         const unsigned long *addrs;
>                         const __u64 *cookies;
>                 } kprobe_multi;
> +               struct {
> +                       __u32 flags;
> +                       __u32 cnt;
> +                       const char *path;
> +                       const unsigned long *offsets;
> +                       const unsigned long *ref_ctr_offsets;
> +                       const __u64 *cookies;
> +                       __u32 pid;
> +               } uprobe_multi;
>                 struct {
>                         __u64 cookie;
>                 } tracing;
>         };
>         size_t :0;
>  };
> -#define bpf_link_create_opts__last_field kprobe_multi.cookies
> +#define bpf_link_create_opts__last_field uprobe_multi.pid
>
>  LIBBPF_API int bpf_link_create(int prog_fd, int target_fd,
>                                enum bpf_attach_type attach_type,
> --
> 2.41.0
>

