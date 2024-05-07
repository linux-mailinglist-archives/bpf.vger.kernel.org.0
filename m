Return-Path: <bpf+bounces-28906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582748BEA54
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 19:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B5428216C
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 17:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4575184D;
	Tue,  7 May 2024 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ev8/i0mU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB7115ECC6
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715102318; cv=none; b=PuBDTzDEL0WzleEaZx3Puo0mvUt/QD+nzEP/zHcBKD5BeLg10M82RsJYfGeqrmabRPG1G+Obb1j185DWiEJm2y+WhjKSWr43ANnvs5shtQnSL6uJumuCwMy6utY0za6m5VKVo10Qq5VOttx42Z2TZjorJUh4WQXypuNTAwUYVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715102318; c=relaxed/simple;
	bh=tGe+x+UIYfjSPistak0mpL+zWfQIdalZBQ0rhO0asEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebYT63QaO+uXhT5t5Njm5om1H2ETs+JHymDsXmYzv2gI2Pqfr9yyNpOU3zx3uiv+vUORWnaFrOMbwpVX6gBV/e9ZGl3yLhwmvs4KcLiRwRqXON6v5un3Ac+IOL0r5+b28qF83kn7qiOPzkTAZpm0CaJmM2k4Z13l+wL61s2QGys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ev8/i0mU; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ac8c73cf88so2162701eaf.2
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715102316; x=1715707116; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TNXX/YtUwSuS/g2B8MSt52lAQEnAuMRmEUHsjXzWWlk=;
        b=ev8/i0mULaeUcvt0CEWB7bZbTeXxEpUMSGiC3nbp3TcENAFvIstWDRYpjdkmFcMVOt
         UkJ0nwG4K8UtGNMMWopXV5gidEf2FpetrzwYVrvWs/Ewhf2cjzrRu0Xh/N0VGpoqHRzN
         zhP9NSU31q7nXu237hDI897xTIYZeHRaG4NfOsoJKlLcNBfqTHPSEO+xJFXFNPWXkIj9
         nWi6BiVrQilPyGeHx0PfZ8o7uZSFL3dg/FB+yvtcL3gp0ElNyE7fXkSa54ybPEYaWW42
         mL6olw+W/j29+jUQJIJXasp4ZtcQVIaBHvS6ZYu8VaFdE+CnP6WZiJAWEPUMT5fs9PiX
         eX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715102316; x=1715707116;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNXX/YtUwSuS/g2B8MSt52lAQEnAuMRmEUHsjXzWWlk=;
        b=o0yF0T7PB+IQFQYujr9a4IlFVKETQbMuKmhkBeqJ5Y0LHj9OpZAec6/4OmjxHzzpfE
         4CpT7Y7H1WSoubI+WL8MWzhh2ugQYnjGM3Lmx2aSRoLGTRtwzGTjOdh+jj25miyHV0f1
         OQYsB+2AsUMCzld0LkSzxJUFAKVoea85KV6Fo7qRHQPOzC/CgO6glRCP6F74qKiueLi6
         DbgRWGglfkpqlW3Mzr5txXDK7iA9I5DjhRm0xWSDcLkSqVDhGtCzSgi0eEKLPhjLpuPN
         YXzs76uw6OPjElGMaI56wngdWSUwc96tIIk+IDXPPLycRVxad8pghQ8MbfZ5a1HfAEWu
         c9KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk/mL4ONAm254BJK9TWXJwwLeXeKldghJJDR0M8HoRkmkULvB8i/Brkv8X9+CjOI+0swR8+xWy4Vyj8a+PIk5H1hC2
X-Gm-Message-State: AOJu0YwaOEo7EczEcmoa/+HJKJHjmjyH+uF5PmJTHQCJcQJ9/JHVX/wR
	Fd+c40MWqUh3NWvRUhTup0I/NPnIrNnH0uklvQMIPx6A8aqDL+/3
X-Google-Smtp-Source: AGHT+IFRvC5tNyPZo5pRG2N0XNKiyiDgS+fEu87wp5l52I/Lqb+ok2dkgNi5ZwHPdfzLo/DtJTA0jA==
X-Received: by 2002:a05:6358:88c:b0:192:c556:5552 with SMTP id e5c5f4694b2df-192d2c29942mr45614855d.6.1715102315772;
        Tue, 07 May 2024 10:18:35 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:f3e4:f9ee:d229:5b64])
        by smtp.gmail.com with ESMTPSA id h129-20020a636c87000000b005d5445349edsm9818468pgc.19.2024.05.07.10.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 10:18:35 -0700 (PDT)
Date: Tue, 7 May 2024 10:18:34 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Dust Li <dust.li@linux.alibaba.com>
Cc: lsf-pc@lists.linux-foundation.org, bpf <bpf@vger.kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"a.mehrab@bytedance.com" <a.mehrab@bytedance.com>
Subject: Re: [LSF/MM/BPF TOPIC] Inter-VM Shared Memory Communications with
 eBPF
Message-ID: <ZjpiaoJsL1jH7Q+9@pop-os.localdomain>
References: <CAM_iQpXzAYFES62Cbj8PoGqr_OW=R+Y-ac=6s3kmp5373R7RzQ@mail.gmail.com>
 <20240304095947.GB123222@linux.alibaba.com>
 <CAM_iQpXKi3tYb+5O=NRi_C-eGCRYiZgk96=egFaKAPa3KX8joA@mail.gmail.com>
 <20240311095456.GA40084@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240311095456.GA40084@linux.alibaba.com>

On Mon, Mar 11, 2024 at 05:54:56PM +0800, Dust Li wrote:
> On Thu, Mar 07, 2024 at 07:52:52PM -0800, Cong Wang wrote:
> >On Mon, Mar 4, 2024 at 1:59 AM Dust Li <dust.li@linux.alibaba.com> wrote:
> >>
> >> On Fri, Feb 23, 2024 at 03:05:59PM -0800, Cong Wang wrote:
> >>
> >> Hi Cong,
> >>
> >> This is a good topic !
> >> We have proposed another solution to accelerate Inter-VM tcp/ip communication
> >> transparently within the same host based on SMC-D + virtio-ism
> >> https://lists.oasis-open.org/archives/virtio-comment/202212/msg00030.html
> >>
> >> I don't know, can we do better with your proposal ?
> >
> >We knew SMC and it _is_ actually why I have this eBPF based proposal.
> >Sorry for not providing more details here, since I just want to keep
> >this proposal
> >brief and will certain have all the details in our presentation if our
> >proposal gets
> >accepted.
> >
> >The main problem of SMC is it is not fully transparent, LD_PRELOAD could
> >work for most cases but not all. Therefore, I don't think introducing any new
> >socket family is in the right direction at all.
> 
> Actually, this is not really true. We have introduce several ways to solve
> this. The best way I think is to support IPPROTO_SMC[1] in SMC and using the
> same eBPF infrastructure as MPTCP has already contributed[2].
> 
> [1] https://lore.kernel.org/netdev/20231113045758.GB121324@linux.alibaba.com
> [2] https://lore.kernel.org/all/cover.1692147782.git.geliang.tang@suse.com

(Sorry for missing your email.)

I think this is wrong, basically and literally speaking, it is saying
"you want to use a kernel module to replace another kernel module with
eBPF as a trigger". The trigger itself could not function at all without
the actual module which provides the implementation. Nor it works for
kernel sockets, you need to think about NVMe-oF which is a very legitimate
case since it supports both TCP and RDMA.

Unlike SMC, all those eBPF components we need here can be easily used
independently for any other purposes. Neither sockmap nor sockops (not
even ivmshem) is designed for this specific case, we just combine and
reuse them. I hope now you could see how and why flexibilities matter.
We prefer eBPF not because it is cool or new, it is because of this
kind of flexibility.

BTW, its granularity is less ideal than sockops which is per container.

Thanks.

