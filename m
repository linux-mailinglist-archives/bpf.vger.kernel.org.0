Return-Path: <bpf+bounces-12441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0467CC858
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A590B211C4
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF96B45F61;
	Tue, 17 Oct 2023 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfvM84sF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BBF450E7
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 16:06:00 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630E7FA
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 09:05:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b6559cbd74so1023789866b.1
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 09:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697558758; x=1698163558; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XOmnpkoUs++OoOzbOQL4QS4Unsi+0hAP3QmhNtOanNU=;
        b=jfvM84sFf4kPCtHJc+ti+eV/RdWiFGzw3hjzP8erzQU+Kr4AQUOqgkcdwm0Uttc8+o
         G8N2ws/+QLiejSZFqKmex3ZPxnnR7oarvx3PpnjDeE4i3SHHKBgUYifR7yA4Ud26ibwF
         k5fCZSaQui4rQSkAwLjHBi9/UDYODL5//UmQuoBiQ8pE5zT3r1BpAa6d6wBfkrhBDdlq
         gwjmQu3SnMe3Y9UaAm08/g8r/ZG28iQEPw8oW9YV1V88CWpDgsQB58Ije54m8tdgK4xh
         rb3/Prsuquw+zK/fo3xv2A+u8PllN6eKN4bFlZa68AvFEGoe3G+DdDSYadYkGj69yay8
         jYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697558758; x=1698163558;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XOmnpkoUs++OoOzbOQL4QS4Unsi+0hAP3QmhNtOanNU=;
        b=Mo2Lq7yGIM+YnMskEPT+fvxQ+cuqjtml/kZxlhjYqWAsXp6m+1MDXYlWOG5EW0aZjg
         fIPUTyI6sZwqnIHyUujnCCQjMm5aWDpuFEDHl7fpIZZgiukAppWMpWhlWgow0qA9wLI6
         5AL9sqwPgYOisqRGUbCEInVCZ5WE/jcb880k1FwbhY8SyNHTqY/9LuDotzmoCC4kd+qv
         qhgW3MkhBgMaMNaIpIhoc9VcVK1FCuf3q6QECK6lk6oYrSNztvA0+AnclpIPBdbS4utX
         As8CPl+M+cyDu98TQcrttV16l2QLbySQzgDsmSTelp820An1QX7hpgHPcX0tli0pUOWB
         cl9Q==
X-Gm-Message-State: AOJu0YwwiIfj4JAwr5RnNGUfnP+SKRx1vX7o1muLFdigH64iEDaNWgCM
	eGyGfkTDXggc4wsAQwHMOa37MrBplag5quiE
X-Google-Smtp-Source: AGHT+IEy1BQcltkBzQi4j3GC83i7F8BB/tGivJ08udX7CAsRQi0Ms9egROCAn9olTISNcb5D1UNp7A==
X-Received: by 2002:a17:906:ef08:b0:9be:1bde:d4b with SMTP id f8-20020a170906ef0800b009be1bde0d4bmr1839465ejs.44.1697558757470;
        Tue, 17 Oct 2023 09:05:57 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h9-20020a170906260900b009ae3d711fd9sm69956ejc.69.2023.10.17.09.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:05:56 -0700 (PDT)
Message-ID: <d7dc70644cb914f53e933298fa87a29cb762fdc4.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 5/5] pahole: add --btf_features_strict to
 reject unknown BTF features
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org,  sdf@google.com,
 haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org, Andrii Nakryiko
 <andrii@kernel.org>
Date: Tue, 17 Oct 2023 19:05:54 +0300
In-Reply-To: <f59f5d60-c33e-1786-f442-82ea795059b2@oracle.com>
References: <20231013153359.88274-1-alan.maguire@oracle.com>
	 <20231013153359.88274-6-alan.maguire@oracle.com>
	 <dbaa9e9b3e090f5ed88faaa62a40a080eae53ec4.camel@gmail.com>
	 <f59f5d60-c33e-1786-f442-82ea795059b2@oracle.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-10-17 at 16:59 +0100, Alan Maguire wrote:
[...]
> > Sorry for late response.
> >=20
> > This won't work if --btf_features_strict specifies an incomplete list, =
e.g.:
> >=20
> >   $ pahole --btf_features_strict=3Ddecl_tag,enum64 --btf_encode_detache=
d=3D/dev/null ~/work/tmp/test.o=20
> >   Feature in 'decl_tag,enum64' is not supported.  'pahole --supported_b=
tf_features' shows the list of features supported.
> >=20
> > Also, I think it would be good to print exactly which feature is not su=
pported.
> > What do you think about modification as in the end of this email?
> > (applied on top of your series).
> >=20
>=20
> Argh, apologies, I could have sworn I'd tested this.

No worries.

> Thanks, the fix looks great, and I tested your modifications and all
> looks good. I can add a Co-developed-by: tag for v3, or let me know
> what attribution works best for you. I'll fix the cover letter as
> per your other email also. Thanks for the help!
>=20
> Alan

I don't think "Co-developed-by" is necessary, I can just add ack in the end=
.
If you think that some attribution info is necessary for bookkeeping reason=
s
maybe "Suggested-by"?

Thanks,
Eduard

[...]

