Return-Path: <bpf+bounces-23201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8120386EB82
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 22:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD111C215C3
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 21:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8859058ACF;
	Fri,  1 Mar 2024 21:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="yMTQghxc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Zxf9V0eS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PTid69JO"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B55E58ACB
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709330147; cv=none; b=t4KQQp6Hmhb+nRuCAZ4t2PMS2Jmvpj8dl69yWCDRIYkPHo/hTByS4WygHspq5Z6uxrLxSAcufEgyycbvmrZO4wZUGtuNiwGMAoA1R+7sq1P/rcJUmF/rinNqvKxcO9FSgazjJw9iO0gqy162VSdFD9qvQt5TY95VfRSLaJM0P6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709330147; c=relaxed/simple;
	bh=rlSmeP/ACjGjNUOSq9x371ePdLdGMuBWVVvSBmWXbKE=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=g1JCt2Qf3JZB+k2blQNb6Xmoz0QgtAaQqYqTpK027OI6ZTs2cEAvdc+WRcztRM/rDsUQ8aQhHAHAbiHCp4SMtyK9i3DYMvHXs347PoNYcbTCkMFL/bpvWBnYD1+ADSGn6Z7DP4qkIm6su1eQn8EyQ+UzhqUtU05W9sLnla1B6ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=yMTQghxc; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=Zxf9V0eS reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=PTid69JO reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id BB3FEC14F70B
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 13:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1709330144; bh=rlSmeP/ACjGjNUOSq9x371ePdLdGMuBWVVvSBmWXbKE=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yMTQghxc27pIO28BsAG4v0nc02muU6w5Op0MhdCeyw1+Toa4MtEHd8IDbJXb26BsD
	 WaQaC40ObhxO6kE+E+QPImrKI4t5bJeBXT72weHIutFU2/LuTqk7QM9Uc728MY0hej
	 RIFu2FGmHo76JUjPi8Sf1b20peZD2hP9DPpAS0Xw=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 88648C14F616;
 Fri,  1 Mar 2024 13:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1709330144; bh=rlSmeP/ACjGjNUOSq9x371ePdLdGMuBWVVvSBmWXbKE=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=Zxf9V0eS7Z57Q/40ybUv0qRW9XSfkX8vj0DN42+Qm3nBvZJBMEvs2tRUjZ3BCxl0Z
 0T8ND0qfmp0tCvUj8bPrUrtNSZwUrJrzM3cJEJgFojgUc3XZGUi+6uyOnRZDoIPV81
 1GGmsROsRaVfdu2DyyRhJJlMj66ZWzhjIk54JyQg=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 77E79C14F5F2
 for <bpf@ietfa.amsl.com>; Fri,  1 Mar 2024 13:55:43 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.854
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LyOktKOuq0zv for <bpf@ietfa.amsl.com>;
 Fri,  1 Mar 2024 13:55:39 -0800 (PST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 95F36C14F6F3
 for <bpf@ietf.org>; Fri,  1 Mar 2024 13:55:39 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2998950e951so1828429a91.2
 for <bpf@ietf.org>; Fri, 01 Mar 2024 13:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1709330139; x=1709934939; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=lmSXi4D7sPEpSkeVvMobsfBRWK3fOq6/QBi0rLCDoPY=;
 b=PTid69JOIq8FN3NWshiiRWA+9l0G6SkKmptkQDhZ4HcOZPlHR6yp4iDiEnJdwREvUj
 5084DlJcwsX3dNKeGsi43gR5DvohvVkeISQCRT/HFspXAmXv9aAUKM6fr9IzglQ6Xt7f
 LYpqJ+pHI4WPWAiq0qcM2aqeq4x+nCy2xtzoaT8QSnq4yMxafMNR200hc5SPzuZ/FsCB
 i3UwJ3spIVUU7ph80TLHU5ZnSv21wk7cz8u3jgU4dy9sSnD3XsOF99zzlIxeRQEs9orK
 pcH+mVbHYLEEK5REUMB1gXvJIJtoXz5TyToTU81wRLmWKS6tnDFnnWq6DabfTdmFhgA/
 pCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709330139; x=1709934939;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lmSXi4D7sPEpSkeVvMobsfBRWK3fOq6/QBi0rLCDoPY=;
 b=EXTUbhkENUIvEvK283GlSNH10tP4R5YVubr6ECAI/fTaJtoRctK6lFJutZXjsOZ+VC
 c8hF9rwkuzBekBeToxLI0S8kny7N+aixtXKZueXY4WuELw4qojPjRE8swKrt8pwG9LIw
 0h0nKxV8sZ4ccNke6UWZ89iV7QVgM/2gTDXrb3rTdUJhyBiqGgvEzuM2f32soTsm3cGH
 dAkm4QOx7FlJlfXVK5AdP19ktuKy+GkMRkmyacaCB3sRT66XnuV9Zrhf7hHUpN5Mi/v7
 hdRkmQkLgii1OdLrkK0nt+2HdW33YJ1CIlx4mkBGl/16tTUu3WEq+P1OZPrTVYsa/2t9
 qDGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyzTvxFjeKuw/O9yBKuA0CAVwlsWEg63E6T29rtmsZpiMEiU7PJOOs1/4JAwe3g3nGk3zC46uad73cBAM=
X-Gm-Message-State: AOJu0YyuW0DiSrxthOBBK3eb5rEtggSCdZ/It7HwYAKmnFTGzOA69IG+
 RWf4LTfvDUC/+N1GhU9kEV/o+DsBwJw0pacbCZULnflfE6Y0lI6udQXfiiIJdgM=
X-Google-Smtp-Source: AGHT+IFh5xJfNmB8rOn/crUe562ehXXzA6BVOg/iySAQp01mZAIomO+zl4Ed1JCBldmZ+KHg/UreLA==
X-Received: by 2002:a17:90a:ae05:b0:29a:b13a:2455 with SMTP id
 t5-20020a17090aae0500b0029ab13a2455mr2670928pjq.30.1709330138396; 
 Fri, 01 Mar 2024 13:55:38 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 v20-20020a17090ac91400b0029abb8b1265sm3695578pjt.49.2024.03.01.13.55.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Mar 2024 13:55:37 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>
Cc: <bpf@vger.kernel.org>,
	<bpf@ietf.org>
References: <20240301192020.15644-1-dthaler1968@gmail.com>
 <20240301214929.GB192865@maniforge>
In-Reply-To: <20240301214929.GB192865@maniforge>
Date: Fri, 1 Mar 2024 13:55:34 -0800
Message-ID: <236501da6c23$30b03380$92109a80$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH/ehTCFBulKRgYvS4cKeKGZS5OpwHpwZEgsMoC04A=
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/zoDjQj_mLxEMNsaEM9aONS-rL4g>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Use IETF format for field definitions in instruction-set.rst
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

David Vernet <void@manifault.com> wrote:
[...] 
> Very glad that we were able to do this before sending to WG last call.
Thank
> you, Dave. I left a couple of comments below but here's my AB:
> 
> Acked-by: David Vernet <void@manifault.com>
[...]
> > -``BPF_ADD | BPF_X | BPF_ALU`` means::
> > +``{ADD, X, ALU}``, where 'code'=``ADD``, 'source'=``X``, and
'class'=``ALU``,
> means::
> 
> For some reason ``ADD``, ``X`` and ``ALU`` aren't rendering correctly when
> built with sphinx. It looks like we need to do this:
[...] 
> -``{ADD, X, ALU}``, where 'code'=``ADD``, 'source'=``X``, and
'class'=``ALU``,
> means::
> +``{ADD, X, ALU}``, where 'code' = ``ADD``, 'source' = ``X``, and 'class'
=
> ``ALU``, means::

Ack.  Do you want me to submit a v2 now with that change or hold off for a
bit?
Keep in mind the deadline for submitting a draft before the meeting is
end-of-day Monday.

[...]
> > -``BPF_XOR | BPF_K | BPF_ALU64`` means::
> > +``{XOR, K, ALU64}`` means::
> 
> I do certainly personally prefer the notation that was there before, but
if this
> more closely matches IETF norms then LGTM.

The notation before assumed the values were full byte values so you could OR
them together.  When they're not full byte values (and they're not in IETF
convention), OR'ing makes no sense.

The proposed {} notation matches the C struct initialization convention as a
precedent.

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

