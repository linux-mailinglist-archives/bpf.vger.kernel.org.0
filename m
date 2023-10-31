Return-Path: <bpf+bounces-13718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 045417DD0D4
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 16:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5052812AD
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5D31F19B;
	Tue, 31 Oct 2023 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Ydgj7Hub"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DA21D556
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 15:46:18 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1274E4
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:46:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9d242846194so430379066b.1
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1698767175; x=1699371975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zvORLavA9zDMo1ODNchXSyFXGb12sAU3bpk2p4HNhc=;
        b=Ydgj7HubJ0wU8QHEq5JD/MiBRa9XQ6DYlwJx8U/ZEsE6y11AwGtugbmRvuBOlISahQ
         M4G/5/mMV74sE0sF8CTv47WAzFYCnOunwjL6zOGuHlktaEu556FMiVfaIwcY61sj0IQc
         DTTSxJsIX8Czw3JJ95Y7A1UQT8DaXTnVcgFJy5rfAO92Tj0/UvreQ4sD1Ls1IBkm5uov
         6jyGluvkF7J9w52VhpX6bRSUG8mNZFmRZWvGs1hjF9kCulP56kzD17xWDiIHqQOKi7Jg
         U+UsKwdXv0KVueedYsKxqePspcvWj/PKIN4KzwvKFPm0vIgqlLNKhmjmAglHX+DFUEhX
         nisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698767175; x=1699371975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zvORLavA9zDMo1ODNchXSyFXGb12sAU3bpk2p4HNhc=;
        b=HVblpVDv5cQ/RfW5DOPXz+WTZ2+j0THvd7QLAE6YGVpD2abfbHWymiJB22p+ReeBaw
         PUWMoOFLdME9oa8BRXp1pagLdGzgqKkJAjnlv3vPq7PHc+fwJrc+EtKHU7t286/OfRuh
         yJdLOFEh8Etth/zl5+9sZOTsHcC4VYxKo6CAZdHVlppV7XnX0nQphCjmxMgQWQuTEJxO
         o5Yn2p7xXBad4ulhdbJEPb3v83KdErrRrjtex3b7N3u+fFJu8ukWRntVpTF4kN3KhEFb
         WozNkcr6y+6dwdXoc/4ag1RAgih2UDv5kh5tDZYyWmr22CNaNaMUqwWLV9xVihzNSiIy
         U67A==
X-Gm-Message-State: AOJu0YwVbk5FFxXNpiEbHp36j9W4wBWcfMuZT38qYErCzSsPqaLsaraO
	QdbXpWe9ZZT4vTt2n3S3LgjWnps7lbRwIkcMKqx0eg==
X-Google-Smtp-Source: AGHT+IHzQdkAQ1pTms8Nrhts16AZOvjVYZfAwIJ2xTqshujsNXNWxs4XZImcnLF7yR1VDgRTADejisb6IJkk/oiyRs0=
X-Received: by 2002:a17:907:9492:b0:9ae:54c3:c627 with SMTP id
 dm18-20020a170907949200b009ae54c3c627mr11265665ejc.71.1698767175095; Tue, 31
 Oct 2023 08:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN+4W8h3yDjkOLJPiuKVKTpj_08pBz8ke6vN=Lf8gcA=iYBM-g@mail.gmail.com>
 <e9987f16-7328-627d-8c02-c42c130a61a8@meta.com>
In-Reply-To: <e9987f16-7328-627d-8c02-c42c130a61a8@meta.com>
From: Lorenz Bauer <lorenz.bauer@isovalent.com>
Date: Tue, 31 Oct 2023 15:46:04 +0000
Message-ID: <CAN+4W8hK9EEb7Qb2How+YwNkkz4wjRyBAK7Y+WcqBzA9ckJ5Qg@mail.gmail.com>
Subject: Re: bpf_core_type_id_kernel is not consistent with bpf_core_type_id_local
To: Yonghong Song <yhs@meta.com>
Cc: Lorenz Bauer <lmb@isovalent.com>, bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 6, 2023 at 5:50=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote:
>
> But I see your point. Maybe we should preserve the original type
> for BTF_TYPE_ID_TARGET as well. Will check what libbpf/kernel
> will handle 'const int *' case and get back to this thread later.
>
> >
> > Cheers
> > Lorenz

Did you get round to fixing this, or did you decide to leave it as is?

