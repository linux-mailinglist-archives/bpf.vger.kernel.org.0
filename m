Return-Path: <bpf+bounces-76800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 882F4CC5C43
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 03:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E9483019BC5
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 02:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AD92749FE;
	Wed, 17 Dec 2025 02:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YEU9wA6q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8188525DAEA
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 02:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765938473; cv=none; b=TgpcOtytze6rrYrf2sXhGzHF2YyiU2nQfDtdcD5II81zI4hvIWcWA+B+uqsW3sTU7RWJWnf7S7W1hRGUKA0z3FX8+y0cs5v4N+GYvQpKJEz+oLeRmqjYaDZaAbwLlNp+iD4wfMqUxm6KiOkaUJTdYm1tx39V+C49BdQA42YhUog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765938473; c=relaxed/simple;
	bh=aT3YEEU97Bca6ddJJYsZgHuzzQOQrZGCUK09PTv3how=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDhwYa9VwUNwPS0t1bgHxASDGVxs7ueKC5P0Tg0bb11V2Z+aLb0hjjW50IYzBn53G+1NOklgc5yXtUh2/t48PZGrtCHi29wg0GgVy9KhJ73MmU9f92uPOOYGwGyyLmtLF8ALHnOhTDi/9Uug4QKJyIwznaLgbiRvC9+tKnV9kd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YEU9wA6q; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c868b197eso3128987a91.2
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 18:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1765938471; x=1766543271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJ8qqeFM12JCYkW9VCcf6IgSGSHtttRCm9XL5An2AGc=;
        b=YEU9wA6q3UHs061zxeDv/0PCeE8z1lv/U2rHGLDRySmvTwqrq5pvfcd84E1o9Lq7Px
         Dx/t1x3k85lgR3FSWBiR/nczfrh+boFW6jzkW3kMtXRyo7SXKla6zK9H/0rigMGn15Wi
         NoTC8r7cEjUIzTtunhwxNSZSqdAjufMjt+7byh7EDanH0KwisDmbUc9tq+Wc04/dZo6t
         /GaxASZALURg9K0MQhIC6ezOOfnT5HsFPLv8VC7wWxWRBV7vrHPDY+ObN0xcG85jU1zw
         HpVejI9LIeCsY399Rci03yOFKDxJijIPfB2thOM5qsal4zDkqvCjh7lJ87obgA9OMA+G
         InCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765938471; x=1766543271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OJ8qqeFM12JCYkW9VCcf6IgSGSHtttRCm9XL5An2AGc=;
        b=sGuW1XQHFpnncj+atQ5HnjCjlpuZK9V7iJFshciWVoIkS61EX/aJMetswIpWUf4gkQ
         XpsbQXb3d7xIicPabHcbl32nrY2K4N/nRJJ/Nh7jDoV2w9ijohsdWW4lm40PqQJSHsaa
         b9EXBIS3PrF4oDag8pBmtsy/INR+05Mbd4uq2vio85ESYCxZkQwaF6BVGfNfdYjyGJks
         ObDY18Y3YkFvVp+dN52FTn0BnYpuN4UCR29Lg2EsOalq/jslwnUd9ffjIcxPMB8xAllq
         w4c1NWfyLTmDedCS/6lLrZfm9tBDhKM58eG2AnNvRHxvPjxAcne+gX6v27S/dHHA1h5f
         j8iA==
X-Forwarded-Encrypted: i=1; AJvYcCX1AVt+I7xG+wMpQWgWntU0lJfN9FBs0VKfpRRzgQTPLKohv326/Hf3YfJtg2SxsV+0lz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyR/X82r0iPtTVFKWc4PQP9uk1iRUpf2i+Xg5itcT1sZm8VQEe
	dR3YIhbI2Z7wmJuNu92WnQrRxbE7cQigADrqNTQEeuJUDDEub+I+yg1wnW2mvWh68fKdmnK+1mr
	VHdxvfS8j8LPiGAdbAtOJuBDVXqqDmWpVb+MUB/QV
X-Gm-Gg: AY/fxX7BgPeaIVTzUK2NSHFFWEKEYnL9FY0lc/L3Rz3nc7sUOgB7a6BnG9Fdna3BcPh
	BaoE9TqPwVRnNs5N84vBfnvsI2XWZXy06etO7LsTrA2CmJms8KDFTlmYXla7IZWAlGqevaLu6S0
	PT9eHPKnPv/iooqP2EoHbnYgG3U1k0OVkto5Ndy9cbv04pinZ6KVHpc+hWbLMhKQbc7HKooeQHy
	BwBVdZ/m5QRyh4K3rJkferJNhnkgb7wMQK/hPsen9OR3Rny/09oNdhUIuv3XxzMTgh0/c8=
X-Google-Smtp-Source: AGHT+IGa5bCdXy2eDFRMiIp85gX1ITVsGZfXkqJXB8XEHuy6HqNMrqN7lOYrjH4FnMPCpV8UuGH4zqOEanO4V2Ai+Y0=
X-Received: by 2002:a17:90b:3911:b0:339:d03e:2a11 with SMTP id
 98e67ed59e1d1-34abd6e022bmr15611483a91.14.1765938470689; Tue, 16 Dec 2025
 18:27:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHtS32-Zh3knxSdR=DUqQH4rX4QU8ewgu+KHGq6Af3qs9S0FAg@mail.gmail.com>
In-Reply-To: <CAHtS32-Zh3knxSdR=DUqQH4rX4QU8ewgu+KHGq6Af3qs9S0FAg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 16 Dec 2025 21:27:39 -0500
X-Gm-Features: AQt7F2qprIYE6-HyVMTHleBbF-N1q77Ba2A-srAgPQlDo2gt1smd-xuGCyFzwz0
Message-ID: <CAHC9VhQ4=ALurNy_nBdqmdQ1dguupPnJ6KYAnU7B2UWhp9ydbA@mail.gmail.com>
Subject: Re: [RFC 00/11] Reintroduce Hornet LSM
To: ryan foster <foster.ryan.r@gmail.com>
Cc: bboscaccy@linux.microsoft.com, James.Bottomley@hansenpartnership.com, 
	akpm@linux-foundation.org, bpf@vger.kernel.org, corbet@lwn.net, 
	dhowells@redhat.com, gnoack@google.com, jmorris@namei.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux@treblig.org, mic@digikod.net, 
	serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 12:26=E2=80=AFPM ryan foster <foster.ryan.r@gmail.c=
om> wrote:
>
> Hi all,
>
> I want to confirm I understand the current semantics, and specific issues=
 this series is addressing.

I don't want to speak for Blaise (or James for that matter), but my
understanding is that Hornet is focused on ensuring BPF program
integrity at load time; similar to KP's signature scheme which has
recently found its way into Linus tree.  Where KP's and Blaise's
scheme differ is in how they perform the integrity checks.

--=20
paul-moore.com

