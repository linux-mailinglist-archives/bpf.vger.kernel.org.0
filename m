Return-Path: <bpf+bounces-4743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD10374E9D1
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5DC1C203E0
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 09:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7036C1774A;
	Tue, 11 Jul 2023 09:05:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A38C17723
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:05:43 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EDD93
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:05:41 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9926623e367so697396766b.0
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689066340; x=1691658340;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5uLzH75BCdsjrLJkaFhZmP5u1mv4kF4W5txEOaqnGBg=;
        b=BW0nPuX6LRAZR71oNbmzZrMfHQorWi+oCMf+Z+laBkE+gtHKvfB/15zsZLfnI091Gx
         JlVfWwW+cpjw3dx8Nil1+E2GRmM1BtZtRzntWrTOUI0I5mkhcIBwyZKCt2L0EI/oZBD0
         4Rug6sWAiAim2n3bvvnCgNTLZsTJ5Jv7oimuTpMBhUYYmxZVuJM5gS4F4YEFurAlxShh
         0JobhKYNFVsvBEN+Z553zpsc/eIy88biHA+Ks8rwp5zG/wI2hLhFRJSaAzQ4BomXfKXV
         Hd4evfAE5JgnSLNEcSjwxaYyX+5ceQpY3gaf4/oAhq2PlQFEsGNsH0obYPFLqhDY26tk
         ZlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066340; x=1691658340;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uLzH75BCdsjrLJkaFhZmP5u1mv4kF4W5txEOaqnGBg=;
        b=OcEYSt4EHKRlzxzxgxzCI+11sbn4WZdS6sFvxcnJ+Dp0uNKeRjINuOhXd5gdOjbaFw
         n+Hcws4Z5V43GyXpMC0i9/leYZLNJEaif5X7VHtRNx0LBqHgUi74x4hxRfs2RXoNsQqB
         V6hE+rKFrUPE8lBlHr0TAY0NybMEacPWvySqIQLkt8yI58xrSWpUwVLqAZM9wo+uvrDq
         MbPi7E2XCVFR6Ebr4hvUpc9Omf4lIYqnfGxv55Ml+BAyDBZe3XRhWaWMVadjSkQX7D0D
         uWQuoAWBYvvyVwHAig3eg000un4ULKO4463jH45QC56VKygX+4ZfQUwAMZroBTIg/i73
         DT1w==
X-Gm-Message-State: ABy/qLbBVQyXAE8P6N9PImQDDXMdJudbGEX9vQq8tNYG3Deyos8v3r1k
	fNLG2zOYfUk71+D0Emk/rkE=
X-Google-Smtp-Source: APBJJlGyxwSDW0LJg3cW9RXF5vcwwsfr30F0DqELtedEb6H0KYcfGmC9JWClQHac/NOCzUUo0npvmw==
X-Received: by 2002:a17:906:7487:b0:993:da40:fbff with SMTP id e7-20020a170906748700b00993da40fbffmr12498887ejl.0.1689066340125;
        Tue, 11 Jul 2023 02:05:40 -0700 (PDT)
Received: from krava (net-109-116-206-239.cust.vodafonedsl.it. [109.116.206.239])
        by smtp.gmail.com with ESMTPSA id l15-20020a1709065a8f00b00991d54db2acsm879338ejq.44.2023.07.11.02.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:05:39 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Jul 2023 11:05:36 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf-next 07/26] libbpf: Move elf_find_func_offset*
 functions to elf object
Message-ID: <ZK0bYPiJdTBZaE9h@krava>
References: <20230630083344.984305-1-jolsa@kernel.org>
 <20230630083344.984305-8-jolsa@kernel.org>
 <CAEf4BzbLDnEyCwEBn2PJCM_756d_C8Pbb+ocvwEkacnd1b8yVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbLDnEyCwEBn2PJCM_756d_C8Pbb+ocvwEkacnd1b8yVQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 04:02:22PM -0700, Andrii Nakryiko wrote:
> On Fri, Jun 30, 2023 at 1:35 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding new elf object that will contain elf related functions.
> > There's no functional change.
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/Build        |   2 +-
> >  tools/lib/bpf/elf.c        | 198 +++++++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf.c     | 186 +---------------------------------
> >  tools/lib/bpf/libbpf_elf.h |  11 +++
> >  4 files changed, 211 insertions(+), 186 deletions(-)
> >  create mode 100644 tools/lib/bpf/elf.c
> >  create mode 100644 tools/lib/bpf/libbpf_elf.h
> >
> 
> [...]
> 
> > diff --git a/tools/lib/bpf/libbpf_elf.h b/tools/lib/bpf/libbpf_elf.h
> > new file mode 100644
> > index 000000000000..1b652220fabf
> > --- /dev/null
> > +++ b/tools/lib/bpf/libbpf_elf.h
> > @@ -0,0 +1,11 @@
> > +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> > +
> > +#ifndef __LIBBPF_LIBBPF_ELF_H
> > +#define __LIBBPF_LIBBPF_ELF_H
> > +
> > +#include <libelf.h>
> > +
> > +long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name);
> > +long elf_find_func_offset_from_file(const char *binary_path, const char *name);
> > +
> > +#endif /* *__LIBBPF_LIBBPF_ELF_H */
> 
> we have libbpf_internal.h, let's put all this there for now, it's
> already all the internal stuff together, I don't know if separate
> header with few functions gives us much

there's more functions coming later in the patchset

	struct elf_fd {
		Elf *elf;
		int fd;
	};

	int elf_open(const char *binary_path, struct elf_fd *elf_fd);
	void elf_close(struct elf_fd *elf_fd);

	int elf_resolve_syms_offsets(const char *binary_path, int cnt,
				     const char **syms, unsigned long **poffsets);

	int elf_resolve_pattern_offsets(const char *binary_path, const char *pattern,
					 unsigned long **poffsets, size_t *pcnt);


and there's probably more elf helpers to eventually move in:

	libbpf.c:static const char *elf_sym_str(const struct bpf_object *obj, size_t off);
	libbpf.c:static const char *elf_sec_str(const struct bpf_object *obj, size_t off);
	libbpf.c:static Elf_Scn *elf_sec_by_idx(const struct bpf_object *obj, size_t idx);
	libbpf.c:static Elf_Scn *elf_sec_by_name(const struct bpf_object *obj, const char *name);
	libbpf.c:static Elf64_Shdr *elf_sec_hdr(const struct bpf_object *obj, Elf_Scn *scn);
	libbpf.c:static const char *elf_sec_name(const struct bpf_object *obj, Elf_Scn *scn);
	libbpf.c:static Elf_Data *elf_sec_data(const struct bpf_object *obj, Elf_Scn *scn);
	libbpf.c:static Elf64_Sym *elf_sym_by_idx(const struct bpf_object *obj, size_t idx);
	libbpf.c:static Elf64_Rel *elf_rel_by_idx(Elf_Data *data, size_t idx);

	usdt.c:static int find_elf_sec_by_name(Elf *elf, const char *sec_name, GElf_Shdr *shdr, Elf_Scn **scn)

	'struct elf_seg' stuff

	usdt.c:static int cmp_elf_segs(const void *_a, const void *_b)
	usdt.c:static int parse_elf_segs(Elf *elf, const char *path, struct elf_seg **segs, size_t *seg_cnt)
	usdt.c:static int parse_vma_segs(int pid, const char *lib_path, struct elf_seg **segs, size_t *seg_cnt)
	usdt.c:static struct elf_seg *find_elf_seg(struct elf_seg *segs, size_t seg_cnt, long virtaddr)
	usdt.c:static struct elf_seg *find_vma_seg(struct elf_seg *segs, size_t seg_cnt, long offset)


but I can add the new header file later in follow up changes when
we have more elf functions in

jirka

