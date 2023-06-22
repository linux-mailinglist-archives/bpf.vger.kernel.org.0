Return-Path: <bpf+bounces-3198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC7373AC48
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 00:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142E62810BD
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 22:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56092256E;
	Thu, 22 Jun 2023 22:02:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A9922557
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 22:02:56 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8ED1BE1
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 15:02:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3112c11fdc9so5748060f8f.3
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 15:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687471373; x=1690063373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fa3/2jpcWPbeZjQPQ3CC6YFS7XeDy8NvVsxfvJoE0I8=;
        b=XP7QQUlKtIfYZyFotuJMtEPE/Fcs3faGAGgMAXpDb3xw47+nrla7Tncb+t+tlPMC7d
         hJoBKre9RhY01uiejN04F5JVLkdiisAxjoCSOpT58x1oLcfUHxMRguCF2n4UAirOXDsM
         fZIUZMNRi4WRyWWVJquJYJloQJiOcPwNISTFw8M+Tnk8oFYsRzM1l4a9ZAw8qRGuPhfd
         Oh9m7nyBVh50/ugbKU2tYfIZEGDeYMyrw6ZVNAtzp3vUpWRSXOb3lXHNfRdKQPuHxWIV
         XKRxYz2iwWDVRueSBP1Fmvfq2c9lQAqIg/CXbKF5Zf4PoslT938qKExfEuNgi0nY1Izt
         NF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687471373; x=1690063373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fa3/2jpcWPbeZjQPQ3CC6YFS7XeDy8NvVsxfvJoE0I8=;
        b=ap8WDA6bI/2Nho/IqGtJZGhY/pe2d6v8bDrp8yEc9UHYmQQeqYLBsgI1KkyPyFKQY5
         f2HYfc442m2Jj7Ui0axhT+7S1NYV6MWADWubKLVZ3rX1HEhwo2Wmwn1uF/zsHDvARSlj
         eO0z6ZjVGt8oez1IbEU8DkHLOshdjzkaH+4SPg5mgzKE6DQgcnKFndiiAZKnEl64rlxG
         tm0I+pKNDKXxRWElsPa54TZXoWP+8yLhVzbiZOoq741huN377UgiMtwLbbYUX9LcuXd/
         F44tUJLU94FsuvwkxKR1Jli2POWf/4dHO2LVDxakE99VKlMItEmVaRyWFP79dKi6MaBG
         s9Eg==
X-Gm-Message-State: AC+VfDwqDt6ckQQ3KaCeC/KJot91+I8R3K9mEIdJPD8rlIMI+F7KG1os
	uklwxfFRT9u/VmU+7cOm0ApxDZu//Ni7zKK/QE8=
X-Google-Smtp-Source: ACHHUZ4MZN6jbLfxDN2258EeJ2BgkdACK0I8nrLs6s/pQEtpE4xzOy/L+MtxJyETOU6SgIhlwL7K6IJr4HF0HklhSnc=
X-Received: by 2002:a5d:54c2:0:b0:306:2c16:8359 with SMTP id
 x2-20020a5d54c2000000b003062c168359mr14523495wrv.39.1687471372544; Thu, 22
 Jun 2023 15:02:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230616171728.530116-1-alan.maguire@oracle.com> <20230616171728.530116-2-alan.maguire@oracle.com>
In-Reply-To: <20230616171728.530116-2-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jun 2023 15:02:40 -0700
Message-ID: <CAEf4BzapHdQb=gXq9xLRGfRFBC=3xcQ=OSdV1o=+5nvgDwT4HA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/9] btf: add kind layout encoding, crcs to UAPI
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	quentin@isovalent.com, jolsa@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 16, 2023 at 10:17=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> BTF kind layouts provide information to parse BTF kinds.
> By separating parsing BTF from using all the information
> it provides, we allow BTF to encode new features even if
> they cannot be used.  This is helpful in particular for
> cases where newer tools for BTF generation run on an
> older kernel; BTF kinds may be present that the kernel
> cannot yet use, but at least it can parse the BTF
> provided.  Meanwhile userspace tools with newer libbpf
> may be able to use the newer information.
>
> The intent is to support encoding of kind layouts
> optionally so that tools like pahole can add this
> information.  So for each kind we record
>
> - kind-related flags
> - length of singular element following struct btf_type
> - length of each of the btf_vlen() elements following
>
> In addition we make space in the BTF header for
> CRC32s computed over the BTF along with a CRC for
> the base BTF; this allows split BTF to identify
> a mismatch explicitly.
>
> The ideas here were discussed at [1], [2]; hence
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>
> [1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=3DeOXOs_ONrDwrgX4bn=3D=
Nuc1g8JPFC34MA@mail.gmail.com/
> [2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.maguire@ora=
cle.com/
> ---
>  include/uapi/linux/btf.h       | 24 ++++++++++++++++++++++++
>  tools/include/uapi/linux/btf.h | 24 ++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>
> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index ec1798b6d3ff..cea9125ed953 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h
> @@ -8,6 +8,22 @@
>  #define BTF_MAGIC      0xeB9F
>  #define BTF_VERSION    1
>
> +/* is this information required? If so it cannot be sanitized safely. */
> +#define BTF_KIND_LAYOUT_OPTIONAL               (1 << 0)

hm.. I thought we agreed to not have OPTIONAL flag last time, no? From
kernel's perspective nothing is optional. From libbpf perspective
everything should be optional, unless we get type_id reference to
something that we don't recognize. So why the flag and extra code to
handle it?

We can always add it later, if necessary.

> +
> +/* kind layout section consists of a struct btf_kind_layout for each kno=
wn
> + * kind at BTF encoding time.
> + */
> +struct btf_kind_layout {
> +       __u16 flags;            /* see BTF_KIND_LAYOUT_* values above */
> +       __u8 info_sz;           /* size of singular element after btf_typ=
e */
> +       __u8 elem_sz;           /* size of each of btf_vlen(t) elements *=
/
> +};
> +
> +/* for CRCs for BTF, base BTF to be considered usable, flags must be set=
. */
> +#define BTF_FLAG_CRC_SET               (1 << 0)
> +#define BTF_FLAG_BASE_CRC_SET          (1 << 1)
> +
>  struct btf_header {
>         __u16   magic;
>         __u8    version;
> @@ -19,8 +35,16 @@ struct btf_header {
>         __u32   type_len;       /* length of type section       */
>         __u32   str_off;        /* offset of string section     */
>         __u32   str_len;        /* length of string section     */
> +       __u32   kind_layout_off;/* offset of kind layout section */
> +       __u32   kind_layout_len;/* length of kind layout section */
> +
> +       __u32   crc;            /* crc of BTF; used if flags set BTF_FLAG=
_CRC_VALID */
> +       __u32   base_crc;       /* crc of base BTF; used if flags set BTF=
_FLAG_BASE_CRC_VALID */
>  };
>
> +/* required minimum BTF header length */
> +#define BTF_HEADER_MIN_LEN     (sizeof(struct btf_header) - 16)

offsetof(struct btf_header, kind_layout_off) ?

but actually why this needs to be a part of UAPI?

> +
>  /* Max # of type identifier */
>  #define BTF_MAX_TYPE   0x000fffff
>  /* Max offset into the string section */
> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/bt=
f.h
> index ec1798b6d3ff..cea9125ed953 100644
> --- a/tools/include/uapi/linux/btf.h
> +++ b/tools/include/uapi/linux/btf.h
> @@ -8,6 +8,22 @@
>  #define BTF_MAGIC      0xeB9F
>  #define BTF_VERSION    1
>
> +/* is this information required? If so it cannot be sanitized safely. */
> +#define BTF_KIND_LAYOUT_OPTIONAL               (1 << 0)
> +
> +/* kind layout section consists of a struct btf_kind_layout for each kno=
wn
> + * kind at BTF encoding time.
> + */
> +struct btf_kind_layout {
> +       __u16 flags;            /* see BTF_KIND_LAYOUT_* values above */
> +       __u8 info_sz;           /* size of singular element after btf_typ=
e */
> +       __u8 elem_sz;           /* size of each of btf_vlen(t) elements *=
/
> +};
> +
> +/* for CRCs for BTF, base BTF to be considered usable, flags must be set=
. */
> +#define BTF_FLAG_CRC_SET               (1 << 0)
> +#define BTF_FLAG_BASE_CRC_SET          (1 << 1)
> +
>  struct btf_header {
>         __u16   magic;
>         __u8    version;
> @@ -19,8 +35,16 @@ struct btf_header {
>         __u32   type_len;       /* length of type section       */
>         __u32   str_off;        /* offset of string section     */
>         __u32   str_len;        /* length of string section     */
> +       __u32   kind_layout_off;/* offset of kind layout section */
> +       __u32   kind_layout_len;/* length of kind layout section */
> +
> +       __u32   crc;            /* crc of BTF; used if flags set BTF_FLAG=
_CRC_VALID */

why are we making crc optional? shouldn't we just say that crc is
always filled out?

> +       __u32   base_crc;       /* crc of base BTF; used if flags set BTF=
_FLAG_BASE_CRC_VALID */

here it would be nice if we could just rely on zero meaning not set,
but I suspect not everyone will be happy about this, as technically
crc 0 is a valid crc :(


>  };
>
> +/* required minimum BTF header length */
> +#define BTF_HEADER_MIN_LEN     (sizeof(struct btf_header) - 16)
> +
>  /* Max # of type identifier */
>  #define BTF_MAX_TYPE   0x000fffff
>  /* Max offset into the string section */
> --
> 2.39.3
>

