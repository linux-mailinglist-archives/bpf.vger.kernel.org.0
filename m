Return-Path: <bpf+bounces-6473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA8576A222
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 22:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA603281694
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 20:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0F81DDE3;
	Mon, 31 Jul 2023 20:47:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9597618C26
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 20:47:16 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8DCE46
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 13:47:14 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so35125481fa.1
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 13:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690836433; x=1691441233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5UrgQQomhk5V5SW91S9tcKgWdLw/7WYOeVpPIDktIY=;
        b=eCzkSoNz/hqqM0dCvxaZt7oZqu3xAbsAj9Hmyg3UFKuBpQwlWfcReUR6Q5W9ktPufR
         auKXDQDGk9j/hIiA14CwZPnut6Jj1vY/+RnmTnhngEq2rK11mSjOf0mPfjz58F5Cz0uC
         7q9VV61yI5CdfbvIWhotfC7/C3WOnRTLTh5QcD6qCT8OSSMjFjXaA4tLy6MFulGpB9EO
         Enoj7utAiC/X0KwuGOJ7mhjgurT9iSiv955h23SV5Ap9/F8bxWg6Wyz8N8O+JkgYd/DM
         n47CQfP2/J6rZQCb9ZIbZ1/zAL7ryAMGGMJyHLwSwGaao9XzDhmpealqoMbvR9FTtmSG
         aS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690836433; x=1691441233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5UrgQQomhk5V5SW91S9tcKgWdLw/7WYOeVpPIDktIY=;
        b=L5nbdo+T99NfrsMXyX38Mii31z+m09sbtLT4Z2+E09kbCXfDMfgbfCrcMTG7hueSlb
         lgU7Ax09UKeO2qWQvgfp2nA3k2G92mrwsdCBDkMPzJtNQTJGbWUD0GFUDvov8WRkcj4y
         wKAM+ZYG3tDMS0ImNQ+nDdj6eT5XI3nfQa6403f4/Iz1SchyXZw6+TxJEJDAyS9ceFMj
         tvLGeQODOgD2SzhjMkAi4qsUbQV+JRqniv4lj6phaKUVrE8dJUjq6IMWoSss4FfIRefm
         ooaAH4uQfvrhr0P82G+4TNOUUK9fm2s1DMje9xOIXFQv86L5AL4z26DdHWCTfBDqby5t
         6aFQ==
X-Gm-Message-State: ABy/qLZyStIU/Xr/v0SXzSFOfoo35fdudTgFZWqFrEkl0WLWIYsfa9aM
	dqjvfnzj2btvcm4pYfnagZfpBBMmIHXQkVxUK34=
X-Google-Smtp-Source: APBJJlF9grmZ0cCTlzCEm3+5CARtXQmkhnSbhh3+pql/T978W2aFiRQ8nYIdk/vxlt37w5UzB7FlDMfiMCpfx/VcIQ8=
X-Received: by 2002:a2e:8796:0:b0:2b7:3b6c:a5e4 with SMTP id
 n22-20020a2e8796000000b002b73b6ca5e4mr862401lji.38.1690836432461; Mon, 31 Jul
 2023 13:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d1360219-85c3-4a03-9449-253ea905f9d1@moroto.mountain>
In-Reply-To: <d1360219-85c3-4a03-9449-253ea905f9d1@moroto.mountain>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 31 Jul 2023 13:47:01 -0700
Message-ID: <CAADnVQJjRy75vy3KSm7hbyBq=1Urfz4eVKiigPHr78nuxz-CBA@mail.gmail.com>
Subject: Re: [bug report] bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr
To: Dan Carpenter <dan.carpenter@linaro.org>, Kui-Feng Lee <kuifeng@meta.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 12:24=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> Hello Joanne Koong,
>
> The patch 66e3a13e7c2c: "bpf: Add bpf_dynptr_slice and
> bpf_dynptr_slice_rdwr" from Mar 1, 2023 (linux-next), leads to the
> following Smatch static checker warning:
>
>         tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c:403 =
forward_with_gre()
>         error: 'encap_gre' dereferencing possible ERR_PTR()
>
> tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
>     396
>     397         encap_gre =3D bpf_dynptr_slice_rdwr(dynptr, 0, encap_buff=
er, sizeof(encap_buffer));
>     398         if (!encap_gre) {
>     399                 metrics->errors_total_encap_buffer_too_small++;
>     400                 return TC_ACT_SHOT;
>     401         }
>     402
> --> 403         encap_gre->ip.protocol =3D IPPROTO_GRE;
>                 ^^^^^^^^^^^
>
> The bpf_dynptr_slice() function accidentally propagates error pointers
> from bpf_xdp_pointer() so it would crash here.

Good catch.

Kui-Feng, could you please send a fix?

Probably the following will be enough:
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 56ce5008aedd..eb91cae0612a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2270,7 +2270,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct
bpf_dynptr_kern *ptr, u32 offset
        case BPF_DYNPTR_TYPE_XDP:
        {
                void *xdp_ptr =3D bpf_xdp_pointer(ptr->data, ptr->offset
+ offset, len);
-               if (xdp_ptr)
+               if (!IS_ERR_OR_NULL(xdp_ptr))
                        return xdp_ptr;

Also I've noticed:
void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
                      void *buf, unsigned long len, bool flush);
#else /* CONFIG_NET */
static inline void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 l=
en)
{
        return NULL;
}

The latter is wrong.
Please send a separate fix.

