Return-Path: <bpf+bounces-10913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340967AF806
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 04:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3BA63281D17
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 02:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A7F5257;
	Wed, 27 Sep 2023 02:12:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212EA29AF
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 02:12:23 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAAD140E6
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 19:12:20 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c4e7951dc1so3036725a34.3
        for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 19:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695780740; x=1696385540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uXbAnfG7Klg4kxQCKSM3U/vizxaMvqOmTFPhEn3fCg=;
        b=V1ToZMZpJDpQUDNfmsXdS4xRXPGtpZB5wDToII7P06GBcgicUmGU+VNCYAz8amF8BT
         UaG7MaRMlhO/oLQ/+NzpygNrukfLgx5rIQhUSTRRsLqTiacIsgsBARtKCo+iHmTCsdK6
         s8xNc1E6fEPoFcnfMiMEQKhsAVW2EiHGRPnLd5B97pvB2FaKmWsstoHXH1cSloG1Ejuz
         WLPrEGyJd8e76Jgy00736GCm7KAaxNVS/ZBPjtwljkBcWX9Vf5YnlnzpbaDL8l2wCNiJ
         5Yqk8nc+3Cu/abLZB8cGCpVX/ulJ/pkn+36EIPuzmLSmo+RG4eBbETLGyFkdIuusMf1Z
         UbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695780740; x=1696385540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uXbAnfG7Klg4kxQCKSM3U/vizxaMvqOmTFPhEn3fCg=;
        b=dW+V+MD5xe2goMHARWDQJS0dCP1zgLCRmuhK4bI/cBw4JI8BrqhCZ9rpHbOMUzROb7
         XoPNO7eyCd455B2K/v9fQHkk/ZBhXlUesrIMLSLl09PHxgFwvVTSOLSfT7Kb2y6NEO7N
         +VtFJ3HL2hFo+SzlsDsMdVCg3YA9yAqpnFEY9ckyyTyY7dMpEvRQpLiwkL0Y3e1Dnnow
         If5qN+fXRWxlzdDly2Sdo7j+Aj93YQhiq27DHSttv+qkuI5cK1BWzHJ257A3PjD5Tn/7
         xT8ARcaBVblTcUkUhwnZAOfw2jDKzQa5phIcoUl5ciyfV8RnHWHBNy6VUR8iyr1BkqS8
         M/8w==
X-Gm-Message-State: AOJu0YyZ661QMrY7zTFh64Eq0jHzQ+tAbI9FkGT6O9zJGlykGZByuqVA
	qo6jZzYJKvjfx162wowYIShrfWEKysLMmjRhLR8=
X-Google-Smtp-Source: AGHT+IGyQIHfAhgclJO/17JrgQOEM2oGPf846LeUru/bBleD4NzeTJVf1yEpG6BurGDqVHAG76f0Nc5P0gVDvhWzsWo=
X-Received: by 2002:a05:6870:fb9f:b0:1c8:baa5:a50f with SMTP id
 kv31-20020a056870fb9f00b001c8baa5a50fmr968338oab.27.1695780739865; Tue, 26
 Sep 2023 19:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925025722.46580-1-hengqi.chen@gmail.com> <ZRFCd6sY5bp29JRB@krava>
In-Reply-To: <ZRFCd6sY5bp29JRB@krava>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 27 Sep 2023 10:12:08 +0800
Message-ID: <CAEyhmHRsXJahntBtB2NjRy3pWYHy8ap3ui_UdtO1TFeo-FnwWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Allow Golang symbols in uprobe secdef
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 4:19=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Sep 25, 2023 at 02:57:22AM +0000, Hengqi Chen wrote:
> > Golang symbols in ELF files are different from C/C++
> > which contains special characters like '*', '(' and ')'.
> > With generics, things get more complicated, there are
> > symbols like:
> >
> >   github.com/cilium/ebpf/internal.(*Deque[go.shape.interface {
> >    Format(fmt.State, int32); TypeName() string;
> >   github.com/cilium/ebpf/btf.copy() github.com/cilium/ebpf/btf.Type
> >   }]).Grow
> >
> > Add " ()*,-/;[]{}" (in alphabetical order) to support matching
> > against such symbols. Note that ']' and '-' should be the first
> > and last characters in the %m range as sscanf required.
> >
> > A working example can be found at this repo ([0]).
> >
> >   [0]: https://github.com/chenhengqi/libbpf-go-symbols
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index b4758e54a815..de0e068195ab 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -11630,7 +11630,7 @@ static int attach_uprobe(const struct bpf_progr=
am *prog, long cookie, struct bpf
> >
> >       *link =3D NULL;
> >
> > -     n =3D sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.@]+%li"=
,
> > +     n =3D sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[]a-zA-Z0-9 ()*,./;=
@[_{}-]+%li",
> >                  &probe_type, &binary_path, &func_name, &offset);
>
> could you please make that work for uprobe.multi (attach_uprobe_multi)
> as well?
>

I haven't used uprobe.multi before, let me try.

> it uses %ms at the moment and it seems it won't get pass the space
> in the symbol name
>
> thanks,
> jirka
>
> >       switch (n) {
> >       case 1:
> > --
> > 2.34.1
> >
> >

