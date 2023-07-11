Return-Path: <bpf+bounces-4740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB2974E9CD
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD201C20D1A
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 09:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5317317743;
	Tue, 11 Jul 2023 09:04:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2630117738
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:04:32 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E5EE56
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:04:30 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b6fbf0c0e2so83851841fa.2
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689066268; x=1691658268;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UNiwvwWuhDMorw95SuybhpbJNn2iWK1iwWfSfmi+mu4=;
        b=R5c1FdLhIwmXrtfQilOgTHPHuzCcGCjMuFun7fqYs8TgG86KPybgJ7Ki0zgNs13Nqy
         yZNQrxo008U30Nid8QVCGqHvk+UUX34PL9kBk172Be1uW8jE6qlkZbiHYTMwgkXaPoPZ
         NVBRN+JB/dmz1P2KjpnQe273LKVdyDI3dAt9MWPjih4RwbfMSUeUdwlDae5fYK0FOtkB
         mAdN2y6sSUuYjohQDeq+mSQFNY6G8t9OJZIkzwLGzOU2J7wlokyw7dIznxAJ5Coja1ZY
         oTlVasPmMquymiQimOGrbebhVNR8KXdCB+lZJJuwFuDCK2XdNqytRedrivS8vBCHW7ya
         mAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066268; x=1691658268;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UNiwvwWuhDMorw95SuybhpbJNn2iWK1iwWfSfmi+mu4=;
        b=LiJEF7knJc4qBHmeCp1hq2pZpfuihXWw2Qrhro9t/W9RnESxS2R6GG/MrmvAYHoCUC
         jMDGwDl1yPJcRtJkjMqzYjbGPOPDP10uHhxVWA/OLGKMeLch+Vdzr+4nacFPZm9HZxMW
         wBoLrwknApP/5PWndJvGSEwACZX7fg7ZHTcvjds7aaK5feTHB/YCw4biSGFURGcnVZiX
         cr+tE58hEUw62J0kqOVyqYNBqupQslsa1/FWBhDXucMv18OIWFhDZTYO9itbNu6ta//R
         5vbkN1/zLXk+HvLDXDcqfyPbdDnD5hFq/r16NSG7IcdCYf5KwaYt8QSmr9j5rei9X4L+
         9aZQ==
X-Gm-Message-State: ABy/qLbNgMfUj2T4pKDWcD+GkM7VIHYCFyr6/ROT25aFIJ9tz1vVBSXx
	7caIcso943+RmSH4EGwKuGE=
X-Google-Smtp-Source: APBJJlE8GdfAVWTf1LFDjvWV7ukiUz3Qy7EkgwagY/kKhFuK16FjGR92+NvS7XkciuYVkcmrRDw/Bw==
X-Received: by 2002:a2e:969a:0:b0:2b6:dcde:b77f with SMTP id q26-20020a2e969a000000b002b6dcdeb77fmr13331346lji.35.1689066268451;
        Tue, 11 Jul 2023 02:04:28 -0700 (PDT)
Received: from krava (net-109-116-206-239.cust.vodafonedsl.it. [109.116.206.239])
        by smtp.gmail.com with ESMTPSA id gs4-20020a170906f18400b00992b66e54e9sm859975ejb.214.2023.07.11.02.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:04:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Jul 2023 11:04:24 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf-next 10/26] libbpf: Add elf_resolve_syms_offsets
 function
Message-ID: <ZK0bGPFTJUSW/jza@krava>
References: <20230630083344.984305-1-jolsa@kernel.org>
 <20230630083344.984305-11-jolsa@kernel.org>
 <CAEf4Bza0sDmQgcPMh3S5rRHdw9n3Cx_KwCLvP7y__xkR1vOL8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza0sDmQgcPMh3S5rRHdw9n3Cx_KwCLvP7y__xkR1vOL8A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 08:48:13PM -0700, Andrii Nakryiko wrote:
> On Fri, Jun 30, 2023 at 1:35 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding elf_resolve_syms_offsets function that looks up
> > offsets for symbols specified in syms array argument.
> >
> > Offsets are returned in allocated array with the 'cnt' size,
> > that needs to be released by the caller.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/elf.c        | 105 +++++++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf_elf.h |   2 +
> >  2 files changed, 107 insertions(+)
> >
> > diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> > index fcce4bd2478f..7e2f3b2e1fb6 100644
> > --- a/tools/lib/bpf/elf.c
> > +++ b/tools/lib/bpf/elf.c
> > @@ -271,3 +271,108 @@ long elf_find_func_offset_from_file(const char *binary_path, const char *name)
> >         elf_close(&elf_fd);
> >         return ret;
> >  }
> > +
> > +struct symbol {
> > +       const char *name;
> > +       int bind;
> > +       int idx;
> > +};
> > +
> > +static int symbol_cmp(const void *_a, const void *_b)
> > +{
> > +       const struct symbol *a = _a;
> > +       const struct symbol *b = _b;
> 
> please, let's not (over)use leading underscores, x/y, s1/s2, whatever

ok

> 
> > +
> > +       return strcmp(a->name, b->name);
> > +}
> > +
> 
> probably worth leaving a comment that the caller should free offsets on success?

ook

> 
> > +int elf_resolve_syms_offsets(const char *binary_path, int cnt,
> > +                            const char **syms, unsigned long **poffsets)
> > +{
> > +       int sh_types[2] = { SHT_DYNSYM, SHT_SYMTAB };
> > +       int err = 0, i, cnt_done = 0;
> > +       unsigned long *offsets;
> > +       struct symbol *symbols;
> > +       struct elf_fd elf_fd;
> > +
> > +       err = elf_open(binary_path, &elf_fd);
> > +       if (err)
> > +               return err;
> > +
> > +       offsets = calloc(cnt, sizeof(*offsets));
> > +       symbols = calloc(cnt, sizeof(*symbols));
> > +
> > +       if (!offsets || !symbols) {
> > +               err = -ENOMEM;
> > +               goto out;
> > +       }
> > +
> > +       for (i = 0; i < cnt; i++) {
> > +               symbols[i].name = syms[i];
> > +               symbols[i].idx = i;
> > +       }
> > +
> > +       qsort(symbols, cnt, sizeof(*symbols), symbol_cmp);
> > +
> > +       for (i = 0; i < ARRAY_SIZE(sh_types); i++) {
> > +               struct elf_sym_iter iter;
> > +               struct elf_sym *sym;
> > +
> > +               err = elf_sym_iter_new(&iter, elf_fd.elf, binary_path, sh_types[i], STT_FUNC);
> > +               if (err) {
> > +                       if (err == -ENOENT)
> > +                               continue;
> > +                       goto out;
> > +               }
> 
> same nit, no need for nested ifs

ok

> > +
> > +               while ((sym = elf_sym_iter_next(&iter))) {
> > +                       int bind = GELF_ST_BIND(sym->sym.st_info);
> > +                       struct symbol *found, tmp = {
> > +                               .name = sym->name,
> > +                       };
> > +                       unsigned long *offset;
> > +
> > +                       found = bsearch(&tmp, symbols, cnt, sizeof(*symbols), symbol_cmp);
> > +                       if (!found)
> > +                               continue;
> > +
> > +                       offset = &offsets[found->idx];
> > +                       if (*offset > 0) {
> > +                               /* same offset, no problem */
> > +                               if (*offset == elf_sym_offset(sym))
> > +                                       continue;
> > +                               /* handle multiple matches */
> > +                               if (found->bind != STB_WEAK && bind != STB_WEAK) {
> > +                                       /* Only accept one non-weak bind. */
> > +                                       pr_warn("elf: ambiguous match foundr '%s', '%s' in '%s'\n",
> 
> typo: found
> 
> but also wouldn't sym->name and found->name be always the same? Maybe
> log sym->name, previous *offset and newly calculated
> elf_sym_offset(sym) instead?

ok

> 
> > +                                               sym->name, found->name, binary_path);
> > +                                       err = -LIBBPF_ERRNO__FORMAT;
> 
> I'd minimize using those custom libbpf-only errors, why not -ESRCH here?

ok

> 
> > +                                       goto out;
> > +                               } else if (bind == STB_WEAK) {
> > +                                       /* already have a non-weak bind, and
> > +                                        * this is a weak bind, so ignore.
> > +                                        */
> > +                                       continue;
> > +                               }
> > +                       } else {
> > +                               cnt_done++;
> > +                       }
> > +                       *offset = elf_sym_offset(sym);
> 
> maybe remember elf_sym_offset() result in a variable? you are using it
> in two (and with my suggestion above it will be three) places already

ok


jirka

