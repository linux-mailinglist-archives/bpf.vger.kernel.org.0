Return-Path: <bpf+bounces-14624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8158F7E7222
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 20:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEBD2B20D13
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 19:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C65358B4;
	Thu,  9 Nov 2023 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfmnD/x7"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03452249FF;
	Thu,  9 Nov 2023 19:20:00 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EB73A84;
	Thu,  9 Nov 2023 11:20:00 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so797011f8f.0;
        Thu, 09 Nov 2023 11:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699557598; x=1700162398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHmtmlWMV03EPvOAE8I3l03aMAmsfssVCPga19RZMhE=;
        b=OfmnD/x7hwAuRzWPRhOTb3HYL5Q4KWqvJwav8thAAEij73tbuCH6RlTfNzx2wvBxZA
         A7k8QbrR3ArxfFyVTxLmgz+xre8Xr0kPkSJv9siCJUKt9n9wcq90Q+XyJeIvckVRPy32
         uHdEKsaVqgLlULTqRkNZuSqfD7SQ33Cm9TFWtnNomyYfkSByBNDEF9sTC9unnoI5zhFO
         pmcyWA7WMcVf8CtrmxpYBKbq9PHNeOzGiEbLAG4EtceGbYSRVBUcB6WCW5SoIwpe9w2R
         5dsOp3pR9m15qWENOGpqLptEtL/4EIKWC2nanOKyP6jDlaqjqEXIJ0/bOgY37vIOflBU
         2B9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699557598; x=1700162398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHmtmlWMV03EPvOAE8I3l03aMAmsfssVCPga19RZMhE=;
        b=j1hfiCrbA1/xKFJN8Af7js2GmDUzuldpaPhQOTdJmU+DL5I1P8MIiSmNXL3v5qojT2
         keAmISSwMK3R0NpFug8OVzKiwymx07aCgLHSk7NItHK+YY8o84FltsVXIygjdZih9c05
         ZyFnse/XKeknjTQBbrDLk8ZzaidiSZy5gowrtU6Q3SED3qx0mofyTK4vJIFWrTbYQOwd
         WXA2tGejrys/JrBGFJptBUH3tkSMremmu3HzVb30neTgRY+ojpx5X9N/ymxJY4deGjr5
         bPD9Q2Tm4+s29za6yWgRfCi05m131nMh9gu2OYw+heVmRwLzVQjX24BxxjL3y4Y+lWxK
         qc4A==
X-Gm-Message-State: AOJu0YyVAFACfLOqygpMKpIr6KGGksxsvuPZ/5JckFfm8Ys07BWFSRBo
	dGvCa6PCVqKFsKIGjftO7eXv1hc/MsO69ryGBGQ=
X-Google-Smtp-Source: AGHT+IFTKtJTibqT0yuYffZ0UvZ7lZfRvacgEC8CXUxpdX5dbeeum5dNGE/z37iWWs19/BDiupjshmHtYNmdyxpwrak=
X-Received: by 2002:a05:6000:188b:b0:32f:76d7:7d6a with SMTP id
 a11-20020a056000188b00b0032f76d77d6amr134396wri.35.1699557598437; Thu, 09 Nov
 2023 11:19:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031175742.21455-1-larysa.zaremba@intel.com>
 <b6da9739-a6e6-4528-a4cd-f87e8e025740@intel.com> <ZUUE8lH+EbuRNI16@lzaremba-mobl.ger.corp.intel.com>
In-Reply-To: <ZUUE8lH+EbuRNI16@lzaremba-mobl.ger.corp.intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Nov 2023 11:19:47 -0800
Message-ID: <CAADnVQJzQm-R5etK+Dh7dMP9dzXfg58kd3suKV2FSPxKMKh8iA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] net, xdp: allow metadata > 32
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 7:35=E2=80=AFAM Larysa Zaremba <larysa.zaremba@intel=
.com> wrote:
>
> On Fri, Nov 03, 2023 at 03:03:14PM +0100, Alexander Lobakin wrote:
> > From: Larysa Zaremba <larysa.zaremba@intel.com>
> > Date: Tue, 31 Oct 2023 18:57:37 +0100
> >
> > It doesn't have "From: Alexa..." here, so that you'll be the author onc=
e
> > this is applied. Is this intended? ^.^
> >
>
> No, I should probably resend.

CI is failing as well.
Make sure to test your patches.
test_xdp_context_error:FAIL:bpf_prog_test_run unexpected success: 0

