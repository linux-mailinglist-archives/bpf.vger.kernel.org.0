Return-Path: <bpf+bounces-10223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387D87A35C7
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 16:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56D2281325
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600854A39;
	Sun, 17 Sep 2023 14:09:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C056F46BF
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 14:09:37 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA5511D
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 07:09:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50079d148aeso6072190e87.3
        for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694959774; x=1695564574; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kp6SnmZgIfKPny1qW6KLyl8FjhdyKwdjfWEdpXSSC/I=;
        b=HipcGVcnOUiaMibdOdk3Lm5+DI3X95tfMq5cdU5c8wSeYnuEoWV1BWtGsqQ3+5kl2h
         ZRIOkQEy8WOqo1oamBWlBTj9tGHwp3r1rc1Bik7e/GlgtFYfOReScpAsIt2J6QIiXTEF
         YQDbPVb35psoM0+l8THXakiPGu6Nv30bseB5cg9IKku4h2b98pePB7VNSFwj1eAgPpRG
         RiMhdT2NgvVypQRWc/ymN+uzPFbKuoKuA22Pa3C5J7UCgDTaJpEducBeuRmYkPfI5OIW
         AVHKRtH/WA39/q+O1VX3qQ4DkStGxXw3A3ZLqF627vMEeRWCJyMRQcYE0OgCw4Ugpjx2
         COyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694959774; x=1695564574;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kp6SnmZgIfKPny1qW6KLyl8FjhdyKwdjfWEdpXSSC/I=;
        b=kT56T9P3GeavEVabnkh3NxxDvu/Jey83CUJH9q990hwKKdwyNw3Kuqw2UNv13mqZJT
         ahSbH1Cw2Dh0LcG1Sc61VnTMtNlvGQdhSXcl5Bnc/vKpq/eJrbS+87rvtc8g9vCcqWv9
         n8XtTj0JZh9MGO/1ABvIYvWhAWCPqsVfqwlyBWWupHqULOtcmR8mxxltQJymr9u4XS2V
         GqkGWiSjwqRDNEcrQArw9yeUYeWG2wUrQNZOWWspL19eCpW4blyaD4JZNYegCOAX9H5L
         nXgLaN26NSTmD1ycb94lzdayoXZXmxSTUxwZTwlTzsytA8LdGgexLUS+Aox9nv60+tjC
         K9dQ==
X-Gm-Message-State: AOJu0YyIfsjeF82GABgjjncUNspr4YvtHgEkpUZSYtBPw4DlY8Jv5KwB
	AQqH0ZiE0hXZQjBX9MtJQBMYxPf8CKS5cw==
X-Google-Smtp-Source: AGHT+IEvy0xPaCxJWk7c9ZYYKlpxm5S6TzNC05vEZYj7lckJE6DLB6atp04K7mC0rCN7uQRs0YmCwQ==
X-Received: by 2002:ac2:5976:0:b0:4fb:911b:4e19 with SMTP id h22-20020ac25976000000b004fb911b4e19mr5413741lfp.35.1694959774088;
        Sun, 17 Sep 2023 07:09:34 -0700 (PDT)
Received: from krava ([217.192.101.2])
        by smtp.gmail.com with ESMTPSA id ee17-20020a056402291100b005308fa6ef7fsm3184858edb.16.2023.09.17.07.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 07:09:33 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 17 Sep 2023 16:09:31 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Marcus Seyfarth <m.seyfarth@gmail.com>, bpf <bpf@vger.kernel.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>
Subject: Re: duplicate BTF_IDs leading to symbol redefinition errors?
Message-ID: <ZQcIm/TZH73IklIf@krava>
References: <ZPozfCEF9SV2ADQ5@krava>
 <ZPsJ4AAqNMchvms/@krava>
 <CAKwvOd==X0exrhmsqX1j1WFX77xe8W7xPbfiCY+Rt6abgmkMCQ@mail.gmail.com>
 <ZPuA5+HmbcdBLbIq@krava>
 <ZQLBm8sC+V53CIzD@krava>
 <CAK7LNATiHvOXiWQi9gXJO9rZbT_MFm6NddaWqoY4ykNWf+OYsQ@mail.gmail.com>
 <ZQLX3oSCk95Qf4Ma@krava>
 <CAEf4Bzb5KQ2_LmhN769ifMeSJaWfebccUasQOfQKaOd0nQ51tw@mail.gmail.com>
 <ZQQVr35crUtN1quS@krava>
 <CAEf4BzZe_27FPzMwjaU3d5gPuyXX3iTQJGzT64CCTZLEfpQUvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZe_27FPzMwjaU3d5gPuyXX3iTQJGzT64CCTZLEfpQUvQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 01:41:25PM -0700, Andrii Nakryiko wrote:
> On Fri, Sep 15, 2023 at 1:28 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Sep 14, 2023 at 11:14:19AM -0700, Andrii Nakryiko wrote:
> > > On Thu, Sep 14, 2023 at 2:52 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Thu, Sep 14, 2023 at 05:30:51PM +0900, Masahiro Yamada wrote:
> > > >
> > > > SNIP
> > > >
> > > > > > > so the change is about adding unique id that's basically path of
> > > > > > > the object stored in base32 so it could be used as symbol, so we
> > > > > > > don't really need to read the actual file
> > > > > > >
> > > > > > > the problem is when BTF_ID definition like:
> > > > > > >
> > > > > > > BTF_ID(struct, cgroup)
> > > > > > >
> > > > > > > translates in 2 separate objects into same symbol name because of
> > > > > > > the matching __COUNTER__ macro values (like 380 below)
> > > > > > >
> > > > > > >   __BTF_ID__struct__cgroup__380
> > > > > > >
> > > > > > > this change just adds unique id of the path name at the end of the
> > > > > > > symbol with:
> > > > > > >
> > > > > > >   echo -n 'kernel/bpf/helpers' | base32 -w0 --> NNSXE3TFNQXWE4DGF5UGK3DQMVZHG
> > > > > > >
> > > > > > > so the symbol looks like:
> > > > > > >
> > > > > > >   __BTF_ID__struct__cgroup__380NNSXE3TFNQXWE4DGF5UGK3DQMVZHG
> > > > > > >
> > > > > > > and is unique over the sources
> > > > > > >
> > > > > > > but I still hope we could come up with some better solution ;-)
> > > > > >
> > > > > > so far the only better solution I could come up with is to use
> > > > > > cksum (also from coreutils) instead of base32, which makes the
> > > > > > BTF_ID_BASE value compact
> > > > > >
> > > > > > I'll run test to find out how much it hurts the build time
> > > > > >
> > > > > > jirka
> > > > >
> > > > >
> > > > >
> > > > > Seems a bad idea to me.
> > > > >
> > > > > It would fork a new shell and chsum for all files,
> > > > > while only a few of them need it.
> > > >
> > > > right, I have a change to limit this on kernel and net directories,
> > > > but it's still bad
> > > >
> > > > >
> > > > > Better to consult BTF forks.
> > > >
> > > > perhaps there's better way within kbuild to get unique id/value
> > > > for each object file?
> > >
> > > let's just use __LINE__ + __COUNTER__ for now and teach resolve_btfids
> > > to fail and complain loudly about duplicate symbols?
> >
> > ok, will send that.. but it fails during link before resolve_btfids
> > takes place
> >
> > >
> > >
> > > This will give us time and opportunity to implement a better approach
> > > to .BTF_ids overall. Encoding the desired type name in the symbol name
> > > always felt off. Maybe it's better to encode type + name as data,
> > > which is discarded at the latest stage during vmlinux linking? Either
> >
> > hum, so maybe having a special section (.BTF_ids_desc below)
> > that would have record for each ID placed in .BTF_ids section:
> >
> > asm(                                           \
> > ".pushsection .BTF_ids,\"a\";        \n"       \
> > "1:                                  \n"       \
> > ".zero 4                             \n"       \
> > ".popsection;                        \n"       \
> > ".pushsection .BTF_ids_desc,\"a\";   \n"       \
> > ".long 1b                            \n"       \
> >
> > and somehow get prefix and name pointers in here:
> >
> > ".long prefix
> > ".long name
> >
> > ".popsection;                        \n");
> >
> > so resolve_btfids would iterate .BTF_ids_desc records and fix
> > up .BTF_ids data..
> >
> 
> Something like that. I don't think it's even a regression in terms of
> vmlinux space usage, because right now we spend as much space on
> storing symbol names. So just adding string pointers would be already
> a win due to repeating "struct", "func", etc strings.
> 
> 
> > we might need to do one extra link phase to get rid of the
> > .BTF_ids_desc secion
> 
> Hopefully we can find a way to avoid this, we already do like 3 link
> phases at least (for kallsyms), so doing all that on the first one and
> then stripping it out using link script at subsequent one would be
> best.

perhaps we could move that section under .init.data and
get rid of it on startup

jirka

