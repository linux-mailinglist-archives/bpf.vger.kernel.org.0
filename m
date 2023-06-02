Return-Path: <bpf+bounces-1718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F29B720802
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 18:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD82F281A24
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 16:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4DE332FF;
	Fri,  2 Jun 2023 16:58:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E41B332EE
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 16:58:00 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66251A2
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 09:57:58 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5149e65c218so3344684a12.2
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 09:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685725077; x=1688317077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQblcpQXJvbpMRuPhrtxVyKiqMHVN89TQKD8KX3S57M=;
        b=WkYrPrw+7eKtnLtThdYwWmCJqaz5L/pVdDqCOV6mIG1/4vKDeALoXIeCuBDw4wA/oi
         CaZz+1jHXazqD9AeQMzi7JIAiymW6IkVubTY79zWA0rzANo+6Qdw/jSn+7jHWZ5EMr6E
         d2SjHXxk/WomcpPgWk8nMcg2f41ufjXHWlaSr86oRqfU1T2ATKer3SINcSYiil3hG9BQ
         j4GGpji4Fg/PZj94dE4kNXMqPJQkQwEjS1hPkkhaxrePU+IOwoiwpM/5Jd/oFZmbGzmh
         dBwg5c8w738nS0l4pezo7fF+erlW+nuw9TqV1ImnPVN4wH4Y01kq8A2gt8G5sxPYd7s0
         56OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685725077; x=1688317077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQblcpQXJvbpMRuPhrtxVyKiqMHVN89TQKD8KX3S57M=;
        b=l4lDBxzs/1rmefLZlrhXOt29HFySZTeZv7jv68/7VirLQnTmB/p4/Fz5K6ugA65STg
         eqW1saaOTpIrepL6wC1UxTL4+yDGwFTAlGLF7Pg8V+Q//BtdFzV1plsX3WdKPGZ3dAsX
         K/FY6+Liz8ou8KG/q8d9P/XJ2YYICk0VeHJXKLq5C/t2K35jgrtWbOYWOzcVghltDsiX
         aUdXk8z8rwZv9hEygWZrr23cVM9/Urt8+0oVMaVQvNjggdK1wQzXo5wSVakl5BnNF4WJ
         LTLR6apimuX1gf6vLOhwg8+P5IGup90IftOwyIj7sEgGWUH+tKSXmHjZvbvkih+yX9kA
         HEjQ==
X-Gm-Message-State: AC+VfDxtBTDBYeCGk6Sclhx9U81kvKdXn1VKXk7dDHLY3iVOwkKjC1HH
	7jrfqYRcLjg+tLVPicmTL+0s9ANCk5wb/k56lAM=
X-Google-Smtp-Source: ACHHUZ4u2srlVVgPPSKrfxByp4yBqq4WzS8ndz72eUx+2LqKB0tXusQ3f1RlgIJTkagPOwY65GZdPeyGH77FRUb+DOo=
X-Received: by 2002:aa7:c650:0:b0:516:4098:66f4 with SMTP id
 z16-20020aa7c650000000b00516409866f4mr1138310edr.18.1685725076985; Fri, 02
 Jun 2023 09:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230531201936.1992188-1-alan.maguire@oracle.com> <20230531201936.1992188-8-alan.maguire@oracle.com>
In-Reply-To: <20230531201936.1992188-8-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Jun 2023 09:57:45 -0700
Message-ID: <CAEf4BzahDAkuaxOQf10zMv8rKPA0Hno1y6m8R1w=g+X2ryO6Kw@mail.gmail.com>
Subject: Re: [RFC bpf-next 7/8] bpftool: add BTF dump "format meta" to dump header/metadata
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, acme@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, mykolal@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 31, 2023 at 1:21=E2=80=AFPM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Provide a way to dump BTF header and metadata info via
> bpftool; for example
>
> $ bpftool btf dump file vmliux format meta
> BTF: data size 4963656
> Header: magic 0xeb9f, version 1, flags 0x0, hdr_len 32
> Types: len 2927556, offset 0
> Strings: len 2035881, offset 2927556
> Metadata header found: len 184, offset 4963440, flags 0x1
> Description: 'generated by dwarves v1.25'
> CRC 0x6da2a930 ; base CRC 0x0
> Kind metadata for 20 kinds:
>        BTF_KIND_UNKN[ 0] flags 0x0    info_sz  0 elem_sz  0
>         BTF_KIND_INT[ 1] flags 0x0    info_sz  4 elem_sz  0
>         BTF_KIND_PTR[ 2] flags 0x0    info_sz  0 elem_sz  0
>       BTF_KIND_ARRAY[ 3] flags 0x0    info_sz 12 elem_sz  0
>      BTF_KIND_STRUCT[ 4] flags 0x0    info_sz  0 elem_sz 12
>       BTF_KIND_UNION[ 5] flags 0x0    info_sz  0 elem_sz 12
>        BTF_KIND_ENUM[ 6] flags 0x0    info_sz  0 elem_sz  8
>         BTF_KIND_FWD[ 7] flags 0x0    info_sz  0 elem_sz  0
>     BTF_KIND_TYPEDEF[ 8] flags 0x0    info_sz  0 elem_sz  0
>    BTF_KIND_VOLATILE[ 9] flags 0x0    info_sz  0 elem_sz  0
>       BTF_KIND_CONST[10] flags 0x0    info_sz  0 elem_sz  0
>    BTF_KIND_RESTRICT[11] flags 0x0    info_sz  0 elem_sz  0
>        BTF_KIND_FUNC[12] flags 0x0    info_sz  0 elem_sz  0
>  BTF_KIND_FUNC_PROTO[13] flags 0x0    info_sz  0 elem_sz  8
>         BTF_KIND_VAR[14] flags 0x0    info_sz  4 elem_sz  0
>     BTF_KIND_DATASEC[15] flags 0x0    info_sz  0 elem_sz 12
>       BTF_KIND_FLOAT[16] flags 0x0    info_sz  0 elem_sz  0
>    BTF_KIND_DECL_TAG[17] flags 0x1    info_sz  4 elem_sz  0
>    BTF_KIND_TYPE_TAG[18] flags 0x1    info_sz  0 elem_sz  0
>      BTF_KIND_ENUM64[19] flags 0x0    info_sz  0 elem_sz 12

nit: looks very weird to be right aligned for the "BTF_KIND_xxx"
column, let's align it left here?

Also, btfdump ([0]) emits stats on per-kind basis, and I found it
quite useful on multiple occasions, do you think it would be
worthwhile to add that to bpftool as well. It looks like this in
btfdump's case:

BTF types
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Total        2293996 bytes (90517 types)
FuncProto:    731420 bytes (21455 types)
Struct:       625944 bytes (7575 types)
Func:         480876 bytes (40073 types)
Enum:         137652 bytes (1721 types)
Ptr:          132180 bytes (11015 types)
Array:         67440 bytes (2810 types)
Union:         57744 bytes (1348 types)
Const:         28140 bytes (2345 types)
Typedef:       20964 bytes (1747 types)
Var:            5024 bytes (314 types)
Datasec:        3780 bytes (1 types)
Enum64:         1500 bytes (7 types)
Fwd:             828 bytes (69 types)
Int:             240 bytes (15 types)
Volatile:        228 bytes (19 types)
Restrict:         24 bytes (2 types)
Float:            12 bytes (1 types)


  [0] https://github.com/anakryiko/btfdump

>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/bpf/bpftool/btf.c | 46 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 91fcb75babe3..da4257e00ba8 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -504,6 +504,47 @@ static int dump_btf_c(const struct btf *btf,
>         return err;
>  }
>

[...]

