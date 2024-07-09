Return-Path: <bpf+bounces-34301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A6D92C547
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 23:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634F61F232EF
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 21:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA07182A58;
	Tue,  9 Jul 2024 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baEQPdwd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906D3153505
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720560255; cv=none; b=ic3woSpS542pWCx0GXhMGE2+u4DqzCk7HCOiIHg37eLXuFn1H/+h5zyI1Jc9siqFyCa0IDPCwtzbojt4VANcYIWmfcK40SImyR4XXWq7SpPEV1qZ/gAKU6AWu+IRqty5iPyFAMR9GiNCcgfEehomoxKOw4TU+kZRIujuwlRDWP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720560255; c=relaxed/simple;
	bh=GZx+oixWwjX+KBVSqNA+5IcQxtvk9Q97JooqlJyJd74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDKJoUoBb3d17CEN7WAdOJFyA/Zwau17UfGDZW8DssfAQgLqK/0/928mwZXngcdKRV0HWRH6XZdP7b/0HmSSbAeWcBmxN/Fua8D3JDBSGdJ0jxumyhFWA6zkhUpL8VwLmhorovAh1M+pOigS3rv409jNEmnbjeZS0kjA1VTRP3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baEQPdwd; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so81641641fa.0
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 14:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720560252; x=1721165052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GZx+oixWwjX+KBVSqNA+5IcQxtvk9Q97JooqlJyJd74=;
        b=baEQPdwd0I9v5QHozckb/SC2m/eLEHD8y749T0SHaeU3NdhRupHBz6VFcnMBA7Yjtm
         oCFSkVi1Ty/8YNsEwLsCKWo9sPNVBUGy/vhbDE2RxSoo6h3pJ3vHVZaPt6r+ABigY8sd
         rQ/fOUz4QY9+vyEkxXlmfY8Sx+T6d6ZWDLD1U6CiGL4LQpiyzTsywXLfIHlDQ+TutDhX
         81TtvrY+BI0PTYvy5zUdUI4R/KZGReltmm+ss6/FYJPd/3AlqLnNnFp/6N1FrfreWpdf
         5ISNFgOgKbFVWyYPOwEfgDTboBqKpwu59qrkBeJhYTpZdDGyEyaiZlyxgQ8jA8tXRy1Y
         qxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720560252; x=1721165052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZx+oixWwjX+KBVSqNA+5IcQxtvk9Q97JooqlJyJd74=;
        b=FUxbzXLfJXTmYOsXsN1sbsOXboegp1H4PlaCldFloaqZ2n/90fw1mK02wqimtN/KUU
         ntW9aGHQtsq+4Gu2eFbxvxP8oJm+f1mQ4ZmCJUl5twbptIFSsIfHcpYIIWHRvdxqljrz
         fPWZufIg6dP6iZvP7yKm0CwSIkZCcRLfLFN/G2YFj4s3GwTrAdGopqQOELo+Rhg/pEdI
         fFAFB24mVmt5UjdlADztahZADRIWk+KVEcIgq+N2+TRYwt6nM+lYWp+kBeU4/b8R1REm
         qWffnprZdg4DTaNLEYPZng9RXN4142lqB1FbH6w5F1U0uunKXLCxoncr6VsCMvSpmYw1
         2ujw==
X-Gm-Message-State: AOJu0YzTfsjHzIEnRENuubiynewZnn7yBIKsa0XjpgsH6HTKIv621/GU
	XwXhhOY4cHqOsrxHX4jDtrxdXIx02c2Ymuv/yN3vFoj/paH22pzm5cWFuyz/jhX5rH9hTV7eW/H
	yApDRdMN15aYE1P7JUkhmZnPTCJE=
X-Google-Smtp-Source: AGHT+IEMXvR1Ad4HlQEMRhyNV2sJQxbDmeolUtcVMkjBRDxv1QYw4vKf4BKbhv7k6AENSmoZXNT1yhdmDGAU9yqDq1c=
X-Received: by 2002:a2e:a316:0:b0:2ec:5945:62e9 with SMTP id
 38308e7fff4ca-2eeb316b47bmr27533761fa.32.1720560251555; Tue, 09 Jul 2024
 14:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709210939.1544011-1-mattbobrowski@google.com>
In-Reply-To: <20240709210939.1544011-1-mattbobrowski@google.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 9 Jul 2024 23:23:34 +0200
Message-ID: <CAP01T77XeZBAY6KJJcKexw=EKRLrcsnmigb8B9D0Cv8Z2KcRfw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: relax zero fixed offset constraint on KF_TRUSTED_ARGS/KF_RCU
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 23:09, Matt Bobrowski <mattbobrowski@google.com> wrote:
>
> Currently, BPF kfuncs which accept trusted pointer arguments
> i.e. those flagged as KF_TRUSTED_ARGS, KF_RCU, or KF_RELEASE, all
> require an original/unmodified trusted pointer argument to be supplied
> to them. By original/unmodified, it means that the backing register
> holding the trusted pointer argument that is to be supplied to the BPF
> kfunc must have its fixed offset set to zero, or else the BPF verifier
> will outright reject the BPF program load. However, this zero fixed
> offset constraint that is currently enforced by the BPF verifier onto
> BPF kfuncs specifically flagged to accept KF_TRUSTED_ARGS or KF_RCU
> trusted pointer arguments is rather unnecessary, and can limit their
> usability in practice. Specifically, it completely eliminates the
> possibility of constructing a derived trusted pointer from an original
> trusted pointer. To put it simply, a derived pointer is a pointer
> which points to one of the nested member fields of the object being
> pointed to by the original trusted pointer.
>
> This patch relaxes the zero fixed offset constraint that is enforced
> upon BPF kfuncs which specifically accept KF_TRUSTED_ARGS, or KF_RCU
> arguments. Although, the zero fixed offset constraint technically also
> applies to BPF kfuncs accepting KF_RELEASE arguments, relaxing this
> constraint for such BPF kfuncs has subtle and unwanted
> side-effects. This was discovered by experimenting a little further
> with an initial version of this patch series [0]. The primary issue
> with relaxing the zero fixed offset constraint on BPF kfuncs accepting
> KF_RELEASE arguments is that it'd would open up the opportunity for
> BPF programs to supply both trusted pointers and derived trusted
> pointers to them. For KF_RELEASE BPF kfuncs specifically, this could
> be problematic as resources associated with the backing pointer could
> be released by the backing BPF kfunc and cause instabilities for the
> rest of the kernel.
>
> With this new fixed offset semantic in-place for BPF kfuncs accepting
> KF_TRUSTED_ARGS and KF_RCU arguments, we now have more flexibility
> when it comes to the BPF kfuncs that we're able to introduce moving
> forward.
>
> Early discussions covering the possibility of relaxing the zero fixed
> offset constraint can be found using the link below. This will provide
> more context on where all this has stemmed from [1].
>
> Notably, pre-existing tests have been updated such that they provide
> coverage for the updated zero fixed offset
> functionality. Specifically, the nested offset test was converted from
> a negative to positive test as it was already designed to assert zero
> fixed offset semantics of a KF_TRUSTED_ARGS BPF kfunc.
>
> [0] https://lore.kernel.org/bpf/ZnA9ndnXKtHOuYMe@google.com/
> [1] https://lore.kernel.org/bpf/ZhkbrM55MKQ0KeIV@google.com/
>
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Though I'm not sure this is bpf material since it isn't a fix, it
might be better to base it against bpf-next.

