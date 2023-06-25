Return-Path: <bpf+bounces-3385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD0A73CDC8
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 03:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE5D1C20865
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 01:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8692E62C;
	Sun, 25 Jun 2023 01:19:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B287F
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 01:19:47 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D13BEA
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 18:19:45 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f8fe9dc27aso18273105e9.3
        for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 18:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687655984; x=1690247984;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iZK/pAFfNj65S9PWDkc5nhrIQ3lRgFW7VYz+PNBViXY=;
        b=dNxsExtc1/nCuDK3LRdQcsNgiCZlhSkxSZvJBmZFjAq97DYQru1wWKqxKK5DM8f0Ih
         ECeaJWTunAbt0HcbT2ohZdVvqqmuZ2Am0s3asbTCx3LPQIa0cMnjAfkgWowziT/KPSJz
         LnSMmCOqzdjy1lKTVrTd0H60LXm/5SOfwH9TrKWUgKsppjIqyGDAug4LXdky5CiBVY09
         XkfYNs+rMYJ/yqN6vB85DeILywAbyJI5NQjM8Rp0I8sFYeZA+XomEgXmPlX7AY//r7sg
         XQCQ7XHKwk0xfKtgzN+B48sA+JkVjCCJr9ELFzgsxFJuWnmoXXQ24FldbFpyVeydpflc
         FTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687655984; x=1690247984;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZK/pAFfNj65S9PWDkc5nhrIQ3lRgFW7VYz+PNBViXY=;
        b=OYeXz0BZ0KgT1ku2JNDVnUijzPY7511toWrIm5mOSDDbNbugwnS7PABtaxgt5FCgfo
         RnTIx7hBCxpkK3hkzvTb56VKbi0FOKk/do+6GtzCLKo1jF/iroI5eQIew2kbA+CAv3wT
         uklC2Z996nWc6fool7iU0Ffz3ThJsew/icjJaRQzuF9jHA2pjbtDBXEO6iWEDRByKqNB
         micWW8/5tUlD+UxsLh39lN2ciHfctpROPCrsNWsOrFCJ/tD2qccFxxJnFHT7dOACkBUM
         fqvp/2M0/60tVl6sGRfwk2ExYGjAZ1lPeeBI7ilVeT6ieCynG18hQ1Z3C3M4yZEZ2oLz
         Pjyg==
X-Gm-Message-State: AC+VfDxcxYhhN7zbfKBxiciZI1QZjNYHnIRpFx252E8+FUjyvMPbpK+B
	39k4IzdrvOU+9wo4UKx2R+4=
X-Google-Smtp-Source: ACHHUZ49UDX941Mk2eZVZX6AEgih7HghxDBtnrnQOyntjQg1URLAoBnlTPfMBvi6uPv0pDBdMrIk8g==
X-Received: by 2002:a7b:cbd9:0:b0:3fa:7d9d:456f with SMTP id n25-20020a7bcbd9000000b003fa7d9d456fmr2971499wmi.40.1687655983654;
        Sat, 24 Jun 2023 18:19:43 -0700 (PDT)
Received: from krava (brn-rj-tbond05.sa.cz. [185.94.55.134])
        by smtp.gmail.com with ESMTPSA id v14-20020a1cf70e000000b003f9b2c602c0sm6386525wmh.37.2023.06.24.18.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 18:19:43 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 25 Jun 2023 03:19:36 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf-next 09/24] libbpf: Add
 elf_find_pattern_func_offset function
Message-ID: <ZJeWKDmj3QO4PLqz@krava>
References: <20230620083550.690426-1-jolsa@kernel.org>
 <20230620083550.690426-10-jolsa@kernel.org>
 <CAEf4BzYq2LsFkJxGGxU1QG=t8dn3aAqTa4XRdKcFkKjf2n_kow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYq2LsFkJxGGxU1QG=t8dn3aAqTa4XRdKcFkKjf2n_kow@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 01:39:58PM -0700, Andrii Nakryiko wrote:
> On Tue, Jun 20, 2023 at 1:37 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding elf_find_pattern_func_offset function that looks up
> > offsets for symbols specified by pattern argument.
> >
> > The 'pattern' argument allows wildcards (*?' supported).
> >
> > Offsets are returned in allocated array together with its
> > size and needs to be released by the caller.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c          | 78 +++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf_internal.h |  3 ++
> >  2 files changed, 81 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 1c310b718961..3e5c88caf5d5 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -11165,6 +11165,84 @@ int elf_find_multi_func_offset(const char *binary_path, int cnt,
> >         return ret;
> >  }
> >
> > +static int
> > +__elf_find_pattern_func_offset(Elf *elf, const char *binary_path, const char *pattern,
> > +                              const char ***pnames, unsigned long **poffsets, size_t *pcnt)
> > +{
> > +       int sh_types[2] = { SHT_DYNSYM, SHT_SYMTAB };
> > +       struct elf_symbol_offset *func_offs = NULL;
> > +       unsigned long *offsets = NULL;
> > +       const char **names = NULL;
> > +       size_t func_offs_cnt = 0;
> > +       size_t func_offs_cap = 0;
> > +       int err = 0, i;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(sh_types); i++) {
> > +               struct elf_symbol_iter iter;
> > +               struct elf_symbol *sym;
> > +
> > +               if (elf_symbol_iter_new(&iter, elf, binary_path, sh_types[i]))
> > +                       continue;
> 
> same as in the previous patch, error handling?

ok, same solution as in my previous answer

> 
> > +
> > +               while ((sym = elf_symbol_iter_next(&iter))) {
> > +                       if (!glob_match(sym->name, pattern))
> > +                               continue;
> > +
> > +                       err = libbpf_ensure_mem((void **) &func_offs, &func_offs_cap,
> > +                                               sizeof(*func_offs), func_offs_cnt + 1);
> > +                       if (err)
> > +                               goto out;
> > +
> > +                       func_offs[func_offs_cnt].offset = sym->offset;
> > +                       func_offs[func_offs_cnt].name = strdup(sym->name);
> 
> check for NULL?
> 
> and I'm actually unsure why you need to reuse elf_symbol_offset struct
> here? You just need names and offsets in two separate array, so just
> do that?..

I guess it seemed easier to do just single libbpf_ensure_mem call,
then doing two and maintain cap/cnt for both arrays.. but right,
I guess there will be good solution without the extra array

> 
> > +                       func_offs_cnt++;
> > +               }
> > +
> > +               /* If we found anything in the first symbol section,
> > +                * do not search others to avoid duplicates.
> > +                */
> > +               if (func_offs_cnt)
> > +                       break;
> > +       }
> > +
> > +       offsets = calloc(func_offs_cnt, sizeof(*offsets));
> > +       names = calloc(func_offs_cnt, sizeof(*names));
> > +       if (!offsets || !names) {
> > +               free(offsets);
> > +               free(names);
> > +               err = -ENOMEM;
> > +               goto out;
> > +       }
> > +
> > +       for (i = 0; i < func_offs_cnt; i++) {
> > +               offsets[i] = func_offs[i].offset;
> > +               names[i] = func_offs[i].name;
> 
> see above, why not fill these out right away during elf symbols iteration?

ok

> 
> > +       }
> > +
> > +       *pnames = names;
> > +       *poffsets = offsets;
> > +       *pcnt = func_offs_cnt;
> > +out:
> > +       free(func_offs);
> > +       return err;
> > +}
> > +
> > +int elf_find_pattern_func_offset(const char *binary_path, const char *pattern,
> > +                                const char ***pnames, unsigned long **poffsets,
> > +                                size_t *pcnt)
> > +{
> > +       struct elf_fd elf_fd = {};
> > +       long ret = -ENOENT;
> > +
> > +       ret = open_elf(binary_path, &elf_fd);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = __elf_find_pattern_func_offset(elf_fd.elf, binary_path, pattern, pnames, poffsets, pcnt);
> 
> I don't really like these underscored functions,
> elf_find_pattern_func_offset() already has to do goto out for clean
> ups, this close_elf() thing is just another resource to clean up
> there, I don't see much reason to separate open_elf/close_elf in this
> case

I think that happened because I originally did the 'struct elf_fd' cleanup
as last patch and only then moved it up the git log, so I did not realize
elf_find_pattern_func_offset could be single function, will change

thanks,
jirka

> 
> 
> > +       close_elf(&elf_fd);
> > +       return ret;
> > +}
> > +
> >  /* Find offset of function name in ELF object specified by path. "name" matches
> >   * symbol name or name@@LIB for library functions.
> >   */
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> > index 13d5c12fbd0b..22b0834e7fe1 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -579,4 +579,7 @@ int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attempts);
> >
> >  int elf_find_multi_func_offset(const char *binary_path, int cnt,
> >                                const char **syms, unsigned long **poffsets);
> > +int elf_find_pattern_func_offset(const char *binary_path, const char *pattern,
> > +                                const char ***pnames, unsigned long **poffsets,
> > +                                size_t *pcnt);
> >  #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
> > --
> > 2.41.0
> >

