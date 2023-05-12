Return-Path: <bpf+bounces-366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF496FFF10
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 04:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A9A1C21111
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 02:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F18810;
	Fri, 12 May 2023 02:51:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F227E9
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 02:51:45 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DD465B4
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 19:51:40 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-61b2f654b54so46041356d6.3
        for <bpf@vger.kernel.org>; Thu, 11 May 2023 19:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683859900; x=1686451900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0anDDFz/VWSBVszUM9QwBZFMXE3QguZV9EhIK5ejc70=;
        b=lVhaMsclTcz0g4hFsd962SUnmDjz6JZKBgdTAsPpP1MTIJkaeP22gCw7Opyfr7N7nh
         55Rvljdh/sc0Ce4GhhKKXlZWtn6DADYCDQRUe9xkNEjjxxeV96LtMpDo68Ye5L2uLXUq
         BbQfdEMMgbLgeu0xNcrDrz8s/8sVX0xyyAapSl4u8HGoLGmcgjUv9rJKuXzzeuhOLSkq
         qsPNUfopy0mysiYwTekt8f6/HLTLsmLdSLgvopa8eGrSaabXbOlGOH1pbYkn8orwANQS
         blI5PdAP6ZlZItil181f3/sTE3kL0DVCZKaehsrWp1CCHrED8NsyDGbhWPm3zfZZvVvb
         B2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683859900; x=1686451900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0anDDFz/VWSBVszUM9QwBZFMXE3QguZV9EhIK5ejc70=;
        b=RqneiNh65clVNJtxVw4lwzKECaxwAShavJbUNyy0OREYzcD3sUikxla5jbEjASg79Z
         92fo4kCpOgpMYnyIUx2lttP7Q5C/tMXmo6Y9767aXuaDgq877vmXjuu2yLrrDz5jqr8F
         nQyPd0himgVkcQ0pZ5WEOR7+2EOogCkMJhF0y9HM+V05wonmRl1uYTb1RFlFq2k+8Yqr
         D8KA+nnzNZNhSFgfC/HcOOHg5kFd7HVnj8iFmBvzCFLd8xnDTshYX2uc35i25qtz8Ro0
         OuGY7Tq5VZyFpV6cXbeQKwhByFLzXJqO9dy1/5rAm4WTjyL9BbbuBr6Gn83KJtHU7dij
         gZxg==
X-Gm-Message-State: AC+VfDxXCeQNGAoeW43gtueysgp+78MacsGgA72tydRHXSZ+O/mgU/z5
	Wll0jPg8Velw/9GRwdEok4QbcqB6Nk/KR27HKYM=
X-Google-Smtp-Source: ACHHUZ7PTrrtDhmNQDHDGIRQr0uVbsgeGkpNJQmWmVuVkq/XPJ5VmayRVM5PBRPZpJmtpygrddWNbxXLtVfqT/onItg=
X-Received: by 2002:ad4:5b8f:0:b0:61d:be1e:7c4e with SMTP id
 15-20020ad45b8f000000b0061dbe1e7c4emr35099288qvp.12.1683859899837; Thu, 11
 May 2023 19:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230510130241.1696561-1-alan.maguire@oracle.com>
In-Reply-To: <20230510130241.1696561-1-alan.maguire@oracle.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 12 May 2023 10:51:03 +0800
Message-ID: <CALOAHbDeK4SkP7pXdBWJ6Omwq2NyxJrYn6wZTX=z1-VkDtWwMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add --skip_encoding_btf_inconsistent_proto,
 --btf_gen_optimized to pahole flags for v1.25
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, acme@kernel.org, 
	jolsa@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 10, 2023 at 9:03=E2=80=AFPM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> v1.25 of pahole supports filtering out functions with multiple inconsiste=
nt
> function prototypes or optimized-out parameters from the BTF representati=
on.
> These present problems because there is no additional info in BTF saying =
which
> inconsistent prototype matches which function instance to help guide atta=
chment,
> and functions with optimized-out parameters can lead to incorrect assumpt=
ions
> about register contents.
>
> So for now, filter out such functions while adding BTF representations fo=
r
> functions that have "."-suffixes (foo.isra.0) but not optimized-out param=
eters.
> This patch assumes that below linked changes land in pahole for v1.25.
>
> Issues with pahole filtering being too aggressive in removing functions
> appear to be resolved now, but CI and further testing will confirm.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  scripts/pahole-flags.sh | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> index 1f1f1d397c39..728d55190d97 100755
> --- a/scripts/pahole-flags.sh
> +++ b/scripts/pahole-flags.sh
> @@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
>         # see PAHOLE_HAS_LANG_EXCLUDE
>         extra_paholeopt=3D"${extra_paholeopt} --lang_exclude=3Drust"
>  fi
> +if [ "${pahole_ver}" -ge "125" ]; then
> +       extra_paholeopt=3D"${extra_paholeopt} --skip_encoding_btf_inconsi=
stent_proto --btf_gen_optimized"
> +fi
>
>  echo ${extra_paholeopt}
> --
> 2.31.1
>

That change looks like a workaround to me.
There may be multiple functions that have the same proto, e.g.:

  $ grep -r "bpf_iter_detach_map(struct bpf_iter_aux_info \*aux)"
kernel/bpf/ net/core/
  kernel/bpf/map_iter.c:static void bpf_iter_detach_map(struct
bpf_iter_aux_info *aux)
  net/core/bpf_sk_storage.c:static void bpf_iter_detach_map(struct
bpf_iter_aux_info *aux)

  $ bpftool btf dump file /sys/kernel/btf/vmlinux   |  grep -B 2
bpf_iter_detach_map
  [34691] FUNC_PROTO '(anon)' ret_type_id=3D0 vlen=3D1
  'aux' type_id=3D2638
  [34692] FUNC 'bpf_iter_detach_map' type_id=3D34691 linkage=3Dstatic

We don't know which one it is in the BTF.
However, I'm not against this change, as it can avoid some issues.

--=20
Regards
Yafang

