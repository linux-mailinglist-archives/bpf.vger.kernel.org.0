Return-Path: <bpf+bounces-7899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 718EA77E379
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 16:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3B51C21087
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 14:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3A9125BF;
	Wed, 16 Aug 2023 14:24:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F831111A4
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 14:24:16 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445661999
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 07:24:15 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-6430bf73e1cso33155906d6.0
        for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 07:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692195854; x=1692800654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vP/ltVhB3rkbXk8GQDKBg0KAtKOitkIEXY5BCLEBmFc=;
        b=ek9TQMsuUznUwtd8+BBCtDx+FY8D+wgFAh/eLIWME6h/sER2dzXdBieC2KhJR5e2X1
         PGp7ar/U7xRQx56yvCWyRZzJIY6UMtmYfUxnJyKFtURO39hKGLjHN/hP2cM/cf1CERbb
         OXrVCnpJs/rBHMWPy998qDiyQR75paT8q/HU46CU11zfHOl8yZxOqCfSgy8EeXfKjV4u
         MNVOu4TFyq9XpL5yvtP+t806vke+C7G3jkjT9zBQ9jNaQphlLOwREHkpHc3vSv/UfV8H
         G+N3HqSgPu1csLeHZRuC89uUzQwWLi8EIxHmp9gJFWF9J/vx9YnaVmphdgTwrm15KvCc
         7Jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692195854; x=1692800654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vP/ltVhB3rkbXk8GQDKBg0KAtKOitkIEXY5BCLEBmFc=;
        b=khL46WklNuSnr8hhG4+gBnxjbjiUlaT3WG3yXWlfFnmdSdeANxKx8pe2+8d0AbibVM
         U/nf4zlq4Rm4K6arXRUyoxdK7JvKo5q09ka4hVf2+vkOs2iReF33KkqzZz5fzvaE1Zq6
         TPQOrTxHoQjtD7cycioG6oMec5gtx46luzjuB4gyw3nqYnIsi2wpkDL6hMWlt49xmQKS
         d+Ncr52kEkGnowhdlXtYaRUju9TyrMukhRzzn5/UyleJQZwUHjEXwutmAL2/6WAdhiAy
         wmotOytpr1PRTi7MK9QG63RjugDL61HA1AEuAXYGvdi/pUiY24QbgYd0sl9iR9a5NX0v
         9g5A==
X-Gm-Message-State: AOJu0YzJMyxgDXYh0SYPcyoz5Yzf52tFcfHLZXx/NgOFd4P9eQfD1Wmc
	73LJ+x7KldkfEoG1xvMz9pd0gXORGjh7zp0HMY4=
X-Google-Smtp-Source: AGHT+IGCAsRPjudbDuZTCzpWMv+QkJOiHnYXqsO4g8wYcSoY76Xi1drLg8IlKrjkDtTix8zqi0rc1TvcY8JEERLbAGw=
X-Received: by 2002:a0c:cc14:0:b0:63d:2018:5044 with SMTP id
 r20-20020a0ccc14000000b0063d20185044mr1689494qvk.45.1692195854329; Wed, 16
 Aug 2023 07:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816095651.10014-1-daniel@iogearbox.net>
In-Reply-To: <20230816095651.10014-1-daniel@iogearbox.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 16 Aug 2023 22:23:38 +0800
Message-ID: <CALOAHbDtmTPV6enF1M0RnZr4pPyWkr1bZ7afcFchfNYRGVKu7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpftool: Implement link show support for tcx
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@linux.dev, bpf@vger.kernel.org, 
	Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 5:56=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Add support to dump tcx link information to bpftool. This adds a
> common helper show_link_ifindex_{plain,json}() which can be reused
> also for other link types. The plain text and json device output is
> the same format as in bpftool net dump.
>
> Below shows an example link dump output along with a cgroup link
> for comparison:
>
>   # bpftool link
>   [...]
>   10: cgroup  prog 1977
>         cgroup_id 1  attach_type cgroup_inet6_post_bind
>   [...]
>   13: tcx  prog 2053
>         ifindex enp5s0(3)  attach_type tcx_ingress
>   14: tcx  prog 2080
>         ifindex enp5s0(3)  attach_type tcx_egress
>   [...]
>
> Equivalent json output:
>
>   # bpftool link --json
>   [...]
>   {
>     "id": 10,
>     "type": "cgroup",
>     "prog_id": 1977,
>     "cgroup_id": 1,
>     "attach_type": "cgroup_inet6_post_bind"
>   },
>   [...]
>   {
>     "id": 13,
>     "type": "tcx",
>     "prog_id": 2053,
>     "devname": "enp5s0",
>     "ifindex": 3,
>     "attach_type": "tcx_ingress"
>   },
>   {
>     "id": 14,
>     "type": "tcx",
>     "prog_id": 2080,
>     "devname": "enp5s0",
>     "ifindex": 3,
>     "attach_type": "tcx_egress"
>   }
>   [...]
>
> Suggested-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks for your work. This patch looks good to me.
A minor nit below.

> ---
>  tools/bpf/bpftool/link.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 65a168df63bc..a3774594f154 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -150,6 +150,18 @@ static void show_link_attach_type_json(__u32 attach_=
type, json_writer_t *wtr)
>                 jsonw_uint_field(wtr, "attach_type", attach_type);
>  }
>
> +static void show_link_ifindex_json(__u32 ifindex, json_writer_t *wtr)
> +{
> +       char devname[IF_NAMESIZE] =3D "(unknown)";
> +
> +       if (ifindex)
> +               if_indextoname(ifindex, devname);
> +       else
> +               snprintf(devname, sizeof(devname), "(detached)");
> +       jsonw_string_field(wtr, "devname", devname);
> +       jsonw_uint_field(wtr, "ifindex", ifindex);
> +}
> +
>  static bool is_iter_map_target(const char *target_name)
>  {
>         return strcmp(target_name, "bpf_map_elem") =3D=3D 0 ||
> @@ -433,6 +445,10 @@ static int show_link_close_json(int fd, struct bpf_l=
ink_info *info)
>         case BPF_LINK_TYPE_NETFILTER:
>                 netfilter_dump_json(info, json_wtr);
>                 break;
> +       case BPF_LINK_TYPE_TCX:
> +               show_link_ifindex_json(info->tcx.ifindex, json_wtr);
> +               show_link_attach_type_json(info->tcx.attach_type, json_wt=
r);
> +               break;
>         case BPF_LINK_TYPE_STRUCT_OPS:
>                 jsonw_uint_field(json_wtr, "map_id",
>                                  info->struct_ops.map_id);
> @@ -509,6 +525,22 @@ static void show_link_attach_type_plain(__u32 attach=
_type)
>                 printf("attach_type %u  ", attach_type);
>  }
>
> +static void show_link_ifindex_plain(__u32 ifindex)
> +{
> +       char devname[IF_NAMESIZE * 2] =3D "(unknown)";
> +       char tmpname[IF_NAMESIZE];
> +       char *ret =3D NULL;
> +
> +       if (ifindex)
> +               ret =3D if_indextoname(ifindex, tmpname);
> +       else
> +               snprintf(devname, sizeof(devname), "(detached)");
> +       if (ret)
> +               snprintf(devname, sizeof(devname), "%s(%d)",
> +                        tmpname, ifindex);
> +       printf("ifindex %s  ", devname);
> +}

This function looks a little strange to me. What about the change below?

static void show_link_ifindex_plain(__u32 ifindex)
{
        char devname[IF_NAMESIZE] =3D "(unknown)";

        if (ifindex) {
                if_indextoname(ifindex, devname);
                printf("ifindex %s(%d)  ", devname, ifindex);
        } else {
                printf("ifindex (detached)  ");
        }
}


> +
>  static void show_iter_plain(struct bpf_link_info *info)
>  {
>         const char *target_name =3D u64_to_ptr(info->iter.target_name);
> @@ -745,6 +777,11 @@ static int show_link_close_plain(int fd, struct bpf_=
link_info *info)
>         case BPF_LINK_TYPE_NETFILTER:
>                 netfilter_dump_plain(info);
>                 break;
> +       case BPF_LINK_TYPE_TCX:
> +               printf("\n\t");
> +               show_link_ifindex_plain(info->tcx.ifindex);
> +               show_link_attach_type_plain(info->tcx.attach_type);
> +               break;
>         case BPF_LINK_TYPE_KPROBE_MULTI:
>                 show_kprobe_multi_plain(info);
>                 break;
> --
> 2.34.1
>


--=20
Regards
Yafang

