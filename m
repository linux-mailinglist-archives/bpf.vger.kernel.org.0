Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 259A6119282
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2019 21:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfLJUzB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Dec 2019 15:55:01 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44845 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJUzB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Dec 2019 15:55:01 -0500
Received: by mail-pl1-f194.google.com with SMTP id bh2so331370plb.11
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2019 12:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=FpkeMzqnudfYJAR1RJofkj4BLPvaslMP35EJSzmn390=;
        b=1Au0MGXkVSUuxQvKGjX2QkJmMnQzvtWo175oDow9jBax5iLRsxER/XgVeIz8GjlHEA
         gi0F+wjGY1vbEMx28UNnLvZxuSAVKih8DLhmk2bxC6dwqBtHPrao+SgexMUTNjl5kx2q
         Re46tM8Rt90lnNFjFMkFRQgCwFogqvQKCJd7pK3bIvg6Mn9uqvAAjtSN6wGJvzdN5afp
         4IsOzKD8lWB49o+jzEkMha2Q8dE6G/N9Oq5qgNuKmaIFqhDeR/3TV5q6n2r0+OON03/O
         ua1G2Z5AEAsFUwvg/8m4KGHFN7gMXNiUU03gcdH1rWyUztxbA2OihX2ck6WCTtDxGFoN
         oRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=FpkeMzqnudfYJAR1RJofkj4BLPvaslMP35EJSzmn390=;
        b=GD2J22esEB6NjF2Ufptji6/Tu6f6xJTRXg6iqEX7jtoKbxgfCoj7umdOp4vRN79+Pk
         JVgxvNvu5BlWX6sgv5uNc1C7HpmRGbHhs4L0Jnt4cONXkaCNx8F1LA/K3IC5zo5GjKoc
         wSg6PBY7Quw6gdiJX1NzuBpJr87kubRtpQPBPdRDjCwAiGlKYxt7fHkJYxAUzoQW4lNg
         RBPN/xnbq2RRiJNyaMf77dPJnNCoE5RXSBvPw+BvorpbTIGsoHk8SsBQoB14vp3T0NjQ
         Ru6wY83DXmTDIOaBwDUwORWPtkWDbO2I0eEVbxYUoG9X0riiaHPxMQgTj68LLt/2cDfz
         kyxw==
X-Gm-Message-State: APjAAAU85HFOTStYLZE+a3M9eptu146qFPRBZqExIM/HvPir5gR9JwZM
        2MDM28YcBJePg5gU63dJfpOMRoTqD9s=
X-Google-Smtp-Source: APXvYqxDk2oXKvAMNL8xSIqUf4XZA+vWC8wwKrnzFOMPi/iiA0pCEtvsCLVSgJQqNC79q06wt/lYDQ==
X-Received: by 2002:a17:90a:a881:: with SMTP id h1mr7581457pjq.50.1576011300561;
        Tue, 10 Dec 2019 12:55:00 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 199sm4651176pfv.81.2019.12.10.12.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:55:00 -0800 (PST)
Date:   Tue, 10 Dec 2019 12:54:57 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin Lau <kafai@fb.com>
Subject: Re: [PATCH bpf v2] bpftool: Don't crash on missing jited insns or
 ksyms
Message-ID: <20191210125457.13f7821a@cakuba.netronome.com>
In-Reply-To: <20191210181412.151226-1-toke@redhat.com>
References: <20191210181412.151226-1-toke@redhat.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 10 Dec 2019 19:14:12 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> When the kptr_restrict sysctl is set, the kernel can fail to return
> jited_ksyms or jited_prog_insns, but still have positive values in
> nr_jited_ksyms and jited_prog_len. This causes bpftool to crash when tryi=
ng
> to dump the program because it only checks the len fields not the actual
> pointers to the instructions and ksyms.
>=20
> Fix this by adding the missing checks.
>=20
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")

and

Fixes: f84192ee00b7 ("tools: bpftool: resolve calls without using imm field=
")

?
