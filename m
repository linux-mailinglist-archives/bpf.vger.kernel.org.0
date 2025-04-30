Return-Path: <bpf+bounces-57036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C61B7AA4919
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 12:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A26387A3E1F
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 10:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B50235348;
	Wed, 30 Apr 2025 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RekcL09B"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E241B5EB5
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746010042; cv=none; b=WrgIdagYZFUxQPTAMrsrhfOKzKHRcVCMvpCxjaX2k7BVd8Ts3BoLO9laWd8xeTZI3ZMeBOOtdk60+x3cWNbubmyuaeSNbSI1JU1J1sDRIjSY/rmdTDRXoTv2fxcQFa/c2q0JB3CjRSlrMfAoiDY27mFfJXEIZaVD5ZP24il8d2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746010042; c=relaxed/simple;
	bh=R6qQ62Z8xlTyopXwXahv9z9FtUyLDe0of54tPFyN/vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkc8J28OkH4mtrzpVHJXQL+D8fTPUnm8i2i5zCF3l97Sic5lDwtfu4u0XEEnPXOkYgkbhW7OzmVeihaRpXbO19y+9DS1koWfyg1o5YGtE+7siVEMf+WVbvMEW2rdxmnb7cGzU9zReqkUYCVpNpyTxGNUHrDyGVDaKJfqkYjVE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RekcL09B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746010039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWnivOs9W4+XLyEImwujBJd1shwdicbALn9+s1Jc+yg=;
	b=RekcL09BJB5ldj8D/V1cU+Dj6HOUBqi3Y17l3bT1StDz2SGw8e+CvW+0IJdCESvfNcOuBw
	DQRzpZIy4CCRuyTtFNODdiSTVfYPJf6lbH3EmjiYHDfwwvgIzAmd7jtdonu2pSYaBGRtQD
	BFxVpwZVlqFjDskXuvOclDgbNzuQV/I=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-YzQ4-YTYNxOTjIC-ZFKAlw-1; Wed, 30 Apr 2025 06:47:18 -0400
X-MC-Unique: YzQ4-YTYNxOTjIC-ZFKAlw-1
X-Mimecast-MFC-AGG-ID: YzQ4-YTYNxOTjIC-ZFKAlw_1746010037
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff7cf599beso6558263a91.0
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 03:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746010037; x=1746614837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWnivOs9W4+XLyEImwujBJd1shwdicbALn9+s1Jc+yg=;
        b=jLo5Lx4lxbHOIEBbG7WGbw/bOwrkJx2elksogPT+77eEn4KZVlWq6M4zq+V0mSXkR2
         cPPj467NlHglk8ve2yGG4H+zV0qoH3MCcEBnj+Nd4ozSnfieUsYmdUHFX4f6sCGlCSQD
         An6glRHUVMPYYzf08GCyMav4yGDXfFy/uuxb3XVDMmK5DKWX12QrXnLE34dr9KlXCVAm
         RWPUXCZPl2VecqLcpeC7n0Ct9NeYU/24GPKNeGYirFjLiCIu1HJolnx8Jcrk5sqn/aKs
         Y8T34EFxNg7J+x9YSP5Y6CE41c3IQtPMnzhp2VkCzsgmYwdehnsd4GLxV14w+fskm6c3
         F04Q==
X-Gm-Message-State: AOJu0YwQgliZ7hpaizVkDnVB3HklSpCYKP3M/9gLTehS6Z70wdw3sY1+
	Vmf5lvXWmZVVG2pnMDeipqR2kN+n/jZ0U0BSEzblrHI2REWqaXUQpZM3wea6wFuW4IsHNv9e1bR
	rfzw4SRcAlSYe0osg9os3AYqJcb9s1722IgDkNuzLN3I6zIpeLLXcekulbnN3XHF5FCbjS9RCJm
	UUHJP9Vudd4IXTsAIyi4XXLHjh
X-Gm-Gg: ASbGncuYIkRld7rhtFzZ1179c5c7YZ3GIFvodxZRPp5+tAtS+Ng+pAOfvT6FVt3oyGH
	lMVh5f2xBxsR0SuiIf991b6u7F++D32DfSdRxC82YSA4YfmXuZi9B/VgGWD2TV1MAYG0O/A==
X-Received: by 2002:a17:90b:1cc8:b0:30a:fe:140f with SMTP id 98e67ed59e1d1-30a3335f481mr3880096a91.28.1746010037366;
        Wed, 30 Apr 2025 03:47:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5jQrm0WkaSuZ2pViWj2b9YtpHy88CCKCiVNRceMWGHYFLhtTmS/1fHotBLW4tYXZnPDikg1DTTIqp4/y5PJk=
X-Received: by 2002:a17:90b:1cc8:b0:30a:fe:140f with SMTP id
 98e67ed59e1d1-30a3335f481mr3880048a91.28.1746010036979; Wed, 30 Apr 2025
 03:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429041214.13291-1-piliu@redhat.com> <20250429041214.13291-5-piliu@redhat.com>
 <CAADnVQKTSubuisSBap_J=tgO15fCdtwF-NDY_1HLP_m6o28mhw@mail.gmail.com>
In-Reply-To: <CAADnVQKTSubuisSBap_J=tgO15fCdtwF-NDY_1HLP_m6o28mhw@mail.gmail.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Wed, 30 Apr 2025 18:47:05 +0800
X-Gm-Features: ATxdqUHf-cFpaHNGaQnpHjY7Ol3gt6Pz5b1rkhWQt0CgtYPAvEmCJ_bnsVUsKMQ
Message-ID: <CAF+s44QM55AtGyquKvj0XAzZAjOii7VJYWsGD50iK3+r6GZSmg@mail.gmail.com>
Subject: Re: [RFCv2 4/7] bpf/kexec: Introduce three bpf kfunc for kexec
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kexec@lists.infradead.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Philipp Rudo <prudo@redhat.com>, Viktor Malik <vmalik@redhat.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 8:04=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 28, 2025 at 9:13=E2=80=AFPM Pingfan Liu <piliu@redhat.com> wr=
ote:
>  +__bpf_kfunc struct mem_range_result *bpf_kexec_decompress(char
> *image_gz_payload, int image_gz_sz,
> > +                       unsigned int expected_decompressed_sz)
> > +{
> > +       decompress_fn decompressor;
> > +       //todo, use flush to cap the memory size used by decompression
> > +       long (*flush)(void*, unsigned long) =3D NULL;
> > +       struct mem_range_result *range;
> > +       const char *name;
> > +       void *output_buf;
> > +       char *input_buf;
> > +       int ret;
> > +
> > +       range =3D kmalloc(sizeof(struct mem_range_result), GFP_KERNEL);
> > +       if (!range) {
> > +               pr_err("fail to allocate mem_range_result\n");
> > +               return NULL;
> > +       }
> > +       refcount_set(&range->usage, 1);
> > +
> > +       input_buf =3D vmalloc(image_gz_sz);
> > +       if (!input_buf) {
> > +               pr_err("fail to allocate input buffer\n");
> > +               kfree(range);
> > +               return NULL;
> > +       }
> > +
> > +       ret =3D copy_from_kernel_nofault(input_buf, image_gz_payload, i=
mage_gz_sz);
> > +       if (ret < 0) {
> > +               pr_err("Error when copying from 0x%px, size:0x%x\n",
> > +                               image_gz_payload, image_gz_sz);
> > +               kfree(range);
> > +               vfree(input_buf);
> > +               return NULL;
> > +       }
> > +
> > +       output_buf =3D vmalloc(expected_decompressed_sz);
> > +       if (!output_buf) {
> > +               pr_err("fail to allocate output buffer\n");
> > +               kfree(range);
> > +               vfree(input_buf);
> > +               return NULL;
> > +       }
> > +
> > +       decompressor =3D decompress_method(input_buf, image_gz_sz, &nam=
e);
> > +       if (!decompressor) {
> > +               pr_err("Can not find decompress method\n");
> > +               kfree(range);
> > +               vfree(input_buf);
> > +               vfree(output_buf);
> > +               return NULL;
> > +       }
> > +       //to do, use flush
> > +       ret =3D decompressor(image_gz_payload, image_gz_sz, NULL, NULL,
> > +                               output_buf, NULL, NULL);
> > +
> > +       /* Update the range map */
> > +       if (ret =3D=3D 0) {
> > +               range->buf =3D output_buf;
> > +               range->size =3D expected_decompressed_sz;
> > +               range->status =3D 0;
> > +       } else {
> > +               pr_err("Decompress error\n");
> > +               vfree(output_buf);
> > +               kfree(range);
> > +               return NULL;
> > +       }
> > +       pr_info("%s, return range 0x%lx\n", __func__, range);
> > +       return range;
> > +}
>
> These kfuncs look like generic decompress routines.
> They're not related to kexec and probably should be in kernel/bpf/helpers=
.c
> or kernel/bpf/compression.c instead of kernel/kexec_pe_image.c.
>

Thanks for your suggestion. I originally considered using these kfuncs
only in kexec context (Later, introducing a dedicated BPF_PROG_TYPE
for kexec). They are placed under a lock so that a malice attack can
not exhaust the memory through repeatedly calling to the decompress
kfunc.

To generalize these kfunc, I think I can add some boundary control of
the memory usage to prevent such attacks.

> They also must be KF_SLEEPABLE.
> Please test your patches with all kernel debugs enabled.
> Otherwise you would have seen all these "sleeping while atomic"
> issues yourself.
>

See, I will have all these debug options for the V3 test.

Appreciate your insight.

Regards,

Pingfan


