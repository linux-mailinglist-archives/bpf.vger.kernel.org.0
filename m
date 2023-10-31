Return-Path: <bpf+bounces-13746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED16C7DD62C
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 19:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E1B1C20CFE
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8DB1A700;
	Tue, 31 Oct 2023 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKX7g0SF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96F7D2ED
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 18:39:01 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F778E
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:39:00 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9d2c54482fbso461804266b.2
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698777539; x=1699382339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eTPxl5PJi3Vuug0jwWXHvngUCbbt5H0xpB1qKpUZAw=;
        b=gKX7g0SFRStOTEywB4XxsbaA0/TgX5eBfMRgivCc13XhrmOYumUjqJdkWOw3jPTLpq
         AwxLylRo5533W2vE5cFwr7Ur25ZwGa3FgwZvGPNZWfAgjvZeNYP76VBkteDTpHwvxgR0
         ZyUmiV8qnKraKZLp4suqY5F1fBii2BqNSwaYzGOa9unOA9bmJFd7wNAPu05toUKQtYWi
         T4AyKryOXajStt+5Hwtuf+OUB9izwEtvbtGZKWKTgt3/0kUoTJ/EiWsQuDBxF1t7elt+
         vhok0p/MdQGhTN377xIwrlos821Y2tkuEArrM05h0SNfSvPRh57rUz+7Qj+iRtiEJXfl
         ocdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698777539; x=1699382339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7eTPxl5PJi3Vuug0jwWXHvngUCbbt5H0xpB1qKpUZAw=;
        b=HVjef4E8qdHDtVcBM/ROmvT05mwPGx1EqB0INWCyd0cEhOJLGpKKAROPYYOp14n790
         cwfJBYglDovU8QBzH7dmX9z7EuoKpP5/Nq83wDRMhkgHTKv96GOPQ6/FuVuFMrb2voOr
         S+jBIHlBH0He+CfbwLOphwqaEN9EOnCDOvgNlMZgqm2KaqkOlcnvEDCPsLfQIj9PhY8T
         o3AsCyS72c8e3ILDQaNT7MVhJNF+cr3IYDgUNJoRw+M53/dQTNssFGFp/rPpMx/TwoLg
         m/887MckoNSGDFaNgqcQSwHeOnUgGghZkFVGo1wKxMkL0PHZCXXHRjCyMavcIGkoSKxP
         I/9g==
X-Gm-Message-State: AOJu0YyNXMy0lWUXhbgekDPICMLz4kgu0g+tDD0eJAlOu5rc+KZ2QyVz
	MR9Xiwwt+9h4203PR+VtEZBfyAef3/ba9feaOHHm30S7q5A=
X-Google-Smtp-Source: AGHT+IFjMBONOCnL4x4HpC2w3dm8bvuKeFZwJeQCaUDKitBrKXk5fZjby1ebrAGdCL14LZydUl5BFMUTu3bnihYjcRg=
X-Received: by 2002:a17:907:2d12:b0:9ad:7890:b4c0 with SMTP id
 gs18-20020a1709072d1200b009ad7890b4c0mr140979ejc.56.1698777538618; Tue, 31
 Oct 2023 11:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN+4W8i=7Wv2VwvWZGhX_mc8E7EST10X_Z5XGBmq=WckusG_fw@mail.gmail.com>
In-Reply-To: <CAN+4W8i=7Wv2VwvWZGhX_mc8E7EST10X_Z5XGBmq=WckusG_fw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Oct 2023 11:38:47 -0700
Message-ID: <CAEf4BzZCjTsWhcmQz08QB4mirfgG0ea6bYJX2RgKirwFxAO+3g@mail.gmail.com>
Subject: Re: BTF_TYPE_ID_LOCAL off by one?
To: Lorenz Bauer <lorenz.bauer@isovalent.com>
Cc: Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 8:45=E2=80=AFAM Lorenz Bauer <lorenz.bauer@isovalen=
t.com> wrote:
>
> I think there is something weird going on with BTF_TYPE_ID_LOCAL. A
> call to bpf_obj_new is getting the "wrong" type as an argument as
> emitted by clang into the instruction stream.
>
> Compiling local_kptr_stash.c from 6.6 selftest with clang-16 and
> clang-17 yields the following disassembly for the stash_plain function
> (source is at [1]):
>
> 00000000000001b0 <stash_plain>:
> ...
>       64:    18 01 00 00 1c 00 00 00 00 00 00 00 00 00 00 00    r1 =3D 0x=
1c ll
>       66:    b7 02 00 00 00 00 00 00    r2 =3D 0x0
>       67:    85 10 00 00 ff ff ff ff    call -0x1
>           ; bpf_obj_new
> ...
>
> This is looking at local_kptr_stash.bpf.linked3.o specifically, but
> local_kptr_stash.bpf.o has the same problem.
>
> 0x1c being 28. From bpftool we can see that 28 corresponds to a FUNC
> type which doesn't make much sense to me:
>
> [28] FUNC 'unstash_rb_node' type_id=3D15 linkage=3Dglobal
>
> The source code actually passes struct plain_local to bpf_obj_new,
> which has type ID 27:
>
> [27] STRUCT 'plain_local' size=3D16 vlen=3D2
>     'key' type_id=3D16 bits_offset=3D0
>     'data' type_id=3D16 bits_offset=3D64
>
> I'm guessing that this works in practice since the CO-RE relo in
> ext_infos actually carries the correct local_type_id:
>
> CORERelocation(local_type_id, Struct:"node_data"[0], local_id=3D18)
> CORERelocation(local_type_id, Struct:"node_data"[0], local_id=3D18)
> CORERelocation(local_type_id, Struct:"plain_local"[0], local_id=3D27)
>
> 1: https://elixir.bootlin.com/linux/v6.6/source/tools/testing/selftests/b=
pf/progs/local_kptr_stash.c#L76


I don't remember if this is intention or not, but the main part is
adjusting CO-RE relocation, the actual instruction value is less
important. But this is happening after static linking, because BTF is
deduplicated (there is a duplication in BTF generated by Clang).

$ llvm-objdump -dr ./local_kptr_stash.bpf.linked3.o | grep -A1 '65:'
      65:       18 01 00 00 1c 00 00 00 00 00 00 00 00 00 00 00 r1 =3D 0x1c=
 ll
                0000000000000208:  CO-RE <local_type_id> [27] struct plain_=
local

$ bpftool btf dump file ./local_kptr_stash.bpf.linked3.o | grep 'plain_loca=
l'
[27] STRUCT 'plain_local' size=3D16 vlen=3D2

$ llvm-objdump -dr ./local_kptr_stash.bpf.o | grep -A1 '65:'
      65:       18 01 00 00 1c 00 00 00 00 00 00 00 00 00 00 00 r1 =3D 0x1c=
 ll
                0000000000000208:  CO-RE <local_type_id> [28] struct plain_=
local

$ bpftool btf dump file ./local_kptr_stash.bpf.o | grep 'plain_local'
[28] STRUCT 'plain_local' size=3D16 vlen=3D2

Note how plain_local was [28] and then became [27]. CO-RE relocation
was correctly adjusted, but the instruction itself was left intact.


The BTF duplication is in

[26] FUNC_PROTO '(anon)' ret_type_id=3D16 vlen=3D1
        'ctx' type_id=3D14

There are at least two identical prototypes (which is strange and
might be worth looking into from Clang side).

