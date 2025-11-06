Return-Path: <bpf+bounces-73771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA29C38D4D
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 03:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAD4F4E4848
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 02:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBD123183A;
	Thu,  6 Nov 2025 02:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NayA01pH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C247322ACEF
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 02:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395257; cv=none; b=oqN1u/vI8VYJKtfdzuvAZ6u2EaJEWO3D00GA2PMeU0vtLfFmIidInVq2jP7l78vp4F4VIyeTFWIlP9E9ndTUx7Q8ol10+1zv9b6Mqy1JT0LU3M+KOqDkmvoYNkjwu/vPZ8U9EMoz1iCZe3w/RWD/i7e8uD8565Vb56H5NykrKKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395257; c=relaxed/simple;
	bh=vZP6Olr5BkV89fHbnFl2sWgdkU0Nu6NEN5nDJ+HXmt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tywrziJ4ZGrh/N8wtxTz64YMeyfWLKUzOssDcmaklxdM2r5Fu1URiK2lxl+YmCGQTQwpsLYUS0f1ZcxKuU8Cy3ja+q4XogWSd0xwjF9btV3vEGMCg4M6q4k+W6FIAPMSt9cmsM481mIpqF1AQ2TR5Xz+xvNxFtixkxoWexQNgs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NayA01pH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477563bcaacso3052325e9.1
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 18:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762395253; x=1763000053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pID6uUnnVVZ9vUknZjr7R/tHvBIqPxx/hilxjQ4G/4I=;
        b=NayA01pH7J4QAApvV6oY6JB9WF6zyrc7iVR/2oNn9ntLYTClVYcxFDZqneiLVuoy6t
         pe3+Ws2RO7Tej5S8Ulx3RaMx8N2E2KO1odP4b5A929XWZNqrWbtix44axXqAIb6gPFkx
         GlpFkNg0KsxsITlLCUtmQPoy8skXOh0PnXpYK8pcmGsNckYAp/JhiRyYX6FGoV38FsRg
         3q4xJ+VkUxESZj26RO8rCVai7geBECTyJsEt0fF3jisSwvvWbqBI+RXyHSazb0EvuRix
         JYKuzNgjhJkkvxkSr1n4QZIxcPw9TpF0mnWfRZTtxwfGSoEfFm9V1ubNoe0iZN5CSk3J
         TpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762395253; x=1763000053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pID6uUnnVVZ9vUknZjr7R/tHvBIqPxx/hilxjQ4G/4I=;
        b=KhUy2y6qvZK2V9l1HqUk7fAVvIJRihwiGFjGjvsMk2jTYPeDHS/Z1eB20BkRF2Anz2
         +Y0hMzVomESg/1bLvM8mn0zg/Tgyx8xwqX0a3S60yffTr0Tj/MIhG1PFeWwAAp3vONPH
         DwMwGKoGfQugqfVBcU60VqKVY5ikMQ9zGHynKHTaNGdKUmg4aNGw9ddxQxi0FC7nia7i
         9Ecmgs4Z0cxPFidvKXx5i2xK652RnuaqZrIXXQyxJcQXBmW+tBoa7glZoZKSutbdCwdB
         JNO9p/mSMO/Rr8mneFWGskekwu6wXuheDJ7Fhkh6Bpgzt3UsVfQBOOb8v13YkHlErF7q
         a72g==
X-Forwarded-Encrypted: i=1; AJvYcCWR4NmT5Xhk1pzCX6cDVCswTRUYg7mcCpFgHO52+zE/ZumH1lSvy738aLNJ+9LXNxKRpcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbAoUJ7TAwbTXdjAaLEGoFKeG8vJVFUcL1nopjV71oS5ln/7zq
	JIV2H4jaCgVnixOap9dgphS+LZC/cN+GfZdKICMvJ4CdPeV4Ah5iVFU4WzcMALJtBQn01SFF5j3
	AkO4TWagKgJoPFA5eswWHHk1M3BQDdbE=
X-Gm-Gg: ASbGncuX/1JuKgb4m7HiSqfPONyG7c0ACasvUTLDD+xRKcYpR9BcZydHBDy8665eCNJ
	uTF6XcrP96EWczOqiPAiVh8xhPd265sN4QNaaB68eFOXtGZrq1xfuvUwKxNKvWYutJoKgRfr+K2
	yybf7RK1N4Aitzl2TT145bMVMN4B6Be5U+ixFoYIz0f1/qIboXXVNVEFkx/nTSjT0g/p/7m83W8
	3zerDUbgDvvGPExahJ+mraRNQyTQ5h5uZT63xKBYY8gJW/aRgxZyd9g5JOfzRDUuowi2Fv5wmKB
	yCCRPwe5l8m6SWAEIU3Qm9ObtOqy
X-Google-Smtp-Source: AGHT+IHNnfInoqONg+HdDsdA3ANtxnE3sVDgNmGAhLj4s+3clgxi2RV1/L4viLoDYukFGUUERUQj1xR+74oc6GYdLj4=
X-Received: by 2002:a05:600c:621b:b0:477:fad:acd9 with SMTP id
 5b1f17b1804b1-4775ce7dfcfmr67517835e9.34.1762395252988; Wed, 05 Nov 2025
 18:14:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101193357.111186-1-harshit.m.mogalapalli@oracle.com>
 <20251101193357.111186-2-harshit.m.mogalapalli@oracle.com>
 <CAADnVQLe6a8Kae892sVaND-2p1DQDXGD5gqxHWHHUC85ntLCqw@mail.gmail.com>
 <e9d43dab-cfae-48a8-9039-e050ea392797@kernel.org> <CAADnVQKzSBZYaj0iMkNBk6FvaOket1mWPksX661zwC2rg2FBkQ@mail.gmail.com>
 <7874cfab-3f96-4cfb-9e52-b9d8108bc536@kernel.org>
In-Reply-To: <7874cfab-3f96-4cfb-9e52-b9d8108bc536@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 18:14:02 -0800
X-Gm-Features: AWmQ_bkDFU4rnwNyySArAEKJqcvgmyxv0uWO4gd3WyExlNwj1KcULnAVkj1_8jg
Message-ID: <CAADnVQL7cLYPKEQOLWi1DjTZjhE_Fy4zWLrWG+=NSeN821SyMw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpftool: Print map ID upon creation and support
 JSON output
To: Quentin Monnet <qmo@kernel.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, bpf <bpf@vger.kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 6:05=E2=80=AFPM Quentin Monnet <qmo@kernel.org> wrot=
e:
>
> 2025-11-05 17:29 UTC-0800 ~ Alexei Starovoitov
> <alexei.starovoitov@gmail.com>
> > On Wed, Nov 5, 2025 at 1:38=E2=80=AFAM Quentin Monnet <qmo@kernel.org> =
wrote:
> >>
> >> 2025-11-04 09:54 UTC-0800 ~ Alexei Starovoitov
> >> <alexei.starovoitov@gmail.com>
> >>> On Sat, Nov 1, 2025 at 12:34=E2=80=AFPM Harshit Mogalapalli
> >>> <harshit.m.mogalapalli@oracle.com> wrote:
> >>>>
> >>>> It is useful to print map ID on successful creation.
> >>>>
> >>>> JSON case:
> >>>> $ ./bpftool -j map create /sys/fs/bpf/test_map4 type hash key 4 valu=
e 8 entries 128 name map4
> >>>> {"id":12}
> >>>>
> >>>> Generic case:
> >>>> $ ./bpftool  map create /sys/fs/bpf/test_map5 type hash key 4 value =
8 entries 128 name map5
> >>>> Map successfully created with ID: 15
> >>>>
> >>>> Bpftool Issue: https://github.com/libbpf/bpftool/issues/121
> >>>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> >>>> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> >>>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com=
>
> >>>> ---
> >>>> v2->v3: remove a line break("\n" ) in p_err statement. [Thanks Quent=
in]
> >>>> ---
> >>>>  tools/bpf/bpftool/map.c | 21 +++++++++++++++++----
> >>>>  1 file changed, 17 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> >>>> index c9de44a45778..f32ae5476d76 100644
> >>>> --- a/tools/bpf/bpftool/map.c
> >>>> +++ b/tools/bpf/bpftool/map.c
> >>>> @@ -1251,6 +1251,8 @@ static int do_create(int argc, char **argv)
> >>>>         LIBBPF_OPTS(bpf_map_create_opts, attr);
> >>>>         enum bpf_map_type map_type =3D BPF_MAP_TYPE_UNSPEC;
> >>>>         __u32 key_size =3D 0, value_size =3D 0, max_entries =3D 0;
> >>>> +       struct bpf_map_info map_info =3D {};
> >>>> +       __u32 map_info_len =3D sizeof(map_info);
> >>>>         const char *map_name =3D NULL;
> >>>>         const char *pinfile;
> >>>>         int err =3D -1, fd;
> >>>> @@ -1353,13 +1355,24 @@ static int do_create(int argc, char **argv)
> >>>>         }
> >>>>
> >>>>         err =3D do_pin_fd(fd, pinfile);
> >>>> -       close(fd);
> >>>>         if (err)
> >>>> -               goto exit;
> >>>> +               goto close_fd;
> >>>>
> >>>> -       if (json_output)
> >>>> -               jsonw_null(json_wtr);
> >>>> +       err =3D bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len)=
;
> >>>> +       if (err) {
> >>>> +               p_err("Failed to fetch map info: %s", strerror(errno=
));
> >>>> +               goto close_fd;
> >>>> +       }
> >>>>
> >>>> +       if (json_output) {
> >>>> +               jsonw_start_object(json_wtr);
> >>>> +               jsonw_int_field(json_wtr, "id", map_info.id);
> >>>> +               jsonw_end_object(json_wtr);
> >>>> +       } else {
> >>>> +               printf("Map successfully created with ID: %u\n", map=
_info.id);
> >>>> +       }
> >>>
> >>> bpftool doesn't print it today and some scripts may depend on that.
> >>
> >>
> >> Hi Alexei, are you sure we can't add any input at all? I'm concerned
> >> that users won't ever find the IDs for created maps they might want to
> >> use, if they never see it in the plain output.
> >>
> >>
> >>> Let's drop this 'printf'. Json can do it unconditionally, since
> >>> json parsing scripts should filter things they care about.
> >>
> >> I'd say the risk is the same. Scripts should filter things, but in
> >> practise they might just as well be comparing to "null" today, given
> >> that we didn't have any other output for the command so far. Conversel=
y,
> >> what scripts should not do is rely on plain output, we've always
> >> recommended using bpftool's JSON for automation (or the exit code, in
> >> the case of map creation). So I'm not convinced it's justified to
> >> introduce a difference between plain and JSON in the current case.
> >
> > tbh the "map create" feature suppose to create and pin and if both
> > are successful then the map will be there and bpftool will
> > exit with success.
> > Now you're arguing that there could be a race with another
> > bpftool/something that pins a different map in the same location
> > and success of bpftool doesn't mean that exact that map is there.
> > Other tool could have unpinned/deleted map, pinned another one, etc.
> > Sure, such races are possible, but returning map id still
> > looks pointless. It doesn't solve any race.
> > So the whole 'lets print id' doesn't quite make sense to me.
>
> OK "solving races" is not accurate, but returning the ID gives a unique
> handle to work with the map, if a user runs a follow-up invocation to
> update entries using the ID they can be sure they're working with the
> same map - whatever happened with the bpffs. Or they can have the update
> fail if you really want that particular map but, for example, it's been
> recreated in the meantime. At the moment there's no way to uniquely
> identify the map we've created with bpftool, and that seems weird to me.

ID is not unique. If somebody rm -rf bpffs. That ID will not point anywhere=
.
Also it's 31-bit space and folks in the past demonstrated an attack
to recycle the same ID.
So the users cannot be sure what ID is this.

