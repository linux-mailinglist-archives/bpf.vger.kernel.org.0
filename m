Return-Path: <bpf+bounces-16384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6DC800D2E
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 15:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1FE1C20A75
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 14:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A013B7BC;
	Fri,  1 Dec 2023 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJbXSE17"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA61F3
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 06:33:30 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54c4f95e27fso969677a12.1
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 06:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701441208; x=1702046008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DGyky3IM+4wNEDcPOrSpBIpZb9HMLjXYHRCp+rzVQSs=;
        b=DJbXSE17tvvCfeNDHgSrDMLM4WDVWJkNgw+wt2KMLhmxktZERzlV6/lzP2dwNZho6Y
         93pv4iD5kNNJstDh04i5Q7D1OETrFcWdQzHLRuzh3EzX0xla3TS22PuPdxOLE7TdxYkF
         iMn+jTNpDV8mAdC54KNBUw1Zth1+Z6tGA400XkclvYKQFd32W0lvKuvHCCSmK0eiTTaO
         5eei3+9XaZRAcnW9U5ZewfN02uMDFlto7pec8FaHwDuk7+pv37VRMuHvHVnjlwP4Oh9b
         Awnxt9XwQLOHmd0PZtQ5DgGiN/PSBE2ymMD0w/uAW13d795JbbE89Kq132T3Yu74+6iQ
         /pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441208; x=1702046008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGyky3IM+4wNEDcPOrSpBIpZb9HMLjXYHRCp+rzVQSs=;
        b=HmXsZg5sIALy8OOfHfllkYob9Vn7WWEHORJbTXuHz4VMlgAWp+f7v+GaLFULvOUVo0
         DpiID+COHR/O4oiz8zGGFsfRedij+uGJ4mlu8X3GFCnMHNdriGUzIwUodARQN8svv7z2
         YIbXiTn+5Gkc+1fMxUlEblGAVW80XLoa1vDQdhfA6LPwtAGkkd7brpB1gUQmUmDTufi/
         S0Pzu2mkdaAm/ESsm32m0byJvZi9LrN2Y2/jBvf52niQhu4qdOrxpaJ9xMFVu2TNyRUX
         Fqr7FHDgVVfDa9Iis1/GmhBoN9e2fsiYw0RmEtKDryeG+FBeyxpt8e7VLXO54a/iqt9U
         sfRw==
X-Gm-Message-State: AOJu0Yzfuy7w8/FlInyx9k7gxPy6V/N5EOrc21VrlQqfyGMtRQjmQeU8
	WtxwwHbc6Cci90bKx+wVw3A=
X-Google-Smtp-Source: AGHT+IGu4LqRamiKG+QjEtZnSnUOdRvCiIx1SOnRnuKssm1aF5PChWH7Nd1H5ATXI8W/ekA6vftvIw==
X-Received: by 2002:a50:d4c4:0:b0:530:74ed:fc8a with SMTP id e4-20020a50d4c4000000b0053074edfc8amr1171930edj.41.1701441208280;
        Fri, 01 Dec 2023 06:33:28 -0800 (PST)
Received: from erthalion ([2a00:20:6005:5771:fa16:54ff:fe6e:2940])
        by smtp.gmail.com with ESMTPSA id q26-20020aa7da9a000000b00542db304680sm1676339eds.63.2023.12.01.06.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 06:33:27 -0800 (PST)
Date: Fri, 1 Dec 2023 15:29:49 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Artem Savkov <asavkov@redhat.com>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	yonghong.song@linux.dev, dan.carpenter@linaro.org,
	olsajiri@gmail.com
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <20231201142949.wjw7rrmdeansm3mc@erthalion>
References: <20231129195240.19091-1-9erthalion6@gmail.com>
 <20231129195240.19091-2-9erthalion6@gmail.com>
 <CAPhsuW6J+ZN7KQdxm+2=ZcGGkWohcQxeNS+nNjE5r0K-jdq=FQ@mail.gmail.com>
 <20231130100851.fymwxhwevd3t5d7m@ddolgov.remote.csb>
 <CAPhsuW7Yif_mhaUsiwSFyUD7Pv4sz163DBz73EDhnTGMhwdApg@mail.gmail.com>
 <20231130204134.4i4tloaylxrkrnrt@erthalion.local>
 <ZWmtfZlTq2hBn5zp@wtfbox.lan>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWmtfZlTq2hBn5zp@wtfbox.lan>

> On Fri, Dec 01, 2023 at 10:55:09AM +0100, Artem Savkov wrote:
> On Thu, Nov 30, 2023 at 09:41:34PM +0100, Dmitry Dolgov wrote:
> > > On Thu, Nov 30, 2023 at 12:19:31PM -0800, Song Liu wrote:
> > > > All in all I've decided that more elaborated approach is slightly
> > > > better. But if everyone in the community agrees that less
> > > > "defensiveness" is not an issue and verifier could be simply made less
> > > > restrictive, I'm fine with that. What do you think?
> > >
> > > I think the follower_cnt check is not necessary, and may cause confusions.
> > > For tracing programs, we are very specific on "which function(s) are we
> > > tracing". So I don't think circular attachment can be a real issue. Do we
> > > have potential use cases that make the circular attach possible?
> >
> > At the moment no, nothing like that in sight. Ok, you've convinced me --
> > plus since nobody has yet actively mentioned that potential cycle
> > prevention is nice to have, I can drop follower_cnt and the
> > corresponding check in the verifier.
>
> If you are worried about potential future situations where cyclic
> attaches are possible would it make sense to add a test that checks if
> this fails?

Do you mean a test that cyclic attachment doesn't work due to the
current limitations (not the one in verifier)? Sounds interesting, but
I'm hesitant to add such a test -- it would verify a property that is
more like a side effect of e.g. having attach_prog_fd at prog load, and
most likely will be either incomplete or flaky.

At the moment I'm pretty convinced that even if the future changes will
make cycles possible, it's something that has to be discussed at the
point when such change will land, and it's fine for now to simplify
things.

