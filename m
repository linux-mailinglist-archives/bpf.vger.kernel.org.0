Return-Path: <bpf+bounces-13598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C021B7DB8A9
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 12:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA52C1C20AAE
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 11:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDAA1118A;
	Mon, 30 Oct 2023 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="i8lcTjBZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CD411C93
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 11:02:19 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899898E
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 04:02:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-542d3e47fd5so3034372a12.0
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 04:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698663735; x=1699268535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WeWnu1VnXDJdQnD4OwRDixNC5z+Kx5C71UrIBBCdxu0=;
        b=i8lcTjBZYRXJI+n53Pq5QNRmone1bIV7FM0iFvs3pWFndgvSwgpp8wveSoI4dZ9gBm
         827pQ3xGIB4BS0yFWJo5sbbjbFS89Nwqnq99pcdI95fWRBlXz3o++j4kNQnsuC79xJLj
         XhwVLCX93zhWW80YnDRau/lrhwE5mqvvqqseUi1029kmfKAKWSI6L9GqyVF6h8s/smGj
         pn1mp89uPXVhcVpVAjqdaQZpaTRKAkF545E02AV7DzpQqyn8jvfi7hfChblIL1OyqJbv
         3Z01aF25gaLsjzzzBkyAo4sEgkbcRz2ApkTk0R+dGiyk22QWnP9pleyY4QaZtxt1aGoA
         IDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698663735; x=1699268535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeWnu1VnXDJdQnD4OwRDixNC5z+Kx5C71UrIBBCdxu0=;
        b=PCxlyGVHMuJ0RgZFsaK0XxGv3Aerk9J38dolAwZNOeveYSH/DCrak2sbahdlpsyj2i
         KV0QU+tQ2vb1Yb+0SUu7p2geEhj1B5lZm+2zI+oNTEZOl/qam1C1v+v2SwZYE5fvYSWB
         7O993TJOoBwMZjlnLloa5qFSQMoKTWMlo9HL4LWy7619rrNBOclO2I/tG9C+sQzNZo5l
         JVknVgE0ruR+zM2/eBIVb/aTBMGVRJwyvCNSh9G0ttYMc6ymKPPdEdDkIqOoTac1KLks
         olvPvvaoepvoGcfhR09xH094GcaN61haTMhAFxXnyHa3yPEyZy+mt0U79bUJSX7aKtET
         K9tw==
X-Gm-Message-State: AOJu0Ywl02WagN4xueaBCp2nW9rU7gh0dQgBT4pp3NQtEE7ZMIsP4h//
	aEKjaxz8ItOypyy4sF01wHgSAPVxv5PRJOsCMqE=
X-Google-Smtp-Source: AGHT+IH2PvculO5L3/sCFJj9rQfTxZjvyKYLYFKxgVZWZBW11zPbbBu64PdTycEAYJ6SjMkahfCcnA==
X-Received: by 2002:a50:d6d5:0:b0:543:54da:1a37 with SMTP id l21-20020a50d6d5000000b0054354da1a37mr136752edj.6.1698663734935;
        Mon, 30 Oct 2023 04:02:14 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id r27-20020a50d69b000000b00537666d307csm6047409edi.32.2023.10.30.04.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 04:02:14 -0700 (PDT)
Date: Mon, 30 Oct 2023 12:02:13 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: kfunc use newbie question
Message-ID: <ZT+NNS1kgBRdfZnW@nanopsycho>
References: <ZT94/1VlpfA231TX@nanopsycho>
 <ZT+CG0cWnko5AIO8@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZT+CG0cWnko5AIO8@krava>

Mon, Oct 30, 2023 at 11:14:51AM CET, olsajiri@gmail.com wrote:
>On Mon, Oct 30, 2023 at 10:35:59AM +0100, Jiri Pirko wrote:
>> Hi BPF :)
>> 
>> I'm trying to use bpf_dynptr_from_skb() kfunc in my program. I compiled
>> it with having following declaration in the bpf .c file:
>> extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
>>                                struct bpf_dynptr *ptr__uninit) __ksym;
>> 
>> I have all "BPF/BTF" kernel config options on. During load,
>> I'm still getting:
>> 
>> libbpf: failed to find BTF for extern 'bpf_dynptr_from_skb': -3
>
>heya,
>error -3 suggests there's no BTF generated, is there .BTF section
>in the object ? did you compile with -g ?

w/o -g. If I compile with -g, I'm getting this:
libbpf: failed to find valid kernel BTF
libbpf: Error loading vmlinux BTF: -3


>
>jirka
>
>> 
>> I'm pretty much clueless about what may be wrong. Documentation didn't
>> help me either :/
>> 
>> Any idea what I may be doing wrong?
>> 
>> Thanks
>> 
>> Jiri
>> 

