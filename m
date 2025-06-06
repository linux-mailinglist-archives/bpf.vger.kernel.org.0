Return-Path: <bpf+bounces-59829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63638ACFB59
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 04:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43D51899925
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 02:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A111DC198;
	Fri,  6 Jun 2025 02:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geX0d7vn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66071DFCE;
	Fri,  6 Jun 2025 02:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749177936; cv=none; b=X5AgWD9s6CIIhiHIqgDq5J+tM4LoDWl23989zVVXc62CBVwj/nNQ+RC/hOXYD5KfivrNyNDXG6RNsB+NE+yrgs3GVbe9pvq9JbQPw890xrClngVtLYaJ8EfCElyObu0iAi8eYKqKhLizLR+ONXDJ0bLTu6EBTBhTMxbCxe6XzdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749177936; c=relaxed/simple;
	bh=s01/9I6xaHEczQ9P9s3Zx/2EXKrtSJYsyQN791Ysq2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPrFJqwGYTANQXiWrVHg1JPfamEDk1yXzlN20eyrFFMsF+G0KOWHvZ8q12h+nCvwG62JaA4Mceb1VzVIADtYtBZWafAaYYF2mGAxmhSUkeAhGEnFJXwA3+gHbC0IA3/D5noHyKBhewdqteettkYujiORAakKURSfRxuzQq1cx08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geX0d7vn; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso1311549a12.3;
        Thu, 05 Jun 2025 19:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749177934; x=1749782734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5hXIFK95RelvZfB3lVGSZbjvbap3HklSJfL2XOUh65I=;
        b=geX0d7vnH6X+2lgj83vvofIOHZutypMWUIknfbAb3/e2sCoYyEYcyahaLKU9DZw8U4
         swu6rbDcYT/wltHq01iuLSbbqUiyxWIlp78x4Bfbsyk5ayg2I0ZruK4+noFVCDOje5Fc
         fP3oPQWNzPmkaxKlHS+KMRoaNt+mcB/Wuv27WU9gz71XBc9PzCMnMEM0TWXjAgiqzC1b
         A9FhijkGuHayBSabnj8OmV3LdD7iYpcBxVITgp76OKEG4p8oYa+Nwu2W+FmJRh2FS3Ms
         8A3yc8BSe4tXE2U6un0+TQCb6Z81QHZgwwFmKJTn6ZXO0VcF0W9+dcZaQxpjqR9Cdjaa
         UU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749177934; x=1749782734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hXIFK95RelvZfB3lVGSZbjvbap3HklSJfL2XOUh65I=;
        b=K9N9KKz0YGnheeWsH6tBu5Yf/bIoZVIC3LzEh0YcnxlX0mtDKRyqoAb3YLqke+0RR9
         +uictPwenU1IoKPVcBJw8na4XaYI+hxqFd8YUiRZ50J9XysLNpp6xGBlGF+F5IqK5Re+
         7sst+gSr4aJITOh+nTCzNXZHCBNzPR7n0dtAUmayqfzYlLCojh1rUH9l2i8AwOJOCnp/
         PCS+twPqqhfrekaJkjsKbnPwsUYGVS5SbKN3M1ZiVkJ/tP9BqOCCnC/RZ+2+Ryibiecl
         qU+kUBEF//ekphmgvRAryr7kipV0AtyNm3iB0HH7BiOoKGHMCr7UfpKML0IvHfNIF8cg
         THNA==
X-Forwarded-Encrypted: i=1; AJvYcCXR1dlg6DoNJQzDqZR6tOvXuLHWACLIqb7XW981qaEiiYv19AzgmApSy7gHzBGzYsNggZrbujk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQYTm5BR0fUUDXadWVVJmWR06fEd4HD4iVGXidRiBv/y9ET108
	Qo8XUaDC5CKp35FDMLELU+O05EnzqY85ZFB9yhX4PUPq8tT5m/mhnjNRAUr4
X-Gm-Gg: ASbGncsvJxWWJq7NbW5A+7LrpV4dWVX0uzZV41xfQT4XUX41LCEaJ0WUL1EXpL7nyTQ
	Id0mRNVrDJ78UzWqqx3Pik6FYY1p+jMP+gnQzxrPOgqumhqOVMkpp3BhGob8j6neF+zQas6oM+r
	uKsX0MnbWxL+qguTlQ7ZdW4Q62dxdKhDTpmL4UrhlTRyAmXb+2N8n8gRm5usS6nCwkDaT2FPNQX
	gFdHuymsJ/W4OkQA97MRLaLUV0jN70KzCT2Mt+5zwIHJoqV/sJGT8uc9up8sdjjvK1s65iGrSnt
	BJqs+46AzCtADgM1UMLOuqZ6QuDe7rPei33RbQ/dKlsoFUwxW9BQ2hHKQH0tKJWoKEhkTr8pT/C
	V8mIU5ORKhwkt
X-Google-Smtp-Source: AGHT+IG4s0cvudn/AcHpm1PTcfR2KrvkcBjyekd73ntcClqE5x4OR6w2VPEHrRbBxFNsR9j5aaKXBA==
X-Received: by 2002:a17:902:c952:b0:234:ba37:87b0 with SMTP id d9443c01a7336-23601e44ebbmr17859995ad.13.1749177934131;
        Thu, 05 Jun 2025 19:45:34 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23603078957sm2884315ad.41.2025.06.05.19.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 19:45:33 -0700 (PDT)
Date: Thu, 5 Jun 2025 19:45:32 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, lorenzo@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <borkmann@iogearbox.net>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
	kernel-team@cloudflare.com, arthur@arthurfabre.com,
	jakub@cloudflare.com
Subject: Re: [PATCH bpf-next V1 7/7] net: xdp: update documentation for
 xdp-rx-metadata.rst
Message-ID: <aEJWTPdaVmlIYyKC@mini-arch>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897279518.1677018.5982630277641723936.stgit@firesoul>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174897279518.1677018.5982630277641723936.stgit@firesoul>

On 06/03, Jesper Dangaard Brouer wrote:
> Update the documentation[1] based on the changes in this patchset.
> 
> [1] https://docs.kernel.org/networking/xdp-rx-metadata.html
> 
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>  Documentation/networking/xdp-rx-metadata.rst |   74 ++++++++++++++++++++------
>  net/core/xdp.c                               |   32 +++++++++++
>  2 files changed, 90 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> index a6e0ece18be5..2c54208e4f7e 100644
> --- a/Documentation/networking/xdp-rx-metadata.rst
> +++ b/Documentation/networking/xdp-rx-metadata.rst
> @@ -90,22 +90,64 @@ the ``data_meta`` pointer.
>  In the future, we'd like to support a case where an XDP program
>  can override some of the metadata used for building ``skbs``.
>  
> -bpf_redirect_map
> -================
> -
> -``bpf_redirect_map`` can redirect the frame to a different device.
> -Some devices (like virtual ethernet links) support running a second XDP
> -program after the redirect. However, the final consumer doesn't have
> -access to the original hardware descriptor and can't access any of
> -the original metadata. The same applies to XDP programs installed
> -into devmaps and cpumaps.
> -
> -This means that for redirected packets only custom metadata is
> -currently supported, which has to be prepared by the initial XDP program
> -before redirect. If the frame is eventually passed to the kernel, the
> -``skb`` created from such a frame won't have any hardware metadata populated
> -in its ``skb``. If such a packet is later redirected into an ``XSK``,
> -that will also only have access to the custom metadata.
> +XDP_REDIRECT
> +============
> +
> +The ``XDP_REDIRECT`` action forwards an XDP frame to another net device or a CPU
> +(via cpumap/devmap) for further processing. It is invoked using BPF helpers like
> +``bpf_redirect_map()`` or ``bpf_redirect()``.  When an XDP frame is redirected,
> +the recipient (e.g., an XDP program on a veth device, or the kernel stack via
> +cpumap) loses direct access to the original NIC's hardware descriptor and thus
> +its hardware metadata
> +
> +By default, this loss of access means that if an ``xdp_frame`` is redirected and
> +then converted to an ``skb``, its ``skb`` fields for hardware-derived metadata
> +(like ``skb->hash`` or VLAN info) are not populated from the original
> +packet. This can impact features like Generic Receive Offload (GRO).  While XDP
> +programs can manually save custom data (e.g., using ``bpf_xdp_adjust_meta()``),
> +propagating specific *hardware* RX hints to ``skb`` creation requires using the
> +kfuncs described below.
> +
> +To enable propagating selected hardware RX hints, store BPF kfuncs allow an
> +XDP program on the initial NIC to read these hints and then explicitly
> +*store* them. The kfuncs place this metadata in locations associated with
> +the XDP packet buffer, making it available if an ``skb`` is later built or
> +the frame is otherwise processed. For instance, RX hash and VLAN tags are
> +stored within the XDP frame's addressable headroom, while RX timestamps are
> +typically written to an area corresponding to ``skb_shared_info``.
> +
> +**Crucially, the BPF programmer must call these "store" kfuncs to save the
> +desired hardware hints for propagation.** The system does not do this
> +automatically. The NIC driver is responsible for ensuring sufficient headroom is
> +available; kfuncs may return ``-ENOSPC`` if space is inadequate for storing
> +these hints.

Why not have a new flag for bpf_redirect that transparently stores all
available metadata? If you care only about the redirect -> skb case.
Might give us more wiggle room in the future to make it work with
traits.

