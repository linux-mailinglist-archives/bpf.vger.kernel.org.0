Return-Path: <bpf+bounces-61375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D50AE669F
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 15:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4BC3AAD83
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 13:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB61C298CDD;
	Tue, 24 Jun 2025 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZXm/iT3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB862A1A4
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772092; cv=none; b=eTkZcnRPAM3L4t3FcOX8b1gV0xAjeu4NRo2WlM3y71X/Xmo4ILTDO9UUP04blARZZO7ovua2eK0TiTAR9oi4icqoh3gqSp0ZH18ywx/zWjSrtMiT83ryIj8gVxJylzJdEkKbYamHRxhlloHk6UQSg1nfsrM1R/ww/HESa4dfbFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772092; c=relaxed/simple;
	bh=7rtS229PZXA2TypExRx7X3cfgtKiK4dj6mlbyReK3+k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcSXGrhm2TAaKwCjEarMNrAke4kMxmsbtcJxt1Fw3j4P8zwIqaaxwpVTjq8RCiKjGfObvbSIytXhxlwHvzEwHF/8aE+7bnSm8d9fbKyIk/D+vEdyB3bPbNOkI3drSjlnSyFnh17Zp4Ng7p9GcBKaEQGZRWMFbR1b6yGKxup6MWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZXm/iT3; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60497d07279so11521139a12.3
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 06:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750772089; x=1751376889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/EKZJlEwQXoxjKuPNRY0WVO2VA3vk6mG/IMGeDYwqH8=;
        b=TZXm/iT3yD/cAatBfOPsURihdL9V1eiQ6oHVil9z1vvZl/1usbhe91hCNSRn8Tn+tV
         mQpJir0pwTRGK4D+uzMFcY5YynfD4FVWohSA/ZnfulSHD++m/Dyi7hErBSQLcWc9X8F1
         /vMSfclumMx8t92bpd1eGXislcgj4FwB7Nwue8Fra3ULV2mpRj9eWYxaoIvwN4jjInxu
         mjCbMHpQt9IAvj5sEDwTqX3O9X9/VN5Wiah8gvsBLU67fKBsG9kLinZU9rhbRuhwX3PT
         3Oe6dA8fkRhcixDdkH72q2/Ge07q6W9VPYgZCpvjZJIZmYRWgk7taNiYt0BLkFihYfuE
         RWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750772089; x=1751376889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EKZJlEwQXoxjKuPNRY0WVO2VA3vk6mG/IMGeDYwqH8=;
        b=NHcHRkiqexbjNFVU2lGJYFMP7uhdFLLc3278D/FYpGmir2DmeF61A+hH5amY/5o7Am
         6LFv6EDVnUf3puH8s9ETIl++wK7sUT/7DkGcikemFNQBLEaT2LX+quWrTRCIf1+kV7oH
         uc92yRZsP04UDlGA+SxCyjzYLZDoSzLJY7CQ2QlZ6h5tEsfG9XdKCVmobcYmBYm5fba7
         rTOLKQs1sifMulFNd2AUKp12p2FNdo51DK++eZdhOAqeoSC9G3X9TWl32TKhdB+FUVzb
         QVM4kAq1PUwgkjIHx9ucOzvvAumt+a6a0i70PYol98DtBqlTTT0kMogF3hce1Qo+MStP
         uIQA==
X-Forwarded-Encrypted: i=1; AJvYcCXdM+fMA8a2mQdJ6u+tGPH3V8wg/Hhpwt9NoittuCo0vSn0YvUy+xAGXFBQpdCuVBOTwSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt7ydxmVz2OZLUx0f1TchbinvnlzJin0Qwr+0SDKUQnXc4MRb+
	zMKv36iHrYtFs0Yu3ALigfhpU6VE7v+td3MI4rYtZS9QJ2Fc3OHlGCdE
X-Gm-Gg: ASbGnct3INYIYFVyWMHoPtJGhVognGX48a7Oq9wG1hBPL53G4FVa5BYteFnMaKnANhZ
	laNeMALAJ9q4aMW1jXM5GkANRf6DsEOyLVhIiqHT9aZk35QsmJ+mKzUKadAkvqK0aFkVbkBC9Im
	jO9p15oiY+2Mw0lhOETRcb8mT4g8J56PPwkCAN4aNOQi2LA301Lohuh/rBVC4RL9zxnVyCzaL2i
	ToPgQCiUnE837jh8BxwVsQ4Vpk5TjnYXVcWjQ21Y399Tnxvww6HNhqgW+ENblAPmZBOBpspDloB
	CvhgbTCfb2ToR5CpNy98eNIIKiGUI19ZwP2C3uqqyZyfKkf3lQ==
X-Google-Smtp-Source: AGHT+IGSaA2R9yKFNgZowuLbBBFoSECPp6D7D7LMnSwTfcr3hrnFXvmpXHf75S/fI4eaQf+/CRkrGQ==
X-Received: by 2002:a17:906:9f8a:b0:adb:43d0:aedb with SMTP id a640c23a62f3a-ae057fa74c6mr1522123266b.61.1750772088476;
        Tue, 24 Jun 2025 06:34:48 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053ecbd9esm880295266b.38.2025.06.24.06.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 06:34:48 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 24 Jun 2025 15:34:46 +0200
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 02/12] bpf: Introduce BPF standard streams
Message-ID: <aFqpdkLaRsjTw7Ik@krava>
References: <20250624031252.2966759-1-memxor@gmail.com>
 <20250624031252.2966759-3-memxor@gmail.com>
 <aFqTiLd4HmjPS5eP@krava>
 <CAP01T77EXWDdRYtrJHUR6qLBgLqe4oT0A0N74CGBBRVGYPuKnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T77EXWDdRYtrJHUR6qLBgLqe4oT0A0N74CGBBRVGYPuKnQ@mail.gmail.com>

On Tue, Jun 24, 2025 at 02:15:09PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Tue, 24 Jun 2025 at 14:01, Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Jun 23, 2025 at 08:12:42PM -0700, Kumar Kartikeya Dwivedi wrote:
> > > Add support for a stream API to the kernel and expose related kfuncs to
> > > BPF programs. Two streams are exposed, BPF_STDOUT and BPF_STDERR. These
> > > can be used for printing messages that can be consumed from user space,
> > > thus it's similar in spirit to existing trace_pipe interface.
> > >
> > > The kernel will use the BPF_STDERR stream to notify the program of any
> > > errors encountered at runtime. BPF programs themselves may use both
> > > streams for writing debug messages. BPF library-like code may use
> > > BPF_STDERR to print warnings or errors on misuse at runtime.
> >
> > just curious, IIUC we can't mix the output of the streams when we dump
> > them, right? I wonder it'd be handy to be able to get combined output
> > and see messages from bpf programs sorted out with messages from kernel
> >
> 
> Yeah, this is a good point.
> Right now, no, in the sense that sequentiality is definitely broken
> across the two streams.
> We can force print a timestamp for every message and do the sorting
> from bpftool side, or it can just be piped to sort after dumping both
> stdout and stderr.
> Output will look like trace_pipe with some fixed format before the
> actual message.
> WDYT? Others are also welcome to chime in.

yes, keeping the kernel simple (just adding timestamp) and sorting
it in bpftool seems good to me

jirka

