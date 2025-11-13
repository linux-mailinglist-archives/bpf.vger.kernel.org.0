Return-Path: <bpf+bounces-74437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B06AC59F63
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 21:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A3484E2087
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 20:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9EE31326E;
	Thu, 13 Nov 2025 20:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZWiGAAc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F083E2877F2
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763065432; cv=none; b=jNDhXahN+JI74lIwJ847kmVZzEWyQj+cfleTBk8QaJMDFSNzu79Q2wt6Y2FSxsevS4s+lDI8KKTCit+eu+ikwWrrmtgKDdRmY/VuuN2Qra24qMtCjxDmMA4N2N5lbor8aUgj2yzTMh46aAvpPLENALaKPOkIZ+Pc7ykL2CuI1CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763065432; c=relaxed/simple;
	bh=1vQa73EzE7c16+W4pulKpHQrRgU4+7y9W9WORppn8K4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MoAB5vTvTpzdQrHwUHo+yI87UzcgGQqxbku+9u+3VJmXgxbC0fqWFbOVnXyab7K2lEnzZlLNElm6mBMyybO+GBHwIq7PxAiFYkmksE/V3wFth91QGBKo/JNi5oszKSGPys/dSp1RLRLUhjrHFAm8tPOG46yeuIjGyEZxIC8vPoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZWiGAAc; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso1136618b3a.3
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 12:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763065430; x=1763670230; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rU5LnM79UuU+YlEBTlTGRnareORo2+Hc/rRFWzixC1M=;
        b=CZWiGAAcEj7OSxDhjVbqcSA3b9qCoXR6CHAYQRJSQIhmy4UYqngxtffOOM8OIEuAwR
         7zXt3GfhvKSgRFdZtjycX/nHWiNFBYi8Um8inN0WPXApnqoehRtp2PMwmpcWEwksiLQV
         Dn634PK383kWZG1x3467kGqJ19+QJimqvpGWaq67sBQaOe2EYoGMhWBeEzPkvi5d977b
         B1mxvChmxRsLNC2RDPu0ByuWaaSlA8SoSeN5mFcSXrnlL7fFkxOGG05b1srL31SWuMNM
         20Lv5oVpoBh0GcxdJ25oYMZ+xQjFiUovsj5oHmtb18nDhRVFl9tbUmjgxYfMPfrHF6X4
         GQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763065430; x=1763670230;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rU5LnM79UuU+YlEBTlTGRnareORo2+Hc/rRFWzixC1M=;
        b=ByXpp44ZR74rTMmbCJz8xJOtgIgesi6Vq5w/yBgtI1eNkKuLcPHYMAZ8IgiR8vRgzl
         BUq4U8aezG602gFmjUb5Ldnf9zF1hLOPGB/QENj08+SBYBU1UoBdS+o3QkN43WSuVvAc
         DahivTf8N78UPt6aqqtl9ssTvkiUJz9O/pB6kR0XaX6hdfuy++Czj4faWrtAVN1TTjZO
         cM+6Sipl2GNNi1i/YCUTr41W1rETthOyZYRIs+Q/JldDWCAHLbPUCiLmQTQ45FuB2+87
         QQ6l4jmedQjafGrWW7ROFXx5iPBrHpR0JWVvrOcHivpzx6KzqgNj5VUcN9asDYsTWbxJ
         IMwA==
X-Forwarded-Encrypted: i=1; AJvYcCWanqmugGejC5oLh9EynYDd+Z4fezkND5oAeS7JNIDP049+Pmmlf4crKfxQPW1QX8gTzSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4PujGzkTN3vPhtvm8yX6snjsDSDhNwA0KPn7f+dxyixvkhEnk
	Uo9b7SXiulME1frXwLnx4BDUfu6viQTHPKFj/1k1gsU+cdIyEubvbCJf
X-Gm-Gg: ASbGncuRjHD8cRdJx6/ShDYfJ7imdQCp/bkBhH7qHLlyIM9vvIG3sZ21eXYTEVEA/kD
	7xqfiAkGbsBk2LHfe5o0zJxfR/5ktkq5wFXsdksyFikLlYsWIjsqUnDvVUcszOIGE3DhMUnW5GX
	/zALITbXI2LFoS2fsI6TF5bNQ0OxhJ5Lz+QwieD0t93FS4Aw8WHoefd3bOJnr2BH++GuACCyco6
	vy0/YU+05ZCkNLbEKXgWIhV3ma0yrT02NzNMIrUtZe4QvI/6cP7HZUDKn/c0iKa+ZX3aSriuMah
	1SirTQgze6ebpTHzV4O2IUGExMbuEvz7Zco8c3z+lbKW4ZxxbSda9yLa0Q0xcfr9qExPxH3CwJS
	U/6KEGGggHn8PWtUS5gBe+Dqt+abotOfN2+Wh3KIfJp4MHQVIiOB9W/i53HG4SHVY0Dok39Id4b
	AM6qgGELuH
X-Google-Smtp-Source: AGHT+IHA0Cqi3BtvgZ4A5D/OWLtsAoH22cOGbRRwl3o3enq3btlGo/59DrzsosXC3lSc9F8u/pSepw==
X-Received: by 2002:aa7:8046:0:b0:7b8:10b9:9bec with SMTP id d2e1a72fcca58-7ba3c080d10mr551290b3a.19.1763065430129;
        Thu, 13 Nov 2025 12:23:50 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d195fsm3094568b3a.18.2025.11.13.12.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 12:23:49 -0800 (PST)
Message-ID: <1faf09abc5a468a025ba784430cf697bd125f74d.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Fix failure paths in
 send_signal test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Date: Thu, 13 Nov 2025 12:23:47 -0800
In-Reply-To: <20251113171153.2583-1-alexei.starovoitov@gmail.com>
References: <20251113171153.2583-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-13 at 09:11 -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> When test_send_signal_kern__open_and_load() fails parent closes the
> pipe which cases ASSERT_EQ(read(pipe_p2c...)) to fail, but child
> continues and enters infinite loop, while parent is stuck in wait(NULL).
> Other error paths have similar issue, so kill the child before waiting on=
 it.
>
> The bug was discovered while compiling all of selftests with -O1 instead =
of -O2
> which caused progs/test_send_signal_kern.c to fail to load.
>
> Fixes: ab8b7f0cb358 ("tools/bpf: Add self tests for bpf_send_signal_threa=
d()")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

From the same test:

                 /* wait a little for signal handler */
                 for (int i =3D 0; i < 1000000000 && !sigusr1_received; i++=
) {
                         j /=3D i + j + 1;
                         if (remote)
                                 sleep(seconds: 1);
                         else
                                 if (!attr)
                                         /* trigger the nanosleep tracepoin=
t program. */
                                         usleep(useconds: 1);
                 }

Constants are probably a bit too high: from 10**3 to 10**9 seconds.

