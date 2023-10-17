Return-Path: <bpf+bounces-12474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEEC7CCBCB
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 21:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE831C20C6A
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 19:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA57A2EAF2;
	Tue, 17 Oct 2023 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtepnVV/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4942EAEB
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 19:08:33 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAD990
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 12:08:32 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40651a72807so56160505e9.1
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 12:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697569711; x=1698174511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUrM/usGu4HOCVcsQ2mLRiy1RX8lnnPjKL1N16nu/qY=;
        b=MtepnVV/algEP+Xi/IIkXrTFCJ5SyGTOXyiCNEpsL88jlWCaiM7b65tQR21FGTx8GR
         EjnrcbaTxwBy/uBMo+Qn0ZFpsc3hAY1EqOMXNacgVvoTZYGQcxg2S/Czm522PAfCHopi
         1e7qnTePWa+PE0gQms+kJd51z3kgY77S0S2Us+SInEkoIT2vZi6qPobQC3Ji/uvk+bAr
         DECZVwOyE4GIOODaN0h6qkESZQjZQ1FQeSVaikRWHyrS1FyqsdF7DAirUuHQLT45h4Zm
         YAy6se/1Cy8SL/K20atF2q426RYo7Xwe9w5q/l5yXU0DXzi2Mzvx/XQoB3TU+x2jOhl1
         wdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569711; x=1698174511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUrM/usGu4HOCVcsQ2mLRiy1RX8lnnPjKL1N16nu/qY=;
        b=RZDVuWpvjbd4fHobS8+F20WARwkkAnR+IHh4Wr0evkNDtAY466O2yKI7oeVsaQ4pNd
         eXuGz9zGgHlz7opXoX6j0ZxakZj/73w41HNWVad3WAOWciKhN+Q78Tu0PdISzmAaWqD4
         cMTCHKzJ7R0k68ib7stDvgYBlON5cvTD2to2Oc2e4zQ3sJbIkFYdKbe+Q1qAGlrubGm6
         rTZvDq/UjrDQITMl6JZgVrKz1Z+o2AIeVMMwDbSdpKL2Fo2+1PiUbmdjrmBFdRHtHXjV
         78vu5xKuh66obnFwSDXaNOuNhsCH4k6Pp2VI0qE6z666sgwyzAtD/tBJvhTdjK+/G+AD
         X7MA==
X-Gm-Message-State: AOJu0YzLIJ7leaVhHaNiifA0SLaF67PXzwxpnOHJA0y6rh0nl1UTg3f3
	CBlGMIV4swd5xiMTeONAlgqXgQ+vlZSUnF/6YJI=
X-Google-Smtp-Source: AGHT+IE9M3SEfRDyt0OfJhXlaNkLhtVKKI7gDp+yX9RGs1+JLKM9bAnGrCz/BwjW53iKyDGA6hHLqa3+uMhmIciVs6g=
X-Received: by 2002:a5d:6ad0:0:b0:32d:b9c5:82fc with SMTP id
 u16-20020a5d6ad0000000b0032db9c582fcmr2800191wrw.36.1697569710521; Tue, 17
 Oct 2023 12:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231013182644.2346458-1-song@kernel.org> <20231013182644.2346458-6-song@kernel.org>
In-Reply-To: <20231013182644.2346458-6-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Oct 2023 12:08:19 -0700
Message-ID: <CAADnVQK6_RNn3Bt=BKLecNrwS4pi2JOMq-h9O5qnE6EJhpitXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: Add test that use fsverity
 and xattr to sign a file
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, fsverity@lists.linux.dev, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 11:29=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> +#define MAGIC_SIZE 8
> +char digest[MAGIC_SIZE + sizeof(struct fsverity_digest) + SHA256_DIGEST_=
SIZE];
> +
> +__u32 monitored_pid;
> +char xattr_name[] =3D "user.sig";
> +char sig[MAX_SIG_SIZE];
> +__u32 sig_size;
> +__u32 user_keyring_serial;
> +
> +SEC("lsm.s/file_open")
> +int BPF_PROG(test_file_open, struct file *f)
> +{
> +       struct bpf_dynptr digest_ptr, sig_ptr, name_ptr;
> +       struct bpf_key *trusted_keyring;
> +       __u32 pid;
> +       int ret;
> +
> +       pid =3D bpf_get_current_pid_tgid() >> 32;
> +       if (pid !=3D monitored_pid)
> +               return 0;
> +
> +       /* digest_ptr points to fsverity_digest */
> +       bpf_dynptr_from_mem(digest + MAGIC_SIZE, sizeof(digest) - MAGIC_S=
IZE, 0, &digest_ptr);
> +
> +       ret =3D bpf_get_fsverity_digest(f, &digest_ptr);
> +       /* No verity, allow access */
> +       if (ret < 0)
> +               return 0;
> +
> +       /* Move digest_ptr to fsverity_formatted_digest */
> +       bpf_dynptr_from_mem(digest, sizeof(digest), 0, &digest_ptr);
> +
> +       /* Read signature from xattr */
> +       bpf_dynptr_from_mem(sig, sizeof(sig), 0, &sig_ptr);
> +       bpf_dynptr_from_mem(xattr_name, sizeof(xattr_name), 0, &name_ptr)=
;
> +       ret =3D bpf_get_file_xattr(f, &name_ptr, &sig_ptr);
> +       /* No signature, reject access */
> +       if (ret < 0)
> +               return -EPERM;
> +
> +       trusted_keyring =3D bpf_lookup_user_key(user_keyring_serial, 0);
> +       if (!trusted_keyring)
> +               return -ENOENT;
> +
> +       /* Verify signature */
> +       ret =3D bpf_verify_pkcs7_signature(&digest_ptr, &sig_ptr, trusted=
_keyring);
> +
> +       bpf_key_put(trusted_keyring);
> +       return ret;
> +}

I think the UX is cumbersome.
Putting a NULL terminated string into dynptr not only a source
code ugliness, but it adds run-time overhead too.
We better add proper C style string support in the verifier,
so that bpf_get_file_xattr() can look like normal C.

