Return-Path: <bpf+bounces-12373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297317CB981
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 06:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2CBDB21006
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 04:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4CBBE56;
	Tue, 17 Oct 2023 04:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A1aAu1n+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489331FD5
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 04:06:10 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEC995
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 21:06:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9b70b9671so81055ad.1
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 21:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697515568; x=1698120368; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LExA3e22tObbU+gD8GPC03yOLOAUcj6vLEW+DNSQRQk=;
        b=A1aAu1n+cXyLVVHBTXwXNg4DeKQ7AyS8/tpBg8edWdeBGSo4Aip779SObSju5Q/PRz
         iwQ387kioyCakrHnYSt7gY5xAW2NMnfLaEAXKV33DoUzQxksTHgi8NVp6YaSh51qAQlW
         ondzE8P7SWEc8v8UNVxu7eIeql8fG7rv28LhDyPl0VdJC7OcHDbDw3x10oiQAuPm0oXw
         jJYG6U67EevnsKQVqSWWCeiT4LshUqmiQeqU8TC6VCYw31/COVjEoPejhVCuy5CAV1vq
         jWVZ0RW3R0VMKDNRquxnyS5JakKAc9fRSy2Wx8O8fLAtimHqhiTD1VPa9QIPvn9tG2wP
         aTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697515568; x=1698120368;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LExA3e22tObbU+gD8GPC03yOLOAUcj6vLEW+DNSQRQk=;
        b=CrObfHZPWm3WWobBO1w81jj5G5smgU+gL/lMZ0wI1jAaDkUuU0l92nu6mbYOYlh8jE
         2slOqOtxud30XEC12w34LDBoiOHrnPA3VKbgZSGIKVrss1q0m804rp7A0/Hqz4qSjYbZ
         3XI2XQyiRoIeyGvLcvfI350Uf2kQurT7qo9hQe1B3T4OPg3Pn9wkF6xKYJeoc1AneWvL
         RyjcC8+0MR6DC/S36hRLCryFNHlr0WfQwT4NkO7UX8WU2M4o/cPAgA0ly2Ed4tSIGV/P
         o/7cbeiyfZolVVF8gHDpJtnGW/vexLj/7DKZZdpeR+AMsrOtu6oy8UF3oWD4QmdIWKqm
         oD+A==
X-Gm-Message-State: AOJu0Yyi/gOWs1jFjFthb0JK+BUBpSlle1zl0ne7Gx2qPpEQ7e8ltf1P
	/MIvkKE+T1NiklM2yQx8IDEwrQ==
X-Google-Smtp-Source: AGHT+IHN/ub8c5M6g8Qe1DBy8l6JWjc849szLZ1QEHQMkcJv/UJ8e/7B8OzQ3UEMmXoL5maLY8y4+Q==
X-Received: by 2002:a17:902:ef4f:b0:1c1:efe5:cce5 with SMTP id e15-20020a170902ef4f00b001c1efe5cce5mr92807plx.3.1697515567297;
        Mon, 16 Oct 2023 21:06:07 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:205:1972:b984:359b:c069])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ecc200b001c9db5e2929sm392179plh.93.2023.10.16.21.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 21:06:04 -0700 (PDT)
Date: Mon, 16 Oct 2023 21:06:00 -0700
From: Fangrui Song <maskray@google.com>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	kernel-team@meta.com, Liam Wisehart <liamwisehart@meta.com>
Subject: Re: [PATCH bpf-next] libbpf: don't assume SHT_GNU_verdef presence
 for SHT_GNU_versym section
Message-ID: <20231017040600.z3k5nqfpblt6zwhe@google.com>
References: <20231016182840.4033346-1-andrii@kernel.org>
 <CAEf4BzZopGdv=cfQCryvaw_duK_BD1oFgTXXZ6w25X0xxXLWJw@mail.gmail.com>
 <CAEyhmHSHJgQrgtRZotmm3yQOSekjjZjqaHAF58iQeu0WYPNcYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEyhmHSHJgQrgtRZotmm3yQOSekjjZjqaHAF58iQeu0WYPNcYA@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-17, Hengqi Chen wrote:
>+ Fangrui

Thanks for CCing me. I have spent countless hours studying symbol
versioning...
https://maskray.me/blog/2020-11-26-all-about-symbol-versioning

>On Tue, Oct 17, 2023 at 4:10 AM Andrii Nakryiko
><andrii.nakryiko@gmail.com> wrote:
>>
>> On Mon, Oct 16, 2023 at 11:28 AM Andrii Nakryiko <andrii@kernel.org> wrote:
>> >
>> > Fix too eager assumption that SHT_GNU_verdef ELF section is going to be
>> > present whenever binary has SHT_GNU_versym section. It seems like either
>> > SHT_GNU_verdef or SHT_GNU_verneed can be used, so failing on missing
>> > SHT_GNU_verdef actually breaks use cases in production.
>> >
>> > One specific reported issue, which was used to manually test this fix,
>> > was trying to attach to `readline` function in BASH binary.
>> >
>> > Cc: Hengqi Chen <hengqi.chen@gmail.com>
>> > Reported-by: Liam Wisehart <liamwisehart@meta.com>
>> > Fixes: bb7fa09399b9 ("libbpf: Support symbol versioning for uprobe")
>> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>> > ---
>> >  tools/lib/bpf/elf.c | 16 ++++++++++------
>> >  1 file changed, 10 insertions(+), 6 deletions(-)
>> >
>>
>> Hengqi,
>>
>> Please take a look when you get a chance. I'm not very familiar with
>> symbol versioning details, but it seems like we made a too strong
>> assumption about verdef always being present. In bash's case we have
>> VERNEED, but not VERDEF, and that seems to be ok:
>>
>
>Yes, both VERNEED and VERDEF are optional.

Yes.

The .gnu.version table assigns a version index to each .dynsym entry. An
entry (version ID) corresponds to a Index: entry in .gnu.version_d or a
Version: entry in .gnu.version_r.

>>   [ 8] .gnu.version      VERSYM          000000000001c9ca 01c9ca
>> 00130c 02   A  6   0  2
>>   [ 9] .gnu.version_r    VERNEED         000000000001dcd8 01dcd8
>> 0000b0 00   A  7   2  8
>>
>> So perhaps we need to complete the implementation to take VERNEED into
>> account. And also let's add a test that can catch an issue like this
>> going forward. Thanks!
>>
>
>AFAIK, VERNEED contains version requirements for shared libraries.

Yes.

>> > diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
>> > index 2a158e8a8b7c..2a62bf411bb3 100644
>> > --- a/tools/lib/bpf/elf.c
>> > +++ b/tools/lib/bpf/elf.c
>> > @@ -141,14 +141,15 @@ static int elf_sym_iter_new(struct elf_sym_iter *iter,
>> >         iter->versyms = elf_getdata(scn, 0);
>> >
>> >         scn = elf_find_next_scn_by_type(elf, SHT_GNU_verdef, NULL);
>> > -       if (!scn) {
>> > -               pr_debug("elf: failed to find verdef ELF sections in '%s'\n", binary_path);
>> > -               return -ENOENT;
>> > -       }
>> > -       if (!gelf_getshdr(scn, &sh))
>> > +       if (!scn)
>> > +               return 0;
>> > +
>> > +       iter->verdefs = elf_getdata(scn, 0);
>> > +       if (!iter->verdefs || !gelf_getshdr(scn, &sh)) {
>> > +               pr_warn("elf: failed to get verdef ELF section in '%s'\n", binary_path);
>> >                 return -EINVAL;
>> > +       }
>> >         iter->verdef_strtabidx = sh.sh_link;
>> > -       iter->verdefs = elf_getdata(scn, 0);
>> >
>> >         return 0;
>> >  }
>> > @@ -199,6 +200,9 @@ static const char *elf_get_vername(struct elf_sym_iter *iter, int ver)
>> >         GElf_Verdef verdef;
>> >         int offset;
>> >
>> > +       if (!iter->verdefs)
>> > +               return NULL;
>> > +
>> >         offset = 0;
>> >         while (gelf_getverdef(iter->verdefs, offset, &verdef)) {
>> >                 if (verdef.vd_ndx != ver) {
>> > --
>> > 2.34.1
>> >
>
>Anyway, this change look good to me, so
>
>Acked-by: Hengqi Chen <hengqi.chen@gmail.com>

Looks good to me, too.

Review Reviewed-by: Fangrui Song <maskray@google.com>

---

I have a question about a previous patch
"libbpf: Support symbol versioning for uprobe"
(commit bb7fa09399b937cdc4432ac99f9748f5a7f69389 in next/master).

In the function 'symbol_match',

	/* If user specifies symbol version, for dynamic symbols,
	 * get version name from ELF verdef section for comparison.
	 */
	if (sh_type == SHT_DYNSYM) {
		ver_name = elf_get_vername(iter, sym->ver);
		if (!ver_name)
			return false;
		return strcmp(ver_name, lib_ver) == 0;
	}

elf_get_vername only checks verdef, not verneed. Is this an issue?
I am not familiar with tools/lib/bpf or how it is used for uprobe.


Is the function intended to match linker behavior?
Then the rules described at https://maskray.me/blog/2020-11-26-all-about-symbol-versioning#linker-behavior
apply.
I think the current rules are quite good.


>--
>Hengqi

