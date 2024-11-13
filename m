Return-Path: <bpf+bounces-44776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B4F9C7821
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 17:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8116128183D
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 16:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB55152165;
	Wed, 13 Nov 2024 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViMH1/P7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423E641C92
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513792; cv=none; b=NYWK8Ocrum9hNWgSYmB5Zw0frIEBXShLz44qyMGx3zA3CQ7voWKjB8hsL9Z+WTR4KHfmKjsWSVHxAXYMyG3CgAWYtjl2crpPbMhgaIzOPpP32S4udaT4hTxfxwfujV7Pn6ju7blv2vQl+uUjPcU2sdwNzobunD9tq3HKs5rGRRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513792; c=relaxed/simple;
	bh=C9zc3AleJMuES/54RnyDz0hf6zT1rVPw5NVeyqTQW+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkuMIyN6IKkYI1Y+Iu4Ye+SmHfTlvUZ2YVDI5vHlPqWTx+5PojuumssD7t3cy87PcWmYyB5OKO4U9nmF6c3JNG3Lr8X4zOizsWhUL4V1ezxVfkBe2e/NfvDMlKNDc+yDeI0tsZBfPWXQ+b/LoXl4hbzIX0v5/2WjxBXOVO0kTJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViMH1/P7; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5cf71986b67so559368a12.2
        for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 08:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731513789; x=1732118589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C9zc3AleJMuES/54RnyDz0hf6zT1rVPw5NVeyqTQW+8=;
        b=ViMH1/P7nYvXkaeuAzv1ctvL4NSJw0KnQ3kuaiNEyAevzpyKvKiWmfn44z+flwZStm
         eUnV87fOEKLCP5x+l3sqFV5U0AQmC6+334saQHymmTTffXhleGdB2YakOZ6cRKi1vH+5
         rde0nYQnFLyUkjClNnP/xEskOQvRWN0dOFw/pAsBRCpaqllwj+S1Aul5CBMiyeh5RVdj
         yzYU6eUWapLdJnSNXXrnLzWjLUAzHOavKJbC7l5WpzXqe/lLf7pB2mc0MqfCUtBi9nbF
         VuNOuSzvaIwnScFfXKttVy//uuhUJGIdwiIhgMQVGYGJRrowkcIRXfLmlYMKFDLP+9FX
         V5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731513789; x=1732118589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9zc3AleJMuES/54RnyDz0hf6zT1rVPw5NVeyqTQW+8=;
        b=lag4KQYAW3bi8e5RvNFzh1rXSVot1y9pwiXSSrqXjpI5xDDdwBBuXpQc98FeKWHVRf
         jCuHwBqOmaLJ0YHcDkavmTj4Cqk+pixpIuVV37EzQh7ARWFgmaGD35PScCF04GpBYQ/s
         H3PQqwJaYSeNpmWtaVVFrEkc0AVz46fRTkNVXDp/XifwP3AjN9Qf7z5zLx302FP1ta8D
         7dRZmlT6pSaBIDGuJMtJF7a0gu5yEk4WH/lKF+ijWJblYP5Uq4zqCDHB07uCT9e7U3lX
         /MY0ieNLU1FoQ+hcmIjFFYEl8kkwxMpiEHYYE4ruyUDweJHP3eDHxv1YERomwmGIIMr3
         onTw==
X-Gm-Message-State: AOJu0YzlWhHFRhy4dgeDNsWTomOe1oApy3KULU48MCEeegDU/1sE1bd+
	bucp2cEItXKh1NmJdBFJI4FJPqCiif5MVk9jgDdGypvXnidqIyC0PZ2KYFIfwca9lxu5o9Rlcwr
	SvkUlWuM4mxg2zuhEgLTbMxdz/P0=
X-Google-Smtp-Source: AGHT+IEOXHZIsEwxAlV25+wqRPWy5CHf40b1LdeZnlCDGAXLFMrHRlVB+H7L366EaoKGeiIMMOaSpImtJUZI1iqnQ3Q=
X-Received: by 2002:a05:6402:2355:b0:5c9:8a75:a707 with SMTP id
 4fb4d7f45d1cf-5cf0a306754mr15454663a12.2.1731513788863; Wed, 13 Nov 2024
 08:03:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108025616.17625-1-alexei.starovoitov@gmail.com> <20241108025616.17625-2-alexei.starovoitov@gmail.com>
In-Reply-To: <20241108025616.17625-2-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 13 Nov 2024 17:02:32 +0100
Message-ID: <CAP01T76DpS=0RN-_ORPMR4qd6hn=dGgH6DXxGcsb9kGbYpHu3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Introduce range_tree data structure and
 use it in bpf arena
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, eddyz87@gmail.com, djwong@kernel.org, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Nov 2024 at 03:56, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Introduce range_tree data structure and use it in bpf arena to track
> ranges of allocated pages. range_tree is a large bitmap that is
> implemented as interval tree plus rbtree. The contiguous sequence of
> bits represents unallocated pages.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

