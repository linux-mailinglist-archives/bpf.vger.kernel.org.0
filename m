Return-Path: <bpf+bounces-64901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3D3B18513
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 17:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68BD11885FA3
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 15:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3641270EA3;
	Fri,  1 Aug 2025 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcNqVNZd"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFB0142E83
	for <bpf@vger.kernel.org>; Fri,  1 Aug 2025 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754062507; cv=none; b=CvIHuZSemn9pemx3eHR9i5j7nWtjzRKQA1dd+gdRqrmggwTwcufNn7s5A0D9nth0u3eUcm+Jt5PEBAb3uYIH5uAWffg2BUnszbIiO6WJveNiOFbctX0OA9iLss+y8ouWHQsdkDEI+bWQpdhS07sOP5Chomey9PNd4Ns3vmLJBL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754062507; c=relaxed/simple;
	bh=3t7pavYnxvZ2zr+sT6EoGPHPeQNdp+X8VdJPWKkQuPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFrgdc1OqAPofb1Jio3eyPmiYE8aMtogo/GEQ6Y9lEFhnjuKa/PdhPoBUiL4qXBybjwuUdEN5QsBHxyjrx8kzvLNpsyaf6MvMFaYsQmmQ7qZFfRJRtoDyIVSpE8j2DpSZl7UhS+4UH2BTgnDirnLdqDCcw/+S4AK9JO4C6aKouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JcNqVNZd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754062505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3t7pavYnxvZ2zr+sT6EoGPHPeQNdp+X8VdJPWKkQuPc=;
	b=JcNqVNZdKFxetraF1bNeUX02HHRYlJx6b+OqglvwkN/Ql5pTRPjN99y3uGNTni0+zV99/V
	vTCIgwIIFAme5epTIMU7PkfUekVBpfWH8mLN/dJFTntFPCyQUnDIrtNhla/ZKZDizyMu9y
	cw+desFsfnKuwyNDLxBdaDcbN0eKTyg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-LPGn3bg7Pc2608GKK0qYjg-1; Fri, 01 Aug 2025 11:35:03 -0400
X-MC-Unique: LPGn3bg7Pc2608GKK0qYjg-1
X-Mimecast-MFC-AGG-ID: LPGn3bg7Pc2608GKK0qYjg_1754062503
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae0d05f1247so143502666b.1
        for <bpf@vger.kernel.org>; Fri, 01 Aug 2025 08:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754062503; x=1754667303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3t7pavYnxvZ2zr+sT6EoGPHPeQNdp+X8VdJPWKkQuPc=;
        b=iApRHwFOsDHRG5XA7h6h7HEBPuBPGX47MAyQ6kcMP9WcaLYQfZfw6PuvEC/njBY6m8
         LkNo73Ke9zKxN+Z8Froaspo1o9zmjmNt3VKvDnBsRY2JiYpfJ9vNsh0qGIhCDgmNHnnL
         0312jywgycezU8qEStofhJksXp5Iy/Diy+iHtLu33alLGBT1RRcbIkd8+U0CQ5i3838g
         BEBnO+dnqXnddq+jNSCWYP8vxyFGAePgTSCL7Sls6JbzQUeOyGIlr3F30XYnmFWlZldv
         d3oDfcb7spKkfLdnsd2eVMzrhY7d6A8BJMlj0KNbW3/apvZ9PTHE+LV5n0W7pPoMLXUR
         tkkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbt8lyDIMEpaUtaUOhDYXHNXVWLPxuXszpWpn2cZEJ5Zpn8clBC43rtlcukjSPD26MaP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4yAfm/FkyhClYNyycdgFK1YcihZGOH54BXlAv3JMrJvk6nE2B
	M2DunV+CseQeRIj6K8SD0tte5kPiTR7Qcq4UON69wNXsMQ36laox4Fn7BQ9jetCMviOcac8msoq
	EbqUS80u7BFjyk3vS5SEVgzOc7Anx06hGHwsAB5k0F42A4sdFGCJaYkNKKckUHbOEwKhwjkBNV+
	gizHu4HbIF2/8/IFgykYGxMalVrYqG
X-Gm-Gg: ASbGncv/VhZLMYYXOljescM2DsUziyK9Gu7aCh8A2Z45vJN/p7H3JcS22rppgyZgGQv
	LcdEfmrM4m0bh2RVm5eTG5nepl3bxVGvKVFW4VT7lPwf51gcmteJedJTAhaMOGEo543eUTf0Kfl
	B4B+7hr/jGEnRIRFl+fpfT3/f+Yp4IikxkpeiAPqOQHIMI+pGwAkY=
X-Received: by 2002:a17:907:9455:b0:ae6:dd93:d7d1 with SMTP id a640c23a62f3a-af94022bd18mr24176566b.56.1754062502686;
        Fri, 01 Aug 2025 08:35:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEffcQ80umUTy89ebwr2s4PAM6/RBBB8AMdwFz4nIXXP4EkDzw5biAznHDWzpfhf0kLY0g1Q4rSu75I/gxLePE=
X-Received: by 2002:a17:907:9455:b0:ae6:dd93:d7d1 with SMTP id
 a640c23a62f3a-af94022bd18mr24173766b.56.1754062502265; Fri, 01 Aug 2025
 08:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801071622.63dc9b78@gandalf.local.home> <CAADnVQLky+R-tfkGaDo-R_-tJ8E3bmWz8Ug7etgTKsCpfXTSKw@mail.gmail.com>
 <20250801110705.373c69b4@gandalf.local.home> <CAADnVQLFLSwrnHKZUtUpwQ1tst71AfYCcbbtK2haxF=R9StpSw@mail.gmail.com>
 <20250801111919.13c0620e@gandalf.local.home> <CAADnVQJnTqXLNT9YWWkpLqjxw7MGMrq_CTT7Dhb__R0uO2-COA@mail.gmail.com>
In-Reply-To: <CAADnVQJnTqXLNT9YWWkpLqjxw7MGMrq_CTT7Dhb__R0uO2-COA@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 1 Aug 2025 17:34:51 +0200
X-Gm-Features: Ac12FXxzpQTuJoSDpFwJ5S798l7k_pWSubckc5Xl8rkjsWL2kupB9MLIkTqSUgE
Message-ID: <CAP4=nvSNeviiHg89L3dB9pGzi4Obf_s=bWJ8v89Q-fsJbuqymQ@mail.gmail.com>
Subject: Re: [PATCH] btf: Simplify BTF logic with use of __free(btf_put)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 1. 8. 2025 v 17:29 odes=C3=ADlatel Alexei Starovoitov
<alexei.starovoitov@gmail.com> napsal:
>
> but __free() is imo garbage. It's essence of what's wrong with C++
>

Here, you at least can read the beginning of the function though, and
see that a free will be done at the end, like Go's defer, right?


