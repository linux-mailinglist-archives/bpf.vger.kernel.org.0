Return-Path: <bpf+bounces-3384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D16073CDC7
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 03:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9181C2032A
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 01:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B320162C;
	Sun, 25 Jun 2023 01:19:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6E77F
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 01:19:32 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946F6EA
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 18:19:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31297125334so1737804f8f.0
        for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 18:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687655969; x=1690247969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XooyKelbzR8y0tBkBizKCTmBSsNUTpvVKxds+EvEiHk=;
        b=OFIcJ76A3n1y/fxOAhU3cUUuMbjcYVfWvFkF9/4lzqV25m1B5n+ZZx4yKHLpQ3AWcc
         pbusnnMUAW+fMa/b3QsLHvGjNh5AezS8kRxy+XL+T/USTHEEGyMgLa1Gm/fQ/qnbIHiU
         0S/Kq6P3R+XSj+WVcIWuwJD1WlAMsEdAUwJj05vQMDJCFaZS87oLdIImZqBUh+/bU4Mi
         iwoh8j52YlhMBbrqzX2DGID8ubLRxv237DFDcnVZVuIC3rZ+QDMRHFlKAHFRz4AmjYNf
         qVLOAK3ycWOiC+RNUzrNBIZ2wI+9+jSmEsPRIgb+iX4ZpwWJ7MbxzAQlgK+OfZeO0cWK
         9JiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687655969; x=1690247969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XooyKelbzR8y0tBkBizKCTmBSsNUTpvVKxds+EvEiHk=;
        b=Mb1eL4JQ9s6mVidGLRvV0u+2aOaB9DHIvy2ypl/f28y0/AZOoYfkm9xCUa4lJLcvjH
         bpgSeX6OuggbTqj+GAcY3zEtGke/HG3DnY6lbtF+nJs3crU48ClTKtdTBz8QRrcP417C
         2Xt3nbp22NNqu1QjYJr+G7/Kq1lAtAb75CuzJ6bTUOgakGn2tkBSmLK4OPedy+di7KQ0
         6Uu4QuuWuYsFxUfakMkF+OCU+j6tWMWZz3T2dZ8sD6lvE7zj3cJAIkDf6YmtILH0G7mX
         NFqb9OMh5gJiCKCUcOnQLJppB1DnhPfONY5+Bfod5QiLSEC01tLENs7mjGuhjEeNlF1E
         nexw==
X-Gm-Message-State: AC+VfDxBdR+0k+LPQdAsefYqD2NhR/YSTDtTrkHPWC20IwxDGVMOHueR
	weA/lbt/LmGq1custJmgnjs=
X-Google-Smtp-Source: ACHHUZ73J8eGTnanxPen14kl46S9rKb+48hY1Brumy0ovuUCNXzRKweJruRYzauu01P6/RUDFC8Lgg==
X-Received: by 2002:a05:600c:138c:b0:3fa:7bf0:7a81 with SMTP id u12-20020a05600c138c00b003fa7bf07a81mr5354264wmf.0.1687655968813;
        Sat, 24 Jun 2023 18:19:28 -0700 (PDT)
Received: from krava (brn-rj-tbond05.sa.cz. [185.94.55.134])
        by smtp.gmail.com with ESMTPSA id hn8-20020a05600ca38800b003fa722e8b48sm6432524wmb.32.2023.06.24.18.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 18:19:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 25 Jun 2023 03:19:24 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf-next 08/24] libbpf: Add elf_find_multi_func_offset
 function
Message-ID: <ZJeWHKFXubOWd+Mj@krava>
References: <20230620083550.690426-1-jolsa@kernel.org>
 <20230620083550.690426-9-jolsa@kernel.org>
 <CAEf4BzZFipgUhpaUY7-Cy9+jBOtBws5bdnFMh0FgWk_kh-z6pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZFipgUhpaUY7-Cy9+jBOtBws5bdnFMh0FgWk_kh-z6pQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 01:39:54PM -0700, Andrii Nakryiko wrote:
> On Tue, Jun 20, 2023 at 1:37 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding elf_find_multi_func_offset function that looks up
> > offsets for symbols specified in syms array argument.
> >
> > Offsets are returned in allocated array with the 'cnt' size,
> > that needs to be released by the caller.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c          | 112 ++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf_internal.h |   2 +
> >  2 files changed, 114 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 30d9e3b69114..1c310b718961 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -11053,6 +11053,118 @@ static long elf_find_func_offset(Elf *elf, const char *binary_path, const char *
> >         return ret;
> >  }
> >
> > +struct elf_symbol_offset {
> > +       const char *name;
> > +       unsigned long offset;
> > +       int bind;
> > +       int idx;
> > +};
> > +
> > +static int cmp_func_offset(const void *_a, const void *_b)
> > +{
> > +       const struct elf_symbol_offset *a = _a;
> > +       const struct elf_symbol_offset *b = _b;
> > +
> > +       return strcmp(a->name, b->name);
> > +}
> > +
> > +static int
> > +__elf_find_multi_func_offset(Elf *elf, const char *binary_path, int cnt,
> > +                            const char **syms, unsigned long **poffsets)
> > +{
> > +       int sh_types[2] = { SHT_DYNSYM, SHT_SYMTAB };
> > +       struct elf_symbol_offset *func_offs;
> > +       int err = 0, i, idx, cnt_done = 0;
> > +       unsigned long *offsets = NULL;
> > +
> > +       func_offs = calloc(cnt, sizeof(*func_offs));
> > +       if (!func_offs)
> > +               return -ENOMEM;
> > +
> > +       for (i = 0; i < cnt; i++) {
> > +               func_offs[i].name = syms[i];
> > +               func_offs[i].idx = i;
> > +       }
> > +
> > +       qsort(func_offs, cnt, sizeof(*func_offs), cmp_func_offset);
> > +
> > +       for (i = 0; i < ARRAY_SIZE(sh_types); i++) {
> > +               struct elf_symbol_iter iter;
> > +               struct elf_symbol *sym;
> > +
> > +               if (elf_symbol_iter_new(&iter, elf, binary_path, sh_types[i]))
> 
> a bit lax handling of initialization errors here, let's be a bit more
> strict here?

right, I'll have elf_symbol_iter_new return -ENOENT in case there's no
'sh_types[i]' section type (and we want to try next section type) and
fail otherwise

> 
> > +                       continue;
> > +
> > +               while ((sym = elf_symbol_iter_next(&iter))) {
> > +                       struct elf_symbol_offset *fo, tmp = {
> > +                               .name = sym->name,
> > +                       };
> > +
> > +                       fo = bsearch(&tmp, func_offs, cnt, sizeof(*func_offs),
> > +                                    cmp_func_offset);
> > +                       if (!fo)
> > +                               continue;
> > +
> > +                       if (fo->offset > 0) {
> > +                               /* same offset, no problem */
> > +                               if (fo->offset == sym->offset)
> > +                                       continue;
> > +                               /* handle multiple matches */
> > +                               if (fo->bind != STB_WEAK && sym->bind != STB_WEAK) {
> > +                                       /* Only accept one non-weak bind. */
> > +                                       pr_warn("elf: ambiguous match for '%s', '%s' in '%s'\n",
> > +                                               sym->name, fo->name, binary_path);
> > +                                       err = -LIBBPF_ERRNO__FORMAT;
> > +                                       goto out;
> > +                               } else if (sym->bind == STB_WEAK) {
> > +                                       /* already have a non-weak bind, and
> > +                                        * this is a weak bind, so ignore.
> > +                                        */
> > +                                       continue;
> > +                               }
> > +                       }
> > +                       if (!fo->offset)
> > +                               cnt_done++;
> > +                       fo->offset = sym->offset;
> > +                       fo->bind = sym->bind;
> > +               }
> > +       }
> > +
> > +       if (cnt != cnt_done) {
> > +               err = -ENOENT;
> > +               goto out;
> > +       }
> > +       offsets = calloc(cnt, sizeof(*offsets));
> 
> you can allocate it at the very beginning and fill it out based on
> fo->idx, there is no need to store offset in elf_symbol_offset

true, will fix

> 
> > +       if (!offsets) {
> > +               err = -ENOMEM;
> > +               goto out;
> > +       }
> > +       for (i = 0; i < cnt; i++) {
> > +               idx = func_offs[i].idx;
> > +               offsets[idx] = func_offs[i].offset;
> > +       }
> > +
> > +out:
> > +       *poffsets = offsets;
> > +       free(func_offs);
> > +       return err;
> > +}
> > +
> > +int elf_find_multi_func_offset(const char *binary_path, int cnt,
> > +                              const char **syms, unsigned long **poffsets)
> > +{
> > +       struct elf_fd elf_fd = {};
> 
> do you need to initialize this struct?

I recall getting gcc warn/error, which I can't see anymore ;-)
will remove

> 
> > +       long ret = -ENOENT;
> 
> same here, you always override ret, so no need to init it?

yes

> 
> > +
> > +       ret = open_elf(binary_path, &elf_fd);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = __elf_find_multi_func_offset(elf_fd.elf, binary_path, cnt, syms, poffsets);
> 
> is there a point of having elf_find_multi_func_offset and
> __elf_find_multi_func_offset separately? can you please combine?

ok

thanks,
jirka

