Return-Path: <bpf+bounces-13012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8177D3A5C
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 17:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E60E1C20A92
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 15:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F1B1BDC7;
	Mon, 23 Oct 2023 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="egm/O2E7"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2031C14AA9
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:06:43 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990ACF9
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 08:06:42 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-581b6b93bd1so2047136eaf.1
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 08:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1698073602; x=1698678402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=589kWa60rv9ivRuzxruIRObnx4upUw3uc1WngFwaW/E=;
        b=egm/O2E7ECjg8eJyL+euzv9jUMby5afDoTByoEUsYEq/22IvZBzbW6htivU2gmDV7U
         Q76Wc3ProrjZzbnlTxFnX+Ekr+oLr4kZPsxHfyCTPh5r5qsj9FA7GsSQcR5FT2/sB04J
         9axJp1L3bYqD5ON6o7Nv9NsPzwGXTq6uYHxTPIMH0BW+m/v3GSE1d3n8LyRBHx7BwboZ
         8mWnXjOsUgNiV2rL8kSyt4TjPQWAg/xx7OfRFi/ibRGSq4SrVH7svEhTLuC2VVBAN8YJ
         MjcM08D2ry4qMJ8sweafzb/8m2xxvjpfcdyiUpJn2hEMczQBqZb3G0oSvAg3z3fBK5kI
         JRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698073602; x=1698678402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=589kWa60rv9ivRuzxruIRObnx4upUw3uc1WngFwaW/E=;
        b=vwsp1c2fAK0Ty/SBCoau6Oz5bz7mVRjV/xeH9mK4zzUCZfcPcpydokuf/AaGpArIDI
         OZ0m3RwX3HYyJEVrVzW/j46eL/+DuVbAgJ4Iu+5PckU94RjzuHPYMio+9ypPj/C7Ik4O
         2lnpHP8P9W0rwt7aS5Dv0cBJF/QaR1YQeQ4Y1dyl8EFSuQ2AdWfMwBRPB8pMQesJJbTZ
         yFXc+Bl1cZrwugFQ2+lSwB2BytJLH+Nilgsf/4nfExt4ZOyLghUPNuLRh8A2LZlzV2Rp
         Lt7NM2wajPxpFTdbi3udF6PZIbFWnfgHbImxkg+daFJ/LRlMLmvFUUzSdEXvuTszb5yW
         1UPQ==
X-Gm-Message-State: AOJu0YwcREkkGcJvg8Ioc3qc42x8og5c8LBRcT3qbYVSrD3zVzS+QEAp
	luL43gwtVQIKMkNc7kZMkwy6fucjBoVSm6hDi6S0Rw==
X-Google-Smtp-Source: AGHT+IFNQ1m7HKnCw0yCQBHmA1Fz716XV9sZnDMUA943cr0wW2g8X1fgF2y2e5lLHjl99/hK91pYr2xUGbE6zum5o+0=
X-Received: by 2002:a05:6358:cd04:b0:168:d0a3:202f with SMTP id
 gv4-20020a056358cd0400b00168d0a3202fmr5784477rwb.15.1698073601496; Mon, 23
 Oct 2023 08:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR21MB387850B8DB6A2A5FB87DAC06A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <ZTDGfppgSnpKjaYz@infradead.org>
In-Reply-To: <ZTDGfppgSnpKjaYz@infradead.org>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Mon, 23 Oct 2023 11:06:32 -0400
Message-ID: <CADx9qWgP=h4kQEJ2Cpy-A9hyiKLdkF3hVZVydLrz2Lk+UGBaAQ@mail.gmail.com>
Subject: Re: [Bpf] ISA RFC compliance question
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>, "bpf@ietf.org" <bpf@ietf.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 2:04=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Sep 29, 2023 at 08:14:12PM +0000, Dave Thaler wrote:
> > Now that we have some new "v4" instructions, it seems a good time to as=
k about
> > what it means to support (or comply with) the ISA RFC once published.  =
Does
> > it mean that a verifier/disassembler/JIT compiler/etc. MUST support *al=
l* the
> > non-deprecated instructions in the document?   That is any runtime or t=
ool that
> > doesn't support the new instructions is considered non-compliant with t=
he BPF ISA?
>
> Unless we clearly designate optional extensions that that can clearly
> be marked supported or not supported that is the only way to get
> interoperability.
>

Can we look to either RISC-V or ARM for prior art in how they worked
different versions and compliance levels? I am happy to amass some
documentation about their processes/procedures if you think that it
would help!

Will


> --
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf

