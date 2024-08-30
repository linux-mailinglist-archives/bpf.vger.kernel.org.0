Return-Path: <bpf+bounces-38562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF94966639
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 17:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E07BFB2578E
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 15:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085361B790F;
	Fri, 30 Aug 2024 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9vMnkNl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461681B4C49;
	Fri, 30 Aug 2024 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033382; cv=none; b=cEH7kQJl7KwSVTI2llF5elsxzhbgE1DqUpvH1z3ar7IW9maR2agPJDV0nMSNBFBUJLfLTszWXQ6WugChb6rvTgpQ5w9ljfcf9/1h7iYi8UcxsQxxoJ1kW9aPUNHDG58ALkGCJe/6R+zYHGE5kFs7tBF6f2ofVHZsTSpgN54FYO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033382; c=relaxed/simple;
	bh=QrYgyV0VSBODAlhXYGEh3PvrP9UWEOoH6ktO6q/oP8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/uffqeQuck0Lo2rfLALgLbFBf1kNvqqYjS2F0E889Ggky8yaLDEvGTO6cnexloXi2SH+DXG5jUxBzFPdUvTMoqdAioQyUVpvJhLiKfG3n+uzh6OJg4b+fdwUdHseH1NLEgGhgtFzZpFgug71CHKrR6MZCza+413FIKxgN+pkCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9vMnkNl; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d885019558so297062a91.2;
        Fri, 30 Aug 2024 08:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725033380; x=1725638180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrYgyV0VSBODAlhXYGEh3PvrP9UWEOoH6ktO6q/oP8E=;
        b=a9vMnkNllvogR5Emmgf//8X4Y67UycdmuO2qpZr11xn7jMvdEtiHdjqgkyPCKTPPNU
         I37m8oIMHroPIcCkRrzZtAA7nHfeeowSzieKGNkjKpnSmpZZCNIT/uWz5Tj1CybqVpk+
         bWIV1MLtO6DnRatDJaQrIPLUX7IIUt01cQi0/znI5QtTxeKwMCPnnFBeyNAYFAGphVuB
         ZMCSyRMzl0NL4VNwmisMHBAOKsXUAFDDvV/IhIZAbm4NUlVQAja37nZAhECN/dYnplnp
         xFJKHaYG8WO6R1s1MslINgcUjotLSvh29G1vOtK42YGOtIaSHYIC4H3fUl9b6+b0WBOt
         3WAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725033380; x=1725638180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrYgyV0VSBODAlhXYGEh3PvrP9UWEOoH6ktO6q/oP8E=;
        b=Jjkw7ucnt22BlVsf/TgfXicr1pevG5OlZOL+Mwg5OQOSViOxwgZhmfhXlcKHE+bwjx
         N/B4UtdQK7mbSuW4BkH7hQyzcdudE8h7Gp0jBOzO7TXURJ3ED7LPgj8G0e4XRUAKZ6MX
         dEU8R/PAebI6A7sNdi9Xkw+Dx6/rNQ4ej2QduIGv2T1htivbJiai7pzI/utxvNKIZJv3
         73sLfQIGYSxV9aKK37gkPvOnxb1lzPUZ8c9rE2VkjdGYCRK8Bk0B6YyqO4GfeJe1ikMi
         aVDQrSU94u4dq7gQf6T02RrUUdqyMUXjn8r06HJo61j65dPFNFG+Etunzir3S1GhoSER
         vQ0w==
X-Forwarded-Encrypted: i=1; AJvYcCU9XI60UhKeMuxAU+oQFIAO7eYoX22qRPMXLlfp+4lLF6JLtLUae9mvnkhE4jdX4v/UreU=@vger.kernel.org, AJvYcCW/7/n+E5SLqIllTpV261+Z95w9TG4m5rZRj/kItEpV3OQDu0yryByWtEx+Vpe4nJzqWaszHWuf2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwS3WuV01+ZZtTepTsABY7S79Ga+iNDW+9gW4Skbc8wp2+aam65
	r6ZzcqC9+jS/zhft1QcyAntwncK9T1ls1obgGuhjDVuU9X89KumLTz2QbjoylZllRZwbSFf+sBQ
	qEu6FqvmDcJIEtfLGH3Vmb6ZypU5DBw==
X-Google-Smtp-Source: AGHT+IH2Y0zVJrb5G9rbZITwqjCaVcNGLQaOjJw74fLjJdMab1ek/jghItra6O96D/axBYmvbPz1MugcYQiRc6tnvYk=
X-Received: by 2002:a17:90b:4a48:b0:2d3:d09a:630e with SMTP id
 98e67ed59e1d1-2d85617b9e2mr7801384a91.1.1725033380543; Fri, 30 Aug 2024
 08:56:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6358db36c5f68b07873a0a5be2d062b1af5ea5f8.camel@gmail.com>
 <442C7AEC-2919-4307-8700-F7A0B60B5565@fb.com> <322d9bac47bc3732b77cf2cf23d69f2c4665bc36.camel@gmail.com>
 <860fe244-157b-46cf-9b41-ee9fd36f9c1e@oracle.com> <ZtHG9YwwG5kwiRFt@x1>
In-Reply-To: <ZtHG9YwwG5kwiRFt@x1>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Aug 2024 08:56:08 -0700
Message-ID: <CAEf4Bza9OJckdJ4=nask2m+bJsiDszvoLoaf+GhVFu8CNarb=g@mail.gmail.com>
Subject: Re: FYI: CI regression on big-endian arch (s390) after recent pahole changes
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@meta.com>, 
	"dwarves@vger.kernel.org" <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 6:19=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Aug 30, 2024 at 11:05:30AM +0100, Alan Maguire wrote:
> > On 30/08/2024 10:21, Eduard Zingerman wrote:
> > > On Fri, 2024-08-30 at 02:49 +0000, Song Liu wrote:
> > >> With the regression, _both_ .BTF and .BTF.base sections (or at
> > >> least part of these sections) are in little endian for s390:
>
> > > Hi Song,
>
> > > Understood, thank you for clarification and sorry for confusion.
> > > This makes sense because btf__distill_base() generates
> > > two new BTF structures and both need to inherit endianness.
>
> > thanks all for the quick root-cause analysis and proposed fixes!
> > Explicitly checking these cases in the btf_endian selftest is probably
> > worthwhile; I've put together tests that do that for non-native
> > endianness but just noticed you mentioned you're working on tests
> > Eduard. Is that what you had in mind?
>
> > Arnaldo: apologies but I think we'll either need to back out the
> > distilled stuff for 1.28 or have a new libbpf resync that captures the
> > fixes for endian issues once they land. Let me know what works best for
> > you. Thanks!
>
> It was useful, we got it tested more widely and caught this one.
>
> Andrii, what do you think? Can we get a 1.5.1 with this soon so that we
> do a resying in pahole and then release 1.28?

Did you mean 1.4.6? We haven't released v1.5 just yet.

But yes, I'm going to cut a new set of bugfix releases to libbpf
anyways, there is one more skeleton-related fix I have to backport.

So I'll try to review, land, and backport the fix ASAP.


>
> - Arnaldo

