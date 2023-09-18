Return-Path: <bpf+bounces-10303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4018D7A4E0A
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 18:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9A9282862
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 16:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830A521356;
	Mon, 18 Sep 2023 16:05:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FF2210F9
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 16:05:07 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C9644AB
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 09:03:50 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c00e1d4c08so17040301fa.3
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 09:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695052979; x=1695657779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLVba2ehhbQq4ioWVdYGZ+oLzzTKyohQ6D5FFQAosU8=;
        b=aZ0nDAeWYrJtSU3cbG45TzyZUTESLkvyXei5MUGHUubMSBU1xH7qQPics5GLx4l7PF
         jx4HuwTzjqwUeeHKje4nTTRlo7MSO8o2snkKq4uILoJifvTxlBCXupEeCbgvVTlq/a+E
         y85SX+eBxP0W1Pv+C0+LM5mg6PgKFrFjzfLLotYD5DwbCO42fo3PO2ZPlRcuLKJ1f5CD
         2oi/PuGUl7k8zINmG89AYgaSMLG4Z2l+i3Ep9Crhss7xRoahOhahV79wgKtp2nrL1rE3
         rmJBEDFvGePLIu8jzg8RRWQddqgjh/i/XhkVe6/9QmiH8N2PfhwEl27MYCSB8WbgV122
         EnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695052979; x=1695657779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLVba2ehhbQq4ioWVdYGZ+oLzzTKyohQ6D5FFQAosU8=;
        b=pqxAaKq5D99kOj9RGKfLflgga/XPnTooXV298Uv1nHQ7gRAdS/2WLocb5mJg/5nlMl
         M9IynnMfZWIsY905HWRCnvbg2/28+WZiK5keFZODYFjFLLuJcllUc3JJ3L9pH8Ms2Aoz
         NVtAX86gr+D5+cWzz60m+B9Erp8jBtz+G2h/3DsJVqLYgHV59eyTTEi1nTHPtQI3siJU
         Hztmn1+HyTLmb561Y5QXv0lE5OoS/00vgGK7QjsTtdaySzoZAqzI7Nv3d5w6Zun/bkvZ
         t1PS/RrI8835mQYN0RwT1iCv7auzwZTcCowHT+uflVO/hkbTJb1VXlajtm39ph5XX+9F
         oQGg==
X-Gm-Message-State: AOJu0Yznc+I1Za4d6Birl8sIbs7sop/eSZQOyk2T5g56whMj1xQWEvKJ
	Tf0wrLHGOvk66V9yG0I2plPyY30rfW9ypl1Ii9l6NkHz038=
X-Google-Smtp-Source: AGHT+IEzL3HKdjX9k+RDyFemAVduCRRD6kGG9jB0DuRxmICwdSqpt32Qc1IxoDI39lZPQGxhRUs2Z4BnKxB8tWtOLXM=
X-Received: by 2002:a05:600c:2215:b0:401:bf56:8ba0 with SMTP id
 z21-20020a05600c221500b00401bf568ba0mr7367134wml.28.1695052072963; Mon, 18
 Sep 2023 08:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918143914.292526-1-memxor@gmail.com> <20230918143914.292526-4-memxor@gmail.com>
In-Reply-To: <20230918143914.292526-4-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 18 Sep 2023 08:47:40 -0700
Message-ID: <CAADnVQLX6BBzQuFS8bcP2ucfSDFGZT3C+N+yagxUiMPtnsra-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] bpf: Disable exceptions when CONFIG_UNWINDER_FRAME_POINTER=y
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, David Vernet <void@manifault.com>, 
	Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 7:39=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> The build with CONFIG_UNWINDER_FRAME_POINTER=3Dy is broken for
> current exceptions feature as it assumes ORC unwinder specific fields in
> the unwind_state. Disable exceptions when frame_pointer unwinder is
> enabled for now.
>
> Fixes: fd5d27b70188 ("arch/x86: Implement arch_bpf_stack_walk")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Very weird that only this patch reached patchwork.
Could you resend and trim cc list significantly?

