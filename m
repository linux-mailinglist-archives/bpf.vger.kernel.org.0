Return-Path: <bpf+bounces-14815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9987E871D
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 01:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9421C209BB
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 00:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032141C03;
	Sat, 11 Nov 2023 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax97m84N"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9631865
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 00:57:49 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16732422D
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 16:57:48 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507a62d4788so3709311e87.0
        for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 16:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699664266; x=1700269066; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uTuRCiDx0ct23JSLHY9QCqPamFJvjOvjczrSWTWzO0A=;
        b=ax97m84NFzfwEL1rScepcbmUIvNkTmr2drFAL3jhH6twTkbYHZNLcG2PsE1Ic9ArB2
         CAj8fXGDVQWOAtEBvHUIGiEVMivnZLy1YslOVeIev7wdU6KIE2h95p9SRe/g1Zp5VulM
         aAzRLyLoHUFb2lE/+Gm6TzpcMpLvXL8wfJAtDt2XVw2KoSKohtrR+TwBsk6qQoSKI69a
         j+n0USW4a2qsrjeEkTWdFJkXqux5uj04YaFONO6DBAEXJDi+kHikLnHSHXn5g21I0MtG
         COZ01QCYt5E+SUi7ni5LIkBpKM48S1jFLUKui3mcKIk+kXZ0A0ECkSaJx0FzmCSmimAH
         lPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699664266; x=1700269066;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTuRCiDx0ct23JSLHY9QCqPamFJvjOvjczrSWTWzO0A=;
        b=psePTB38L269nQ7s3mhxa6ar0ONcriyBPPeSDbFDjKjxfd7uAZrNA7RJ0fqdc4Y3CM
         HHnTnksfCYApWmFFnYI0DUd8FfH2B9HjgpcqpMncHhphoW+Hc6XHgrYwV2f3ivt1tcC6
         QRNJWfKMEo8V1CHjdeqH+zrGbfFAJdv/NZi/Y/9QC6nGZ22aUQmFN2krydWP6S6GqsO+
         RdKqSzH9xBOcnJsQjaJpgtH73Nu+cEy0SwJqJtAhgj0QrHllHcq7O/Zh+6ojZGJzkcY0
         aMj/bN9Tqk6eZi7cxwZAsJnHLsPS34CoHjj2FOrHotDNhLEdrIhNC+wo7R05AcfFQHxM
         IOyQ==
X-Gm-Message-State: AOJu0Ywp8GnAMgKmXIhIG6j7c8Kp9CopwoabMBJqZlPU6Y/sOOmg5t6/
	erSkJwvY1EmIkV9XVny+9jw=
X-Google-Smtp-Source: AGHT+IHj3/Gjny9KQ7Dva2fsyLvwYNrLErzjKeui7k/f+wF9hz540ZPRss+rGQvJafwqWuhrftc3YQ==
X-Received: by 2002:a05:6512:48d9:b0:4fe:7e7f:1328 with SMTP id er25-20020a05651248d900b004fe7e7f1328mr438791lfb.16.1699664266035;
        Fri, 10 Nov 2023 16:57:46 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b4-20020a50b404000000b005438ce5bf80sm283815edh.20.2023.11.10.16.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 16:57:45 -0800 (PST)
Message-ID: <5ed2b9c9cd53d5d4718516c890437df1d8ef8381.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/8] BPF verifier log improvements
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Sat, 11 Nov 2023 02:57:44 +0200
In-Reply-To: <20231110161057.1943534-1-andrii@kernel.org>
References: <20231110161057.1943534-1-andrii@kernel.org>
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

On Fri, 2023-11-10 at 08:10 -0800, Andrii Nakryiko wrote:
[...]
> Patch #8 prints frame number for PTR_TO_CTX registers, if that frame is
> different from the "current" one. This removes ambiguity and confusion,
> especially in complicated cases with multiple subprogs passing around
> pointers.
>=20
> Andrii Nakryiko (8):
>   bpf: move verbose_linfo() into kernel/bpf/log.c
>   bpf: move verifier state printing code to kernel/bpf/log.c
>   bpf: extract register state printing
>   bpf: print spilled register state in stack slot
>   bpf: emit map name in register state if applicable and available
>   bpf: omit default off=3D0 and imm=3D0 in register state log
>   bpf: smarter verifier log number printing logic
>   bpf: emit frameno for PTR_TO_STACK regs if it differs from current one

This should be very handy, at-least for verifier development.
Acked-by: Eduard Zingerman <eddyz87@gmail.com>

