Return-Path: <bpf+bounces-58252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C638AB7859
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 23:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0301BA5F14
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 21:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826AF223DF2;
	Wed, 14 May 2025 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J47KQUz/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDD122371B
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747259977; cv=none; b=tINlcDgZfDH4E6wIEYrrLrLvvuUmrL813Y22lDLexWXGP2W/e0fMMtJFP23hWKK105FyqHVBZyMJnP8YMJU7qm6yWTXVCtjFcKjDF7MfOzW7hsQkceqLcn9A7UYthTR16IUsRxpXSvH/VLGiEc5UL9HVU5XnvYhOytHms+JgTy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747259977; c=relaxed/simple;
	bh=SJjJynQia8GvK0U0lmMdZeH3vMiN4uYyFlk9oMLngdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rib6XBKprBJH9ZwQYjUYzDAWVFuIpHqAJZA/gaAPnS86AuSFMumgfjFsrDU0IZztlQQias3ZxsUkrt0qDlp16n3YAfgxzpNe3kIQbI4QTlzWmiUzESzDpWoGUHPovJBCBX7XEGFoxXVWk8GHqdKLr1oBbPPnjemASURQXqiuULw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J47KQUz/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d5f10e1aaso22255e9.0
        for <bpf@vger.kernel.org>; Wed, 14 May 2025 14:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747259973; x=1747864773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlmeeTfLkq8aEMSuw0FxNnLKvZlTgNOBO6GA5zAYi+M=;
        b=J47KQUz/JvbYxv3LgKEtPrh8N4HcWVpDiARUurLr522K31x/skQ82M4jJxp4XYgJvx
         Fn/KvTX7c7H1+x9c1LHfPKncDC5/D9nmTGOs/Q/K+O/NK1b6XqU+EY9GS0FYGHn74c/0
         84BQquTQ7nCnJ2b+yiuE2GQxOZ9YxQ95osqz6qIopH3U3Hr0vgcHOaW/IsiHTVS7ByNX
         9nqrEsHdZ3G0FwNRQtHJjvMDp/lkpUedwaTmH3FN/l9P3FvJ7U+kp5JH0aoSQ4E30aMK
         0F4kkz9D+NIFBjWwBZpwHt6aX4xV5rtFrpR5T/cPWfE/ces0NJ61WqOoQgoh103ogc8O
         NIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747259973; x=1747864773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlmeeTfLkq8aEMSuw0FxNnLKvZlTgNOBO6GA5zAYi+M=;
        b=ahSq02D82rTpI4NAqEvfroBwxvjVjFYE/8U3XsKnEsxmEu7RZT+CV3nu8j6zczd0y2
         JoZeumBxB/yMol+blqBLmG38lynLDemtJzZwYdUjEoTU7d60IxoBqKr8RxcjODzCvnhn
         qehq64cXJp5o7q6LCnBZ9QpBRjZANafj8SubE5LVxF8h+bOYaxJtnuSoiqEXqPZ0Rwat
         DekTofdubysdgF8ocnEJD0+pfJw7S/7qaCpbv6+g+4Fbexo5o1kNi8CFN6+FuBKzvsic
         Sdu4sv4fJleq1aJUb8L5dNWKBe9uuB/H9ibF2iSQsJwsrpdjgDmgS7P6wkHtjWqRDaQN
         AJbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgZQ+oHTH5TVTDMDR0mpV81f/oxz6cIdkgdty9x9UEdZaXtiOE/myIhRUyyN55IxkCgYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC9kr/RrQR+WQ/TL9lIfrNIsqsgs+6ktK05Rz/lL9+1+96iu+9
	HjMU0ZzUB19lhr9bnMlZZDt3QntUGzjSJT6xBMlQMqErBYKHR3q5BWeowupDBQj8aupCDSiYrUO
	t64YuZ7p0p/utr6wKt09lSmnugDPad8OKoGaBh0Io
X-Gm-Gg: ASbGncvniJJDHhnqVahYdOt/lXmM205PaGlALgvR/7AJX/gOLpufJdic46EeatDBhTv
	kzVGyclPrUNfni1adGtWbWg2/5piiUe/n4ulqkx2GfzdmvWRsD9CIaB5AmSVfq9+lAiwMRIZkRN
	VAlyGpQisea/RV076OkJqhs0PreN7FhNPds1FpXASf8JrEycaaqdPqMTj2CDfWj1I=
X-Google-Smtp-Source: AGHT+IGZFtWR6kaa3m5TftPx8Xk4j/uPH4VRUM2tBcUfEbplvxpzfZrRREM/wd4w9XuTIGx4myNdq/Z7Y6ry3xbYHkg=
X-Received: by 2002:a05:600c:4f43:b0:439:8d84:32ff with SMTP id
 5b1f17b1804b1-442f94eb5a7mr91875e9.3.1747259973405; Wed, 14 May 2025 14:59:33
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513163601.812317-1-tjmercier@google.com> <20250513163601.812317-6-tjmercier@google.com>
 <CAPhsuW50mA3hhirHBiZ2miBeC0uAN=KxyYKBJ_hHgmFx-cvaNw@mail.gmail.com>
In-Reply-To: <CAPhsuW50mA3hhirHBiZ2miBeC0uAN=KxyYKBJ_hHgmFx-cvaNw@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 14 May 2025 14:59:21 -0700
X-Gm-Features: AX0GCFuiegK4tHyclG5bzgCNPpj8LN37JRrILy438Zw7YZxZPwu1YJY1Fclo4i0
Message-ID: <CABdmKX1nxw6=JVfT8wEgsJB692LbaYWrpL-CN=KPQi7K_cKPSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 5/5] selftests/bpf: Add test for open coded dmabuf_iter
To: Song Liu <song@kernel.org>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, alexei.starovoitov@gmail.com, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 2:00=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Tue, May 13, 2025 at 9:36=E2=80=AFAM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > Use the same test buffers as the traditional iterator and a new BPF map
> > to verify the test buffers can be found with the open coded dmabuf
> > iterator.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Acked-by: Song Liu <song@kernel.org>
> > ---
> >  .../testing/selftests/bpf/bpf_experimental.h  |  5 +++
> >  .../selftests/bpf/prog_tests/dmabuf_iter.c    | 41 +++++++++++++++++++
> >  .../testing/selftests/bpf/progs/dmabuf_iter.c | 38 +++++++++++++++++
> >  3 files changed, 84 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/tes=
ting/selftests/bpf/bpf_experimental.h
> > index 6535c8ae3c46..5e512a1d09d1 100644
> > --- a/tools/testing/selftests/bpf/bpf_experimental.h
> > +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> > @@ -591,4 +591,9 @@ extern int bpf_iter_kmem_cache_new(struct bpf_iter_=
kmem_cache *it) __weak __ksym
> >  extern struct kmem_cache *bpf_iter_kmem_cache_next(struct bpf_iter_kme=
m_cache *it) __weak __ksym;
> >  extern void bpf_iter_kmem_cache_destroy(struct bpf_iter_kmem_cache *it=
) __weak __ksym;
> >
> > +struct bpf_iter_dmabuf;
> > +extern int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it) __weak __ks=
ym;
> > +extern struct dma_buf *bpf_iter_dmabuf_next(struct bpf_iter_dmabuf *it=
) __weak __ksym;
> > +extern void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it) __weak=
 __ksym;
> > +
> >  #endif
> > diff --git a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c b/too=
ls/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> > index dc740bd0e2bd..6c2b0c3dbcd8 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> > @@ -219,14 +219,52 @@ static void subtest_dmabuf_iter_check_default_ite=
r(struct dmabuf_iter *skel)
> >         close(iter_fd);
> >  }
> >
> > +static void subtest_dmabuf_iter_check_open_coded(struct dmabuf_iter *s=
kel, int map_fd)
> > +{
> > +       LIBBPF_OPTS(bpf_test_run_opts, topts);
> > +       char key[DMA_BUF_NAME_LEN];
> > +       int err, fd;
> > +       bool found;
> > +
> > +       /* No need to attach it, just run it directly */
> > +       fd =3D bpf_program__fd(skel->progs.iter_dmabuf_for_each);
> > +
> > +       err =3D bpf_prog_test_run_opts(fd, &topts);
> > +       if (!ASSERT_OK(err, "test_run_opts err"))
> > +               return;
> > +       if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
> > +               return;
> > +
> > +       if (!ASSERT_OK(bpf_map_get_next_key(map_fd, NULL, key), "get ne=
xt key"))
> > +               return;
> > +
> > +       do {
> > +               ASSERT_OK(bpf_map_lookup_elem(map_fd, key, &found), "lo=
okup");
> > +               ASSERT_TRUE(found, "found test buffer");
>
> This check failed once in the CI, on s390:
>
> Error: #89/3 dmabuf_iter/open_coded
> 9309 subtest_dmabuf_iter_check_open_coded:PASS:test_run_opts err 0 nsec
> 9310 subtest_dmabuf_iter_check_open_coded:PASS:test_run_opts retval 0 nse=
c
> 9311 subtest_dmabuf_iter_check_open_coded:PASS:get next key 0 nsec
> 9312 subtest_dmabuf_iter_check_open_coded:PASS:lookup 0 nsec
> 9313 subtest_dmabuf_iter_check_open_coded:FAIL:found test buffer
> unexpected found test buffer: got FALSE
>
> But it passed in the rerun. It is probably a bit flakey. Maybe we need so=
me
> barrier somewhere.
>
> Here is the failure:
>
> https://github.com/kernel-patches/bpf/actions/runs/15002058808/job/422348=
64754
>
> To see the log, you need to log in GitHub.
>
> Thanks,
> Song

Thanks, yeah I have been trying to run this locally today but still
working on setting up an environment for it. Daniel Xu thoughtfully
suggested I use a github PR to trigger CI, but I tried that last week
without success: https://github.com/kernel-patches/bpf/pull/8910

I'm not sure if this is the cause (doesn't show up on the runs that
pass) but I have no idea why that would be intermittently failing:
libbpf: Error in bpf_create_map_xattr(testbuf_hash): -EINVAL. Retrying
without BTF.





> > +       } while (bpf_map_get_next_key(map_fd, key, key));
> > +}
>
> [...]

