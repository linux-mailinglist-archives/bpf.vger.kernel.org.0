Return-Path: <bpf+bounces-45900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BDA9DEDE3
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 01:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22327B21E32
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 00:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984783B796;
	Sat, 30 Nov 2024 00:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG5/8gWe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3C228EA;
	Sat, 30 Nov 2024 00:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732927413; cv=none; b=J1JatFVz3a+j7Cen0Lt2B2w+vEeCjTfrZEuX2ir+NCytncO7A6xqkCm1+P0aWFIyzZEoopflKDT0rTuEFV5FerKrEvlYG//uNSpFyC58AJobq5+B6qE1d3SpTEslHNMZeNq8c5pqsGRFGfQiWrHkerVJlfzgSA4qbBAMaTUA0uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732927413; c=relaxed/simple;
	bh=KuRo4uCbWKz+FqYQncpemBAEXoi2K2b0kXIOuq1XSNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ew9fRgiZAfG/O86m041ofTM1qHIbPe7zueFbtEO/3E+C2s69UlZmlmlTj/GHatZZUdCpyQMlPSpbP1HeJcMX9Gc/+ddKDsV8UOWezMxKVOpcrbSNWDZ/Va8nXJGXrnWBjCHiL11t9hrg5FlhA4Cyhai7JGipdEnFePZkNnTIals=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GG5/8gWe; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2155157c58cso4753835ad.0;
        Fri, 29 Nov 2024 16:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732927411; x=1733532211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=csgRMHYFsJTvCVxa5kFhLp6akKuS7lLHkAJW6CKOQI0=;
        b=GG5/8gWevn9q9DCMM5KuaIfudwZ32G0hQ1/eg3WsHzAyEDwakPlS4yGwgaURKrLqtp
         xGIX2tWIBhDnxjZC6r6W/0HyS1RunKl2U7Gy9Eh/c8BwPZeu8eFfjQh584Mkcbv1t4jS
         MBl97Db8KsZZZd6lxH3OLNhvIIPhiQC3uIaUcLBlgKBuF3lsHrb2v5uZLkxfYsJnOPWs
         yuvvBU+95f0i8tzf+VGuYBqtZIAAAQfYFCjZxnjBpL6IrPa0KK7hVVwqJGGSkt99d2fj
         jUNLEyUaGjGZoWadjracI/18VuTTq4xrxFURKWfWKSlr1F6Ol4SvZ1RU2aJxtrV2oHbX
         DB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732927411; x=1733532211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csgRMHYFsJTvCVxa5kFhLp6akKuS7lLHkAJW6CKOQI0=;
        b=MEwlNPB71MppkN5+9cYjxlmelAQoRx5XnqynScYkf4xRf/EL7r6vyQTlKOjFHDdk3i
         g8TXSilkBKPe9ZKfRm2e+lcuRus1ossj6OqoJzmLMwh+dH1WY3CffeP4dYcIyaG/Vuwg
         ni2z7c+5Kul6iJkUPq+/R4UfOLA3neCzqifpABEbi4SoddSueJX3uM44LkHkMQq+D3lY
         PTpi4DXm9IYS8Ed0/ov+fDARLljxfSRA9AeHMdTjPq9JreclISuSjFsrXmsZst/+8vbY
         IHfsMnC2rM4GTfGddihViI2X+tUQ3Dz0U1jbzR3tvFO6VwiJxYY/IoG+cDtKK9881Pux
         93qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhTyI6B7Z1Syz4Epx+ilkn98N9bsPyz17yjJWm9wis1Pfkz2g4Ezikd5Ti680qe5YSmIX6HGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwmybKBSxbAyTVKiOYweeFVVysYzPm41JP0NNPqmOu3LkZXhBT
	9YahqWSJDgvCJG4R9m57zUprEA8GmqSAC5zr89YmVLEoWmGFmUw0
X-Gm-Gg: ASbGnctu8MMzOvhxQDzZQ7iD/NHxiVVq4QMNk1/VsmvAM5WcquDmpWK11+BUX4zJ0Cg
	oJ1gqQw9JKX0W3CjwKcx1nlZqfkCBxBXbwz6AFE7y/1PCubyymY+K80q8eyJv9wcn9AMACS/UYS
	YOH933a1k5Xep19OiGy4XrOJrbnncMdgiKOCc6BUSSc1Mf4mmBPpt0prYd3AP+nEBtGrpLSYkIg
	VlsVK/G/oN1xte4kq2EbqSE0FV/K5ZmBnjTxC0gTcPaAWMoYTEqVsxW
X-Google-Smtp-Source: AGHT+IGzLM51VCB9JAOMQCXu5eLjeIT5mzuFUlXm1DhA/gitN8lpuED5VPyZTOh1DhJ9NdBuLVL3Kg==
X-Received: by 2002:a17:902:f604:b0:215:5ea2:6543 with SMTP id d9443c01a7336-2155ea26658mr7277605ad.28.1732927411230;
        Fri, 29 Nov 2024 16:43:31 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:22e0:3259:eab0:7dee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521989750sm35776205ad.202.2024.11.29.16.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 16:43:30 -0800 (PST)
Date: Fri, 29 Nov 2024 16:43:29 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, bjorn@kernel.org, jordyzomer@google.com,
	security@kernel.org
Subject: Re: [PATCH v2 bpf 0/2] bpf: fix OOB accesses in map_delete_elem
 callbacks
Message-ID: <Z0pfsWqRoxaTTC2t@pop-os.localdomain>
References: <20241122121030.716788-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122121030.716788-1-maciej.fijalkowski@intel.com>

On Fri, Nov 22, 2024 at 01:10:28PM +0100, Maciej Fijalkowski wrote:
> v1->v2:
> - CC stable and collect tags from Toke & John
> 
> Hi,
> 
> Jordy reported that for big enough XSKMAPs and DEVMAPs, when deleting
> elements, OOB writes occur.
> 
> Reproducer below:
> 

Please consider adding it to tools/testing/selftests/bpf/, since it is
pretty small and self-contained. (A follow up patch is definitely
welcome.)

Thanks.

