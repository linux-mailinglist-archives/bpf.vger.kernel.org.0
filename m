Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A84114D33D
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2020 23:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgA2WwU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jan 2020 17:52:20 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39194 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgA2WwU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jan 2020 17:52:20 -0500
Received: by mail-pf1-f193.google.com with SMTP id 84so414844pfy.6
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2020 14:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=rvpYjI/n+Bo0mU5X5aWL1boapgW8Fsyz4LQ0wC7oDbQ=;
        b=n2RHgdb3+f83nEM9sD+b0yIES1KwIogAvo/TAb+nfvmSKNp54V8WwMPUTAG2HNrtpB
         h6eCv48w4hhaFx1QQwcveNQtZbpe5APLnU/8YeHhZFWmQLiOCW9wByIHHb+Euv1w5YBJ
         ov3xmud/bSKbu/bmf9P8rCVjO/J2vyqU62idSwmN85zcslsf0wwRCzFmbJwlk4CVxN7p
         RwVC5Z0ILwKIIfG01pPuAdPGxgUfJsqgTgGhMPSpN1kjqHs0gHItSvwB8TZsa1hUOruQ
         vzNWcyHhN3JzOzJr5+DfOrm7d+ya6XemxhKyRTintUmitvj6t1aJ369m4ZFv9v4TA/DF
         wS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=rvpYjI/n+Bo0mU5X5aWL1boapgW8Fsyz4LQ0wC7oDbQ=;
        b=dBMLWFEenwhuDIpeXo8RyyVHDL94VFP17JRKnXG7GwwYF0Y67zKaWGAdGwnOGY2Ses
         eB1dQD5f7Uxwjyi0goWhXsols11TcBmz8SZIyzLbuerrjnn20NmteUu1VOUZym6qINbu
         isgBb7KcCnOIoq4oYZ8mteX5WD6FYOiQ6EBt/HziT9CQqsn8x/JbyEKsfoeefnpzllU7
         hJOQWP7MKOhCffJ5bWhKTAQ5D+aVPOgLWLPxrPPhho7NHQrGCeCNzDSCEFsIxQuNYmHl
         JmeO1Lxi+4fZJhMk6x427UZfmJdcVome8nNb6ju2T/ac16WXKvSE8xrACGL1CLH5qrRi
         C6ew==
X-Gm-Message-State: APjAAAVY2YC04DxFsD1OWH/Po60EQq/uvwrImijAg/GllYdDdxyWmkVX
        ZQApk8N6AIUcOeZePyES1dc=
X-Google-Smtp-Source: APXvYqziD6Eg0TLilj3iVCngd/siqtYY8Vht7T+rfzuSF6NINMQR/Ezpt/2vTaKChwGWbHvbHteEkA==
X-Received: by 2002:a63:f5c:: with SMTP id 28mr1513433pgp.348.1580338339871;
        Wed, 29 Jan 2020 14:52:19 -0800 (PST)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id r62sm3995046pfc.89.2020.01.29.14.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 14:52:19 -0800 (PST)
Date:   Wed, 29 Jan 2020 14:52:10 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Message-ID: <5e320c9a30f64_2a332aadcd1385bc3f@john-XPS-13-9370.notmuch>
In-Reply-To: <99042fc3-0b02-73cb-56cd-fc9a4bfdf3ee@iogearbox.net>
References: <158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370>
 <b26a97e0-6b02-db4b-03b3-58054bcb9b82@iogearbox.net>
 <CAADnVQ+YhgKLkVCsQeBmKWxfuT+4hiHAYte9Xnq8XpC8WedQXQ@mail.gmail.com>
 <99042fc3-0b02-73cb-56cd-fc9a4bfdf3ee@iogearbox.net>
Subject: Re: [bpf PATCH v3] bpf: verifier, do_refine_retval_range may clamp
 umin to 0 incorrectly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann wrote:
> On 1/29/20 8:28 PM, Alexei Starovoitov wrote:
> > On Wed, Jan 29, 2020 at 8:25 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >>>
> >>> Fixes: 849fa50662fbc ("bpf/verifier: refine retval R0 state for bpf_get_stack helper")
> >>> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> >>
> >> Applied, thanks!
> > 
> > Daniel,
> > did you run the selftests before applying?
> > This patch breaks two.
> > We have to find a different fix.
> > 
> > ./test_progs -t get_stack
> > 68: (85) call bpf_get_stack#67
> >   R0=inv(id=0,smax_value=800) R1_w=ctx(id=0,off=0,imm=0)
> > R2_w=map_value(id=0,off=0,ks=4,vs=1600,umax_value=4294967295,var_off=(0x0;
> > 0xffffffff)) R3_w=inv(id=0,umax_value=4294967295,var_off=(0x0;
> > 0xffffffff)) R4_w=inv0 R6=ctx(id=0,off=0,im?
> > R2 unbounded memory access, make sure to bounds check any array access
> > into a map
> 
> Sigh, had it in my wip pre-rebase tree when running tests. I've revert it from the
> tree since this needs to be addressed. Sorry for the trouble.

Thanks I'm looking into it now. Not sure how I missed it on
selftests either older branch or I missed the test somehow. I've
updated toolchain and kernel now so shouldn't happen again.

Thanks,
John
