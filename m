Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA386EFACE
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 21:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbjDZTO7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 15:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239593AbjDZTOy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 15:14:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A4C4683
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:14:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94f0dd117dcso1110412866b.3
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682536470; x=1685128470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGqEnYAnG4Q3VPm1Ke7WmD5YQbCYEfs4z8luTPzLEas=;
        b=QYyKpYDNbMdeSpDXOo6aVhjmI+BlGRprznWdiys3DsmjR7czTm2cxY5Lvruw+jOH6H
         6Lodn8mHDJCPVEjYNNPUuNOyHbfG5S0cguNWuoFmgRDSVN+l2SlPRNAknqae7VvM5YY+
         VyCAcc4TX6d9nowH5GsJZ/Z8gpPkysRzk433SYeizHvfJc+1bXroGBZ89bhexJTwFteB
         r08Bg3N6QSalfAmle5xAiqmxW90n8M2dmQM1JznPk/d6XwXalSW6wlnmZhpo6TPkdIz6
         M8NkfMUUkf2Hpy26w1xXjdDDPcsI9sKXvfyKw2EH6IrnVU3Tc59ngiY+wCvxiUYib4CL
         uLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682536470; x=1685128470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGqEnYAnG4Q3VPm1Ke7WmD5YQbCYEfs4z8luTPzLEas=;
        b=ItI2wGN41RSEvhuLcUMkaTAJ4DFLH5BB7U3r+mlVzZCV4l5CqsgC1MvkMdo7LfgyLo
         tpjvBbkbywAayORFwdmIW241B264kNj8sn28BcICC6dxrykrSxCULgnPnIeUxDENcGLI
         6KZ9nAuUOqaOQ76xSCu0tvDAVhGIbL4nYmHvBux7Cf/TEtU9mwkZBLpSUT/8mfQ6Z8Lg
         4Kj2O8082HZxCTX3wF1b1d5BppVICtDKV2H5pzidD3wXhTDFhwB2ho+sVbNf8Zeorvpd
         UCEwOyNQzoBJ/o8aA5oMZ1wFmnr81wkSoanUHNHYODuLpCaCnBWN+CWj4pnaQus4mcP2
         gw1g==
X-Gm-Message-State: AAQBX9eOvRvDTl+WtOHk8mAPbISjqIQe+wZEQznxNhSjAlYAbuiWC+s5
        bZ3NBP9HmNUwSDM82yqG3CN017DQys9W8M5KzbIXSWKj
X-Google-Smtp-Source: AKy350a4oRftU5cGTCt86rWeWN6NMWZpZxB1fteHFHkM1kFRcnkjulCeumnHGmHhnGOEBzSV6cOQvyc5cEbQR2iMP5o=
X-Received: by 2002:a17:907:7616:b0:953:4db7:c30e with SMTP id
 jx22-20020a170907761600b009534db7c30emr16879807ejc.76.1682536470298; Wed, 26
 Apr 2023 12:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230424160447.2005755-1-jolsa@kernel.org> <20230424160447.2005755-5-jolsa@kernel.org>
In-Reply-To: <20230424160447.2005755-5-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 12:14:18 -0700
Message-ID: <CAEf4BzZOsy0wC_RFHfJrG9zLjPUa86EencCOZto8FMnOMCpFOQ@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next 04/20] libbpf: Update uapi bpf.h tools header
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 24, 2023 at 9:05=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Updating uapi bpf.h tools header with new uprobe_multi
> link interface.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

let's merge this with the original UAPI header update patch? We used
to split this out for libbpf sync purposes, but it is handled easily
with current sync script, so no  need to make this a separate patch
(but up to you, I don't mind either)

>  tools/include/uapi/linux/bpf.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 1bb11a6ee667..77ce2159478d 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1035,6 +1035,7 @@ enum bpf_attach_type {
>         BPF_TRACE_KPROBE_MULTI,
>         BPF_LSM_CGROUP,
>         BPF_STRUCT_OPS,
> +       BPF_TRACE_UPROBE_MULTI,
>         __MAX_BPF_ATTACH_TYPE
>  };
>
> @@ -1052,6 +1053,7 @@ enum bpf_link_type {
>         BPF_LINK_TYPE_KPROBE_MULTI =3D 8,
>         BPF_LINK_TYPE_STRUCT_OPS =3D 9,
>         BPF_LINK_TYPE_NETFILTER =3D 10,
> +       BPF_LINK_TYPE_UPROBE_MULTI =3D 11,
>
>         MAX_BPF_LINK_TYPE,
>  };
> @@ -1169,6 +1171,11 @@ enum bpf_link_type {
>   */
>  #define BPF_F_KPROBE_MULTI_RETURN      (1U << 0)
>
> +/* link_create.uprobe_multi.flags used in LINK_CREATE command for
> + * BPF_TRACE_UPROBE_MULTI attach type to create return probe.
> + */
> +#define BPF_F_UPROBE_MULTI_RETURN      (1U << 0)
> +
>  /* When BPF ldimm64's insn[0].src_reg !=3D 0 then this can have
>   * the following extensions:
>   *
> @@ -1568,6 +1575,14 @@ union bpf_attr {
>                                 __s32           priority;
>                                 __u32           flags;
>                         } netfilter;
> +                       struct {
> +                               __u32           flags;
> +                               __u32           cnt;
> +                               __aligned_u64   paths;
> +                               __aligned_u64   offsets;
> +                               __aligned_u64   ref_ctr_offsets;
> +                               __aligned_u64   cookies;
> +                       } uprobe_multi;
>                 };
>         } link_create;
>
> --
> 2.40.0
>
