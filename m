Return-Path: <bpf+bounces-15272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A15E7EFA76
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 22:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60612814C2
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 21:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B29524BC;
	Fri, 17 Nov 2023 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTB4x3UL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534231FE4
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 13:18:27 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso3611749a12.1
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 13:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700255906; x=1700860706; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tld3nI/3e4RcusERfylC/2kSCU36cVwgyiWV1lbsfZA=;
        b=HTB4x3ULm9OLCSPWy5kuz2pUfEka9ljtSrbocati3IYqS9Pwjg1+ekjiJxkhLSfKyt
         Y4S2Hg+NcliCuWCJiRpvspbq4wBcMMRmhEju3LoniN91vV3h5XzBawqrKwWn+GmuJ0XS
         uAeusYNdYa0NeuBhztqc9UYeeosy0WJI5Lw0nrvVifggz3ByrnWj56WdKgcnb92IvmZF
         EElObsiPydN8SNgol29HPtk8NaoyIpTNF4CdsEg6bNVfmUqAQRldDZS2Wnu7z7uYEfkh
         1XF0gj31GffPtDpoyP2weQq5Bk9B+6DXWkTGpUH+t4KpVTHz+P2k2hnCH2Bi+YG4XOUL
         VqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700255906; x=1700860706;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tld3nI/3e4RcusERfylC/2kSCU36cVwgyiWV1lbsfZA=;
        b=PfLtOmfSKa7jsXT7j0vQlNv1ZUBbKIBkgoYkkcf9vud4Z7KKvt1/8LMF6sWtzP1bVr
         /6t9Pb9aB56w2KQIqeNx3AFtnGbQq1j8nD6hLAFzwoIITD4YnBNZh60ex3j/RGJuiovS
         Q826WRz/v9EbkcEXEWarLJyfiv9r8iKAs0ku/jzyHV5D+TQuUL9OUXO9EPmmn0u/oF4I
         wKx8DJKewI9YWUGarHBGomwDI5EeqcaiOtpCFKmXsChLvEEgoKyj5IlFtUM+aP5DFV2u
         QQQsHyCyc1kjal3aVcGapU1PiBhHaogWfsEfFnOs5IE+j2g9wX6KTAKEtRdL9UftlNp9
         SHwg==
X-Gm-Message-State: AOJu0YzVCAFe5aVON19jg0SiNFskeYpCnDgE5kwTEwi/Q8vt7FY6e9uR
	0yiOxWIjUvT7otOrpvk5q3A=
X-Google-Smtp-Source: AGHT+IEoQYo0ovTfIdxv4ArwRmdRkF/db6cZ0+x5qy0Ny0vUxglPc07p6UOzNsBuUcMUhsw96ahUTQ==
X-Received: by 2002:a17:907:940d:b0:9da:b1f1:ef47 with SMTP id dk13-20020a170907940d00b009dab1f1ef47mr369218ejc.30.1700255905592;
        Fri, 17 Nov 2023 13:18:25 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id l1-20020a17090615c100b00992e14af9c3sm1187957ejd.143.2023.11.17.13.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 13:18:25 -0800 (PST)
Message-ID: <4ba004264da50aa938d2bda9e3f2cc5c15d737e4.camel@gmail.com>
Subject: Re: [PATCH bpf 12/12] selftests/bpf: check if max number of
 bpf_loop iterations is tracked
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  memxor@gmail.com, awerner32@gmail.com
Date: Fri, 17 Nov 2023 23:18:24 +0200
In-Reply-To: <CAEf4BzbNYveHmjxmKN9doBD_yEh6nyEiqQVSSbeh-yMnNJsG8Q@mail.gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
	 <20231116021803.9982-13-eddyz87@gmail.com>
	 <CAEf4BzYd_Dv4fEoPe+n+sRXxHFmYrTs7w45jtYeQByNH521gzA@mail.gmail.com>
	 <6da7c6b9617663daa54ed27d2c1637cc71dfb7a3.camel@gmail.com>
	 <CAEf4BzbNYveHmjxmKN9doBD_yEh6nyEiqQVSSbeh-yMnNJsG8Q@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-11-17 at 15:32 -0500, Andrii Nakryiko wrote:
[...]
> > Well, r1 could be 0 as well, so idx would be out of bounds.
> > But I like the idea, it is possible to check that r1 is either 00000,
> > 100000, ..., 111111 and do something unsafe otherwise.
>=20
> then why not `return choice_arr[r <=3D 111111 ? (r & 1) : -1];` or
> something along those lines?

In theory, invalid value might be 100002 or something similar.
I'll try writing down something more precise, if that would look too
ugly would resort to the comparison that you suggest.

