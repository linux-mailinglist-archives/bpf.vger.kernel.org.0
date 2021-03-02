Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A0B32B35F
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352464AbhCCDvN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381489AbhCBVKm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 16:10:42 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AF3C0698DE
        for <bpf@vger.kernel.org>; Tue,  2 Mar 2021 13:02:59 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id g4so14747842pgj.0
        for <bpf@vger.kernel.org>; Tue, 02 Mar 2021 13:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=CB9dY4Lo/FVVsXfU2ohXWUZuVD42ULjyGl9o+tMY6Y8=;
        b=kEn/jTaFtVpFmfCrT7bL4yxMKEL+7/DDc3lsEo5QR+j1n1aCc8f0qujpo0FciT082V
         cmrgOfKTnFLcR9EFh9f0nrroavyJTTeufrRwJidYhJRhmEpKuV78c4BdGQPbXBSC5eK4
         Y5RDspp1l2iVsMqFgSUW7tjeTU0ldBS1jRmNgi1e/PfVqXmMqr+gxEjIGYwukVqTkwEX
         C+2R6FhS9KFt4p/FRw1GL2lgjAdauN/ww9vSNVVgN6/MReGuo0HKLQMeYSyVm6upjzw1
         RiLpJxexbc3CbRSRTU9sAjYah8W3YHb9iheXKfYij/OUvu887kndLu+gFVqv8ljjM/WR
         R07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=CB9dY4Lo/FVVsXfU2ohXWUZuVD42ULjyGl9o+tMY6Y8=;
        b=a49Ny9h6FN7nZmyX/gQNnbkrgAhiSBKxNMi2it8LtWG6poK7sNzMZ14oaU8WkvGoTH
         +5Es2eQBAfsxWWffSSyKXzGlDvfw7LkO9xthH8E0xpYrVo8OcmkPT50hx9+z6HZwaiP5
         t3A4HDd5q2MLP1NWIjAklm1trF867q/KwcI976Wj1R2SPKC56mbbYZmGEiqL+oxNS+pH
         ZHzwdYd4EDP7jj1N8nE/8EWEj2d0HJDgqvoMDuUzIPush+mf9gngzcRsUaBt68J353q6
         EyA7i8xS0BzklITWIVa3RhSLAKfx5cXBRZiJpvXu59NMCTxXv9brv9HmpXUxgqo7/3Wx
         29yg==
X-Gm-Message-State: AOAM530Jx7+wm4wYmW0gfk6Xjk74zsLUfFqHAlFw7s6tePSPcOXdEcGZ
        JZ4fyG8Vou2tCO3AM81LbgcsDA==
X-Google-Smtp-Source: ABdhPJygZuY9KaqkU4K9gLXIZ9wSlUe7qlBkMj13Bu2eXTZp5/3vDnvFlNMTXcuIUbq2VLW6J4hP5w==
X-Received: by 2002:a63:fb11:: with SMTP id o17mr19763253pgh.282.1614718979407;
        Tue, 02 Mar 2021 13:02:59 -0800 (PST)
Received: from ?IPv6:2600:1010:b02b:fd90:e1d3:88b3:9a99:4873? ([2600:1010:b02b:fd90:e1d3:88b3:9a99:4873])
        by smtp.gmail.com with ESMTPSA id c29sm20427129pgb.58.2021.03.02.13.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 13:02:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: Why do kprobes and uprobes singlestep?
Date:   Tue, 2 Mar 2021 13:02:57 -0800
Message-Id: <EECBE373-7CA1-4ED8-9F03-406BBED607FD@amacapital.net>
References: <CAADnVQ+czV6u4CM-A+o5U+WhApkocunZXiCMJBB_Zbs0mvNSwQ@mail.gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>, bpf <bpf@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <CAADnVQ+czV6u4CM-A+o5U+WhApkocunZXiCMJBB_Zbs0mvNSwQ@mail.gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Mar 2, 2021, at 12:24 PM, Alexei Starovoitov <alexei.starovoitov@gmail.=
com> wrote:
>=20
> =EF=BB=BFOn Tue, Mar 2, 2021 at 10:38 AM Andy Lutomirski <luto@kernel.org>=
 wrote:
>>=20
>> Is there something like a uprobe test suite?  How maintained /
>> actively used is uprobe?
>=20
> uprobe+bpf is heavily used in production.
> selftests/bpf has only one test for it though.
>=20
> Why are you asking?

Because the integration with the x86 entry code is a mess, and I want to kno=
w whether to mark it BROKEN or how to make sure the any cleanups actually wo=
rk.=
