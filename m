Return-Path: <bpf+bounces-22213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94770858FF6
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 15:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7E8281572
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 14:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880297B3C0;
	Sat, 17 Feb 2024 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECvT1HI7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7205C7A716
	for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708178670; cv=none; b=Tw2FQHBLjNLbmaxnoS7yTBsoZ2i1GipveyPue7VeBuxJvyDicsXAEHGGxARjsf61NYSDqYPyJzDtxSPKOVr67e09GG6FojvQh09kL6wPG8VYoTvcIYAQYgqYNe8AzYfhTlXC1/twinKMsAc7aiO3raMsYmFr4iQ1XUSdf8jkkN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708178670; c=relaxed/simple;
	bh=OLzURTBCeda2HIru1RBMkVrljIQQF/BhWkmgonsQOMw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O98ujTycF08ug/M2j9RW4Jw33Id+aHMwYZvmWWvO7l/pypFT5Qv9ddYYPmVRE1t/TCM5Da9YT8Wjkiowvcnik9Eg7bYGR1zgfa5/V8h0kyMzU8eR5Xr1IQO+aaZMwq3DVyF+WJM8xxE48e8mSGUR6uRLK0DAnNPHwhGdY/Y0340=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECvT1HI7; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-511acd26befso3739056e87.1
        for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 06:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708178666; x=1708783466; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vYe2GqnfcnYYg85zkGI+xAA+1Opv2mHxwjkW0XBjYSw=;
        b=ECvT1HI7gHt7vJ9NfiZpxkhXSPeu0WzQ3S7Qu18Rv40TYpirssoyN4l3uPCanLZ4yG
         UZdEaYKMvv8gE1CjAmFaXrb26/LH6+4PexQqV14GwQmQyRfWm3sXoLyJI5z+opwn755w
         AU6S5BooxrRIUXtckW5blQ9Skw08ii+KO4F1RC4DKpCjwgKtjr/Yx8JI2qNuOEpDibTD
         UYxhSOfGqRbV6zG4mbUiGitmRn8H0rr9wyY6OZfsBBrM1/E3PzoUhN4P6PAoQKnEdhZX
         ozESZ65TQe5QWkwdNxMrMBgTBgOXPA3LuO+RmZTtZtaZbiOYIhjSIwQP7JY0tWDBg3jj
         oINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708178666; x=1708783466;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYe2GqnfcnYYg85zkGI+xAA+1Opv2mHxwjkW0XBjYSw=;
        b=v9DAuMomUKSurcUWmltHkiOchfOMq6ymf3rHIvB4WPHyg/KUuRMUuen4bVQWLkss9h
         tnEa43w+PU+HgVGMxxHh1I8yTSzo6sCoOgpe67NJQVlsB9dHiIwthhXaJ0QSB5O4k4lH
         v+nZhv/tkHlZmTxb32ba1iaoLemmN3pJRXehaSOWoxbDgzMfc0tnfh0+X8uivSJ2CzmS
         69Y1IV8yhJHlHfLsbC80kCZLSqz3OWPpka8HqwFPCR0HQqwb6A3BMj4Nshu2u1pVzlfj
         Ir/BMYhKNwItwsNbcAqKfxp/kH2JK8ziEO/QakeuIYumk3Q7cssQJpzL2ALiW+OJz8Ri
         TLqA==
X-Gm-Message-State: AOJu0Yz1kE5C3Agsz6FlWctcvCVsIsVtunpvEaz881qLwb7vnmw01+as
	NRIJ84k3fc4rn2LshEX8eQ2CSDPI5BLjenR6yBlFW8cI1mqmCEFA
X-Google-Smtp-Source: AGHT+IGKfse31CwUXRo2x680oHkrM5qaCTXfpo8+DsoGb0ka0gsl79UmRl48sUo6m9f/9l2MHoIp8A==
X-Received: by 2002:a05:6512:10d5:b0:512:8f84:c3cf with SMTP id k21-20020a05651210d500b005128f84c3cfmr4589030lfg.1.1708178666273;
        Sat, 17 Feb 2024 06:04:26 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v22-20020a1709061dd600b00a3d8fb05c0csm1006343ejh.86.2024.02.17.06.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 06:04:25 -0800 (PST)
Message-ID: <8567105a2b261b347f8f27620992c89cb9af1984.camel@gmail.com>
Subject: Re: [RFC PATCH v1 02/14] bpf: Process global subprog's exception
 propagation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, David Vernet
 <void@manifault.com>, Tejun Heo <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>,
 Dan Williams <djwillia@vt.edu>,  Rishabh Iyer <rishabh.iyer@epfl.ch>,
 Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Date: Sat, 17 Feb 2024 16:04:24 +0200
In-Reply-To: <CAP01T75=3uN0N5gi+4n93aePdEtQNVZcxuvzMpTSaJbiZBDT0w@mail.gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
	 <20240201042109.1150490-3-memxor@gmail.com>
	 <6bfdc890c49fe4836aa18dcd509c9d3ecc05e26f.camel@gmail.com>
	 <CAP01T75=3uN0N5gi+4n93aePdEtQNVZcxuvzMpTSaJbiZBDT0w@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-16 at 22:50 +0100, Kumar Kartikeya Dwivedi wrote:
[...]

> > Also, did you consider global subprograms that always throw?
> > E.g. do some logging and unconditionally call bpf_throw().
> >=20
>=20
> I have an example for that in the exception test suite, but I will add
> a test for that with lingering references around.

I meant that for some global subprograms it is not necessary to
explore both throwing and non-throwing branches, e.g.:

  void my_throw(void) {
    bpf_printk("oh no, oh no, oh no-no-no-...");
    bpf_throw(0);
  }

  SEC("tp")
  int foo(...) {
    ...
    if (a > 10)
      my_throw();
    ... here 'a' is always <=3D 10 ...
  }

[...]

> > Nit: Maybe move this log entry to do_check?
> >      It would be printed right before returning to do_check() anyways.
> >      Maybe add a log level check?
> >=20
>=20
> Hmm, true. I was actually even considering whether all frame_desc logs
> should also be LOG_LEVEL2?

Right, makes sense.

