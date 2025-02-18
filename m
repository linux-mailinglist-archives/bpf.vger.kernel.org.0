Return-Path: <bpf+bounces-51859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB74A3A721
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 20:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43EE23ADDAC
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 19:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC4021B9F4;
	Tue, 18 Feb 2025 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfnhWYds"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF62121B9F3;
	Tue, 18 Feb 2025 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905786; cv=none; b=XinPlZbcAGsCAqx8JjEWXxuyYhry1j7b4CWuiKGvMkH5Hi/Yz+9tx+GhpWOJB68W9WFuta2hqbMl1CsCuOOcEZDpFcKYNMxfr9TTFGRA9wnP5EPBweDcYe0Cd/BNyicYt2mtbabgsavqdaO4hwkI36XRzchpJ3nlWUdm2S7MjLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905786; c=relaxed/simple;
	bh=MKRpg20GW51A8TO6MgkFLj5LD4O/ElF77sV3bubJAfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4XWPaHH7wIgx5Q9z7ZgQGrVMKOt3AEWSrQwiEegHVJROrV8oN4hGwdWisqMButTXkUjAjG2KocxcgYjEmLdnEDlxLa6EeFjcEU+AIsT+NHSeOwCSxTPHMY8Qt7WbdQ9KhyYcphrDB61UjzcQFAjUWe12UEaw90O7r7Hjq8FNOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfnhWYds; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220c2a87378so83445725ad.1;
        Tue, 18 Feb 2025 11:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739905784; x=1740510584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BB41eKE33tD6ZlxR2QuIN+D2oIaS7wnfJEtztipPSK4=;
        b=MfnhWYds0qNI3aJNRXeZ9bhssOY4/b3On/bQMysu1CXRCrvsEW6o5Km4LbS8TpLq/a
         q4tN+LPJ8vczM9eliRwYUxuwhK5YdkzUbRetOw9L3DwLbToL1UeUVfgSBbaD1u+exVwp
         bYifpI6hxazA+AmcPOlPg1+WMA5b3M0XOq95l9fh/aBLizTQPyVhOpjz9sDWwiP7BinB
         7H7WO4YiYS7UejpSKGkIZInHdVqbbwY1L7WKp1TZKzkMJrdN4F+ZSkfMPR4/C3FaOec6
         oK2mmsvZxyPjs2JpzvV64UZZhUTb5jfmEXUkUW/G75mpJhvUV+SOckciEn5BChMbCRQX
         46DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739905784; x=1740510584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB41eKE33tD6ZlxR2QuIN+D2oIaS7wnfJEtztipPSK4=;
        b=ZQzMLXJgjuKf+Czfr/0JSzDmvxEw2+SfPEATQdMz4DMybLonL32TtgUw4bbWyBKafY
         p1b4MozA2NwkDzeGUXl0hcTkfyoqq0BNo6dn52y8OOPwRDE4ClYywttJ7SZd1frxplfV
         5O7SIxI7kiaa49+3vakUkqCVn7zC1GiGtM7HH83lwCowdr1CkZUS0IPyK891IGgFpxeT
         DnMfBtUTbcfZZ0AN2GaH1bZGvMxsfztmbHcjwMP7hus+dlk6GD+qyfd/TwIGy/nurbwV
         i3A4/Ej/JEvzDIzZ1M3tR0SEdVrQpSbQ6D5T2gxGXZ4pp0lcNRXXfq8m83mVnGxeCua7
         XmgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4jtwSFx9f9/j7SYypGKF0F0FuheR0hmrsXGzPd+D//Js9ODZ3gs6ePrc0wKhHUPKSaMw=@vger.kernel.org, AJvYcCXekByQCgsmpyY7Kyy9BHOu3KYmK5oWdUNuVfAXyzGehVp4gxaDtE4BIoOyWJHsV0I63eAvBIQ3jqxp58Jn@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3DprxyNXBWOvQH/6tTaMOWZTaanriOlT1JaHQzH1aYQTp5DaP
	/GWNZhfSk+MkCT/e+QcZUzaB9orfVsdVMy18pOTRngFmhrC+YlPt
X-Gm-Gg: ASbGncsd/j3UDIHUOg2k1TZ+mjYk+vaO1w+eHJE0EytS3xGqHZ6zF4YBbsbC0g0gVvm
	JA3oOtsB41m8+Z/8VO4Ev9wNmWdjslWHUJcdj1BSJFBRSwsfEIk6Y/T66CY9vNNsCyJgyxx8jjZ
	+Te5l+7vHrl123Ne8mYVVMfWFSNHe8vu4/auUCl+5pc99uqvoP06RmzLVpJWRzbzc4z0+Sv4dk2
	FCZm05ZQ5Hx4sMIHX5QGDlXiXhMy2N5XwA92ckV6GZgqRVHttJkQ9t0aKdYmOFioqVvcMgMQrZh
	DLHxjqTp8R7Uwc4=
X-Google-Smtp-Source: AGHT+IHewgZoDXqzwkD/Pf9RNFhJxKN2ex1Jk+M6rDTJ0peO0LGgdlAqipzv9O4selP+o5eu5Tnlug==
X-Received: by 2002:a05:6a20:12c3:b0:1ee:8296:b078 with SMTP id adf61e73a8af0-1ee8cb40d00mr23483247637.25.1739905783780;
        Tue, 18 Feb 2025 11:09:43 -0800 (PST)
Received: from localhost ([216.228.125.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae07fec1f8esm3414096a12.28.2025.02.18.11.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:09:43 -0800 (PST)
Date: Tue, 18 Feb 2025 14:09:41 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.15] sched_ext: idle: Introduce node-aware
 idle cpu kfunc helpers
Message-ID: <Z7Ta9ULl141jcjFF@thinkpad>
References: <20250218180441.63349-1-arighi@nvidia.com>
 <Z7TZIvaxzEDD2u9A@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7TZIvaxzEDD2u9A@slm.duckdns.org>

On Tue, Feb 18, 2025 at 09:01:54AM -1000, Tejun Heo wrote:
> On Tue, Feb 18, 2025 at 07:04:41PM +0100, Andrea Righi wrote:
> > Introduce a new kfunc to retrieve the node associated to a CPU:
> > 
> >  int scx_bpf_cpu_node(s32 cpu)
> > 
> > Add the following kfuncs to provide BPF schedulers direct access to
> > per-node idle cpumasks information:
> > 
> >  const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
> >  const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
> >  s32 scx_bpf_pick_idle_cpu_node(const cpumask_t *cpus_allowed,
> >  				int node, u64 flags)
> >  s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed,
> >  			       int node, u64 flags)
> > 
> > Moreover, trigger an scx error when any of the non-node aware idle CPU
> > kfuncs are used when SCX_OPS_BUILTIN_IDLE_PER_NODE is enabled.
> > 
> > Cc: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> 
> Applied to sched_ext/for-6.15.

I added my review-by in v12. Can you please add it here?

Reviewed-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>

