Return-Path: <bpf+bounces-47458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EE89F9937
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913621890C90
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 18:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F66622A1FA;
	Fri, 20 Dec 2024 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXB/5nvU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774E922A1D5;
	Fri, 20 Dec 2024 17:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734717091; cv=none; b=dhjPsvNWuVAnQ/N6e2HJjcCLp4Euvc34Dx7uB0w2bzpWqhC22fLdFAJVACJEK6ba9oKeGYs5DA1dp53mvpbbZx8vIM7s2EdFfHgx2IY+xWQ612KLc37x2pKDJr+qHNO13/RTrklDIjtgNMltSIUw2tP73/QXPZ8QemfEHo8sG0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734717091; c=relaxed/simple;
	bh=G3Dcv5kXUa9cHfOn+qLnQS0QmYMPszCsMH3p4VhBSEU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ld7ihRsl7FbDX1w8VTM4TkZ3UIwTlWJVf4dYDkTs4gRvr0E5OMtMZ6pks2wUH/hrAtUI9Qkw/eBQKhwkNHh5d2NVlL6s47+dxCL3i3hmwJ/mVp283SBIgMAn2Knf8Sgzcjz1pxvzwO4Wf2eHcecttoOwqScRyo+FtNEZFjywAcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXB/5nvU; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725ed193c9eso2091996b3a.1;
        Fri, 20 Dec 2024 09:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734717090; x=1735321890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68m2V1Lyf3TW9YMWZ2b+k97sw1EJgMttv425t2usl/k=;
        b=aXB/5nvU6XHcJgwpyaMdXqjFk6/xVdPdUQhi+OY+Qp/Q0tHd1nuL9/saojIaNcOY+8
         MODm+T6br0eDgtHEtntS0uFLaTQp/LfuW3biJThgUl9U2GSLisUluMmdrDLGkkqnSfMz
         KslRDHMaiXTGThDrWfbrHLSaJIiIEjgJEz0H9UTbeH4fSsKXoZOgndSOx07Oo7e8Dg79
         AGkzDT0kQWmT95gLDl7MtHIRuU63v8Z5IRV3wqhtbZsw2UBCQDXKY/6Og3IAuNlXJif5
         lf89OyWfIybWPFjTIJKl1J3BF/gKL8xAuizl1cY02OnnqGUScSOoeSxuaL36ISd9g1P/
         E+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734717090; x=1735321890;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=68m2V1Lyf3TW9YMWZ2b+k97sw1EJgMttv425t2usl/k=;
        b=VHjTjB0KQahu/w+P9jyqO/InZCYAUMf2xcxnt0AcJNPLWBhUmtKEcOv2xVV9PyPXZu
         WNaTJjrOQCihx/Ufw9QfunUfIsm1yYX/0xebQrYfC3+WsaYIFTJr5oHGYyKPBYm8dVx/
         VV8Ox8b3hggZxXdwPyrVcWiJs/0MBeW9Mlkvu0yo7FdnNj9wHvp3lYBSjobAmBB8Mqb7
         /AyN1vOOVd1/Y2YA3QRr8Wef/lacff2V9U+CsXO5m3j3bDTl62Ffbvcj1SBnm7IqsIg5
         5qvEX/zl6Scs2TGrgKtOeX0XTKovhTvmpFH1TFFHVWABM03ruPOhwdva9SuQFUBLx/S8
         ruvw==
X-Forwarded-Encrypted: i=1; AJvYcCWgC4Gx4WbY1zLd+S8vv4pv54eGezN0SlQLByMAnMo5uh+YV5MElm45C3KrW2qsxlKFedp6LGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWzRVlclMNats6UZaeylGaixymEvalLwNGLNyThRjXY+O2mfO1
	gTQHTa40Da3oqDpp6Q/59m5ibR22XXNIx+ehRgnDGn6+yGnn2qZ8EQSxdA==
X-Gm-Gg: ASbGncsyxf4YueeoCm422c16/C1HCo1ZnkRjOnS6E1J2fUEs3wBsJ/sCZMYvZW2UwBS
	Fj8XHvwMpTgx1LIMBkBhvlCxjHEEM51nSZzkxofQtzzW3daz7y3ft+IY0pi6X4Gm5hFoSY80lut
	sb1wZekDeWrE9fp8g2CDGmDnrKDDAZ8uc/4wfAip70R/MuAdiU1eA0yqGZk1DD4W2QbIqBtwDnT
	qtsJlvVBO7MEvDuGI8thVMfCOesBTp0RIMQB9Rih17huYA+0u3YutU=
X-Google-Smtp-Source: AGHT+IFy0EltL/dutMq9XQO23HR5oIQnqz/laJ9qwqdJ7+phnJf2h6CZSvbnN4yk0n50T4FgneEK1w==
X-Received: by 2002:a05:6a21:6da4:b0:1e0:d4f4:5b2f with SMTP id adf61e73a8af0-1e5e07ffb0dmr7660932637.32.1734717089728;
        Fri, 20 Dec 2024 09:51:29 -0800 (PST)
Received: from localhost ([98.97.44.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fd58asm3482058b3a.145.2024.12.20.09.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 09:51:29 -0800 (PST)
Date: Fri, 20 Dec 2024 09:51:28 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>, 
 netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, 
 Cong Wang <cong.wang@bytedance.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6765aea049149_21de2208b@john.notmuch>
In-Reply-To: <20241213034057.246437-2-xiyou.wangcong@gmail.com>
References: <20241213034057.246437-1-xiyou.wangcong@gmail.com>
 <20241213034057.246437-2-xiyou.wangcong@gmail.com>
Subject: RE: [Patch bpf v3 1/4] bpf: Check negative offsets in
 __bpf_skb_min_len()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> skb_network_offset() and skb_transport_offset() can be negative when
> they are called after we pull the transport header, for example, when
> we use eBPF sockmap at the point of ->sk_data_ready().
> 
> __bpf_skb_min_len() uses an unsigned int to get these offsets, this
> leads to a very large number which then causes bpf_skb_change_tail()
> failed unexpectedly.
> 
> Fix this by using a signed int to get these offsets and ensure the
> minimum is at least zero.
> 
> Fixes: 5293efe62df8 ("bpf: add bpf_skb_change_tail helper")
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

