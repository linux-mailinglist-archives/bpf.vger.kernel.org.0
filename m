Return-Path: <bpf+bounces-53923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 692D5A5E44B
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 20:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131F1189CF23
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 19:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6022571C4;
	Wed, 12 Mar 2025 19:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="FjB9Anxx"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC911D54E2
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807279; cv=none; b=NSgDNPrO73SUMktXrsT+deth9p2pQ/26dP314BZE5Jo2NbiL8skrt3y9Ne/Moqr0YgN/+37zSrIU4pdOtsQF4phv2ySTlB3PjD5lLDem2Fn1/cUFxIb/IB4G+M/R4GOve0erzjFZVhDWbk7v0eLOnJhX16EYhlzRwy1RmNqf03o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807279; c=relaxed/simple;
	bh=9jrW5yUt/slkMtqtaE3GPs+8vBtXiJqherhHTpJhCQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujQzaSl11xq94tvZZGC7w+c7hi/wrqflo281Jc92D3cngVbmHeySs/CD+VszVBJDo1weK/achi9g8M8e8N7CMlZM5Fcw/fnHcmyRhoSH/YMNOnKGPyB5BPiGO5OI7dsq1bWNOJR+VTFoChehYStxp+lN2av/iHNKbnYRAahTs0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=FjB9Anxx; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1741807276; x=1742412076; i=linux@jordanrome.com;
	bh=lwAHmVOWFVlQOCiqejU/F7HcJhPY+5kmS9WTeN39w9c=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FjB9Anxxx2ZPKC5wXVFyUrVTMatxvhqfsDV59dwgBviW7Q6LSxujGaaTqI1leoEJ
	 GTLY2dNIbIImoN4/+AnwANycbefNP7bJEqG8rWWdxdQqZl2wbMxaBmxaAOPzsKdgE
	 wxKTo21p6NM382KZuz+wjQP53CECo0zXQRgidMn1gqLdhczGOr35x2HCUrQrKy2ov
	 WI8ZE+MVER13vhO8cZAmifmMR9cNnvAAgelxWJUbAnQYMDvF3YRfZK/HeykMxM/sR
	 OfO2MWxX9FE7YtLNg9fS2WdxqvqJh5crh+cU8Jn64JmX5JCQrZc0ptLhFbMF65tmN
	 +ocz9mSSk4UW8kxn6Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-il1-f174.google.com ([209.85.166.174]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0M8kOI-1u4Z721WZw-007pY6 for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 20:21:16
 +0100
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d46aaf36a2so1083225ab.3
        for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 12:21:16 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy3tfAiuie5UOt2S0m1DAOq8kYEKqMVbFRwcsqVzB7MjS1ZhUJi
	M+KOoGEuTiKHYinJhUfA/VIzAnA7efRlDWY7gN7dox2KPt3SjrKzXvbdP6QkdqPC6ZHfqzFfGy4
	c25uy+PO0sp+/va4ixfpJiOb+X0s=
X-Google-Smtp-Source: AGHT+IHK8mFDA77A1I7/XCNw2c2jvqo4IWiF8qXca4KD0TTItHQO7p62pOq8P3GovPkVOZgJR6SPvHmza0E1oV5fpRs=
X-Received: by 2002:a05:6e02:3f88:b0:3d1:7835:1031 with SMTP id
 e9e14a558f8ab-3d4418a5d8fmr294129145ab.7.1741807275870; Wed, 12 Mar 2025
 12:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312010358.3468811-1-linux@jordanrome.com> <CAEf4Bzb_TqinCgS92ehz8p00PQ=Z3U-8cTKBn9gfDu0Dh4EcNg@mail.gmail.com>
In-Reply-To: <CAEf4Bzb_TqinCgS92ehz8p00PQ=Z3U-8cTKBn9gfDu0Dh4EcNg@mail.gmail.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Wed, 12 Mar 2025 15:21:04 -0400
X-Gmail-Original-Message-ID: <CA+QiOd66W5hajNCCbL+07xcCBnGUuSORwfDW5XC0Ev-w5Hgk+A@mail.gmail.com>
X-Gm-Features: AQ5f1JrnNnM1gE1CbzwwtfL9hfVi9iKXpj8TJSZsMDX8_oBqR64PUI-ec7pdDdc
Message-ID: <CA+QiOd66W5hajNCCbL+07xcCBnGUuSORwfDW5XC0Ev-w5Hgk+A@mail.gmail.com>
Subject: Re: [bpf-next v4] bpf: adjust btf load error logging
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pbMBero4v4Sh4adObg/b/5r4pGJGLYDq0YNHMl9Squu7JsluUru
 qtPC6Hc5UGemx42YbTLZUti07f4yA8pBcoZRkMQoWVu3F2jpfbij0a3om8DymaFjkw8rTWi
 xYzUEx2YUH0TxvL2o25+JW3BvljrNwlRcrXm8twTxXOUDw+LM52NB6lP94UknQ7IUV9yUsv
 386YU2sOStRHJOHrpSa0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5KBWyNMzwac=;5WAvgm8ekGpEkAZDT8otxYGfzWA
 A3xstq9ouMpyV5jVVuAzlDc0P71KZvl+qGAODI/WQ1GkM3bGvA6ONS13L8IYs9LakCAhYJFIG
 aYcVRjkE6SAoYLfo6DkYdCYMiltV/odBnLGllRBhBVWPH9p4UJMqCpvIqyQ+ITUNSbbQUFKUA
 b81f4JLHdHphQjcvo50rNC0os27fccae13QVLrKZ+s3MYlJOl8Aut1XafQJQIBJzSP23kTCd9
 DZHzMmZsdks5lgw56BaVXeW3bZIrjhzzAIfV3qF2l3YehRkfHKK963goC+fM4NjPR8OvB2EMs
 2xCwUlRlGfuHQ1lEA2eoEtT7oFPc7ev9lKeoFj8/jw4GRVc0T3StIfnYUG1Rj0mPIok61TNLA
 E2p8fxc7HjrKZt/LIKOfBdXsY8nu/yfdExKX0cKtq6mzfcDcmRF5akWKMDBsZWYqVs/PgO9Sk
 86MdJioSTkG152yaiVCbl3cOf1vbYvHUWVDUN4ECKpjYJTBgIWvp3Ro+UBwpQ0Qs34J7rZqTq
 rvfoUY5HuOcpcxo2VlYtp+62C4iDrQ5Wzk8S+MiD7/xkGmM+/qiOmQvd4PxTGEg12YbaM/PgF
 tdsrmYQoTeSGvPLdG9ml/5WL6zk6zu3wbMuftBlLMJ9m0KaeX8Wzjke1D4/cN3DJlycWqCmai
 87n1ZrA7ILMau2y0lo6rm4iUvYwd5XL79fEpaHf5aAZhNWV9YALA7pu/fRNJcL/ArsQE+wZr8
 Ym+Vlx6SIdzVDPBjM9qLHT39yla7xepQ/V7hGHj01mqQj3XmsPzOsA+cUuplY1D1U5iR0mILv
 d5xfBt+S5jjMFoUsDTa8ZMvQF3B8KO8VVEIoJiEKSQV2HJzLSO2E1npYEaaSr+b5aNt+BBuD1
 eWSoOcmJLivb0/lUR9u1HvrvACjkA8CsLlR+88ZIdD5cHXHVHXS5UkahPXeH8v6yL7q95HhJR
 12/NOA3nniX7xjvTuUgDNGhap8ExMWDD0K2X08y1BI2r+KUi/2q6RPKTon9oGNCLSm9w8kLdM
 QNZSO+j7mnbxOjL8t5uXdhLhpzIJQ4o26ogxxAwwP4EKgKSynlem0sDFUMF5y6RN64aBmDJM+
 5F/CIt5hBpRByOMBzfWZjfmuPlRNjKfj56QEy3M7JMUJX0DJUV7TvTTjrCf2b5By4NmB0f+GO
 5DoyPDfcluD6c1UGjOIwq3/bR5zAB9tfuteKCeoDyyIRbbgJh70XDR+vZEsl+YvUmO45N1cnD
 O7PQAuWA+0eObxQVpthHLMyJ82Fib4b4AYG8mwx4TZrT5N/QKae2EnxpoMzLV9L7wonIiK85+
 BGWFZRIIPCKe+0jdMJoCJnoQEoKiniQrr0WPrJUOU5f1MG/CC5I083vPxNAym0Jj//dDs3BJs
 R/gYTGOjNfCCG2PA==

On Wed, Mar 12, 2025 at 2:40=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Mar 11, 2025 at 6:04=E2=80=AFPM Jordan Rome <linux@jordanrome.com=
> wrote:
> >
> > For kernels where btf is not mandatory
> > we should log loading errors with `pr_info`
> > and not retry where we increase the log level
> > as this is just added noise.
> >
> > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > ---
> >  tools/lib/bpf/btf.c             | 36 ++++++++++++++++++---------------
> >  tools/lib/bpf/libbpf.c          |  3 ++-
> >  tools/lib/bpf/libbpf_internal.h |  2 +-
> >  3 files changed, 23 insertions(+), 18 deletions(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index eea99c766a20..7da4807451bb 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -1379,9 +1379,10 @@ static void *btf_get_raw_data(const struct btf *=
btf, __u32 *size, bool swap_endi
> >
> >  int btf_load_into_kernel(struct btf *btf,
> >                          char *log_buf, size_t log_sz, __u32 log_level,
> > -                        int token_fd)
> > +                        int token_fd, bool btf_mandatory)
> >  {
> >         LIBBPF_OPTS(bpf_btf_load_opts, opts);
> > +       enum libbpf_print_level print_level;
> >         __u32 buf_sz =3D 0, raw_size;
> >         char *buf =3D NULL, *tmp;
> >         void *raw_data;
> > @@ -1435,22 +1436,25 @@ int btf_load_into_kernel(struct btf *btf,
> >
> >         btf->fd =3D bpf_btf_load(raw_data, raw_size, &opts);
> >         if (btf->fd < 0) {
> > -               /* time to turn on verbose mode and try again */
> > -               if (log_level =3D=3D 0) {
> > -                       log_level =3D 1;
> > -                       goto retry_load;
> > +               if (btf_mandatory) {
> > +                       /* time to turn on verbose mode and try again *=
/
> > +                       if (log_level =3D=3D 0) {
> > +                               log_level =3D 1;
> > +                               goto retry_load;
> > +                       }
> > +                       /* only retry if caller didn't provide custom l=
og_buf, but
> > +                        * make sure we can never overflow buf_sz
> > +                        */
> > +                       if (!log_buf && errno =3D=3D ENOSPC && buf_sz <=
=3D UINT_MAX / 2)
>
> Original behavior was to go from log_level 0 to log_level 1 when the
> user provided custom log_buf, which would happen even for
> non-btf_mandatory case. I'd like to not change that behavior.
>

I don't quite understand why we want to increase the log level
if btf is not mandatory. Users will still get an info message that
btf failed to load and if they are still curious, they can increase
the log level themselves right? The goal of this patch is to reduce
log noise in cases where btf fails to load and is not mandatory.

> Did you find some problem with the code I proposed a few emails back?

Truth be told, I didn't like the added complexity in the conditionals.
I tried something similar in an earlier version and it led to a SEGFAULT
when trying to access `buf[0]` which had not been allocated.

> If not, why not do that instead and preserve that custom log_buf and
> log_level upgrade behavior?
>
> pw-bot: cr
>
> > +                               goto retry_load;
> >                 }
> > -               /* only retry if caller didn't provide custom log_buf, =
but
> > -                * make sure we can never overflow buf_sz
> > -                */
> > -               if (!log_buf && errno =3D=3D ENOSPC && buf_sz <=3D UINT=
_MAX / 2)
> > -                       goto retry_load;
> > -
> >                 err =3D -errno;
> > -               pr_warn("BTF loading error: %s\n", errstr(err));
> > -               /* don't print out contents of custom log_buf */
> > -               if (!log_buf && buf[0])
> > -                       pr_warn("-- BEGIN BTF LOAD LOG ---\n%s\n-- END =
BTF LOAD LOG --\n", buf);
> > +               print_level =3D btf_mandatory ? LIBBPF_WARN : LIBBPF_IN=
FO;
> > +               __pr(print_level, "BTF loading error: %s\n", errstr(err=
));
> > +               if (!log_buf && log_level)
> > +                       __pr(print_level,
> > +                            "-- BEGIN BTF LOAD LOG ---\n%s\n-- END BTF=
 LOAD LOG --\n",
> > +                            buf);
> >         }
> >
> >  done:
> > @@ -1460,7 +1464,7 @@ int btf_load_into_kernel(struct btf *btf,
> >
> >  int btf__load_into_kernel(struct btf *btf)
> >  {
> > -       return btf_load_into_kernel(btf, NULL, 0, 0, 0);
> > +       return btf_load_into_kernel(btf, NULL, 0, 0, 0, true);
> >  }
> >
> >  int btf__fd(const struct btf *btf)
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 8e32286854ef..2cb3f067a12e 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -3604,9 +3604,10 @@ static int bpf_object__sanitize_and_load_btf(str=
uct bpf_object *obj)
> >                  */
> >                 btf__set_fd(kern_btf, 0);
> >         } else {
> > +               btf_mandatory =3D kernel_needs_btf(obj);
> >                 /* currently BPF_BTF_LOAD only supports log_level 1 */
> >                 err =3D btf_load_into_kernel(kern_btf, obj->log_buf, ob=
j->log_size,
> > -                                          obj->log_level ? 1 : 0, obj-=
>token_fd);
> > +                                          obj->log_level ? 1 : 0, obj-=
>token_fd, btf_mandatory);
> >         }
> >         if (sanitize) {
> >                 if (!err) {
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_int=
ernal.h
> > index de498e2dd6b0..f1de2ba462c3 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -408,7 +408,7 @@ int libbpf__load_raw_btf(const char *raw_types, siz=
e_t types_len,
> >                          int token_fd);
> >  int btf_load_into_kernel(struct btf *btf,
> >                          char *log_buf, size_t log_sz, __u32 log_level,
> > -                        int token_fd);
> > +                        int token_fd, bool btf_mandatory);
> >
> >  struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf);
> >  void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
> > --
> > 2.47.1
> >

