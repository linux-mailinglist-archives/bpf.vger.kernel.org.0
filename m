Return-Path: <bpf+bounces-1120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B34170E48C
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 20:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E1A1C20DBB
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 18:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5105121CD9;
	Tue, 23 May 2023 18:23:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CD22098A
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 18:23:01 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E388AE5
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 11:22:59 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-96fffe11714so420890066b.0
        for <bpf@vger.kernel.org>; Tue, 23 May 2023 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684866178; x=1687458178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhaElOpxUWgNvKB4CZud2BABpmCUe91eDtSNyWrzMxE=;
        b=SbLePw5X/P7nwQn0nK1kPNwnSJE9uGFhTIzHi3T2j4la+zyMvrX2au5wS4D4T1jL4o
         7/hGOde0Rrh0OyldcDF6PxTMCoBwoKXmfsKMmehmpnfPb7Wf+lPB3Vgd0NhqaMnZXHIS
         VHokJxItWEaFnkb9a4oIpPBtlmC8wuvcasm2JK+9WwLZ1H1Lfzz3+twzPQXR89XAkOMe
         8OM5+LzPta5Gi7FCauNm8zMDLHRZ0hj3ba1aO3vMstjJ1MA+Vkb+Toc8u1eZczWuACZE
         6Q5UW1BgRhEglYH7tCNUKqsuRczbNstEl+F6X/tqEuBzpp0HCtTpvvkPmlTykodTTx1F
         JsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684866178; x=1687458178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhaElOpxUWgNvKB4CZud2BABpmCUe91eDtSNyWrzMxE=;
        b=EqZKKLJ1tabDJ8+PBvCUMw/PCtuxkc3Pz1ukpBoFJPbYq9CYE7MEFId7RUbJ01oNhE
         Y8RnUpUbdMaGNbdxw/Ov19mOEHlPPUz39wNJ9p2o5Jc+9OCrGcYnpn9UzhY6+Sf8uS6J
         E/P4lcGKRaOguIeN1PmST9rHzKaMTFsTqvRQilyZ9HP+Dn4iC0Kbn2JQtFyKqWlPQzBu
         qsn+T7Tmp0kJb3wN4B6FzUz93YdqqJ2zWwAVfnnHsYoUxWq9VTXaknBhLLzV276wAUK5
         fawPiQmoIHy3usNeB9noe5j5EAH4IBv5bj/5AAvCHhb9ZzCjeamY+dyyLxcINvw/HzvL
         ZbHg==
X-Gm-Message-State: AC+VfDwm9NEru8+R+ZhlrRxkHWBsiKcDIkix9iM+fWM2jcJxR4ne66YO
	CAr4FE1q+y8y3VlX4yIhRcPCClaL9s9E+QoBAtE=
X-Google-Smtp-Source: ACHHUZ45t+3FVI7Cb9QlYPuk/6AofK9Ox6Cbp/6oemQa8vd2DIlDptNT61NhV+vq/NHnv/HH39JMio4nAIAalscE8Oc=
X-Received: by 2002:a17:907:9620:b0:96f:87ae:49eb with SMTP id
 gb32-20020a170907962000b0096f87ae49ebmr14640474ejc.16.1684866178267; Tue, 23
 May 2023 11:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230523132547.94384-1-liu.yun@linux.dev> <ZGznHMU1uhdPnE/F@krava>
In-Reply-To: <ZGznHMU1uhdPnE/F@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 May 2023 11:22:46 -0700
Message-ID: <CAEf4BzZTn41v7_xAzg4A0xCq9qWmFjLxebHe5gTw9p-=A93RQw@mail.gmail.com>
Subject: Re: [PATCH] libbpf: kprobe.multi: Filter with blacklist and available_filter_functions
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Jackie Liu <liu.yun@linux.dev>, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, bpf@vger.kernel.org, liuyun01@kylinos.cn, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 23, 2023 at 9:17=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, May 23, 2023 at 09:25:47PM +0800, Jackie Liu wrote:
> > From: Jackie Liu <liuyun01@kylinos.cn>
> >
> > When using regular expression matching with "kprobe multi", it scans al=
l
> > the functions under "/proc/kallsyms" that can be matched. However, not =
all
> > of them can be traced by kprobe.multi. If any one of the functions fail=
s
> > to be traced, it will result in the failure of all functions. The best
> > approach is to filter out the functions that cannot be traced to ensure
> > proper tracking of the functions.
> >
> > But, the addition of these checks will frequently probe whether a funct=
ion
> > complies with "available_filter_functions" and ensure that it has not b=
een
> > filtered by kprobe's blacklist. As a result, it may take a longer time
> > during startup. The function implementation is referenced from BCC's
> > "kprobe_exists()"
> >
> > Here is the test eBPF program [1].
> > [1] https://github.com/JackieLiu1/ketones/commit/a9e76d1ba57390e533b8b3=
eadde97f7a4535e867
> >
> > Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> > ---
> >  tools/lib/bpf/libbpf.c | 47 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index ad1ec893b41b..6a201267fa08 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -10421,6 +10421,50 @@ struct kprobe_multi_resolve {
> >       size_t cnt;
> >  };
> >
> > +static bool filter_available_function(const char *name)
> > +{
> > +     char addr_range[256];
> > +     char sym_name[256];
> > +     FILE *f;
> > +     int ret;
> > +
> > +     f =3D fopen("/sys/kernel/debug/kprobes/blacklist", "r");
> > +     if (!f)
> > +             goto avail_filter;
> > +
> > +     while (true) {
> > +             ret =3D fscanf(f, "%s %s%*[^\n]\n", addr_range, sym_name)=
;
> > +             if (ret =3D=3D EOF && feof(f))
> > +                     break;
> > +             if (ret !=3D 2)
> > +                     break;
> > +             if (!strcmp(name, sym_name)) {
> > +                     fclose(f);
> > +                     return false;
> > +             }
> > +     }
> > +     fclose(f);
>
> so available_filter_functions already contains all traceable symbols
> for kprobe_multi/fprobe
>
> kprobes/blacklist is kprobe specific and does not apply to fprobe,
> is there a crash when attaching function from kprobes/blacklist ?
>
> > +
> > +avail_filter:
> > +     f =3D fopen("/sys/kernel/debug/tracing/available_filter_functions=
", "r");
> > +     if (!f)
> > +             return true;
> > +
> > +     while (true) {
> > +             ret =3D fscanf(f, "%s%*[^\n]\n", sym_name);
> > +             if (ret =3D=3D EOF && feof(f))
> > +                     break;
> > +             if (ret !=3D 1)
> > +                     break;
> > +             if (!strcmp(name, sym_name)) {
> > +                     fclose(f);
> > +                     return true;
> > +             }
> > +     }
> > +     fclose(f);
> > +     return false;
> > +}
> > +
> >  static int
> >  resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
> >                       const char *sym_name, void *ctx)
> > @@ -10431,6 +10475,9 @@ resolve_kprobe_multi_cb(unsigned long long sym_=
addr, char sym_type,
> >       if (!glob_match(sym_name, res->pattern))
> >               return 0;
> >
> > +     if (!filter_available_function(sym_name))
> > +             return 0;
>
> I think it'd be better to parse available_filter_functions directly
> for kprobe_multi instead of filtering out kallsyms entries

yep, available_filter_functions should be cheaper to parse than
kallsyms. We can probably fallback to kallsyms still, if
available_filter_functions are missing.

Furthermore, me and Steven chatted at lsfmm2023 about having an
available_filter_functions-like file with kernel function addresses
(not just names), which would speed up attachment as well. It could be
useful in some other scenarios as well (e.g., I think retsnoop has to
join kallsyms and available_filter_functions). I think it's still a
good idea to add this new file, given kernel has all this information
readily available anyways.


>
> we could add libbpf_available_filter_functions_parse function with
> similar callback to go over available_filter_functions file

or iterator ;)

but either way, current approach will do linear scan for each matched
function, which is hugely inefficient, so definitely a no go

>
>
> jirka
>
> > +
> >       err =3D libbpf_ensure_mem((void **) &res->addrs, &res->cap, sizeo=
f(unsigned long),
> >                               res->cnt + 1);
> >       if (err)
> > --
> > 2.25.1
> >
> >

