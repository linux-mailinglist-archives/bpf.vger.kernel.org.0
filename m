Return-Path: <bpf+bounces-31782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A54690345A
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 09:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4971F2A5E8
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 07:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2A9173321;
	Tue, 11 Jun 2024 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlWpwhmo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599F2172BD5;
	Tue, 11 Jun 2024 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092281; cv=none; b=na6yV0dj/VuLVAr/kyZYY34jE50uWQa+bGZfCyLgSrv6qkzQQTyT+lGvlBW8B2As+IBEPrQxwVIQUonGgzJagnw+wOPfIQvlNcC4haIk6jCNN4aeXRUfR3C1CICjHJ6h6NaQWsO2RZEA8QSDcmF5tdCED7Uuthj1hTPSfcpMo1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092281; c=relaxed/simple;
	bh=mnR/TXWNSKYBo1dIPf7CZ8BaFrrRv1WSzGL6q8wujvA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tT7itlz51lwevbVa/37jzAaLxd8PdrDt4OHhNrcLF/CBDeG1i0rdcgS8CddqiNYUWwV71mcFuL6E2NDjVB9+WXVzYzlfI73xjbTrxNEijoA4Y3cgMOCmx30nyqdpz1Fnf92bQRmIgm/dwS88OBDFwL4jh05UUPedbiwO0NXQMY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlWpwhmo; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-704313fa830so1814842b3a.3;
        Tue, 11 Jun 2024 00:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718092279; x=1718697079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B5dpfcWBVzZkrjYUVKPs0kakADGkyRUU122R+dHdta4=;
        b=IlWpwhmod0gj30IHYYxMt5qSI/PM6py1NhMafpZ9/vB1nUiMh/N4y/HeGD/Ohn8p80
         D4o1O8XzGHX7BJBF2Ibp9tT0fyf8JigdtCDx2PHviBlf4GgNuH6jhmOPw4gQLWLllPG6
         tLZWU1KLI4h1K53ah+pxrveAj62jTMbH2DMkBLplW81BynaMqbH5c+kPvhKNQy3FoxFG
         lC84aHOJpOWi/XgZ88Oib0EA2HixCLMOipHT3UwrOzu5abcAI0ZNHODYIV6wU2fO2s8o
         9g/cmQ77WDp8j+8KqwYOB/AjMoGeuvKE3rbDJSMdmw1K+opR8SePW2MTMFKlsQGgG2uX
         T1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718092279; x=1718697079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5dpfcWBVzZkrjYUVKPs0kakADGkyRUU122R+dHdta4=;
        b=FpcVqCn7Qn4fGPfU0rzN7i87+AQMNUAr7+fMx4r52MBYF9KC09vJlUr+w8w1CXZ/aG
         NpbSI8op3vjCsCBOk88WAQVH0MbB4A5V6uxF77/PEh/RPwxNzZGbYQ3sDidDpmzMP98i
         maJefJKQp1PBoL0V2tyeuoEjVDzjMhOLit+Azg5t3mMZiSjMNIWM7T+pKcNYiKH+CDEg
         FXTxw7SOJ/XdjgOLXYFeUJcKESpqwn9UtCKHjkBji4/AbytmuiArIm96aIBpqhBOuq66
         AOBUvC60b9+SePyJya7X5WgIHPd+DNM5bukCFtnhG2xMhbK2v8shkB2s5oHvIJfwGRk9
         TTKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz5KpuEHofqawAEW3jB01BhE5Cqmj4VvUq9vMAqLjYoXKrMGLeOkxdgjASoBzHRsw/5j/xBYfd8RvJ4q8hLuwERThs7r+hRIKJXhrdecem+VBgqJc6GSibEw42eQ==
X-Gm-Message-State: AOJu0YySqWcmXHc9fyx5lSQcbSDYdZkQw0pFkJJIR3w46AlHBt0hcKJM
	6fB5edRcMmNv5XpmgeqnVkrU1VujpNz5dSdolJUcAiybLJsmrKL5
X-Google-Smtp-Source: AGHT+IFLutzyaa3H+suoM7wf8H86WUDxg3mOl4rOpoLaLlOM4GLritf1m4KGdowZsvvO2KGSBj862Q==
X-Received: by 2002:a05:6a00:b81:b0:704:2d64:747 with SMTP id d2e1a72fcca58-7042d64088dmr8377849b3a.7.1718092279428;
        Tue, 11 Jun 2024 00:51:19 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70423f4a849sm5174072b3a.153.2024.06.11.00.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 00:51:18 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Tue, 11 Jun 2024 00:51:16 -0700
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Wielaard <mjw@redhat.com>, Hengqi Chen <hengqi.chen@gmail.com>,
	Mark Wielaard <mark@klomp.org>,
	Ying Huang <ying.huang@oss.cipunited.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: elfutils DWARF problem was: Re: Problem with BTF generation on
 mips64el
Message-ID: <ZmgB9FtYADbF1jn+@kodidev-ubuntu>
References: <ZlkoM6/PSxVcGM6X@kodidev-ubuntu>
 <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com>
 <ZlmrQqQSJyNH7fVF@kodidev-ubuntu>
 <Zln1kZnu2Xxeyngj@x1>
 <Zl2m4RP7BwhZ0J6l@kodidev-ubuntu>
 <Zl3Zp5r9m6X_i_J4@x1>
 <Zl4AHfG6Gg5Htdgc@x1>
 <20240603191833.GD4421@gnu.wildebeest.org>
 <Zl6OTJXw0LH6uWIN@kodidev-ubuntu>
 <Zmfwhn6inA2m1ftm@kodidev-ubuntu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmfwhn6inA2m1ftm@kodidev-ubuntu>

On Mon, Jun 10, 2024 at 11:36:54PM -0700, Tony Ambardar wrote:
> On Mon, Jun 03, 2024 at 08:47:24PM -0700, Tony Ambardar wrote:
> 
> [snip]
> 
> Arnaldo:
> 
> Your stepping through DWARF/reloc diagnostics earlier was helpful. Thanks!
> I reran your tests with the updated elfutils and latest pahole (pre-1.27),
> and then found:
> 
>   - everything that worked before, still works
>   - your observations from "btfdiff vmlinux" and 'struct dma_chan' persist
>   - we now see expected output from "eu-readelf -winfo netdevsim.ko"
> 
> Regarding pahole, DWARF parsing and BTF generation now works:
> (with no more die__process: error messages seen)
> 
>     kodidev:~/linux$ pahole -F dwarf netdevsim.ko |wc -l
>     14504
> 
> but strangely pahole still doesn't read its own generated BTF:
> 
>     kodidev:~/linux$ pahole -F btf netdevsim.ko
>     libbpf: Invalid BTF string section
>     pahole: file 'netdevsim.ko' has no btf type information.

After staring at this I realized that this is split BTF and we needed to
issue "pahole -F btf --btf_base vmlinux netdevsim.ko", which does work.
Unfortunately, the libbpf error message is a bit cryptic; perhaps a future
update could mention "--btf_base"?

>     
> [snip]
> 
> Many thanks everyone for your help,
> Tony
> 
> [1]: https://patchwork.sourceware.org/project/elfutils/list/?series=31601
> [2]: https://patchwork.sourceware.org/project/elfutils/list/?series=34310
> [3]:
> https://github.com/guidosarducci/elfutils/commits/main-fix-mips-support-reloc/

