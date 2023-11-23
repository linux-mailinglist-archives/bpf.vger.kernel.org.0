Return-Path: <bpf+bounces-15727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E9A7F5603
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 02:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590B11C20C5B
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 01:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79AF187E;
	Thu, 23 Nov 2023 01:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIfJam0Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5C8191
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 17:44:20 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-285625e1851so148772a91.1
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 17:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700703860; x=1701308660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ka0OjqA7/CGvxnMe2w75wtjWxnKCkBHAUUFZi3iTSZ8=;
        b=eIfJam0QhtSZOMTAuLwq8zd/NYgtkRcL4DBjVJ12Rz3V4zeYCd+U7FYpglHYi2ITo1
         uHBzNAD5hCU5YyfYCjnZ0D5qKB3o9hLISQ0liG8PJxrgA4PuFNKnpYO2qJkjeIZByD6m
         WLpmeHlNfx2OcvCnIK/SZjXSfVRwWasgI42WDFIcE9IXL2AXS2rU9r9PyCDfa2bY11Ok
         E5f/zNaSTCU39WyMSxaIbugnbPjbkAO47k20v594MWFR397hsdY/ATDv00MdiMUJ6tP3
         E+vq/DezH9UqqUw3tfA6FBk+NlLNhzRMA+4htbejLmXBDPgw+Wv5Wx+SouiMOB+Ru1IX
         IS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700703860; x=1701308660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ka0OjqA7/CGvxnMe2w75wtjWxnKCkBHAUUFZi3iTSZ8=;
        b=bx3+qQ3snOuL+pRXiKjNuP9zdxXsuxgB/oTWlxL3rP3iy8YwyYY5qsLUhnZRkMJoMY
         BOidcT6n4FgTnKNofU8XDKuo4MqjAZ0xW8h1nXn+gwyHfCSrOvtqFBXdSyTzsPKkaclt
         BsJegMdPajIlMAaBfHz4p2QTDzWbmaKvrRTj8j+uVPUN4VSGAeYTRBD7izfOlI0bCGJp
         8SDmedcyQEKTyEtEotgRm49yxWxlCiZPoVPUVBMEWgNHccr4wUbY0DsPqQZJ1J+3fNRG
         YsnnJYLW/maQN8yh+FBW8+aaV3yA2p4tjZeiKYslatZG4DiXQcd3JLthH/2LamhzH2OT
         Zg8Q==
X-Gm-Message-State: AOJu0YxYjVKAwjhfgD0KNvQDCAFSePzLf1O57WogUH5heWzhXrosXcI7
	13ciiCrSIdO+eOYDVa4zfUKE+IEzV0M=
X-Google-Smtp-Source: AGHT+IGnY9zjzP5/YllfvMssxYovhniQpr2/3cFCFqVxp1SqmvAqvQTjjD5kdkmxOohHjnkIVaHfAg==
X-Received: by 2002:a17:90b:3b89:b0:280:a491:abff with SMTP id pc9-20020a17090b3b8900b00280a491abffmr4374798pjb.5.1700703859802;
        Wed, 22 Nov 2023 17:44:19 -0800 (PST)
Received: from MacBook-Pro-49.local.dhcp.thefacebook.com ([2620:10d:c090:400::4:78a6])
        by smtp.gmail.com with ESMTPSA id a21-20020a17090ad81500b002851e283c21sm153854pjv.12.2023.11.22.17.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 17:44:19 -0800 (PST)
Date: Wed, 22 Nov 2023 17:44:16 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 02/10] bpf: provide correct register name for
 exception callback retval check
Message-ID: <20231123014416.sm2pcgsfiptan6wf@MacBook-Pro-49.local.dhcp.thefacebook.com>
References: <20231122011656.1105943-1-andrii@kernel.org>
 <20231122011656.1105943-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122011656.1105943-3-andrii@kernel.org>

On Tue, Nov 21, 2023 at 05:16:48PM -0800, Andrii Nakryiko wrote:
>  SEC("?fentry/bpf_check")
> -__failure __msg("At program exit the register R0 has value (0x40; 0x0)")
> +__failure __msg("At program exit the register R1 has value (0x40; 0x0)")

While at it...
should we change tnum_strn() to print it as normal constant when mask==0 ?

