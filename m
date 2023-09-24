Return-Path: <bpf+bounces-10710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD117AC92C
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 15:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 04DDC1C2082B
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 13:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463126AD7;
	Sun, 24 Sep 2023 13:27:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771E053A6
	for <bpf@vger.kernel.org>; Sun, 24 Sep 2023 13:27:28 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0DF1F29
	for <bpf@vger.kernel.org>; Sun, 24 Sep 2023 06:27:25 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-405361bb93bso44474455e9.3
        for <bpf@vger.kernel.org>; Sun, 24 Sep 2023 06:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695562044; x=1696166844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cbu6rkAxfPF5il5/avof2BWEnk2QGAzA+mWNA0/uAag=;
        b=Fgm+VuSthTeOj8xBQqgSTW3NYP+BgB+Gn3FCrpZM5VFyUN2WoDqWGkNlJZvvLTd2VP
         5gATsxTUZG6oW5ovcYjvcCpsR7uY6ggcFC7wgenxBuCOrakvGTuBhoA7MkhwOHERP/wT
         pbcn12/ZPGI/fizf/6+n6jkG5ieX1Qnh0iEpPMcNX3qXMUgsLuUrYRL3Ltfd8ZPb/Rdj
         DWRWaT6AeLKZvrui6B/S1+mM82MsVVWWLABI0ySwm996WYZabXzH43ERLdN8Q7UXmYVj
         PvUwOVUAL2jk0SI325oKJ9CB0ARR4IjdERlVRegx2jMgb+x2+3vokYH8z9CgTJkvPhwS
         mR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695562044; x=1696166844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbu6rkAxfPF5il5/avof2BWEnk2QGAzA+mWNA0/uAag=;
        b=G0OznANEWvgDAm7WNoXHfyY4JQX4pswPbSa4HxhEbtgr6/CEUHQmAdtRO1cp4NfBKN
         g5gnhz82OLJrcOGpCfhxpwAvg+yMT/SvlWuOWjPuqWOIylkjB88HQV938lDZjdgXR3Ww
         6sEzFkIXEt7jgS6va3Dh6jFyjFXaI/XH6ffKeAzM9m4NBU1xrWx1Bb1PPrjQ4s/XcbDd
         L4a9dVq+VSR8gf+45uF+xMb+B2bkhZfPS5tS6YYWE48SZVrhQQ069bKc6U6TEWMLjYqn
         kE1TilN3D3W5ih3MJCsH06w+0mYloe5x2jbDwQswRaazgGB4ncEVGtpDynaPvSkUYaU2
         YdFA==
X-Gm-Message-State: AOJu0Yzwk+GCDJlZ95oWKWuz0xQph610YYykqatyFTBzBKmJKLELXsZD
	rO5V/NF1SCxrxgP+7GZfsuMFH2B64M8=
X-Google-Smtp-Source: AGHT+IFltB8e+9+uUhrJ+shwpZsUwTKNcbz4g8rcIxeudO2m9S7xwJr99iKnYfxiRYElPL47aTW+gA==
X-Received: by 2002:a7b:c84e:0:b0:3fe:2b60:b24e with SMTP id c14-20020a7bc84e000000b003fe2b60b24emr3586208wml.29.1695562043693;
        Sun, 24 Sep 2023 06:27:23 -0700 (PDT)
Received: from krava (37-188-170-118.red.o2.cz. [37.188.170.118])
        by smtp.gmail.com with ESMTPSA id u23-20020a05600c211700b004042dbb8925sm12418786wml.38.2023.09.24.06.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 06:27:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 24 Sep 2023 15:27:18 +0200
To: Jiri Olsa <olsajiri@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Marcus Seyfarth <m.seyfarth@gmail.com>, bpf <bpf@vger.kernel.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>
Subject: Re: duplicate BTF_IDs leading to symbol redefinition errors?
Message-ID: <ZRA5NjXsgRJ0kueF@krava>
References: <ZPsJ4AAqNMchvms/@krava>
 <CAKwvOd==X0exrhmsqX1j1WFX77xe8W7xPbfiCY+Rt6abgmkMCQ@mail.gmail.com>
 <ZPuA5+HmbcdBLbIq@krava>
 <ZQLBm8sC+V53CIzD@krava>
 <CAK7LNATiHvOXiWQi9gXJO9rZbT_MFm6NddaWqoY4ykNWf+OYsQ@mail.gmail.com>
 <ZQLX3oSCk95Qf4Ma@krava>
 <CAEf4Bzb5KQ2_LmhN769ifMeSJaWfebccUasQOfQKaOd0nQ51tw@mail.gmail.com>
 <ZQQVr35crUtN1quS@krava>
 <CAEf4BzZe_27FPzMwjaU3d5gPuyXX3iTQJGzT64CCTZLEfpQUvQ@mail.gmail.com>
 <ZQcIm/TZH73IklIf@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQcIm/TZH73IklIf@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 17, 2023 at 04:09:31PM +0200, Jiri Olsa wrote:

SNIP

> > > > This will give us time and opportunity to implement a better approach
> > > > to .BTF_ids overall. Encoding the desired type name in the symbol name
> > > > always felt off. Maybe it's better to encode type + name as data,
> > > > which is discarded at the latest stage during vmlinux linking? Either
> > >
> > > hum, so maybe having a special section (.BTF_ids_desc below)
> > > that would have record for each ID placed in .BTF_ids section:
> > >
> > > asm(                                           \
> > > ".pushsection .BTF_ids,\"a\";        \n"       \
> > > "1:                                  \n"       \
> > > ".zero 4                             \n"       \
> > > ".popsection;                        \n"       \
> > > ".pushsection .BTF_ids_desc,\"a\";   \n"       \
> > > ".long 1b                            \n"       \
> > >
> > > and somehow get prefix and name pointers in here:
> > >
> > > ".long prefix
> > > ".long name
> > >
> > > ".popsection;                        \n");
> > >
> > > so resolve_btfids would iterate .BTF_ids_desc records and fix
> > > up .BTF_ids data..
> > >
> > 
> > Something like that. I don't think it's even a regression in terms of
> > vmlinux space usage, because right now we spend as much space on
> > storing symbol names. So just adding string pointers would be already
> > a win due to repeating "struct", "func", etc strings.
> > 
> > 
> > > we might need to do one extra link phase to get rid of the
> > > .BTF_ids_desc secion
> > 
> > Hopefully we can find a way to avoid this, we already do like 3 link
> > phases at least (for kallsyms), so doing all that on the first one and
> > then stripping it out using link script at subsequent one would be
> > best.
> 
> perhaps we could move that section under .init.data and
> get rid of it on startup

hi,
I made first version on having extra sections that contain the
auxiliary data for .BTF_ids section,

new sections are:

  .BTF_ids_data that holds type and name strings
  .BTF_ids_desc that holds array of

     struct {
       u64 addr_btf_ids;      // address to .BTF_ids section
       u64 addr_type;         // address of type string
       u64 addr_name;         // address of name string
     }

it seems to work ok for vmlinux, but there' problem with kernel modules,
because all the .BTF_ids_desc datas need to be relocated first.. and we
don't get relocated data when reading elf object.. I'll check if we can
relocate that ourselfs, but might be tricky to support this on other archs

It's all in here together with resolve_btfids change:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  btfid_fix

jirka


---
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 9c59409104f6..2f7518b15301 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -658,6 +658,14 @@
 	. = ALIGN(4);							\
 	.BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {			\
 		*(.BTF_ids)						\
+	}								\
+	. = ALIGN(4);							\
+	.BTF_ids_data : AT(ADDR(.BTF_ids_data) - LOAD_OFFSET) {		\
+		*(.BTF_ids_data)					\
+	}								\
+	. = ALIGN(4);							\
+	.BTF_ids_desc : AT(ADDR(.BTF_ids_desc) - LOAD_OFFSET) {		\
+		*(.BTF_ids_desc)					\
 	}
 #else
 #define BTF
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index a9cb10b0e2e9..63a4ebc7f331 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -34,6 +34,7 @@ struct btf_id_set8 {
 
 #define BTF_IDS_SECTION ".BTF_ids"
 
+#ifdef MODULE
 #define ____BTF_ID(symbol, word)			\
 asm(							\
 ".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
@@ -65,6 +66,38 @@ word							\
 #define BTF_ID_FLAGS(prefix, name, ...) \
 	__BTF_ID_FLAGS(prefix, name, ##__VA_ARGS__, 0)
 
+#else
+#define __BTF_ID(type, name, word)             \
+asm(                                           \
+".pushsection .BTF_ids,\"a\";        \n"       \
+"1:                                  \n"       \
+".zero 4                             \n"       \
+word                                           \
+".popsection;                        \n"       \
+".pushsection .BTF_ids_data,\"a\";   \n"       \
+"2:                                  \n"       \
+".string \"" #type "\"               \n"       \
+"3:                                  \n"       \
+".string \"" #name "\"               \n"       \
+".popsection;                        \n"       \
+".pushsection .BTF_ids_desc,\"a\";   \n"       \
+".quad 1b                            \n"       \
+".quad 2b                            \n"       \
+".quad 3b                            \n"       \
+".popsection;                        \n");
+
+#define BTF_ID(type, name) \
+	__BTF_ID(type, name, "")
+
+#define ____BTF_ID_FLAGS(type, name, flags, ...) \
+	__BTF_ID(type, name, ".long " #flags "\n")
+#define __BTF_ID_FLAGS(type, name, flags, ...) \
+	____BTF_ID_FLAGS(type, name, flags)
+#define BTF_ID_FLAGS(type, name, ...) \
+	__BTF_ID_FLAGS(type, name, ##__VA_ARGS__, 0)
+
+#endif /* MODULE */
+
 /*
  * The BTF_ID_LIST macro defines pure (unsorted) list
  * of BTF IDs, with following layout:

