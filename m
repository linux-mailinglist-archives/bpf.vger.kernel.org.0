Return-Path: <bpf+bounces-64267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68BFB10CBF
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 16:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE60AC488E
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 14:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A671A2E0B6E;
	Thu, 24 Jul 2025 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBr88x7T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0A7254844
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365820; cv=none; b=JsFo2PuRHRuVE+ZHLi92XrECZf9l42X+wV3on+vRDHnR7hiLFqnk3WK96fhwnX610MhdSKVLMqKvSrffAbSZ62hZ5GLrz9J5KhH8Sl7wktXK+rsr8EHmcdQe9Ys/8nNQWd2d3xFLONk5BINuKq7/Y+ykwSssYbvhG64czL2spaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365820; c=relaxed/simple;
	bh=0VIikj3yIUFdsJdgzNjAyqK7TQm1VH72hppv76TmtKI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHK8tDL3X5bZfTzarp8hCIqOC4NKaQeiNf95M/tmxiqDofg0fsMNEvLGxZqeYtL/wAqMAl7k1s4uVAM0LYEm4MSF7ZL54bStzd4mWupCb1hwXcbNQ/YTFfJn+bshEwZhgPE5iGjCm1WpdNgHnQlHJy0hgxQXppmDg3F+X2aGX1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBr88x7T; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45619d70c72so18211705e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 07:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753365817; x=1753970617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0VIikj3yIUFdsJdgzNjAyqK7TQm1VH72hppv76TmtKI=;
        b=OBr88x7TF6rOKHmBmEEo6qC1X1d8v/6fuX6A419sMaQ+6KQ5bFOAT5KZThZ1dBlONn
         SGzrbig1ndPan1uiHKq9hVUvE654b9WMpNoLCriirIhPKOZEhfmo9sJLGwcAF4BZAhp+
         yZESH5XfySzx3+ehZdzIaHV1c0x18Bd9x1FWntuzU8ESLLQg04PjLBDBTGlpfI+sl7gt
         EuRvQFp/JnwczbOC/yzt97x54xUA3dqf+lvqAvzoonKO2EddWvgwRH3UdY8ZBHTPZcEK
         FPuXppbl8p46+73zEkqFgWlaNN0pDZLMsfWqngQplPUa2BB7ATQyA0Y2lmUhebgHU7Ma
         A8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365817; x=1753970617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VIikj3yIUFdsJdgzNjAyqK7TQm1VH72hppv76TmtKI=;
        b=Ah99hriDKjtfGI8iCQmU2h76kkPLsr3/yfXlr1OHL7C+Q3209x/5VeOKfV6dddhsmf
         jBcePDSlZCmGHA2nTj361SfG6KT+9wC2bH1QjCalM9We+GGgwrgwwfAYkLDusllz/9t6
         vKCBFVGseXrUVnxHb37rhg5Q32eSv+F9NBdk6+4AuLLCQnJ++gye6aZosq5iepRC/iwn
         RmS68rYAgVHvpQWir4f2AO7Qt2p1KUficnLKvJTIRc7uZAeiU9YwQDpCV6BOEzSEXR75
         3ygYQMb5i3xbqhcQUbIFn1RoMBnkdJKKW9zNGXA/gVOQL+/1Wxnz+rgTEWNcUG4CxIm1
         Zjcg==
X-Gm-Message-State: AOJu0YwpXwXKZF6vT/dxRUCbOnquZO1ZZDLrXlfuo5SHcKkzBoyQcE3c
	5sTgMhS+4s5eaWGgTtsJfgnoo59XejNveh38lNGx/GYrvYSkdBbIIRo2
X-Gm-Gg: ASbGncvr/VSyoh37RV0k0Sb7HDbFjqOeGl2c7l2RpXlnDJUOg2ry+FPZMoryzg1XdPj
	EkXUEoQqkwbzJwVY7p1fAM/+3KXAn99iLzfKDmPEuEGBndd9wlTFHe25fuUzKqspjx/ZLSG3PuQ
	gx9mX5W19AirwpvogiWm/PrIixLQlxaIbsGLfGTGcvRsTH2VdE5R1jLQdEv7rAeW1WvWisYwTt7
	RAxQ4psSca8RDgUrIf0mnkSrpak5KaRCSpA94wJM+VybzQRCtjReIvYBv/OCRKIxBuB8iTZx+o8
	TqulKeNPm24IxvL6JkeoV4LEsXini6vavSVhN8B16EuAn9raKnFtHFf0m+cFat8pXHhOnY0iLq0
	Jy3T5Nwl+U02Q/cM2MPeS27M2Kw+DRVrXOfltXFLygKkTC8oECNozpJK27JCIVHfjo/+G3SVPUp
	78npcxgeUNkd8E5Q==
X-Google-Smtp-Source: AGHT+IEzK9ndi7Z+A0TqmpDYLtMTRLT1Js20eu4ZO01cw36jVYxaXGbVDcZ3bgM/8l+SAoMSfu1qtQ==
X-Received: by 2002:a05:600c:8b72:b0:455:efd7:17dc with SMTP id 5b1f17b1804b1-4587057590dmr21980555e9.11.1753365816416;
        Thu, 24 Jul 2025 07:03:36 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00667e58c39c19dc02.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:667e:58c3:9c19:dc02])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054f27dsm21364575e9.11.2025.07.24.07.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 07:03:35 -0700 (PDT)
From: Paul Chaignon <paul.chaignon@gmail.com>
X-Google-Original-From: Paul Chaignon <paul.chaignon@.com>
Date: Thu, 24 Jul 2025 16:03:34 +0200
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: Test cross-sign 64bits range
 refinement
Message-ID: <aII9NupeihYc0xHj@mail.gmail.com>
References: <cover.1752934170.git.paul.chaignon@gmail.com>
 <7cf24829f55fac6eee2b43e09e78fc03f443c8e5.1752934170.git.paul.chaignon@gmail.com>
 <755dfeb5b02a1d3b5dd8b87a5aeb822628a93996.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <755dfeb5b02a1d3b5dd8b87a5aeb822628a93996.camel@gmail.com>

On Mon, Jul 21, 2025 at 02:30:07PM -0700, Eduard Zingerman wrote:
> On Sat, 2025-07-19 at 16:23 +0200, Paul Chaignon wrote:

[...]

> I think two more test cases are needed:
> - when intersection is on the other side of the interval;
> - when signed and unsigned intervals overlap in two places.

Thanks for the review! I've added the two new tests in the v2, along
with appropriate __msg checks. I also made sure the tests fail as
expected without the first patch improving range refinement.


